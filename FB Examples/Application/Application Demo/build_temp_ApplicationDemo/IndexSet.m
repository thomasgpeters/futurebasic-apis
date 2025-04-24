/*
 IndexSet.m

 Bernie Wylde
 */

#import "IndexSet.h"

// Class
Class IndexSetClass( void )
{ return [NSIndexSet class]; }

// Create
NSIndexSet *IndexSetInit( void )
{ return [NSIndexSet indexSet]; }

NSIndexSet *IndexSetWithIndex( NSUInteger value )
{ return [NSIndexSet indexSetWithIndex:value]; }

NSIndexSet *IndexSetWithIndexesInRange( CFRange range )
{ return [NSIndexSet indexSetWithIndexesInRange:NSRangeFromCFRange(range)]; }


BOOL IndexSetContainsIndex( NSIndexSet *ref, NSUInteger index )
{ return [ref containsIndex:index]; }

BOOL IndexSetContainsIndexes( NSIndexSet *ref, NSIndexSet *subset )
{ return [ref containsIndexes:subset]; }

BOOL IndexSetContainsIndexesInRange( NSIndexSet *ref, CFRange range )
{ return [ref containsIndexesInRange:NSRangeFromCFRange(range)]; }

BOOL IndexSetIntersectsIndexesInRange( NSIndexSet *ref, CFRange range )
{ return [ref intersectsIndexesInRange:NSRangeFromCFRange(range)]; }

NSUInteger IndexSetCount( NSIndexSet *ref )
{ return [ref count]; }

NSUInteger IndexSetCountOfIndexesInRange( NSIndexSet *ref, CFRange range )
{ return [ref countOfIndexesInRange:NSRangeFromCFRange(range)]; }

NSUInteger IndexSetIndexPassingTest( NSIndexSet *ref, CUI_IndexSetIndexPredicateType predicate, void *userData )
{
    return [ref indexPassingTest:^( NSUInteger idx, BOOL *stop ) {
        return (*predicate)(ref,idx,stop,userData);
    }];
}

NSIndexSet *IndexSetIndexesPassingTest( NSIndexSet *ref, CUI_IndexSetIndexPredicateType predicate, void *userData )
{
    return [ref indexesPassingTest:^( NSUInteger idx, BOOL *stop ) {
        return (*predicate)(ref,idx,stop,userData);
    }];
}

NSUInteger IndexSetIndexWithOptionsPassingTest( NSIndexSet *ref, NSEnumerationOptions options, CUI_IndexSetIndexPredicateType predicate, void *userData )
{
    return [ref indexWithOptions:options passingTest:^( NSUInteger idx, BOOL *stop ) {
        return (*predicate)(ref,idx,stop,userData);
    }];
}

NSIndexSet *IndexSetIndexesWithOptionsPassingTest( NSIndexSet *ref, NSEnumerationOptions options, CUI_IndexSetIndexPredicateType predicate, void *userData )
{
    return [ref indexesWithOptions:options passingTest:^( NSUInteger idx, BOOL *stop) {
        return (*predicate)(ref,idx,stop,userData);
    }];
}

NSUInteger IndexSetIndexInRangePassingTest( NSIndexSet *ref, CFRange range, NSEnumerationOptions options, CUI_IndexSetIndexPredicateType predicate, void *userData )
{
    return [ref indexInRange:NSRangeFromCFRange(range) options:options passingTest:^( NSUInteger idx, BOOL *stop) {
        return (*predicate)(ref,idx,stop,userData);
    }];
}

NSIndexSet *IndexSetIndexesInRangePassingTest( NSIndexSet *ref, CFRange range, NSEnumerationOptions options, CUI_IndexSetIndexPredicateType predicate, void *userData )
{
    return [ref indexesInRange:NSRangeFromCFRange(range) options:options passingTest:^( NSUInteger idx, BOOL *stop) {
        return (*predicate)(ref,idx,stop,userData);
    }];
}

// enumerate content
void IndexSetEnumerateRangesInRange( NSIndexSet *ref, CFRange inRange, NSEnumerationOptions options, CUI_IndexSetRangeCallbackType callback, void *userData )
{
    [ref enumerateRangesInRange:NSRangeFromCFRange(inRange) options:options usingBlock:^(NSRange range, BOOL *stop) {
        (*callback)(ref,NSRangeToCFRange(range),stop,userData);
    }];
}

void IndexSetEnumerateRanges( NSIndexSet *ref, CUI_IndexSetRangeCallbackType callback, void *userData )
{
    [ref enumerateRangesUsingBlock:^(NSRange range, BOOL *stop) {
        (*callback)(ref,NSRangeToCFRange(range),stop,userData);
    }];
}

void IndexSetEnumerateRangesWithOptions( NSIndexSet *ref, NSEnumerationOptions options, CUI_IndexSetRangeCallbackType callback, void *userData )
{
    [ref enumerateRangesWithOptions:options usingBlock:^(NSRange range, BOOL *stop) {
        (*callback)(ref,NSRangeToCFRange(range),stop,userData);
    }];
}

BOOL IndexSetIsEqual( NSIndexSet *ref1, NSIndexSet *ref2 )
{ return [ref1 isEqualToIndexSet:ref2]; }

NSUInteger IndexSetFirstIndex( NSIndexSet *ref )
{ return [ref firstIndex]; }

NSUInteger IndexSetLastIndex( NSIndexSet *ref )
{ return [ref lastIndex]; }

NSUInteger IndexSetIndexLessThan( NSIndexSet *ref, NSUInteger value )
{ return [ref indexLessThanIndex:value]; }

NSUInteger IndexSetIndexLessThanOrEqualTo( NSIndexSet *ref, NSUInteger value )
{ return [ref indexLessThanOrEqualToIndex:value]; }

NSUInteger IndexSetIndexGreaterThanOrEqualTo( NSIndexSet *ref, NSUInteger value )
{ return [ref indexGreaterThanOrEqualToIndex:value]; }

NSUInteger IndexSetIndexGreaterThan( NSIndexSet *ref, NSUInteger value )
{ return [ref indexGreaterThanIndex:value]; }

NSUInteger InsetSetGetIndexes( NSIndexSet *ref, NSUInteger *indexBuffer, NSUInteger maxCount, CFRange *indexRange )
{ return [ref getIndexes:indexBuffer maxCount:maxCount inIndexRange:(NSRange *)indexRange]; }

// Enumerate indexes
void IndexSetEnumerateIndexes( NSIndexSet *ref, CUI_IndexSetIndexCallbackType callback, void *userData )
{
    [ref enumerateIndexesUsingBlock:^(NSUInteger index, BOOL *stop) {
        (*callback)(ref,index,stop,userData);
    }];
}

void IndexSetEnumerateIndexesWithOptions( NSIndexSet *ref, NSEnumerationOptions options, CUI_IndexSetIndexCallbackType callback, void *userData )
{
    [ref enumerateIndexesWithOptions:options usingBlock:^(NSUInteger index, BOOL *stop) {
        (*callback)(ref,index,stop,userData);
    }];
}

void IndexSetEnumerateIndexesInRange( NSIndexSet *ref, CFRange range, NSEnumerationOptions options, CUI_IndexSetIndexCallbackType callback, void *userData )
{
    [ref enumerateIndexesInRange:NSRangeFromCFRange(range) options:options usingBlock:^(NSUInteger index, BOOL *stop) {
        (*callback)(ref,index,stop,userData);
    }];
}

// Custom
NSIndexSet *IndexSetWithIndexes( NSInteger index, ... )
{
    va_list ap;
    va_start( ap, index );
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    while ( index >= 0 ) {
        [indexSet addIndex:index];
        index = va_arg( ap, int );
    }
    va_end( ap );
#if __has_feature(objc_arc)
    return [[NSIndexSet alloc] initWithIndexSet:indexSet];
#else
    return [[[NSIndexSet alloc] initWithIndexSet:indexSet] autorelease];
#endif
}

CFArrayRef IndexSetIndexArray( NSIndexSet *ref )
{
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    [ref enumerateIndexesUsingBlock:^(NSUInteger idx, __attribute__ ((unused)) BOOL *stop) {
        [array addObject:@(idx)];
    }];
    return (__bridge CFArrayRef)array;
}


#pragma mark - mutable
Class MutableIndexSetClass( void )
{ return [NSMutableIndexSet class]; }

NSMutableIndexSet *MutableIndexSetNew( void )
{
#if __has_feature(objc_arc)
    return [NSMutableIndexSet new];
#else
    return [[NSMutableIndexSet new] autorelease];
#endif
}

NSMutableIndexSet *MutableIndexSetInit( void )
{ return [NSMutableIndexSet indexSet]; }

NSMutableIndexSet *MutableIndexSetWithIndex( NSUInteger index )
{ return [NSMutableIndexSet indexSetWithIndex:index]; }

NSMutableIndexSet *MutableIndexSetWithIndexesInRange( CFRange range )
{ return [NSMutableIndexSet indexSetWithIndexesInRange:NSRangeFromCFRange(range)]; }

void MutableIndexSetAddIndex( NSMutableIndexSet *ref, NSUInteger index )
{ [ref addIndex:index]; }

void MutableIndexSetAddIndexes( NSMutableIndexSet *ref, NSIndexSet *otherSet )
{ [ref addIndexes:otherSet]; }

void MutableIndexSetAddIndexesInRange( NSMutableIndexSet *ref, CFRange range )
{ [ref addIndexesInRange:NSRangeFromCFRange(range)]; }

void MutableIndexSetRemoveIndex( NSMutableIndexSet *ref, NSUInteger index )
{ [ref removeIndex:index]; }

void MutableIndexSetRemoveIndexes( NSMutableIndexSet *ref, NSIndexSet *otherSet )
{ [ref removeIndexes:otherSet]; }

void MutableIndexSetRemoveAllIndexes( NSMutableIndexSet *ref )
{ [ref removeAllIndexes]; }

void MutableIndexSetRemoveIndexesInRange( NSMutableIndexSet *ref, CFRange range )
{ [ref removeIndexesInRange:NSRangeFromCFRange(range)]; }

void MutableIndexSetShiftIndexes( NSMutableIndexSet *ref, NSUInteger index, NSInteger delta )
{ [ref shiftIndexesStartingAtIndex:index by:delta]; }
