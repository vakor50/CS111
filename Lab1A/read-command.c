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
	token_stream_t new_stream;
	bool input_done = false;
	int skip_char = 1;
	char *place_holder;

	if (buffer[buffer_counter] == '\0' || buffer == NULL)
		return NULL;

	while (buffer[buffer_counter] != '\0')
	{
		token_t current_token;
		next_char = buffer[buffer_counter];
		skip_char = 1;
		
		if (is_valid_char(next_char))
		{
			while (is_valid_char(buffer[buffer_counter+skip_char]))
			{
				skip_char++;
			}

			for (int i = 0; i < skip_char; i++)
			{
				place_holder[i] = tolower(buffer[buffer_counter+i]);
			}

			if (strcmp(place_holder,"if") == 0)
			{
				current_token->type = IF_TOKEN;
				strcpy(current_token->content, IF_STR);
			} 
			else if (strcmp(place_holder,"then") == 0)
			{
				current_token->type = THEN_TOKEN;
				strcpy(current_token->content, THEN_STR);
			} 
			else if (strcmp(place_holder,"else") == 0)
			{
				current_token->type = ELSE_TOKEN;
				strcpy(current_token->content, ELSE_STR);
			} 
			else if (strcmp(place_holder,"fi") == 0)
			{
				current_token->type = FI_TOKEN;
				strcpy(current_token->content, FI_STR);
			} 
			else if (strcmp(place_holder,"while") == 0)
			{
				current_token->type = WHILE_TOKEN;
				strcpy(current_token->content, WHILE_STR);
			} 
			else if (strcmp(place_holder,"until") == 0)
			{
				current_token->type = UNTIL_TOKEN;
				strcpy(current_token->content, UNTIL_STR);
			} 
			else if (strcmp(place_holder,"do") == 0)
			{
				current_token->type = DO_TOKEN;
				strcpy(current_token->content, DO_STR);
			} 
			else if (strcmp(place_holder,"done") == 0)
			{
				current_token->type = DONE_TOKEN;
				strcpy(current_token->content, DONE_STR);
			} 
			else
			{
				current_token->type = WORD_TOKEN;
				current_token->content = buffer.substr(buffer_counter,skip_char)
			}
			buffer_counter+=skip_char;
			current_token->line_num = line_num;
		}
		else
		{
			switch(next_char)
			{
				case SEMICOLON_CHAR:
					current_token->type = SEMICOLON_TOKEN;
					current_token->content[0] = SEMICOLON_CHAR;
					current_token->line_num = line_num;
					buffer_counter++;
					break;
				case PIPE_CHAR:
					current_token->type = PIPE_TOKEN;
					current_token->content[0] = PIPE_CHAR;
					current_token->line_num = line_num;
					buffer_counter++;
					break;
				case PAREN_OPEN_CHAR:
					current_token->type = PAREN_OPEN_TOKEN;
					current_token->content[0] = PAREN_OPEN_CHAR;
					current_token->line_num = line_num;
					buffer_counter++;
					break;
				case PAREN_CLOSE_CHAR:
					current_token->type = PAREN_CLOSE_TOKEN;
					current_token->content[0] = PAREN_CLOSE_CHAR;
					current_token->line_num = line_num;
					buffer_counter++;
					break;
					break;	
				case LESS_CHAR: 
					current_token->type = LESS_TOKEN;
					current_token->content[0] = LESS_CHAR;
					current_token->line_num = line_num;
					buffer_counter++;
					break;       
				case GREATER_CHAR: 
					current_token->type = GREATER_TOKEN;
					current_token->content[0] = LESS_CHAR;
					current_token->line_num = line_num;
					buffer_counter++;
					break;
				case NEWLINE_CHAR:
					current_token->type = LESS_TOKEN;
					current_token->content[0] = NEWLINE_CHAR;
					current_token->line_num = line_num;
					while (buffer[buffer_counter+skip_char] == '\n')
					{
						skip_char++;
						line_num++;
					}
					line_num++;
					buffer_counter+=(skip_char);
					break;
				/*This ignores comments and does not place them into the token stream*/
				case COMMENT_CHAR:
					while (buffer[buffer_counter+skip_char] != '\n' && buffer[buffer_counter+skip_char] != '\0')
					{
						skip_char++;
					}
					buffer_counter+=(skip_char);
				case ' ':
				case '\t':
					/*Free the memory of the Token*/
					break;
				default:
					/*Undefined Character*/
					fprintf(stderr, "Undefined Character at line %i", line_num);
					exit(1);
			}
		}
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
