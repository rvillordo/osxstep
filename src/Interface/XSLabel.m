#import <XSLabel.h>
#import <XSApplication.h>

@implementation XSLabel

- (id) initWithFrame:(NSRect)frame
{
	id _self = [super initWithFrame:frame];
	if(_self) {
		//[super setFont:[[XSApplication sharedApplication] defaultFont]]; //[NSFont systemFontOfSize:9]];
		[[_self cell] setLineBreakMode:NSLineBreakByClipping];
		[[_self cell] setDrawsBackground:YES];
		[[_self cell] setEditable:NO];
		[[_self cell] setEnabled:NO];
		[[_self cell] setWraps:NO];
		[_self setBordered:NO];
	}
	return (_self);
}

- (void)dealloc
{
	[super dealloc];
}

- (NSString *)getString
{
	NSText *tview = (NSText *)[self currentEditor];
	return ([tview string]);
}
@end


