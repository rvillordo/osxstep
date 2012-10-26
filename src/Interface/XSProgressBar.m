#include <osxstep.h>
#import <XSProgressbar.h>

@implementation XSProgressBar 
@synthesize parent;
@synthesize wptr;

- (id)initWithFrame:(NSRect)frame
{
	id _self = [super initWithFrame:frame];
	if(_self) {
		//[_self setMinValue:0];
		[_self setHidden:NO];
		//[_self setNumberOfTickMarks:1];
		//[_self setNumberOfMajorTickMarks:0];
	}
	return _self;
}
@end

