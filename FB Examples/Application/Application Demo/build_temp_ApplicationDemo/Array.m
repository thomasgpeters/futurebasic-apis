/*
 Array.m
 
 Bernie Wylde
 */

#import "Array.h"

// Class
Class ArrayClass( void )
{ return [NSArray class]; }

// Create
CFArrayRef ArrayWithArray( CFArrayRef ref )
{ return (__bridge CFArrayRef)[NSArray arrayWithArray:(__bridge NSArray *)ref]; }

//CFArrayRef ArrayWithContentsOfURL( CFURLRef url )
//{ return (__bridge CFArrayRef)[NSMutableArray arrayWithContentsOfURL:(__bridge NSURL *)url]; }

CFArrayRef ArrayWithContentsOfURL( CFURLRef url, NSError **err )
{ return (__bridge CFArrayRef)[NSArray arrayWithContentsOfURL:(__bridge NSURL *)url error:err]; }

CFArrayRef ArrayWithObject( CFTypeRef obj )
{ return (__bridge CFArrayRef)[NSArray arrayWithObject:(__bridge id)obj]; }

CFArrayRef ArrayWithObjects( CFTypeRef obj, ... )
{
    va_list ap;
    va_start( ap, obj );
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    while ( obj ) {
        [array addObject:(__bridge id _Nonnull)(obj)];
        obj = (__bridge CFTypeRef)(va_arg( ap, id ));
    }
    va_end( ap );
    return (__bridge CFArrayRef)[NSArray arrayWithArray:array];
}

// Query
BOOL ArrayContainsObject( CFArrayRef ref, CFTypeRef obj )
{ return [(__bridge NSArray *)ref containsObject:(__bridge id)obj]; }

NSUInteger ArrayCount( CFArrayRef ref )
{ return [(__bridge NSArray *)ref count]; }

CFTypeRef ArrayFirstObject( CFArrayRef ref )
{ return (__bridge CFTypeRef)[(__bridge NSArray *)ref firstObject]; }

CFTypeRef ArrayLastObject( CFArrayRef ref )
{ return (__bridge CFTypeRef)[(__bridge NSArray *)ref lastObject]; }

CFTypeRef ArrayObjectAtIndex( CFArrayRef ref, NSUInteger index )
{ return (__bridge CFTypeRef)[(__bridge NSArray *)ref objectAtIndex:index]; }

CFArrayRef ArrayObjectsAtIndexes( CFArrayRef ref, NSIndexSet *indexes )
{ return (__bridge CFArrayRef)[(__bridge NSArray *)ref objectsAtIndexes:indexes]; }

NSEnumerator *ArrayObjectEnumerator( CFArrayRef ref )
{ return [(__bridge NSArray *)ref objectEnumerator]; }

NSEnumerator *ArrayReverseObjectEnumerator( CFArrayRef ref )
{ return [(__bridge NSArray *)ref reverseObjectEnumerator]; }

// Find
NSUInteger ArrayIndexOfObject( CFArrayRef ref, CFTypeRef obj )
{ return [(__bridge NSArray *)ref indexOfObject:(__bridge id)obj]; }

NSUInteger ArrayIndexOfObjectInRange( CFArrayRef ref, CFTypeRef obj, CFRange range )
{ return [(__bridge NSArray *)ref indexOfObject:(__bridge id)obj inRange:NSRangeFromCFRange(range)]; }

NSUInteger ArrayIndexOfObjectIdenticalTo( CFArrayRef ref, CFTypeRef obj )
{ return [(__bridge NSArray *)ref indexOfObjectIdenticalTo:(__bridge id)obj]; }

NSUInteger ArrayIndexOfObjectPassingTest( CFArrayRef ref, CUI_ArrayTestCallbackType testFn, void *userData )
{
    return [(__bridge NSArray *)ref indexOfObjectPassingTest:^(id obj, NSUInteger idx, BOOL *stop) {
        return (*testFn)(ref,(__bridge CFTypeRef)obj,idx,stop,userData);
    }];
}

NSUInteger ArrayIndexOfObjectWithOptionsPassingTest( CFArrayRef ref, NSEnumerationOptions options, CUI_ArrayTestCallbackType testFn, void *userData )
{
    return [(__bridge NSArray *)ref indexOfObjectWithOptions:options passingTest:^(id obj, NSUInteger idx, BOOL *stop) {
        return (*testFn)(ref,(__bridge CFTypeRef)obj,idx,stop,userData);
    }];
}

NSUInteger ArrayIndexOfObjectAtIndexesPassingTest( CFArrayRef ref, NSIndexSet *indexSet, NSEnumerationOptions options, CUI_ArrayTestCallbackType testFn, void *userData )
{
    return [(__bridge NSArray *)ref indexOfObjectAtIndexes:indexSet options:options passingTest:^(id obj, NSUInteger idx, BOOL *stop) {
        return (*testFn)(ref,(__bridge CFTypeRef)obj,idx,stop,userData);
    }];
}

NSIndexSet *ArrayIndexesOfObjectsPassingTest( CFArrayRef ref, CUI_ArrayTestCallbackType testFn, void *userData )
{
    return [(__bridge NSArray *)ref indexesOfObjectsPassingTest:^(id obj, NSUInteger idx, BOOL *stop) {
        return (*testFn)(ref,(__bridge CFTypeRef)obj,idx,stop,userData);
    }];
}

NSIndexSet *ArrayIndexesOfObjectsWithOptionsPassingTest( CFArrayRef ref, NSEnumerationOptions options, CUI_ArrayTestCallbackType testFn, void *userData )
{
    return [(__bridge NSArray *)ref indexesOfObjectsWithOptions:options passingTest:^(id obj, NSUInteger idx, BOOL *stop) {
        return (*testFn)(ref,(__bridge CFTypeRef)obj,idx,stop,userData);
    }];
}

NSIndexSet *ArrayIndexesOfObjectsAtIndexesPassingTest( CFArrayRef ref, NSIndexSet *indexSet, NSEnumerationOptions options, CUI_ArrayTestCallbackType testFn, void *userData )
{
    return [(__bridge NSArray *)ref indexesOfObjectsAtIndexes:indexSet options:options passingTest:^(id obj, NSUInteger idx, BOOL *stop) {
        return (*testFn)(ref,(__bridge CFTypeRef)obj,idx,stop,userData);
    }];
}


NSUInteger ArrayIndexOfObjectInSortedRange( CFArrayRef ref, CFTypeRef obj, CFRange range, NSBinarySearchingOptions options, CUI_ArraySortedArrayFunctionType comparatorFn, void *userData )
{
    return [(__bridge NSArray *)ref indexOfObject:(__bridge id)obj inSortedRange:NSRangeFromCFRange(range) options:options usingComparator:^(id obj1, id obj2) {
        return (*comparatorFn)((__bridge id)((__bridge CFTypeRef)obj1),(__bridge id)((__bridge CFTypeRef)obj2),userData);
    }];
}

NSUInteger ArrayIndexOfObjectInSortedRangeUsingComparator( CFArrayRef ref, CFTypeRef obj, CFRange range, NSBinarySearchingOptions options, CUI_ArraySortedArrayFunctionType comparatorFn, void *userData )
{ return ArrayIndexOfObjectInSortedRange( ref, obj, range, options, comparatorFn, userData ); }

// Compare
CFTypeRef ArrayFirstObjectCommonWithArray( CFArrayRef array1, CFArrayRef array2 )
{ return (__bridge CFTypeRef)[(__bridge NSArray *)array1 firstObjectCommonWithArray:(__bridge NSArray *)array2]; }

BOOL ArrayIsEqual( CFArrayRef array1, CFArrayRef array2 )
{ return [(__bridge NSArray *)array1 isEqualToArray:(__bridge NSArray *)array2]; }

// Deriving new arrays
CFArrayRef ArrayByAddingObject( CFArrayRef ref, CFTypeRef obj )
{ return (__bridge CFTypeRef)[(__bridge NSArray *)ref arrayByAddingObject:(__bridge id)obj]; }

CFArrayRef ArrayByAddingObjectsFromArray( CFArrayRef array1, CFArrayRef array2 )
{ return (__bridge CFTypeRef)[(__bridge NSArray *)array1 arrayByAddingObjectsFromArray:(__bridge NSArray *)array2]; }

CFArrayRef ArrayFilteredArrayUsingPredicate( CFArrayRef ref, NSPredicate *pred )
{ return (__bridge CFArrayRef)[(__bridge NSArray *)ref filteredArrayUsingPredicate:pred]; }

CFArrayRef ArraySubarrayWithRange( CFArrayRef ref, CFRange range )
{ return (__bridge CFTypeRef)[(__bridge NSArray *)ref subarrayWithRange:NSRangeFromCFRange(range)]; }

// Sending message to elements
void ArrayMakeObjectsPerformSelector( CFArrayRef ref, CFStringRef selector )
{ [(__bridge NSArray *)ref makeObjectsPerformSelector:NSSelectorFromString((__bridge NSString *)selector)]; }

void ArrayMakeObjectsPerformSelectorWithObject( CFArrayRef ref, CFStringRef selector, CFTypeRef object )
{ [(__bridge NSArray *)ref makeObjectsPerformSelector:NSSelectorFromString((__bridge NSString *)selector) withObject:(__bridge id)object]; }

void ArrayEnumerateObjects( CFArrayRef ref, CUI_ArrayEnumerateObjectsCallbackType callback, void *userData )
{
    [(__bridge NSArray *)ref enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        (*callback)(ref,(__bridge CFTypeRef)obj,idx,stop,userData);
    }];
}

void ArrayEnumerateObjectsWithOptions( CFArrayRef ref, NSEnumerationOptions options, CUI_ArrayEnumerateObjectsCallbackType callback, void *userData )
{
    [(__bridge NSArray *)ref enumerateObjectsWithOptions:options usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        (*callback)(ref,(__bridge CFTypeRef)obj,idx,stop,userData);
    }];
}

void ArrayEnumerateObjectsAtIndexes( CFArrayRef ref, NSIndexSet *indexSet, NSEnumerationOptions options, CUI_ArrayEnumerateObjectsCallbackType callback, void *userData )
{
    [(__bridge NSArray *)ref enumerateObjectsAtIndexes:indexSet options:options usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        (*callback)(ref,(__bridge CFTypeRef)obj,idx,stop,userData);
    }];
}

// Sort
CFDataRef ArraySortedArrayHint( CFArrayRef ref )
{ return (__bridge CFDataRef)[(__bridge NSArray *)ref sortedArrayHint]; }

CFArrayRef ArraySortedArrayUsingFunction( CFArrayRef ref, CUI_ArraySortedArrayFunctionType comparator, void *context )
{ return (__bridge CFArrayRef)[(__bridge NSArray *)ref sortedArrayUsingFunction:(*comparator) context:context]; }

CFArrayRef ArraySortedArrayUsingFunctionHint( CFArrayRef ref, CUI_ArraySortedArrayFunctionType comparator, void *context, CFDataRef hint )
{ return (__bridge CFArrayRef)[(__bridge NSArray *)ref sortedArrayUsingFunction:(*comparator) context:context hint:(__bridge NSData *)hint]; }

CFArrayRef ArraySortedArrayUsingDescriptors( CFArrayRef ref, CFArrayRef descriptors )
{ return (__bridge CFArrayRef)[(__bridge NSArray *)ref sortedArrayUsingDescriptors:(__bridge NSArray *)descriptors]; }

CFArrayRef ArraySortedArrayUsingSelector( CFArrayRef ref, CFStringRef selector )
{ return (__bridge CFArrayRef)[(__bridge NSArray *)ref sortedArrayUsingSelector:NSSelectorFromString((__bridge NSString *)selector)]; }

// Working with string elements
CFStringRef ArrayComponentsJoinedByString( CFArrayRef ref, CFStringRef separator )
{ return (__bridge CFStringRef)[(__bridge NSArray *)ref componentsJoinedByString:(__bridge NSString *)separator]; }

// Description
CFStringRef ArrayDescription( CFArrayRef ref )
{ return (__bridge CFStringRef)[(__bridge NSArray *)ref description]; }

CFStringRef ArrayDescriptionWithLocale( CFArrayRef ref, CFLocaleRef locale )
{ return (__bridge CFStringRef)[(__bridge NSArray *)ref descriptionWithLocale:(__bridge NSLocale *)locale]; }

CFStringRef ArrayDescriptionWithLocaleIndent( CFArrayRef ref, CFLocaleRef locale, NSUInteger indentLevel )
{ return (__bridge CFStringRef)[(__bridge NSArray *)ref descriptionWithLocale:(__bridge NSLocale *)locale indent:indentLevel]; }

// Collecting paths
CFArrayRef ArrayPathsMatchingExtensions( CFArrayRef ref, CFArrayRef extensions )
{ return (__bridge CFArrayRef)[(__bridge NSArray *)ref pathsMatchingExtensions:(__bridge NSArray *)extensions]; }

// Key-value coding
void ArraySetValueForKey( CFArrayRef ref, CFTypeRef value, CFStringRef key )
{ [(__bridge NSArray *)ref setValue:(__bridge id)value forKey:(__bridge NSString *)key]; }

CFTypeRef ArrayValueForKey( CFArrayRef ref, CFStringRef key )
{ return (__bridge CFArrayRef)[(__bridge NSArray *)ref valueForKey:(__bridge NSString *)key]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
CFArrayRef ArrayByApplyingDifference( CFArrayRef ref, NSOrderedCollectionDifference *diff )
{ return (__bridge CFArrayRef)[(__bridge NSArray *)ref arrayByApplyingDifference:diff]; }

NSOrderedCollectionDifference *ArrayDifferenceFromArray( CFArrayRef ref, CFArrayRef otherArray )
{ return [(__bridge NSArray *)ref differenceFromArray:(__bridge NSArray *)otherArray]; }

NSOrderedCollectionDifference *ArrayDifferenceFromArrayWithOptions( CFArrayRef ref, CFArrayRef otherArray, NSOrderedCollectionDifferenceCalculationOptions options )
{ return [(__bridge NSArray *)ref differenceFromArray:(__bridge NSArray *)otherArray withOptions:options]; }

NSOrderedCollectionDifference *ArrayDifferenceFromArrayUsingEquivalenceTest( CFArrayRef ref, CFArrayRef otherArray, NSOrderedCollectionDifferenceCalculationOptions options, CUI_ArrayDifferenceFromArrayFunctionType fnAddress, void *userData )
{
    return [(__bridge NSArray *)ref differenceFromArray:(__bridge NSArray *)otherArray withOptions:options usingEquivalenceTest:^(id obj1, id obj2) {
        return (*fnAddress)((__bridge id)((__bridge CFTypeRef)obj1),(__bridge id)((__bridge CFTypeRef)obj2),userData);// returns YES or NO
    }];
}
#endif// 101500

//BOOL ArrayWriteToURLAtomically( CFArrayRef ref, CFURLRef url, BOOL atomically )
//{ return [(__bridge NSArray *)ref writeToURL:(__bridge NSURL *)url atomically:atomically]; }

BOOL ArrayWriteToURL( CFArrayRef ref, CFURLRef url, NSError **err )
{ return [(__bridge NSArray *)ref writeToURL:(__bridge NSURL *)url error:err]; }

#pragma mark - NSScriptWhoseTests
BOOL ArrayDoesContain( CFArrayRef ref, ObjectRef obj )
{ return [(__bridge NSArray *)ref doesContain:obj]; }


#pragma mark - Convenience functions
CFArrayRef ArrayWithJSONString( CFStringRef string, NSError **err )
{
    NSData *data = [(__bridge NSString *)string dataUsingEncoding:NSUTF8StringEncoding];
    if ( data ) {
        id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:err];
        if ( obj ) return (__bridge CFArrayRef)obj;
    }
    return nil;
}


#pragma mark - mutable array
// Class
Class MutableArrayClass( void )
{ return [NSMutableArray class]; }

// Create
CFMutableArrayRef MutableArrayNew( void )
{
#if __has_feature(objc_arc)
    return (__bridge CFMutableArrayRef)[NSMutableArray new];
#else
    return (__bridge CFMutableArrayRef)[[NSMutableArray new] autorelease];
#endif
}

CFMutableArrayRef MutableArrayWithCapacity( NSUInteger numItems )
{ return (__bridge CFMutableArrayRef)[NSMutableArray arrayWithCapacity:numItems]; }

CFMutableArrayRef MutableArrayWithContentsOfURL( CFURLRef url )
{ return (__bridge CFMutableArrayRef)[NSMutableArray arrayWithContentsOfURL:(__bridge NSURL *)url]; }

CFMutableArrayRef MutableArrayWithArray( CFArrayRef array )
{ return (__bridge CFMutableArrayRef)[NSMutableArray arrayWithArray:(__bridge NSArray *)array]; }

CFMutableArrayRef MutableArrayWithObject( CFTypeRef obj )
{ return (__bridge CFMutableArrayRef)[NSMutableArray arrayWithObject:(__bridge id)obj]; }

CFMutableArrayRef MutableArrayWithObjects( CFTypeRef obj, ... )
{
    va_list ap;
    va_start( ap, obj );
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    while ( obj ) {
        [array addObject:(__bridge id _Nonnull)(obj)];
        obj = (__bridge CFTypeRef)(va_arg( ap, id ));
    }
    va_end( ap );
    return (__bridge CFMutableArrayRef)array;
}

// Adding objects
void MutableArrayAddObject( CFMutableArrayRef ref, CFTypeRef obj )
{ [(__bridge NSMutableArray *)ref addObject:(__bridge id)obj]; }

void MutableArrayAddObjectsFromArray( CFMutableArrayRef ref, CFArrayRef otherArray )
{ [(__bridge NSMutableArray *)ref addObjectsFromArray:(__bridge NSArray *)otherArray]; }

void MutableArrayInsertObjectAtIndex( CFMutableArrayRef ref, CFTypeRef obj, NSUInteger index )
{ [(__bridge NSMutableArray *)ref insertObject:(__bridge id)obj atIndex:index]; }

void MutableArrayInsertObjectsAtIndexes( CFMutableArrayRef ref, CFArrayRef objects, NSIndexSet *indexes )
{ [(__bridge NSMutableArray *)ref insertObjects:(__bridge NSArray *)objects atIndexes:indexes]; }

void MutableArrayRemoveAllObjects( CFMutableArrayRef ref )
{ [(__bridge NSMutableArray *)ref removeAllObjects]; }

void MutableArrayRemoveLastObject( CFMutableArrayRef ref )
{ [(__bridge NSMutableArray *)ref removeLastObject]; }

void MutableArrayRemoveObject( CFMutableArrayRef ref, CFTypeRef obj )
{ [(__bridge NSMutableArray *)ref removeObject:(__bridge id)obj]; }

void MutableArrayRemoveObjectInRange( CFMutableArrayRef ref, CFTypeRef obj, CFRange range )
{ [(__bridge NSMutableArray *)ref removeObject:(__bridge id)obj inRange:NSRangeFromCFRange(range)]; }

void MutableArrayRemoveObjectAtIndex( CFMutableArrayRef ref, NSUInteger index )
{ [(__bridge NSMutableArray *)ref removeObjectAtIndex:index]; }

void MutableArrayRemoveObjectsAtIndexes( CFMutableArrayRef ref, NSIndexSet *indexes )
{ [(__bridge NSMutableArray *)ref removeObjectsAtIndexes:indexes]; }

void MutableArrayRemoveObjectsInArray( CFMutableArrayRef ref, CFArrayRef objects )
{ [(__bridge NSMutableArray *)ref removeObjectsInArray:(__bridge NSArray *)objects]; }

void MutableArrayRemoveObjectsInRange( CFMutableArrayRef ref, CFRange range )
{ [(__bridge NSMutableArray *)ref removeObjectsInRange:NSRangeFromCFRange(range)]; }

void MutableArrayReplaceObjectAtIndex( CFMutableArrayRef ref, CFTypeRef obj, NSUInteger index )
{ [(__bridge NSMutableArray *)ref replaceObjectAtIndex:index withObject:(__bridge id)obj]; }

void MutableArrayReplaceObjectsAtIndexes( CFMutableArrayRef ref, CFArrayRef objects, NSIndexSet *indexes )
{ [(__bridge NSMutableArray *)ref replaceObjectsAtIndexes:indexes withObjects:(__bridge NSArray *)objects]; }

void MutableArraySetArray( CFMutableArrayRef ref, CFArrayRef otherArray )
{ [(__bridge NSMutableArray *)ref setArray:(__bridge NSArray *)otherArray]; }

// Filter content
void MutableArrayFilterUsingPredicate( CFMutableArrayRef ref, NSPredicate *predicate )
{ [(__bridge NSMutableArray *)ref filterUsingPredicate:predicate]; }

// Rearrange content
void MutableArrayExchangeObjects( CFMutableArrayRef ref, NSUInteger index1, NSUInteger index2 )
{ [(__bridge NSMutableArray *)ref exchangeObjectAtIndex:index1 withObjectAtIndex:index2]; }

void MutableArraySortUsingDescriptors( CFMutableArrayRef ref, CFArrayRef descriptors )
{ [(__bridge NSMutableArray *)ref sortUsingDescriptors:(__bridge NSArray *)descriptors]; }

void MutableArraySortUsingFunction( CFMutableArrayRef ref, CUI_ArraySortedArrayFunctionType comparator, void *context )
{ [(__bridge NSMutableArray *)ref sortUsingFunction:(*comparator) context:context]; }

void MutableArraySortUsingSelector( CFMutableArrayRef ref, CFStringRef selector )
{ [(__bridge NSMutableArray *)ref sortUsingSelector:NSSelectorFromString((__bridge NSString *)selector)]; }

// Instance method
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
void MutableArrayApplyDifference( CFMutableArrayRef ref, NSOrderedCollectionDifference *diff )
{ [(__bridge NSMutableArray *)ref applyDifference:diff]; }
#endif// 101500


#pragma mark - Convenience
void MutableArrayAddObjects( CFMutableArrayRef ref, CFTypeRef obj, ... )
{
    va_list ap;
    va_start( ap, obj );
    while ( obj ) {
        [(__bridge NSMutableArray *)ref addObject:(__bridge id _Nonnull)(obj)];
        obj = (__bridge CFTypeRef)(va_arg( ap, id ));
    }
    va_end( ap );
}

#pragma mark - Convenience function
CFMutableArrayRef MutableArrayWithJSONString( CFStringRef string, NSError **err )
{
    NSData *data = [(__bridge NSString *)string dataUsingEncoding:NSUTF8StringEncoding];
    if ( data ) {
        id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:err];
        if ( obj ) return (__bridge CFMutableArrayRef)obj;
    }
    return nil;
}

