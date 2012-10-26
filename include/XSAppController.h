#ifndef APPCONTROLLER_H
#define APPCONTROLLER_H

#include <AppKit/AppKit.h>

@interface XSAppController : NSObject <NSApplicationDelegate, NSWindowDelegate> 
{
	NSWindow	*window;
}
- (IBAction) XSButtonCallback:(id)sender;
- (IBAction) doQuit:(id)sender;
- (void) doAbout:(id)sender;

@end

#endif
