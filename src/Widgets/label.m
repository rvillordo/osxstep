/* 
 * c widgets - 0.1alpha
 *
 * OSX C interface for fast and easy GUI development
 *
 * Copyright(C) 2011 - rafael villordo
 * rvillordo@gmail.com
 */

#include <XSApplication.h>
#include <XSLabel.h>

#include "osxstep.h"

label_t *label_create(widget_t *parent, float width, float height, float x, float y, char *text, unsigned int type)
{
	id			view ;
	NSRect		frame = NSMakeRect(x, (parent->geometry.h - height) - y, width, height);
	XSLabel		*_input = [[XSLabel alloc] initWithFrame:frame];
	label_t 	*input;

	if(parent == NULL || ((view = (NSView *)(parent->gptr)) == NULL))
		return (NULL);

	input = (label_t *)widget_create(width, height, x, y, text, XS_WTYPE_LABEL);

	[_input setParent:view];
	[_input setWptr:input];

	[_input setBackgroundColor:[NSColor controlColor]];

	[[_input cell] setStringValue:[[NSString alloc] initWithUTF8String:text]];
	if(type == XS_LABEL_SMALL) {
		[[_input cell] setFont:[NSFont systemFontOfSize:XS_FONT_SIZE_SMALL]];
	} else if(type == XS_LABEL_NORMAL) {
		[[_input cell] setFont:[NSFont systemFontOfSize:XS_FONT_SIZE_NORMAL]];
	} else {
		[[_input cell] setFont:[NSFont systemFontOfSize:XS_FONT_SIZE_BIG]];
	}

	[_input sizeToFit];

	[[view contentView] addSubview:_input];

	input->parent 	= parent;
	input->gptr 	= _input;

	widget_list_insert(parent, input);

	return (input);
}

void label_set_text(widget_t *input, char *text)
{
	XSLabel *_input = (XSLabel *)input->gptr;
	if(_input != nil) {
		[[_input cell] setStringValue:[[NSString alloc] initWithUTF8String:text]];
	}
	[_input sizeToFit];
	[_input setNeedsDisplay:YES];
}

char *label_get_text(widget_t *input)
{
	XSLabel *_input = (XSLabel *)input->gptr;
	if(_input != NULL) {
		return ((char *)[[_input getString] UTF8String]);
	}
	return (NULL);
}
