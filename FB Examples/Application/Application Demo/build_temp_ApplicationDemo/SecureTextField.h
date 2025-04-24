/*
 SecureTextField.h

 Bernie Wylde
 */



//#import "Control.h"
//#import "DialogEvent.h"
//#import "View.h"
//#import "Window.h"

@interface SecureTextFieldSC : NSSecureTextField
@end

// Class
Class SecureTextFieldClass( void );

NSSecureTextField *SecureTextFieldWithTag( NSInteger tag );
BOOL SecureTextFieldExists( NSInteger tag );

BOOL SecureTextFieldEchosBullets( NSInteger tag );
void SecureTextFieldSetEchosBullets( NSInteger tag, BOOL flag );


// Init
NSSecureTextField *SecureTextFieldInit( NSInteger inTag, CGRect inRect );

// Statement
void CUI_SecureTextField( NSInteger inTag, NSInteger inEnabled, CFStringRef inText, CGRect inRect, NSInteger inWndTag );
