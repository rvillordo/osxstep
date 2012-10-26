#ifndef XSTEXTFIELDFORMATTER_H
#define XSTEXTFIELDFORMATTER_H

#import <Cocoa/Cocoa.h>

@interface XSTextFieldFormatter : NSFormatter {
	int maxLength;
}
- (void)setMaximumLength:(int)len;
- (int)maximumLength;

@end

#endif

