#import <Cocoa/Cocoa.h>
#import <osxstep.h>

@interface XSView : NSView
{
	id				parent;
	void 			*wptr;
    NSColor 		*backgroundColor;
	CGContextRef    viewGC;

}
@property (assign) id parent;
@property (assign) void *wptr;

- (id)initWithFrame:(NSRect)frame;
- (void)drawRect:(NSRect)dirtyRect;
- (void)setBackgroundColor:(NSColor *)color;
- (NSColor *)backgroundColor;

@end
