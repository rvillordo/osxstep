#import <Cocoa/Cocoa.h>
#import <XSTextFieldFormatter.h>

@implementation XSTextFieldFormatter

- (id)init {
	[super init];
	maxLength = INT_MAX;
	return self;
}

- (void)setMaximumLength:(int)len {
	maxLength = len;
}

- (int)maximumLength {
	return maxLength;
}

- (NSString *)stringForObjectValue:(id)object 
{
	NSString *sobj = (NSString *)object;
	return (sobj);
}

- (BOOL)getObjectValue:(id *)object forString:(NSString *)string errorDescription:(NSString **)error {
	*object = string;
	return YES;
}

- (BOOL)isPartialStringValid:(NSString **)partialStringPtr
	   proposedSelectedRange:(NSRangePointer)proposedSelRangePtr
			  originalString:(NSString *)origString
	   originalSelectedRange:(NSRange)origSelRange
			errorDescription:(NSString **)error {
				if ([*partialStringPtr length] > maxLength) {
					return NO;
				}/* else {
				//if (![*partialStringPtr isEqual:[*partialStringPtr uppercaseString]]) {
					char *str;
					str = malloc([*partialStringPtr length] + 1);
					memset(str, '*', [*partialStringPtr length]);
					NSString *s = [[NSString alloc] initWithUTF8String:str];
					*partialStringPtr = [*partialStringPtr stringByReplacingOccurrencesOfString:*partialStringPtr withString:s];
					free(str);
					return YES;
				}*/
				return YES;
			}

- (NSAttributedString *)attributedStringForObjectValue:(id)anObject withDefaultAttributes:(NSDictionary *)attributes {
	return nil;
}
@end


