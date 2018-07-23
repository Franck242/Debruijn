##
## EPITECH PROJECT, 2018
## deBruijn
## File description:
## Makefile for deBruijn
##

NAME		=	deBruijn

PACKAGE_NAME	=	deBruijn-exe #Name of repo create by `stack new` + '-exe'

STACK		=	stack

DIR_EXE		=	$(shell stack path --local-install-root )

all: $(NAME)

$(NAME):
	$(STACK) build
	cp $(DIR_EXE)/bin/$(NAME)-exe ./$(NAME)

clean:
	$(STACK) clean

fclean:
	$(RM) $(NAME)
	$(STACK) clean --full

re: fclean all

.PHONY: all clean fclean re
