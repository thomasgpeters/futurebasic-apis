/*
 NumberFormatter.m

 Bernie Wylde
 */

#import "NumberFormatter.h"

// Class
Class NumberFormatterClass( void )
{ return [NSNumberFormatter class]; }

// - init -
NSNumberFormatter *NumberFormatterInit( void )
{
#if __has_feature(objc_arc)
    return [[NSNumberFormatter alloc] init];
#else
    return [[[NSNumberFormatter alloc] init] autorelease];
#endif
}

NSNumberFormatter *NumberFormatterWithStyle( NSNumberFormatterStyle style )
{
#if __has_feature(objc_arc)
    NSNumberFormatter *ref = [[NSNumberFormatter alloc] init];
#else
    NSNumberFormatter *ref = [[[NSNumberFormatter alloc] init] autorelease];
#endif
    [ref setNumberStyle:style];
    return ref;
}

// - configure -
NSNumberFormatterBehavior NumberFormatterBehavior( NSNumberFormatter *ref )
{ return [ref formatterBehavior]; }

void NumberFormatterSetBehavior( NSNumberFormatter *ref, NSNumberFormatterBehavior behavior )
{ [ref setFormatterBehavior:behavior]; }

NSNumberFormatterBehavior NumberFormatterDefaultBehavior( void )
{ return [NSNumberFormatter defaultFormatterBehavior]; }

void NumberFormatterSetDefaultBehavior( NSNumberFormatterBehavior behavior )
{ [NSNumberFormatter setDefaultFormatterBehavior:behavior]; }

NSNumberFormatterStyle NumberFormatterNumberStyle( NSNumberFormatter *ref )
{ return [ref numberStyle]; }

void NumberFormatterSetNumberStyle( NSNumberFormatter *ref, NSNumberFormatterStyle style )
{ [ref setNumberStyle:style]; }

BOOL NumberFormatterGeneratesDecimalNumbers( NSNumberFormatter *ref )
{ return [ref generatesDecimalNumbers]; }

void NumberFormatterSetGeneratesDecimalNumbers( NSNumberFormatter *ref, BOOL flag )
{ [ref setGeneratesDecimalNumbers:flag]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
NSInteger NumberFormatterMinimumGroupingDigits( NSNumberFormatter *ref )
{ return [ref minimumGroupingDigits]; }

void NumberFormatterSetMinimumGroupingDigits( NSNumberFormatter *ref, NSInteger digits )
{ [ref setMinimumGroupingDigits:digits]; }
#endif // 150000

// - convert between numbers and strings -
BOOL NumberFormatterGetObjectValue( NSNumberFormatter *ref, CFTypeRef *obj, CFStringRef string, CFRange *range, NSError **err  )
{
    NSRange nsRange;
#if __has_feature(objc_arc)
    id temp = nil;
    BOOL result = [ref getObjectValue:&temp forString:(__bridge NSString *)string range:&nsRange error:err];
    if ( obj) *obj = (__bridge CFTypeRef)temp;
#else
    BOOL result = [ref getObjectValue:(id *)obj forString:(__bridge NSString *)string range:&nsRange error:err];
#endif
    if ( result ) {
        range->location = (CFIndex)nsRange.location;
        range->length = (CFIndex)nsRange.length;
    }
    return result;
}

CFNumberRef NumberFormatterNumberFromString( NSNumberFormatter *ref, CFStringRef string )
{ return (__bridge CFNumberRef)[ref numberFromString:(__bridge NSString *)string]; }

CFStringRef NumberFormatterStringFromNumber( NSNumberFormatter *ref, CFNumberRef number )
{ return (__bridge CFStringRef)[ref stringFromNumber:(__bridge NSNumber *)number]; }

CFStringRef NumberFormatterLocalizedStringFromNumber( CFNumberRef number, NSNumberFormatterStyle style )
{ return (__bridge CFStringRef)[NSNumberFormatter localizedStringFromNumber:(__bridge NSNumber *)number numberStyle:style]; }

// - localization -
BOOL NumberFormatterLocalizesFormat( NSNumberFormatter *ref )
{ return [ref localizesFormat]; }

void NumberFormatterSetLocalizesFormat( NSNumberFormatter *ref, BOOL flag )
{ [ref setLocalizesFormat:flag]; }

CFLocaleRef NumberFormatterLocale( NSNumberFormatter *ref )
{ return (__bridge CFLocaleRef)[ref locale]; }

void NumberFormatterSetLocale( NSNumberFormatter *ref, CFLocaleRef locale )
{ [ref setLocale:(__bridge NSLocale *)locale]; }

// - rounding -
NSDecimalNumberHandler *NumberFormatterRoundingBehavior( NSNumberFormatter *ref )
{ return [ref roundingBehavior]; }

void NumberFormatterSetRoundingBehavior( NSNumberFormatter *ref, NSDecimalNumberHandler *behavior )
{ [ref setRoundingBehavior:behavior]; }

CFNumberRef NumberFormatterRoundingIncrement( NSNumberFormatter *ref )
{ return (__bridge CFNumberRef)[ref roundingIncrement]; }

void NumberFormatterSetRoundingIncrement( NSNumberFormatter *ref, CFNumberRef number )
{ [ref setRoundingIncrement:(__bridge NSNumber *)number]; }

NSNumberFormatterRoundingMode NumberFormatterRoundingMode( NSNumberFormatter *ref )
{ return [ref roundingMode]; }

void NumberFormatterSetRoundingMode( NSNumberFormatter *ref, NSNumberFormatterRoundingMode mode )
{ [ref setRoundingMode:mode]; }

// - formats -
CFStringRef NumberFormatterFormat( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref format]; }

void NumberFormatterSetFormat( NSNumberFormatter *ref, CFStringRef string )
{ [ref setFormat:(__bridge NSString *)string]; }

NSFormattingContext NumberFormatterFormattingContext( NSNumberFormatter *ref )
{ return [ref formattingContext]; }

void NumberFormatterSetFormattingContext( NSNumberFormatter *ref, NSFormattingContext context )
{ [ref setFormattingContext:context]; }

NSUInteger NumberFormatterFormatWidth( NSNumberFormatter *ref )
{ return [ref formatWidth]; }

void NumberFormatterSetFormatWidth( NSNumberFormatter *ref, NSUInteger value )
{ [ref setFormatWidth:value]; }

CFStringRef NumberFormatterNegativeFormat( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref negativeFormat]; }

void NumberFormatterSetNegativeWidth( NSNumberFormatter *ref, CFStringRef string )
{ [ref setNegativeFormat:(__bridge NSString *)string]; }

CFStringRef NumberFormatterPositiveFormat( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref positiveFormat]; }

void NumberFormatterSetPositiveFormat( NSNumberFormatter *ref, CFStringRef string )
{ [ref setPositiveFormat:(__bridge NSString *)string]; }

CFNumberRef NumberFormatterMultiplier( NSNumberFormatter *ref )
{ return (__bridge CFNumberRef)[ref multiplier]; }

void NumberFormatterSetMultiplier( NSNumberFormatter *ref, CFNumberRef number )
{ [ref setMultiplier:(__bridge NSNumber *)number]; }

// - symbols -
CFStringRef NumberFormatterPercentSymbol( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref percentSymbol]; }

void NumberFormatterSetPercentSymbol( NSNumberFormatter *ref, CFStringRef string )
{ [ref setPercentSymbol:(__bridge NSString *)string]; }

CFStringRef NumberFormatterPerMillSymbol( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref perMillSymbol]; }

void NumberFormatterSetPerMillSymbol( NSNumberFormatter *ref, CFStringRef string )
{ [ref setPerMillSymbol:(__bridge NSString *)string]; }

CFStringRef NumberFormatterMinusSign( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref minusSign]; }

void NumberFormatterSetMinusSign( NSNumberFormatter *ref, CFStringRef string )
{ [ref setMinusSign:(__bridge NSString *)string]; }

CFStringRef NumberFormatterPlusSign( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref plusSign]; }

void NumberFormatterSetPlusSign( NSNumberFormatter *ref, CFStringRef string )
{ [ref setPlusSign:(__bridge NSString *)string]; }

CFStringRef NumberFormatterExponentSymbol( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref exponentSymbol]; }

void NumberFormatterSetExponentSymbol( NSNumberFormatter *ref, CFStringRef string )
{ [ref setExponentSymbol:(__bridge NSString *)string]; }

CFStringRef NumberFormatterZeroSymbol( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref zeroSymbol]; }

void NumberFormatterSetZeroSymbol( NSNumberFormatter *ref, CFStringRef string )
{ [ref setZeroSymbol:(__bridge NSString *)string]; }

CFStringRef NumberFormatterNilSymbol( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref nilSymbol]; }

void NumberFormatterSetNilSymbol( NSNumberFormatter *ref, CFStringRef string )
{ [ref setNilSymbol:(__bridge NSString *)string]; }

CFStringRef NumberFormatterNotANumberSymbol( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref notANumberSymbol]; }

void NumberFormatterSetNotANumberSymbol( NSNumberFormatter *ref, CFStringRef string )
{ [ref setNotANumberSymbol:(__bridge NSString *)string]; }

CFStringRef NumberFormatterNegativeInfinitySymbol( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref negativeInfinitySymbol]; }

void NumberFormatterSetNegativeInfinitySymbol( NSNumberFormatter *ref, CFStringRef string )
{ [ref setNegativeInfinitySymbol:(__bridge NSString *)string]; }

CFStringRef NumberFormatterPositiveInfinitySymbol( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref positiveInfinitySymbol]; }

void NumberFormatterSetPositiveInfinitySymbol( NSNumberFormatter *ref, CFStringRef string )
{ [ref setPositiveInfinitySymbol:(__bridge NSString *)string]; }

// - currency -
CFStringRef NumberFormatterCurrencySymbol( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref currencySymbol]; }

void NumberFormatterSetCurrencySymbol( NSNumberFormatter *ref, CFStringRef string )
{ [ref setCurrencySymbol:(__bridge NSString *)string]; }

CFStringRef NumberFormatterCurrencyCode( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref currencyCode]; }

void NumberFormatterSetCurrencyCode( NSNumberFormatter *ref, CFStringRef string )
{ [ref setCurrencyCode:(__bridge NSString *)string]; }

CFStringRef NumberFormatterInternationalCurrencySymbol( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref internationalCurrencySymbol]; }

void NumberFormatterSetInternationalCurrencySymbol( NSNumberFormatter *ref, CFStringRef string )
{ [ref setInternationalCurrencySymbol:(__bridge NSString *)string]; }

CFStringRef NumberFormatterCurrencyGroupingSeparator( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref currencyGroupingSeparator]; }

void NumberFormatterSetCurrencyGroupingSeparator( NSNumberFormatter *ref, CFStringRef string )
{ [ref setCurrencyGroupingSeparator:(__bridge NSString *)string]; }

// - prefix and suffix -
CFStringRef NumberFormatterPositivePrefix( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref positivePrefix]; }

void NumberFormatterSetPositivePrefix( NSNumberFormatter *ref, CFStringRef string )
{ [ref setPositivePrefix:(__bridge NSString *)string]; }

CFStringRef NumberFormatterPositiveSuffix( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref positiveSuffix]; }

void NumberFormatterSetPositiveSuffix( NSNumberFormatter *ref, CFStringRef string )
{ [ref setPositiveSuffix:(__bridge NSString *)string]; }

CFStringRef NumberFormatterNegativePrefix( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref negativePrefix]; }

void NumberFormatterSetNegativePrefix( NSNumberFormatter *ref, CFStringRef string )
{ [ref setNegativePrefix:(__bridge NSString *)string]; }

CFStringRef NumberFormatterNegativeSuffix( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref negativeSuffix]; }

void NumberFormatterSetNegativeSuffix( NSNumberFormatter *ref, CFStringRef string )
{ [ref setNegativeSuffix:(__bridge NSString *)string]; }

// - display -
CFDictionaryRef NumberFormatterTextAttributesForNegativeValues( NSNumberFormatter *ref )
{ return (__bridge CFDictionaryRef)[ref textAttributesForNegativeValues]; }

void NumberFormatterSetTextAttributesForNegativeValues( NSNumberFormatter *ref, CFDictionaryRef attributes )
{ [ref setTextAttributesForNegativeValues:(__bridge NSDictionary *)attributes]; }

CFDictionaryRef NumberFormatterTextAttributesForPositiveValues( NSNumberFormatter *ref )
{ return (__bridge CFDictionaryRef)[ref textAttributesForPositiveValues]; }

void NumberFormatterSetTextAttributesForPositiveValues( NSNumberFormatter *ref, CFDictionaryRef attributes )
{ [ref setTextAttributesForPositiveValues:(__bridge NSDictionary *)attributes]; }

CFAttributedStringRef NumberFormatterAttributedStringForZero( NSNumberFormatter *ref )
{ return (__bridge CFAttributedStringRef)[ref attributedStringForZero]; }

void NumberFormatterSetAttributedStringForZero( NSNumberFormatter *ref, CFAttributedStringRef aString )
{ [ref setAttributedStringForZero:(__bridge NSAttributedString *)aString]; }

CFDictionaryRef NumberFormatterTextAttributesForZero( NSNumberFormatter *ref )
{ return (__bridge CFDictionaryRef)[ref textAttributesForZero]; }

void NumberFormatterSetTextAttributesForZero( NSNumberFormatter *ref, CFDictionaryRef attributes )
{ [ref setTextAttributesForZero:(__bridge NSDictionary *)attributes]; }

CFAttributedStringRef NumberFormatterAttributedStringForNil( NSNumberFormatter *ref )
{ return (__bridge CFAttributedStringRef)[ref attributedStringForNil]; }

void NumberFormatterSetAttributedStringForNil( NSNumberFormatter *ref, CFAttributedStringRef aString )
{ [ref setAttributedStringForNil:(__bridge NSAttributedString *)aString]; }

CFDictionaryRef NumberFormatterTextAttributesForNil( NSNumberFormatter *ref )
{ return (__bridge CFDictionaryRef)[ref textAttributesForNil]; }

void NumberFormatterSetTextAttributesForNil( NSNumberFormatter *ref, CFDictionaryRef attributes )
{ [ref setTextAttributesForNil:(__bridge NSDictionary *)attributes]; }

CFAttributedStringRef NumberFormatterAttributedStringForNotANumber( NSNumberFormatter *ref )
{ return (__bridge CFAttributedStringRef)[ref attributedStringForNotANumber]; }

void NumberFormatterSetAttributedStringForNotANumber( NSNumberFormatter *ref, CFAttributedStringRef aString )
{ [ref setAttributedStringForNotANumber:(__bridge NSAttributedString *)aString]; }

CFDictionaryRef NumberFormatterTextAttributesForNotANumber( NSNumberFormatter *ref )
{ return (__bridge CFDictionaryRef)[ref textAttributesForNotANumber]; }

void NumberFormatterSetTextAttributesForNotANumber( NSNumberFormatter *ref, CFDictionaryRef attributes )
{ [ref setTextAttributesForNotANumber:(__bridge NSDictionary *)attributes]; }

CFDictionaryRef NumberFormatterTextAttributesForPositiveInfinity( NSNumberFormatter *ref )
{ return (__bridge CFDictionaryRef)[ref textAttributesForPositiveInfinity]; }

void NumberFormatterSetTextAttributesForPositiveInfinity( NSNumberFormatter *ref, CFDictionaryRef attributes )
{ [ref setTextAttributesForPositiveInfinity:(__bridge NSDictionary *)attributes]; }

CFDictionaryRef NumberFormatterTextAttributesForNegativeInfinity( NSNumberFormatter *ref )
{ return (__bridge CFDictionaryRef)[ref textAttributesForNegativeInfinity]; }

void NumberFormatterSetTextAttributesForNegativeInfinity( NSNumberFormatter *ref, CFDictionaryRef attributes )
{ [ref setTextAttributesForNegativeInfinity:(__bridge NSDictionary *)attributes]; }

// - separators and grouping -
CFStringRef NumberFormatterGroupingSeparator( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref groupingSeparator]; }

void NumberFormatterSetGroupingSeparator( NSNumberFormatter *ref, CFStringRef string )
{ [ref setGroupingSeparator:(__bridge NSString *)string]; }

BOOL NumberFormatterUsesGroupingSeparator( NSNumberFormatter *ref )
{ return [ref usesGroupingSeparator]; }

void NumberFormatterSetUsesGroupingSeparator( NSNumberFormatter *ref, BOOL flag )
{ [ref setUsesGroupingSeparator:flag]; }

CFStringRef NumberFormatterThousandSeparator( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref thousandSeparator]; }

void NumberFormatterSetThousandSeparator( NSNumberFormatter *ref, CFStringRef string )
{ [ref setThousandSeparator:(__bridge NSString *)string]; }

BOOL NumberFormatterHasThousandSeparators( NSNumberFormatter *ref )
{ return [ref hasThousandSeparators]; }

void NumberFormatterSetHasThousandSeparators( NSNumberFormatter *ref, BOOL flag )
{ [ref setHasThousandSeparators:flag]; }

CFStringRef NumberFormatterDecimalSeparator( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref decimalSeparator]; }

void NumberFormatterSetDecimalSeparator( NSNumberFormatter *ref, CFStringRef string )
{ [ref setDecimalSeparator:(__bridge NSString *)string]; }

BOOL NumberFormatterAlwaysShowsDecimalSeparator( NSNumberFormatter *ref )
{ return [ref alwaysShowsDecimalSeparator]; }

void NumberFormatterSetAlwaysShowsDecimalSeparator( NSNumberFormatter *ref, BOOL flag )
{ [ref setAlwaysShowsDecimalSeparator:flag]; }

CFStringRef NumberFormatterCurrencyDecimalSeparator( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref currencyDecimalSeparator]; }

void NumberFormatterSetCurrencyDecimalSeparator( NSNumberFormatter *ref, CFStringRef string )
{ [ref setCurrencyDecimalSeparator:(__bridge NSString *)string]; }

NSUInteger NumberFormatterGroupingSize( NSNumberFormatter *ref )
{ return [ref groupingSize]; }

void NumberFormatterSetGroupingSize( NSNumberFormatter *ref, NSUInteger value )
{ [ref setGroupingSize:value]; }

NSUInteger NumberFormatterSecondaryGroupingSize( NSNumberFormatter *ref )
{ return [ref secondaryGroupingSize]; }

void NumberFormatterSetSecondaryGroupingSize( NSNumberFormatter *ref, NSUInteger value )
{ [ref setSecondaryGroupingSize:value]; }

// - padding -
CFStringRef NumberFormatterPaddingCharacter( NSNumberFormatter *ref )
{ return (__bridge CFStringRef)[ref paddingCharacter]; }

void NumberFormatterSetPaddingCharacter( NSNumberFormatter *ref, CFStringRef string )
{ [ref setPaddingCharacter:(__bridge NSString *)string]; }

NSNumberFormatterPadPosition NumberFormatterPaddingPosition( NSNumberFormatter *ref )
{ return [ref paddingPosition]; }

void NumberFormatterSetPaddingPosition( NSNumberFormatter *ref, NSNumberFormatterPadPosition position )
{ [ref setPaddingPosition:position]; }

// - input and output attributes -
BOOL NumberFormatterAllowsFloats( NSNumberFormatter *ref )
{ return [ref allowsFloats]; }

void NumberFormatterSetAllowsFloats( NSNumberFormatter *ref, BOOL flag )
{ [ref setAllowsFloats:flag]; }

CFNumberRef NumberFormatterMinimum( NSNumberFormatter *ref )
{ return (__bridge CFNumberRef)[ref minimum]; }

void NumberFormatterSetMinimum( NSNumberFormatter *ref, CFNumberRef number )
{ [ref setMinimum:(__bridge NSNumber *)number]; }

CFNumberRef NumberFormatterMaximum( NSNumberFormatter *ref )
{ return (__bridge CFNumberRef)[ref maximum]; }

void NumberFormatterSetMaximum( NSNumberFormatter *ref, CFNumberRef number )
{ [ref setMaximum:(__bridge NSNumber *)number]; }

// - integer and fraction digits -
NSUInteger NumberFormatterMinimumIntegerDigits( NSNumberFormatter *ref )
{ return [ref minimumIntegerDigits]; }

void NumberFormatterSetMinimumIntegerDigits( NSNumberFormatter *ref, NSUInteger value )
{ [ref setMinimumIntegerDigits:value]; }

NSUInteger NumberFormatterMaximumIntegerDigits( NSNumberFormatter *ref )
{ return [ref maximumIntegerDigits]; }

void NumberFormatterSetMaximumIntegerDigits( NSNumberFormatter *ref, NSUInteger value )
{ [ref setMaximumIntegerDigits:value]; }

NSUInteger NumberFormatterMinimumFractionDigits( NSNumberFormatter *ref )
{ return [ref minimumFractionDigits]; }

void NumberFormatterSetMinimumFractionDigits( NSNumberFormatter *ref, NSUInteger value )
{ [ref setMinimumFractionDigits:value]; }

NSUInteger NumberFormatterMaximumFractionDigits( NSNumberFormatter *ref )
{ return [ref maximumFractionDigits]; }

void NumberFormatterSetMaximumFractionDigits( NSNumberFormatter *ref, NSUInteger value )
{ [ref setMaximumFractionDigits:value]; }

// - significant digits -
BOOL NumberFormatterUsesSignificantDigits( NSNumberFormatter *ref )
{ return [ref usesSignificantDigits]; }

void NumberFormatterSetUsesSignificantDigits( NSNumberFormatter *ref, BOOL flag )
{ [ref setUsesSignificantDigits:flag]; }

NSUInteger NumberFormatterMinimumSignificantDigits( NSNumberFormatter *ref )
{ return [ref minimumSignificantDigits]; }

void NumberFormatterSetMinimumSignificantDigits( NSNumberFormatter *ref, NSUInteger value )
{ [ref setMinimumSignificantDigits:value]; }

NSUInteger NumberFormatterMaximumSignificantDigits( NSNumberFormatter *ref )
{ return [ref maximumSignificantDigits]; }

void NumberFormatterSetMaximumSignificantDigits( NSNumberFormatter *ref, NSUInteger value )
{ [ref setMaximumSignificantDigits:value]; }

// - leniency behavior -
BOOL NumberFormatterIsLenient( NSNumberFormatter *ref )
{ return [ref isLenient]; }

void NumberFormatterSetLenient( NSNumberFormatter *ref, BOOL flag )
{ [ref setLenient:flag]; }

// - validation of partial numeric -
BOOL NumberFormatterIsPartialStringValidationEnabled( NSNumberFormatter *ref )
{ return [ref isPartialStringValidationEnabled]; }

void NumberFormatterSetPartialStringValidationEnabled( NSNumberFormatter *ref, BOOL flag )
{ [ref setPartialStringValidationEnabled:flag]; }

