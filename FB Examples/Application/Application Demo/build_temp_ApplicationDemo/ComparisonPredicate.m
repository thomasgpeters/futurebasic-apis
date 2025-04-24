/*
 ComparisonPredicate.m
 
 Bernie Wylde
 */

#import "ComparisonPredicate.h"

// Class
Class ComparisonPredicateClass( void )
{ return [NSComparisonPredicate class]; }

// Create
NSComparisonPredicate *ComparisonPredicateWithCoder( NSCoder *coder )
{
#if __has_feature(objc_arc)
    return [[NSComparisonPredicate alloc] initWithCoder:coder];
#else
    return [[[NSComparisonPredicate alloc] initWithCoder:coder] autorelease];
#endif
}

NSComparisonPredicate *ComparisonPredicateWithCustomSelector( NSExpression *leftExpression, NSExpression *rightExpression, CFStringRef customSelector )
{ return (NSComparisonPredicate *)[NSComparisonPredicate predicateWithLeftExpression:leftExpression rightExpression:rightExpression customSelector:NSSelectorFromString((__bridge NSString *)customSelector)]; }

NSComparisonPredicate *ComparisonPredicateWithModifier( NSExpression *leftExpression, NSExpression *rightExpression, NSComparisonPredicateModifier modifier, NSPredicateOperatorType type, NSComparisonPredicateOptions options )
{ return (NSComparisonPredicate *)[NSComparisonPredicate predicateWithLeftExpression:leftExpression rightExpression:rightExpression modifier:modifier type:type options:options]; }

// Info
NSComparisonPredicateModifier ComparisonPredicateModifier( NSComparisonPredicate *ref )
{ return [ref comparisonPredicateModifier]; }

SEL ComparisonPredicateCustomSelector( NSComparisonPredicate *ref )
{ return [ref customSelector]; }

NSExpression *ComparisonPredicateRightExpression( NSComparisonPredicate *ref )
{ return [ref rightExpression]; }

NSExpression *ComparisonPredicateLeftExpression( NSComparisonPredicate *ref )
{ return [ref leftExpression]; }

NSComparisonPredicateOptions ComparisonPredicateOptions( NSComparisonPredicate *ref )
{ return [ref options]; }

NSPredicateOperatorType ComparisonPredicateOperatorType( NSComparisonPredicate *ref )
{ return [ref predicateOperatorType]; }
