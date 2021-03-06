// UCLA CS 111 Lab 1 command interface

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

#define SEMICOLON_CHAR		';'
#define PIPE_CHAR			'|'
#define PAREN_OPEN_CHAR		'('
#define PAREN_CLOSE_CHAR	')'
#define LESS_CHAR           '<'
#define GREATER_CHAR        '>'
#define COMMENT_CHAR        '#'
#define NEWLINE_CHAR        '\n'
#define IF_STR				"if"
#define THEN_STR            "then"
#define ELSE_STR			"else"
#define FI_STR				"fi"
#define WHILE_STR			"while"
#define UNTIL_STR			"until"
#define DO_STR				"do"
#define DONE_STR			"done"

enum token_type
{
	COMPLETE_TOKEN,			//A command that has been completed for the stack
	WORD_TOKEN,				//words
	SEMICOLON_TOKEN,		//;
	PIPE_TOKEN,				//|
	PAREN_OPEN_TOKEN,		//(
	PAREN_CLOSE_TOKEN,		//)
	LESS_TOKEN,				//<
	GREATER_TOKEN,			//>
	COMMENT_TOKEN,			//#
	NEWLINE_TOKEN,			//'\n'
	IF_TOKEN,				//"if"
	THEN_TOKEN,				//"then"
	ELSE_TOKEN,				//"else"
	FI_TOKEN,				//"fi"
	UNTIL_TOKEN,			//"until"
	WHILE_TOKEN,			//"while"
	DO_TOKEN,				//"do"
	DONE_TOKEN				//"done"
};


typedef struct command *command_t;
typedef struct command_stream *command_stream_t;

typedef struct token *token_t;
typedef struct token_stream *token_stream_t;
typedef struct token_stack *token_stack_t;

/* Create a command stream from GETBYTE and ARG.  A reader of
   the command stream will invoke GETBYTE (ARG) to get the next byte.
   GETBYTE will return the next input byte, or a negative number
   (setting errno) on failure.  */
command_stream_t make_command_stream (int (*getbyte) (void *), void *arg);

/* Prepare for profiling to the file FILENAME.  If FILENAME is null or
   cannot be written to, set errno and return -1.  Otherwise, return a
   nonnegative integer flag useful as an argument to
   execute_command.  */
int prepare_profiling (char const *filename);

/* Read a command from STREAM; return it, or NULL on EOF.  If there is
   an error, report the error and exit instead of returning.  */
command_t read_command_stream (command_stream_t stream);

/* Print a command to stdout, for debugging.  */
void print_command (command_t);

/* Execute a command.  Use profiling according to the flag; do not profile
   if the flag is negative.  */
void execute_command (command_t, int);

/* Return the exit status of a command, which must have previously
   been executed.  Wait for the command, if it is not already finished.  */
int command_status (command_t);
