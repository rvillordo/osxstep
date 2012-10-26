#include <XSComboBox.h>

@implementation XSComboBox
@synthesize parent;
@synthesize wptr;
@synthesize callback;

- (id) initWithFrame:(NSRect)frame
{
	id _self = [super initWithFrame:frame];
	if(_self) {
		[_self setDelegate:self];
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
	return (callback(p1));
}

- (void)comboBoxSelectionDidChange:(NSNotification *)notification
{
	callback((void *)[self wptr]);
}

@end


