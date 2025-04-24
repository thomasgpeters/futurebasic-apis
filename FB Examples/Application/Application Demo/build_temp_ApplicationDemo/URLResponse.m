/*
 URLResponse.m

 Bernie Wylde
 */

#import "URLResponse.h"

// Class
Class URLResponseClass( void )
{ return [NSURLResponse class]; }

// Create
NSURLResponse *URLResponseWithURL( CFURLRef url, CFStringRef mimeType, NSInteger expectedContentLength, CFStringRef textEncodingName )
{
#if __has_feature(objc_arc)
    return [[NSURLResponse alloc] initWithURL:(__bridge NSURL *)url MIMEType:(__bridge NSString *)mimeType expectedContentLength:expectedContentLength textEncodingName:(__bridge NSString *)textEncodingName];
#else
    return [[[NSURLResponse alloc] initWithURL:(__bridge NSURL *)url MIMEType:(__bridge NSString *)mimeType expectedContentLength:expectedContentLength textEncodingName:(__bridge NSString *)textEncodingName] autorelease];
#endif
}

// Properties
NSInteger URLResponseExpectedContentLength( NSURLResponse *ref )
{ return [ref expectedContentLength]; }

CFStringRef URLResponseSuggestedFilename( NSURLResponse *ref )
{ return (__bridge CFStringRef)[ref suggestedFilename]; }

CFStringRef URLResponseMIMEType( NSURLResponse *ref )
{ return (__bridge CFStringRef)[ref MIMEType]; }

CFStringRef URLResponseTextEncodingName( NSURLResponse *ref )
{ return (__bridge CFStringRef)[ref textEncodingName]; }

CFURLRef URLResponseURL( NSURLResponse *ref )
{ return (__bridge CFURLRef)[ref URL]; }


#pragma mark - HTTPURLResponse
// Init
NSHTTPURLResponse *HTTPURLResponseWithURL( CFURLRef url, NSInteger statusCode, CFStringRef HTTPVersion, CFDictionaryRef headerFields )
{
#if __has_feature(objc_arc)
    return [[NSHTTPURLResponse alloc] initWithURL:(__bridge NSURL *)url statusCode:statusCode HTTPVersion:(__bridge NSString *)HTTPVersion headerFields:(__bridge NSDictionary *)headerFields];
#else
    return [[[NSHTTPURLResponse alloc] initWithURL:(__bridge NSURL *)url statusCode:statusCode HTTPVersion:(__bridge NSString *)HTTPVersion headerFields:(__bridge NSDictionary *)headerFields] autorelease];
#endif
}

// HTTP headers
CFDictionaryRef HTTPURLResponseAllHeaderFields( NSHTTPURLResponse *ref )
{ return (__bridge CFDictionaryRef)[ref allHeaderFields]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
CFStringRef HTTPURLResponseValueForHeaderField( NSHTTPURLResponse *ref, CFStringRef field )
{ return (__bridge CFStringRef)[ref valueForHTTPHeaderField:(__bridge NSString *)field]; }
#endif// 101500

// Status codes
CFStringRef HTTPURLResponseLocalizedStringForStatusCode( NSInteger statusCode )
{ return (__bridge CFStringRef)[NSHTTPURLResponse localizedStringForStatusCode:statusCode]; }

NSInteger HTTPURLResponseStatusCode( NSHTTPURLResponse *ref )
{ return [ref statusCode]; }

