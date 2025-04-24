/*
 FileManager.m

 Bernie Wylde
 */

#import "FileManager.h"

@implementation CUI_FileManagerDelegate

- (BOOL)fileManager:(NSFileManager *)fileManager shouldMoveItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL {
    DialogEventSetBool( YES );
    DialogEventSetNSURL( srcURL );
    DialogEventSetOtherNSURL( dstURL );
    CallUserDefinedOnDialogFunction( fileManagerShouldMoveItem, 0, 0, (__bridge CFTypeRef)srcURL );
    return DialogEventBool();
}

- (BOOL)fileManager:(NSFileManager *)fileManager shouldProceedAfterError:(NSError *)error movingItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL {
    DialogEventSetBool( NO );
    DialogEventSetError( error );
    DialogEventSetNSURL( srcURL );
    DialogEventSetOtherNSURL( dstURL );
    CallUserDefinedOnDialogFunction( fileManagerShouldProceedMovingItem, 0, 0, (__bridge CFTypeRef)srcURL );
    return DialogEventBool();
}

- (BOOL)fileManager:(NSFileManager *)fileManager shouldCopyItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL {
    DialogEventSetBool( YES );
    DialogEventSetNSURL( srcURL );
    DialogEventSetOtherNSURL( dstURL );
    CallUserDefinedOnDialogFunction( fileManagerShouldCopyItem, 0, 0, (__bridge CFTypeRef)srcURL );
    return DialogEventBool();
}

- (BOOL)fileManager:(NSFileManager *)fileManager shouldProceedAfterError:(NSError *)error copyingItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL {
    DialogEventSetBool( NO );
    DialogEventSetError( error );
    DialogEventSetNSURL( srcURL );
    DialogEventSetOtherNSURL( dstURL );
    CallUserDefinedOnDialogFunction( fileManagerShouldProceedCopyingItem, 0, 0, (__bridge CFTypeRef)srcURL );
    return DialogEventBool();
}

- (BOOL)fileManager:(NSFileManager *)fileManager shouldRemoveItemAtURL:(NSURL *)URL {
    DialogEventSetBool( YES );
    DialogEventSetNSURL( URL );
    CallUserDefinedOnDialogFunction( fileManagerShouldRemoveItem, 0, 0, (__bridge CFTypeRef)URL );
    return DialogEventBool();
}

- (BOOL)fileManager:(NSFileManager *)fileManager shouldProceedAfterError:(NSError *)error removingItemAtURL:(NSURL *)URL {
    
    return NO;
}

- (BOOL)fileManager:(NSFileManager *)fileManager shouldLinkItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL {
    
    return YES;
}

- (BOOL)fileManager:(NSFileManager *)fileManager shouldProceedAfterError:(NSError *)error linkingItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL {
    
    return NO;
}

@end

void CUI_FileManagerDelegateCreate( void )
{
    static CUI_FileManagerDelegate *sCUI_FileManagerDelegate = nil;
    if ( !sCUI_FileManagerDelegate ) {
        sCUI_FileManagerDelegate = [[CUI_FileManagerDelegate alloc] init];
        [[NSFileManager defaultManager] setDelegate:sCUI_FileManagerDelegate];
    }
}

// Class
Class FileManagerClass( void )
{ return [NSFileManager class]; }

// Create
NSFileManager *FileManagerDefaultManager( void )
{ return [NSFileManager defaultManager]; }

// User directories
CFURLRef FileManagerTemporaryDirectory( void )
{ return (__bridge CFURLRef)[[NSFileManager defaultManager] temporaryDirectory]; }

CFURLRef FileManagerHomeDirectoryForCurrentUser( void )
{ return (__bridge CFURLRef)[[NSFileManager defaultManager] homeDirectoryForCurrentUser]; }

CFURLRef FileManagerHomeDirectoryForUser( CFStringRef userName )
{ return (__bridge CFURLRef)[[NSFileManager defaultManager] homeDirectoryForUser:(__bridge NSString *)userName]; }

// System directories
CFURLRef FileManagerURLForDirectoryAppropriateForURL( NSSearchPathDirectory whichDirectory, NSSearchPathDomainMask domain, CFURLRef url, BOOL create, NSError **err )
{ return (__bridge CFURLRef)[[NSFileManager defaultManager] URLForDirectory:whichDirectory inDomain:domain appropriateForURL:(__bridge NSURL *)url create:create error:err]; }

CFURLRef FileManagerURLForDirectory( NSSearchPathDirectory whichDirectory, NSSearchPathDomainMask domain )
{
    NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:whichDirectory inDomains:domain];
    if ( [urls count] ) return (__bridge CFURLRef)[urls objectAtIndex:0];
    return nil;
}

CFArrayRef FileManagerURLsForDirectory( NSSearchPathDirectory whichDirectory, NSSearchPathDomainMask domain )
{ return (__bridge CFArrayRef)[[NSFileManager defaultManager] URLsForDirectory:whichDirectory inDomains:domain]; }

CFURLRef FileManagerURLForDesktopDirectory( void )
{
    NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSDesktopDirectory inDomains:NSUserDomainMask];
    if ( [urls count] ) return (__bridge CFURLRef)urls[0];
    return nil;
}

CFURLRef FileManagerURLForPreferencesDirectory( void )
{ return (__bridge CFURLRef)[NSURL fileURLWithPath:[@"~/Library/Preferences" stringByExpandingTildeInPath]]; }

CFURLRef FileManagerURLForApplicationDirectory( void )
{ return (__bridge CFURLRef)[[[NSBundle mainBundle] bundleURL] URLByDeletingLastPathComponent]; }

// Container directories
CFURLRef FileManagerContainerURLForSecurityApplicationGroupIdentifier( CFStringRef groupIdentifier )
{ return (__bridge CFURLRef)[[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:(__bridge NSString *)groupIdentifier]; }

#if ERROR_PARAM

CFArrayRef FileManagerContentsOfDirectoryAtURL( CFURLRef url, CFArrayRef keys, NSDirectoryEnumerationOptions options, NSError **err )
{ return (__bridge CFArrayRef)[[NSFileManager defaultManager] contentsOfDirectoryAtURL:(__bridge NSURL *)url includingPropertiesForKeys:(__bridge NSArray *)keys options:options error:err]; }

#else // ERROR_PARAM

CFArrayRef FileManagerContentsOfDirectoryAtURL( CFURLRef url, CFArrayRef keys, NSDirectoryEnumerationOptions options )
{ return (__bridge CFArrayRef)[[NSFileManager defaultManager] contentsOfDirectoryAtURL:(__bridge NSURL *)url includingPropertiesForKeys:(__bridge NSArray *)keys options:options error:nil]; }

#endif // ERROR_PARAM

NSDirectoryEnumerator *FileManagerEnumeratorAtURL( CFURLRef url, CFArrayRef propertyKeys, NSDirectoryEnumerationOptions options, FileManagerEnumeratorCallbackType errorCallback, void *userData )
{
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtURL:(__bridge NSURL *)url
                                                             includingPropertiesForKeys:(__bridge NSArray *)propertyKeys
                                                                                options:options
                                                                           errorHandler:^(NSURL *url, NSError *error) {
                                                                               if ( errorCallback ) return (*errorCallback)((__bridge CFURLRef)url,error,userData);
                                                                               return YES;
                                                                           }];
    return enumerator;
}

CFArrayRef FileManagerMountedVolumeURLs( CFArrayRef propertyKeys, NSVolumeEnumerationOptions options )
{ return (__bridge CFArrayRef)[[NSFileManager defaultManager] mountedVolumeURLsIncludingResourceValuesForKeys:(__bridge NSArray *)propertyKeys options:options]; }

#if ERROR_PARAM

BOOL FileManagerCreateDirectoryAtURL( CFURLRef url, BOOL withIntermediateDirectories, CFDictionaryRef attributes, NSError **err )
{ return [[NSFileManager defaultManager] createDirectoryAtPath:[(__bridge NSURL *)url path] withIntermediateDirectories:withIntermediateDirectories attributes:(__bridge NSDictionary *)attributes error:err]; }

#else // ERROR_PARAM

BOOL FileManagerCreateDirectoryAtURL( CFURLRef url, BOOL withIntermediateDirectories, CFDictionaryRef attributes )
{ return [[NSFileManager defaultManager] createDirectoryAtPath:[(__bridge NSURL *)url path] withIntermediateDirectories:withIntermediateDirectories attributes:(__bridge NSDictionary *)attributes error:nil]; }

#endif // ERROR_PARAM

BOOL FileManagerCreateFileAtURL( CFURLRef url, CFDataRef contents, CFDictionaryRef attributes )
{ return [[NSFileManager defaultManager] createFileAtPath:[(__bridge NSURL *)url path] contents:(__bridge NSData *)contents attributes:(__bridge NSDictionary *)attributes]; }

#if ERROR_PARAM

BOOL FileManagerRemoveItemAtURL( CFURLRef url, NSError **err )
{
    CUI_FileManagerDelegateCreate();
    return [[NSFileManager defaultManager] removeItemAtURL:(__bridge NSURL *)url error:err];
}

BOOL FileManagerReplaceItemAtURL( CFURLRef origURL, CFURLRef newURL, CFStringRef backupItemName, NSFileManagerItemReplacementOptions options, CFURLRef *resultingItemURL, NSError **err )
{ return [[NSFileManager defaultManager] replaceItemAtURL:(__bridge NSURL *)origURL withItemAtURL:(__bridge NSURL *)newURL backupItemName:(__bridge NSString *)backupItemName  options:options resultingItemURL:(__bridge NSURL **)resultingItemURL error:err]; }

#else // ERROR_PARAM

BOOL FileManagerRemoveItemAtURL( CFURLRef url )
{
    CUI_FileManagerDelegateCreate();
    return [[NSFileManager defaultManager] removeItemAtURL:(__bridge NSURL *)url error:nil];
}

BOOL FileManagerReplaceItemAtURL( CFURLRef origURL, CFURLRef newURL )
{ return [[NSFileManager defaultManager] replaceItemAtURL:(__bridge NSURL *)origURL withItemAtURL:(__bridge NSURL *)newURL backupItemName:nil options:0 resultingItemURL:nil error:nil]; }

#endif // ERROR_PARAM

BOOL FileManagerReplaceItemAtURLWithOptions( CFURLRef origURL, CFURLRef newURL, CFStringRef backupItemName, NSFileManagerItemReplacementOptions options, CFURLRef *resultingItemURL, NSError **err )
{
    NSURL *tempResultingItemURL = nil;
    BOOL flag = [[NSFileManager defaultManager] replaceItemAtURL:(__bridge NSURL *)origURL withItemAtURL:(__bridge NSURL *)newURL backupItemName:(__bridge NSString *)backupItemName options:options resultingItemURL:&tempResultingItemURL error:err];
    if ( resultingItemURL ) *resultingItemURL = (__bridge CFURLRef)tempResultingItemURL;
    return flag;
}

#if ERROR_PARAM

BOOL FileManagerTrashItemAtURL( CFURLRef url, CFURLRef *resultingItemURL, NSError **err )
{ return [[NSFileManager defaultManager] trashItemAtURL:(__bridge NSURL *)url resultingItemURL:(__bridge NSURL **)resultingItemURL error:err]; }

BOOL FileManagerCopyItemAtURL( CFURLRef srcURL, CFURLRef dstURL, NSError **err )
{
    CUI_FileManagerDelegateCreate();
    return [[NSFileManager defaultManager] copyItemAtURL:(__bridge NSURL *)srcURL toURL:(__bridge NSURL *)dstURL error:err];
}

BOOL FileManagerMoveItemAtURL( CFURLRef srcURL, CFURLRef dstURL, NSError **err )
{
    CUI_FileManagerDelegateCreate();
    return [[NSFileManager defaultManager] moveItemAtURL:(__bridge NSURL *)srcURL toURL:(__bridge NSURL *)dstURL error:err];
}

#else // ERROR_PARAM

void FileManagerTrashItemAtURL( CFURLRef url )
{ [[NSWorkspace sharedWorkspace] recycleURLs:[NSArray arrayWithObject:(__bridge NSURL *)url] completionHandler:nil]; }

BOOL FileManagerCopyItemAtURL( CFURLRef srcURL, CFURLRef dstURL )
{
    CUI_FileManagerDelegateCreate();
    return [[NSFileManager defaultManager] copyItemAtURL:(__bridge NSURL *)srcURL toURL:(__bridge NSURL *)dstURL error:nil];
}

BOOL FileManagerMoveItemAtURL( CFURLRef srcURL, CFURLRef dstURL )
{
    CUI_FileManagerDelegateCreate();
    return [[NSFileManager defaultManager] moveItemAtURL:(__bridge NSURL *)srcURL toURL:(__bridge NSURL *)dstURL error:nil];
}

#endif // ERROR_PARAM

// ICloud-based items
CFTypeRef FileManagerUbiquityIdentityToken( void )
{ return (__bridge CFTypeRef)[[NSFileManager defaultManager] ubiquityIdentityToken]; }

CFURLRef FileManagerURLForUbiquityContainerIdentifier( CFStringRef identifier )
{ return (__bridge CFURLRef)[[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:(__bridge NSString *)identifier]; }

BOOL FileManagerIsUbiquitousItem( CFURLRef url )
{ return [[NSFileManager defaultManager] isUbiquitousItemAtURL:(__bridge NSURL *)url]; }

BOOL FileManagerSetUbiquitousItem( BOOL flag, CFURLRef url, CFURLRef destURL, NSError **err )
{ return [[NSFileManager defaultManager] setUbiquitous:flag itemAtURL:(__bridge NSURL *)url destinationURL:(__bridge NSURL *)destURL error:err]; }

BOOL FileManagerStartDownloadingUbiquitousItem( CFURLRef url, NSError **err )
{ return [[NSFileManager defaultManager] startDownloadingUbiquitousItemAtURL:(__bridge NSURL *)url error:err]; }

BOOL FileManagerEvictUbiquitousItem( CFURLRef url, NSError **err )
{ return [[NSFileManager defaultManager] evictUbiquitousItemAtURL:(__bridge NSURL *)url error:err]; }

CFURLRef FileManagerURLForPublishingUbiquitousItem( CFURLRef url, CFDateRef *expirationDate, NSError **err )
{
    NSDate *tempExpirationDate = nil;
    NSURL *outURL = [[NSFileManager defaultManager] URLForPublishingUbiquitousItemAtURL:(__bridge NSURL *)url expirationDate:&tempExpirationDate error:err];
    if ( expirationDate ) *expirationDate = (__bridge CFDateRef)tempExpirationDate;
    return (__bridge CFURLRef)outURL;
}

// File provider services
void FileManagerGetFileProviderServicesForItem( CFURLRef url, FileManagerGetFileProviderServicesHandlerType completionHandler, void *userData )
{
    [[NSFileManager defaultManager] getFileProviderServicesForItemAtURL:(__bridge NSURL *)url completionHandler:^(NSDictionary *services,NSError *error) {
        (*completionHandler)((__bridge CFDictionaryRef)services,error,userData);
    }];
}

// Symbolic and hard links
BOOL FileManagerCreateSymbolicLinkAtURL( CFURLRef url, CFURLRef dstURL, NSError **err )
{ return [[NSFileManager defaultManager] createSymbolicLinkAtURL:(__bridge NSURL *)url withDestinationURL:(__bridge NSURL *)dstURL error:err]; }

BOOL FileManagerLinkItemAtURL( CFURLRef srcURL, CFURLRef dstURL, NSError **err )
{ return [[NSFileManager defaultManager] linkItemAtURL:(__bridge NSURL *)srcURL toURL:(__bridge NSURL *)dstURL error:err]; }

CFURLRef FileManagerDestinationURLOfSymbolicLinkAtURL( CFURLRef url, NSError **err )
{ return (__bridge CFURLRef)[NSURL fileURLWithPath:[[NSFileManager defaultManager] destinationOfSymbolicLinkAtPath:[(__bridge NSURL *)url path] error:err]]; }


BOOL FileManagerFileExistsAtURL( CFURLRef url )
{ return [[NSFileManager defaultManager] fileExistsAtPath:[(__bridge NSURL *)url path]]; }

BOOL FileManagerIsReadableFileAtURL( CFURLRef url )
{ return [[NSFileManager defaultManager] isReadableFileAtPath:[(__bridge NSURL *)url path]]; }

BOOL FileManagerIsWritableFileAtURL( CFURLRef url )
{ return [[NSFileManager defaultManager] isWritableFileAtPath:[(__bridge NSURL *)url path]]; }

BOOL FileManagerIsExecutableFileAtURL( CFURLRef url )
{ return [[NSFileManager defaultManager] isExecutableFileAtPath:[(__bridge NSURL *)url path]]; }

BOOL FileManagerIsDeletableFileAtURL( CFURLRef url )
{ return [[NSFileManager defaultManager] isDeletableFileAtPath:[(__bridge NSURL *)url path]]; }

BOOL FileManagerIsDirectoryAtURL( CFURLRef url )
{
    BOOL isDirectory = NO;
    [[NSFileManager defaultManager] fileExistsAtPath:[(__bridge NSURL *)url path] isDirectory:&isDirectory];
    return isDirectory;
}

#if ERROR_PARAM

CFDictionaryRef FileManagerAttributesOfItemAtURL( CFURLRef url, NSError **err )
{ return (__bridge CFDictionaryRef)[[NSFileManager defaultManager] attributesOfItemAtPath:[(__bridge NSURL *)url path] error:err]; }

BOOL FileManagerSetAttributesOfItemAtURL( CFURLRef url, CFDictionaryRef attributes, NSError **err )
{ return [[NSFileManager defaultManager] setAttributes:(__bridge NSDictionary *)attributes ofItemAtPath:[(__bridge NSURL *)url path] error:err]; }

#else // ERROR_PARAM

CFDictionaryRef FileManagerAttributesOfItemAtURL( CFURLRef url )
{ return (__bridge CFDictionaryRef)[[NSFileManager defaultManager] attributesOfItemAtPath:[(__bridge NSURL *)url path] error:nil]; }

BOOL FileManagerSetAttributesOfItemAtURL( CFURLRef url, CFDictionaryRef attributes )
{ return [[NSFileManager defaultManager] setAttributes:(__bridge NSDictionary *)attributes ofItemAtPath:[(__bridge NSURL *)url path] error:nil]; }

#endif // ERROR_PARAM

CFDataRef FileManagerContentsAtURL( CFURLRef url )
{ return (__bridge CFDataRef)[[NSFileManager defaultManager] contentsAtPath:[(__bridge NSURL *)url path]]; }

BOOL FileManagerContentsEqual( CFURLRef url1, CFURLRef url2 )
{ return [[NSFileManager defaultManager] contentsEqualAtPath:[(__bridge NSURL *)url1 path] andPath:[(__bridge NSURL *)url2 path]]; }

// Relationships between items
BOOL FileManagerGetRelationshipOfDirectoryAtURL( NSURLRelationship *relationship, CFURLRef dirURL, CFURLRef itemURL, NSError **err )
{ return [[NSFileManager defaultManager] getRelationship:relationship ofDirectoryAtURL:(__bridge NSURL *)dirURL toItemAtURL:(__bridge NSURL *)itemURL error:err]; }

BOOL FileManagerGetRelationshipOfDirectoryInDomain( NSURLRelationship *relationship, NSSearchPathDirectory whichDirectory, NSSearchPathDomainMask domain, CFURLRef itemURL, NSError **err )
{ return [[NSFileManager defaultManager] getRelationship:relationship ofDirectory:whichDirectory inDomain:domain toItemAtURL:(__bridge NSURL *)itemURL error:err]; }

// Current directory
BOOL FileManagerChangeCurrentDirectoryURL( CFURLRef url )
{ return [[NSFileManager defaultManager] changeCurrentDirectoryPath:[(__bridge NSURL *)url path]]; }

CFURLRef FileManagerCurrentDirectoryURL( void )
{ return (__bridge CFURLRef)[NSURL fileURLWithPath:[[NSFileManager defaultManager] currentDirectoryPath]]; }

// Unmount volumes
void FileManagerUnmountVolumeAtURL( CFURLRef url, NSFileManagerUnmountOptions options, FileManagerUnmountVolumeHandlerType completionHandler, void *userData )
{
    [[NSFileManager defaultManager] unmountVolumeAtURL:(__bridge NSURL *)url options:options completionHandler:^(NSError *error) {
        (*completionHandler)(error,userData);
    }];
}


/*
 DirectoryEnumerator.m
 */
// - attributes -
CFDictionaryRef DirectoryEnumeratorDirectoryAttributes( NSDirectoryEnumerator *enumerator )
{ return (__bridge CFDictionaryRef)[enumerator directoryAttributes]; }

CFDictionaryRef DirectoryEnumeratorFileAttributes( NSDirectoryEnumerator *enumerator )
{ return (__bridge CFDictionaryRef)[enumerator fileAttributes]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
BOOL DirectoryEnumeratorIsEnumeratingDirectoryPostOrder( NSDirectoryEnumerator *ref )
{ return [ref isEnumeratingDirectoryPostOrder]; }
#endif// 101500

NSUInteger DirectoryEnumeratorLevel( NSDirectoryEnumerator *enumerator )
{ return [enumerator level]; }

// - skipping -
void DirectoryEnumeratorSkipDescendants( NSDirectoryEnumerator *enumerator )
{ [enumerator skipDescendants]; }

