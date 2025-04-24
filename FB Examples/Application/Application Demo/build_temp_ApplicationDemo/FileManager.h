/*
 FileManager.h

 Bernie Wylde
 */

#import "CocoaUI.h"

/*
 ERROR_PARAM
 
 20250327

 Add @err param to these functions:
   FileManagerContentsOfDirectoryAtURL
   FileManagerCreateDirectoryAtURL
   FileManagerRemoveItemAtURL
   FileManagerReplaceItemAtURL
   FileManagerTrashItemAtURL
   FileManagerCopyItemAtURL
   FileManagerMoveItemAtURL
   FileManagerAttributesOfItemAtURL
   FileManagerSetAttributesOfItemAtURL
 */
#define ERROR_PARAM 0


// dialog events
enum {
    fileManagerShouldMoveItem = 2400,
    fileManagerShouldProceedMovingItem,
    fileManagerShouldCopyItem,
    fileManagerShouldProceedCopyingItem,
    fileManagerShouldRemoveItem,
    fileManagerShouldProceedRemovingItem,
    fileManagerShouldLinkItem,
    fileManagerShouldProceedLinkingItem
};

@interface CUI_FileManagerDelegate : NSObject <NSFileManagerDelegate>
@end

void CUI_FileManagerDelegateCreate( void );

typedef BOOL (*FileManagerEnumeratorCallbackType)(CFURLRef,NSError *,void *);
typedef void (*FileManagerGetFileProviderServicesHandlerType)(CFDictionaryRef,NSError *,void *);
typedef void (*FileManagerUnmountVolumeHandlerType)(NSError *,void *);

// Class
Class FileManagerClass( void );

// Create
NSFileManager *FileManagerDefaultManager( void );

// User directories
CFURLRef FileManagerTemporaryDirectory( void );
CFURLRef FileManagerHomeDirectoryForCurrentUser( void );
CFURLRef FileManagerHomeDirectoryForUser( CFStringRef userName );

// System directories
CFURLRef FileManagerURLForDirectoryAppropriateForURL( NSSearchPathDirectory whichDirectory, NSSearchPathDomainMask domain, CFURLRef url, BOOL create, NSError **err );
CFURLRef FileManagerURLForDirectory( NSSearchPathDirectory whichDirectory, NSSearchPathDomainMask domain );
CFArrayRef FileManagerURLsForDirectory( NSSearchPathDirectory whichDirectory, NSSearchPathDomainMask domain );

// Container directories
CFURLRef FileManagerContainerURLForSecurityApplicationGroupIdentifier( CFStringRef groupIdentifier );

CFURLRef FileManagerURLForDesktopDirectory( void );
CFURLRef FileManagerURLForPreferencesDirectory( void );
CFURLRef FileManagerURLForApplicationDirectory( void );
#if ERROR_PARAM
CFArrayRef FileManagerContentsOfDirectoryAtURL( CFURLRef url, CFArrayRef keys, NSDirectoryEnumerationOptions options, NSError **err );
#else // ERROR_PARAM
CFArrayRef FileManagerContentsOfDirectoryAtURL( CFURLRef url, CFArrayRef keys, NSDirectoryEnumerationOptions options );
#endif // ERROR_PARAM

NSDirectoryEnumerator *FileManagerEnumeratorAtURL( CFURLRef url, CFArrayRef propertyKeys, NSDirectoryEnumerationOptions options, FileManagerEnumeratorCallbackType errorCallback, void *userData );
CFArrayRef FileManagerMountedVolumeURLs( CFArrayRef propertyKeys, NSVolumeEnumerationOptions options );

#if ERROR_PARAM
BOOL FileManagerCreateDirectoryAtURL( CFURLRef url, BOOL withIntermediateDirectories, CFDictionaryRef attributes, NSError **err );
#else // ERROR_PARAM
BOOL FileManagerCreateDirectoryAtURL( CFURLRef url, BOOL withIntermediateDirectories, CFDictionaryRef attributes );
#endif // ERROR_PARAM

BOOL FileManagerCreateFileAtURL( CFURLRef url, CFDataRef contents, CFDictionaryRef attributes );

#if ERROR_PARAM
BOOL FileManagerRemoveItemAtURL( CFURLRef url, NSError **err );
BOOL FileManagerReplaceItemAtURL( CFURLRef origURL, CFURLRef newURL, CFStringRef backupItemName, NSFileManagerItemReplacementOptions options, CFURLRef *resultingItemURL, NSError **err );
#else // ERROR_PARAM
BOOL FileManagerRemoveItemAtURL( CFURLRef url );
BOOL FileManagerReplaceItemAtURL( CFURLRef origURL, CFURLRef newURL );
#endif // ERROR_PARAM

BOOL FileManagerReplaceItemAtURLWithOptions( CFURLRef origURL, CFURLRef newURL, CFStringRef backupItemName, NSFileManagerItemReplacementOptions options, CFURLRef *resultingItemURL, NSError **err );

#if ERROR_PARAM
BOOL FileManagerTrashItemAtURL( CFURLRef url, CFURLRef *resultingItemURL, NSError **err );
BOOL FileManagerCopyItemAtURL( CFURLRef srcURL, CFURLRef dstURL, NSError **err );
BOOL FileManagerMoveItemAtURL( CFURLRef srcURL, CFURLRef dstURL, NSError **err );
#else // ERROR_PARAM
void FileManagerTrashItemAtURL( CFURLRef url );
BOOL FileManagerCopyItemAtURL( CFURLRef srcURL, CFURLRef dstURL );
BOOL FileManagerMoveItemAtURL( CFURLRef srcURL, CFURLRef dstURL );
#endif // ERROR_PARAM

// ICloud-based items
CFTypeRef FileManagerUbiquityIdentityToken( void );
CFURLRef FileManagerURLForUbiquityContainerIdentifier( CFStringRef identifier );
BOOL FileManagerIsUbiquitousItem( CFURLRef url );
BOOL FileManagerSetUbiquitousItem( BOOL flag, CFURLRef url, CFURLRef destURL, NSError **err );
BOOL FileManagerStartDownloadingUbiquitousItem( CFURLRef url, NSError **err );
BOOL FileManagerEvictUbiquitousItem( CFURLRef url, NSError **err );
CFURLRef FileManagerURLForPublishingUbiquitousItem( CFURLRef url, CFDateRef *expirationDate, NSError **err );

// File provider services
void FileManagerGetFileProviderServicesForItem( CFURLRef url, FileManagerGetFileProviderServicesHandlerType completionHandler, void *userData );

// Symbolic and hard links
BOOL FileManagerCreateSymbolicLinkAtURL( CFURLRef url, CFURLRef dstURL, NSError **err );
BOOL FileManagerLinkItemAtURL( CFURLRef srcURL, CFURLRef dstURL, NSError **err );
CFURLRef FileManagerDestinationURLOfSymbolicLinkAtURL( CFURLRef url, NSError **err );

BOOL FileManagerFileExistsAtURL( CFURLRef url );
BOOL FileManagerIsReadableFileAtURL( CFURLRef url );
BOOL FileManagerIsWritableFileAtURL( CFURLRef url );
BOOL FileManagerIsExecutableFileAtURL( CFURLRef url );
BOOL FileManagerIsDeletableFileAtURL( CFURLRef url );
BOOL FileManagerIsDirectoryAtURL( CFURLRef url );

#if ERROR_PARAM
CFDictionaryRef FileManagerAttributesOfItemAtURL( CFURLRef url, NSError **err );
BOOL FileManagerSetAttributesOfItemAtURL( CFURLRef url, CFDictionaryRef attributes, NSError **err );
#else // ERROR_PARAM
CFDictionaryRef FileManagerAttributesOfItemAtURL( CFURLRef url );
BOOL FileManagerSetAttributesOfItemAtURL( CFURLRef url, CFDictionaryRef attributes );
#endif // ERROR_PARAM

CFDataRef FileManagerContentsAtURL( CFURLRef url );

BOOL FileManagerContentsEqual( CFURLRef url1, CFURLRef url2 );

// Relationships between items
BOOL FileManagerGetRelationshipOfDirectoryAtURL( NSURLRelationship *relationship, CFURLRef dirURL, CFURLRef itemURL, NSError **err );
BOOL FileManagerGetRelationshipOfDirectoryInDomain( NSURLRelationship *relationship, NSSearchPathDirectory whichDirectory, NSSearchPathDomainMask domain, CFURLRef itemURL, NSError **err );

// Current directory
BOOL FileManagerChangeCurrentDirectoryURL( CFURLRef url );
CFURLRef FileManagerCurrentDirectoryURL( void );

// Unmount volumes
void FileManagerUnmountVolumeAtURL( CFURLRef url, NSFileManagerUnmountOptions options, FileManagerUnmountVolumeHandlerType completionHandler, void *userData );


/*
 DirectoryEnumerator.h
 */

// - attributes -
CFDictionaryRef DirectoryEnumeratorDirectoryAttributes( NSDirectoryEnumerator *enumerator );
CFDictionaryRef DirectoryEnumeratorFileAttributes( NSDirectoryEnumerator *enumerator );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
BOOL DirectoryEnumeratorIsEnumeratingDirectoryPostOrder( NSDirectoryEnumerator *ref );
#endif// 101500

NSUInteger DirectoryEnumeratorLevel( NSDirectoryEnumerator *enumerator );

// - skipping -
void DirectoryEnumeratorSkipDescendants( NSDirectoryEnumerator *enumerator );

