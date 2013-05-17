/* 
 * ascii widgets library - 0.1
 * Copyright(C) 2011 - rafael villordo
 * rvillordo@gmail.com
 *
 * widget basics
 *  - 
 */
#include <XSBox.h>
#include <Cocoa/Cocoa.h>
#include "osxstep.h"

unsigned int hash(void *ptr, unsigned int len)
{
	unsigned int crc = 0x123;
	while(len--) {
		crc += (*((unsigned char *)(ptr + len)) ^ (crc & 0xFF));
	}
	return (crc);
}

widget_t *widget_create(float width, float height, float x, float y, char *name, int type)
{
	char wtemp[64];
	static int widcount = 0;
	widget_t *wid = (widget_t *)malloc(sizeof(widget_t));

	snprintf(wtemp, 64, "widget%d", widcount++);
	if(name == NULL) 
		name = wtemp;
	wid->name = strdup(name);
	wid->geometry.w = width;
	wid->geometry.h = height;
	wid->geometry.x = x;
	wid->geometry.y = y;
	wid->type = type;
	wid->cwlist = NULL;
	wid->parent = NULL;
	wid->gptr = NULL;
	wid->tag = hash(name, strlen(name)) + hash(wid, sizeof(widget_t));
	return (wid);
}

void widget_destroy(widget_t *widget)
{
	if(widget == NULL)
		return;
	free(widget->name);
	free(widget);
}

void widget_set_title(widget_t *wid, char *title)
{
	if(wid == NULL) return;
	if(wid->name != NULL)
		free(wid->name);
	wid->name = (char *)malloc(strlen(title) + 1);
	memset(wid->name, 0x00, strlen(title));
	memcpy(wid->name, title, strlen(title));
}

void widget_sizeToFit(widget_t *wid)
{
	id p = wid->gptr;
	[p sizeToFit];
}

void widget_set_fontSize(widget_t *wid, int size)
{
	id p = (id)(wid->gptr);
	[p setFont:[NSFont systemFontOfSize:size]];
}

void widget_set_fontStyle(widget_t *wid, int style)
{
	id p = (id)(wid->gptr);
	if(style == XS_FONT_STYLE_BOLD) {
		[p setFont:[NSFont boldSystemFontOfSize:XS_FONT_SIZE_NORMAL]];
	}
}

void widget_set_event(widget_t *wid, int event, cbptr_t evCallback)
{
	if(event >= XS_EVENT_MAX) 
		return;
	wid->event[event] = evCallback;
}

void widget_list_insert(widget_t *list, widget_t *widget)
{
	widget->parent = list;
	list_add(&list->cwlist, list_init((void *)widget));
}

void widget_list_delete(widget_t *list, widget_t *item)
{
	list_del(&list->cwlist, list_search(&list->cwlist, (void *)item, NULL, LIST_SEARCH_ALL));
}

void widget_set_textColor(widget_t *widget, int _color)
{
	id  p;
	NSColor *color;
	p = (id)(widget->gptr);
	NSLog(@"set textColor widget: %@, color: %d", p, _color);
	switch(_color) {
		case XS_COLOR_BLACK:
			color = [NSColor blackColor];
			break;
		case XS_COLOR_RED:
			color = [NSColor redColor];
			break;
		case XS_COLOR_GREEN:
			color = [NSColor greenColor];
			break;
		case XS_COLOR_YELLOW:
			color = [NSColor yellowColor];
			break;
		case XS_COLOR_BLUE:
			color = [NSColor blueColor];
			break;
		case XS_COLOR_MAGENTA:
			color = [NSColor magentaColor];
			break;
		case XS_COLOR_CYAN:
			color = [NSColor cyanColor];
			break;
		case XS_COLOR_WHITE:
			color = [NSColor whiteColor];
			break;
		case XS_COLOR_GRAY:
			color = [NSColor grayColor];
			break;
		default:
			color = [NSColor clearColor];
			break;

	}
	[p setBackgroundColor:color];
	//[[p parent] setNeedsDisplay:YES];
}

void widget_set_backgroundColor(widget_t *widget, XS_COLOR_LIST _color)
{
	id  p;
	NSColor *color;
	p = (id)(widget->gptr);
	NSLog(@"set backgroundColor widget: %@, color: %d", p, _color);
	switch(_color) {
		case XS_COLOR_BLACK:
			color = [NSColor blackColor];
			break;
		case XS_COLOR_RED:
			color = [NSColor redColor];
			break;
		case XS_COLOR_GREEN:
			color = [NSColor greenColor];
			break;
		case XS_COLOR_YELLOW:
			color = [NSColor yellowColor];
			break;
		case XS_COLOR_BLUE:
			color = [NSColor blueColor];
			break;
		case XS_COLOR_MAGENTA:
			color = [NSColor magentaColor];
			break;
		case XS_COLOR_CYAN:
			color = [NSColor cyanColor];
			break;
		case XS_COLOR_WHITE:
			color = [NSColor whiteColor];
			break;
		case XS_COLOR_GRAY:
			color = [NSColor grayColor];
			break;
		default:
			color = [NSColor clearColor];
			break;

	}
	[p setBackgroundColor:color];
	//[[p parent] setNeedsDisplay:YES]; // update to OSX 10.7.5
}

void widget_set_update(widget_t *widget)
{
	id p = widget->gptr;
	[p setNeedsDisplay:YES];
}
