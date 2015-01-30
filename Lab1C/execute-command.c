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
#include <errno.h> //creates integer errno

#include <unistd.h> //pipe
#include <stdio.h> //standard input output
#include <string.h> //strcmp
#include <sys/types.h>  //pid_t
#include <sys/wait.h> //waitpid
#include <unistd.h>  //fork
#include <stdlib.h>  //exit
#include <fcntl.h> //file control
#include <time.h> //gettime
#include <sys/time.h> //getrusage
#include <sys/resource.h> //getrusage

/* FIXME: You may need to add #include directives, macro definitions,
   static function definitions, etc.  */

int
prepare_profiling (char const *name)
{
  /* FIXME: Replace this with your implementation.  You may need to
     add auxiliary functions and otherwise modify the source code.
     You can also use external functions defined in the GNU C Library.  */
	int file_descriptor;
	file_descriptor = open(name, O_RDONLY | O_CREAT | O_TRUNC, 0666);
	if (file_descriptor < 0)
		error(1,0,"Unable to create file descriptor for profiling\n");
	return file_descriptor;
}

double
make_timespec(double sec, double nsec)
{
	return (sec+(nsec/1000000000))
}

double
make_timeval(double sec, double usec)
{
	return (sec+(usec/1000000))
}

double*
calculate_time_end(double start_time)
{
	double real_end_time, execution_time, user_time, system_time;
	struct timespec real_time, monotonic_time;
	struct rusage usage_time, usage_time_children;

	if (clock_gettime(CLOCK_REALTIME, &real_time) < 0)
		error(1,0,"Unable to receive real clock time\n");
	real_end_time = make_timespec(real_time.tv_sec, real_time.tv_nsec);
	
	if (clock_gettime(CLOCK_MONOTONIC, &monotonic_time) < 0)
		error(1,0,"Unable to receive monotonic clock time\n");
	execution_time = make_timespec(monotonic_time.tv_sec, monotonic_time.tv_nsec) - start_time;

	if (getrusage(RUSAGE_SELF, &usage_time) < 0)
		error(1,0,"Unable to receive usage time\n");
	if (getrusage(RUSAGE_CHILDREN, &usage_time_children) < 0)
		error(1,0,"Unable to receive usage time\n");
	user_time = make_timeval(usage_time.ru_utime.tv_sec, usage_time.ru_utime.tv_usec) + make_timeval(usage_time_children.ru_utime.tv_sec, usage_time_children.ru_utime.tv_usec);
	system_time = make_timeval(usage_time.ru_stime.tv_sec, usage_time.ru_stime.tv_usec) + make_timeval(usage_time_children.ru_stime.tv_sec, usage_time_children.ru_stime.tv_usec);

	double *return_array = {real_end_time, execution_time, user_time, system_time};
	return return_array;
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
			error(1,0,"Unable to open input\n");
		if (dup2(temp_in, 0) == -1)
			error(1,0,"Unable to duplicate input file descriptors\n");
		if (close(temp_in) == -1)
			error(1,0,"Unable to close input\n");
	}

	if (c->output != NULL)
	{
		// write to a file of name c->output, into stdout
		int temp_out = open(c->output, O_WRONLY | O_TRUNC | O_CREAT, 0666);
		if (temp_out == -1)
			error(1,0,"Unable to open output\n");
		if (dup2(temp_out, 1) == -1)
			error(1,0,"Unable to duplicate input file descriptors\n");
		if (close(temp_out) == -1)
			error(1,0,"Unable to close output\n");
	}
}

void
execute_command (command_t c, int profiling)
{
  /* FIXME: Replace this with your implementation, like 'prepare_profiling'.  */
	pid_t child, grandchild;
	int file_descriptor[2];//0 is read, 1 is write
	int counter = 0;

	switch(c->type)
	{
		case SIMPLE_COMMAND:
			if (!strcmp (c->u.word[0], "exec")) //Checks for the exec command and runs accordingly, killing parent process
			{
				if (c->u.word[1] == NULL)
				{
					c->status = -1;
					error(1,0, "Invalid exec command\n");
				}
				check_io(c);
				int i = execvp(c->u.word[1], c->u.word+1);
				if (i < 0)
				{
					c->status = -1;
					error(1,errno, "Exec command error");
				}
			}
			child = fork(); //Forks the process to run the simple command properly without messing up parent process
			if (child == 0) //Child Process
			{
				if (c->u.word[0][0] == ':') //Check for a colon simple command
					_exit(0);  //Does nothing with null utility
				check_io(c);
				int i = execvp(c->u.word[0], c->u.word);
				if (i < 0)
				{
					c->status = -1;
					error(1,errno, "Invalid simple command");
				}
			}
			else if (child > 0) //Parent Process
			{
				int simple;
				waitpid(child, &simple, 0);
				c->status = WEXITSTATUS(simple);
			}
			else
			{
				c->status = -1;
				error(1,errno, "Unable to fork");
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
			{
				c->status = -1;
				error(1,0, "Unable to pipe\n");
			}

			/*child = fork(); //Forks the process to run the two commands properly as a pipe

			if (!child) //Child was succesfully created and this is the child
			{
				close(file_descriptor[0]); //Close the reading from the child
				if (dup2(file_descriptor[1],1) == -1)
				{
					c->status = -1;
					error(1,errno, "Unable to duplicate pipe child file descriptors");
				}
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
				{
					c->status = -1;
					error(1,errno, "Unable to duplicate pipe parent file descriptors");
				}
				execute_command(c->u.command[1], profiling); //Executes the second command
				c->status = c->u.command[1]->status; //Sets the final c->status to that of the second command
				close(file_descriptor[0]); //Close the reading from the parent
			}
			else //Something happened and the child wasn't produced
			{
				c->status = -1;
				error(1,errno, "Unable to fork");
			}*/

			//--------------------------------------------------------------------------------------------------------------

			int status;
			child = fork(); //Forks the process to run the two commands properly as a pipe

			if (!child) //Child was succesfully created and this is the child
			{
				grandchild = fork();
				if (!grandchild) //Grandchild was succesfully created and this is the grandchild
				{
					close(file_descriptor[0]); //Close the reading from the grandchild
					if (dup2(file_descriptor[1],1) == -1)
					{
						c->status = -1;
						error(1,errno, "Unable to duplicate pipe child file descriptors");
					}
					execute_command(c->u.command[0], profiling); //Executes the first command
					c->status = c->u.command[0]->status;
					close(file_descriptor[1]); //Close the writing from the grandchild
					exit(0);
				}
				else if (grandchild > 0) //This is the child class
				{
					waitpid(grandchild, &status, 0);

					close(file_descriptor[1]); //Close the writing from the child
					if (dup2(file_descriptor[0],0) == -1)
					{
						c->status = -1;
						error(1,errno, "Unable to duplicate pipe parent file descriptors");
					}
					execute_command(c->u.command[1], profiling); //Executes the second command
					c->status = c->u.command[1]->status; //Sets the final c->status to that of the second command
					close(file_descriptor[0]); //Close the reading from the child
				}
				else //Something happened and the grandchild wasn't produced
				{
					c->status = -1;
					error(1,errno, "Unable to fork");
				}
			}
			else if (child > 0) //This is the parent class
			{
				close(file_descriptor[0]);
				close(file_descriptor[1]);
				waitpid(child, &status, 0);
			}
			else //Something happened and the child wasn't produced
			{
				c->status = -1;
				error(1,errno, "Unable to fork");
			}
			break;
		case IF_COMMAND:
			check_io(c);
			execute_command(c->u.command[0], profiling);
			c->status = c->u.command[0]->status;
			if ((!c->status) && (c->status != -1)) //If condition succeeded (status is non-zero): if condition is true
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
			c->status = -1;
			error(1,0, "Invalid command stored\n");
	}
}
