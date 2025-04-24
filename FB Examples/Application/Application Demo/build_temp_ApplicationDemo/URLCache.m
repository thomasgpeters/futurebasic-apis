/*
 URLCache.m

 Bernie Wylde
 */

#import "URLCache.h"

// Class
Class URLCacheClass( void )
{ return [NSURLCache class]; }

// Shared cache
NSURLCache *URLCacheShared( void )
{ return [NSURLCache sharedURLCache]; }

// Create
NSURLCache *URLCacheWithMemoryCapacity( NSUInteger memoryCapacity, NSUInteger diskCapacity, CFURLRef directoryURL )
{
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
    if (@available(macOS 10.15, *)) {
#if __has_feature(objc_arc)
        return [[NSURLCache alloc] initWithMemoryCapacity:memoryCapacity diskCapacity:diskCapacity directoryURL:(__bridge NSURL *)directoryURL];
#else
        return [[[NSURLCache alloc] initWithMemoryCapacity:memoryCapacity diskCapacity:diskCapacity directoryURL:(__bridge NSURL *)directoryURL] autorelease];
#endif
    } else {
#if __has_feature(objc_arc)
        return [[NSURLCache alloc] initWithMemoryCapacity:memoryCapacity diskCapacity:diskCapacity diskPath:[(__bridge NSURL *)directoryURL path]];
#else
        return [[[NSURLCache alloc] initWithMemoryCapacity:memoryCapacity diskCapacity:diskCapacity diskPath:[(__bridge NSURL *)directoryURL path]] autorelease];
#endif
    }
#else
#if __has_feature(objc_arc)
    return [[NSURLCache alloc] initWithMemoryCapacity:memoryCapacity diskCapacity:diskCapacity diskPath:[(__bridge NSURL *)directoryURL path]];
#else
    return [[[NSURLCache alloc] initWithMemoryCapacity:memoryCapacity diskCapacity:diskCapacity diskPath:[(__bridge NSURL *)directoryURL path]] autorelease];
#endif
#endif// 101500
}

// Storing objects
NSCachedURLResponse *URLCacheCachedResponseForRequest( NSURLCache *ref, NSURLRequest *request )
{ return [ref cachedResponseForRequest:request]; }

void URLCacheStoreCachedResponseForRequest( NSURLCache *ref, NSCachedURLResponse *response, NSURLRequest *request )
{ [ref storeCachedResponse:response forRequest:request]; }

void URLCacheGetCachedResponseForDataTask( NSURLCache *ref, NSURLSessionDataTask *dataTask, CUI_URLCacheCachedReponseForDataTaskCompletionHandler completionHandler, void *userData )
{
    [ref getCachedResponseForDataTask:dataTask completionHandler:^(NSCachedURLResponse *cachedResponse) {
        (*completionHandler)( ref, cachedResponse, userData );
    }];
}

void URLCacheStoreCachedResponseForDataTask( NSURLCache *ref, NSCachedURLResponse *response, NSURLSessionDataTask *dataTask )
{ [ref storeCachedResponse:response forDataTask:dataTask]; }

// Removing objects
void URLCacheRemoveCachedResponseForRequest( NSURLCache *ref, NSURLRequest *request )
{ [ref removeCachedResponseForRequest:request]; }

void URLCacheRemoveCachedResponseForDataTask( NSURLCache *ref, NSURLSessionDataTask *dataTask )
{ [ref removeCachedResponseForDataTask:dataTask]; }

void URLCacheRemoveCachedResponsesSinceDate( NSURLCache *ref, CFDateRef dt )
{ [ref removeCachedResponsesSinceDate:(__bridge NSDate *)dt]; }

void URLCacheRemoveAllCachedResponses( NSURLCache *ref )
{ [ref removeAllCachedResponses]; }

// On-disk cache properties
NSUInteger URLCacheCurrentDiskUsage( NSURLCache *ref )
{ return [ref currentDiskUsage]; }

NSUInteger URLCacheDiskCapacity( NSURLCache *ref )
{ return [ref diskCapacity]; }

// In-memory cache properties
NSUInteger URLCacheCurrentMemoryUsage( NSURLCache *ref )
{ return [ref currentMemoryUsage]; }

NSUInteger URLCacheMemoryCapacity( NSURLCache *ref )
{ return [ref memoryCapacity]; }


#pragma mark - CachedURLResponse
// Create
NSCachedURLResponse *CachedURLResponseWithResponse( NSURLResponse *response, CFDataRef dta )
{
#if __has_feature(objc_arc)
    return [[NSCachedURLResponse alloc] initWithResponse:response data:(__bridge NSData *)dta];
#else
    return [[[NSCachedURLResponse alloc] initWithResponse:response data:(__bridge NSData *)dta] autorelease];
#endif
}

NSCachedURLResponse *CachedURLResponseWithStoragePolicy( NSURLResponse *response, CFDataRef dta, CFDictionaryRef userInfo, NSURLCacheStoragePolicy storagePolicy )
{
#if __has_feature(objc_arc)
    return [[NSCachedURLResponse alloc] initWithResponse:response data:(__bridge NSData *)dta userInfo:(__bridge NSDictionary *)userInfo storagePolicy:storagePolicy];
#else
    return [[[NSCachedURLResponse alloc] initWithResponse:response data:(__bridge NSData *)dta userInfo:(__bridge NSDictionary *)userInfo storagePolicy:storagePolicy] autorelease];
#endif
}

// Get response properties
CFDataRef CachedURLResponseData( NSCachedURLResponse *ref )
{ return (__bridge CFDataRef)[ref data]; }

NSURLResponse *CachedURLResponseResponse( NSCachedURLResponse *ref )
{ return [ref response]; }

NSURLCacheStoragePolicy CachedURLResponseStoragePolicy( NSCachedURLResponse *ref )
{ return [ref storagePolicy]; }

CFDictionaryRef CachedURLResponseUserInfo( NSCachedURLResponse *ref )
{ return (__bridge CFDictionaryRef)[ref userInfo]; }

