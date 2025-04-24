/*
 Array.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

typedef void (*CUI_ArrayEnumerateObjectsCallbackType)(CFArrayRef,CFTypeRef,NSUInteger,BOOL*,void*);
typedef BOOL (*CUI_ArrayTestCallbackType)(CFArrayRef,CFTypeRef,NSUInteger,BOOL*,void*);
typedef NSInteger (*CUI_ArraySortedArrayFunctionType)(id,id,void*);
typedef BOOL (*CUI_ArrayDifferenceFromArrayFunctionType)(id,id,void*);

// Class
Class ArrayClass( void );

// Create
CFArrayRef ArrayWithArray( CFArrayRef ref );
//CFArrayRef ArrayWithContentsOfURL( CFURLRef url );
CFArrayRef ArrayWithContentsOfURL( CFURLRef url, NSError **err );
CFArrayRef ArrayWithObject( CFTypeRef obj );
CFArrayRef ArrayWithObjects( CFTypeRef obj, ... );

BOOL ArrayContainsObject( CFArrayRef ref, CFTypeRef obj );
NSUInteger ArrayCount( CFArrayRef ref );

CFTypeRef ArrayFirstObject( CFArrayRef ref );
CFTypeRef ArrayLastObject( CFArrayRef ref );

CFTypeRef ArrayObjectAtIndex( CFArrayRef ref, NSUInteger index );
CFArrayRef ArrayObjectsAtIndexes( CFArrayRef ref, NSIndexSet *indexes );
NSEnumerator *ArrayObjectEnumerator( CFArrayRef ref );
NSEnumerator *ArrayReverseObjectEnumerator( CFArrayRef ref );

// Find
NSUInteger ArrayIndexOfObject( CFArrayRef ref, CFTypeRef obj );
NSUInteger ArrayIndexOfObjectInRange( CFArrayRef ref, CFTypeRef obj, CFRange range );
NSUInteger ArrayIndexOfObjectIdenticalTo( CFArrayRef ref, CFTypeRef obj );
NSUInteger ArrayIndexOfObjectPassingTest( CFArrayRef ref, CUI_ArrayTestCallbackType testFn, void *userData );
NSUInteger ArrayIndexOfObjectWithOptionsPassingTest( CFArrayRef ref, NSEnumerationOptions options, CUI_ArrayTestCallbackType testFn, void *userData );
NSUInteger ArrayIndexOfObjectAtIndexesPassingTest( CFArrayRef ref, NSIndexSet *indexSet, NSEnumerationOptions options, CUI_ArrayTestCallbackType testFn, void *userData );
NSIndexSet *ArrayIndexesOfObjectsPassingTest( CFArrayRef ref, CUI_ArrayTestCallbackType testFn, void *userData );
NSIndexSet *ArrayIndexesOfObjectsWithOptionsPassingTest( CFArrayRef ref, NSEnumerationOptions options, CUI_ArrayTestCallbackType testFn, void *userData );
NSIndexSet *ArrayIndexesOfObjectsAtIndexesPassingTest( CFArrayRef ref, NSIndexSet *indexSet, NSEnumerationOptions options, CUI_ArrayTestCallbackType testFn, void *userData );
NSUInteger ArrayIndexOfObjectInSortedRange( CFArrayRef ref, CFTypeRef obj, CFRange range, NSBinarySearchingOptions options, CUI_ArraySortedArrayFunctionType comparatorFn, void *userData );
NSUInteger ArrayIndexOfObjectInSortedRangeUsingComparator( CFArrayRef ref, CFTypeRef obj, CFRange range, NSBinarySearchingOptions options, CUI_ArraySortedArrayFunctionType comparatorFn, void *userData );

// Sending message to elements
void ArrayMakeObjectsPerformSelector( CFArrayRef ref, CFStringRef selector );
void ArrayMakeObjectsPerformSelectorWithObject( CFArrayRef ref, CFStringRef selector, CFTypeRef object );
void ArrayEnumerateObjects( CFArrayRef ref, CUI_ArrayEnumerateObjectsCallbackType callback, void *userData );
void ArrayEnumerateObjectsWithOptions( CFArrayRef ref, NSEnumerationOptions options, CUI_ArrayEnumerateObjectsCallbackType callback, void *userData );
void ArrayEnumerateObjectsAtIndexes( CFArrayRef ref, NSIndexSet *indexSet, NSEnumerationOptions options, CUI_ArrayEnumerateObjectsCallbackType callback, void *userData );

// Comparing arrays
CFTypeRef ArrayFirstObjectCommonWithArray( CFArrayRef array1, CFArrayRef array2 );
BOOL ArrayIsEqual( CFArrayRef array1, CFArrayRef array2 );
CFArrayRef ArrayByAddingObject( CFArrayRef ref, CFTypeRef obj );
CFArrayRef ArrayByAddingObjectsFromArray( CFArrayRef array1, CFArrayRef array2 );
CFArrayRef ArrayFilteredArrayUsingPredicate( CFArrayRef ref, NSPredicate *pred );
CFArrayRef ArraySubarrayWithRange( CFArrayRef ref, CFRange range );

// Sort
CFDataRef ArraySortedArrayHint( CFArrayRef ref );
CFArrayRef ArraySortedArrayUsingFunction( CFArrayRef ref, CUI_ArraySortedArrayFunctionType comparator, void *context );
CFArrayRef ArraySortedArrayUsingFunctionHint( CFArrayRef ref, CUI_ArraySortedArrayFunctionType comparator, void *context, CFDataRef hint );
CFArrayRef ArraySortedArrayUsingDescriptors( CFArrayRef ref, CFArrayRef descriptors );
CFArrayRef ArraySortedArrayUsingSelector( CFArrayRef ref, CFStringRef selector );

// Working with string elements
CFStringRef ArrayComponentsJoinedByString( CFArrayRef ref, CFStringRef separator );

// Description
CFStringRef ArrayDescription( CFArrayRef ref );
CFStringRef ArrayDescriptionWithLocale( CFArrayRef ref, CFLocaleRef locale );
CFStringRef ArrayDescriptionWithLocaleIndent( CFArrayRef ref, CFLocaleRef locale, NSUInteger indentLevel );

// Collecting paths
CFArrayRef ArrayPathsMatchingExtensions( CFArrayRef ref, CFArrayRef extensions );

// Key-value coding
void ArraySetValueForKey( CFArrayRef ref, CFTypeRef value, CFStringRef key );
CFTypeRef ArrayValueForKey( CFArrayRef ref, CFStringRef key );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
CFArrayRef ArrayByApplyingDifference( CFArrayRef ref, NSOrderedCollectionDifference *diff );
API_AVAILABLE(macos(10.15))
NSOrderedCollectionDifference *ArrayDifferenceFromArray( CFArrayRef ref, CFArrayRef otherArray );
API_AVAILABLE(macos(10.15))
NSOrderedCollectionDifference *ArrayDifferenceFromArrayWithOptions( CFArrayRef ref, CFArrayRef otherArray, NSOrderedCollectionDifferenceCalculationOptions options );
API_AVAILABLE(macos(10.15))
NSOrderedCollectionDifference *ArrayDifferenceFromArrayUsingEquivalenceTest( CFArrayRef ref, CFArrayRef otherArray, NSOrderedCollectionDifferenceCalculationOptions options, CUI_ArrayDifferenceFromArrayFunctionType fnAddress, void *userData );
#endif// 101500

//BOOL ArrayWriteToURLAtomically( CFArrayRef ref, CFURLRef url, BOOL atomically );
BOOL ArrayWriteToURL( CFArrayRef ref, CFURLRef url, NSError **err );


#pragma mark - NSScriptWhoseTests
BOOL ArrayDoesContain( CFArrayRef ref, ObjectRef obj );

#pragma mark - JSON convenience functions
CFArrayRef ArrayWithJSONString( CFStringRef string, NSError **err );


#pragma mark - mutable array
// Class
Class MutableArrayClass( void );

// Create
CFMutableArrayRef MutableArrayNew( void );
CFMutableArrayRef MutableArrayWithCapacity( NSUInteger numItems );
CFMutableArrayRef MutableArrayWithContentsOfURL( CFURLRef url );
CFMutableArrayRef MutableArrayWithArray( CFArrayRef array );
CFMutableArrayRef MutableArrayWithObject( CFTypeRef obj );
CFMutableArrayRef MutableArrayWithObjects( CFTypeRef obj, ... );

void MutableArrayAddObject( CFMutableArrayRef ref, CFTypeRef obj );
void MutableArrayAddObjectsFromArray( CFMutableArrayRef ref, CFArrayRef otherArray );
void MutableArrayInsertObjectAtIndex( CFMutableArrayRef ref, CFTypeRef obj, NSUInteger index );
void MutableArrayInsertObjectsAtIndexes( CFMutableArrayRef ref, CFArrayRef objects, NSIndexSet *indexes );
void MutableArrayRemoveAllObjects( CFMutableArrayRef ref );
void MutableArrayRemoveLastObject( CFMutableArrayRef ref );
void MutableArrayRemoveObject( CFMutableArrayRef ref, CFTypeRef obj );
void MutableArrayRemoveObjectInRange( CFMutableArrayRef ref, CFTypeRef obj, CFRange range );
void MutableArrayRemoveObjectAtIndex( CFMutableArrayRef ref, NSUInteger index );
void MutableArrayRemoveObjectsAtIndexes( CFMutableArrayRef ref, NSIndexSet *indexes );
void MutableArrayRemoveObjectsInArray( CFMutableArrayRef ref, CFArrayRef objects );
void MutableArrayRemoveObjectsInRange( CFMutableArrayRef ref, CFRange range );
void MutableArrayReplaceObjectAtIndex( CFMutableArrayRef ref, CFTypeRef obj, NSUInteger index );
void MutableArrayReplaceObjectsAtIndexes( CFMutableArrayRef ref, CFArrayRef objects, NSIndexSet *indexes );
void MutableArraySetArray( CFMutableArrayRef ref, CFArrayRef otherArray );

// Filter content
void MutableArrayFilterUsingPredicate( CFMutableArrayRef ref, NSPredicate *predicate );

// Rearrange content
void MutableArrayExchangeObjects( CFMutableArrayRef ref, NSUInteger index1, NSUInteger index2 );
void MutableArraySortUsingDescriptors( CFMutableArrayRef ref, CFArrayRef descriptors );
void MutableArraySortUsingFunction( CFMutableArrayRef ref, CUI_ArraySortedArrayFunctionType comparator, void *context );
void MutableArraySortUsingSelector( CFMutableArrayRef ref, CFStringRef selector );

// Instance method
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
void MutableArrayApplyDifference( CFMutableArrayRef ref, NSOrderedCollectionDifference *diff );
#endif// 101500

#pragma mark - Convenience
void MutableArrayAddObjects( CFMutableArrayRef ref, CFTypeRef obj, ... );

#pragma mark - JSON convenience function
CFMutableArrayRef MutableArrayWithJSONString( CFStringRef string, NSError **err );
