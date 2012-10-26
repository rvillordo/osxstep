#include <XSApplication.h>
#include <XSView.h>
#include "osxstep.h"

view_t *view_create(widget_t *parent, float width, float height, float x, float y, char *title, unsigned int flags)
{
	id		window;
	view_t 	*view;

	if(parent == NULL)
		return (NULL);

	window= (XSView *)parent->gptr;

	view = (view_t *)widget_create(width, height, x, y, title, XS_WTYPE_VIEW);
	y = (view->geometry.h - y);
	view->name = strdup(title);
	view->type = XS_WTYPE_VIEW;
	view->tag = hash(title, strlen(title)) + hash(view, sizeof(view_t));
	view->event[XS_EVENT_EXPOSE] = NULL;

	XSView *_view = [[XSView alloc] initWithFrame:NSMakeRect(x, y, width, height)];

	[_view setParent:window];
	[_view setWptr:view];

	view->parent = parent;
	view->gptr = _view;

	[[window contentView] addSubview:_view];

	widget_list_insert(parent, view);

	return (view);
}

void view_draw_line(widget_t *view, int lineWidth, long color, int x, int y, int xl, int yl)
{
	CGContextRef viewGC = [[NSGraphicsContext currentContext] graphicsPort];
	CGContextSetRGBStrokeColor(viewGC, 1.0, 2.8, 0.0, 1.0);
	CGContextSetLineWidth(viewGC, 1.0 * lineWidth);
	CGContextBeginPath(viewGC);
	CGContextMoveToPoint(viewGC, 1.0 * x, 1.0 * y);
	CGContextAddLineToPoint(viewGC, 1.0 * xl, 1.0 * yl);
	CGContextDrawPath(viewGC,kCGPathStroke);
}

void view_draw_rect(widget_t *view, int lineWidth, long color, int x, int y, int w, int h)
{
	NSRect r = NSMakeRect(x, y, w, h);
	CGContextRef viewGC = [[NSGraphicsContext currentContext] graphicsPort];
	CGContextSetRGBStrokeColor(viewGC, 0, 0.0, 0.00, 0.0);
	CGContextSetLineWidth(viewGC, 1.0 * lineWidth);
	CGContextBeginPath(viewGC);
	CGContextAddRect(viewGC,r);
}

void view_setFill(widget_t *view)
{
	XSView *_view = (view->gptr);
	[[_view backgroundColor] setFill];
}

void view_rectFill(widget_t *view)
{
	NSRectFill(NSMakeRect(view->geometry.x,view->geometry.y,view->geometry.w,view->geometry.h));
}
