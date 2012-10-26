#include <osxstep.h>

@implementation XSProgressBar 
@synthesize parent;
@synthesize wptr;

- (id)initWithFrame:(NSRect)frame
{
	id _self = [super initWithFrame:frame];
	if(_self) {
     	[_self setStyle:NSProgressIndicatorSpinningStyle];
	    [_self setIndeterminate:YES];
		[_self setBezeled:NO];
		[_self setMinValue:0];
		[_self setMaxValue:100];
		[_self setDisplayedWhenStopped:YES];
		[_self setHidden:NO];
	}
	return _self;
}

- (void) dealloc
{
	[super dealloc];
}

@end


