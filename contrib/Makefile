#
# OSXstep - OSX Graphical Toolkit v0.1
#
# Copyright (c) 2012, rafael villordo
# rvillordo@gmail.com
#
#
CC				= gcc
DFLAGS			= -g3 -ggdb
CFLAGS			= -Wall -I../include/ -I../libcnary/include $(DFLAGS)
SOURCES			= main.c
TARGET			= osxstep

.PHONY: label clean

.SUFFIXES: .c .o

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@

all: 
	ln -sf ../libosxstep.dylib
	$(CC) $(CFLAGS) $(SOURCES) -o $(TARGET) libosxstep.dylib
	@mkdir -p osxstep.app/Contents/MacOS
	@mkdir -p osxstep.app/Contents/Resources/English.lproj
	@mv osxstep osxstep.app/Contents/MacOS/osxstep
	@cp ../libosxstep.dylib osxstep.app/Contents/MacOS/  && cp Info.plist osxstep.app/Contents/
	@#cp MainMenu.nib osxstep.app/Contents/Resources/English.lproj

clean: 
	-rm -rf $(OBJECTS) $(TARGET) $(TARGET_DYNAMIC) osxstep.app *.dSYM libosxstep.dylib
