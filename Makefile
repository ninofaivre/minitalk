# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nino <nino@student.42.fr>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/09/04 10:00:05 by nino              #+#    #+#              #
#    Updated: 2021/10/18 15:18:28 by nino             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC = clang

FLAGS = -Wall -Wextra -Werror

LIBFTPRINTF_DIR = ./ft_printf

MANDATORY_DIR = ./srcs/mandatory
BONUS_DIR = ./srcs/bonus

NAME = client
NAME2 = server
OBJS = $(NAME) $(NAME2)

all: $(NAME) $(NAME2)

$(NAME):
	@make -C $(LIBFTPRINTF_DIR)
	@$(CC) -o $(NAME) $(FLAGS) $(addprefix $(MANDATORY_DIR)/, $(NAME).c) $(addprefix $(LIBFTPRINTF_DIR)/, libftprintf.a)
	@echo "compiling $(NAME).c libftprintf.a to $(NAME)"

$(NAME2):
	@$(CC) -o $(NAME2) $(FLAGS) $(addprefix $(MANDATORY_DIR)/, $(NAME2).c) $(addprefix $(LIBFTPRINTF_DIR)/, libftprintf.a)
	@echo "compiling $(NAME2).c libftprintf.a to $(NAME2)"

bonus:
	@make -C $(LIBFTPRINTF_DIR)
	@$(CC) -o client $(FLAGS) $(addprefix $(BONUS_DIR)/, client_bonus.c) $(addprefix $(LIBFTPRINTF_DIR)/, libftprintf.a)
	@echo "compiling $(NAME)_bonus.c libftprintf.a to $(NAME)"
	@$(CC) -o server $(FLAGS) $(addprefix $(BONUS_DIR)/, server_bonus.c) $(addprefix $(LIBFTPRINTF_DIR)/, libftprintf.a)
	@echo "compiling $(NAME2)_bonus.c libftprintf.a to $(NAME2)"

clean:
	@rm -f $(OBJS)
	@make clean -C $(LIBFTPRINTF_DIR)
	@echo "removing ${OBJS}"

fclean: clean
	@make fclean -C $(LIBFTPRINTF_DIR)

re: fclean all

.PHONY: fclean re norme all clean
