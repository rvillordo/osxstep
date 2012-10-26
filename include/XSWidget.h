#ifndef XSWIDGET_H
#define XSWIDGET_H

#include <osxstep.h>
#import <AppKit/AppKit.h>
#import <XSWindow.h>
#import <XSButton.h>
#import <XSLabel.h>
#import <XSTextInput.h>
#import <XSBox.h>
#import <XSTextFieldFormatter.h>

#define XS_WIDGET_WINDOW		0
#define XS_WIDGET_LABEL			1
#define XS_WIDGET_BUTTON		2
#define XS_WIDGET_INPUTBOX		3
#define XS_WIDGET_BOX			4
#define XS_WIDGET_TREELIST		5
	
@interface XSWidget : NSObject
{
	id 						parent;
	void 					*wptr;
	NSInteger				maxInputLength;
	NSFont					*defaultFont;
	NSColor					*backgroundColor;
	NSColor					*textColor;
	XSTextFieldFormatter 	*format;
	cbptr_t					callback;
}

@property (assign) id parent;
@property (assign) void *wptr;
@property (assign, retain) maxInputLength;
@property (assign) NSFont *defaultFont;
@property (assign) NSColor *backgroundColor;
@property (assign) NSColor *textColor;
@property (assign) XSTextFieldFormatter *format;
@property (assign) cbptr_t callback;

- (id)init;
- (id)initWithFrame:(NSRect)frame;
- (id)initWithFrame:(NSRect)frame andType:(NSInteger)type;

- (void)dealloc;

- (int)doCallback:(id)sender;
- (void)setCallback:(cbptr_t)cback;

- (NSString *)getString;

@end
#endif
