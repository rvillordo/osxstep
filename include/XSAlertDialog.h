#import <Foundation/Foundation.h>
#import <Appkit/Appkit.h>

#define XS_ALERT_INFO			0
#define XS_ALERT_BUTTON_OK      1
#define XS_ALERT_BUTTON_CANCEL  0
#define XS_ALERT_BUTTON_OTHER   2

@interface XSAlertDialog : NSAlert
{
}

- (id)initWithTitle:(NSString *)title;

- (BOOL)runInformative:(NSString *)msg, ...;
- (BOOL)runQuestion:(NSString *)msg, ...;

- (void)setButtonTitle:(NSUInteger)bIndex title:(NSString *)bTitle;
- (void)hideButton:(NSUInteger)bIndex;
- (void)unhideButton:(NSUInteger)bIndex;

- (void)hideAllButtons;
- (void)unhideAllButtons;

@end
