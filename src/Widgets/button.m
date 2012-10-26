/* 
 * ascii widgets library
 * Copyright(C) 2011 - rafael villordo
 * rvillordo@gmail.com
 * button.c
 */
#include <XSApplication.h>
#include <XSButton.h>
#include "osxstep.h"

button_t *button_create(widget_t *parent, float width, float height, float x, float y, char *text, int (*cbptr)(void *))
{
	id			window;
	XSButton	*_button;
	NSRect		frame = NSMakeRect(x, (parent->geometry.h - height) - y, width, height);
	widget_t 	*button;

	if(parent == NULL || ((window = (NSView *)parent->gptr) == NULL))
		return (NULL);
		
	button = (button_t *)widget_create(width, height, x, y, text, XS_WTYPE_BUTTON);
	button->type = XS_WTYPE_BUTTON;
	button->event[0] = cbptr;
	button->tag = hash(text, strlen(text)) + hash(button, sizeof(button_t));
	
	_button = [ [ XSButton alloc ] initWithFrame:frame];

	[ _button setBezelStyle:  NSSmallSquareBezelStyle];
	[ _button setTitle: [[NSString alloc] initWithUTF8String:text]];
	[ _button setAction:@selector(XSButtonCallback:)];
	[ _button setTarget:[[XSApplication sharedApplication] delegate]];
	[ _button setCallback:cbptr ];

	[ _button setParent:window];
	[ _button setWptr:button];

	[[ window contentView] addSubview: _button ];

	button->gptr = (void *)_button;

	widget_list_insert(parent, button);

	return (button);
}

checkbutton_t *checkbutton_create(widget_t *parent, float width, float height, float x, float y, char *text, int (*cbptr)(void *))
{
	id			window;
	XSButton	*_button;
	NSRect		frame = NSMakeRect(x, (parent->geometry.h - height) - y, width, height);
	widget_t 	*button;

	if(parent == NULL || ((window = (NSView *)parent->gptr) == NULL))
		return (NULL);
		
	button = (button_t *)widget_create(width, height, x, y, text, XS_WTYPE_BUTTON_CHECK);
	button->type = XS_WTYPE_BUTTON_CHECK;
	button->event[0] = cbptr;
	button->tag = hash(text, strlen(text)) + hash(button, sizeof(button_t));
	
	_button = [ [ XSButton alloc ] initWithFrame:frame];

	[ _button setFont:[NSFont systemFontOfSize:9]];
	[ _button setBezelStyle:  NSSmallSquareBezelStyle];
	[ _button setButtonType:NSSwitchButton];
	[ _button setTitle: [[NSString alloc] initWithUTF8String:text]];
	[ _button setAction:@selector(XSButtonCallback:)];
	[ _button setTarget:[[XSApplication sharedApplication] delegate]];
	[ _button setCallback:cbptr ];

	[ _button setParent:window];
	[ _button setWptr:button];

	[[ window contentView] addSubview: _button ];

	button->gptr = (void *)_button;

	widget_list_insert(parent, button);

	return (button);
}

radiobutton_t *radiobutton_create(widget_t *parent, float width, float height, float x, float y, char *text, int (*cbptr)(void *))
{
	id			window;
	XSButton	*_button;
	NSRect		frame = NSMakeRect(x, (parent->geometry.h - height) - y, width, height);
	widget_t 	*button;

	if(parent == NULL || ((window = (NSView *)parent->gptr) == NULL))
		return (NULL);
		
	button = (button_t *)widget_create(width, height, x, y, text, XS_WTYPE_BUTTON_RADIO);
	button->type = XS_WTYPE_BUTTON_RADIO;
	button->event[0] = cbptr;
	button->tag = hash(text, strlen(text)) + hash(button, sizeof(button_t));
	
	_button = [ [ XSButton alloc ] initWithFrame:frame];

	[ _button setFont:[NSFont systemFontOfSize:9]];
	[ _button setBezelStyle:  NSSmallSquareBezelStyle];
	[ _button setButtonType:NSRadioButton];
	[ _button setTitle: [[NSString alloc] initWithUTF8String:text]];
	[ _button setAction:@selector(XSButtonCallback:)];
	[ _button setTarget:[[XSApplication sharedApplication] delegate]];
	[ _button setCallback:cbptr ];
	[ _button setState:NO];

	[ _button setParent:window];
	[ _button setWptr:button];

	[[ window contentView] addSubview: _button ];

	button->gptr = (void *)_button;

	widget_list_insert(parent, button);

	return (button);
}

void button_set_text(button_t *button, char *text)
{
	XSButton *xbt = (XSButton *)button->gptr;
	if(xbt != nil) {
		[xbt setTitle:[[NSString alloc] initWithUTF8String:text]];
	}
}

void button_set_state(button_t *button, int state)
{
	XSButton *xbt = (XSButton *)button->gptr;
	if(xbt != nil) {
		[xbt setState:(state ? YES : NO )];
	}
}

void button_set_enabled(button_t *button, int enabled)
{	
	XSButton *xbt = (XSButton *)button->gptr;
	if(xbt != nil) {
		[xbt setEnabled:(enabled ? YES : NO )];
	}
}

void button_set_style(button_t *button, long style)
{
	XSButton *xbt = (XSButton *)button->gptr;
	if(xbt != nil) {
		[xbt setBezelStyle:style];
	}
}
