#ifndef OSXSTEP_H
#define OSXSTEP_H

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/time.h>
#include <sys/select.h>
#include <sys/termios.h>
#include <stdarg.h>
#include <signal.h>

#define true	1
#define false	0

#ifdef __OBJC__
#include <AppKit/AppKit.h>
#endif

typedef int (*cbptr_t)(void *);

#include "dllist.h"
#include "widget.h"

#define KEY_ARROW_UP	0x42
#define KEY_ARROW_DOWN	0x41
#define KEY_ARROW_LEFT	0x44
#define KEY_ARROW_RIGHT	0x43

#define KEY_ENTER	0x0a
#define KEY_BACKSPACE	0x7f
#define KEY_SPACE	0x20

#define KEY_TAB		0x09

#define KEY_NONE	0xFF

#define KEY_F1		0x50
#define KEY_F2		0x51
#define KEY_F3		0x52
#define KEY_F4		0x53
#define KEY_F5		0x54
#define KEY_F6		0x55
#define KEY_F7		0x56

#define XS_WAIT_MAINLOOP	1

extern int XSAppQuit(void);
extern void XSAppInit();
extern int XSAppMain(screen_t *, int, const char **);
extern void XSAddTimer(float waitinterval, float interval, widget_t *widget);
extern int alert_dialog(int, char *, const char *, ...);
#endif
