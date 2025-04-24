/*
 HashTable.m

 Bernie Wylde
 */

#import "HashTable.h"

// Class
Class HashTableClass( void )
{ return [NSHashTable class]; }

// Init
NSHashTable *HashTableWithOptions( NSPointerFunctionsOptions options )
{ return [NSHashTable hashTableWithOptions:options]; }

NSHashTable *HashTableWithOptionsAndCapacity( NSPointerFunctionsOptions options, NSUInteger initialCapacity )
{ return [[NSHashTable alloc] initWithOptions:options capacity:initialCapacity]; }

NSHashTable *HashTableWithPointerFunctions( NSPointerFunctions *functions, NSUInteger initialCapacity )
{ return [[NSHashTable alloc] initWithPointerFunctions:functions capacity:initialCapacity]; }

// Convenience constructors
NSHashTable *HashTableWeakObjects( void )
{ return [NSHashTable weakObjectsHashTable]; }

// Content
CFTypeRef HashTableAnyObject( NSHashTable *ref )
{ return (__bridge CFTypeRef)[ref anyObject]; }

CFArrayRef HashTableAllObjects( NSHashTable *ref )
{ return (__bridge CFArrayRef)[ref allObjects]; }

CFSetRef HashTableSetRepresentation( NSHashTable *ref )
{ return (__bridge CFSetRef)[ref setRepresentation]; }

NSUInteger HashTableCount( NSHashTable *ref )
{ return [ref count]; }

BOOL HashTableContainsObject( NSHashTable *ref, CFTypeRef obj )
{ return [ref containsObject:(__bridge id)obj]; }

CFTypeRef HashTableMember( NSHashTable *ref, CFTypeRef obj )
{ return (__bridge CFTypeRef)[ref member:(__bridge id)obj]; }

NSEnumerator *HashTableObjectEnumerator( NSHashTable *ref )
{ return [ref objectEnumerator]; }

// Manipulate membership
void HashTableAddObject( NSHashTable *ref, CFTypeRef obj )
{ [ref addObject:(__bridge id)obj]; }

void HashTableRemoveObject( NSHashTable *ref, CFTypeRef obj )
{ [ref removeObject:(__bridge id)obj]; }

void HashTableRemoveAllObjects( NSHashTable *ref )
{ [ref removeAllObjects]; }

// Compare
void HashTableIntersect( NSHashTable *ref, NSHashTable *other )
{ [ref intersectHashTable:other]; }

BOOL HashTableIntersects( NSHashTable *ref, NSHashTable *other )
{ return [ref intersectsHashTable:other]; }

BOOL HashTableIsSubset( NSHashTable *ref, NSHashTable *other )
{ return [ref isSubsetOfHashTable:other]; }

BOOL HashTableIsEqual( NSHashTable *ref, NSHashTable *other )
{ return [ref isEqualToHashTable:other]; }

// Set functions
void HashTableMinus( NSHashTable *ref, NSHashTable *other )
{ [ref minusHashTable:other]; }

void HashTableUnion( NSHashTable *ref, NSHashTable *other )
{ [ref unionHashTable:other]; }

// Pointer functions
NSPointerFunctions *HashTablePointerFunctions( NSHashTable *ref )
{ return [ref pointerFunctions]; }

