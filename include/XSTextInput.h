#ifndef XSTEXTINPUT_H
#define XSTEXTINPUT_H

#include <Cocoa/Cocoa.h>
#include <XSTextFieldFormatter.h>

@interface XSTextInput : NSTextField
{
	id parent;
	void *wptr;
	XSTextFieldFormatter *format;
}
@property (assign) id parent;
@property (assign) void *wptr;
@property (assign) XSTextFieldFormatter *format;

- (NSString *)getString;
@end

@interface XSSecureInput : NSSecureTextField
{
	id parent;
	void *wptr;
	XSTextFieldFormatter *format;
}
@property (assign) id parent;
@property (assign) void *wptr;
@property (assign) XSTextFieldFormatter *format;
- (NSString *)getString;
@end

#endif
