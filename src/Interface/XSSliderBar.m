#include <osxstep.h>
#import <XSSliderBar.h>

@implementation XSSliderBar 
@synthesize parent;
@synthesize wptr;
@synthesize callback;

- (id)initWithFrame:(NSRect)frame
{
	id _self = [super initWithFrame:frame];
	if(_self) {
		callback = nil;
		//[_self setMinValue:0];
		[_self setTarget:_self];
		[_self setAction:@selector(doCallback:)];
		//[_self setNumberOfTickMarks:1];
		//[_self setNumberOfMajorTickMarks:0];
	}
	return _self;
}

- (void) setCallback:(cbptr_t)cb
{
	callback = cb;
}

- (int)doCallback:(id)value
{
	int val = [value intValue];
	if(callback == nil)
		return 0;
	return (callback(&val));
}

- (void) setObjectValue:(id)value
{
	NSLog(@"setvalue: %d", [value intValue]);
}
@end

