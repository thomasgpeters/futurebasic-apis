/*
 MapTable.m

 Bernie Wylde
 */

#import "MapTable.h"

// Class
Class MapTableClass( void )
{ return [NSMapTable class]; }

// Create
NSMapTable *MapTableWithOptions( NSPointerFunctionsOptions keyOptions, NSPointerFunctionsOptions valueOptions )
{ return [NSMapTable mapTableWithKeyOptions:keyOptions valueOptions:valueOptions]; }

NSMapTable *MapTableWithOptionsAndCapacity( NSPointerFunctionsOptions keyOptions, NSPointerFunctionsOptions valueOptions, NSUInteger initialCapacity )
{
#if __has_feature(objc_arc)
    return [[NSMapTable alloc] initWithKeyOptions:keyOptions valueOptions:valueOptions capacity:initialCapacity];
#else
    return [[[NSMapTable alloc] initWithKeyOptions:keyOptions valueOptions:valueOptions capacity:initialCapacity] autorelease];
#endif
}

NSMapTable *MapTableWithPointerFunctions( NSPointerFunctions *keyFunctions, NSPointerFunctions *valueFunctions, NSUInteger initialCapacity )
{
#if __has_feature(objc_arc)
    return [[NSMapTable alloc] initWithKeyPointerFunctions:keyFunctions valuePointerFunctions:valueFunctions capacity:initialCapacity];
#else
    return [[[NSMapTable alloc] initWithKeyPointerFunctions:keyFunctions valuePointerFunctions:valueFunctions capacity:initialCapacity] autorelease];
#endif
}

NSMapTable *MapTableStrongToStrongObjects( void )
{ return [NSMapTable strongToStrongObjectsMapTable]; }

NSMapTable *MapTableWeakToStrongObjects( void )
{ return [NSMapTable weakToStrongObjectsMapTable]; }

NSMapTable *MapTableStrongToWeakObjects( void )
{ return [NSMapTable strongToWeakObjectsMapTable]; }

NSMapTable *MapTableWeakToWeakObjects( void )
{ return [NSMapTable weakToWeakObjectsMapTable]; }

// Accessing content
CFTypeRef MapTableObjectForKey( NSMapTable *ref, CFStringRef key )
{ return (__bridge CFTypeRef)[ref objectForKey:(__bridge NSString *)key]; }

NSEnumerator *MapTableKeyEnumerator( NSMapTable *ref )
{ return [ref keyEnumerator]; }

NSEnumerator *MapTableObjectEnumerator( NSMapTable *ref )
{ return [ref objectEnumerator]; }

NSUInteger MapTableCount( NSMapTable *ref )
{ return [ref count]; }

// Manipulating content
void MapTableSetObjectForKey( NSMapTable *ref, CFTypeRef obj, CFStringRef key )
{ [ref setObject:(__bridge id)obj forKey:(__bridge NSString *)key]; }

void MapTableRemoveObjectForKey( NSMapTable *ref, CFStringRef key )
{ [ref removeObjectForKey:(__bridge NSString *)key]; }

void MapTableRemoveAllObjects( NSMapTable *ref )
{ [ref removeAllObjects]; }

// Dictionary representation
CFDictionaryRef MapTableDictionaryRepresentation( NSMapTable *ref )
{ return (__bridge CFDictionaryRef)[ref dictionaryRepresentation]; }

// Pointer functions
NSPointerFunctions *MapTableKeyPointerFunctions( NSMapTable *ref )
{ return [ref keyPointerFunctions]; }

NSPointerFunctions *MapTableValuePointerFunctions( NSMapTable *ref )
{ return [ref valuePointerFunctions]; }

