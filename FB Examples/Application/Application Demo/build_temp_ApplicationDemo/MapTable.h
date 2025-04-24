/*
 MapTable.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class MapTableClass( void );

// Create
NSMapTable *MapTableWithOptions( NSPointerFunctionsOptions keyOptions, NSPointerFunctionsOptions valueOptions );
NSMapTable *MapTableWithOptionsAndCapacity( NSPointerFunctionsOptions keyOptions, NSPointerFunctionsOptions valueOptions, NSUInteger initialCapacity );
NSMapTable *MapTableWithPointerFunctions( NSPointerFunctions *keyFunctions, NSPointerFunctions *valueFunctions, NSUInteger initialCapacity );
NSMapTable *MapTableStrongToStrongObjects( void );
NSMapTable *MapTableWeakToStrongObjects( void );
NSMapTable *MapTableStrongToWeakObjects( void );
NSMapTable *MapTableWeakToWeakObjects( void );

// Accessing content
CFTypeRef MapTableObjectForKey( NSMapTable *ref, CFStringRef key );
NSEnumerator *MapTableKeyEnumerator( NSMapTable *ref );
NSEnumerator *MapTableObjectEnumerator( NSMapTable *ref );
NSUInteger MapTableCount( NSMapTable *ref );

// Manipulating content
void MapTableSetObjectForKey( NSMapTable *ref, CFTypeRef obj, CFStringRef key );
void MapTableRemoveObjectForKey( NSMapTable *ref, CFStringRef key );
void MapTableRemoveAllObjects( NSMapTable *ref );

// Dictionary representation
CFDictionaryRef MapTableDictionaryRepresentation( NSMapTable *ref );

// Pointer functions
NSPointerFunctions *MapTableKeyPointerFunctions( NSMapTable *ref );
NSPointerFunctions *MapTableValuePointerFunctions( NSMapTable *ref );

