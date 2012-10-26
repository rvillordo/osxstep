#include <osxstep.h>
#include <XSProgressBar.h>

progressbar_t *progressbar_create(widget_t *parent, float width, float height, float x, float y, float min, float max, unsigned int type)
{
	id				view ;
	NSRect			frame = NSMakeRect(x, y, width, height);
	XSProgressBar	*_progress = [[XSProgressBar alloc] initWithFrame:frame];
	progressbar_t 	*progress;

	if(parent == NULL || ((view = (NSView *)(parent->gptr)) == NULL))
		return (NULL);

	progress = (progressbar_t *)widget_create(width, height, x, y, NULL, XS_WTYPE_TREEVIEW);

	[_progress setParent:view];
	[_progress setWptr:progress];
	[_progress setMinValue:min];
	[_progress setMaxValue:max];
	[_progress setUsesThreadedAnimation:NO];

	if(type == XS_WTYPE_PROGRESS_ROUND) {
		[_progress setIndeterminate:YES];
		[_progress setStyle:NSProgressIndicatorSpinningStyle];
	}else  {
		[_progress setIndeterminate:NO];
		[_progress setStyle:NSProgressIndicatorBarStyle];
	}

	[[view contentView] addSubview:_progress];

	progress->parent 	= parent;
	progress->gptr 		= _progress;

	widget_list_insert(parent, progress);

	return (progress);
}

void progressbar_set_value(progressbar_t *progress, float value)
{
	XSProgressBar *level = (XSProgressBar *)progress->gptr;
	[level setDoubleValue:value];
	[level setNeedsDisplay:YES];
}

float progressbar_get_value(progressbar_t *progress)
{
	XSProgressBar *level = (XSProgressBar *)progress->gptr;
	return ([[level value] doubleValue]);
}

void progressbar_set_disable(progressbar_t *progress)
{
	XSProgressBar *level = (XSProgressBar *)progress->gptr;
	[level setDoubleValue:[level maxValue]];
	[level setNeedsDisplay:YES];
}
