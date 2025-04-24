/*
 ComboButton.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000

#pragma mark - subclass
API_AVAILABLE(macos(13.0))
@interface ComboButtonSC : NSComboButton
@end

#pragma mark - functions
// Class
API_AVAILABLE(macos(13.0))
Class ComboButtonClass( void );

API_AVAILABLE(macos(13.0))
NSComboButton *ComboButtonWithTag( NSInteger tag );
API_AVAILABLE(macos(13.0))
BOOL ComboButtonExists( NSInteger tag );

// Title
API_AVAILABLE(macos(13.0))
CFStringRef ComboButtonTitle( NSInteger tag );
API_AVAILABLE(macos(13.0))
void ComboButtonSetTitle( NSInteger tag, CFStringRef title );

// Image
API_AVAILABLE(macos(13.0))
NSImage *ComboButtonImage( NSInteger tag );
API_AVAILABLE(macos(13.0))
void ComboButtonSetImage( NSInteger tag, CFTypeRef inImage );

// Image scaling
API_AVAILABLE(macos(13.0))
NSImageScaling ComboButtonImageScaling( NSInteger tag );
API_AVAILABLE(macos(13.0))
void ComboButtonSetImageScaling( NSInteger tag, NSImageScaling scaling );

// Menu
API_AVAILABLE(macos(13.0))
NSInteger ComboButtonMenuIndex( NSInteger tag );
API_AVAILABLE(macos(13.0))
void ComboButtonSetMenu( NSInteger tag, NSInteger menuID );
API_AVAILABLE(macos(13.0))
NSMenu *ComboButtonMenu( NSInteger tag );

// Style
API_AVAILABLE(macos(13.0))
NSComboButtonStyle ComboButtonStyle( NSInteger tag );
API_AVAILABLE(macos(13.0))
void ComboButtonSetStyle( NSInteger tag, NSComboButtonStyle style );



// Init
API_AVAILABLE(macos(13.0))
NSComboButton *ComboButtonInit( NSInteger inTag, CGRect inRect );

#pragma mark - combobutton statement
API_AVAILABLE(macos(13.0))
void CUI_ComboButton( NSInteger inTag, NSInteger inEnabled, CFStringRef inTitle, void *inImage, NSInteger inMenuID, CFTypeRef inMenuItems, CGRect inRect, NSInteger inStyle, NSInteger inWndTag );

#endif// 130000
