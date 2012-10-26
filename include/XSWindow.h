#ifndef XSWINDOW_H
#define XSWINDOW_H

#include <osxstep.h>

@interface XSWindow : NSWindow
{
	id parent;
	void *wptr;
}
@property (assign) id parent;
@property (assign) void *wptr;

- (id)init;
- (void)dealloc;

@end

#endif
