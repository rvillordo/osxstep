#import <AppKit/AppKit.h>

@interface XSApplication : NSApplication
{
	BOOL 	shouldKeepRunning;
	NSFont	*defaultFont;
}
@property (assign) BOOL shouldKeepRunning;
@property (assign) NSFont *defaultFont;

- (void) run;
- (void) terminate:(id)sender;
- (void) onTick:(id)sender;

+ (XSApplication *)sharedApplication;

@end


