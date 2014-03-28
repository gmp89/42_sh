# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ymohl-cl <ymohl-cl@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2014/01/04 16:12:18 by ymohl-cl          #+#    #+#              #
#    Updated: 2014/03/27 22:31:57 by ymohl-cl         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = 42sh

LIBFT = -L libft/ -lft

LIBFTH = -I libft/

INC = -I includes/

WFT = make -C libft/

LIB = libshell.a

WLIB = -L. -lshell

CC = cc

CCB= llvm-gcc-4.2

GFLAG = -g3

FLAG = -Wall -Wextra -Werror

ADD = -ltermcap

INT_SRC =	ft_minishell.c \
			ft_check_key.c \
			ft_arrow_left_right.c \
			ft_up_down.c \
			get_winsize.c \
			add_new_char.c \
			position_cursor.c \
			l_list.c \
			ft_clean_thist.c \
			ft_create_hst.c \
			ft_del_keyword.c \
			ft_env.c \
			ft_filled_lste.c \
			ft_home.c \
			ft_print_commande.c \
			ft_print_fd.c \
			ft_print_lste.c \
			ft_read.c \
			ft_shift.c \
			ft_termios.c \
			ft_tputs.c \
			ft_write_on_file.c \
			get_next_line.c \
			ft_signum.c \
			ft_sigleton.c \
			ft_signal.c \
			ft_creat_string.c \
			ft_jumprint.c \

BLD_SRC =	ft_builtin.c \
			ft_env.c \
			env_tools.c \
			ft_echo.c \
			ft_unsetenv.c \
			ft_setenv.c \

PRC_SRC =	ft_lexer.c \
			ft_make_oplst.c \
			ft_split.c \
			is.c \
			ft_fill_tab.c \
			ft_create_tree.c \
			ft_read_tree.c \
			ft_opcode_tree.c \
			ft_execve.c \
			ft_ar_lft.c \
			ft_and.c \
			ft_or.c \
			ft_ar_rgt.c \
			ft_db_ar_rgt.c \
			ft_semicol.c \
			ft_pipe.c \
			ft_check_pipes.c \

INT_SRCS = $(addprefix int_src/, $(INT_SRC))
BLD_SRCS = $(addprefix bld_src/, $(BLD_SRC))
PRC_SRCS = $(addprefix prc_src/, $(PRC_SRC))
SRC += $(INT_SRCS)
SRC += $(BLD_SRCS)
SRC += $(PRC_SRCS)

OBJ = $(SRC:%.c=.obj/%.o)

.PHONY: all say clean fclean re createfolder

all: createfolder $(NAME)

.obj/%.o: %.c
	@$(CC) $(FLAG) -o $@ -c $< -I. $(LIBFTH) $(INC)
	@echo "\033[32m.\c\033[0m"

$(NAME): say $(OBJ)
	@ar rc $(LIB) $(OBJ)
	@ranlib $(LIB)
	@echo "\033[32m\tDONE !\033[0m"
	@$(WFT)
	@$(CC) $(FLAG) -o $(NAME) $(OBJ) $(ADD) $(WLIB) $(LIBFT) -I. $(INC)
	@echo "\033[32m  $(NAME) project is compiled !\033[0m"
	@echo ""
	cat -e auteur

say:
	@echo "\033[32m"
	@cat .logo
	@echo ""
	@echo "\c\033[0m"
	@echo "\033[33m  '.' == One file is compiled\t\033[0m"
	@echo "\033[33m  ' ' == make: Nothing to be done for 'all'\t\033[0m"
	@echo "\033[32m  $(LIB) compilation progress\t\c\033[0m"

gdb:
	cc $(FLAG) $(GFLAG) -o deb $(SRC) $(ADD) $(WLIB) $(LIBFT) $(INC) $(LIBFTH)
	gdb deb


clean:
	@rm -rf .obj
	@echo "\033[32m  Remove all objects from the $(LIB)\tDONE !\033[0m"

fclean: clean
	@$(WFT) fclean
	@rm -f $(NAME) $(LIB)
	@echo "\033[32m  Remove $(LIB) and $(NAME)\t\tDONE !\033[0m"

createfolder:
	@mkdir -p .obj
	@mkdir -p .obj/int_src
	@mkdir -p .obj/bld_src
	@mkdir -p .obj/prc_src

re: fclean all
