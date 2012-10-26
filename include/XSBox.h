#ifndef XSBOX_H
#define XSBOX_H

#include <osxstep.h>

@interface XSBox : NSBox
{
	id 						parent;
	void 					*wptr;
	NSFont					*defaultFont;
	NSColor					*backgroundColor;
}
@property (assign) id 		parent;
@property (assign) void 	*wptr;
@property (assign) NSFont 	*defaultFont;
@property (assign) NSColor 	*backgroundColor;

- (id)init;
- (void)drawRect:(NSRect)frame;

@end

#endif
