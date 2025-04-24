/*
 Expression.m

 Bernie Wylde
 */

#import "Expression.h"

// Class
Class ExpressionClass( void )
{ return [NSExpression class]; }

// Init
NSExpression *ExpressionWithType( NSExpressionType type )
{
#if __has_feature(objc_arc)
    return [[NSExpression alloc] initWithExpressionType:type];
#else
    return [[[NSExpression alloc] initWithExpressionType:type] autorelease];
#endif
}

NSExpression *ExpressionWithFormat( CFStringRef format, ... )
{
    va_list ap;
    va_start( ap, format );
    NSExpression *expression = [NSExpression expressionWithFormat:(__bridge NSString *)format arguments:ap];
    va_end(ap);
    return expression;
}

NSExpression *ExpressionWithFormatAndArgumentArray( CFStringRef format, CFArrayRef argArray )
{ return [NSExpression expressionWithFormat:(__bridge NSString *)format argumentArray:(__bridge NSArray *)argArray]; }

NSExpression *ExpressionWithFormatAndArguments( CFStringRef format, va_list argList )
{ return [NSExpression expressionWithFormat:(__bridge NSString *)format arguments:argList]; }

// Create for value
NSExpression *ExpressionForConstantValue( CFTypeRef obj )
{ return [NSExpression expressionForConstantValue:(__bridge id)obj]; }

NSExpression *ExpressionForEvaluatedObject( void )
{ return [NSExpression expressionForEvaluatedObject]; }

NSExpression *ExpressionForKeyPath( CFStringRef keyPath )
{ return [NSExpression expressionForKeyPath:(__bridge NSString *)keyPath]; }

NSExpression *ExpressionForVariable( CFStringRef string )
{ return [NSExpression expressionForVariable:(__bridge NSString *)string]; }

NSExpression *ExpressionForAnyKey( void )
{ return [NSExpression expressionForAnyKey]; }

// Create collection
NSExpression *ExpressionForAggregate( CFArrayRef subexpressions )
{ return [NSExpression expressionForAggregate:(__bridge NSArray *)subexpressions]; }

NSExpression *ExpressionForUnionSet( NSExpression *left, NSExpression *right )
{ return [NSExpression expressionForUnionSet:left with:right]; }

NSExpression *ExpressionForIntersectSet( NSExpression *left, NSExpression *right )
{ return [NSExpression expressionForIntersectSet:left with:right]; }

NSExpression *ExpressionForMinusSet( NSExpression *left, NSExpression *right )
{ return [NSExpression expressionForMinusSet:left with:right]; }

// Create subquery
NSExpression *ExpressionForSubquery( NSExpression *exp, CFStringRef variable, NSPredicate *predicate )
{ return [NSExpression expressionForSubquery:exp usingIteratorVariable:(__bridge NSString *)variable predicate:predicate]; }

// Create using blocks
NSExpression *ExpressionForArguments( CFArrayRef arguments, CUI_ExpressionForArgumentsCallbackType callback, void *userData )
{
    return [NSExpression expressionForBlock:^(id evaluatedObject, NSArray *expressions, NSMutableDictionary *context) {
        return (__bridge id)(*callback)((__bridge CFTypeRef)evaluatedObject,(__bridge CFArrayRef)expressions,(__bridge CFMutableDictionaryRef)context,userData);
    } arguments:(__bridge NSArray *)arguments];
}

// Create for function
NSExpression *ExpressionForFunction( CFStringRef name, CFArrayRef arguments )
{ return [NSExpression expressionForFunction:(__bridge NSString *)name arguments:(__bridge NSArray *)arguments]; }

// Info
CFArrayRef ExpressionArguments( NSExpression *ref )
{ return (__bridge CFArrayRef)[ref arguments]; }

CFTypeRef ExpressionCollection( NSExpression *ref )
{ return (__bridge CFTypeRef)[ref collection]; }

CFTypeRef ExpressionConstantValue( NSExpression *ref )
{ return (__bridge CFTypeRef)[ref constantValue]; }

NSExpressionType ExpressionType( NSExpression *ref )
{ return [ref expressionType]; }

CFStringRef ExpressionFunction( NSExpression *ref )
{ return (__bridge CFStringRef)[ref function]; }

CFStringRef ExpressionKeyPath( NSExpression *ref )
{ return (__bridge CFStringRef)[ref keyPath]; }

NSExpression *ExpressionOperand( NSExpression *ref )
{ return [ref operand]; }

NSPredicate *ExpressionPredicate( NSExpression *ref )
{ return [ref predicate]; }

NSExpression *ExpressionLeftExpression( NSExpression *ref )
{ return [ref leftExpression]; }

NSExpression *ExpressionRightExpression( NSExpression *ref )
{ return [ref rightExpression]; }

CFStringRef ExpressionVariable( NSExpression *ref )
{ return (__bridge CFStringRef)[ref variable]; }

// Evaluate
CFTypeRef ExpressionValueWithObject( NSExpression *ref, CFTypeRef obj, CFMutableDictionaryRef context )
{ return (__bridge CFTypeRef)[ref expressionValueWithObject:(__bridge id)obj context:(__bridge NSMutableDictionary *)context]; }

void ExpressionAllowEvaluation( NSExpression *ref )
{ [ref allowEvaluation]; }

// Initializers
NSExpression *ExpressionForConditional( NSPredicate *predicate, NSExpression *trueExpression, NSExpression *falseExpression )
{ return [NSExpression expressionForConditional:predicate trueExpression:trueExpression falseExpression:falseExpression]; }

// Instance properties
NSExpression *ExpressionFalseExpression( NSExpression *ref )
{ return [ref falseExpression]; }

NSExpression *ExpressionTrueExpression( NSExpression *ref )
{ return [ref trueExpression]; }
