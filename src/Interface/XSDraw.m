#include <osxstep.h>

@implementation XSView
@synthesize	parent;
@synthesize wptr;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        backgroundColor = [NSColor greenColor];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [backgroundColor setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
}

- (void)setBackgroundColor:(NSColor *)color
{
    backgroundColor = color;
}

- (NSColor *)backgroundColor
{
    return (backgroundColor);
}

@end
