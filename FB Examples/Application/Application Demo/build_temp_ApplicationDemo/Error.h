/*
 Error.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class ErrorClass( void );

// Create
NSError *ErrorWithDomain( CFStringRef domain, NSInteger code, CFDictionaryRef userInfo );

// Properties
NSInteger ErrorCode( NSError *ref );
CFStringRef ErrorDomain( NSError *ref );
CFDictionaryRef ErrorUserInfo( NSError *ref );

// Localized description
CFStringRef ErrorLocalizedDescription( NSError *ref );
CFArrayRef ErrorLocalizedRecoveryOptions( NSError *ref );
CFStringRef ErrorLocalizedRecoverySuggestion( NSError *ref );
CFStringRef ErrorLocalizedFailureReason( NSError *ref );

// Display helpAnchor
CFStringRef ErrorHelpAnchor( NSError *ref );

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110300
API_AVAILABLE(macos(11.3))
CFArrayRef ErrorUnderlyingErrors( NSError *ref );
#endif// 110300

