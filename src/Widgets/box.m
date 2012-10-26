#include <XSApplication.h>
#include <XSBox.h>
#include "osxstep.h"

box_t *box_create(widget_t *parent, float width, float height, float x, float y, char *title, unsigned int flags)
{
	id		view;
	box_t 	*window;

	if(parent == NULL)
		return (NULL);

	view = (XSBox *)parent->gptr;

	window = (box_t *)widget_create(width, height, x, y, title, XS_WTYPE_BOX);
	window->name = strdup(title);
	window->type = XS_WTYPE_BOX;

	window->tag = hash(title, strlen(title)) + hash(window, sizeof(box_t));

	XSBox *box = [[XSBox alloc] init];

	[box setParent:view];
	[box setWptr:window];

	[box setTitle:[NSString stringWithUTF8String:title]];
	//[box setTitlePosition:NSAtBottom];
	y = (height - y);
	[box setFrameFromContentFrame:NSMakeRect(x, height - y, width, height)];
	//[[box titleCell] setNeedsUpdate:YES];
	
	[[view contentView] addSubview: box];

	window->gptr = (void *)box;

	widget_list_insert(parent, window);

	return (window);
}

char *box_get_title(box_t *box)
{
	XSBox *_box = (XSBox *)box->gptr;
	char *title = (char *)[[_box title] UTF8String];
	return (title);
}

void box_sizetofit(box_t *_box)
{
	XSBox *box = (XSBox *)(_box->gptr);
	[box sizeToFit];
}
