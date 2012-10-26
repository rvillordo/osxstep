#include <XSButton.h>
#import <XSAlertDialog.h>

@implementation XSButton 
@synthesize parent;
@synthesize wptr;
@synthesize callback;

- (id) initWithFrame:(NSRect)frame
{
	id _self = [super initWithFrame:frame];
	if(_self) {
		callback = nil;
	}
	return (_self);
}

- (void) dealloc
{
	[super dealloc];
}

- (void) setCallback:(cbptr_t)cb
{
	callback = cb;
}

- (int)doCallback:(void *)p1
{
	if(callback == nil)
		return 0;

	return (callback(p1));
}

@end


