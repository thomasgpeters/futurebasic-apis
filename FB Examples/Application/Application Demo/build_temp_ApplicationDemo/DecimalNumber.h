/*
 DecimalNumber.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class DecimalNumberClass( void );

// - create -
NSDecimalNumber *DecimalNumberWithDecimal( NSDecimal dcm );
NSDecimalNumber *DecimalNumberWithMantissa( UInt64 mantissa, short exponent, BOOL isNegative  );
NSDecimalNumber *DecimalNumberWithString( CFStringRef string );
NSDecimalNumber *DecimalNumberWithStringAndLocale( CFStringRef string, CFLocaleRef locale );
NSDecimalNumber *DecimalNumberOne( void );
NSDecimalNumber *DecimalNumberZero( void );
NSDecimalNumber *DecimalNumberNotANumber( void );

// - perform arithmetic -
NSDecimalNumber *DecimalNumberByAdding( NSDecimalNumber *ref1, NSDecimalNumber *ref2 );
NSDecimalNumber *DecimalNumberBySubtracting( NSDecimalNumber *ref1, NSDecimalNumber *ref2 );
NSDecimalNumber *DecimalNumberByMultiplyingBy( NSDecimalNumber *ref1, NSDecimalNumber *ref2 );
NSDecimalNumber *DecimalNumberByDividingBy( NSDecimalNumber *ref1, NSDecimalNumber *ref2 );
NSDecimalNumber *DecimalNumberByRaisingToPower( NSDecimalNumber *ref, NSUInteger power );
NSDecimalNumber *DecimalNumberByMultiplyingByPowerOf10( NSDecimalNumber *ref, short power );
NSDecimalNumber *DecimalNumberByAddingWithBehavior( NSDecimalNumber *ref1, NSDecimalNumber *ref2, id<NSDecimalNumberBehaviors> behavior );
NSDecimalNumber *DecimalNumberBySubtractingWithBehavior( NSDecimalNumber *ref1, NSDecimalNumber *ref2, id<NSDecimalNumberBehaviors> behavior );
NSDecimalNumber *DecimalNumberByMultiplyingByWithBehavior( NSDecimalNumber *ref1, NSDecimalNumber *ref2, id<NSDecimalNumberBehaviors> behavior );
NSDecimalNumber *DecimalNumberByDividingByWithBehavior( NSDecimalNumber *ref1, NSDecimalNumber *ref2, id<NSDecimalNumberBehaviors> behavior );
NSDecimalNumber *DecimalNumberByRaisingToPowerWithBehavior( NSDecimalNumber *ref, NSUInteger power, id<NSDecimalNumberBehaviors> behavior );
NSDecimalNumber *DecimalNumberByMultiplyingByPowerOf10WithBehavior( NSDecimalNumber *ref, short power, id<NSDecimalNumberBehaviors> behavior );

// - rounding -
NSDecimalNumber *DecimalNumberByRounding( NSDecimalNumber *ref, id<NSDecimalNumberBehaviors> behavior );

// - behavior -
id<NSDecimalNumberBehaviors> DecimalNumberDefaultBehavior( void );

// - value -
NSDecimal DecimalNumberDecimalValue( NSDecimalNumber *ref );
double DecimalNumberDoubleValue( NSDecimalNumber *ref );
CFStringRef DecimalNumberDescription( NSDecimalNumber *ref, CFLocaleRef locale );

// - compare -
NSComparisonResult DecimalNumberCompare( NSDecimalNumber *ref1, NSDecimalNumber *ref2 );

// - min/max values -
NSDecimalNumber *DecimalNumberMaximum( void );
NSDecimalNumber *DecimalNumberMinimum( void );

// Convenience
CFStringRef DecimalNumberString( NSDecimalNumber *ref );


#pragma mark - decimalnumberbehaviors
// - rounding -
NSRoundingMode DecimalNumberBehaviorsRoundingMode( id<NSDecimalNumberBehaviors> ref );
short DecimalNumberBehaviorsScale( id<NSDecimalNumberBehaviors> ref );


#pragma mark - decimalnumberhandler
// - create -
NSDecimalNumberHandler *DecimalNumberHandlerDefault( void );
NSDecimalNumberHandler *DecimalNumberHandlerWithRoundingMode( NSRoundingMode mode, short scale, BOOL raiseOnExactness, BOOL raiseOnOverflow, BOOL raiseOnUnderflow, BOOL raiseOnDivideByZero );


