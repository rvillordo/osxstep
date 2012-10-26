#
# OSXstep - OSX Graphical Toolkit v0.1
#
# Copyright (c) 2012, rafael villordo
# rvillordo@gmail.com
#
#
include			config.mk

SRC=				combobox.m inputbox.m treeview.m progress.m sliderbar.m widget.m window.m screen.m button.m table.m label.m alert.m box.m view.m

#SOURCES			= src/Widgets/widget.m src/Widgets/screen.m src/Widgets/box.m \
				  src/Widgets/inputbox.m src/Widgets/label.m src/Widgets/combobox.m \
				  src/Widgets/window.m src/Widgets/button.m src/Widgets/alert.m src/Widgets/table.m \
				  src/Widgets/treeview.m src/Widgets/progress.m \
				  src/dllist.m src/main.m

SOURCES = $(SRC:%.m=src/Widgets/%.m)

OBJECTS=$(SOURCES:.m=.o) src/dllist.o src/main.o
INTERFACE_OBJECTS = src/Interface/XSInterface.o 

.PHONY: dyn static interface contrib

.SUFFIXES: .m

.m.o:
	@echo "\t[CC $<]";
	@$(CC) $(CFLAGS) -c $< -o $@

all: interface dyn contrib

dyn: $(OBJECTS)
	@echo "[building executable ...]";
	$(CC) $(OBJECTS) $(INTERFACE_OBJECTS) $(LDFLAGS_DYNAMIC) -o $(TARGET_DYNAMIC)

static: $(OBJECTS)
	@$(AR) $(TARGET_STATIC) $(OBJECTS)
	@$(RANLIB) $(TARGET_STATIC)

interface:
	@echo "[osxstep building interface ...]";
	make -C src/Interface

contrib:
	#@mkdir -p ./contrib/osxstep.app/Contents/MacOS
	#@$(CC) $(CFLAGS) contrib/main.c -o contrib/osxstep.app/Contents/MacOS/osxstep libosxstep.dylib 
	#@cp ./libosxstep.dylib ./contrib/osxstep.app/Contents/MacOS/
	#@cp ./contrib/Info.plist ./contrib/osxstep.app/Contents/
	make -C contrib 

clean: 
	-rm -rf $(OBJECTS) main $(TARGET_STATIC) $(TARGET_DYNAMIC) contrib/osxstep.app/Contents/MacOS
	make -C src/Interface/ clean
	make -C contrib/ clean

