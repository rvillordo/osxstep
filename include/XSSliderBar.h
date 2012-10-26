#include <osxstep.h>

@interface XSSliderBar : NSSlider
{
	id parent;
	void *wptr;
	float floatValue;
	cbptr_t	callback;
}
@property (assign) id parent;
@property (assign) void *wptr;
@property (assign) cbptr_t callback;

- (void) setCallback:(cbptr_t)cb;
- (int)doCallback:(id)value;
- (void)setFloatVal:(float)value;
- (float)getFloatVal;


@end;
