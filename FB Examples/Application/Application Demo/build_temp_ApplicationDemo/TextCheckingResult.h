/*
 TextCheckingResult.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class TextCheckingResultClass( void );

// Range and type
CFRange TextCheckingResultRange( NSTextCheckingResult *ref );
NSTextCheckingType TextCheckingResultType( NSTextCheckingResult *ref );
NSUInteger TextCheckingResultNumberOfRanges( NSTextCheckingResult *ref );
CFRange TextCheckingResultRangeAtIndex( NSTextCheckingResult *ref, NSUInteger index );

// Text replacement
//NSTextCheckingResult *TextCheckingResultReplacementCheckingResultWithRange( CFRange range, CFStringRef replacementString );
NSTextCheckingResult *TextCheckingResultReplacementCheckingResult( CFRange range, CFStringRef replacementString );
CFStringRef TextCheckingResultReplacementString( NSTextCheckingResult *ref );

// Regular expressions
//NSTextCheckingResult *TextCheckingResultRegularExpressionCheckingResultWithRanges( CFRange *ranges, NSUInteger count, NSRegularExpression *regex );
NSTextCheckingResult *TextCheckingResultRegularExpressionCheckingResult( CFRange *ranges, NSUInteger count, NSRegularExpression *regex );
NSRegularExpression *TextCheckingResultRegularExpression( NSTextCheckingResult *ref );

// Components
CFDictionaryRef TextCheckingResultComponents( NSTextCheckingResult *ref );

// URLs
//NSTextCheckingResult *TextCheckingResultLinkCheckingResultWithRange( CFRange range, CFURLRef url );
NSTextCheckingResult *TextCheckingResultLinkCheckingResult( CFRange range, CFURLRef url );
CFURLRef TextCheckingResultURL( NSTextCheckingResult *ref );

// Addresses
//NSTextCheckingResult *TextCheckingResultAddressCheckingResultWithRange( CFRange range, CFDictionaryRef components );
NSTextCheckingResult *TextCheckingResultAddressCheckingResult( CFRange range, CFDictionaryRef components );
CFDictionaryRef TextCheckingResultAddressComponents( NSTextCheckingResult *ref );

// Transit info
//NSTextCheckingResult *TextCheckingResultTransitInformationCheckingResultWithRange( CFRange range, CFDictionaryRef components );
NSTextCheckingResult *TextCheckingResultTransitInformationCheckingResult( CFRange range, CFDictionaryRef components );

// Phone numbers
//NSTextCheckingResult *TextCheckingResultPhoneNumberCheckingResultWithRange( CFRange range, CFStringRef phoneNumber );
NSTextCheckingResult *TextCheckingResultPhoneNumberCheckingResult( CFRange range, CFStringRef phoneNumber );
CFStringRef TextCheckingResultPhoneNumber( NSTextCheckingResult *ref );

// Dates and times
//NSTextCheckingResult *TextCheckingResultDateCheckingResultWithRange( CFRange range, CFDateRef dt );
NSTextCheckingResult *TextCheckingResultDateCheckingResult( CFRange range, CFDateRef dt );
//NSTextCheckingResult *TextCheckingResultDateCheckingResultWithRangeAndTimeZone( CFRange range, CFDateRef dt, CFTimeZoneRef zone, CFTimeInterval duration );
NSTextCheckingResult *TextCheckingResultDateCheckingResultWithTimeZone( CFRange range, CFDateRef dt, CFTimeZoneRef zone, CFTimeInterval duration );
CFDateRef TextCheckingResultDate( NSTextCheckingResult *ref );
CFTimeInterval TextCheckingResultDuration( NSTextCheckingResult *ref );
CFTimeZoneRef TextCheckingResultTimeZone( NSTextCheckingResult *ref );

// Typography
//NSTextCheckingResult *TextCheckingResultDashCheckingResultWithRange( CFRange range, CFStringRef replacementString );
NSTextCheckingResult *TextCheckingResultDashCheckingResult( CFRange range, CFStringRef replacementString );
//NSTextCheckingResult *TextCheckingResultQuoteCheckingResultWithRange( CFRange range, CFStringRef replacementString );
NSTextCheckingResult *TextCheckingResultQuoteCheckingResult( CFRange range, CFStringRef replacementString );

// Spelling
//NSTextCheckingResult *TextCheckingResultSpellCheckingResultWithRange( CFRange range );
NSTextCheckingResult *TextCheckingResultSpellCheckingResult( CFRange range );
//NSTextCheckingResult *TextCheckingResultCorrectionCheckingResultWithRange( CFRange range, CFStringRef replacementString );
NSTextCheckingResult *TextCheckingResultCorrectionCheckingResult( CFRange range, CFStringRef replacementString );

// Orthography
//NSTextCheckingResult *TextCheckingResultOrthographyCheckingResultWithRange( CFRange range, NSOrthography *orthography );
NSTextCheckingResult *TextCheckingResultOrthographyCheckingResult( CFRange range, NSOrthography *orthography );
NSOrthography *TextCheckingResultOrthography( NSTextCheckingResult *ref );

// Grammar
//NSTextCheckingResult *TextCheckingResultGrammarCheckingResultWithRange( CFRange range, CFArrayRef details );
NSTextCheckingResult *TextCheckingResultGrammarCheckingResult( CFRange range, CFArrayRef details );
CFArrayRef TextCheckingResultGrammarDetails( NSTextCheckingResult *ref );

// Adjust ranges
NSTextCheckingResult *TextCheckingResultByAdjustingRangesWithOffset( NSTextCheckingResult *ref, NSInteger offset );

// Instance properties
CFArrayRef TextCheckingResultAlternativeStrings( NSTextCheckingResult *ref );

// Instance methods
CFRange TextCheckingResultRangeWithName( NSTextCheckingResult *ref, CFStringRef name );

// Type methods
//NSTextCheckingResult *TextCheckingResultCorrectionCheckingResultWithRange( CFRange range, CFStringRef replacementString, CFArrayRef alternativeStrings );
NSTextCheckingResult *TextCheckingResultCorrectionCheckingResultWithAlternativeStrings( CFRange range, CFStringRef replacementString, CFArrayRef alternativeStrings );

