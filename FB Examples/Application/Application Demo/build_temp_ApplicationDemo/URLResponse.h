/*
 URLResponse.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class URLResponseClass( void );

// Create
NSURLResponse *URLResponseWithURL( CFURLRef url, CFStringRef mimeType, NSInteger expectedContentLength, CFStringRef textEncodingName );

// Properties
NSInteger URLResponseExpectedContentLength( NSURLResponse *ref );
CFStringRef URLResponseSuggestedFilename( NSURLResponse *ref );
CFStringRef URLResponseMIMEType( NSURLResponse *ref );
CFStringRef URLResponseTextEncodingName( NSURLResponse *ref );
CFURLRef URLResponseURL( NSURLResponse *ref );


#pragma mark - HTTPURLResponse
// Init
NSHTTPURLResponse *HTTPURLResponseWithURL( CFURLRef url, NSInteger statusCode, CFStringRef HTTPVersion, CFDictionaryRef headerFields );

// HTTP headers
CFDictionaryRef HTTPURLResponseAllHeaderFields( NSHTTPURLResponse *ref );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
CFStringRef HTTPURLResponseValueForHeaderField( NSHTTPURLResponse *ref, CFStringRef field );
#endif// 101500

// Status codes
CFStringRef HTTPURLResponseLocalizedStringForStatusCode( NSInteger statusCode );
NSInteger HTTPURLResponseStatusCode( NSHTTPURLResponse *ref );
