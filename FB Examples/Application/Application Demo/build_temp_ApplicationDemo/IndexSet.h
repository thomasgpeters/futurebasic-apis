/*
 IndexSet.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef void (*CUI_IndexSetRangeCallbackType)(NSIndexSet *,CFRange,BOOL*,void*);
typedef void (*CUI_IndexSetIndexCallbackType)(NSIndexSet *,NSUInteger,BOOL*,void*);
typedef BOOL (*CUI_IndexSetIndexPredicateType)(NSIndexSet *,NSUInteger,BOOL*,void*);

// Class
Class IndexSetClass( void );

NSIndexSet *IndexSetInit( void );
NSIndexSet *IndexSetWithIndex( NSUInteger value );
NSIndexSet *IndexSetWithIndexesInRange( CFRange range );

BOOL IndexSetContainsIndex( NSIndexSet *ref, NSUInteger index );
BOOL IndexSetContainsIndexes( NSIndexSet *ref, NSIndexSet *subset );
BOOL IndexSetContainsIndexesInRange( NSIndexSet *ref, CFRange range );
BOOL IndexSetIntersectsIndexesInRange( NSIndexSet *ref, CFRange range );
NSUInteger IndexSetCount( NSIndexSet *ref );
NSUInteger IndexSetCountOfIndexesInRange( NSIndexSet *ref, CFRange range );
NSUInteger IndexSetIndexPassingTest( NSIndexSet *ref, CUI_IndexSetIndexPredicateType predicate, void *userData );
NSIndexSet *IndexSetIndexesPassingTest( NSIndexSet *ref, CUI_IndexSetIndexPredicateType predicate, void *userData );
NSUInteger IndexSetIndexWithOptionsPassingTest( NSIndexSet *ref, NSEnumerationOptions options, CUI_IndexSetIndexPredicateType predicate, void *userData );
NSIndexSet *IndexSetIndexesWithOptionsPassingTest( NSIndexSet *ref, NSEnumerationOptions options, CUI_IndexSetIndexPredicateType predicate, void *userData );
NSUInteger IndexSetIndexInRangePassingTest( NSIndexSet *ref, CFRange range, NSEnumerationOptions options, CUI_IndexSetIndexPredicateType predicate, void *userData );
NSIndexSet *IndexSetIndexesInRangePassingTest( NSIndexSet *ref, CFRange range, NSEnumerationOptions options, CUI_IndexSetIndexPredicateType predicate, void *userData );

// enumerate content
void IndexSetEnumerateRangesInRange( NSIndexSet *ref, CFRange inRange, NSEnumerationOptions options, CUI_IndexSetRangeCallbackType callback, void *userData );
void IndexSetEnumerateRanges( NSIndexSet *ref, CUI_IndexSetRangeCallbackType callback, void *userData );
void IndexSetEnumerateRangesWithOptions( NSIndexSet *ref, NSEnumerationOptions options, CUI_IndexSetRangeCallbackType callback, void *userData );

BOOL IndexSetIsEqual( NSIndexSet *ref1, NSIndexSet *ref2 );

NSUInteger IndexSetFirstIndex( NSIndexSet *ref );
NSUInteger IndexSetLastIndex( NSIndexSet *ref );
NSUInteger IndexSetIndexLessThan( NSIndexSet *ref, NSUInteger value );
NSUInteger IndexSetIndexLessThanOrEqualTo( NSIndexSet *ref, NSUInteger value );
NSUInteger IndexSetIndexGreaterThanOrEqualTo( NSIndexSet *ref, NSUInteger value );
NSUInteger IndexSetIndexGreaterThan( NSIndexSet *ref, NSUInteger value );
NSUInteger InsetSetGetIndexes( NSIndexSet *ref, NSUInteger *indexBuffer, NSUInteger maxCount, CFRange *indexRange );

// Enumerate indexes
void IndexSetEnumerateIndexes( NSIndexSet *ref, CUI_IndexSetIndexCallbackType callback, void *userData );
void IndexSetEnumerateIndexesWithOptions( NSIndexSet *ref, NSEnumerationOptions options, CUI_IndexSetIndexCallbackType callback, void *userData );
void IndexSetEnumerateIndexesInRange( NSIndexSet *ref, CFRange range, NSEnumerationOptions options, CUI_IndexSetIndexCallbackType callback, void *userData );

// Custom
NSIndexSet *IndexSetWithIndexes( NSInteger index, ... );
CFArrayRef IndexSetIndexArray( NSIndexSet *ref );

#pragma mark - MutableIndexSet
// Class
Class MutableIndexSetClass( void );

NSMutableIndexSet *MutableIndexSetInit( void );
NSMutableIndexSet *MutableIndexSetNew( void );
NSMutableIndexSet *MutableIndexSetWithIndex( NSUInteger index );
NSMutableIndexSet *MutableIndexSetWithIndexesInRange( CFRange range );

void MutableIndexSetAddIndex( NSMutableIndexSet *ref, NSUInteger index );
void MutableIndexSetAddIndexes( NSMutableIndexSet *ref, NSIndexSet *otherSet );
void MutableIndexSetAddIndexesInRange( NSMutableIndexSet *ref, CFRange range );
void MutableIndexSetRemoveIndex( NSMutableIndexSet *ref, NSUInteger index );
void MutableIndexSetRemoveIndexes( NSMutableIndexSet *ref, NSIndexSet *otherSet );
void MutableIndexSetRemoveAllIndexes( NSMutableIndexSet *ref );
void MutableIndexSetRemoveIndexesInRange( NSMutableIndexSet *ref, CFRange range );
void MutableIndexSetShiftIndexes( NSMutableIndexSet *ref, NSUInteger index, NSInteger delta );

