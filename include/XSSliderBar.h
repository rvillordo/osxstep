#include <osxstep.h>

@interface XSSliderBar : NSSlider
{
	id parent;
	void *wptr;
	cbptr_t	callback;
}
@property (assign) id parent;
@property (assign) void *wptr;
@property (assign) cbptr_t callback;

- (void) setCallback:(cbptr_t)cb;
- (int)doCallback:(id)value;

@end;
