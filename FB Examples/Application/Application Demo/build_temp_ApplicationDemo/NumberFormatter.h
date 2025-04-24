/*
 NumberFormatter.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class NumberFormatterClass( void );

// - init -
NSNumberFormatter *NumberFormatterInit( void );
NSNumberFormatter *NumberFormatterWithStyle( NSNumberFormatterStyle style );

// - configure -
NSNumberFormatterBehavior NumberFormatterBehavior( NSNumberFormatter *ref );
void NumberFormatterSetBehavior( NSNumberFormatter *ref, NSNumberFormatterBehavior behavior );
NSNumberFormatterBehavior NumberFormatterDefaultBehavior( void );
void NumberFormatterSetDefaultBehavior( NSNumberFormatterBehavior behavior );
NSNumberFormatterStyle NumberFormatterNumberStyle( NSNumberFormatter *ref );
void NumberFormatterSetNumberStyle( NSNumberFormatter *ref, NSNumberFormatterStyle style );
BOOL NumberFormatterGeneratesDecimalNumbers( NSNumberFormatter *ref );
void NumberFormatterSetGeneratesDecimalNumbers( NSNumberFormatter *ref, BOOL flag );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
API_AVAILABLE(macos(15.0))
NSInteger NumberFormatterMinimumGroupingDigits( NSNumberFormatter *ref );
API_AVAILABLE(macos(15.0))
void NumberFormatterSetMinimumGroupingDigits( NSNumberFormatter *ref, NSInteger digits );
#endif // 150000

// - convert between numbers and strings -
BOOL NumberFormatterGetObjectValue( NSNumberFormatter *ref, CFTypeRef *obj, CFStringRef string, CFRange *range, NSError **err  );
CFNumberRef NumberFormatterNumberFromString( NSNumberFormatter *ref, CFStringRef string );
CFStringRef NumberFormatterStringFromNumber( NSNumberFormatter *ref, CFNumberRef number );
CFStringRef NumberFormatterLocalizedStringFromNumber( CFNumberRef number, NSNumberFormatterStyle style );

// - localization -
BOOL NumberFormatterLocalizesFormat( NSNumberFormatter *ref );
void NumberFormatterSetLocalizesFormat( NSNumberFormatter *ref, BOOL flag );
CFLocaleRef NumberFormatterLocale( NSNumberFormatter *ref );
void NumberFormatterSetLocale( NSNumberFormatter *ref, CFLocaleRef locale );

// - rounding -
NSDecimalNumberHandler *NumberFormatterRoundingBehavior( NSNumberFormatter *ref );
void NumberFormatterSetRoundingBehavior( NSNumberFormatter *ref, NSDecimalNumberHandler *behavior );
CFNumberRef NumberFormatterRoundingIncrement( NSNumberFormatter *ref );
void NumberFormatterSetRoundingIncrement( NSNumberFormatter *ref, CFNumberRef number );
NSNumberFormatterRoundingMode NumberFormatterRoundingMode( NSNumberFormatter *ref );
void NumberFormatterSetRoundingMode( NSNumberFormatter *ref, NSNumberFormatterRoundingMode mode );

// - formats -
CFStringRef NumberFormatterFormat( NSNumberFormatter *ref );
void NumberFormatterSetFormat( NSNumberFormatter *ref, CFStringRef string );

NSFormattingContext NumberFormatterFormattingContext( NSNumberFormatter *ref );
void NumberFormatterSetFormattingContext( NSNumberFormatter *ref, NSFormattingContext context );

NSUInteger NumberFormatterFormatWidth( NSNumberFormatter *ref );
void NumberFormatterSetFormatWidth( NSNumberFormatter *ref, NSUInteger value );
CFStringRef NumberFormatterNegativeFormat( NSNumberFormatter *ref );
void NumberFormatterSetNegativeWidth( NSNumberFormatter *ref, CFStringRef string );
CFStringRef NumberFormatterPositiveFormat( NSNumberFormatter *ref );
void NumberFormatterSetPositiveFormat( NSNumberFormatter *ref, CFStringRef string );
CFNumberRef NumberFormatterMultiplier( NSNumberFormatter *ref );
void NumberFormatterSetMultiplier( NSNumberFormatter *ref, CFNumberRef number );

// - symbols -
CFStringRef NumberFormatterPercentSymbol( NSNumberFormatter *ref );
void NumberFormatterSetPercentSymbol( NSNumberFormatter *ref, CFStringRef string );
CFStringRef NumberFormatterPerMillSymbol( NSNumberFormatter *ref );
void NumberFormatterSetPerMillSymbol( NSNumberFormatter *ref, CFStringRef string );
CFStringRef NumberFormatterMinusSign( NSNumberFormatter *ref );
void NumberFormatterSetMinusSign( NSNumberFormatter *ref, CFStringRef string );
CFStringRef NumberFormatterPlusSign( NSNumberFormatter *ref );
void NumberFormatterSetPlusSign( NSNumberFormatter *ref, CFStringRef string );
CFStringRef NumberFormatterExponentSymbol( NSNumberFormatter *ref );
void NumberFormatterSetExponentSymbol( NSNumberFormatter *ref, CFStringRef string );
CFStringRef NumberFormatterZeroSymbol( NSNumberFormatter *ref );
void NumberFormatterSetZeroSymbol( NSNumberFormatter *ref, CFStringRef string );
CFStringRef NumberFormatterNilSymbol( NSNumberFormatter *ref );
void NumberFormatterSetNilSymbol( NSNumberFormatter *ref, CFStringRef string );
CFStringRef NumberFormatterNotANumberSymbol( NSNumberFormatter *ref );
void NumberFormatterSetNotANumberSymbol( NSNumberFormatter *ref, CFStringRef string );
CFStringRef NumberFormatterNegativeInfinitySymbol( NSNumberFormatter *ref );
void NumberFormatterSetNegativeInfinitySymbol( NSNumberFormatter *ref, CFStringRef string );
CFStringRef NumberFormatterPositiveInfinitySymbol( NSNumberFormatter *ref );
void NumberFormatterSetPositiveInfinitySymbol( NSNumberFormatter *ref, CFStringRef string );

// - currency -
CFStringRef NumberFormatterCurrencySymbol( NSNumberFormatter *ref );
void NumberFormatterSetCurrencySymbol( NSNumberFormatter *ref, CFStringRef string );
CFStringRef NumberFormatterCurrencyCode( NSNumberFormatter *ref );
void NumberFormatterSetCurrencyCode( NSNumberFormatter *ref, CFStringRef string );
CFStringRef NumberFormatterInternationalCurrencySymbol( NSNumberFormatter *ref );
void NumberFormatterSetInternationalCurrencySymbol( NSNumberFormatter *ref, CFStringRef string );
CFStringRef NumberFormatterCurrencyGroupingSeparator( NSNumberFormatter *ref );
void NumberFormatterSetCurrencyGroupingSeparator( NSNumberFormatter *ref, CFStringRef string );

// - prefix and suffix -
CFStringRef NumberFormatterPositivePrefix( NSNumberFormatter *ref );
void NumberFormatterSetPositivePrefix( NSNumberFormatter *ref, CFStringRef string );
CFStringRef NumberFormatterPositiveSuffix( NSNumberFormatter *ref );
void NumberFormatterSetPositiveSuffix( NSNumberFormatter *ref, CFStringRef string );
CFStringRef NumberFormatterNegativePrefix( NSNumberFormatter *ref );
void NumberFormatterSetNegativePrefix( NSNumberFormatter *ref, CFStringRef string );
CFStringRef NumberFormatterNegativeSuffix( NSNumberFormatter *ref );
void NumberFormatterSetNegativeSuffix( NSNumberFormatter *ref, CFStringRef string );

// - display -
CFDictionaryRef NumberFormatterTextAttributesForNegativeValues( NSNumberFormatter *ref );
void NumberFormatterSetTextAttributesForNegativeValues( NSNumberFormatter *ref, CFDictionaryRef attributes );
CFDictionaryRef NumberFormatterTextAttributesForPositiveValues( NSNumberFormatter *ref );
void NumberFormatterSetTextAttributesForPositiveValues( NSNumberFormatter *ref, CFDictionaryRef attributes );
CFAttributedStringRef NumberFormatterAttributedStringForZero( NSNumberFormatter *ref );
void NumberFormatterSetAttributedStringForZero( NSNumberFormatter *ref, CFAttributedStringRef aString );
CFDictionaryRef NumberFormatterTextAttributesForZero( NSNumberFormatter *ref );
void NumberFormatterSetTextAttributesForZero( NSNumberFormatter *ref, CFDictionaryRef attributes );
CFAttributedStringRef NumberFormatterAttributedStringForNil( NSNumberFormatter *ref );
void NumberFormatterSetAttributedStringForNil( NSNumberFormatter *ref, CFAttributedStringRef aString );
CFDictionaryRef NumberFormatterTextAttributesForNil( NSNumberFormatter *ref );
void NumberFormatterSetTextAttributesForNil( NSNumberFormatter *ref, CFDictionaryRef attributes );
CFAttributedStringRef NumberFormatterAttributedStringForNotANumber( NSNumberFormatter *ref );
void NumberFormatterSetAttributedStringForNotANumber( NSNumberFormatter *ref, CFAttributedStringRef aString );
CFDictionaryRef NumberFormatterTextAttributesForNotANumber( NSNumberFormatter *ref );
void NumberFormatterSetTextAttributesForNotANumber( NSNumberFormatter *ref, CFDictionaryRef attributes );
CFDictionaryRef NumberFormatterTextAttributesForPositiveInfinity( NSNumberFormatter *ref );
void NumberFormatterSetTextAttributesForPositiveInfinity( NSNumberFormatter *ref, CFDictionaryRef attributes );
CFDictionaryRef NumberFormatterTextAttributesForNegativeInfinity( NSNumberFormatter *ref );
void NumberFormatterSetTextAttributesForNegativeInfinity( NSNumberFormatter *ref, CFDictionaryRef attributes );

// - separators and grouping -
CFStringRef NumberFormatterGroupingSeparator( NSNumberFormatter *ref );
void NumberFormatterSetGroupingSeparator( NSNumberFormatter *ref, CFStringRef string );
BOOL NumberFormatterUsesGroupingSeparator( NSNumberFormatter *ref );
void NumberFormatterSetUsesGroupingSeparator( NSNumberFormatter *ref, BOOL flag );
CFStringRef NumberFormatterThousandSeparator( NSNumberFormatter *ref );
void NumberFormatterSetThousandSeparator( NSNumberFormatter *ref, CFStringRef string );
BOOL NumberFormatterHasThousandSeparators( NSNumberFormatter *ref );
void NumberFormatterSetHasThousandSeparators( NSNumberFormatter *ref, BOOL flag );
CFStringRef NumberFormatterDecimalSeparator( NSNumberFormatter *ref );
void NumberFormatterSetDecimalSeparator( NSNumberFormatter *ref, CFStringRef string );
BOOL NumberFormatterAlwaysShowsDecimalSeparator( NSNumberFormatter *ref );
void NumberFormatterSetAlwaysShowsDecimalSeparator( NSNumberFormatter *ref, BOOL flag );
CFStringRef NumberFormatterCurrencyDecimalSeparator( NSNumberFormatter *ref );
void NumberFormatterSetCurrencyDecimalSeparator( NSNumberFormatter *ref, CFStringRef string );
NSUInteger NumberFormatterGroupingSize( NSNumberFormatter *ref );
void NumberFormatterSetGroupingSize( NSNumberFormatter *ref, NSUInteger value );
NSUInteger NumberFormatterSecondaryGroupingSize( NSNumberFormatter *ref );
void NumberFormatterSetSecondaryGroupingSize( NSNumberFormatter *ref, NSUInteger value );

// - padding -
CFStringRef NumberFormatterPaddingCharacter( NSNumberFormatter *ref );
void NumberFormatterSetPaddingCharacter( NSNumberFormatter *ref, CFStringRef string );
NSNumberFormatterPadPosition NumberFormatterPaddingPosition( NSNumberFormatter *ref );
void NumberFormatterSetPaddingPosition( NSNumberFormatter *ref, NSNumberFormatterPadPosition position );

// - input and output attributes -
BOOL NumberFormatterAllowsFloats( NSNumberFormatter *ref );
void NumberFormatterSetAllowsFloats( NSNumberFormatter *ref, BOOL flag );
CFNumberRef NumberFormatterMinimum( NSNumberFormatter *ref );
void NumberFormatterSetMinimum( NSNumberFormatter *ref, CFNumberRef number );
CFNumberRef NumberFormatterMaximum( NSNumberFormatter *ref );
void NumberFormatterSetMaximum( NSNumberFormatter *ref, CFNumberRef number );

// - integer and fraction digits -
NSUInteger NumberFormatterMinimumIntegerDigits( NSNumberFormatter *ref );
void NumberFormatterSetMinimumIntegerDigits( NSNumberFormatter *ref, NSUInteger value );
NSUInteger NumberFormatterMaximumIntegerDigits( NSNumberFormatter *ref );
void NumberFormatterSetMaximumIntegerDigits( NSNumberFormatter *ref, NSUInteger value );
NSUInteger NumberFormatterMinimumFractionDigits( NSNumberFormatter *ref );
void NumberFormatterSetMinimumFractionDigits( NSNumberFormatter *ref, NSUInteger value );
NSUInteger NumberFormatterMaximumFractionDigits( NSNumberFormatter *ref );
void NumberFormatterSetMaximumFractionDigits( NSNumberFormatter *ref, NSUInteger value );

// - significant digits -
BOOL NumberFormatterUsesSignificantDigits( NSNumberFormatter *ref );
void NumberFormatterSetUsesSignificantDigits( NSNumberFormatter *ref, BOOL flag );
NSUInteger NumberFormatterMinimumSignificantDigits( NSNumberFormatter *ref );
void NumberFormatterSetMinimumSignificantDigits( NSNumberFormatter *ref, NSUInteger value );
NSUInteger NumberFormatterMaximumSignificantDigits( NSNumberFormatter *ref );
void NumberFormatterSetMaximumSignificantDigits( NSNumberFormatter *ref, NSUInteger value );

// - leniency behavior -
BOOL NumberFormatterIsLenient( NSNumberFormatter *ref );
void NumberFormatterSetLenient( NSNumberFormatter *ref, BOOL flag );

// - validation of partial numeric -
BOOL NumberFormatterIsPartialStringValidationEnabled( NSNumberFormatter *ref );
void NumberFormatterSetPartialStringValidationEnabled( NSNumberFormatter *ref, BOOL flag );

