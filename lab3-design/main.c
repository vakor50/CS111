#include <stdint.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "ospfsfix.h"

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
