#import <XSTextInput.h>
#import <XSTextFieldFormatter.h>

@implementation XSSecureInput
@synthesize parent;
@synthesize wptr;
@synthesize format;

- (id) initWithFrame:(NSRect)frame
{
	id _self = [super initWithFrame:frame];
	format = [[XSTextFieldFormatter alloc] init];
	[format setMaximumLength:16];
	if(_self) {
		[super setFont:[NSFont systemFontOfSize:10]];
		[[_self cell] setLineBreakMode:NSLineBreakByClipping];
	}
	return (_self);
}

- (NSString *)getString
{
	NSText *tview = (NSText *)[self currentEditor];
	return ([tview string]);
}
@end

@implementation XSTextInput
@synthesize parent;
@synthesize wptr;
@synthesize format;

- (id) initWithFrame:(NSRect)frame
{
	id _self = [super initWithFrame:frame];
	format = [[XSTextFieldFormatter alloc] init];
	[format setMaximumLength:16];
	if(_self) {
		[super setFont:[NSFont systemFontOfSize:10]];
		[[_self cell] setLineBreakMode:NSLineBreakByClipping];
		[[_self cell] setFormatter:format];
	}

	return (_self);
}

- (void)dealloc
{
	[super dealloc];
}

- (NSString *)getString
{
	return ([[self cell] stringValue]);
}

@end


