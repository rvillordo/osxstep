#include <XSAppController.h>
#include <XSApplication.h>
#include <AppKit/NSMenuView.h>
#include <osxstep.h>

volatile NSAutoreleasePool 	*XStepPool;
XSApplication 		*_app;

int XSAppQuit(void)
{
	[_app performSelector:@selector(terminate:) withObject:nil];
	return (0);
}

struct default_menu {
	NSString *key;
	NSString *name;
	NSString *sel;
};

void XSAppInit(void)
{
	int i;

struct default_menu _fileMenu[] = {
	{ @"n", @"New", 		@"new:" },
  	{ @"o", @"Open", 		@"open:" },
	{ @"c", @"Close", 		@"close:" },
 	{ @"s", @"Save", 		@"save:" },
	{ @"a", @"Save as", 	@"saveas:" },
	{ @"",  @"separator", 	@"" },
	{ @"r", @"Reload", 		@"reload:" },
	{ nil, nil, 				nil }
};

struct default_menu _appMenu[] = {
	{ @"b", @"About", 		@"doAbout:" },
  	{ @"",  @"separator", 	@""			},
	{ @"q", @"Quit", 		@"doQuit:" },
	{ nil, nil, nil }
};
	XStepPool = [[NSAutoreleasePool alloc] init];
	XSAppController *app_controller = [[XSAppController alloc] init];
	NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
	Class principalClass = NSClassFromString([infoDictionary objectForKey:@"NSPrincipalClass"]);
	_app = (id)[principalClass sharedApplication];
	id item;
	/*NSString *mainNibName = [infoDictionary objectForKey:@"NSMainNibFile"];
	 *     NSNib *mainNib = [[NSNib alloc] initWithNibNamed:mainNibName bundle:[NSBundle mainBundle]];
	 *         [mainNib instantiateNibWithOwner:applicationObject topLevelObjects:nil];*/

	NSMenu *menubar = [[NSMenu new] autorelease];

	id appMenuItem = [[NSMenuItem new] autorelease];
	id appMenu = [[NSMenu new] autorelease];


	id fileMenuItem = [[[NSMenuItem alloc] init] autorelease];
	[fileMenuItem setTitle:@" File "];

	id fileMenu = [[NSMenu new] autorelease];

	[menubar addItem:appMenuItem];
	
	for(i = 0; _appMenu[i].name != nil; i++) {
		if ( [_appMenu[i].name isEqual:@"separator"] )  {
			item = [NSMenuItem separatorItem];
		}
		else {
			item = [[[NSMenuItem alloc] initWithTitle:_appMenu[i].name action:NSSelectorFromString(_appMenu[i].sel) keyEquivalent:_appMenu[i].key] autorelease]; 
			[item setTarget:app_controller];
		}
		[appMenu addItem:item];
	}

	[appMenuItem setSubmenu:appMenu];

	[menubar addItem:fileMenuItem];

	for(i = 0; _fileMenu[i].name != nil; i++) {
		if ( [_fileMenu[i].name isEqual:@"separator"] )  {
			item = [NSMenuItem separatorItem];
		}
		else {
			item = [[[NSMenuItem alloc] initWithTitle:_fileMenu[i].name action:NSSelectorFromString(_fileMenu[i].sel) keyEquivalent:_fileMenu[i].key] autorelease]; 
			[item setTarget:app_controller];
		}

		[fileMenu addItem:item];
	}
	[fileMenuItem setSubmenu:fileMenu];

	[appMenuItem setTitle:[[[NSString alloc] initWithString:@" app "] autorelease]];
	[menubar update];

	[_app setMainMenu:menubar];
	[_app setDelegate:app_controller];
}

void XSAddTimer(float waitinterval, float interval, widget_t *widget)
{
	NSDate *wait = [NSDate dateWithTimeIntervalSinceNow: waitinterval];
	NSTimer *timer = [[NSTimer alloc] initWithFireDate: wait
								interval: interval
								target:[_app delegate]
							    selector: @selector(onTick:)
								userInfo:(id)(widget->gptr)
								repeats:YES ];
	 [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
	 //[timer release];
};

int XSAppMain(screen_t *screen, int argc, const char **argv)
{
	ProcessSerialNumber ourPSN;

	GetCurrentProcess(&ourPSN);
	SetFrontProcess(&ourPSN);

		if ([_app respondsToSelector:@selector(run)]) {
			[_app performSelectorOnMainThread:@selector(run) 
								withObject:nil
								waitUntilDone:YES];
		}
	[XStepPool release];

	return (0);
}
