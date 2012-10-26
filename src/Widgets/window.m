#include <XSApplication.h>
#include <XSWindow.h>
#include <AppKit/AppKit.h>
#include "osxstep.h"

@interface HTableView : NSTableView <NSTableViewDelegate, NSTableViewDataSource>
@end

@implementation HTableView 

- (id) initWithFrame:(NSRect)frame
{
	id _self = [super initWithFrame:frame];
	if(_self) {
	}

	return (_self);
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
	printf("NUM ROwS 4\n");
	return 4;
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn    *)aTableColumn row:(NSInteger)rowIndex
{
	if([[aTableColumn identifier] isEqual:@"Col1"]) {
		return @"okay col 1";
	} else {
		return @"OKAY";
	}
}
@end 

window_t *window_create(widget_t *parent, float width, float height, float x, float y, char *title, unsigned long flags)
{
	window_t 	*window;

	if(parent == NULL)
		return (NULL);

	window = (window_t *)widget_create(width, height, x, y, title, XS_WTYPE_WINDOW);
	window->name = strdup(title);
	window->type = XS_WTYPE_WINDOW;

	window->tag = hash(title, strlen(title)) + hash(window, sizeof(window_t));

	NSRect frame = NSMakeRect(x, y, width, height);
	XSWindow *win = [[XSWindow alloc] initWithContentRect:frame
												styleMask:NSTitledWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask //NSResizableWindowMask|NSClosableWindowMask
											  //styleMask:NSBorderlessWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask
												  backing:NSBackingStoreBuffered defer:NO];
	[win setHasShadow:YES];
	[win setTitle:[[NSString alloc] initWithUTF8String:title]];
	[win makeKeyAndOrderFront:[XSApplication sharedApplication]];
	[win setWptr:win];

	window->gptr = (void *)win;

	widget_list_insert(parent, window);

	return (window);
}

void window_set_bgcolor(window_t *w, unsigned char color)
{
	NSWindow *window = (NSWindow *)w->gptr;
	switch(color) {
		case XS_COLOR_BLACK:
  [window setBackgroundColor:[NSColor blackColor]];
  break;
		case XS_COLOR_WHITE:
  [window setBackgroundColor:[NSColor whiteColor]];
  break;
		case XS_COLOR_GRAY:
 [window setBackgroundColor:[NSColor grayColor]]; 
 break;
		case XS_COLOR_RED:
[window setBackgroundColor:[NSColor redColor]];
break;
		case XS_COLOR_YELLOW:
   [window setBackgroundColor:[NSColor yellowColor]];
   break;
		case XS_COLOR_GREEN:
  [window setBackgroundColor:[NSColor greenColor]];
  break;
		case XS_COLOR_BLUE:
 [window setBackgroundColor:[NSColor blueColor]];
 break;
	}
}

