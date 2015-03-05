// ospfsfixer.c
// This file is responsible for analyzing the filsystem and fixing it.
// This should be the only file we use for filesystem analysis and fixing.
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "ospfsfixer.h"

// This file holds the data for the filesystem.
file_system_t fs;

// These functions analyze the ospfs.

int fix_file_system(){

}

static int checks_superblock(){

	CHECK("superblock");

	int retval = FS_OK;

	//Check size of FS, if space for superblock
	if (buffer_size < 2 * OSPFS_BLKSIZE){
		UNFIXABLE("Not enough space for superblock");
		return FS_BROKEN;
	}

	ospfs_super_t *super = (ospfs_super_t *) block_pointer(1);

	//Check the magic number
	fs.super.os_magic = OSPFS_MAGIC;
	if (super->os_magic != OSPFS_MAGIC){
		retval = FS_FIXED;
		FIXED("Incorrect magic number");
	}

	//Check number of blocks in image
	fs.super.os_nblocks = fs.buffer_size / OSPFS_BLKSIZE;
	if (fs.buffer_size != super->os_nblocks * OSPFS_BLKSIZE){
		retval = FS_FIXED;
		FIXED("Incorrect number of blocks");
	}

	//Check number of bitmap blocks and first inode block
	uint32_t num_bitmap_blocks;
	uint32_t num_bitmap_bytes = fs.super.os_nblocks / 8;
	uint32_t block_mod = num_bitmap_bytes * OSPFS_BLKSIZE;
	if (block_mod != 0){
		num_bitmap_bytes -= block_mod;
		num_bitmap_bytes += OSPFS_BLKSIZE;
	}
	num_bitmap_blocks = num_bitmap_bytes / OSPFS_BLKSIZE;
	fs.num.num_bitmap_blocks = num_bitmap_bytes;
	fs.super.os_firstinob = OSPFS_FREEMAP_BLK + num_bitmap_blocks;
	if (fs.super.os_firstinob != super->os_firstinob){
		retval = FS_FIXED;
		FIXED("Incorrect first inode");
	}

	//Number of inodes
	uint32_t num_inodes = OSPFS_BLKINODES * (fs.super.os_nblocks - fs.super.os_firstinob - 1);
	if (num_inodes < super->os_ninodes){
		UNFIXABLE("Too many inodes");
		return FS_BROKEN;
	} else
		fs.super.os_ninodes = super->os_ninodes;

	printf("Passed all superblock tests\n");
	return retval;
}

static int checks_inodes(){
	int retval = FS_OK;
	uint32_t ino_no;

	CHECK("inodes");

	fs.inodes = malloc(sizeof(ospfs_inode_t) * fs.super.os_ninodes);
	memset(fs.inodes, 0, sizeof(ospfs_inode_t) * fs.super.os_ninodes);

	int check;
	for (ino_no = 1; ino_no < fs.super.os_ninodes; ino_no++){
		check = checks_inode(ino_no);
		if (check == FS_BROKEN)
			return FS_BROKEN;
		else if (check == FS_FIXED)
			retval = FS_FIXED;
	}
	return retval;
}

static int checks_referenced_blocks(){
	int retval = FS_OK;
	int bitmap_block_size = fs.super.os_nblocks / OSPFS_BLKBITSIZE;
	int inode_blocks = fs.super.os_ninodes / OSPFS_BLKBITSIZE;
	int blocks_used;

	CHECK("referenced blocks");
	
	if ((fs.super.os_nblocks % OSPFS_BLKBITSIZE) > 0)
		bitmap_block_size++;
	fs.bitmap = malloc(bitmap_block_size * OSPFS_BLKSIZE);
	
	if ((fs.super.os_ninodes / OSPFS_BLKBITSIZE) > 0)
		inode_blocks++;
	blocks_used = fs.super.os_firstinob + inode_blocks;
	for (i = 0; i < blocks_used; i++)
		bitmap_set(i, 0); // All blocks thru inodes are used.
	for (; i < fs.super.os_nblocks; i++)
		bitmap_set(i, 1);
}

static int checks_directories(){
	int retval = FS_OK;
	int i, direntry_num;
	ospfs_inode_t *curr_inode;
	ospfs_direntry_t *curr_direntry;

	CHECK("directories");

	for (i = 0; i < fs.super.os_ninodes; i++)
		fs.inodes[i].oi_nlink = 0;

	//Checking every directory
	for (i = 0; i < fs.super.os_ninodes; i++){
		curr_inode = &fs.inodes[i];
		
		//We only want directory inodes becase they contain all the information
		if (curr_inode->oi_ftype != OSPFS_FTYPE_DIR)
			continue;
		for (direntry_num = 0; direntry_num < curr_inode->oi_size; direntry_num++){
			curr_direntry = ospfs_inode_data(curr_inode, direntry_num);

			if (curr_direntry->od_ino == 0)
				continue;

			if (fs.super.os_ninodes <= curr_direntry->od_ino){
				retval = FS_FIXED;
				FIXED("Inode out of range");
				continue;
			}

			if (strchr(curr_direntry->od_name, '\0') == NULL){
				retval = FS_FIXED;
				FIXED("Invalid directory name");
				continue;
			}

			fs.inodes[curr_direntry->od_ino].oi_nlink++;
		}
	}

	printf("Directories are correct");
	return retval;
}

static int checks_bitmap(){
	CHECK("free block bitmap");

	if (memcmp(fs.bitmap, block_pointer(2), fs.num_bitmap_blocks * OSPFS_BLKSIZE) == 0)
		return FS_OK;
	else{
		FIXED("Bitmap incorrect");
		return FS_FIXED;
	}
}

static int checks_inode(uint32_t ino){
	int retval = FS_OK;
	int i;

	ospfs_symlink_inode_t *new_sym_inode, fs_sym_inode;
	ospfs_inode_t *new_inode;
	ospfs_inode_t *fs_inode = block_offset(fs.super.os_firstinob, ino * OSPFS_INODESIZE);

	//Empty inodes
	if (fs_inode->oi_nlink == 0)
		return retval;

	new_inode = &fs.inodes[ino];

	switch(fs_inode->oi_ftype){
		case OSPFS_FTYPE_REG:
		case OSPFS_FTYPE_DIR:
			if (fs_inode->oi_size > OSPFS_MAXFILESIZE){
				new_inode->oi_size = OSPFS_MAXFILESIZE;
				FIXED("Inode size too large");
				result = FS_FIXED;
			} else
				new_inode->oi_size = fs_inode->oi_size;
			new_inode->oi_mode = fs_inode->oi_mode;

			if (fs_inode->oi_indirect2 != NULL)
				new_inode->oi_indirect2 = fs_inode->oi_indirect2;
			if (fs_inode->oi_indirect != NULL)
				new_inode->oi_indirect = fs_inode->oi_indirect;
			for (i = 0; i < OSPFS_NDIRECT; i++)
				new_inode[i] = fs_inode->oi_direct[i];
			break;
		case OSPFS_FTYPE_SYMLINK:
			fs_sym_inode = (ospfs_symlink_inode_t *) fs_inode;
			new_sym_inode = (ospfs_symlink_inode_t *) new_inode;

			new_sym_inode->oi_size = 0;
			for (i = 0; i < OSPFS_MAXSYMLINKLEN; i++){
				new_sym_inode->oi_symlink[i] = fs_sym_inode->oi_symlink[i];
				if (fs_sym_inode->oi_symlink[i] == '\0')
					break;
				else
					new_sym_inode->oi_size++;
			}
			if (new_sym_inode->oi_symlink[i] != '\0'){
				new_sym_inode->oi_symlink[i] = '\0';
				FIXED("Symbolic link value too long");
			}
			break;
		default:
			FIXED("Incorrect inode type");
			return FS_FIXED;
	}

	new_inode->oi_ftype = fs_inode->oi_ftype;
	new_inode->oi_nlink = fs_inode->oi_nlink;

	printf("Current inode is correct\n");

	return retval;
}

void *block_pointer(uint32_t block_num){
	return fs.buffer + (block_num * OSPFS_BLKSIZE);
}

void *block_offset(uint32_t block_num, uint32_t offset){
	return fs.buffer + (block_num * OSPFS_BLKSIZE) + offset;
}

//Taken from ospfsmod.c

// ospfs_inode_blockno(oi, offset)
//	Use this function to look up the blocks that are part of a file's
//	contents.
//
//   Inputs:  oi     -- pointer to a OSPFS inode
//	      offset -- byte offset into that inode
//   Returns: the block number of the block that contains the 'offset'th byte
//	      of the file

static inline uint32_t
ospfs_inode_blockno(ospfs_inode_t *oi, uint32_t offset)
{
	uint32_t blockno = offset / OSPFS_BLKSIZE;
	if (offset >= oi->oi_size || oi->oi_ftype == OSPFS_FTYPE_SYMLINK)
		return 0;
	else if (blockno >= OSPFS_NDIRECT + OSPFS_NINDIRECT) {
		uint32_t blockoff = blockno - (OSPFS_NDIRECT + OSPFS_NINDIRECT);
		uint32_t *indirect2_block = ospfs_block(oi->oi_indirect2);
		uint32_t *indirect_block = ospfs_block(indirect2_block[blockoff / OSPFS_NINDIRECT]);
		return indirect_block[blockoff % OSPFS_NINDIRECT];
	} else if (blockno >= OSPFS_NDIRECT) {
		uint32_t *indirect_block = ospfs_block(oi->oi_indirect);
		return indirect_block[blockno - OSPFS_NDIRECT];
	} else
		return oi->oi_direct[blockno];
}


// ospfs_inode_data(oi, offset)
//	Use this function to load part of inode's data from "disk",
//	where 'offset' is relative to the first byte of inode data.
//
//   Inputs:  oi     -- pointer to a OSPFS inode
//	      offset -- byte offset into 'oi's data contents
//   Returns: a pointer to the 'offset'th byte of 'oi's data contents
//
//	Be careful: the returned pointer is only valid within a single block.
//	This function is a simple combination of 'ospfs_inode_blockno'
//	and 'ospfs_block'.

static inline void *
ospfs_inode_data(ospfs_inode_t *oi, uint32_t offset)
{
	uint32_t blockno = ospfs_inode_blockno(oi, offset);
	return (uint8_t *) ospfs_block(blockno) + (offset % OSPFS_BLKSIZE);
}

void load_file_system(int argc, char** argv){

}
void write_fixed_file_system(){

}

int main (int argc, char** argv){
	printf("Running Filesystem Image Fixer\n");

	switch(fix_file_system()){
		case FS_OK:
			printf("Filesystem has no errors\n");
			break;
		case FS_FIXED:
			printf("All errors have been fixed\n");
			break;
		case FS_BROKEN:
			printf("Errors with filesystem are unfixable\n");
			break;
		default:
			ERROR("You broke the file system fixer");
			exit(1);
	}
	return 0;
}