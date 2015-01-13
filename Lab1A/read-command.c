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
	command_t m_command;
	command_stream_t next_stream;
	command_stream_t prev_stream;
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
	int size;
};

struct token_stack
{
	token_t m_token;
	command_t m_command;
	token_stack_t next_token_stack;
	token_stack_t prev_token_stack;
};

command_type
convert_token_to_command_type (token_t token)
{
    switch (token->type)
    {
        case IF_TOKEN:
            return IF_COMMAND;
        case WHILE_TOKEN:
            return WHILE_COMMAND;
        case UNTIL_TOKEN:
            return UNTIL_COMMAND;
        case SEMICOLON_TOKEN:
            return SEQUENCE_COMMAND;
        case WORD_TOKEN:
            return SIMPLE_COMMAND;
        case SEQUENCE_COMMAND_CHAR:
            return SEQUENCE_COMMAND;
        case PIPE_COMMAND_CHAR:
            return PIPE_COMMAND;
        case SUBSHELL_COMMAND_CHAR_OPEN:
        case SUBSHELL_COMMAND_CHAR_CLOSE:
            return SUBSHELL_COMMAND;
        default: break;
    }
    return SIMPLE_COMMAND;
}

token_stack_t global_stack;

void
push_token_stack(token_t item)
{
	token_stack_t temp_stack;
	if (global_stack == NULL)
	{
		global_stack->m_token = item;
		global_stack->prev_token_stack = global_stack->next_token_stack = NULL;
	}
	else
	{
		temp_stack->m_token = item;
		temp_stack->next_token_stack = NULL;
		temp_stack->prev_token_stack = global_stack;
		global_stack->m_token = item;
	}
}

token_stack_t
pop_token_stack()
{
	token_stack_t temp_stack = NULL;
	if (global_stack != NULL)
	{
		temp_stack = global_stack;
		temp_stack->next_token = temp_stack->prev_token = NULL;
		global_stack= global_stack->prev_token_stack;
		global_stack->next_token_stack = NULL;
	}
	else
		return temp_stack;
}

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
valid_token_stream(token_stream_t input)
{
	int paren_counter = 0, if_counter = 0, then_counter = 0, else_counter = 0, fi_counter = 0;
	int while_counter = 0, until_counter = 0, do_counter = 0, done_counter = 0;
	int j = 0, current_line_num;
	token_t current_token = NULL;
	token_t prev_token = NULL, next_token = NULL;

	for (int i = 0; i < input->size; i++)
	{
		current_token = input->m_token[i];
		if (i == 0)
			continue;
		prev_token = input->m_token[i-1];
		switch(input->m_token[i]->type)
		{
			case IF_TOKEN:
			case UNTIL_TOKEN:
			case WHILE_TOKEN:
			case THEN_TOKEN:
			case ELSE_TOKEN:
			case FI_TOKEN:
			case DO_TOKEN:
			case DONE_TOKEN:
				if (prev_token->type == WORD_TOKEN)
				{
					current_token->type = WORD_TOKEN;
				}
				break;
			default:
				break;
		}
	}	

	prev_token = NULL;

	for (int i = 0; i < input->size; i++)
	{
		paren_counter = 0, if_counter = 0, then_counter = 0, else_counter = 0, fi_counter = 0;
		while_counter = 0, until_counter = 0, do_counter = 0, done_counter = 0;
		current_token = input->m_token[i];

		if (i != 0)
			prev_token = input->m_token[i-1];
		if ((i+1) != input->size)
			next_token = input->m_token[i+1];

		switch(current_token)
		{
			case WORD_TOKEN:
				continue;
			case SEMICOLON_TOKEN:
				if (i == 0)
					fprintf(stderr, "%d: Invalid Semicolon",current_token->line_num);
				if (next_token->type == SEMICOLON_TOKEN)
					fprintf(stderr, "%d: Invalid Semicolon",current_token->line_num);
				break;
			case PIPE_TOKEN:
				switch(next_token->type)
					{
						case WORD_TOKEN:
						case IF_TOKEN:
						case THEN_TOKEN:
						case ELSE_TOKEN:
						case FI_TOKEN:
						case UNTIL_TOKEN:
						case WHILE_TOKEN:
						case DO_TOKEN:
						case DONE_TOKEN:
						case PAREN_OPEN_TOKEN:
						case PAREN_CLOSE_TOKEN:
							break;
						default:
							fprintf(stderr, "%d: Invalid Newline",current_token->line_num);
					}
				if (next_token->type == PIPE_TOKEN)
					fprintf(stderr, "%d: Invalid Pipe",current_token->line_num);
				break;
			case PAREN_OPEN_TOKEN:
				j = i;
				while (j < current_token->size)
				{
					if (input->m_token[i]->type == PAREN_OPEN_TOKEN)
					{
						paren_counter++;
						current_line_num = input->m_token[i]->line_num;
					}
					if (input->m_token[i]->type == PAREN_CLOSE_TOKEN)
					{
						paren_counter--;
						current_line_num = input->m_token[i]->line_num;
					}
				}
				if (paren_counter != 0)
					fprintf(stderr, "%d: Invalid Parentheses",current_line_num);
				break;
			case LESS_TOKEN:
			case GREATER_TOKEN:
				if (prev_token->type != WORD_TOKEN || next_token->type != WORD_TOKEN)
				{
					fprintf(stderr, "%d: Invalid I/O Redirection",current_token->line_num);
				}
				break;
			case NEWLINE_TOKEN:
				if (next_token != NULL)
				{
					switch(next_token->type)
					{
						case WORD_TOKEN:
						case IF_TOKEN:
						case THEN_TOKEN:
						case ELSE_TOKEN:
						case FI_TOKEN:
						case UNTIL_TOKEN:
						case WHILE_TOKEN:
						case DO_TOKEN:
						case DONE_TOKEN:
						case PAREN_OPEN_TOKEN:
						case PAREN_CLOSE_TOKEN:
							break;
						default:
							fprintf(stderr, "%d: Invalid Newline",current_token->line_num);
					}
				}
				if (prev_token->type == LESS_TOKEN || prev_token->type == GREATER_TOKEN)
					fprintf(stderr, "%d: Invalid Newline",current_token]->line_num);
				break;
			case IF_TOKEN:
				j = i;
				while (j < current_token->size)
				{
					if (input->m_token[i]->type == IF_TOKEN)
					{
						if_counter++;
						current_line_num = input->m_token[i]->line_num;
					}
					if (input->m_token[i]->type == THEN_TOKEN)
					{
						then_counter++;
						current_line_num = input->m_token[i]->line_num;
					}
					if (input->m_token[i]->type == ELSE_TOKEN)
					{
						else_counter++;
						current_line_num = input->m_token[i]->line_num;
					}
					if (input->m_token[i]->type == FI_TOKEN)
					{
						if_counter--;
						then_counter--;
						else_counter--;
						current_line_num = input->m_token[i]->line_num;
					}
				}
				if (paren_counter != 0)
					fprintf(stderr, "%d: Invalid Parentheses",current_line_num);
				break;
			case UNTIL_TOKEN:
				break;
			case WHILE_TOKEN:
				break;
			default:
				fprintf(stderr, "%d: Something went wrong.",current_token->line_num);
		}
	}
}

command_stream_t
token_stream_to_command_stream(token_stream_t input)
{

}

token_stream_t
tokenize (char *buffer)
{
	int buffer_counter = 0;
	int line_num = 1;
	char next_char, next_char_two, next_char_three;
	token_stream_t new_stream;
	new_stream->m_token = (char*) checked_malloc(1);
	new_stream->size = 0;
	int token_counter = 0;
	int skip_char = 1;
	char *place_holder;
	bool ignored = false;

	if (buffer[buffer_counter] == '\0' || buffer == NULL)
		return NULL;

	while (buffer[buffer_counter] != '\0')
	{
		token_t current_token;
		current_token->content = (char*) checked_malloc(1);
		next_char = buffer[buffer_counter];
		skip_char = 1;
		ignored=false;
		
		if (is_valid_char(next_char))
		{
			while (is_valid_char(buffer[buffer_counter+skip_char]))
			{
				skip_char++;
			}
			current_token->content = (char*) checked_grow_alloc(current_token->content, (size_t) skip_char);
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
		}
		else
		{
			switch(next_char)
			{
				case SEMICOLON_CHAR:
					current_token->type = SEMICOLON_TOKEN;
					current_token->content[0] = SEMICOLON_CHAR;
					break;
				case PIPE_CHAR:
					current_token->type = PIPE_TOKEN;
					current_token->content[0] = PIPE_CHAR;
					break;
				case PAREN_OPEN_CHAR:
					current_token->type = PAREN_OPEN_TOKEN;
					current_token->content[0] = PAREN_OPEN_CHAR;
					break;
				case PAREN_CLOSE_CHAR:
					current_token->type = PAREN_CLOSE_TOKEN;
					current_token->content[0] = PAREN_CLOSE_CHAR;
					break;	
				case LESS_CHAR: 
					current_token->type = LESS_TOKEN;
					current_token->content[0] = LESS_CHAR;
					break;       
				case GREATER_CHAR: 
					current_token->type = GREATER_TOKEN;
					current_token->content[0] = LESS_CHAR;
					break;
				case NEWLINE_CHAR:
					ignored = true;
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
					ignored = true;
					/*Free the memory of the Token*/
					break;
				default:
					/*Undefined Character*/
					fprintf(stderr, "Undefined Character at line %i", line_num);
					exit(1);
			}
		}
		if (!ignored)
		{
			current_token->content[skip_char]='\0';
			current_token->line_num = line_num;
			buffer_counter+=skip_char;
			new_stream->m_token[token_counter++] = current_token;
			new_stream->size++;
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
	char *buffer = (char*) checked_malloc(buffer_size);
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
	tokenize(buffer);

	/*Check if all tokens are valid*/

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
