/*
 URL.m

 Bernie Wylde
 */

#import "URL.h"

// Class
Class URLClass( void )
{ return [NSURL class]; }

CFURLRef URLWithString( CFStringRef string )
{ return (__bridge CFURLRef)[NSURL URLWithString:(__bridge NSString *)string]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
CFURLRef URLWithStringEncodingInvalidCharacters( CFStringRef string, BOOL encodingInvalidCharacters )
{ return (__bridge CFURLRef)[NSURL URLWithString:(__bridge NSString *)string encodingInvalidCharacters:encodingInvalidCharacters]; }
#endif// 140000

CFURLRef URLWithStringRelativeToURL( CFStringRef string, CFURLRef baseURL )
{ return (__bridge CFURLRef)[NSURL URLWithString:(__bridge NSString *)string relativeToURL:(__bridge NSURL *)baseURL]; }

CFURLRef URLFileURLWithPathIsDirectory( CFStringRef path, BOOL isDir )
{ return (__bridge CFURLRef)[NSURL fileURLWithPath:(__bridge NSString *)path isDirectory:isDir]; }

CFURLRef URLFileURLWithPathRelativeToURL( CFStringRef path, CFURLRef baseURL )
{ return (__bridge CFURLRef)[NSURL fileURLWithPath:(__bridge NSString *)path relativeToURL:(__bridge NSURL *)baseURL]; }

CFURLRef URLFileURLWithPathIsDirectoryRelativeToURL( CFStringRef path, BOOL isDir, CFURLRef baseURL )
{ return (__bridge CFURLRef)[NSURL fileURLWithPath:(__bridge NSString *)path isDirectory:isDir relativeToURL:(__bridge NSURL *)baseURL]; }

CFURLRef URLFileURLWithPath( CFStringRef path )
{ return (__bridge CFURLRef)[NSURL fileURLWithPath:(__bridge NSString *)path]; }

CFURLRef URLFileURLWithPathComponents( CFArrayRef components )
{ return (__bridge CFURLRef)[NSURL fileURLWithPathComponents:(__bridge NSArray *)components]; }

CFURLRef URLByResolvingBookmarkData( CFDataRef bookmarkData, NSURLBookmarkResolutionOptions options, CFURLRef relativeURL, BOOL *isStale, NSError **err )
{ return (__bridge CFURLRef)[NSURL URLByResolvingBookmarkData:(__bridge NSData *)bookmarkData options:options relativeToURL:(__bridge NSURL *)relativeURL bookmarkDataIsStale:isStale error:err]; }

//CFURLRef URLFileURLWithFileSystemRepresentation( CFStringRef path, BOOL isDir, CFURLRef baseURL )
//{ return (__bridge CFURLRef)[NSURL fileURLWithFileSystemRepresentation:]}
//
//CFStringRef URLFileSystemRepresentation( CFURLRef url );

CFURLRef URLAbsoluteURLWithDataRepresentation( CFDataRef dta, CFURLRef baseURL )
{ return (__bridge CFURLRef)[NSURL absoluteURLWithDataRepresentation:(__bridge NSData *)dta relativeToURL:(__bridge NSURL *)baseURL]; }

// Compare
BOOL URLIsEqual( CFURLRef url1, CFURLRef url2 )
{ return [(__bridge NSURL *)url1 isEqual:(__bridge NSURL *)url2]; }

// Query
BOOL URLCheckResourceIsReachable( CFURLRef url, NSError **err )
{ return [(__bridge NSURL *)url checkResourceIsReachableAndReturnError:err]; }

BOOL URLIsFileReferenceURL( CFURLRef url )
{ return [(__bridge NSURL *)url isFileReferenceURL]; }

BOOL URLIsFileURL( CFURLRef url )
{ return [(__bridge NSURL *)url isFileURL]; }

// Parts of URL
CFStringRef URLAbsoluteString( CFURLRef url )
{ return (__bridge CFStringRef)[(__bridge NSURL *)url absoluteString]; }

CFURLRef URLAbsoluteURL( CFURLRef url )
{ return (__bridge CFURLRef)[(__bridge NSURL *)url absoluteURL]; }

CFURLRef URLBaseURL( CFURLRef url )
{ return (__bridge CFURLRef)[(__bridge NSURL *)url baseURL]; }

CFStringRef URLFragment( CFURLRef url )
{ return (__bridge CFStringRef)[(__bridge NSURL *)url fragment]; }

CFStringRef URLHost( CFURLRef url )
{ return (__bridge CFStringRef)[(__bridge NSURL *)url host]; }

CFStringRef URLLastPathComponent( CFURLRef url )
{ return (__bridge CFStringRef)[(__bridge NSURL *)url lastPathComponent]; }

CFStringRef URLPassword( CFURLRef url )
{ return (__bridge CFStringRef)[(__bridge NSURL *)url password]; }

CFStringRef URLPath( CFURLRef url )
{ return (__bridge CFStringRef)[(__bridge NSURL *)url path]; }

CFArrayRef URLPathComponents( CFURLRef url )
{ return (__bridge CFArrayRef)[(__bridge NSURL *)url pathComponents]; }

CFStringRef URLPathExtension( CFURLRef url )
{ return (__bridge CFStringRef)[(__bridge NSURL *)url pathExtension]; }

CFNumberRef URLPort( CFURLRef url )
{ return (__bridge CFNumberRef)[(__bridge NSURL *)url port]; }

CFStringRef URLQuery( CFURLRef url )
{ return (__bridge CFStringRef)[(__bridge NSURL *)url query]; }

CFStringRef URLRelativePath( CFURLRef url )
{ return (__bridge CFStringRef)[(__bridge NSURL *)url relativePath]; }

CFStringRef URLRelativeString( CFURLRef url )
{ return (__bridge CFStringRef)[(__bridge NSURL *)url relativeString]; }

CFStringRef URLRelativeResourceSpecifier( CFURLRef url )
{ return (__bridge CFStringRef)[(__bridge NSURL *)url resourceSpecifier]; }

CFStringRef URLScheme( CFURLRef url )
{ return (__bridge CFStringRef)[(__bridge NSURL *)url scheme]; }

CFURLRef URLStandardizedURL( CFURLRef url )
{ return (__bridge CFURLRef)[(__bridge NSURL *)url standardizedURL]; }

CFStringRef URLUser( CFURLRef url )
{ return (__bridge CFStringRef)[(__bridge NSURL *)url user]; }

// Resource values
CFDictionaryRef URLResourceValuesForKeys( CFURLRef url, CFArrayRef keys )
{ return (__bridge CFDictionaryRef)[(__bridge NSURL *)url resourceValuesForKeys:(__bridge NSArray *)keys error:nil]; }

BOOL URLGetResourceValueForKey( CFURLRef url, CFStringRef key, CFTypeRef *value, NSError **err )
{
    id temp = nil;
    BOOL flag = [(__bridge NSURL *)url getResourceValue:&temp forKey:(__bridge NSString *)key error:err];
    if ( value ) *value = (__bridge CFTypeRef)temp;
    return flag;
}

BOOL URLSetResourceValueForKey( CFURLRef url, CFStringRef key, CFTypeRef value, NSError **err )
{ return [(__bridge NSURL *)url setResourceValue:(__bridge id)value forKey:(__bridge NSString *)key error:err]; }

BOOL URLSetResourceValues( CFURLRef url, CFDictionaryRef keyedValues, NSError **err )
{ return [(__bridge NSURL *)url setResourceValues:(__bridge NSDictionary *)keyedValues error:err]; }

void URLRemoveAllCachedResourceValues( CFURLRef url )
{ [(__bridge NSURL *)url removeAllCachedResourceValues]; }

void URLRemoveCachedResourceValueForKey( CFURLRef url, CFStringRef key )
{ [(__bridge NSURL *)url removeCachedResourceValueForKey:(__bridge NSString *)key]; }

void URLSetTemporaryResourceValueForKey( CFURLRef url, CFTypeRef value, CFStringRef key )
{ [(__bridge NSURL *)url setTemporaryResourceValue:(__bridge id)value forKey:(__bridge NSString *)key]; }

// Modify and convert
CFURLRef URLFilePathURL( CFURLRef url )
{ return (__bridge CFURLRef)[(__bridge NSURL *)url filePathURL]; }

CFURLRef URLFileReferenceURL( CFURLRef url )
{ return (__bridge CFURLRef)[(__bridge NSURL *)url fileReferenceURL]; }

CFURLRef URLByAppendingPathComponent( CFURLRef url, CFStringRef pathComponent )
{ return (__bridge CFURLRef)[(__bridge NSURL *)url URLByAppendingPathComponent:(__bridge NSString *)pathComponent]; }

CFURLRef URLByAppendingPathComponentIsDirectory( CFURLRef url, CFStringRef pathComponent, BOOL isDir )
{ return (__bridge CFURLRef)[(__bridge NSURL *)url URLByAppendingPathComponent:(__bridge NSString *)pathComponent isDirectory:isDir]; }

CFURLRef URLByAppendingPathExtension( CFURLRef url, CFStringRef extension )
{ return (__bridge CFURLRef)[(__bridge NSURL *)url URLByAppendingPathExtension:(__bridge NSString *)extension]; }

CFURLRef URLByDeletingLastPathComponent( CFURLRef url )
{ return (__bridge CFURLRef)[(__bridge NSURL *)url URLByDeletingLastPathComponent]; }

CFURLRef URLByDeletingPathExtension( CFURLRef url )
{ return (__bridge CFURLRef)[(__bridge NSURL *)url URLByDeletingPathExtension]; }

CFURLRef URLByResolvingSymlinksInPath( CFURLRef url )
{ return (__bridge CFURLRef)[(__bridge NSURL *)url URLByResolvingSymlinksInPath]; }

CFURLRef URLByStandardizingPath( CFURLRef url )
{ return (__bridge CFURLRef)[(__bridge NSURL *)url URLByStandardizingPath]; }

BOOL URLHasDirectoryPath( CFURLRef url )
{ return [(__bridge NSURL *)url hasDirectoryPath]; }

// Bookmarks
CFDataRef URLBookmarkDataWithContentsOfURL( CFURLRef url, NSError **err )
{ return (__bridge CFDataRef)[NSURL bookmarkDataWithContentsOfURL:(__bridge NSURL *)url error:err]; }

CFDataRef URLBookmarkDataWithOptions( CFURLRef url, NSURLBookmarkCreationOptions options, CFArrayRef resourceKeys, CFURLRef relativeURL, NSError **err )
{ return (__bridge CFDataRef)[(__bridge NSURL *)url bookmarkDataWithOptions:options includingResourceValuesForKeys:(__bridge NSArray *)resourceKeys relativeToURL:(__bridge NSURL *)relativeURL error:err]; }

CFDictionaryRef URLResourceValuesForKeysFromBookmarkData( CFArrayRef resourceKeys, CFDataRef bookmarkData )
{ return (__bridge CFDictionaryRef)[NSURL resourceValuesForKeys:(__bridge NSArray *)resourceKeys fromBookmarkData:(__bridge NSData *)bookmarkData]; }

BOOL URLWriteBookmarkData( CFDataRef bookmarkData, CFURLRef toURL, NSURLBookmarkFileCreationOptions options, NSError **err )
{ return [NSURL writeBookmarkData:(__bridge NSData *)bookmarkData toURL:(__bridge NSURL *)toURL options:options error:err]; }

BOOL URLStartAccessingSecurityScopedResource( CFURLRef url )
{ return [(__bridge NSURL *)url startAccessingSecurityScopedResource]; }

void URLStopAccessingSecurityScopedResource( CFURLRef url )
{ [(__bridge NSURL *)url stopAccessingSecurityScopedResource]; }

// Promised items
BOOL URLCheckPromisedItemIsReachable( CFURLRef url, NSError **err )
{ return [(__bridge NSURL *)url checkPromisedItemIsReachableAndReturnError:err]; }

BOOL URLGetPromisedItemResourceValue( CFURLRef url, CFTypeRef *value, CFStringRef key, NSError **err )
{
    id temp = nil;
    BOOL flag = [(__bridge NSURL *)url getPromisedItemResourceValue:&temp forKey:(__bridge NSString *)key error:err];
    if ( value ) *value = (__bridge CFTypeRef)temp;
    return flag;
}

CFDictionaryRef URLPromisedItemResourceValuesForKeys( CFURLRef url, CFArrayRef keys, NSError **err )
{ return (__bridge CFDictionaryRef)[(__bridge NSURL *)url promisedItemResourceValuesForKeys:(__bridge NSArray *)keys error:err]; }

// Pasteboards
CFURLRef URLFromPasteboard( NSPasteboard *pb )
{ return (__bridge CFURLRef)[NSURL URLFromPasteboard:pb]; }

void URLWriteToPasteboard( CFURLRef url, NSPasteboard *pb )
{ [(__bridge NSURL *)url writeToPasteboard:pb]; }


#pragma mark - URLComponents

// Create
NSURLComponents *URLComponentsWithString( CFStringRef string )
{ return [NSURLComponents componentsWithString:(__bridge NSString *)string]; }

NSURLComponents *URLComponentsWithURL( CFURLRef url, BOOL resolvingAgainstBaseURL )
{ return [NSURLComponents componentsWithURL:(__bridge NSURL *)url resolvingAgainstBaseURL:resolvingAgainstBaseURL]; }

// URL
CFStringRef URLComponentsString( NSURLComponents *ref )
{ return (__bridge CFStringRef)[ref string]; }

CFURLRef URLComponentsURL( NSURLComponents *ref )
{ return (__bridge CFURLRef)[ref URL]; }

CFURLRef URLComponentsURLRelativeToURL( NSURLComponents *ref, CFURLRef baseURL )
{ return (__bridge CFURLRef)[ref URLRelativeToURL:(__bridge NSURL *)baseURL]; }

// Components in native format
CFStringRef URLComponentsFragment( NSURLComponents *ref )
{ return (__bridge CFStringRef)[ref fragment]; }

void URLComponentsSetFragment( NSURLComponents *ref, CFStringRef fragment )
{ [ref setFragment:(__bridge NSString *)fragment]; }

CFStringRef URLComponentsHost( NSURLComponents *ref )
{ return (__bridge CFStringRef)[ref host]; }

void URLComponentsSetHost( NSURLComponents *ref, CFStringRef host )
{ [ref setHost:(__bridge NSString *)host]; }

CFStringRef URLComponentsPassword( NSURLComponents *ref )
{ return (__bridge CFStringRef)[ref password]; }

void URLComponentsSetPassword( NSURLComponents *ref, CFStringRef password )
{ [ref setPassword:(__bridge NSString *)password]; }

CFStringRef URLComponentsPath( NSURLComponents *ref )
{ return (__bridge CFStringRef)[ref path]; }

void URLComponentsSetPath( NSURLComponents *ref, CFStringRef path )
{ [ref setPath:(__bridge NSString *)path]; }

CFStringRef URLComponentsQuery( NSURLComponents *ref )
{ return (__bridge CFStringRef)[ref query]; }

void URLComponentsSetQuery( NSURLComponents *ref, CFStringRef query )
{ [ref setQuery:(__bridge NSString *)query]; }

CFArrayRef URLComponentsQueryItems( NSURLComponents *ref )
{ return (__bridge CFArrayRef)[ref queryItems]; }

void URLComponentsSetQueryItems( NSURLComponents *ref, CFArrayRef queryItems )
{ [ref setQueryItems:(__bridge NSArray *)queryItems]; }

CFStringRef URLComponentsScheme( NSURLComponents *ref )
{ return (__bridge CFStringRef)[ref scheme]; }

void URLComponentsSetScheme( NSURLComponents *ref, CFStringRef scheme )
{ [ref setScheme:(__bridge NSString *)scheme]; }

CFStringRef URLComponentsUser( NSURLComponents *ref )
{ return (__bridge CFStringRef)[ref user]; }

void URLComponentsSetUser( NSURLComponents *ref, CFStringRef user )
{ [ref setUser:(__bridge NSString *)user]; }

// Components in URL-encoded format
CFStringRef URLComponentsPercentEncodedFragment( NSURLComponents *ref )
{ return (__bridge CFStringRef)[ref percentEncodedFragment]; }

void URLComponentsSetPercentEncodedFragment( NSURLComponents *ref, CFStringRef fragment )
{ [ref setPercentEncodedFragment:(__bridge NSString *)fragment]; }

CFStringRef URLComponentsPercentEncodedHost( NSURLComponents *ref )
{ return (__bridge CFStringRef)[ref percentEncodedHost]; }

void URLComponentsSetPercentEncodedHost( NSURLComponents *ref, CFStringRef host )
{ [ref setPercentEncodedHost:(__bridge NSString *)host]; }

CFStringRef URLComponentsPercentEncodedPassword( NSURLComponents *ref )
{ return (__bridge CFStringRef)[ref percentEncodedPassword]; }

void URLComponentsSetPercentEncodedPassword( NSURLComponents *ref, CFStringRef password )
{ [ref setPercentEncodedPassword:(__bridge NSString *)password]; }

CFStringRef URLComponentsPercentEncodedPath( NSURLComponents *ref )
{ return (__bridge CFStringRef)[ref percentEncodedPath]; }

void URLComponentsSetPercentEncodedPath( NSURLComponents *ref, CFStringRef path )
{ [ref setPercentEncodedPath:(__bridge NSString *)path]; }

CFStringRef URLComponentsPercentEncodedQuery( NSURLComponents *ref )
{ return (__bridge CFStringRef)[ref percentEncodedQuery]; }

void URLComponentsSetPercentEncodedQuery( NSURLComponents *ref, CFStringRef query )
{ [ref setPercentEncodedQuery:(__bridge NSString *)query]; }

CFStringRef URLComponentsPercentEncodedUser( NSURLComponents *ref )
{ return (__bridge CFStringRef)[ref percentEncodedUser]; }

void URLComponentsSetPercentEncodedUser( NSURLComponents *ref, CFStringRef user )
{ [ref setPercentEncodedUser:(__bridge NSString *)user]; }

// Locate components in URL string representation
CFArrayRef URLComponentsPercentEncodedQueryItems( NSURLComponents *ref )
{  return (__bridge CFArrayRef)[ref percentEncodedQueryItems]; }

void URLComponentsSetPercentEncodedQueryItems( NSURLComponents *ref, CFArrayRef queryItems )
{ [ref setPercentEncodedQueryItems:(__bridge NSArray *)queryItems]; }

CFRange URLComponentsRangeOfFragment( NSURLComponents *ref )
{ return NSRangeToCFRange([ref rangeOfFragment]); }

CFRange URLComponentsRangeOfHost( NSURLComponents *ref )
{ return NSRangeToCFRange([ref rangeOfHost]); }

CFRange URLComponentsRangeOfPassword( NSURLComponents *ref )
{ return NSRangeToCFRange([ref rangeOfPassword]); }

CFRange URLComponentsRangeOfPath( NSURLComponents *ref )
{ return NSRangeToCFRange([ref rangeOfPath]); }

CFRange URLComponentsRangeOfPort( NSURLComponents *ref )
{ return NSRangeToCFRange([ref rangeOfPort]); }

CFRange URLComponentsRangeOfQuery( NSURLComponents *ref )
{ return NSRangeToCFRange([ref rangeOfQuery]); }

CFRange URLComponentsRangeOfScheme( NSURLComponents *ref )
{ return NSRangeToCFRange([ref rangeOfScheme]); }

CFRange URLComponentsRangeOfUser( NSURLComponents *ref )
{ return NSRangeToCFRange([ref rangeOfUser]); }

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
CFStringRef URLComponentsEncodedHost( NSURLComponents *ref )
{ return (__bridge CFStringRef)[ref encodedHost]; }

void URLComponentsSetEncodedHost( NSURLComponents *ref, CFStringRef encodedHost )
{ [ref setEncodedHost:(__bridge NSString *)encodedHost]; }
#endif// 130000


#pragma mark - URLQueryItem

// Create
NSURLQueryItem *URLQueryItemWithName( CFStringRef name, CFStringRef value )
{ return [NSURLQueryItem queryItemWithName:(__bridge NSString *)name value:(__bridge NSString *)value]; }

// Name and value
CFStringRef URLQueryItemName( NSURLQueryItem *ref )
{ return (__bridge CFStringRef)[ref name]; }

CFStringRef URLQueryItemValue( NSURLQueryItem *ref )
{ return (__bridge CFStringRef)[ref value]; }


