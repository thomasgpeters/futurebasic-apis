/*
 OrderedCollectionDifference.m
 
 Bernie Wylde
 */

#import "OrderedCollectionDifference.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500

// Class
Class OrderedCollectionDifferenceClass( void )
{ return [NSOrderedCollectionDifference class]; }

// Init
NSOrderedCollectionDifference *OrderedCollectionDifferenceWithChanges( CFArrayRef changes )
{
#if __has_feature(objc_arc)
    return [[NSOrderedCollectionDifference alloc] initWithChanges:(__bridge NSArray *)changes];
#else
    return [[[NSOrderedCollectionDifference alloc] initWithChanges:(__bridge NSArray *)changes] autorelease];
#endif
}

NSOrderedCollectionDifference *OrderedCollectionDifferenceWithInsertIndexes( NSIndexSet *inserts, CFArrayRef insertedObjects, NSIndexSet *removes, CFArrayRef removedObjects )
{
#if __has_feature(objc_arc)
    return [[NSOrderedCollectionDifference alloc] initWithInsertIndexes:inserts insertedObjects:(__bridge NSArray *)insertedObjects removeIndexes:removes removedObjects:(__bridge NSArray *)removedObjects];
#else
    return [[[NSOrderedCollectionDifference alloc] initWithInsertIndexes:inserts insertedObjects:(__bridge NSArray *)insertedObjects removeIndexes:removes removedObjects:(__bridge NSArray *)removedObjects] autorelease];
#endif
}

NSOrderedCollectionDifference *OrderedCollectionDifferenceWithInsertIndexesAdditionalChanges( NSIndexSet *inserts, CFArrayRef insertedObjects, NSIndexSet *removes, CFArrayRef removedObjects, CFArrayRef changes )
{
#if __has_feature(objc_arc)
    return [[NSOrderedCollectionDifference alloc] initWithInsertIndexes:inserts insertedObjects:(__bridge NSArray *)insertedObjects removeIndexes:removes removedObjects:(__bridge NSArray *)removedObjects additionalChanges:(__bridge NSArray *)changes];
#else
    return [[[NSOrderedCollectionDifference alloc] initWithInsertIndexes:inserts insertedObjects:(__bridge NSArray *)insertedObjects removeIndexes:removes removedObjects:(__bridge NSArray *)removedObjects additionalChanges:(__bridge NSArray *)changes] autorelease];
#endif
}

// Instance properties
BOOL OrderedCollectionDifferenceHasChanges( NSOrderedCollectionDifference *ref )
{ return [ref hasChanges]; }

CFArrayRef OrderedCollectionDifferenceInsertions( NSOrderedCollectionDifference *ref )
{ return (__bridge CFArrayRef)[ref insertions]; }

CFArrayRef OrderedCollectionDifferenceRemovals( NSOrderedCollectionDifference *ref )
{ return (__bridge CFArrayRef)[ref removals]; }

// Instance methods
NSOrderedCollectionDifference *OrderedCollectionDifferenceInverse( NSOrderedCollectionDifference *ref )
{ return [ref inverseDifference]; }

NSOrderedCollectionDifference *OrderedCollectionDifferenceByTransformingChanges( NSOrderedCollectionDifference *ref, CUI_OrderedCollectionDifferenceTransformingChangesFunctionType fnAddress, void *userData )
{
    return [ref differenceByTransformingChangesWithBlock:^(NSOrderedCollectionChange *change) {
        return (*fnAddress)(change,userData);
    }];
}

#endif// 101500

