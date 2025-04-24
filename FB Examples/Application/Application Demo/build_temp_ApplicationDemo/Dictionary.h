/*
 Dictionary.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef void (*CUI_DictionaryEnumerateKeysAndObjectsCallbackType)(CFDictionaryRef,CFStringRef,CFTypeRef,BOOL*,void*);
typedef NSComparisonResult (*CUI_DictionaryKeysSortedByValueComparatorType)(CFDictionaryRef,id,id,void*);
typedef BOOL (*CUI_DictionaryKeysOfEntriesPassingTestType)(CFDictionaryRef,id,id,BOOL*,void*);

// Class
Class DictionaryClass( void );

CFDictionaryRef DictionaryWithContentsOfURL( CFURLRef url, NSError **err );
CFDictionaryRef DictionaryWithDictionary( CFDictionaryRef ref );
CFDictionaryRef DictionaryWithObject( CFTypeRef obj, CFStringRef key );
CFDictionaryRef DictionaryWithObjectForKey( CFTypeRef obj, CFTypeRef key );
CFDictionaryRef DictionaryWithObjects( CFTypeRef obj, ... );
BOOL DictionaryWriteToURL( CFDictionaryRef ref, CFURLRef url, NSError **err );
CFDictionaryRef DictionaryWithObjectsForKeys( CFArrayRef objects, CFArrayRef keys );

// Shared-key optimized dictionaries
CFTypeRef DictionarySharedKeySetForKeys( CFArrayRef keys );

NSUInteger DictionaryCount( CFDictionaryRef ref );
BOOL DictionaryIsEqual( CFDictionaryRef ref, CFDictionaryRef otherDict );
CFArrayRef DictionaryAllKeys( CFDictionaryRef ref );
CFArrayRef DictionaryAllKeysForObject( CFDictionaryRef ref, CFTypeRef obj );
CFArrayRef DictionaryAllValues( CFDictionaryRef ref );
CFTypeRef DictionaryValueForKey( CFDictionaryRef ref, CFStringRef key );
CFTypeRef DictionaryObjectForKey( CFDictionaryRef ref, CFTypeRef key );
CFArrayRef DictionaryObjectsForKeys( CFDictionaryRef ref, CFArrayRef keys, CFTypeRef notFoundMarker );

// - enumerator -
NSEnumerator *DictionaryKeyEnumerator( CFDictionaryRef ref );
NSEnumerator *DictionaryObjectEnumerator( CFDictionaryRef ref );
void DictionaryEnumerateKeysAndObjects( CFDictionaryRef ref, CUI_DictionaryEnumerateKeysAndObjectsCallbackType callback, void *userData );
void DictionaryEnumerateKeysAndObjectsWithOptions( CFDictionaryRef ref, NSEnumerationOptions options, CUI_DictionaryEnumerateKeysAndObjectsCallbackType callback, void *userData );

// sorting
CFArrayRef DictionaryKeysSortedByValueUsingSelector( CFDictionaryRef ref, CFStringRef selector );
CFArrayRef DictionaryKeysSortedByValueUsingComparator( CFDictionaryRef ref, CUI_DictionaryKeysSortedByValueComparatorType comparator, void *userData );
CFArrayRef DictionaryKeysSortedByValueWithOptionsUsingComparator( CFDictionaryRef ref, NSSortOptions options, CUI_DictionaryKeysSortedByValueComparatorType comparator, void *userData );

// Filtering
CFSetRef DictionaryKeysOfEntriesPassingTest( CFDictionaryRef ref, CUI_DictionaryKeysOfEntriesPassingTestType callback, void *userData );
CFSetRef DictionaryKeysWithOptionsOfEntriesPassingTest( CFDictionaryRef ref, NSEnumerationOptions options, CUI_DictionaryKeysOfEntriesPassingTestType callback, void *userData );

// - file attributes -
UInt64 DictionaryFileSize( CFDictionaryRef ref );
CFStringRef DictionaryFileType( CFDictionaryRef ref );
CFDateRef DictionaryFileCreationDate( CFDictionaryRef ref );
CFDateRef DictionaryFileModificationDate( CFDictionaryRef ref );
NSUInteger DictionaryFilePosixPermissions( CFDictionaryRef ref );
CFNumberRef DictionaryFileOwnerAccountID( CFDictionaryRef ref );
CFStringRef DictionaryFileOwnerAccountName( CFDictionaryRef ref );
CFNumberRef DictionaryFileGroupOwnerAccountID( CFDictionaryRef ref );
CFStringRef DictionaryFileGroupOwnerAccountName( CFDictionaryRef ref );
BOOL DictionaryFileExtensionHidden( CFDictionaryRef ref );
BOOL DictionaryFileIsImmutable( CFDictionaryRef ref );
BOOL DictionaryFileIsAppendOnly( CFDictionaryRef ref );
NSUInteger DictionaryFileSystemFileNumber( CFDictionaryRef ref );

NSInteger DictionaryFileSystemNumber( CFDictionaryRef ref );

OSType DictionaryFileHFSTypeCode( CFDictionaryRef ref );
OSType DictionaryFileHFSCreatorCode( CFDictionaryRef ref );

// Description
CFStringRef DictionaryDescription( CFDictionaryRef ref );
CFStringRef DictionaryDescriptionInStringsFileFormat( CFDictionaryRef ref );
CFStringRef DictionaryDescriptionWithLocale( CFDictionaryRef ref, CFLocaleRef locale );
CFStringRef DictionaryDescriptionWithLocaleIndent( CFDictionaryRef ref, CFLocaleRef locale, NSUInteger indent );

#pragma mark - JSON convenience functions
CFDictionaryRef DictionaryWithJSONString( CFStringRef string, NSError **err );


#pragma mark - mutable dictionary
// Class
Class MutableDictionaryClass( void );

// Create
CFMutableDictionaryRef MutableDictionaryNew( void );
CFMutableDictionaryRef MutableDictionaryWithCapacity( NSUInteger numItems );
CFMutableDictionaryRef MutableDictionaryWithSharedKeySet( CFTypeRef keyset );
CFMutableDictionaryRef MutableDictionaryWithContentsOfURL( CFURLRef url );
CFMutableDictionaryRef MutableDictionaryWithDictionary( CFDictionaryRef ref );
CFMutableDictionaryRef MutableDictionaryWithObjectForKey( CFTypeRef obj, CFStringRef key );
CFMutableDictionaryRef MutableDictionaryWithObjects( CFTypeRef obj, ... );
CFMutableDictionaryRef MutableDictionaryWithObjectsForKeys( CFArrayRef objects, CFArrayRef keys );

// Add
void MutableDictionarySetObjectForKey( CFMutableDictionaryRef ref, CFTypeRef obj, CFTypeRef key );
void MutableDictionarySetValueForKey( CFMutableDictionaryRef ref, CFTypeRef value, CFStringRef key );
void MutableDictionaryAddEntriesFromDictionary( CFMutableDictionaryRef ref, CFDictionaryRef otherDict );
void MutableDictionarySetDictionary( CFMutableDictionaryRef ref, CFDictionaryRef otherDict );

// Remove
void MutableDictionaryRemoveObjectForKey( CFMutableDictionaryRef ref, CFTypeRef key );
void MutableDictionaryRemoveAllObjects( CFMutableDictionaryRef ref );
void MutableDictionaryRemoveObjectsForKeys( CFMutableDictionaryRef ref, CFArrayRef keys );

#pragma mark - JSON convenience function
CFMutableDictionaryRef MutableDictionaryWithJSONString( CFStringRef string, NSError **err );
