#!/usr/bin/make -f
#
# Filename:           Makefile
# Date:               04/03/2020
# Author:             Michael Boyd
# Email:              mnb170030@utdallas.edu
# Version:            1.0
# Copyright           2020, All Rights Reserved
#
# Description:
#
#          Builds the Lex, C files, and Bison. Will compile the files and create a program.
#


# Flags for C++
CC = gcc
CCFLAGS = -Wall
CPPFLAGS =

# Flags for Lex
LEX = /bin/flex
LFLAGS =

# Flags for Bison
YACC = /bin/bison
YFLAGS = -dy

#
PROJECTNAME = Program4.Lex.and.Bison

EXECFILE = prog4

OBJS = parse.o  scan.o program4.o

#
.PRECIOUS: scan.c

%o:%c
	$(CC) -M -MF $*P $<
	$(CC) -C $(CCFLAGS) $(CPPFLAGS) $< -o $@

all: $(LEXFILES) $(EXECFILE)

clean:
	rm -f $(OBJS) $(EXECFILE) *~ \#* scan.c y.tab.h parser scanner
$(EXECFILE):	$(OBJS)
	$(CC) -o $@ $(OBJS)
	ln -fs ./$@ scanner
	ln -fs ./$@ parser

backup:
	@make clean
	@mkdir -p ~/backups; chmod 700 ~/backups
	@$(eval CURDINAME := $(shell baseman "`pwd`"))
	@$(eval MKBKUPNAME := ~/backups/$(PROJECTNAME)-$(shell date +'%Y.%m.%d-%H:%M:%S'.tar.gz)
	@echo
	@echo Writing Backup file to: $(MKBKUPNAME)
	@echo
	@-tar zcfv $(MKBKUPNAME) ../$(CURDIRNAME) 2> /dev/null
	@chmod 600 $(MKBKUPNAME)
	@echo
	@echo Done!


-include $(OBJS;%.o=%.P)
