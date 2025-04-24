/*
 OrderedSet.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef void (*CUI_OrderedSetEnumerateObjectsCallbackType)(NSOrderedSet*,CFTypeRef,NSUInteger,BOOL*,void*);
typedef BOOL (*CUI_OrderedSetDifferenceFromOrderedSetFunctionType)(CFTypeRef,CFTypeRef,void*);
typedef NSComparisonResult (*CUI_OrderedSetComparatorType)(NSOrderedSet*,CFTypeRef,CFTypeRef,void*);

// Class
Class OrderedSetClass( void );

// Create
NSOrderedSet *OrderedSetWithArray( CFArrayRef array );
NSOrderedSet *OrderedSetWithArrayRange( CFArrayRef array, CFRange range, BOOL copyItems );
NSOrderedSet *OrderedSetWithObject( CFTypeRef obj );
NSOrderedSet *OrderedSetWithObjects( CFTypeRef obj, ... );
NSOrderedSet *OrderedSetWithOrderedSet( NSOrderedSet *set );
NSOrderedSet *OrderedSetWithSet( CFSetRef set );

// Count
NSUInteger OrderedSetCount( NSOrderedSet *ref );

// Accessing set members
BOOL OrderedSetContainsObject( NSOrderedSet *ref, CFTypeRef obj );
void OrderedSetEnumerateObjects( NSOrderedSet *ref, CUI_OrderedSetEnumerateObjectsCallbackType callback, void *userData );
void OrderedSetEnumerateObjectsWithOptions( NSOrderedSet *ref, NSEnumerationOptions options, CUI_OrderedSetEnumerateObjectsCallbackType callback, void *userData );
void OrderedSetEnumerateObjectsAtIndexes( NSOrderedSet *ref, NSIndexSet *indexSet, NSEnumerationOptions options, CUI_OrderedSetEnumerateObjectsCallbackType callback, void *userData );
CFTypeRef OrderedSetFirstObject( NSOrderedSet *ref );
CFTypeRef OrderedSetLastObject( NSOrderedSet *ref );
CFTypeRef OrderedSetObjectAtIndex( NSOrderedSet *ref, NSUInteger index );
CFArrayRef OrderedSetObjectsAtIndexes( NSOrderedSet *ref, NSIndexSet *indexes );
NSUInteger OrderedSetIndexOfObject( NSOrderedSet *ref, CFTypeRef obj );

// Key-value coding
void OrderedSetSetValueForKey( NSOrderedSet *ref, CFTypeRef value, CFStringRef key );
CFTypeRef OrderedSetValueForKey( NSOrderedSet *ref, CFStringRef key );

// Observing
BOOL OrderedSetIsEqual( NSOrderedSet *ref1, NSOrderedSet *ref2 );
BOOL OrderedSetIntersectsOrderedSet( NSOrderedSet *ref1, NSOrderedSet *ref2 );
BOOL OrderedSetIntersectsSet( NSOrderedSet *ref, CFSetRef set );
BOOL OrderedSetIsSubsetOfOrderedSet( NSOrderedSet *ref1, NSOrderedSet *ref2 );
BOOL OrderedSetIsSubsetOfSet( NSOrderedSet *ref, CFSetRef set );

// Sorted array
CFArrayRef OrderedSetSortedArrayUsingDescriptors( NSOrderedSet *ref, CFArrayRef descriptors );
CFArrayRef OrderedSetSortedArrayUsingComparator( NSOrderedSet *ref, CUI_OrderedSetComparatorType comparator, void *userData );
CFArrayRef OrderedSetSortedArrayWithOptionsUsingComparator( NSOrderedSet *ref, NSSortOptions options, CUI_OrderedSetComparatorType comparator, void *userData );

// Filtering
NSOrderedSet *OrderedSetFilteredOrderedSetUsingPredicate( NSOrderedSet *ref, NSPredicate *predicate );

// Description
CFStringRef OrderedSetDescription( NSOrderedSet *ref );
CFStringRef OrderedSetDescriptionWithLocale( NSOrderedSet *ref, CFLocaleRef locale );
CFStringRef OrderedSetDescriptionWithLocaleAndIndent( NSOrderedSet *ref, CFLocaleRef locale, NSUInteger indent );

// Converting
CFArrayRef OrderedSetArray( NSOrderedSet *ref );
CFSetRef OrderedSetSet( NSOrderedSet *ref );

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
NSOrderedSet *OrderedSetByApplyingDifference( NSOrderedSet *ref, NSOrderedCollectionDifference *diff );
API_AVAILABLE(macos(10.15))
NSOrderedCollectionDifference *OrderedSetDifferenceFromOrderedSet( NSOrderedSet *ref, NSOrderedSet *otherSet );
API_AVAILABLE(macos(10.15))
NSOrderedCollectionDifference *OrderedSetDifferenceFromOrderedSetWithOptions( NSOrderedSet *ref, NSOrderedSet *otherSet, NSOrderedCollectionDifferenceCalculationOptions options );
API_AVAILABLE(macos(10.15))
NSOrderedCollectionDifference *OrderedSetDifferenceFromOrderedSetUsingEquivalenceTest( NSOrderedSet *ref, NSOrderedSet *otherSet, NSOrderedCollectionDifferenceCalculationOptions options, CUI_OrderedSetDifferenceFromOrderedSetFunctionType fnAddress, void *userData );
#endif// 101500


#pragma mark - mutable ordered set
// Class
Class MutableOrderedSetClass( void );

// Create
NSMutableOrderedSet *MutableOrderedSetNew( void );
NSMutableOrderedSet *MutableOrderedSetWithCapacity( NSUInteger size );
NSMutableOrderedSet *MutableOrderedSetWithArray( CFArrayRef array );
NSMutableOrderedSet *MutableOrderedSetWithArrayRange( CFArrayRef array, CFRange range, BOOL copyItems );
NSMutableOrderedSet *MutableOrderedSetWithObject( CFTypeRef obj );
NSMutableOrderedSet *MutableOrderedSetWithObjects( CFTypeRef obj, ... );
NSMutableOrderedSet *MutableOrderedSetWithOrderedSet( NSOrderedSet *set );
NSMutableOrderedSet *MutableOrderedSetWithSet( CFSetRef set );

// Add, remove, reorder
void MutableOrderedSetAddObject( NSMutableOrderedSet *ref, CFTypeRef obj );
void MutableOrderedSetAddObjectsFromArray( NSMutableOrderedSet *ref, CFArrayRef array );
void MutableOrderedSetInsertObjectAtIndex( NSMutableOrderedSet *ref, CFTypeRef obj, NSUInteger index );
void MutableOrderedSetInsertObjectsAtIndexes( NSMutableOrderedSet *ref, CFArrayRef objects, NSIndexSet *indexes );
void MutableOrderedSetRemoveObject( NSMutableOrderedSet *ref, CFTypeRef obj );
void MutableOrderedSetRemoveObjectAtIndex( NSMutableOrderedSet *ref, NSUInteger index );
void MutableOrderedSetRemoveObjectsAtIndexes( NSMutableOrderedSet *ref, NSIndexSet *indexes );
void MutableOrderedSetRemoveObjectsInArray( NSMutableOrderedSet *ref, CFArrayRef array );
void MutableOrderedSetRemoveObjectsInRange( NSMutableOrderedSet *ref, CFRange range );
void MutableOrderedSetRemoveAllObjects( NSMutableOrderedSet *ref );
void MutableOrderedSetReplaceObjectAtIndex( NSMutableOrderedSet *ref, CFTypeRef obj, NSUInteger index );
void MutableOrderedSetReplaceObjectsAtIndexes( NSMutableOrderedSet *ref, CFArrayRef objects, NSIndexSet *indexes );
void MutableOrderedSetSetObjectAtIndex( NSMutableOrderedSet *ref, CFTypeRef obj, NSUInteger index );
void MutableOrderedSetMoveObjectsAtIndexesToIndex( NSMutableOrderedSet *ref, NSIndexSet *indexes, NSUInteger index );
void MutableOrderedSetExchangeObjectAtIndex( NSMutableOrderedSet *ref, NSUInteger index1, NSUInteger index2 );

// Sorting
void MutableOrderedSetSortUsingDescriptors( NSMutableOrderedSet *ref, CFArrayRef descriptors );

// Combining and recombining
void MutableOrderedSetIntersectOrderedSet( NSMutableOrderedSet *ref1, NSOrderedSet *ref2 );
void MutableOrderedSetIntersectSet( NSMutableOrderedSet *ref, CFSetRef set );
void MutableOrderedSetMinusOrderedSet( NSMutableOrderedSet *ref1, NSOrderedSet *ref2 );
void MutableOrderedSetMinusSet( NSMutableOrderedSet *ref, CFSetRef set );
void MutableOrderedSetUnionOrderedSet( NSMutableOrderedSet *ref1, NSOrderedSet *ref2 );
void MutableOrderedSetUnionSet( NSMutableOrderedSet *ref, CFSetRef set );

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
void MutableOrderedSetApplyDifference( NSMutableOrderedSet *ref, NSOrderedCollectionDifference *diff );
#endif// 101500
