/*
 OrderedSet.m

 Bernie Wylde
 */

#import "OrderedSet.h"

// Class
Class OrderedSetClass( void )
{ return [NSOrderedSet class]; }

// Create
NSOrderedSet *OrderedSetWithArray( CFArrayRef array )
{ return [NSOrderedSet orderedSetWithArray:(__bridge NSArray *)array]; }

NSOrderedSet *OrderedSetWithArrayRange( CFArrayRef array, CFRange range, BOOL copyItems )
{ return [NSOrderedSet orderedSetWithArray:(__bridge NSArray *)array range:NSRangeFromCFRange(range) copyItems:copyItems]; }

NSOrderedSet *OrderedSetWithObject( CFTypeRef obj )
{ return [NSOrderedSet orderedSetWithObject:(__bridge id)obj]; }

NSOrderedSet *OrderedSetWithObjects( CFTypeRef obj, ... )
{
    va_list ap;
    va_start( ap, obj );
    NSMutableOrderedSet *ref = [NSMutableOrderedSet orderedSetWithCapacity:0];
    while ( obj ) {
        [ref addObject:(__bridge id)obj];
        obj = (__bridge CFTypeRef)va_arg( ap, id );
    }
    va_end( ap );
    return (NSOrderedSet *)[NSOrderedSet orderedSetWithOrderedSet:ref];
}

NSOrderedSet *OrderedSetWithOrderedSet( NSOrderedSet *set )
{ return [NSOrderedSet orderedSetWithOrderedSet:set]; }

NSOrderedSet *OrderedSetWithSet( CFSetRef set )
{ return [NSOrderedSet orderedSetWithSet:(__bridge NSSet *)set]; }

// Count
NSUInteger OrderedSetCount( NSOrderedSet *ref )
{ return [ref count]; }

// - accessing set members -
BOOL OrderedSetContainsObject( NSOrderedSet *ref, CFTypeRef obj )
{ return [ref containsObject:(__bridge id)obj]; }

void OrderedSetEnumerateObjects( NSOrderedSet *ref, CUI_OrderedSetEnumerateObjectsCallbackType callback, void *userData )
{
    [ref enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        (*callback)(ref,(__bridge CFTypeRef)obj,idx,stop,userData);
    }];
}

void OrderedSetEnumerateObjectsWithOptions( NSOrderedSet *ref, NSEnumerationOptions options, CUI_OrderedSetEnumerateObjectsCallbackType callback, void *userData )
{
    [ref enumerateObjectsWithOptions:options usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        (*callback)(ref,(__bridge CFTypeRef)obj,idx,stop,userData);
    }];
}

void OrderedSetEnumerateObjectsAtIndexes( NSOrderedSet *ref, NSIndexSet *indexSet, NSEnumerationOptions options, CUI_OrderedSetEnumerateObjectsCallbackType callback, void *userData )
{
    [ref enumerateObjectsAtIndexes:indexSet options:options usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        (*callback)(ref,(__bridge CFTypeRef)obj,idx,stop,userData);
    }];
}

CFTypeRef OrderedSetFirstObject( NSOrderedSet *ref )
{ return (__bridge CFTypeRef)[ref firstObject]; }

CFTypeRef OrderedSetLastObject( NSOrderedSet *ref )
{ return (__bridge CFTypeRef)[ref lastObject]; }

CFTypeRef OrderedSetObjectAtIndex( NSOrderedSet *ref, NSUInteger index )
{ return (__bridge CFTypeRef)[ref objectAtIndex:index]; }

CFArrayRef OrderedSetObjectsAtIndexes( NSOrderedSet *ref, NSIndexSet *indexes )
{ return (__bridge CFTypeRef)[ref objectsAtIndexes:indexes]; }

NSUInteger OrderedSetIndexOfObject( NSOrderedSet *ref, CFTypeRef obj )
{ return [ref indexOfObject:(__bridge id)obj]; }

// Key-value coding
void OrderedSetSetValueForKey( NSOrderedSet *ref, CFTypeRef value, CFStringRef key )
{ [ref setValue:(__bridge id)value forKey:(__bridge NSString *)key]; }

CFTypeRef OrderedSetValueForKey( NSOrderedSet *ref, CFStringRef key )
{ return (__bridge CFTypeRef)[ref valueForKey:(__bridge NSString *)key]; }

// - observing -
BOOL OrderedSetIsEqual( NSOrderedSet *ref1, NSOrderedSet *ref2 )
{ return [ref1 isEqualToOrderedSet:ref2]; }

BOOL OrderedSetIntersectsOrderedSet( NSOrderedSet *ref1, NSOrderedSet *ref2 )
{ return [ref1 intersectsOrderedSet:ref2]; }

BOOL OrderedSetIntersectsSet( NSOrderedSet *ref, CFSetRef set )
{ return [ref intersectsSet:(__bridge NSSet *)set]; }

BOOL OrderedSetIsSubsetOfOrderedSet( NSOrderedSet *ref1, NSOrderedSet *ref2 )
{ return [ref1 isSubsetOfOrderedSet:ref2]; }

BOOL OrderedSetIsSubsetOfSet( NSOrderedSet *ref, CFSetRef set )
{ return [ref isSubsetOfSet:(__bridge NSSet *)set]; }

// Sorted array
CFArrayRef OrderedSetSortedArrayUsingDescriptors( NSOrderedSet *ref, CFArrayRef descriptors )
{ return (__bridge CFArrayRef)[ref sortedArrayUsingDescriptors:(__bridge NSArray *)descriptors]; }

CFArrayRef OrderedSetSortedArrayUsingComparator( NSOrderedSet *ref, CUI_OrderedSetComparatorType comparator, void *userData )
{
    return (__bridge CFArrayRef)[ref sortedArrayUsingComparator:^(id obj1, id obj2) {
        return (*comparator)(ref,(__bridge CFTypeRef)obj1,(__bridge CFTypeRef)obj2,userData);
    }];
}

CFArrayRef OrderedSetSortedArrayWithOptionsUsingComparator( NSOrderedSet *ref, NSSortOptions options, CUI_OrderedSetComparatorType comparator, void *userData )
{
    return (__bridge CFArrayRef)[ref sortedArrayWithOptions:options usingComparator:^(id obj1, id obj2) {
        return (*comparator)(ref,(__bridge CFTypeRef)obj1,(__bridge CFTypeRef)obj2,userData);
    }];
}

// Filtering
NSOrderedSet *OrderedSetFilteredOrderedSetUsingPredicate( NSOrderedSet *ref, NSPredicate *predicate )
{ return [ref filteredOrderedSetUsingPredicate:predicate]; }

// Description
CFStringRef OrderedSetDescription( NSOrderedSet *ref )
{ return (__bridge CFStringRef)[ref description]; }

CFStringRef OrderedSetDescriptionWithLocale( NSOrderedSet *ref, CFLocaleRef locale )
{ return (__bridge CFStringRef)[ref descriptionWithLocale:(__bridge NSLocale *)locale]; }

CFStringRef OrderedSetDescriptionWithLocaleAndIndent( NSOrderedSet *ref, CFLocaleRef locale, NSUInteger indent )
{ return (__bridge CFStringRef)[ref descriptionWithLocale:(__bridge NSLocale *)locale indent:indent]; }

// Converting
CFArrayRef OrderedSetArray( NSOrderedSet *ref )
{ return (__bridge CFArrayRef)[ref array]; }

CFSetRef OrderedSetSet( NSOrderedSet *ref )
{ return (__bridge CFSetRef)[ref set]; }

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
NSOrderedSet *OrderedSetByApplyingDifference( NSOrderedSet *ref, NSOrderedCollectionDifference *diff )
{ return [(NSOrderedSet *)ref orderedSetByApplyingDifference:diff]; }

NSOrderedCollectionDifference *OrderedSetDifferenceFromOrderedSet( NSOrderedSet *ref, NSOrderedSet *otherSet )
{ return [ref differenceFromOrderedSet:otherSet]; }

NSOrderedCollectionDifference *OrderedSetDifferenceFromOrderedSetWithOptions( NSOrderedSet *ref, NSOrderedSet *otherSet, NSOrderedCollectionDifferenceCalculationOptions options )
{ return [ref differenceFromOrderedSet:otherSet withOptions:options]; }

NSOrderedCollectionDifference *OrderedSetDifferenceFromOrderedSetUsingEquivalenceTest( NSOrderedSet *ref, NSOrderedSet *otherSet, NSOrderedCollectionDifferenceCalculationOptions options, CUI_OrderedSetDifferenceFromOrderedSetFunctionType fnAddress, void *userData )
{
    return [ref differenceFromOrderedSet:otherSet withOptions:options usingEquivalenceTest:^(id obj1, id obj2) {
        return (*fnAddress)((__bridge CFTypeRef)obj1,(__bridge CFTypeRef)obj2,userData);// returns YES or NO
    }];
}
#endif// 101500


#pragma mark - MutableOrderedSet
// Class
Class MutableOrderedSetClass( void )
{ return [NSMutableOrderedSet class]; }

// Create
NSMutableOrderedSet *MutableOrderedSetNew( void )
{
#if __has_feature(objc_arc)
    return [NSMutableOrderedSet new];
#else
    return [[NSMutableOrderedSet new] autorelease];
#endif
}

NSMutableOrderedSet *MutableOrderedSetWithCapacity( NSUInteger size )
{ return [NSMutableOrderedSet orderedSetWithCapacity:size]; }

NSMutableOrderedSet *MutableOrderedSetWithArray( CFArrayRef array )
{ return [NSMutableOrderedSet orderedSetWithArray:(__bridge NSArray *)array]; }

NSMutableOrderedSet *MutableOrderedSetWithArrayRange( CFArrayRef array, CFRange range, BOOL copyItems )
{ return [NSMutableOrderedSet orderedSetWithArray:(__bridge NSArray *)array range:NSRangeFromCFRange(range) copyItems:copyItems]; }

NSMutableOrderedSet *MutableOrderedSetWithObject( CFTypeRef obj )
{ return [NSMutableOrderedSet orderedSetWithObject:(__bridge id)obj]; }

NSMutableOrderedSet *MutableOrderedSetWithObjects( CFTypeRef obj, ... )
{
    va_list ap;
    va_start( ap, obj );
    NSMutableOrderedSet *ref = [NSMutableOrderedSet orderedSetWithCapacity:0];
    while ( obj ) {
        [ref addObject:(__bridge id)obj];
        obj = (__bridge CFTypeRef)va_arg( ap, id );
    }
    va_end( ap );
    return ref;
}

NSMutableOrderedSet *MutableOrderedSetWithOrderedSet( NSOrderedSet *set )
{ return [NSMutableOrderedSet orderedSetWithOrderedSet:set]; }

NSMutableOrderedSet *MutableOrderedSetWithSet( CFSetRef set )
{ return [NSMutableOrderedSet orderedSetWithSet:(__bridge NSSet *)set]; }

// Add, remove, reorder
void MutableOrderedSetAddObject( NSMutableOrderedSet *ref, CFTypeRef obj )
{ [ref addObject:(__bridge id)obj]; }

void MutableOrderedSetAddObjectsFromArray( NSMutableOrderedSet *ref, CFArrayRef array )
{ [ref addObjectsFromArray:(__bridge NSArray *)array]; }

void MutableOrderedSetInsertObjectAtIndex( NSMutableOrderedSet *ref, CFTypeRef obj, NSUInteger index )
{ [ref insertObject:(__bridge id)obj atIndex:index]; }

void MutableOrderedSetInsertObjectsAtIndexes( NSMutableOrderedSet *ref, CFArrayRef objects, NSIndexSet *indexes )
{ [ref insertObjects:(__bridge NSArray *)objects atIndexes:indexes]; }

void MutableOrderedSetRemoveObject( NSMutableOrderedSet *ref, CFTypeRef obj )
{ [ref removeObject:(__bridge id)obj]; }

void MutableOrderedSetRemoveObjectAtIndex( NSMutableOrderedSet *ref, NSUInteger index )
{ [ref removeObjectAtIndex:index]; }

void MutableOrderedSetRemoveObjectsAtIndexes( NSMutableOrderedSet *ref, NSIndexSet *indexes )
{ [ref removeObjectsAtIndexes:indexes]; }

void MutableOrderedSetRemoveObjectsInArray( NSMutableOrderedSet *ref, CFArrayRef array )
{ [ref removeObjectsInArray:(__bridge NSArray *)array]; }

void MutableOrderedSetRemoveObjectsInRange( NSMutableOrderedSet *ref, CFRange range )
{ [ref removeObjectsInRange:NSRangeFromCFRange(range)]; }

void MutableOrderedSetRemoveAllObjects( NSMutableOrderedSet *ref )
{ [ref removeAllObjects]; }

void MutableOrderedSetReplaceObjectAtIndex( NSMutableOrderedSet *ref, CFTypeRef obj, NSUInteger index )
{ [ref replaceObjectAtIndex:index withObject:(__bridge id)obj]; }

void MutableOrderedSetReplaceObjectsAtIndexes( NSMutableOrderedSet *ref, CFArrayRef objects, NSIndexSet *indexes )
{ [ref replaceObjectsAtIndexes:indexes withObjects:(__bridge NSArray *)objects]; }

void MutableOrderedSetSetObjectAtIndex( NSMutableOrderedSet *ref, CFTypeRef obj, NSUInteger index )
{ [ref setObject:(__bridge id)obj atIndex:index]; }

void MutableOrderedSetMoveObjectsAtIndexesToIndex( NSMutableOrderedSet *ref, NSIndexSet *indexes, NSUInteger index )
{ [ref moveObjectsAtIndexes:indexes toIndex:index]; }

void MutableOrderedSetExchangeObjectAtIndex( NSMutableOrderedSet *ref, NSUInteger index1, NSUInteger index2 )
{ [ref exchangeObjectAtIndex:index1 withObjectAtIndex:index2]; }

// Sorting
void MutableOrderedSetSortUsingDescriptors( NSMutableOrderedSet *ref, CFArrayRef descriptors )
{ [ref sortUsingDescriptors:(__bridge NSArray *)descriptors]; }

// Combining and recombining
void MutableOrderedSetIntersectOrderedSet( NSMutableOrderedSet *ref1, NSOrderedSet *ref2 )
{ [ref1 intersectOrderedSet:ref2]; }

void MutableOrderedSetIntersectSet( NSMutableOrderedSet *ref, CFSetRef set )
{ [ref intersectSet:(__bridge NSSet *)set]; }

void MutableOrderedSetMinusOrderedSet( NSMutableOrderedSet *ref1, NSOrderedSet *ref2 )
{ [ref1 minusOrderedSet:ref2]; }

void MutableOrderedSetMinusSet( NSMutableOrderedSet *ref, CFSetRef set )
{ [ref minusSet:(__bridge NSSet *)set]; }

void MutableOrderedSetUnionOrderedSet( NSMutableOrderedSet *ref1, NSOrderedSet *ref2 )
{ [ref1 unionOrderedSet:ref2]; }

void MutableOrderedSetUnionSet( NSMutableOrderedSet *ref, CFSetRef set )
{ [ref unionSet:(__bridge NSSet *)set]; }

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
void MutableOrderedSetApplyDifference( NSMutableOrderedSet *ref, NSOrderedCollectionDifference *diff )
{ [ref applyDifference:diff]; }
#endif// 101500
