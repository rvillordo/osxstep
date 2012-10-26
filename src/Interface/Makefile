#
# OSXstep - OSX Graphical Toolkit v0.1
#
# Copyright (c) 2012, rafael villordo
# rvillordo@gmail.com
#
#
include			../../config.mk

SOURCES			= XSApplication.m XSAppController.m \
				  XSWindow.m XSBox.m XSAlertDialog.m \
				  XSButton.m XSLabel.m XSTextInput.m \
				  XSTextFieldFormatter.m XSComboBox.m \
				  FilesystemItem.m XSTree.m XSTreeData.m \
				  XSTable.m XSProgressBar.m XSView.m XSListItem.m \
				  XSSliderBar.m

OBJECTS=$(SOURCES:.m=.o)

.PHONY: all

.SUFFIXES: .m .o
.m.o:
	@echo "\t[CC $<]";
	@$(CC) $(CFLAGS) -c $< -o $@

all: $(OBJECTS)
	@echo [LD XSInterface.o ...];
	@$(LD) -r -o XSInterface.o $(OBJECTS)

clean: 
	-rm -rf $(OBJECTS)

