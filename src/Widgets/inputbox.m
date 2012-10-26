/* 
 * c widgets - 0.1alpha
 *
 * OSX C interface for fast and easy GUI development
 *
 * Copyright(C) 2011 - rafael villordo
 * rvillordo@gmail.com
 */

#include <XSApplication.h>
#include <XSTextInput.h>
#include "osxstep.h"

inputbox_t *inputbox_create(widget_t *parent, float width, float height, float x, float y, char *name, unsigned int type)
{
	id			view;
	NSRect		frame = NSMakeRect(x, (parent->geometry.h - height) - y, width, height);
	id			_input;

	if(type == 1)
		_input = (XSSecureInput *)[[XSSecureInput alloc] initWithFrame:frame];
	else 
		_input = (XSTextInput *)[[XSTextInput alloc] initWithFrame:frame];

	inputbox_t 	*input;

	if(parent == NULL || ((view = (NSView *)(parent->gptr)) == NULL))
		return (NULL);

	input = (inputbox_t *)widget_create(width, height, x, y, name, (type == XS_INPUT_NORMAL) ? XS_WTYPE_INPUTBOX:XS_WTYPE_INPUTBOX_PASSWORD);

	[_input setParent:view];
	[_input setWptr:input];

	[[view contentView] addSubview:_input];

	input->gptr 	= _input;

	widget_list_insert(parent, input);

	return (input);
}

void inputbox_set_max_length(widget_t *input, int length)
{
	XSTextInput *_input = (XSTextInput *)input->gptr;
	if(_input != nil) {
		[[_input format] setMaximumLength:length];
	}
}

void inputbox_set_text(widget_t *input, char *text)
{
	XSTextInput *_input = (XSTextInput *)input->gptr;
	if(_input != nil) {
		[[_input currentEditor] setString:[[NSString alloc] initWithUTF8String:text]];
	}
}

char *inputbox_get_text(widget_t *input)
{
	XSTextInput *_input = (XSTextInput *)input->gptr;
	if(_input != NULL) {
		return ((char *)[[_input getString] UTF8String]);
	}
	return (NULL);
}
