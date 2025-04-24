/*
 Predicate.h
 
 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class PredicateClass( void );

// Create
NSPredicate *PredicateWithFormat( CFStringRef format, ... );
NSPredicate *PredicateWithFormatAndArgumentArray( CFStringRef format, CFArrayRef arguments );
NSPredicate *PredicateWithSubstitionVariables( NSPredicate *ref, CFDictionaryRef variables );
NSPredicate *PredicateWithValue( BOOL value );
NSPredicate *PredicateFromMetadataQueryString( CFStringRef string );

// Evaluate
BOOL PredicateEvaluateWithObject( NSPredicate *ref, CFTypeRef obj );
BOOL PredicateEvaluateWithObjectAndSubstitutionVariables( NSPredicate *ref, CFTypeRef obj, CFDictionaryRef variables );
void PredicateAllowEvaluation( NSPredicate *ref );

// String representation
CFStringRef PredicateFormat( NSPredicate *ref );

