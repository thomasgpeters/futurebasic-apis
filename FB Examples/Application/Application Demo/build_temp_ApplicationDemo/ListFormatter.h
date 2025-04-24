/*
 ListFormatter.h

 Bernie Wylde
 */


#import "CocoaUI.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500

// Class
API_AVAILABLE(macos(10.15))
Class ListFormatterClass( void );

// Create
API_AVAILABLE(macos(10.15))
NSListFormatter *ListFormatterInit( void );

// Instance properties
API_AVAILABLE(macos(10.15))
NSFormatter *ListFormatterItemFormatter( NSListFormatter *ref );
API_AVAILABLE(macos(10.15))
void ListFormatterSetItemFormatter( NSListFormatter *ref, NSFormatter *formatter );
API_AVAILABLE(macos(10.15))
CFLocaleRef ListFormatterLocale( NSListFormatter *ref );
API_AVAILABLE(macos(10.15))
void ListFormatterSetLocale( NSListFormatter *ref, CFLocaleRef locale );

// Instance methods
API_AVAILABLE(macos(10.15))
CFStringRef ListFormatterStringForObjectValue( NSListFormatter *ref, CFTypeRef obj );
API_AVAILABLE(macos(10.15))
CFStringRef ListFormatterStringFromItems( NSListFormatter *ref, CFArrayRef items );

// Type methods
API_AVAILABLE(macos(10.15))
CFStringRef ListFormatterLocalizedStringByJoiningStrings( CFArrayRef strings );

#endif// 101500
