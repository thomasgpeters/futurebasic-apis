/*
 OrderedCollectionDifference.h
 
 Bernie Wylde
 */


#import "CocoaUI.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500

API_AVAILABLE(macos(10.15))
typedef NSOrderedCollectionChange *(*CUI_OrderedCollectionDifferenceTransformingChangesFunctionType)(NSOrderedCollectionChange *,void*);

// Class
API_AVAILABLE(macos(10.15))
Class OrderedCollectionDifferenceClass( void );

// Init
API_AVAILABLE(macos(10.15))
NSOrderedCollectionDifference *OrderedCollectionDifferenceWithChanges( CFArrayRef changes );
API_AVAILABLE(macos(10.15))
NSOrderedCollectionDifference *OrderedCollectionDifferenceWithInsertIndexes( NSIndexSet *inserts, CFArrayRef insertedObjects, NSIndexSet *removes, CFArrayRef removedObjects );
API_AVAILABLE(macos(10.15))
NSOrderedCollectionDifference *OrderedCollectionDifferenceWithInsertIndexesAdditionalChanges( NSIndexSet *inserts, CFArrayRef insertedObjects, NSIndexSet *removes, CFArrayRef removedObjects, CFArrayRef changes );

// Instance properties
API_AVAILABLE(macos(10.15))
BOOL OrderedCollectionDifferenceHasChanges( NSOrderedCollectionDifference *ref );
API_AVAILABLE(macos(10.15))
CFArrayRef OrderedCollectionDifferenceInsertions( NSOrderedCollectionDifference *ref );
API_AVAILABLE(macos(10.15))
CFArrayRef OrderedCollectionDifferenceRemovals( NSOrderedCollectionDifference *ref );

// Instance methods
API_AVAILABLE(macos(10.15))
NSOrderedCollectionDifference *OrderedCollectionDifferenceInverse( NSOrderedCollectionDifference *ref );
API_AVAILABLE(macos(10.15))
NSOrderedCollectionDifference *OrderedCollectionDifferenceByTransformingChanges( NSOrderedCollectionDifference *ref, CUI_OrderedCollectionDifferenceTransformingChangesFunctionType fnAddress, void *userData );

#endif// 101500
