#include <osxstep.h>
#include <XSWindow.h>

@implementation XSWindow 
@synthesize parent;
@synthesize wptr;

- (id) init
{
	id _self = [super init];
	if(_self) {
	}
	return (_self);
}

- (void) dealloc
{
	[super dealloc];
}

- (BOOL) isFlipped
{
	return YES;
}

@end
