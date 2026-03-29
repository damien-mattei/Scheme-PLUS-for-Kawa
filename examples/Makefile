# example of Makefile for Scheme+ for Kawa
# Makefile for back-propagation program
# author: Damien Mattei

# tree structure directories:
# .
# Makefile
# kawa/*+.scm source code
# kawa/$MODULE_DIRECTORY/*+.scm modules

SHELL := /bin/bash

SCHEME=kawa

# path to Scheme+ for kawa directory
SCHEME_PLUS_FOR_KAWA=..

# Scheme+ for Kawa parser
PARSER:=$(SCHEME_PLUS_FOR_KAWA)/curly-infix2prefix4kawa.scm

PARSER_COMMAND=$(SCHEME) $(PARSER)

PARSER_OPTIONS=--srfi-105

PARSER_OPTIONS_MAIN=--kawa $(PARSER_OPTIONS) # allow more compatibility with Kawa syntax (different from Scheme)

# sub directory where parsed module files will be generated
MODULE_DIRECTORY=output_files_directory

# sub directory where Java/Jakarta classes files will be generated
CLASSES_DIRECTORY=classes_files_directory

# find the system directory for Kawa modules
#SITE_DIR=

# Scheme+ program to be parsed
SOURCES=$(wildcard *+.rkt *+.scm)

# Scheme programs to create by parsing the Scheme+ files
OBJECT=$(addprefix $(MODULE_DIRECTORY)/,$(SOURCES))


# Create OBJECT list with CLASSES_DIRECTORY prefix
#OBJECTS = $(addprefix $(CLASSES_DIRECTORY)/, $(SOURCES:.scm=.class))
# Results: CLASSES_DIRECTORY/file1.class CLASSES_DIRECTORY/file2.class CLASSES_DIRECTORY/file3.class

OBJECTS = $(CLASSES_DIRECTORY)/exo_retropropagationNhidden_layers_matrix_v2_by_vectors4kawa+.class

# create directory, build objects
# note: object modules have the basename of the source file with removing of the + character  and can be in different directories or in the same
all: $(MODULE_DIRECTORY) $(OBJECT) $(OBJECTS) 


# create the sub directory where some parsed module files will be
$(MODULE_DIRECTORY) :
	mkdir $@

# create the sub directory where some classes files will be
$(CLASSES_DIRECTORY) :
	mkdir $@


# if an error occur and the file is empty it will stop further Makefile call so i remove it:

#.DELETE_ON_ERROR:

# create Scheme files (*+.scm) in MODULE_DIRECTORY by parsing Scheme+ files (*+.scm) in current directory
$(MODULE_DIRECTORY)/%+.scm : %+.scm
	@echo PARSING $< :
	$(PARSER_COMMAND) $(PARSER_OPTIONS_MAIN) $< | tr -d '|' > $@


$(CLASSES_DIRECTORY)/%+.class : $(MODULE_DIRECTORY)/%+.scm
	@echo COMPILING $< :
	$(SCHEME) --main -d $(CLASSES_DIRECTORY) -C $<


clean:
	rm -rf $(OBJECT)
	rm -rf $(MODULE_DIRECTORY)
	rm -rf $(CLASSES_DIRECTORY)

# install:
# 	cp $(MODULES) $(SITE_DIR)

