/*
 Expression.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef CFTypeRef (*CUI_ExpressionForArgumentsCallbackType)(CFTypeRef,CFArrayRef,CFMutableDictionaryRef,void*);

// Class
Class ExpressionClass( void );

// Init
NSExpression *ExpressionWithType( NSExpressionType type );
NSExpression *ExpressionWithFormat( CFStringRef format, ... );
NSExpression *ExpressionWithFormatAndArgumentArray( CFStringRef format, CFArrayRef argArray );
NSExpression *ExpressionWithFormatAndArguments( CFStringRef format, va_list argList );

// Create for value
NSExpression *ExpressionForConstantValue( CFTypeRef obj );
NSExpression *ExpressionForEvaluatedObject( void );
NSExpression *ExpressionForKeyPath( CFStringRef keyPath );
NSExpression *ExpressionForVariable( CFStringRef string );
NSExpression *ExpressionForAnyKey( void );

// Create collection
NSExpression *ExpressionForAggregate( CFArrayRef subexpressions );
NSExpression *ExpressionForUnionSet( NSExpression *left, NSExpression *right );
NSExpression *ExpressionForIntersectSet( NSExpression *left, NSExpression *right );
NSExpression *ExpressionForMinusSet( NSExpression *left, NSExpression *right );

// Create subquery
NSExpression *ExpressionForSubquery( NSExpression *exp, CFStringRef variable, NSPredicate *predicate );

// Create using blocks
NSExpression *ExpressionForArguments( CFArrayRef arguments, CUI_ExpressionForArgumentsCallbackType callback, void *userData );

// Create for function
NSExpression *ExpressionForFunction( CFStringRef name, CFArrayRef arguments );

// Info
CFArrayRef ExpressionArguments( NSExpression *ref );
CFTypeRef ExpressionCollection( NSExpression *ref );
CFTypeRef ExpressionConstantValue( NSExpression *ref );
NSExpressionType ExpressionType( NSExpression *ref );
CFStringRef ExpressionFunction( NSExpression *ref );
CFStringRef ExpressionKeyPath( NSExpression *ref );
NSExpression *ExpressionOperand( NSExpression *ref );
NSPredicate *ExpressionPredicate( NSExpression *ref );
NSExpression *ExpressionLeftExpression( NSExpression *ref );
NSExpression *ExpressionRightExpression( NSExpression *ref );
CFStringRef ExpressionVariable( NSExpression *ref );

// Evaluate
CFTypeRef ExpressionValueWithObject( NSExpression *ref, CFTypeRef obj, CFMutableDictionaryRef context );

void ExpressionAllowEvaluation( NSExpression *ref );

// Initializers
NSExpression *ExpressionForConditional( NSPredicate *predicate, NSExpression *trueExpression, NSExpression *falseExpression );

// Instance properties
NSExpression *ExpressionFalseExpression( NSExpression *ref );
NSExpression *ExpressionTrueExpression( NSExpression *ref );
