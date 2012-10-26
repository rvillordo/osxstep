#import <XSWidget.h>

@implementation XSWidget 
@synthesize parent;
@synthesize wptr;
@synthesize backgroundColor;
@synthesize textColor;
@synthesize format;
@synthesize defaultFont;
@synthesize callback;
@synthesize maxInputLength;

- (id)init
{
	id _self = [super init];
	if(_self) {
		parent = nil;
		wptr = nil;

		defaultFont = [NSFont systemFontOfSize:9];
		backgroundColor = [NSColor controlBackgroundColor];
		textColor = [NSColor blackColor];
		format = [[XSTextFieldFormatter alloc] init];
		[format setMaximumLength:16];
	}
	return (_self);
}

- (id)initWithFrame:(NSRect)frame
{
	id _self = [super initWithFrame:frame];
	if(_self) {
	}
	return (_self);
}

- (id)initWithFrame:(NSRect)frame andType:(NSInteger)type
{
	switch(type) {
		case XS_WIDGET_WINDOW:
		case XS_WIDGET_LABEL:
		case XS_WIDGET_BUTTON:
		case XS_WIDGET_INPUTBOX:
		case XS_WIDGET_BOX:
		case XS_WIDGET_TREELIST:
		default:
			break;
	}
}

- (void)dealloc
{
	[super dealloc];
}

- (int)doCallback:(id)sender
{
	widget_t *widget = [self wptr];
	return (widget->event[0]((void *)widget->name, (void *)widget));
}

- (NSString *)getString
{
	return ([[NSString alloc] initWithFormat:@"HEHEHEHE %d", 2]);
}

@end


