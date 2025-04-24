/*
 Set.m

 Bernie Wylde
 */

#import "Set.h"

// Class
Class SetClass( void )
{ return [NSSet class]; }

// Create
CFSetRef SetWithArray( CFArrayRef array )
{ return (__bridge CFSetRef)[NSSet setWithArray:(__bridge NSArray *)array]; }

CFSetRef SetWithObject( CFTypeRef obj )
{ return (__bridge CFSetRef)[NSSet setWithObject:(__bridge id)obj]; }

CFSetRef SetWithObjects( CFTypeRef obj, ... )
{
    va_list ap;
    va_start( ap, obj );
    NSMutableSet *set = [NSMutableSet setWithCapacity:0];
    while ( obj ) {
        [set addObject:(__bridge id)obj];
        obj = (__bridge CFTypeRef)va_arg( ap, id );
    }
    va_end( ap );
    return (__bridge CFSetRef)[NSSet setWithSet:set];
}

CFSetRef SetWithSet( CFSetRef set )
{ return (__bridge CFSetRef)[NSSet setWithSet:(__bridge NSSet *)set]; }

CFSetRef SetByAddingObject( CFSetRef ref, CFTypeRef obj )
{ return (__bridge CFSetRef)[(__bridge NSSet *)ref setByAddingObject:(__bridge id)obj]; }

CFSetRef SetByAddingObjectsFromSet( CFSetRef ref1, CFSetRef ref2 )
{ return (__bridge CFSetRef)[(__bridge NSSet *)ref1 setByAddingObjectsFromSet:(__bridge NSSet *)ref2]; }

CFSetRef SetByAddingObjectsFromArray( CFSetRef ref, CFArrayRef array )
{ return (__bridge CFSetRef)[(__bridge NSSet *)ref setByAddingObjectsFromArray:(__bridge NSArray *)array]; }

// Count
NSUInteger SetCount( CFSetRef ref )
{ return [(__bridge NSSet *)ref count]; }

// Members
CFArrayRef SetAllObjects( CFSetRef ref )
{ return (__bridge CFArrayRef)[(__bridge NSSet *)ref allObjects]; }

CFTypeRef SetAnyObject( CFSetRef ref )
{ return (__bridge CFTypeRef)[(__bridge NSSet *)ref anyObject]; }

BOOL SetContainsObject( CFSetRef ref, CFTypeRef obj )
{ return [(__bridge NSSet *)ref containsObject:(__bridge id)obj]; }

CFTypeRef SetMember( CFSetRef ref, CFTypeRef obj )
{ return (__bridge CFTypeRef)[(__bridge NSSet *)ref member:(__bridge id)obj]; }

NSEnumerator *SetObjectEnumerator( CFSetRef ref )
{ return [(__bridge NSSet *)ref objectEnumerator]; }

void SetEnumerateObjects( CFSetRef ref, CUI_SetEnumerateObjectsCallbackType callback, void *userData )
{
    [(__bridge NSSet *)ref enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        (*callback)(ref,(__bridge CFTypeRef)obj,stop,userData);
    }];
}

void SetEnumerateObjectsWithOptions( CFSetRef ref, NSEnumerationOptions options, CUI_SetEnumerateObjectsCallbackType callback, void *userData )
{
    [(__bridge NSSet *)ref enumerateObjectsWithOptions:options usingBlock:^(id obj, BOOL *stop) {
        (*callback)(ref,(__bridge CFTypeRef)obj,stop,userData);
    }];
}

CFSetRef SetObjectsPassingTest( CFSetRef ref, CUI_SetTestObjectsCallbackType predicate, void *userData )
{
    return (__bridge CFSetRef)[(__bridge NSSet *)ref objectsPassingTest:^(id obj, BOOL *stop) {
        return (*predicate)(ref,(__bridge CFTypeRef)obj,stop,userData);
    }];
}

CFSetRef SetObjectsWithOptionsPassingTest( CFSetRef ref, NSEnumerationOptions options, CUI_SetTestObjectsCallbackType predicate, void *userData )
{
    return (__bridge CFSetRef)[(__bridge NSSet *)ref objectsWithOptions:options passingTest:^(id obj, BOOL *stop) {
        return (*predicate)(ref,(__bridge CFTypeRef)obj,stop,userData);
    }];
}

// Compare
BOOL SetIsSubsetOfSet( CFSetRef ref1, CFSetRef ref2 )
{ return [(__bridge NSSet *)ref1 isSubsetOfSet:(__bridge NSSet *)ref2]; }

BOOL SetIntersectsSet( CFSetRef ref1, CFSetRef ref2 )
{ return [(__bridge NSSet *)ref1 intersectsSet:(__bridge NSSet *)ref2]; }

BOOL SetIsEqual( CFSetRef ref1, CFSetRef ref2 )
{ return [(__bridge NSSet *)ref1 isEqualToSet:(__bridge NSSet *)ref2]; }

CFTypeRef SetValueForKey( CFSetRef ref, CFStringRef key )
{ return (__bridge CFTypeRef)[(__bridge NSSet *)ref valueForKey:(__bridge NSString *)key]; }

void SetSetValueForKey( CFSetRef ref, CFTypeRef value, CFStringRef key )
{ [(__bridge NSSet *)ref setValue:(__bridge id)value forKey:(__bridge NSString *)key]; }

// Sorted array
CFArrayRef SetSortedArrayUsingDescriptors( CFSetRef ref, CFArrayRef sortDescriptors )
{ return (__bridge CFArrayRef)[(__bridge NSSet *)ref sortedArrayUsingDescriptors:(__bridge NSArray *)sortDescriptors]; }

// Description
CFStringRef SetDescription( CFSetRef ref )
{ return (__bridge CFStringRef)[(__bridge NSSet *)ref description]; }

CFStringRef SetDescriptionWithLocale( CFSetRef ref, CFTypeRef locale )
{ return (__bridge CFStringRef)[(__bridge NSSet *)ref descriptionWithLocale:(__bridge id)locale]; }

// Initializers
CFSetRef SetWithCollectionViewIndexPath( NSIndexPath *indexPath )
{ return (__bridge CFSetRef)[NSSet setWithCollectionViewIndexPath:indexPath]; }

CFSetRef SetWithCollectionViewIndexPaths( CFArrayRef indexPaths )
{ return (__bridge CFSetRef)[NSSet setWithCollectionViewIndexPaths:(__bridge NSArray *)indexPaths]; }

// Instance methods
void SetEnumerateIndexPathsWithOptions( CFSetRef ref, NSEnumerationOptions options, CUI_SetEnumerateIndexPathsCallbackType callback, void *userData )
{
    [(__bridge NSSet *)ref enumerateIndexPathsWithOptions:options usingBlock:^(NSIndexPath *indexPath, BOOL *stop) {
        (*callback)(ref,indexPath,stop,userData);
    }];
}


#pragma mark - mutable set
// Class
Class MutableSetClass( void )
{ return [NSMutableSet class]; }

// Create
CFMutableSetRef MutableSetNew( void )
{
#if __has_feature(objc_arc)
    return (__bridge CFMutableSetRef)[NSMutableSet new];
#else
    return (__bridge CFMutableSetRef)[[NSMutableSet new] autorelease];
#endif
}

CFMutableSetRef MutableSetWithCapacity( NSUInteger length )
{ return (__bridge CFMutableSetRef)[NSMutableSet setWithCapacity:length]; }

CFMutableSetRef MutableSetWithArray( CFArrayRef array )
{ return (__bridge CFMutableSetRef)[NSMutableSet setWithArray:(__bridge NSArray *)array]; }

CFMutableSetRef MutableSetWithObject( CFTypeRef obj )
{ return (__bridge CFMutableSetRef)[NSMutableSet setWithObject:(__bridge id)obj]; }

CFMutableSetRef MutableSetWithObjects( CFTypeRef obj, ... )
{
    va_list ap;
    va_start( ap, obj );
    NSMutableSet *set = [NSMutableSet setWithCapacity:0];
    while ( obj ) {
        [set addObject:(__bridge id)obj];
        obj = (__bridge CFTypeRef)va_arg( ap, id );
    }
    va_end( ap );
    return (__bridge CFMutableSetRef)set;
}

CFMutableSetRef MutableSetWithSet( CFSetRef set )
{ return (__bridge CFMutableSetRef)[NSMutableSet setWithSet:(__bridge NSSet *)set]; }

// Add/remove
void MutableSetAddObject( CFMutableSetRef ref, CFTypeRef obj )
{ [(__bridge NSMutableSet *)ref addObject:(__bridge id)obj]; }

void MutableSetRemoveObject( CFMutableSetRef ref, CFTypeRef obj )
{ [(__bridge NSMutableSet *)ref removeObject:(__bridge id)obj]; }

void MutableSetRemoveAllObjects( CFMutableSetRef ref )
{ [(__bridge NSMutableSet *)ref removeAllObjects]; }

void MutableSetAddObjectsFromArray( CFMutableSetRef ref, CFArrayRef array )
{ [(__bridge NSMutableSet *)ref addObjectsFromArray:(__bridge NSArray *)array]; }

// Combine/recombine
void MutableSetUnionSet( CFMutableSetRef ref1, CFSetRef ref2 )
{ [(__bridge NSMutableSet *)ref1 unionSet:(__bridge NSSet *)ref2]; }

void MutableSetMinusSet( CFMutableSetRef ref1, CFSetRef ref2 )
{ [(__bridge NSMutableSet *)ref1 minusSet:(__bridge NSSet *)ref2]; }

void MutableSetIntersectSet( CFMutableSetRef ref1, CFSetRef ref2 )
{ [(__bridge NSMutableSet *)ref1 intersectSet:(__bridge NSSet *)ref2]; }

void MutableSetSet( CFMutableSetRef ref1, CFSetRef ref2 )
{ [(__bridge NSMutableSet *)ref1 setSet:(__bridge NSSet *)ref2]; }


#pragma mark - counted set
// Class
Class CountedSetClass( void )
{ return [NSCountedSet class]; }

// - init -
NSCountedSet *CountedSetNew( void )
{
#if __has_feature(objc_arc)
    return [[NSCountedSet alloc] initWithCapacity:0];
#else
    return [[[NSCountedSet alloc] initWithCapacity:0] autorelease];
#endif
}

NSCountedSet *CountedSetWithArray( CFArrayRef array )
{
#if __has_feature(objc_arc)
    return [[NSCountedSet alloc] initWithArray:(__bridge NSArray *)array];
#else
    return [[[NSCountedSet alloc] initWithArray:(__bridge NSArray *)array] autorelease];
#endif
}

NSCountedSet *CountedSetWithSet( CFSetRef set )
{
#if __has_feature(objc_arc)
    return [[NSCountedSet alloc] initWithSet:(__bridge NSSet *)set];
#else
    return [[[NSCountedSet alloc] initWithSet:(__bridge NSSet *)set] autorelease];
#endif
}

NSCountedSet *CountedSetWithCapacity( NSUInteger length )
{
#if __has_feature(objc_arc)
    return [[NSCountedSet alloc] initWithCapacity:length];
#else
    return [[[NSCountedSet alloc] initWithCapacity:length] autorelease];
#endif
}

// - add/remove -
void CountedSetAddObject( NSCountedSet *ref, CFTypeRef obj )
{ [ref addObject:(__bridge id)obj]; }

void CountedSetRemoveObject( NSCountedSet *ref, CFTypeRef obj )
{ [ref removeObject:(__bridge id)obj]; }

// - combine/recombine
void CountedSetUnionSet( NSCountedSet *ref, CFSetRef set )
{ [ref unionSet:(__bridge NSSet *)set]; }

void CountedSetMinusSet( NSCountedSet *ref, CFSetRef set )
{ [ref minusSet:(__bridge NSSet *)set]; }

void CountedSetIntersectSet( NSCountedSet *ref, CFSetRef set )
{ [ref intersectSet:(__bridge NSSet *)set]; }

// - examine -
NSUInteger CountedSetCountForObject( NSCountedSet *ref, CFTypeRef obj )
{ return [ref countForObject:(__bridge id)obj]; }

// - accessing members -
NSEnumerator *CountedSetObjectEnumerator( NSCountedSet *ref )
{ return [ref objectEnumerator]; }

