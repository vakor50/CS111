// UCLA CS 111 Lab 1 command execution

// Copyright 2012-2014 Paul Eggert.

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

#include "command.h"
#include "command-internals.h"

#include <error.h>

#include <unistd.h>
#include <stdio.h>
#include <sys/types.h>  //pid_t
#include <sys/wait.h> //waitpid
#include <unistd.h>  //fork
#include <stdlib.h>  //exit
#include <fcntl.h> //File Control Options

/* FIXME: You may need to add #include directives, macro definitions,
   static function definitions, etc.  */

int
prepare_profiling (char const *name)
{
  /* FIXME: Replace this with your implementation.  You may need to
     add auxiliary functions and otherwise modify the source code.
     You can also use external functions defined in the GNU C Library.  */
  error (0, 0, "warning: profiling not yet implemented");
  return -1;
}

int
command_status (command_t c)
{
  return c->status;
}

void
check_io (command_t c)
{
	if (c->input != NULL)
	{
		// read file of filename c->input, from stdin
		int temp_in = open(c->input, O_RDONLY, 0666);
		if (temp_in == -1)
			fprintf(stderr, "Something's wrong with opening the input.\n");
		if (dup2(temp_in, 0) == -1)
			fprintf(stderr, "Something's wrong with the duplication of file descriptors in the input.\n");
		if (close(temp_in) == -1)
			fprintf(stderr, "Something's wrong with closing the input.\n");
	}

	if (c->output != NULL)
	{
		// write to a file of name c->output, into stdout
		int temp_out = open(c->output, O_WRONLY | O_TRUNC | O_CREAT, );
		if (temp_out == -1)
			fprintf(stderr, "Something's wrong with opening the output.\n");
		if (dup2(temp_out, 1) == -1)
			fprintf(stderr, "Something's wrong with the duplication of file descriptors in the output.\n");
		if (close(temp_out) == -1)
			fprintf(stderr, "Something's wrong with closing the output.\n");
	}
}

void
execute_command (command_t c, int profiling)
{
  /* FIXME: Replace this with your implementation, like 'prepare_profiling'.  */
	pid_t child;
	int file_descriptor[2];//0 is write, 1 is read
	int new_file_descriptor[2]; //This may not be used, don't use unless absolutely necessary

	switch(c->type)
	{
		case SIMPLE_COMMAND:
			child = fork();
			if (child == 0)
			{
				check_io(c);
				int i = execvp(c->u.word[0], c->u.word);
				if (i < 0)
{
					fprintf(stderr, "Something's wrong with the execution.\n");
					fprintf(stderr, "%s\n", c->u.word[0]);
}
			}
			else if (child > 0)
			{
				int simple;
				waitpid(child, &simple, 0);
				c->status = simple;
			}
			else
			{
				fprintf(stderr, "Something's wrong with the child, so it can't be made.\n");
			}
			break;
		case SUBSHELL_COMMAND:
			check_io(c);
			execute_command(c->u.command[0], profiling);//Run the subshell command
			c->status = c->u.command[0]->status; //Set the status to that of the subshell command
			break;
		case SEQUENCE_COMMAND:
			execute_command(c->u.command[0], profiling);//Run the first command
			execute_command(c->u.command[1], profiling);//Run the second command
			c->status = c->u.command[1]->status; //Set the status to that of the second command; can set to first as well, doesn't matter
			break;
		case PIPE_COMMAND:
			if (pipe(file_descriptor)==-1)
				fprintf(stderr, "Something's wrong with the pipe.\n");

			child = fork(); //Forks the process to run the two commands properly as a pipe

			if (!child) //Child was succesfully created and this is the child
			{
				close(file_descriptor[0]); //Close the reading from the child
				if (dup2(file_descriptor[1],1) == -1)
					fprintf(stderr, "Something's wrong with the file descriptor.\n");
				execute_command(c->u.command[0], profiling); //Executes the first command
				c->status = c->u.command[0]->status;
				close(file_descriptor[1]); //Close the writing from the child
				exit(0);
			}
			else if (child > 0) //This is the parent class
			{
				int status;
				waitpid(child, &status, 0);

				close(file_descriptor[1]); //Close the writing from the parent
				if (dup2(file_descriptor[0],0) == -1)
					fprintf(stderr, "Something's wrong with the file descriptor.\n");
				execute_command(c->u.command[1], profiling); //Executes the second command
				c->status = c->u.command[1]->status; //Sets the final c->status to that of the second command
				close(file_descriptor[0]); //Close the reading from the parent
			}
			else //Something happened and the child wasn't produced
				fprintf(stderr, "Something's wrong with the child, so it can't be made.\n");
			break;
		case IF_COMMAND:
			check_io(c);
			execute_command(c->u.command[0], profiling);
			c->status = c->u.command[0]->status;
			if (!c->status) //If condition succeeded (status is non-zero): if condition is true
			{
				execute_command(c->u.command[1], profiling);
				c->status = c->u.command[1]->status;
			}
			else //If condition failed (status is 0):if condition is false
			{
				if (c->u.command[2] != NULL) //Checks for an "else" portion to the if statement
				{
					execute_command(c->u.command[1], profiling);
					c->status = c->u.command[1]->status;
				}
			}
			break;
		case UNTIL_COMMAND:
			check_io(c);
			do {
				execute_command(c->u.command[0], profiling);
				c->status = c->u.command[0]->status;
				if (!c->status) //Until condition succeeded (status is 0), AKA if statement is true
				{
					execute_command(c->u.command[1], profiling);
					c->status = c->u.command[1]->status;
				}
			} while (c->status); //While the statement is false (status is non-zero) continue doing until command
			break;
		case WHILE_COMMAND:
			check_io(c);
			do {
				execute_command(c->u.command[0], profiling);
				c->status = c->u.command[0]->status;
				if (!c->status) //Until condition succeeded (status is 0), AKA if statement is true
				{
					execute_command(c->u.command[1], profiling);
					c->status = c->u.command[1]->status;
				}
			} while (!c->status); //While the statement is true (status is 0) continue doing while command
			break;
		default:
			fprintf(stderr, "Something's wrong with the command and how it's stored.\n");
	}
}
