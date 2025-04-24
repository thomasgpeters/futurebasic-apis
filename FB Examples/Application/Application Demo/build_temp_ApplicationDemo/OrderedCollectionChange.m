/*
 OrderedCollectionChange.m
 
 Bernie Wylde
 */

#import "OrderedCollectionChange.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500

// Class
Class OrderedCollectionChangeClass( void )
{ return [NSOrderedCollectionChange class]; }

// Init
NSOrderedCollectionChange *OrderedCollectionChangeWithObject( CFTypeRef object, NSCollectionChangeType type, NSUInteger index )
{ return [NSOrderedCollectionChange changeWithObject:(__bridge id)object type:type index:index]; }

NSOrderedCollectionChange *OrderedCollectionChangeWithObjectAssociatedIndex( CFTypeRef object, NSCollectionChangeType type, NSUInteger index, NSUInteger associatedIndex )
{ return [NSOrderedCollectionChange changeWithObject:(__bridge id)object type:type index:index associatedIndex:associatedIndex]; }

// Instance properties
NSUInteger OrderedCollectionChangeAssociatedIndex( NSOrderedCollectionChange *ref )
{ return [ref associatedIndex]; }

NSCollectionChangeType OrderedCollectionChangeType( NSOrderedCollectionChange *ref )
{ return [ref changeType]; }

NSUInteger OrderedCollectionChangeIndex( NSOrderedCollectionChange *ref )
{ return [ref index]; }

CFTypeRef OrderedCollectionChangeObject( NSOrderedCollectionChange *ref )
{ return (__bridge CFTypeRef)[ref object]; }

#endif// 101500
