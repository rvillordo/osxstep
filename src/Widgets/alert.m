#import <osxstep.h>
#import <stdarg.h>
#import <XSAlertDialog.h>

int alert_dialog(int type, char *title, const char *fmt, ...)
{
	char msg[8192];
	va_list ap;
	XSAlertDialog *alert = [[XSAlertDialog alloc] initWithTitle:[NSString stringWithUTF8String:title]];

	va_start(ap, fmt);
	vsnprintf(msg, 8192, fmt, ap);
	va_end(ap);

	[alert setButtonTitle:XS_ALERT_BUTTON_CANCEL title:@" ok "];
	return ([alert runInformative:[NSString stringWithFormat:@"%s", msg]]);
}
