# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nfaivre <nfaivre@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/09/04 10:00:05 by nino              #+#    #+#              #
#    Updated: 2021/11/30 23:13:59 by nfaivre          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

.DEFAULT_GOAL = all

NAME = client server

CC = clang
CFLAGS = -Wall -Werror -Wextra

DIR_SRC = src
DIR_OBJ = .obj

INCLUDE = -Ift_printf/include

SRC = $(wildcard $(DIR_SRC)/*.c)
OBJ = $(addprefix $(DIR_OBJ)/, $(notdir $(SRC:.c=.o)))

mkdir_DIR_OBJ:
	mkdir -p $(DIR_OBJ)

$(DIR_OBJ)/%.o : $(DIR_SRC)/%.c
	$(CC) $(CFLAGS) -o $@ -c $< $(INCLUDE)

$(NAME):
	make -C ft_printf
	$(CC) $(CFLAGS) $(word 1, $(OBJ)) -o $(word 1, $(NAME)) -Lft_printf -l:libftprintf.a
	$(CC) $(CFLAGS) $(word 2, $(OBJ)) -o $(word 2, $(NAME)) -Lft_printf -l:libftprintf.a

all: mkdir_DIR_OBJ $(OBJ) $(NAME)

bonus: all

clean:
	make $@ -C ft_printf
	rm -f $(OBJ)

fclean: clean
	make $@ -C ft_printf
	rm -f $(NAME)
	rm -rf $(DIR_OBJ)

re: fclean all

.PHONY: all clean fclean re
