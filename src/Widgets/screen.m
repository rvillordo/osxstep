#include "osxstep.h"
#include <Cocoa/Cocoa.h>

screen_t *screen_create(float width, float height)
{
	screen_t *screen;
	NSRect usableScreenRect;
	NSSize size;
	NSPoint point;
	char	 *desktop = "desktop";

	usableScreenRect = [[[NSScreen screens] objectAtIndex:0] visibleFrame];
	size = usableScreenRect.size;
	point = usableScreenRect.origin;

	screen = (screen_t *)widget_create(size.width,size.height,point.x,point.y, desktop, XS_WTYPE_SCREEN);

	screen->parent = NULL;
	screen->cwlist = NULL;

	return(screen);
}
