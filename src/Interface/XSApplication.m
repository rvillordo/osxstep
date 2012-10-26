/*
 * osxstep - 0.1
 *
 * copyright (c) 2012, rafael villordo
*/
#import <XSAppController.h>
#import <XSApplication.h>

@implementation XSApplication
@synthesize shouldKeepRunning;
@synthesize defaultFont;

- (void)run
{
	NSEvent *event;
	[[NSNotificationCenter defaultCenter]
			postNotificationName:NSApplicationWillFinishLaunchingNotification
						  object:NSApp];
		[[NSNotificationCenter defaultCenter]
			postNotificationName:NSApplicationDidFinishLaunchingNotification
						  object:NSApp];
	do
	{
		event =
			[self
			nextEventMatchingMask:NSAnyEventMask
						untilDate:[NSDate distantFuture]
						   inMode:NSDefaultRunLoopMode
						  dequeue:YES];
		[self sendEvent:event];
		[self updateWindows];
		NSLog(@"event: %@", event);
	} while (shouldKeepRunning);
}

- (void)terminate:(id)sender
{
	shouldKeepRunning = NO;
}

- (void)onTick:(id)sender
{
}

+ (id)sharedApplication
{
	return (id)[NSApplication sharedApplication]; //[NSApplication sharedApplication];
}

@end
