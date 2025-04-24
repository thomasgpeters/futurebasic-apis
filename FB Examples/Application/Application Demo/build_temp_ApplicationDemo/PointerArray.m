/*
 PointerArray.m

 Bernie Wylde
 */

#import "PointerArray.h"

// Class
Class PointerArrayClass( void )
{ return [NSPointerArray class]; }

// - create -
NSPointerArray *PointerArrayWithOptions( NSPointerFunctionsOptions options )
{ return [NSPointerArray pointerArrayWithOptions:options]; }

NSPointerArray *PointerArrayWithPointerFunctions( NSPointerFunctions *pf )
{ return [NSPointerArray pointerArrayWithPointerFunctions:pf]; }

NSPointerArray *PointerArrayStrongObjects( void )
{ return [NSPointerArray strongObjectsPointerArray]; }

NSPointerArray *PointerArrayWeakObjects( void )
{ return [NSPointerArray weakObjectsPointerArray]; }

// - manage -
NSUInteger PointerArrayCount( NSPointerArray *ref )
{ return [ref count]; }

CFArrayRef PointerArrayAllObjects( NSPointerArray *ref )
{ return (__bridge CFArrayRef)[ref allObjects]; }

void *PointerArrayPointerAtIndex( NSPointerArray *ref, NSUInteger index )
{ return [ref pointerAtIndex:index]; }

void PointerArrayAddPointer( NSPointerArray *ref, void *p )
{ [ref addPointer:p]; }

void PointerArrayRemovePointerAtIndex( NSPointerArray *ref, NSUInteger index )
{ [ref removePointerAtIndex:index]; }

void PointerArrayInsertPointerAtIndex( NSPointerArray *ref, void *p, NSUInteger index )
{ [ref insertPointer:p atIndex:index]; }

void PointerArrayReplacePointerAtIndex( NSPointerArray *ref, void *p, NSUInteger index )
{ [ref replacePointerAtIndex:index withPointer:p]; }

void PointerArrayCompact( NSPointerArray *ref )
{ [ref compact]; }

// - pointer functions -
NSPointerFunctions *PointerArrayPointerFunctions( NSPointerArray *ref )
{ return [ref pointerFunctions]; }


#pragma mark - Convenience
CFTypeRef PointerArrayObjectAtIndex( NSPointerArray *ref, NSUInteger index )
{ return (CFTypeRef)[ref pointerAtIndex:index]; }

void PointerArrayAddObject( NSPointerArray *ref, CFTypeRef obj )
{ [ref addPointer:(void *)obj]; }

void PointerArrayInsertObjectAtIndex( NSPointerArray *ref, CFTypeRef obj, NSUInteger index )
{ [ref insertPointer:(void *)obj atIndex:index]; }

void PointerArrayReplaceObjectAtIndex( NSPointerArray *ref, CFTypeRef obj, NSUInteger index )
{ [ref replacePointerAtIndex:index withPointer:(void *)obj]; }
