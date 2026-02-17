CC = gcc
AR = ar
INCDIRS = -Iinclude
OPT = -O0
CFLAGS = -Wall -g $(INCDIRS) $(OPT)

SRCDIR   = src
BUILDDIR = build
EXAMPLE  = example
LIBDIR 	 = $(BUILDDIR)/lib
EXEDIR   = $(BUILDDIR)/exe


NAME = quickrevive
STATIC = $(LIBDIR)/lib$(NAME).a

CFILES  = $(wildcard $(SRCDIR)/*.c)
OBJECTS = $(patsubst %.c, $(BUILDDIR)/%.o, $(notdir $(CFILES)))
BINARY = $(EXEDIR)/test

VPATH = $(dir $(CFILES))

.PHONY: all run clean debug

all: $(STATIC)

run: $(STATIC) $(BINARY)
	$(BINARY)

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
