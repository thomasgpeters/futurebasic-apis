/*
 TextLabel.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "Control.h"
//#import "View.h"
//#import "Window.h"

NSTextField *TextLabelWithTag( NSInteger tag );
BOOL TextLabelExists( NSInteger tag );

// Init
NSTextField *TextLabelInit( NSInteger inTag, CGRect inRect );

// Statement
#if 1// attributed string text
void CUI_TextLabel( NSInteger inTag, CFTypeRef inText, CGRect inRect, NSInteger inWndTag );
#else// attributed string text
void CUI_TextLabel( NSInteger inTag, CFStringRef inText, CGRect inRect, NSInteger inWndTag );
#endif// attributed string text
