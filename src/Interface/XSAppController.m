#import <XSApplication.h>
#import <XSAppController.h>
#import <XSButton.h>
#import <XSLabel.h>
#import <XSView.h>

@implementation XSAppController 

- (IBAction) XSButtonCallback:(id)sender;
{
	XSButton *button = (XSButton *)sender;
	widget_t *wid = [button wptr];
	if(!wid->runInBackground) {
		[button doCallback:button];
	} else {
		[NSThread detachNewThreadSelector:@selector(doCallback:) toTarget:button withObject:button];
	}
}

- (IBAction)doQuit:(id)sender;
{
	[[XSApplication sharedApplication] performSelector:@selector(terminate:) withObject:sender];
}

- (void)doAbout:(id)sender
{
	NSAlert *alert = [NSAlert alertWithMessageText:@"osxstep 0.2" defaultButton:nil alternateButton:nil otherButton:nil informativeTextWithFormat:@"lero lero"];
	[alert runModal];
}

- (IBAction)onTick:(id)sender
{
	XSView *view;
	XSLabel *label;
	Class cla = [[sender userInfo] class];
	if (cla == [XSLabel class]) {
		label = (XSLabel *)[sender userInfo];
		widget_t *wid = [label wptr];
		wid->event[XS_EVENT_TICK](wid);
	} else if(cla == [XSView class]) {
		view = (XSView *)[sender userInfo];
		widget_t *wid = [view wptr];
		wid->event[XS_EVENT_TICK](wid);
	}
}

@end


