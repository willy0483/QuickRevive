CC = gcc
AR = ar
I = -Iinclude
OPT = -O0
CFLAGS = -Wall -g $(I) $(OPT)

ROOT     = $(HOME)/.local
SRCDIR   = src
BUILDDIR = build
EXAMPLE  = example
LIBDIR 	 = $(BUILDDIR)/lib
EXEDIR   = $(BUILDDIR)/exe

NAME = quickrevive
STATIC = $(LIBDIR)/lib$(NAME).a

INC_INSTALL_DIR = $(ROOT)/include/$(NAME)
LIB_INSTALL_DIR = $(ROOT)/lib/

CFILES  = $(wildcard $(SRCDIR)/*.c)
OBJECTS = $(patsubst %.c, $(BUILDDIR)/%.o, $(notdir $(CFILES)))
BINARY = $(EXEDIR)/test

VPATH = $(dir $(CFILES))

.PHONY: all run clean debug

all: $(STATIC)

run: $(STATIC) $(BINARY)
	$(BINARY)

install: $(STATIC)
	mkdir -p $(INC_INSTALL_DIR)
	mkdir -p $(LIB_INSTALL_DIR)

	cp $(STATIC) $(LIB_INSTALL_DIR)
	cp include/quickrevive.h $(INC_INSTALL_DIR) 

uninstall:
	rm -f $(LIB_INSTALL_DIR)/lib$(NAME).a
	rm -rf $(INC_INSTALL_DIR)

$(BINARY): $(STATIC) $(EXAMPLE)/main.c | $(EXEDIR)
	$(CC) $(CFLAGS) $(EXAMPLE)/main.c -L$(LIBDIR) -l$(NAME) -o $@

$(STATIC): $(OBJECTS) | $(LIBDIR)
	$(AR) rcs $@ $^

$(BUILDDIR)/%.o: %.c | $(BUILDDIR)
	$(CC) $(CFLAGS) -c -o $@ $^

$(BUILDDIR):
	mkdir -p $(BUILDDIR)

$(LIBDIR):
	mkdir -p $(LIBDIR)

$(EXEDIR):
	mkdir -p $(EXEDIR)

clean:
	rm -rf $(BUILDDIR)

debug:
	@echo "Source files: $(CFILES)"
	@echo "Object files: $(OBJECTS)"
	@echo "VPATH:  $(VPATH)"
	@echo "Home path: $(HOME)"
