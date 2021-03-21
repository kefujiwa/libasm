# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/19 00:58:10 by kefujiwa          #+#    #+#              #
#    Updated: 2021/03/21 18:16:15 by kefujiwa         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

### MAKEFILE ###

## COLORS ##

# Formats #
_END				= \x1b[0m
_BOLD				= \x1b[1m
_DIM				= \x1b[2m
_UNDER				= \x1b[4m
_BLINK				= \x1b[5m
_REV				= \x1b[7m
_HIDDEN				= \x1b[8m

# Foreground Colors #
_GREY				= \x1b[30m
_RED				= \x1b[31m
_GREEN				= \x1b[32m
_YELLOW				= \x1b[33m
_BLUE				= \x1b[34m
_PURPLE				= \x1b[35m
_CYAN				= \x1b[36m
_WHITE				= \x1b[37m

# Background Colors #
_BGREY				= \x1b[40m
_BRED				= \x1b[41m
_BGREEN				= \x1b[42m
_BYELLOW			= \x1b[43m
_BBLUE				= \x1b[44m
_BPURPLE			= \x1b[45m
_BCYAN				= \x1b[46m
_BWHITE				= \x1b[47m


# **************************************************************************** #

## VARIABLES ##

# Compilation #
CC					= gcc
CFLAGS				= -Wall -Wextra -Werror
NA					= nasm
NFLAGS				= -f macho64
AR					= ar rcs
# Delete #
RM					= rm -rf

# Directories #
HEADER_DIR			= includes/
SRCS_DIR			= srcs/
OBJS_DIR			= objs/srcs/
SRCSb_DIR			= bonus/
OBJSb_DIR			= objs/bonus/
TEST_DIR			= test/srcs/
TESTb_DIR			= test/bonus/

# Files #
SRCS				= ft_strcmp.s \
					  ft_strcpy.s \
					  ft_strdup.s \
					  ft_strlen.s \
					  ft_read.s \
					  ft_write.s

TESTS				= main.c \
					  strcmp_test.c \
					  strcpy_test.c \
					  strdup_test.c \
					  strlen_test.c \
					  read_test.c \
					  write_test.c
T_SRCS				= $(addprefix $(TEST_DIR), $(TESTS))

SRCSb				= ft_atoi_base_bonus.s \
					  ft_list_size_bonus.s

TESTSb				= main_bonus.c \
					  atoi_base_test.c \
					  list_size_test.c \
					  list_utils.c
T_SRCSb				= $(addprefix $(TESTb_DIR), $(TESTSb))

# Compiled Files #
OBJS				= $(SRCS:%.s=$(OBJS_DIR)%.o)
OBJSb				= $(SRCSb:%.s=$(OBJSb_DIR)%.o)
NAME				= libasm.a

# Executable #
EXEC				= exec


# **************************************************************************** #

## RULES ##
# Main Rules #
all:				$(NAME)

clean:
					@echo "$(_RED)Cleaning libasm objects...\n$(_END)"
					@$(RM) objs/

fclean:				clean
						@echo "$(_RED)Deleting library '$(NAME)'...\n$(_END)"
						@$(RM) $(NAME) *.dSYM ./test/*.txt

re:					fclean all

test:				re
						@$(CC) $(CFLAGS) -I $(HEADER_DIR) $(NAME) $(T_SRCS) -o $(EXEC)
						@./$(EXEC)
						@$(RM) $(EXEC)
						@$(RM) $(TEST_DIR)*.txt

# Bonus Rules #
bonus:				re $(OBJSb)
						@$(AR) $(NAME) $(OBJSb)
						@echo "\n\n$(_GREEN)Library '$(NAME)' compiled.\n$(_END)"

testb:			bonus
						@$(CC) $(CFLAGS) -I $(HEADER_DIR) $(NAME) $(T_SRCSb) -o $(EXEC)
						@./$(EXEC)
						@$(RM) $(EXEC)
						@$(RM) $(TEST_DIR)*.txts

# Variables Rules #
$(NAME):			$(OBJS)
						@$(AR) $(NAME) $(OBJS)
						@echo "\n\n$(_GREEN)Library '$(NAME)' compiled.\n$(_END)"

# Compiled Source Files #
$(OBJS):			$(OBJS_DIR)
$(OBJSb):			$(OBJSb_DIR)

$(OBJS_DIR)%.o:		$(SRCS_DIR)%.s
						@printf "$(_YELLOW)Generating libasm objects... %-33.33s\r$(_END)" $@
						@$(NA) $(NFLAGS) -I $(HEADER_DIR) -s $< -o $@
$(OBJSb_DIR)%.o:	$(SRCSb_DIR)%.s
						@printf "$(_YELLOW)Generating libasm objects... %-33.33s\r$(_END)" $@
						@$(NA) $(NFLAGS) -I $(HEADER_DIR) -s $< -o $@

$(OBJS_DIR):
					@mkdir -p $(OBJS_DIR)
$(OBJSb_DIR):
					@mkdir -p $(OBJSb_DIR)

# Phony #
.PHONY:				all, clean, fclean, re, bonus, re_bonus
