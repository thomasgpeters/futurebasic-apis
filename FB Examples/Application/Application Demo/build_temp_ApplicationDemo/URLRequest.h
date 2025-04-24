/*
 URLRequest.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class URLRequestClass( void );

// Create
NSURLRequest *URLRequestWithURL( CFURLRef url );
NSURLRequest *URLRequestWithURLCachePolicy( CFURLRef url, NSURLRequestCachePolicy policy, CFTimeInterval timeoutInterval );

// Cache policy
NSURLRequestCachePolicy URLRequestCachePolicy( NSURLRequest *ref );

// Components
CFStringRef URLRequestHTTPMethod( NSURLRequest *ref );
CFURLRef URLRequestURL( NSURLRequest *ref );
CFDataRef URLRequestHTTPBody( NSURLRequest *ref );
NSInputStream *URLRequestHTTPBodyStream( NSURLRequest *ref );
CFURLRef URLRequestMainDocumentURL( NSURLRequest *ref );

// Header fields
CFDictionaryRef URLRequestAllHTTPHeaderFields( NSURLRequest *ref );
CFStringRef URLRequestValueForHTTPHeaderField( NSURLRequest *ref, CFStringRef headerField );

// Behavior
CFTimeInterval URLRequestTimeoutInterval( NSURLRequest *ref );
BOOL URLRequestHTTPShouldHandleCookies( NSURLRequest *ref );
BOOL URLRequestHTTPShouldUsePipelining( NSURLRequest *ref );
BOOL URLRequestAllowsCellularAccess( NSURLRequest *ref );

// Limited nodes
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(15.0))
BOOL URLRequestAllowsConstrainedNetworkAccess( NSURLRequest *ref );
API_AVAILABLE(macos(15.0))
BOOL URLRequestAllowsExpensiveNetworkAccess( NSURLRequest *ref );
#endif// 101500

// Service type
NSURLRequestNetworkServiceType URLRequestNetworkServiceType( NSURLRequest *ref );

// Secure coding
BOOL URLRequestSupportsSecureCoding( void );

// Source of request
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
NSURLRequestAttribution URLRequestAttribution( NSURLRequest *ref );
#endif// 120000

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110300
API_AVAILABLE(macos(11.3))
BOOL URLRequestAssumesHTTP3Capable( NSURLRequest *ref );
#endif

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
BOOL URLRequestRequiresDNSSECValidation( URLRequestRef ref );
#endif// 140000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
API_AVAILABLE(macos(15.0))
BOOL URLRequestAllowsPersistentDNS( NSURLRequest *ref );
#endif// 150000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150200
API_AVAILABLE(macos(15.2))
CFStringRef URLRequestCookiePartitionIdentifier( URLRequestRef ref );
#endif // 150200

#pragma mark - MutableURLRequest

// Init
NSMutableURLRequest *MutableURLRequestInit( void );
NSMutableURLRequest *MutableURLRequestWithURL( CFURLRef url );
NSMutableURLRequest *MutableURLRequestWithURLRequestPolicy( CFURLRef url, NSURLRequestCachePolicy policy, CFTimeInterval timeInterval );

// Cache policy
void MutableURLRequestSetCachePolicy( NSMutableURLRequest *ref, NSURLRequestCachePolicy cachePolicy );

// Components
void MutableURLRequestSetHTTPMethod( NSMutableURLRequest *ref, CFStringRef method );
void MutableURLRequestSetURL( NSMutableURLRequest *ref, CFURLRef url );
void MutableURLRequestSetHTTPBody( NSMutableURLRequest *ref, CFDataRef body );
void MutableURLRequestSetHTTPBodyStream( NSMutableURLRequest *ref, NSInputStream *stream );
void MutableURLRequestSetMainDocumentURL( NSMutableURLRequest *ref, CFURLRef docURL );

// Header fields
void MutableURLRequestSetAllHTTPHeaderFields( NSMutableURLRequest *ref, CFDictionaryRef fields );
void MutableURLRequestAddValueForHTTPHeaderField( NSMutableURLRequest *ref, CFStringRef value, CFStringRef headerField );
void MutableURLRequestSetValueForHTTPHeaderField( NSMutableURLRequest *ref, CFStringRef value, CFStringRef headerField );

// Behavior
void MutableURLRequestSetTimeoutInterval( NSMutableURLRequest *ref, CFTimeInterval interval );
void MutableURLRequestSetHTTPShouldHandleCookies( NSMutableURLRequest *ref, BOOL flag );
void MutableURLRequestSetHTTPShouldUsePipelining( NSMutableURLRequest *ref, BOOL flag );
void MutableURLRequestSetAllowsCellularAccess( NSMutableURLRequest *ref, BOOL flag );

// Limited modes
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
void MutableURLRequestSetAllowsConstrainedNetworkAccess( NSMutableURLRequest *ref, BOOL flag );
API_AVAILABLE(macos(10.15))
void MutableURLRequestSetAllowsExpensiveNetworkAccess( NSMutableURLRequest *ref, BOOL flag );
#endif// 101500

// Service type
void MutableURLRequestSetNetworkServiceType( NSMutableURLRequest *ref, NSURLRequestNetworkServiceType type );

// Source of request
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
void MutableURLRequestSetAttribution( NSMutableURLRequest *ref, NSURLRequestAttribution attribution );
#endif// 120000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
void MutableURLRequestSetRequiresDNSSECValidation( NSMutableURLRequest *ref, BOOL flag );
#endif// 130000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
API_AVAILABLE(macos(15.0))
void MutableURLRequestSetAllowsPersistentDNS( NSMutableURLRequest *ref, BOOL flag );
#endif// 150000
