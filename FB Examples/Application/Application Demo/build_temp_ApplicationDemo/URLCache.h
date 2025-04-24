/*
 URLCache.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef void (*CUI_URLCacheCachedReponseForDataTaskCompletionHandler)(NSURLCache*,NSCachedURLResponse*,void*);

// Class
Class URLCacheClass( void );

// Shared cache
NSURLCache *URLCacheShared( void );

// Create
NSURLCache *URLCacheWithMemoryCapacity( NSUInteger memoryCapacity, NSUInteger diskCapacity, CFURLRef directoryURL );

// Storing objects
NSCachedURLResponse *URLCacheCachedResponseForRequest( NSURLCache *ref, NSURLRequest *request );
void URLCacheStoreCachedResponseForRequest( NSURLCache *ref, NSCachedURLResponse *response, NSURLRequest *request );
void URLCacheGetCachedResponseForDataTask( NSURLCache *ref, NSURLSessionDataTask *dataTask, CUI_URLCacheCachedReponseForDataTaskCompletionHandler completionHandler, void *userData );
void URLCacheStoreCachedResponseForDataTask( NSURLCache *ref, NSCachedURLResponse *response, NSURLSessionDataTask *dataTask );

// Removing objects
void URLCacheRemoveCachedResponseForRequest( NSURLCache *ref, NSURLRequest *request );
void URLCacheRemoveCachedResponseForDataTask( NSURLCache *ref, NSURLSessionDataTask *dataTask );
void URLCacheRemoveCachedResponsesSinceDate( NSURLCache *ref, CFDateRef dt );
void URLCacheRemoveAllCachedResponses( NSURLCache *ref );

// On-disk cache properties
NSUInteger URLCacheCurrentDiskUsage( NSURLCache *ref );
NSUInteger URLCacheDiskCapacity( NSURLCache *ref );

// In-memory cache properties
NSUInteger URLCacheCurrentMemoryUsage( NSURLCache *ref );
NSUInteger URLCacheMemoryCapacity( NSURLCache *ref );

#pragma mark - CachedURLResponse

// Create
NSCachedURLResponse *CachedURLResponseWithResponse( NSURLResponse *response, CFDataRef dta );
NSCachedURLResponse *CachedURLResponseWithStoragePolicy( NSURLResponse *response, CFDataRef dta, CFDictionaryRef userInfo, NSURLCacheStoragePolicy storagePolicy );

// Get response properties
CFDataRef CachedURLResponseData( NSCachedURLResponse *ref );
NSURLResponse *CachedURLResponseResponse( NSCachedURLResponse *ref );
NSURLCacheStoragePolicy CachedURLResponseStoragePolicy( NSCachedURLResponse *ref );
CFDictionaryRef CachedURLResponseUserInfo( NSCachedURLResponse *ref );
