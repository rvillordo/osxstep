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
		[_self setFloatVal:0.0];
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
	float val = [value floatValue];
	[self setFloatVal:val];
	if(callback == nil)
		return 0;
	return (callback(&val));
}

- (void) setFloatVal:(float)value
{
	self.floatValue=value;
}

- (float)getFloatVal
{
	return self.floatValue;
}

@end

