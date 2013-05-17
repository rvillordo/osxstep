# OSXstep - OSX Graphical Toolkit v0.3
# Copyright (c) 2011, rafael villordo
# rvillordo@gmail.com
#
CC				= gcc
DFLAGS			= -g3 -ggdb 
CFLAGS			= -Wall -I./include/ -I../include -I../../include -I./libcnary/include -I../libcnary/include -I../../libcnary/include $(DFLAGS) 
TARGET_STATIC	= libosxstep.a
TARGET_DYNAMIC	= libosxstep.dylib 
AR				= ar rcs
RANLIB			= ranlib -L
LDFLAGS_DYNAMIC	= -dynamiclib -framework AppKit -install_name @executable_path/$(TARGET_DYNAMIC) 
