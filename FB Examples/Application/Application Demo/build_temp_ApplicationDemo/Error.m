/*
 Error.m

 Bernie Wylde
 */

#import "Error.h"

// Class
Class ErrorClass( void )
{ return [NSError class]; }

// Create
NSError *ErrorWithDomain( CFStringRef domain, NSInteger code, CFDictionaryRef userInfo )
{ return [NSError errorWithDomain:(__bridge NSString *)domain code:code userInfo:(__bridge NSDictionary *)userInfo]; }

// Properties
NSInteger ErrorCode( NSError *ref )
{ return [ref code]; }

CFStringRef ErrorDomain( NSError *ref )
{ return (__bridge CFStringRef)[ref domain]; }

CFDictionaryRef ErrorUserInfo( NSError *ref )
{ return (__bridge CFDictionaryRef)[ref userInfo]; }

// Localized description
CFStringRef ErrorLocalizedDescription( NSError *ref )
{ return (__bridge CFStringRef)[ref localizedDescription]; }

CFArrayRef ErrorLocalizedRecoveryOptions( NSError *ref )
{ return (__bridge CFArrayRef)[ref localizedRecoveryOptions]; }

CFStringRef ErrorLocalizedRecoverySuggestion( NSError *ref )
{ return (__bridge CFStringRef)[ref localizedRecoverySuggestion]; }

CFStringRef ErrorLocalizedFailureReason( NSError *ref )
{ return (__bridge CFStringRef)[ref localizedFailureReason]; }

// Display helpAnchor
CFStringRef ErrorHelpAnchor( NSError *ref )
{ return (__bridge CFStringRef)[ref helpAnchor]; }

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110300
CFArrayRef ErrorUnderlyingErrors( NSError *ref )
{ return (__bridge CFArrayRef)[ref underlyingErrors]; }
#endif// 110300
