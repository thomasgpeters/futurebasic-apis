/*
 URL.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class URLClass( void );

// Create
CFURLRef URLWithString( CFStringRef string );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
CFURLRef URLWithStringEncodingInvalidCharacters( CFStringRef string, BOOL encodingInvalidCharacters );
#endif// 140000
CFURLRef URLWithStringRelativeToURL( CFStringRef string, CFURLRef baseURL );
CFURLRef URLFileURLWithPathIsDirectory( CFStringRef path, BOOL isDir );
CFURLRef URLFileURLWithPathRelativeToURL( CFStringRef path, CFURLRef baseURL );
CFURLRef URLFileURLWithPathIsDirectoryRelativeToURL( CFStringRef path, BOOL isDir, CFURLRef baseURL );
CFURLRef URLFileURLWithPath( CFStringRef path );
CFURLRef URLFileURLWithPathComponents( CFArrayRef components );
CFURLRef URLByResolvingBookmarkData( CFDataRef bookmarkData, NSURLBookmarkResolutionOptions options, CFURLRef relativeURL, BOOL *isStale, NSError **err );
//CFURLRef URLFileURLWithFileSystemRepresentation( CFStringRef path, BOOL isDir, CFURLRef baseURL );
//CFStringRef URLFileSystemRepresentation( CFURLRef url );
CFURLRef URLAbsoluteURLWithDataRepresentation( CFDataRef dta, CFURLRef baseURL );

// Compare
BOOL URLIsEqual( CFURLRef url1, CFURLRef url2 );

// Query
BOOL URLCheckResourceIsReachable( CFURLRef url, NSError **err );
BOOL URLIsFileReferenceURL( CFURLRef url );
BOOL URLIsFileURL( CFURLRef url );

// Parts of URL
CFStringRef URLAbsoluteString( CFURLRef url );
CFURLRef URLAbsoluteURL( CFURLRef url );
CFURLRef URLBaseURL( CFURLRef url );
CFStringRef URLFragment( CFURLRef url );
CFStringRef URLHost( CFURLRef url );
CFStringRef URLLastPathComponent( CFURLRef url );
CFStringRef URLPassword( CFURLRef url );
CFStringRef URLPath( CFURLRef url );
CFArrayRef URLPathComponents( CFURLRef url );
CFStringRef URLPathExtension( CFURLRef url );
CFNumberRef URLPort( CFURLRef url );
CFStringRef URLQuery( CFURLRef url );
CFStringRef URLRelativePath( CFURLRef url );
CFStringRef URLRelativeString( CFURLRef url );
CFStringRef URLRelativeResourceSpecifier( CFURLRef url );
CFStringRef URLScheme( CFURLRef url );
CFURLRef URLStandardizedURL( CFURLRef url );
CFStringRef URLUser( CFURLRef url );

// Resource values
CFDictionaryRef URLResourceValuesForKeys( CFURLRef url, CFArrayRef keys );
BOOL URLGetResourceValueForKey( CFURLRef url, CFStringRef key, CFTypeRef *value, NSError **err );
BOOL URLSetResourceValueForKey( CFURLRef url, CFStringRef key, CFTypeRef value, NSError **err );
BOOL URLSetResourceValues( CFURLRef url, CFDictionaryRef keyedValues, NSError **err );
void URLRemoveAllCachedResourceValues( CFURLRef url );
void URLRemoveCachedResourceValueForKey( CFURLRef url, CFStringRef key );
void URLSetTemporaryResourceValueForKey( CFURLRef url, CFTypeRef value, CFStringRef key );

// Modify and convert
CFURLRef URLFilePathURL( CFURLRef url );
CFURLRef URLFileReferenceURL( CFURLRef url );
CFURLRef URLByAppendingPathComponent( CFURLRef url, CFStringRef pathComponent );
CFURLRef URLByAppendingPathComponentIsDirectory( CFURLRef url, CFStringRef pathComponent, BOOL isDir );
CFURLRef URLByAppendingPathExtension( CFURLRef url, CFStringRef extension );
CFURLRef URLByDeletingLastPathComponent( CFURLRef url );
CFURLRef URLByDeletingPathExtension( CFURLRef url );
CFURLRef URLByResolvingSymlinksInPath( CFURLRef url );
CFURLRef URLByStandardizingPath( CFURLRef url );
BOOL URLHasDirectoryPath( CFURLRef url );

// Bookmarks
CFDataRef URLBookmarkDataWithContentsOfURL( CFURLRef url, NSError **err );
CFDataRef URLBookmarkDataWithOptions( CFURLRef url, NSURLBookmarkCreationOptions options, CFArrayRef resourceKeys, CFURLRef relativeURL, NSError **err );
CFDictionaryRef URLResourceValuesForKeysFromBookmarkData( CFArrayRef resourceKeys, CFDataRef bookmarkData );
BOOL URLWriteBookmarkData( CFDataRef bookmarkData, CFURLRef toURL, NSURLBookmarkFileCreationOptions options, NSError **err );
BOOL URLStartAccessingSecurityScopedResource( CFURLRef url );
void URLStopAccessingSecurityScopedResource( CFURLRef url );

// Promised items
BOOL URLCheckPromisedItemIsReachable( CFURLRef url, NSError **err );
BOOL URLGetPromisedItemResourceValue( CFURLRef url, CFTypeRef *value, CFStringRef key, NSError **err );
CFDictionaryRef URLPromisedItemResourceValuesForKeys( CFURLRef url, CFArrayRef keys, NSError **err );

// Pasteboards
CFURLRef URLFromPasteboard( NSPasteboard *pb );
void URLWriteToPasteboard( CFURLRef url, NSPasteboard *pb );

#pragma mark - URLComponents

// Create
NSURLComponents *URLComponentsWithString( CFStringRef string );
NSURLComponents *URLComponentsWithURL( CFURLRef url, BOOL resolvingAgainstBaseURL );

// URL
CFStringRef URLComponentsString( NSURLComponents *ref );
CFURLRef URLComponentsURL( NSURLComponents *ref );
CFURLRef URLComponentsURLRelativeToURL( NSURLComponents *ref, CFURLRef baseURL );

// Components in native format
CFStringRef URLComponentsFragment( NSURLComponents *ref );
void URLComponentsSetFragment( NSURLComponents *ref, CFStringRef fragment );
CFStringRef URLComponentsHost( NSURLComponents *ref );
void URLComponentsSetHost( NSURLComponents *ref, CFStringRef host );
CFStringRef URLComponentsPassword( NSURLComponents *ref );
void URLComponentsSetPassword( NSURLComponents *ref, CFStringRef password );
CFStringRef URLComponentsPath( NSURLComponents *ref );
void URLComponentsSetPath( NSURLComponents *ref, CFStringRef path );
CFStringRef URLComponentsQuery( NSURLComponents *ref );
void URLComponentsSetQuery( NSURLComponents *ref, CFStringRef query );
CFArrayRef URLComponentsQueryItems( NSURLComponents *ref );
void URLComponentsSetQueryItems( NSURLComponents *ref, CFArrayRef queryItems );
CFStringRef URLComponentsScheme( NSURLComponents *ref );
void URLComponentsSetScheme( NSURLComponents *ref, CFStringRef scheme );
CFStringRef URLComponentsUser( NSURLComponents *ref );
void URLComponentsSetUser( NSURLComponents *ref, CFStringRef user );

// Components in URL-encoded format
CFStringRef URLComponentsPercentEncodedFragment( NSURLComponents *ref );
void URLComponentsSetPercentEncodedFragment( NSURLComponents *ref, CFStringRef fragment );
CFStringRef URLComponentsPercentEncodedHost( NSURLComponents *ref );
void URLComponentsSetPercentEncodedHost( NSURLComponents *ref, CFStringRef host );
CFStringRef URLComponentsPercentEncodedPassword( NSURLComponents *ref );
void URLComponentsSetPercentEncodedPassword( NSURLComponents *ref, CFStringRef password );
CFStringRef URLComponentsPercentEncodedPath( NSURLComponents *ref );
void URLComponentsSetPercentEncodedPath( NSURLComponents *ref, CFStringRef path );
CFStringRef URLComponentsPercentEncodedQuery( NSURLComponents *ref );
void URLComponentsSetPercentEncodedQuery( NSURLComponents *ref, CFStringRef query );
CFStringRef URLComponentsPercentEncodedUser( NSURLComponents *ref );
void URLComponentsSetPercentEncodedUser( NSURLComponents *ref, CFStringRef user );

// Locate components in URL string representation
CFArrayRef URLComponentsPercentEncodedQueryItems( NSURLComponents *ref );
void URLComponentsSetPercentEncodedQueryItems( NSURLComponents *ref, CFArrayRef queryItems );
CFRange URLComponentsRangeOfFragment( NSURLComponents *ref );
CFRange URLComponentsRangeOfHost( NSURLComponents *ref );
CFRange URLComponentsRangeOfPassword( NSURLComponents *ref );
CFRange URLComponentsRangeOfPath( NSURLComponents *ref );
CFRange URLComponentsRangeOfPort( NSURLComponents *ref );
CFRange URLComponentsRangeOfQuery( NSURLComponents *ref );
CFRange URLComponentsRangeOfScheme( NSURLComponents *ref );
CFRange URLComponentsRangeOfUser( NSURLComponents *ref );

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
API_AVAILABLE(macos(13.0))
CFStringRef URLComponentsEncodedHost( NSURLComponents *ref );
API_AVAILABLE(macos(13.0))
void URLComponentsSetEncodedHost( NSURLComponents *ref, CFStringRef encodedHost );
#endif// 130000


#pragma mark - URLQueryItem

// Create
NSURLQueryItem *URLQueryItemWithName( CFStringRef name, CFStringRef value );

// Name and value
CFStringRef URLQueryItemName( NSURLQueryItem *ref );
CFStringRef URLQueryItemValue( NSURLQueryItem *ref );


