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
static int checks_superblock();
static int checks_inodes();
static int checks_referenced_blocks();
static int checks_directories();
static int checks_bitmap();

// Helper functions.
static int bitmap_get(uint32_t blkno);
static void bitmap_set(uint32_t blkno, int free);
static int checks_inode(uint32_t ino);
static int checks_direct_refs(ospfs_inode_t *inode);
static int checks_indirect1_refs(ospfs_inode_t *inode);
static int checks_indirect2_refs(ospfs_inode_t *inode);
static int truncates_inode(ospfs_inode_t *inode, int n);
static uint32_t file_blockno(ospfs_inode_t *inode, uint32_t offset);
static void *file_offset(ospfs_inode_t *inode, uint32_t offset);


int fix_file_system(){

}

static int checks_superblock(){

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

	fs.inodes = malloc(sizeof(ospfs_inode_t) * fs.super.os_ninodes);
	memset(fs.inodes, 0, sizeof(ospfs_inode_t) * fs.super.os_ninodes);

	for (ino_no = 1; ino_no < fs.super.os_ninodes; ino_no++){
		//Check the inode
		//TODO
	}
}

static int checks_referenced_blocks(){

}

static int checks_directories(){

}

static int checks_bitmap(){

}

void *block_pointer(uint32_t block_num){
	return fs.buffer + (block_num * OSPFS_BLKSIZE);
}

void *block_offset(uint32_t block_num, uint32_t offset){
	return fs.buffer + (block_num * OSPFS_BLKSIZE) + offset;
}