/*
 HashTable.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class HashTableClass( void );

// Init
NSHashTable *HashTableWithOptions( NSPointerFunctionsOptions options );
NSHashTable *HashTableWithOptionsAndCapacity( NSPointerFunctionsOptions options, NSUInteger initialCapacity );
NSHashTable *HashTableWithPointerFunctions( NSPointerFunctions *functions, NSUInteger initialCapacity );

// Convenience constructors
NSHashTable *HashTableWeakObjects( void );

// Content
CFTypeRef HashTableAnyObject( NSHashTable *ref );
CFArrayRef HashTableAllObjects( NSHashTable *ref );
CFSetRef HashTableSetRepresentation( NSHashTable *ref );
NSUInteger HashTableCount( NSHashTable *ref );
BOOL HashTableContainsObject( NSHashTable *ref, CFTypeRef obj );
CFTypeRef HashTableMember( NSHashTable *ref, CFTypeRef obj );
NSEnumerator *HashTableObjectEnumerator( NSHashTable *ref );

// Manipulate membership
void HashTableAddObject( NSHashTable *ref, CFTypeRef obj );
void HashTableRemoveObject( NSHashTable *ref, CFTypeRef obj );
void HashTableRemoveAllObjects( NSHashTable *ref );

// Compare
void HashTableIntersect( NSHashTable *ref, NSHashTable *other );
BOOL HashTableIntersects( NSHashTable *ref, NSHashTable *other );
BOOL HashTableIsSubset( NSHashTable *ref, NSHashTable *other );
BOOL HashTableIsEqual( NSHashTable *ref, NSHashTable *other );

// Set functions
void HashTableMinus( NSHashTable *ref, NSHashTable *other );
void HashTableUnion( NSHashTable *ref, NSHashTable *other );

// Pointer functions
NSPointerFunctions *HashTablePointerFunctions( NSHashTable *ref );
