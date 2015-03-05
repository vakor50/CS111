#ifndef OSPFSFIX_H
#define OSPFSFIX_H

#include "ospfs.h"

#define MAX_FILENAME_LEN 1024

//Define Error Messages
#define ERROR(msg) printf("%s in %s, Line:%d\n", msg, __FILE__, __LINE__)
#define FIXED(msg) printf("Fixed Error:%s\n", msg)
#define UNFIXABLE(msg) printf("Error Unfixable:%s\n", msg)
#define CHECK(msg) printf("Checking %s\n", msg)
#define CORRECT(msg) printf("Passed all %s checks and fixes\n", msg)

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

extern file_system_t fs;

int fix_file_system();

static int checks_superblock();
static int checks_inodes();
static int checks_referenced_blocks();
static int checks_directories();
static int checks_bitmap();

static int bitmap_get(uint32_t blkno);
static void bitmap_set(uint32_t blkno, int free);
static int checks_inode(uint32_t ino);
static int check_direct_refs(ospfs_inode_t *inode);
static int check_indirect_refs(ospfs_inode_t *inode);
static int check_twice_indirect_refs(ospfs_inode_t *inode);
static int truncates_inode(ospfs_inode_t *inode, int n);

void *block_pointer(uint32_t block_num);
void *block_offset(uint32_t block_num, uint32_t offset);

static inline uint32_t ospfs_inode_blockno(ospfs_inode_t *oi, uint32_t offset);
static inline void *ospfs_inode_data(ospfs_inode_t *oi, uint32_t offset)

void load_file_system(int argc, char** argv);
void write_fixed_file_system();

#endif
