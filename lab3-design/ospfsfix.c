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

}

static int checks_inodes(){

}

static int checks_referenced_blocks(){

}

static int checks_directories(){

}

static int checks_bitmap(){

}