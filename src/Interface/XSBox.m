#import <Cocoa/Cocoa.h>
#import <XSBox.h>

@implementation XSBox 
@synthesize parent;
@synthesize wptr;
@synthesize defaultFont;
@synthesize backgroundColor;

-(id)init
{
	id _self = [super init];
	if(_self) {
		[_self setFillColor:[NSColor whiteColor]];
		[_self setBorderColor:[NSColor whiteColor]];
		[_self setBoxType:NSBoxSecondary];
		[_self setBorderWidth:2];
		[_self setBorderType:NSGrooveBorder];
		[_self setTitlePosition:NSAtTop];
		[_self setCornerRadius:6.0];
		[[_self titleCell] setTextColor:[NSColor blackColor]];
	}
	return (_self);
}

- (BOOL)isTransparent
{
	return NO;
}

- (BOOL)isFlipped
{
	return NO;
}

- (void)drawRect:(NSRect)frame
{
	[super drawRect:frame];
	//NSRect rect = [[self titleCell] titleRectForBounds:[[self titleCell] drawingRectForBounds:frame]];
	//[super drawRect:frame];
	//rect.origin.x = 3;
	//[[self titleCell] drawWithFrame:rect inView:[self contentView]];
}

- (void)setBackgroundColor:(NSColor *)color
{
	backgroundColor = color;
}

- (NSColor *)backgroundColor
{
	return backgroundColor;
}
@end


