#import <osxstep.h>

@interface XSCell : NSCell
{
}

@end

@implementation XSCell 
{
}

- (id)init
{
	id _self = [super init];
	if(_self == nil)
		return (nil);
	return (_self);
}

- (id)initWithFrame:(NSRect)frame
{
	id _self = [super initWithFrame:frame];
	if(_self == nil)
		return (nil);

	[_self setFont:[NSFont systemFontOfSize:9]];
	return (_self);
}

@end

