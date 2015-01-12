// UCLA CS 111 Lab 1 command reading

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

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>

/* FIXME: You may need to add #include directives, macro definitions,
   static function definitions, etc.  */



/* FIXME: Define the type 'struct command_stream' here.  This should
   complete the incomplete type declaration in command.h.  */

struct command_stream
{
	command_t *m_command;
	int iterator;
	int current_size;
	int allocated_size;
};

struct token
{
	enum token_type type;
	char *content;
	int line_num;
};

struct token_stream
{
	token_t *m_token;
	int iterator;
	int current_size;
	int allocated_size;
};

bool
is_valid_char(char input)
{
	if (isalnum(input))
    return true;
	switch (input) 
	{
		case '!':
		case '%':
		case '+':
		case ',':
		case '-':
		case '.':
		case '/':
		case ':':
		case '@':
		case '^':
		case '_':
			 return true;
		default: 
			 return false;
	}
}

bool
valid_token(token_t input)
{

}

command_stream_t
token_stream_to_command_stream(token_t input)
{

}

token_stream_t
tokenize (char *buffer)
{
	int buffer_counter = 0;
	int line_num = 1;
	char next_char, next_char_two, next_char_three;
	bool is_special_letter = false;
	token_stream_t new_stream;
	bool input_done = false;

	if (buffer[buffer_counter] == '\0' || buffer == NULL)
		return NULL;

	while (buffer[buffer_counter] != '\0')
	{
		token_t current_token;
		next_char = buffer[buffer_counter];
		
		if (is_valid_char(next_char))
		{
			if (buffer[buffer_counter+1] != '\0' && buffer[buffer_counter+2] != '\0')
			{
				next_char_two = buffer[buffer_counter+1];
				next_char_three = buffer[buffer_counter+2];

				switch(next_char)
				{
					case 'i':
						if (next_char_two == 'f')
						{

						}
						is_special_letter = true;
						break;
					case 't':
						is_special_letter = true;
						break;
					case 'e':
						is_special_letter = true;
						break;
					case 'f':
						is_special_letter = true;
						break;
					case 'w':
						is_special_letter = true;
						break;
					case 'u':
						is_special_letter = true;
						break;
					case 'd':
						is_special_letter = true;
						break;
					default: 
						is_special_letter = false;
						break;
				}
			}				
			
			/*Check for word here*/
			if (!is_special_letter)
			{

			}

		}
		else
		{
			switch(next_char)
			{
				case SEMICOLON_CHAR:
					
					break;
				case PIPE_CHAR:
					
					break;
				case PAREN_OPEN_CHAR:
					
					break;
				case PAREN_CLOSE_CHAR:
					
					break;	
				case LESS_CHAR: 
					
					break;       
				case GREATER_CHAR: 
					
					break;      
				case COMMENT_CHAR:
					
					break;    
				case NEWLINE_CHAR:
					
					break;
				case ' ':
				case '\t':
					/*free memory*/
					break;
				default:
			}
		}


#define IF_STR				"if"
#define THEN_STR            "then"
#define ELSE_STR			"else"
#define FI_STR				"fi"
#define WHILE_STR			"while"
#define UNTIL_STR			"until"
#define DO_STR				"do"
#define DONE_STR			"done"


		}



		buffer_counter++;
	}

}

command_stream_t
make_command_stream (int (*get_next_byte) (void *),
		     void *get_next_byte_argument)
{
  /* FIXME: Replace this with your implementation.  You may need to
     add auxiliary functions and otherwise modify the source code.
     You can also use external functions defined in the GNU C Library.  */
	
	/*Reading in the input*/
	size_t buffer_size = 1024;
	size_t counter = 0;
	next_char = get_next_byte(get_next_byte_argument);
	while (next_char != EOF)
	{
		buffer[counter++] = next_char;
		if (counter == buffer_size)
		{
			buffer = (char*) checked_grow_alloc(buffer, &buffer_size);
		}
		next_char = get_next_byte(get_next_byte_argument);
	}
	if (buffer_size == counter)
		buffer = (char*) checked_grow_alloc(buffer, &buffer_size);
	buffer[counter] = '\0';

	/*Tokenizing the input*/


  error (1, 0, "command reading not yet implemented");
  return 0;
}

command_t
read_command_stream (command_stream_t s)
{
  /* FIXME: Replace this with your implementation too.  */
  error (1, 0, "command reading not yet implemented");
  return 0;
}
