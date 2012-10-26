#import "XSAlertDialog.h"

@implementation XSAlertDialog

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here
    }
    return self;
}

- (id)initWithTitle:(NSString *)title
{
    self = [super init];
    
    [self setMessageText:title];
    
    [self addButtonWithTitle:@"CANCEL"];
    [self addButtonWithTitle:@"OK"];
    [self addButtonWithTitle:@"OTHER"];
    [self hideAllButtons];
    
    return self;
}

- (void)setButtonTitle:(NSUInteger)bIndex title:(NSString *)bTitle
{
    [[[self buttons] objectAtIndex:bIndex] setTitle:bTitle];
}

- (void)hideButton:(NSUInteger)bIndex
{
    [[[self buttons] objectAtIndex:bIndex] setHidden:TRUE];
}

- (void)unhideButton:(NSUInteger)bIndex
{
    [[[self buttons] objectAtIndex:bIndex] setHidden:FALSE];
}

- (void)hideAllButtons
{
    NSUInteger i;
    for(i = 0; i < [[self buttons] count]; i++)
        [self hideButton:i];
}

- (void)unhideAllButtons
{
    NSUInteger i;
    for(i = 0; i < [[self buttons] count]; i++)
        [self unhideButton:i];    
}

- (BOOL)runInformative:(NSString *)msg, ...
{
    NSUInteger modal;
    
    [self hideAllButtons];
    [self unhideButton:XS_ALERT_BUTTON_CANCEL];
    //[self setButtonTitle:XS_ALERT_BUTTON_CANCEL title:@"OK"];
    [self setInformativeText:msg];
    [self setAlertStyle:NSInformationalAlertStyle];
    
    modal = [self runModal];
    return (YES);
}

- (BOOL)runQuestion:(NSString *)msg, ...
{
    NSUInteger modal;    
    
    [self hideAllButtons];
    [self unhideButton:XS_ALERT_BUTTON_OK];
    [self unhideButton:XS_ALERT_BUTTON_CANCEL];
    
    //[self setButtonTitle:XS_ALERT_BUTTON_OK title:@"YES"];
    //[self setButtonTitle:XS_ALERT_BUTTON_CANCEL title:@"NO"];
    
    [self setInformativeText:msg];
    [self setAlertStyle:NSWarningAlertStyle];
    
    modal = [self runModal];
    return ((modal == NSAlertSecondButtonReturn) ? YES : NO);
}


@end
