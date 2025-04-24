/*
 TermOfAddress.h

 Bernie Wylde
 */

#import "CocoaUI.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000

// Create
API_AVAILABLE(macos(14.0))
NSTermOfAddress *TermOfAddressNeutral( void );
API_AVAILABLE(macos(14.0))
NSTermOfAddress *TermOfAddressFeminine( void );
API_AVAILABLE(macos(14.0))
NSTermOfAddress *TermOfAddressMasculine( void );
API_AVAILABLE(macos(14.0))
NSTermOfAddress *TermOfAddressLocalizedForLanguageIdentifier( CFStringRef language, CFArrayRef pronouns );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
API_AVAILABLE(macos(15.0))
NSTermOfAddress *TermOfAddressCurrentUser( void );
#endif // 150000

// Info
API_AVAILABLE(macos(14.0))
CFStringRef TermOfAddressLanguageIdentifier( NSTermOfAddress *ref );
API_AVAILABLE(macos(14.0))
CFArrayRef TermOfAddressPronouns( NSTermOfAddress *ref );

#endif// 140000
