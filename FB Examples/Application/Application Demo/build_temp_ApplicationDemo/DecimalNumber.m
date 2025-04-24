/*
 DecimalNumber.m

 Bernie Wylde
 */

#import "DecimalNumber.h"

// Class
Class DecimalNumberClass( void )
{ return [NSDecimalNumber class]; }

// - create -
NSDecimalNumber *DecimalNumberWithDecimal( NSDecimal dcm )
{ return [NSDecimalNumber decimalNumberWithDecimal:dcm]; }

NSDecimalNumber *DecimalNumberWithMantissa( UInt64 mantissa, short exponent, BOOL isNegative  )
{ return [NSDecimalNumber decimalNumberWithMantissa:mantissa exponent:exponent isNegative:isNegative]; }

NSDecimalNumber *DecimalNumberWithString( CFStringRef string )
{ return [NSDecimalNumber decimalNumberWithString:(__bridge NSString *)string]; }

NSDecimalNumber *DecimalNumberWithStringAndLocale( CFStringRef string, CFLocaleRef locale )
{ return [NSDecimalNumber decimalNumberWithString:(__bridge NSString *)string locale:(__bridge NSLocale *)locale]; }

NSDecimalNumber *DecimalNumberOne( void )
{ return [NSDecimalNumber one]; }

NSDecimalNumber *DecimalNumberZero( void )
{ return [NSDecimalNumber zero]; }

NSDecimalNumber *DecimalNumberNotANumber( void )
{ return [NSDecimalNumber notANumber]; }


// - perform arithmetic -
NSDecimalNumber *DecimalNumberByAdding( NSDecimalNumber *ref1, NSDecimalNumber *ref2 )
{ return [ref1 decimalNumberByAdding:ref2]; }

NSDecimalNumber *DecimalNumberBySubtracting( NSDecimalNumber *ref1, NSDecimalNumber *ref2 )
{ return [ref1 decimalNumberBySubtracting:ref2]; }

NSDecimalNumber *DecimalNumberByMultiplyingBy( NSDecimalNumber *ref1, NSDecimalNumber *ref2 )
{ return [ref1 decimalNumberByMultiplyingBy:ref2]; }

NSDecimalNumber *DecimalNumberByDividingBy( NSDecimalNumber *ref1, NSDecimalNumber *ref2 )
{ return [ref1 decimalNumberByDividingBy:ref2]; }

NSDecimalNumber *DecimalNumberByRaisingToPower( NSDecimalNumber *ref, NSUInteger power )
{ return [ref decimalNumberByRaisingToPower:power]; }

NSDecimalNumber *DecimalNumberByMultiplyingByPowerOf10( NSDecimalNumber *ref, short power )
{ return [ref decimalNumberByMultiplyingByPowerOf10:power]; }

NSDecimalNumber *DecimalNumberByAddingWithBehavior( NSDecimalNumber *ref1, NSDecimalNumber *ref2, id<NSDecimalNumberBehaviors> behavior )
{ return [ref1 decimalNumberByAdding:ref2 withBehavior:behavior]; }

NSDecimalNumber *DecimalNumberBySubtractingWithBehavior( NSDecimalNumber *ref1, NSDecimalNumber *ref2, id<NSDecimalNumberBehaviors> behavior )
{ return [ref1 decimalNumberBySubtracting:ref2 withBehavior:behavior]; }

NSDecimalNumber *DecimalNumberByMultiplyingByWithBehavior( NSDecimalNumber *ref1, NSDecimalNumber *ref2, id<NSDecimalNumberBehaviors> behavior )
{ return [ref1 decimalNumberByMultiplyingBy:ref2 withBehavior:behavior]; }

NSDecimalNumber *DecimalNumberByDividingByWithBehavior( NSDecimalNumber *ref1, NSDecimalNumber *ref2, id<NSDecimalNumberBehaviors> behavior )
{ return [ref1 decimalNumberByDividingBy:ref2 withBehavior:behavior]; }

NSDecimalNumber *DecimalNumberByRaisingToPowerWithBehavior( NSDecimalNumber *ref, NSUInteger power, id<NSDecimalNumberBehaviors> behavior )
{ return [ref decimalNumberByRaisingToPower:power withBehavior:behavior]; }

NSDecimalNumber *DecimalNumberByMultiplyingByPowerOf10WithBehavior( NSDecimalNumber *ref, short power, id<NSDecimalNumberBehaviors> behavior )
{ return [ref decimalNumberByMultiplyingByPowerOf10:power withBehavior:behavior]; }


// - rounding -
NSDecimalNumber *DecimalNumberByRounding( NSDecimalNumber *ref, id<NSDecimalNumberBehaviors> behavior )
{ return [ref decimalNumberByRoundingAccordingToBehavior:behavior]; }

// - behavior -
id<NSDecimalNumberBehaviors> DecimalNumberDefaultBehavior( void )
{ return [NSDecimalNumber defaultBehavior]; }

// - value -
NSDecimal DecimalNumberDecimalValue( NSDecimalNumber *ref )
{ return [ref decimalValue]; }

double DecimalNumberDoubleValue( NSDecimalNumber *ref )
{ return [ref doubleValue]; }

CFStringRef DecimalNumberDescription( NSDecimalNumber *ref, CFLocaleRef locale )
{ return (__bridge CFStringRef)[ref descriptionWithLocale:(__bridge NSLocale *)locale]; }

// - compare -
NSComparisonResult DecimalNumberCompare( NSDecimalNumber *ref1, NSDecimalNumber *ref2 )
{ return [ref1 compare:ref2]; }

// - min/max values -
NSDecimalNumber *DecimalNumberMaximum( void )
{ return [NSDecimalNumber maximumDecimalNumber]; }

NSDecimalNumber *DecimalNumberMinimum( void )
{ return [NSDecimalNumber minimumDecimalNumber]; }

// Convenience
CFStringRef DecimalNumberString( NSDecimalNumber *ref )
{
    NSDecimal dcm = [ref decimalValue];
    return (__bridge CFStringRef)NSDecimalString(&dcm,nil);
}



#pragma mark - decimalnumberbehaviors
// - rounding -
NSRoundingMode DecimalNumberBehaviorsRoundingMode( id<NSDecimalNumberBehaviors> ref )
{ return [ref roundingMode]; }

short DecimalNumberBehaviorsScale( id<NSDecimalNumberBehaviors> ref )
{ return [ref scale]; }


#pragma mark - decimalnumberhandler
// - create -
NSDecimalNumberHandler *DecimalNumberHandlerDefault( void )
{ return [NSDecimalNumberHandler defaultDecimalNumberHandler]; }

NSDecimalNumberHandler *DecimalNumberHandlerWithRoundingMode( NSRoundingMode mode, short scale, BOOL raiseOnExactness, BOOL raiseOnOverflow, BOOL raiseOnUnderflow, BOOL raiseOnDivideByZero )
{ return [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:mode scale:scale raiseOnExactness:raiseOnExactness raiseOnOverflow:raiseOnOverflow raiseOnUnderflow:raiseOnUnderflow raiseOnDivideByZero:raiseOnDivideByZero]; }

