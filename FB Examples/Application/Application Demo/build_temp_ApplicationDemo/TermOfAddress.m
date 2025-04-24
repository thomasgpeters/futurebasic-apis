/*
 TermOfAddress.m

 Bernie Wylde
 */

#import "TermOfAddress.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000

// Create
NSTermOfAddress *TermOfAddressNeutral( void )
{ return [NSTermOfAddress neutral]; }

NSTermOfAddress *TermOfAddressFeminine( void )
{ return [NSTermOfAddress feminine]; }

NSTermOfAddress *TermOfAddressMasculine( void )
{ return [NSTermOfAddress masculine]; }

NSTermOfAddress *TermOfAddressLocalizedForLanguageIdentifier( CFStringRef language, CFArrayRef pronouns )
{ return [NSTermOfAddress localizedForLanguageIdentifier:(__bridge NSString *)language withPronouns:(__bridge NSArray *)pronouns]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
NSTermOfAddress *TermOfAddressCurrentUser( void )
{ return [NSTermOfAddress currentUser]; }
#endif // 150000

// Info
CFStringRef TermOfAddressLanguageIdentifier( NSTermOfAddress *ref )
{ return (__bridge CFStringRef)[ref languageIdentifier]; }

CFArrayRef TermOfAddressPronouns( NSTermOfAddress *ref )
{ return (__bridge CFArrayRef)[ref pronouns]; }

#endif// 140000
