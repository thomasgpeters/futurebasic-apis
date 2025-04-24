/*
 Dictionary.m

 Bernie Wylde
 */

#import "Dictionary.h"

// Class
Class DictionaryClass( void )
{ return [NSDictionary class]; }

CFDictionaryRef DictionaryWithContentsOfURL( CFURLRef url, NSError **err )
{ return (__bridge CFDictionaryRef)[NSDictionary dictionaryWithContentsOfURL:(__bridge NSURL *)url error:err]; }

CFDictionaryRef DictionaryWithDictionary( CFDictionaryRef ref )
{ return (__bridge CFDictionaryRef)[NSDictionary dictionaryWithDictionary:(__bridge NSDictionary *)ref]; }

CFDictionaryRef DictionaryWithObject( CFTypeRef obj, CFStringRef key )
{ return (__bridge CFDictionaryRef)[NSDictionary dictionaryWithObject:(__bridge id)obj forKey:(__bridge NSString *)key]; }

CFDictionaryRef DictionaryWithObjectForKey( CFTypeRef obj, CFTypeRef key )
{ return (__bridge CFDictionaryRef)[NSDictionary dictionaryWithObject:(__bridge id)obj forKey:(__bridge id)key]; }

CFDictionaryRef DictionaryWithObjects( CFTypeRef obj, ... )
{
    va_list ap;
    va_start( ap, obj );
    NSMutableDictionary *ref = [NSMutableDictionary dictionaryWithCapacity:0];
    while ( obj ) {
        NSString *key = va_arg( ap, id );
        if ( key == NULL ) break;
        [ref setObject:(__bridge id)obj forKey:key];
        obj = (__bridge CFTypeRef)va_arg( ap, id );
    }
    va_end( ap );
    return (__bridge CFMutableDictionaryRef)[NSDictionary dictionaryWithDictionary:ref];
}

BOOL DictionaryWriteToURL( CFDictionaryRef ref, CFURLRef url, NSError **err )
{ return [(__bridge NSDictionary *)ref writeToURL:(__bridge NSURL *)url error:err]; }

CFDictionaryRef DictionaryWithObjectsForKeys( CFArrayRef objects, CFArrayRef keys )
{ return (__bridge CFDictionaryRef)[NSDictionary dictionaryWithObjects:(__bridge NSArray *)objects forKeys:(__bridge NSArray *)keys]; }

// Shared-key optimized dictionaries
CFTypeRef DictionarySharedKeySetForKeys( CFArrayRef keys )
{ return (__bridge CFTypeRef)[NSDictionary sharedKeySetForKeys:(__bridge NSArray *)keys]; }

NSUInteger DictionaryCount( CFDictionaryRef ref )
{ return [(__bridge NSDictionary *)ref count]; }

BOOL DictionaryIsEqual( CFDictionaryRef ref, CFDictionaryRef otherDict )
{ return [(__bridge NSDictionary *)ref isEqualToDictionary:(__bridge NSDictionary *)otherDict]; }

CFArrayRef DictionaryAllKeys( CFDictionaryRef ref )
{ return (__bridge CFArrayRef)[(__bridge NSDictionary *)ref allKeys]; }

CFArrayRef DictionaryAllKeysForObject( CFDictionaryRef ref, CFTypeRef obj )
{ return (__bridge CFArrayRef)[(__bridge NSDictionary *)ref allKeysForObject:(__bridge id)obj]; }

CFArrayRef DictionaryAllValues( CFDictionaryRef ref )
{ return (__bridge CFArrayRef)[(__bridge NSDictionary *)ref allValues]; }

CFTypeRef DictionaryValueForKey( CFDictionaryRef ref, CFStringRef key )
{ return (__bridge CFTypeRef)[(__bridge NSDictionary *)ref valueForKey:(__bridge NSString *)key]; }

CFTypeRef DictionaryObjectForKey( CFDictionaryRef ref, CFTypeRef key )
{ return (__bridge CFTypeRef)[(__bridge NSDictionary *)ref objectForKey:(__bridge id)key]; }

CFArrayRef DictionaryObjectsForKeys( CFDictionaryRef ref, CFArrayRef keys, CFTypeRef notFoundMarker )
{ return (__bridge CFArrayRef)[(__bridge NSDictionary *)ref objectsForKeys:(__bridge NSArray *)keys notFoundMarker:(__bridge id)notFoundMarker]; }

// - enumerator -
NSEnumerator *DictionaryKeyEnumerator( CFDictionaryRef ref )
{ return [(__bridge NSDictionary *)ref keyEnumerator]; }

NSEnumerator *DictionaryObjectEnumerator( CFDictionaryRef ref )
{ return [(__bridge NSDictionary *)ref objectEnumerator]; }

void DictionaryEnumerateKeysAndObjects( CFDictionaryRef ref, CUI_DictionaryEnumerateKeysAndObjectsCallbackType callback, void *userData )
{
    [(__bridge NSDictionary *)ref enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        (*callback)(ref,(__bridge CFStringRef)key,(__bridge CFTypeRef)obj,stop,userData);
    }];
}

void DictionaryEnumerateKeysAndObjectsWithOptions( CFDictionaryRef ref, NSEnumerationOptions options, CUI_DictionaryEnumerateKeysAndObjectsCallbackType callback, void *userData )
{
    [(__bridge NSDictionary *)ref enumerateKeysAndObjectsWithOptions:options usingBlock:^(NSString *key, id obj, BOOL *stop) {
        (*callback)(ref,(__bridge CFStringRef)key,(__bridge CFTypeRef)obj,stop,userData);
    }];
}

// sorting
CFArrayRef DictionaryKeysSortedByValueUsingSelector( CFDictionaryRef ref, CFStringRef selector )
{ return (__bridge CFArrayRef)[(__bridge NSDictionary *)ref keysSortedByValueUsingSelector:NSSelectorFromString((__bridge NSString *)selector)]; }

CFArrayRef DictionaryKeysSortedByValueUsingComparator( CFDictionaryRef ref, CUI_DictionaryKeysSortedByValueComparatorType comparator, void *userData )
{
    return (__bridge CFArrayRef)[(__bridge NSDictionary *)ref keysSortedByValueUsingComparator:^(id obj1, id obj2) {
        return (*comparator)(ref,obj1,obj2,userData);
    }];
}

CFArrayRef DictionaryKeysSortedByValueWithOptionsUsingComparator( CFDictionaryRef ref, NSSortOptions options, CUI_DictionaryKeysSortedByValueComparatorType comparator, void *userData )
{
    return (__bridge CFArrayRef)[(__bridge NSDictionary *)ref keysSortedByValueWithOptions:options usingComparator:^(id obj1, id obj2) {
        return (*comparator)(ref,obj1,obj2,userData);
    }];
}

// Filtering
CFSetRef DictionaryKeysOfEntriesPassingTest( CFDictionaryRef ref, CUI_DictionaryKeysOfEntriesPassingTestType callback, void *userData )
{
    return (__bridge CFSetRef)[(__bridge NSDictionary *)ref keysOfEntriesPassingTest:^(id key, id obj, BOOL *stop) {
        return (*callback)(ref,key,obj,stop,userData);
    }];
}

CFSetRef DictionaryKeysWithOptionsOfEntriesPassingTest( CFDictionaryRef ref, NSEnumerationOptions options, CUI_DictionaryKeysOfEntriesPassingTestType callback, void *userData )
{
    return (__bridge CFSetRef)[(__bridge NSDictionary *)ref keysOfEntriesWithOptions:options passingTest:^(id key, id obj, BOOL *stop) {
        return (*callback)(ref,key,obj,stop,userData);
    }];
}

// - file attributes -
UInt64 DictionaryFileSize( CFDictionaryRef ref )
{ return [(__bridge NSDictionary *)ref fileSize]; }

CFStringRef DictionaryFileType( CFDictionaryRef ref )
{ return (__bridge CFStringRef)[(__bridge NSDictionary *)ref fileType]; }

CFDateRef DictionaryFileCreationDate( CFDictionaryRef ref )
{ return (__bridge CFDateRef)[(__bridge NSDictionary *)ref fileCreationDate]; }

CFDateRef DictionaryFileModificationDate( CFDictionaryRef ref )
{ return (__bridge CFDateRef)[(__bridge NSDictionary *)ref fileModificationDate]; }

NSUInteger DictionaryFilePosixPermissions( CFDictionaryRef ref )
{ return [(__bridge NSDictionary *)ref filePosixPermissions]; }

CFNumberRef DictionaryFileOwnerAccountID( CFDictionaryRef ref )
{ return (__bridge CFNumberRef)[(__bridge NSDictionary *)ref fileOwnerAccountID]; }

CFStringRef DictionaryFileOwnerAccountName( CFDictionaryRef ref )
{ return (__bridge CFStringRef)[(__bridge NSDictionary *)ref fileOwnerAccountName]; }

CFNumberRef DictionaryFileGroupOwnerAccountID( CFDictionaryRef ref )
{ return (__bridge CFNumberRef)[(__bridge NSDictionary *)ref fileGroupOwnerAccountID]; }

CFStringRef DictionaryFileGroupOwnerAccountName( CFDictionaryRef ref )
{ return (__bridge CFStringRef)[(__bridge NSDictionary *)ref fileGroupOwnerAccountName]; }

BOOL DictionaryFileExtensionHidden( CFDictionaryRef ref )
{ return [(__bridge NSDictionary *)ref fileExtensionHidden]; }

BOOL DictionaryFileIsImmutable( CFDictionaryRef ref )
{ return [(__bridge NSDictionary *)ref fileIsImmutable]; }

BOOL DictionaryFileIsAppendOnly( CFDictionaryRef ref )
{ return [(__bridge NSDictionary *)ref fileIsAppendOnly]; }

NSUInteger DictionaryFileSystemFileNumber( CFDictionaryRef ref )
{ return [(__bridge NSDictionary *)ref fileSystemFileNumber]; }

NSInteger DictionaryFileSystemNumber( CFDictionaryRef ref )
{ return [(__bridge NSDictionary *)ref fileSystemNumber]; }

OSType DictionaryFileHFSTypeCode( CFDictionaryRef ref )
{ return [(__bridge NSDictionary *)ref fileHFSTypeCode]; }

OSType DictionaryFileHFSCreatorCode( CFDictionaryRef ref )
{ return [(__bridge NSDictionary *)ref fileHFSCreatorCode]; }

// Description
CFStringRef DictionaryDescription( CFDictionaryRef ref )
{ return (__bridge CFStringRef)[(__bridge NSDictionary *)ref description]; }

CFStringRef DictionaryDescriptionInStringsFileFormat( CFDictionaryRef ref )
{ return (__bridge CFStringRef)[(__bridge NSDictionary *)ref descriptionInStringsFileFormat]; }

CFStringRef DictionaryDescriptionWithLocale( CFDictionaryRef ref, CFLocaleRef locale )
{ return (__bridge CFStringRef)[(__bridge NSDictionary *)ref descriptionWithLocale:(__bridge id)locale]; }

CFStringRef DictionaryDescriptionWithLocaleIndent( CFDictionaryRef ref, CFLocaleRef locale, NSUInteger indent )
{ return (__bridge CFStringRef)[(__bridge NSDictionary *)ref descriptionWithLocale:(__bridge id)locale indent:indent]; }


#pragma mark - Convenience functions
CFDictionaryRef DictionaryWithJSONString( CFStringRef string, NSError **err )
{
    NSData *data = [(__bridge NSString *)string dataUsingEncoding:NSUTF8StringEncoding];
    if ( data ) {
        id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:err];
        if ( obj ) return (__bridge CFDictionaryRef)obj;
    }
    return nil;
}


#pragma mark - mutable dictionary
// Class
Class MutableDictionaryClass( void )
{ return [NSMutableDictionary class]; }

// Create
CFMutableDictionaryRef MutableDictionaryNew( void )
{
#if __has_feature(objc_arc)
    return (__bridge CFMutableDictionaryRef)[NSMutableDictionary new];
#else
    return (__bridge CFMutableDictionaryRef)[[NSMutableDictionary new] autorelease];
#endif
}

CFMutableDictionaryRef MutableDictionaryWithCapacity( NSUInteger numItems )
{ return (__bridge CFMutableDictionaryRef)[NSMutableDictionary dictionaryWithCapacity:numItems]; }

CFMutableDictionaryRef MutableDictionaryWithSharedKeySet( CFTypeRef keyset )
{ return (__bridge CFMutableDictionaryRef)[NSMutableDictionary dictionaryWithSharedKeySet:(__bridge id)keyset]; }

CFMutableDictionaryRef MutableDictionaryWithContentsOfURL( CFURLRef url )
{ return (__bridge CFMutableDictionaryRef)[NSMutableDictionary dictionaryWithContentsOfURL:(__bridge NSURL *)url]; }

CFMutableDictionaryRef MutableDictionaryWithDictionary( CFDictionaryRef ref )
{ return (__bridge CFMutableDictionaryRef)[NSMutableDictionary dictionaryWithDictionary:(__bridge NSDictionary *)ref]; }

CFMutableDictionaryRef MutableDictionaryWithObjectForKey( CFTypeRef obj, CFStringRef key )
{ return (__bridge CFMutableDictionaryRef)[NSMutableDictionary dictionaryWithObject:(__bridge id)obj forKey:(__bridge NSString *)key]; }

CFMutableDictionaryRef MutableDictionaryWithObjects( CFTypeRef obj, ... )
{
    va_list ap;
    va_start( ap, obj );
    NSMutableDictionary *ref = [NSMutableDictionary dictionaryWithCapacity:0];
    while ( obj ) {
        NSString *key = va_arg( ap, id );
        if ( key == NULL ) break;
        [ref setObject:(__bridge id)obj forKey:key];
        obj = (__bridge CFTypeRef)va_arg( ap, id );
    }
    va_end( ap );
    return (__bridge CFMutableDictionaryRef)ref;
}

CFMutableDictionaryRef MutableDictionaryWithObjectsForKeys( CFArrayRef objects, CFArrayRef keys )
{ return (__bridge CFMutableDictionaryRef)[NSMutableDictionary dictionaryWithObjects:(__bridge NSArray *)objects forKeys:(__bridge NSArray *)keys]; }

// Add
void MutableDictionarySetObjectForKey( CFMutableDictionaryRef ref, CFTypeRef obj, CFTypeRef key )
{ [(__bridge NSMutableDictionary *)ref setObject:(__bridge id)obj forKey:(__bridge id)key]; }

void MutableDictionarySetValueForKey( CFMutableDictionaryRef ref, CFTypeRef value, CFStringRef key )
{ [(__bridge NSMutableDictionary *)ref setValue:(__bridge id)value forKey:(__bridge NSString *)key]; }

void MutableDictionaryAddEntriesFromDictionary( CFMutableDictionaryRef ref, CFDictionaryRef otherDict )
{ [(__bridge NSMutableDictionary *)ref addEntriesFromDictionary:(__bridge NSDictionary *)otherDict]; }

void MutableDictionarySetDictionary( CFMutableDictionaryRef ref, CFDictionaryRef otherDict )
{ [(__bridge NSMutableDictionary *)ref setDictionary:(__bridge NSDictionary *)otherDict]; }

// Remove
void MutableDictionaryRemoveObjectForKey( CFMutableDictionaryRef ref, CFTypeRef key )
{ [(__bridge NSMutableDictionary *)ref removeObjectForKey:(__bridge id)key]; }

void MutableDictionaryRemoveAllObjects( CFMutableDictionaryRef ref )
{ [(__bridge NSMutableDictionary *)ref removeAllObjects]; }

void MutableDictionaryRemoveObjectsForKeys( CFMutableDictionaryRef ref, CFArrayRef keys )
{ [(__bridge NSMutableDictionary *)ref removeObjectsForKeys:(__bridge NSArray *)keys]; }


#pragma mark - Convenience function
CFMutableDictionaryRef MutableDictionaryWithJSONString( CFStringRef string, NSError **err )
{
    NSData *data = [(__bridge NSString *)string dataUsingEncoding:NSUTF8StringEncoding];
    if ( data ) {
        id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:err];
        if ( obj ) return (__bridge CFMutableDictionaryRef)obj;
    }
    return nil;
}


