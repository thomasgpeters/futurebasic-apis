/*
 PointerArray.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class PointerArrayClass( void );

// - create -
NSPointerArray *PointerArrayWithOptions( NSPointerFunctionsOptions options );
NSPointerArray *PointerArrayWithPointerFunctions( NSPointerFunctions *pf );
NSPointerArray *PointerArrayStrongObjects( void );
NSPointerArray *PointerArrayWeakObjects( void );

// - manage -
NSUInteger PointerArrayCount( NSPointerArray *ref );
CFArrayRef PointerArrayAllObjects( NSPointerArray *ref );
void *PointerArrayPointerAtIndex( NSPointerArray *ref, NSUInteger index );
void PointerArrayAddPointer( NSPointerArray *ref, void *p );
void PointerArrayRemovePointerAtIndex( NSPointerArray *ref, NSUInteger index );
void PointerArrayInsertPointerAtIndex( NSPointerArray *ref, void *p, NSUInteger index );
void PointerArrayReplacePointerAtIndex( NSPointerArray *ref, void *p, NSUInteger index );
void PointerArrayCompact( NSPointerArray *ref );

// - pointer functions -
NSPointerFunctions *PointerArrayPointerFunctions( NSPointerArray *ref );


#pragma mark - Convenience
CFTypeRef PointerArrayObjectAtIndex( NSPointerArray *ref, NSUInteger index );
void PointerArrayAddObject( NSPointerArray *ref, CFTypeRef obj );
void PointerArrayInsertObjectAtIndex( NSPointerArray *ref, CFTypeRef obj, NSUInteger index );
void PointerArrayReplaceObjectAtIndex( NSPointerArray *ref, CFTypeRef obj, NSUInteger index );
