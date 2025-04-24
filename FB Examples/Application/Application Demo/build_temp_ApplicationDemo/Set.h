/*
 Set.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef void (*CUI_SetEnumerateObjectsCallbackType)(CFSetRef,CFTypeRef,BOOL*,void*);
typedef BOOL (*CUI_SetTestObjectsCallbackType)(CFSetRef,CFTypeRef,BOOL*,void*);
typedef void (*CUI_SetEnumerateIndexPathsCallbackType)(CFSetRef,NSIndexPath *,BOOL*,void*);

// Class
Class SetClass( void );

// Create
CFSetRef SetWithArray( CFArrayRef array );
CFSetRef SetWithObject( CFTypeRef obj );
CFSetRef SetWithObjects( CFTypeRef obj, ... );
CFSetRef SetWithSet( CFSetRef set );
CFSetRef SetByAddingObject( CFSetRef ref, CFTypeRef obj );
CFSetRef SetByAddingObjectsFromSet( CFSetRef ref1, CFSetRef ref2 );
CFSetRef SetByAddingObjectsFromArray( CFSetRef ref, CFArrayRef array );

// Count
NSUInteger SetCount( CFSetRef ref );

// Members
CFArrayRef SetAllObjects( CFSetRef ref );
CFTypeRef SetAnyObject( CFSetRef ref );
BOOL SetContainsObject( CFSetRef ref, CFTypeRef obj );
CFTypeRef SetMember( CFSetRef ref, CFTypeRef obj );
NSEnumerator *SetObjectEnumerator( CFSetRef ref );
void SetEnumerateObjects( CFSetRef ref, CUI_SetEnumerateObjectsCallbackType callback, void *userData );
void SetEnumerateObjectsWithOptions( CFSetRef ref, NSEnumerationOptions options, CUI_SetEnumerateObjectsCallbackType callback, void *userData );
CFSetRef SetObjectsPassingTest( CFSetRef ref, CUI_SetTestObjectsCallbackType predicate, void *userData );
CFSetRef SetObjectsWithOptionsPassingTest( CFSetRef ref, NSEnumerationOptions options, CUI_SetTestObjectsCallbackType predicate, void *userData );

// Compare
BOOL SetIsSubsetOfSet( CFSetRef ref1, CFSetRef ref2 );
BOOL SetIntersectsSet( CFSetRef ref1, CFSetRef ref2 );
BOOL SetIsEqual( CFSetRef ref1, CFSetRef ref2 );
CFTypeRef SetValueForKey( CFSetRef ref, CFStringRef key );
void SetSetValueForKey( CFSetRef ref, CFTypeRef value, CFStringRef key );

// Sorted array
CFArrayRef SetSortedArrayUsingDescriptors( CFSetRef ref, CFArrayRef sortDescriptors );

// Description
CFStringRef SetDescription( CFSetRef ref );
CFStringRef SetDescriptionWithLocale( CFSetRef ref, CFTypeRef locale );

// Initializers
CFSetRef SetWithCollectionViewIndexPath( NSIndexPath *indexPath );
CFSetRef SetWithCollectionViewIndexPaths( CFArrayRef indexPaths );

// Instance methods
void SetEnumerateIndexPathsWithOptions( CFSetRef ref, NSEnumerationOptions options, CUI_SetEnumerateIndexPathsCallbackType callback, void *userData );


#pragma mark - mutable set
// Class
Class MutableSetClass( void );

// Create
CFMutableSetRef MutableSetNew( void );
CFMutableSetRef MutableSetWithCapacity( NSUInteger length );
CFMutableSetRef MutableSetWithArray( CFArrayRef array );
CFMutableSetRef MutableSetWithObject( CFTypeRef obj );
CFMutableSetRef MutableSetWithObjects( CFTypeRef obj, ... );
CFMutableSetRef MutableSetWithSet( CFSetRef set );

// Add/remove
void MutableSetAddObject( CFMutableSetRef ref, CFTypeRef obj );
void MutableSetRemoveObject( CFMutableSetRef ref, CFTypeRef obj );
void MutableSetRemoveAllObjects( CFMutableSetRef ref );
void MutableSetAddObjectsFromArray( CFMutableSetRef ref, CFArrayRef array );

// Combine/recombine
void MutableSetUnionSet( CFMutableSetRef ref1, CFSetRef ref2 );
void MutableSetMinusSet( CFMutableSetRef ref1, CFSetRef ref2 );
void MutableSetIntersectSet( CFMutableSetRef ref1, CFSetRef ref2 );
void MutableSetSet( CFMutableSetRef ref1, CFSetRef ref2 );


#pragma mark - counted set
// Class
Class CountedSetClass( void );

// - init -
NSCountedSet *CountedSetNew( void );
NSCountedSet *CountedSetWithArray( CFArrayRef array );
NSCountedSet *CountedSetWithSet( CFSetRef set );
NSCountedSet *CountedSetWithCapacity( NSUInteger length );

// - add/remove -
void CountedSetAddObject( NSCountedSet *ref, CFTypeRef obj );
void CountedSetRemoveObject( NSCountedSet *ref, CFTypeRef obj );

// - combine/recombine
void CountedSetUnionSet( NSCountedSet *ref, CFSetRef set );
void CountedSetMinusSet( NSCountedSet *ref, CFSetRef set );
void CountedSetIntersectSet( NSCountedSet *ref, CFSetRef set );

// - examine -
NSUInteger CountedSetCountForObject( NSCountedSet *ref, CFTypeRef obj );

// - accessing members -
NSEnumerator *CountedSetObjectEnumerator( NSCountedSet *ref );
