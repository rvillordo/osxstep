#include <osxstep.h>
#include <XSSliderBar.h>

sliderbar_t *sliderbar_create(widget_t *parent, float width, float height, float x, float y, float min, float max, cbptr_t cb)
{
	id				view ;
	NSRect			frame = NSMakeRect(x, y, width, height);
	XSSliderBar	*_slider = [[XSSliderBar alloc] initWithFrame:frame];
	sliderbar_t 	*slider;

	if(parent == NULL || ((view = (NSView *)(parent->gptr)) == NULL))
		return (NULL);

	slider = (sliderbar_t *)widget_create(width, height, x, y, NULL, XS_WTYPE_TREEVIEW);

	[_slider setParent:view];
	[_slider setWptr:slider];
	[_slider setMinValue:min];
	[_slider setMaxValue:max];
	[_slider setCallback:cb];

	[[view contentView] addSubview:_slider];

	slider->parent 	= parent;
	slider->gptr 	= _slider;

	widget_list_insert(parent, slider);

	return (slider);
}

void sliderbar_set_value(sliderbar_t *slider, float value)
{
	XSSliderBar *level = (XSSliderBar *)slider->gptr;
	[level setDoubleValue:value];
	[level setNeedsDisplay:YES];
}

float sliderbar_get_value(sliderbar_t *slider)
{
	XSSliderBar *level = (XSSliderBar *)slider->gptr;
	return ([[level value] doubleValue]);
}

void sliderbar_set_disable(sliderbar_t *slider)
{
	XSSliderBar *level = (XSSliderBar *)slider->gptr;
	[level setDoubleValue:[level maxValue]];
	[level setNeedsDisplay:YES];
}
