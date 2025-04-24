/*
 URLRequest.m

 Bernie Wylde
 */

#import "URLRequest.h"

// Class
Class URLRequestClass( void )
{ return [NSURLRequest class]; }

// Create
NSURLRequest *URLRequestWithURL( CFURLRef url )
{ return [NSURLRequest requestWithURL:(__bridge NSURL *)url]; }

NSURLRequest *URLRequestWithURLCachePolicy( CFURLRef url, NSURLRequestCachePolicy policy, CFTimeInterval timeoutInterval )
{ return [NSURLRequest requestWithURL:(__bridge NSURL *)url cachePolicy:policy timeoutInterval:timeoutInterval]; }

// Cache policy
NSURLRequestCachePolicy URLRequestCachePolicy( NSURLRequest *ref )
{ return [ref cachePolicy]; }

// Components
CFStringRef URLRequestHTTPMethod( NSURLRequest *ref )
{ return (__bridge CFStringRef)[ref HTTPMethod]; }

CFURLRef URLRequestURL( NSURLRequest *ref )
{ return (__bridge CFURLRef)[ref URL]; }

CFDataRef URLRequestHTTPBody( NSURLRequest *ref )
{ return (__bridge CFDataRef)[ref HTTPBody]; }

NSInputStream *URLRequestHTTPBodyStream( NSURLRequest *ref )
{ return [ref HTTPBodyStream]; }

CFURLRef URLRequestMainDocumentURL( NSURLRequest *ref )
{ return (__bridge CFURLRef)[ref mainDocumentURL]; }

// Header fields
CFDictionaryRef URLRequestAllHTTPHeaderFields( NSURLRequest *ref )
{ return (__bridge CFDictionaryRef)[ref allHTTPHeaderFields]; }

CFStringRef URLRequestValueForHTTPHeaderField( NSURLRequest *ref, CFStringRef headerField )
{ return (__bridge CFStringRef)[ref valueForHTTPHeaderField:(__bridge NSString *)headerField]; }

// Behavior
CFTimeInterval URLRequestTimeoutInterval( NSURLRequest *ref )
{ return [ref timeoutInterval]; }

BOOL URLRequestHTTPShouldHandleCookies( NSURLRequest *ref )
{ return [ref HTTPShouldHandleCookies]; }

BOOL URLRequestHTTPShouldUsePipelining( NSURLRequest *ref )
{ return [ref HTTPShouldUsePipelining]; }

BOOL URLRequestAllowsCellularAccess( NSURLRequest *ref )
{ return [ref allowsCellularAccess]; }

// Limited nodes
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
BOOL URLRequestAllowsConstrainedNetworkAccess( NSURLRequest *ref )
{ return [ref allowsConstrainedNetworkAccess]; }

BOOL URLRequestAllowsExpensiveNetworkAccess( NSURLRequest *ref )
{ return [ref allowsExpensiveNetworkAccess]; }
#endif// 101500

// Service type
NSURLRequestNetworkServiceType URLRequestNetworkServiceType( NSURLRequest *ref )
{ return [ref networkServiceType]; }

// Secure coding
BOOL URLRequestSupportsSecureCoding( void )
{ return [NSURLRequest supportsSecureCoding]; }

// Source of request
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
NSURLRequestAttribution URLRequestAttribution( NSURLRequest *ref )
{ return [ref attribution]; }
#endif// 120000

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110300
BOOL URLRequestAssumesHTTP3Capable( NSURLRequest *ref )
{ return [ref assumesHTTP3Capable]; }
#endif

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
BOOL URLRequestRequiresDNSSECValidation( NSURLRequest *ref )
{ return [ref requiresDNSSECValidation]; }
#endif// 140000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
BOOL URLRequestAllowsPersistentDNS( NSURLRequest *ref )
{ return [ ref allowsPersistentDNS]; }
#endif// 150000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150200
CFStringRef URLRequestCookiePartitionIdentifier( NSURLRequest *ref )
{ return (__bridge CFStringRef)[ref cookiePartitionIdentifier]; }
#endif // 150200


#pragma mark - MutableURLRequest
// Init
NSMutableURLRequest *MutableURLRequestInit( void )
{
#if __has_feature(objc_arc)
    return [[NSMutableURLRequest alloc] init];
#else
    return [[[NSMutableURLRequest alloc] init] autorelease];
#endif
}

NSMutableURLRequest *MutableURLRequestWithURL( CFURLRef url )
{ return [NSMutableURLRequest requestWithURL:(__bridge NSURL *)url]; }

NSMutableURLRequest *MutableURLRequestWithURLRequestPolicy( CFURLRef url, NSURLRequestCachePolicy policy, CFTimeInterval timeInterval )
{ return [NSMutableURLRequest requestWithURL:(__bridge NSURL *)url cachePolicy:policy timeoutInterval:timeInterval]; }

// Cache policy
void MutableURLRequestSetCachePolicy( NSMutableURLRequest *ref, NSURLRequestCachePolicy cachePolicy )
{ [ref setCachePolicy:cachePolicy]; }

// Components
void MutableURLRequestSetHTTPMethod( NSMutableURLRequest *ref, CFStringRef method )
{ [ref setHTTPMethod:(__bridge NSString *)method]; }

void MutableURLRequestSetURL( NSMutableURLRequest *ref, CFURLRef url )
{ [ref setURL:(__bridge NSURL *)url]; }

void MutableURLRequestSetHTTPBody( NSMutableURLRequest *ref, CFDataRef body )
{ [ref setHTTPBody:(__bridge NSData *)body]; }

void MutableURLRequestSetHTTPBodyStream( NSMutableURLRequest *ref, NSInputStream *stream )
{ [ref setHTTPBodyStream:stream]; }

void MutableURLRequestSetMainDocumentURL( NSMutableURLRequest *ref, CFURLRef docURL )
{ [ref setMainDocumentURL:(__bridge NSURL *)docURL]; }

// Header fields
void MutableURLRequestSetAllHTTPHeaderFields( NSMutableURLRequest *ref, CFDictionaryRef fields )
{ [ref setAllHTTPHeaderFields:(__bridge NSDictionary *)fields]; }

void MutableURLRequestAddValueForHTTPHeaderField( NSMutableURLRequest *ref, CFStringRef value, CFStringRef headerField )
{ [ref addValue:(__bridge NSString *)value forHTTPHeaderField:(__bridge NSString *)headerField]; }

void MutableURLRequestSetValueForHTTPHeaderField( NSMutableURLRequest *ref, CFStringRef value, CFStringRef headerField )
{ [ref setValue:(__bridge NSString *)value forHTTPHeaderField:(__bridge NSString *)headerField]; }

// Behavior
void MutableURLRequestSetTimeoutInterval( NSMutableURLRequest *ref, CFTimeInterval interval )
{ [ref setTimeoutInterval:interval]; }

void MutableURLRequestSetHTTPShouldHandleCookies( NSMutableURLRequest *ref, BOOL flag )
{ [ref setHTTPShouldHandleCookies:flag]; }

void MutableURLRequestSetHTTPShouldUsePipelining( NSMutableURLRequest *ref, BOOL flag )
{ [ref setHTTPShouldUsePipelining:flag]; }

void MutableURLRequestSetAllowsCellularAccess( NSMutableURLRequest *ref, BOOL flag )
{ [ref setAllowsCellularAccess:flag]; }

// Limited modes
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
void MutableURLRequestSetAllowsConstrainedNetworkAccess( NSMutableURLRequest *ref, BOOL flag )
{ [ref setAllowsConstrainedNetworkAccess:flag]; }

void MutableURLRequestSetAllowsExpensiveNetworkAccess( NSMutableURLRequest *ref, BOOL flag )
{ [ref setAllowsExpensiveNetworkAccess:flag]; }
#endif// 101500

// Service type
void MutableURLRequestSetNetworkServiceType( NSMutableURLRequest *ref, NSURLRequestNetworkServiceType type )
{ [ref setNetworkServiceType:type]; }

// Source of request
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
void MutableURLRequestSetAttribution( NSMutableURLRequest *ref, NSURLRequestAttribution attribution )
{ [ref setAttribution:attribution]; }
#endif// 120000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
void MutableURLRequestSetRequiresDNSSECValidation( NSMutableURLRequest *ref, BOOL flag )
{ [ref setRequiresDNSSECValidation:flag]; }
#endif// 130000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
API_AVAILABLE(macos(15.0))
void MutableURLRequestSetAllowsPersistentDNS( NSMutableURLRequest *ref, BOOL flag )
{ [ref setAllowsPersistentDNS:flag]; }
#endif// 150000
