/*
 ComparisonPredicate.h
 
 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class ComparisonPredicateClass( void );

// Create
NSComparisonPredicate *ComparisonPredicateWithCoder( NSCoder *coder );
NSComparisonPredicate *ComparisonPredicateWithCustomSelector( NSExpression *leftExpression, NSExpression *rightExpression, CFStringRef customSelector );
NSComparisonPredicate *ComparisonPredicateWithModifier( NSExpression *leftExpression, NSExpression *rightExpression, NSComparisonPredicateModifier modifier, NSPredicateOperatorType type, NSComparisonPredicateOptions options );

// Info
NSComparisonPredicateModifier ComparisonPredicateModifier( NSComparisonPredicate *ref );
SEL ComparisonPredicateCustomSelector( NSComparisonPredicate *ref );
NSExpression *ComparisonPredicateRightExpression( NSComparisonPredicate *ref );
NSExpression *ComparisonPredicateLeftExpression( NSComparisonPredicate *ref );
NSComparisonPredicateOptions ComparisonPredicateOptions( NSComparisonPredicate *ref );
NSPredicateOperatorType ComparisonPredicateOperatorType( NSComparisonPredicate *ref );
