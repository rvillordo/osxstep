#ifndef XSBUTTON_H
#define XSBUTTON_H

#include "osxstep.h"

@interface XSButton : NSButton
{
	id 		parent;
	void 	*wptr;
	cbptr_t	callback;
}
@property (assign) id parent;
@property (assign) void *wptr;
@property (assign) cbptr_t callback;

- (void) setCallback:(cbptr_t)cb;
- (int)doCallback:(void *)p1;

@end

#endif
