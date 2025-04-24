/*
 CompoundPredicate.m
 
 Bernie Wylde
 */

#import "CompoundPredicate.h"

// Class
Class CompoundPredicateClass( void )
{ return [NSCompoundPredicate class]; }

// Constructors
NSCompoundPredicate *CompoundPredicateAndPredicateWithSubpredicates( CFArrayRef subpredicates )
{ return (NSCompoundPredicate *)[NSCompoundPredicate andPredicateWithSubpredicates:(__bridge NSArray *)subpredicates]; }

NSCompoundPredicate *CompoundPredicateNotPredicateWithSubpredicate( NSPredicate *predicate )
{ return (NSCompoundPredicate *)[NSCompoundPredicate notPredicateWithSubpredicate:predicate]; }

NSCompoundPredicate *CompoundPredicateOrPredicateWithSubpredicates( CFArrayRef subpredicates )
{ return (NSCompoundPredicate *)[NSCompoundPredicate orPredicateWithSubpredicates:(__bridge NSArray *)subpredicates]; }

NSCompoundPredicate *CompoundPredicateWithType( NSCompoundPredicateType type, CFArrayRef subpredicates )
{
#if __has_feature(objc_arc)
    return [[NSCompoundPredicate alloc] initWithType:type subpredicates:(__bridge NSArray *)subpredicates];
#else
    return [[[NSCompoundPredicate alloc] initWithType:type subpredicates:(__bridge NSArray *)subpredicates] autorelease];
#endif
}

// Info
NSCompoundPredicateType CompoundPredicateType( NSCompoundPredicate *ref )
{ return [ref compoundPredicateType]; }

CFArrayRef CompoundPredicateSubpredicates( NSCompoundPredicate *ref )
{ return (__bridge CFArrayRef)[ref subpredicates]; }
