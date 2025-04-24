/*
 PersonNameComponentsFormatter.h

 Bernie Wylde
 */


#import "CocoaUI.h"


// Class
Class PersonNameComponentsFormatterClass( void );

// Create
NSPersonNameComponentsFormatter *PersonNameComponentsFormatterInit( void );

// Behavior
NSPersonNameComponentsFormatterStyle PersonNameComponentsFormatterStyle( NSPersonNameComponentsFormatter *ref );
void PersonNameComponentsFormatterSetStyle( NSPersonNameComponentsFormatter *ref, NSPersonNameComponentsFormatterStyle style );
BOOL PersonNameComponentsFormatterIsPhonetic( NSPersonNameComponentsFormatter *ref );
void PersonNameComponentsFormatterSetPhonetic( NSPersonNameComponentsFormatter *ref, BOOL flag );

// Convert
CFStringRef PersonNameComponentsFormatterLocalizedStringFromComponents( NSPersonNameComponents *comps, NSPersonNameComponentsFormatterStyle style, NSPersonNameComponentsFormatterOptions options );
CFStringRef PersonNameComponentsFormatterStringFromComponents( NSPersonNameComponentsFormatter *ref, NSPersonNameComponents *comps );
CFAttributedStringRef PersonNameComponentsFormatterAnnotatedStringFromComponents( NSPersonNameComponentsFormatter *ref, NSPersonNameComponents *comps );

NSPersonNameComponents *PersonNameComponentsFormatterComponentsFromString( NSPersonNameComponentsFormatter *ref, CFStringRef string );

BOOL PersonNameComponentsFormatterGetObjectValue( NSPersonNameComponentsFormatter *ref, CFTypeRef *obj, CFStringRef string, CFStringRef *errDescription );

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
CFLocaleRef PersonNameComponentsFormatterLocale( NSPersonNameComponentsFormatter *ref );
API_AVAILABLE(macos(12.0))
void PersonNameComponentsFormatterSetLocale( NSPersonNameComponentsFormatter *ref, CFLocaleRef locale );
#endif// 120000
