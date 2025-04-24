/*
 Predicate.m
 
 Bernie Wylde
 */

#import "Predicate.h"

// Class
Class PredicateClass( void )
{ return [NSPredicate class]; }

// Create
NSPredicate *PredicateWithFormat( CFStringRef format, ... )
{
    va_list ap;
    va_start( ap, format );
    NSPredicate *ref = [NSPredicate predicateWithFormat:(__bridge NSString *)format arguments:ap];
    va_end( ap );
    return ref;
}

NSPredicate *PredicateWithFormatAndArgumentArray( CFStringRef format, CFArrayRef arguments )
{ return [NSPredicate predicateWithFormat:(__bridge NSString *)format argumentArray:(__bridge NSArray *)arguments]; }

NSPredicate *PredicateWithSubstitionVariables( NSPredicate *ref, CFDictionaryRef variables )
{ return [ref predicateWithSubstitutionVariables:(__bridge NSDictionary *)variables]; }

NSPredicate *PredicateWithValue( BOOL value )
{ return [NSPredicate predicateWithValue:value]; }

NSPredicate *PredicateFromMetadataQueryString( CFStringRef string )
{ return [NSPredicate predicateFromMetadataQueryString:(__bridge NSString *)string]; }

// Evaluate
BOOL PredicateEvaluateWithObject( NSPredicate *ref, CFTypeRef obj )
{ return [ref evaluateWithObject:(__bridge id)obj]; }

BOOL PredicateEvaluateWithObjectAndSubstitutionVariables( NSPredicate *ref, CFTypeRef obj, CFDictionaryRef variables )
{ return [ref evaluateWithObject:(__bridge id)obj substitutionVariables:(__bridge NSDictionary *)variables]; }

void PredicateAllowEvaluation( NSPredicate *ref )
{ [ref allowEvaluation]; }

// String representation
CFStringRef PredicateFormat( NSPredicate *ref )
{ return(__bridge CFStringRef)[ref predicateFormat]; }

