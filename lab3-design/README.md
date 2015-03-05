Lab 3 Design Problem
Kalin Khemka and Vir Thakor

In this lab, we designed a user level program to analyze an OSPFS filesystem image and fix
any problems with it. To do so, we checked if any of the four invariants were violated and
ran sanity checks on all the disk structures involved on the filesystem image (superblock,
inodes, and directory entries). Many of our tests were done together. For example, checking
the first invariant involving blocks being used for only one purpose was done in conjunction
with all the rest of our tests. 

First, we checked the superblock. We ran multiple checks, checking whether there was enough
space for a superblock, the magic number was correct, the number of blocks and inodes was
correct, and finally the first inode location was correct.

Second, we checked the inodes themselves for errors. For every inode, we checked the size,
the validity of the indirect and doubly indirect pointers, and the type, to make sure it
was recognizable. For symlink inodes, we also did a sanity check on the length of the name.

VIR, FINISH the rest please.
