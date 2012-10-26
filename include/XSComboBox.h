#ifndef XSCOMBOBOX_H
#define XSCOMBOBOX_H

#include "osxstep.h"
#import <AppKit/AppKit.h>

@interface XSComboBox : NSComboBox
{
	id 		parent;
	void 	*wptr;
	cbptr_t	callback;
}
@property (assign) id parent;
@property (assign) void *wptr;
@property (assign) cbptr_t callback;

- (void)setCallback:(cbptr_t)cb;
- (int) doCallback:(void *)p1;

@end

#endif
