/*
 OrderedCollectionChange.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500

// Class
API_AVAILABLE(macos(10.15))
Class OrderedCollectionChangeClass( void );

// Init
API_AVAILABLE(macos(10.15))
NSOrderedCollectionChange *OrderedCollectionChangeWithObject( CFTypeRef object, NSCollectionChangeType type, NSUInteger index );
API_AVAILABLE(macos(10.15))
NSOrderedCollectionChange *OrderedCollectionChangeWithObjectAssociatedIndex( CFTypeRef object, NSCollectionChangeType type, NSUInteger index, NSUInteger associatedIndex );

// Instance properties
API_AVAILABLE(macos(10.15))
NSUInteger OrderedCollectionChangeAssociatedIndex( NSOrderedCollectionChange *ref );
API_AVAILABLE(macos(10.15))
NSCollectionChangeType OrderedCollectionChangeType( NSOrderedCollectionChange *ref );
API_AVAILABLE(macos(10.15))
NSUInteger OrderedCollectionChangeIndex( NSOrderedCollectionChange *ref );
API_AVAILABLE(macos(10.15))
CFTypeRef OrderedCollectionChangeObject( NSOrderedCollectionChange *ref );

#endif// 101500
