#include <stdint.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "ospfsfix.h"

void loads_file(int argc, char **argv)
{
	if (argc == 2) {
		// Open file
		FILE *filp;
		if (MAX_INPUT_FILENAME_LEN < strlen(argv[1])) {
			printf("Error: filename must not exceed %d characters\n", MAX_INPUT_FILENAME_LEN);
			exit(1);
		}
		if (NULL == (filp = fopen(argv[1], "r"))) {
			perror("Error: failed to open file");
			exit(1);
		}

		// Get file length 
		if (-1 == fseek(filp, 0L, SEEK_END)) {
			ERROR("Error: problem reading file1");
			exit(1);
		}
		if (-1 == (fs.buflen = ftell(filp))) {
			ERROR("Error: problem with reading file2");
			exit(1);
		}
		if (-1 == fseek(filp, 0L, SEEK_SET)) {
			ERROR("Error: problem with reading file3");
			exit(1);
		}
		
		// Load file contents into filesystem
		if (NULL == (fs.buf = malloc(fs.buflen + 1))) {
			ERROR("Error: problem with reading file");
		}
		fread(fs.buf, 1, fs.buflen, filp);

		fclose(filp);
	
	} else {
		printf("Error: invoke with \'ospfsfixer [image-file]\'\n");
		exit(1);
	}
}

void writes_fixed_image()
{
	FILE* filp = fopen("fixed.img", "w");
	if (filp == NULL) 
	{
		printf("Error: unable to open file for writing\n");
		return;
	}

	fwrite(blkstart(0), OSPFS_BLKSIZE, 1, filp);

	// write superblock
	size_t pad_size = OSPFS_BLKSIZE - sizeof(ospfs_super_t);
	void *pad = malloc(pad_size);
	memset(pad, 0, pad_size);
	fwrite(&fs.super, sizeof(ospfs_super_t), 1, filp);
	fwrite(pad, pad_size, 1, filp);

	// write bitmap
	fwrite(fs.bitmap, OSPFS_BLKSIZE, fs.num_bitmap_blks, filp);

	// write inodes
	fwrite(fs.inodes, sizeof(ospfs_inode_t), fs.super.os_ninodes, filp);
	size_t num_bytes_written_inode = sizeof(ospfs_inode_t) * fs.super.os_ninodes;
	size_t num_written_last_inode = num_bytes_written_inode % OSPFS_BLKSIZE;
	if (num_written_last_inode != 0)
		fwrite(fs.inodes, 1, OSPFS_BLKSIZE - num_written_last_inode, filp);
	
	// write remaining data blocks
	size_t inodes_block_size = fs.super.os_ninodes / OSPFS_BLKINODES;
	if (fs.super.os_ninodes % OSPFS_BLKINODES)
		inodes_block_size++;
	
	fwrite(blkstart(fs.super.os_firstinob + inodes_block_size), OSPFS_BLKSIZE, fs.super.os_nblocks, filp);

	fclose(filp);
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
