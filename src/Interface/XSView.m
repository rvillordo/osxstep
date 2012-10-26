#include <XSView.h>
#include <osxstep.h>

@implementation XSView
@synthesize	parent;
@synthesize wptr;

- (id)initWithFrame:(NSRect)frame
{
    id _self = [super initWithFrame:frame];
    if (_self) {
        backgroundColor = [NSColor cyanColor];
    }
    return _self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	cbptr_t callback = NULL;
	view_t *view;
	view = [self wptr];
	callback = view->event[XS_EVENT_EXPOSE];
	if(callback != NULL) {
		callback(view);
	} else {
		[backgroundColor setFill];
		NSRectFill(dirtyRect);
		[super drawRect:dirtyRect];
	}
}

- (void)setBackgroundColor:(NSColor *)color
{
    backgroundColor = color;
}

- (NSColor *)backgroundColor
{
    return (backgroundColor);
}

- (BOOL)isFlipped
{
	return YES;
}
@end
