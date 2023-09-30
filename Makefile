TEMPLATEROOT = ../

# compilation flags for gdb

CFLAGS  += -O0 -g
ASFLAGS += -g 

# object files

OBJS=  $(STARTUP) example.o

# include common make file

include $(TEMPLATEROOT)/Makefile.common
