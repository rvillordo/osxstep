#include <osxstep.h>

@interface XSProgressBar : NSProgressIndicator
{
	id parent;
	void *wptr;
}
@property (assign) id parent;
@property (assign) void *wptr;

@end;
