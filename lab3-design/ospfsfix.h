#ifndef OSPFSFIX_H
#define OSPFSFIX_H

#include "ospfs.h"

#define MAX_FILENAME_LEN 1024

//Define Error Messages
#define ERROR(msg) printf("%s in %s, Line:%d\n", msg, __FILE__, __LINE__)
#define FIXED(msg) printf("Fixed Error:%s\n", msg)
#define UNFIXABLE(msg) printf("Error Unfixable:%s\n", msg)

//Return values for the function
#define FS_OK 0
#define FS_FIXED 1
#define FS_BROKEN 2

typedef struct file_system{
	char filename[MAX_FILENAME_LEN + 1];
	void *buffer;
	uint32_t buffer_size;

	ospfs_super_t super;
	ospfs_inode_t *inodes;

	uint32_t num_bitmap_blocks;
	void *bitmap;
} file_system_t;

int fix_file_system();

extern file_system_t fs;

void *block_pointer(uint32_t block_num);
void *block_offset(uint32_t block_num, uint32_t offset);

#endif