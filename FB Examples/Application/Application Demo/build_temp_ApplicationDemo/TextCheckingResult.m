/*
 TextCheckingResult.m

 Bernie Wylde
 */

#import "TextCheckingResult.h"

// Class
Class TextCheckingResultClass( void )
{ return [NSTextCheckingResult class]; }

// Range and type
CFRange TextCheckingResultRange( NSTextCheckingResult *ref )
{ return NSRangeToCFRange([ref range]); }

NSTextCheckingType TextCheckingResultType( NSTextCheckingResult *ref )
{ return [ref resultType]; }

NSUInteger TextCheckingResultNumberOfRanges( NSTextCheckingResult *ref )
{ return [ref numberOfRanges]; }

CFRange TextCheckingResultRangeAtIndex( NSTextCheckingResult *ref, NSUInteger index )
{ return NSRangeToCFRange([ref rangeAtIndex:index]); }

// Text replacement
//NSTextCheckingResult *TextCheckingResultReplacementCheckingResultWithRange( CFRange range, CFStringRef replacementString )
//{ return [NSTextCheckingResult replacementCheckingResultWithRange:NSRangeFromCFRange(range) replacementString:(__bridge NSString *)replacementString]; }

NSTextCheckingResult *TextCheckingResultReplacementCheckingResult( CFRange range, CFStringRef replacementString )
{ return [NSTextCheckingResult replacementCheckingResultWithRange:NSRangeFromCFRange(range) replacementString:(__bridge NSString *)replacementString]; }

CFStringRef TextCheckingResultReplacementString( NSTextCheckingResult *ref )
{ return (__bridge CFStringRef)[ref replacementString]; }

// Regular expressions
//NSTextCheckingResult *TextCheckingResultRegularExpressionCheckingResultWithRanges( CFRange *ranges, NSUInteger count, NSRegularExpression *regex )
//{ return [NSTextCheckingResult regularExpressionCheckingResultWithRanges:(NSRange *)ranges count:count regularExpression:regex]; }

NSTextCheckingResult *TextCheckingResultRegularExpressionCheckingResult( CFRange *ranges, NSUInteger count, NSRegularExpression *regex )
{ return [NSTextCheckingResult regularExpressionCheckingResultWithRanges:(NSRange *)ranges count:count regularExpression:regex]; }

NSRegularExpression *TextCheckingResultRegularExpression( NSTextCheckingResult *ref )
{ return [ref regularExpression]; }

// Components
CFDictionaryRef TextCheckingResultComponents( NSTextCheckingResult *ref )
{ return (__bridge CFDictionaryRef)[ref components]; }

// URLs
//NSTextCheckingResult *TextCheckingResultLinkCheckingResultWithRange( CFRange range, CFURLRef url )
//{ return [NSTextCheckingResult linkCheckingResultWithRange:NSRangeFromCFRange(range) URL:(__bridge NSURL *)url]; }

NSTextCheckingResult *TextCheckingResultLinkCheckingResult( CFRange range, CFURLRef url )
{ return [NSTextCheckingResult linkCheckingResultWithRange:NSRangeFromCFRange(range) URL:(__bridge NSURL *)url]; }

CFURLRef TextCheckingResultURL( NSTextCheckingResult *ref )
{ return (__bridge CFURLRef)[ref URL]; }

// Addresses
//NSTextCheckingResult *TextCheckingResultAddressCheckingResultWithRange( CFRange range, CFDictionaryRef components )
//{ return [NSTextCheckingResult addressCheckingResultWithRange:NSRangeFromCFRange(range) components:(__bridge NSDictionary *)components]; }

NSTextCheckingResult *TextCheckingResultAddressCheckingResult( CFRange range, CFDictionaryRef components )
{ return [NSTextCheckingResult addressCheckingResultWithRange:NSRangeFromCFRange(range) components:(__bridge NSDictionary *)components]; }

CFDictionaryRef TextCheckingResultAddressComponents( NSTextCheckingResult *ref )
{ return (__bridge CFDictionaryRef)[ref addressComponents]; }

// Transit info
//NSTextCheckingResult *TextCheckingResultTransitInformationCheckingResultWithRange( CFRange range, CFDictionaryRef components )
//{ return [NSTextCheckingResult transitInformationCheckingResultWithRange:NSRangeFromCFRange(range) components:(__bridge NSDictionary *)components]; }

NSTextCheckingResult *TextCheckingResultTransitInformationCheckingResult( CFRange range, CFDictionaryRef components )
{ return [NSTextCheckingResult transitInformationCheckingResultWithRange:NSRangeFromCFRange(range) components:(__bridge NSDictionary *)components]; }

// Phone numbers
//NSTextCheckingResult *TextCheckingResultPhoneNumberCheckingResultWithRange( CFRange range, CFStringRef phoneNumber )
//{ return [NSTextCheckingResult phoneNumberCheckingResultWithRange:NSRangeFromCFRange(range) phoneNumber:(__bridge NSString *)phoneNumber]; }

NSTextCheckingResult *TextCheckingResultPhoneNumberCheckingResult( CFRange range, CFStringRef phoneNumber )
{ return [NSTextCheckingResult phoneNumberCheckingResultWithRange:NSRangeFromCFRange(range) phoneNumber:(__bridge NSString *)phoneNumber]; }

CFStringRef TextCheckingResultPhoneNumber( NSTextCheckingResult *ref )
{ return (__bridge CFStringRef)[ref phoneNumber]; }

// Dates and times
//NSTextCheckingResult *TextCheckingResultDateCheckingResultWithRange( CFRange range, CFDateRef dt )
//{ return [NSTextCheckingResult dateCheckingResultWithRange:NSRangeFromCFRange(range) date:(__bridge NSDate *)dt]; }

NSTextCheckingResult *TextCheckingResultDateCheckingResult( CFRange range, CFDateRef dt )
{ return [NSTextCheckingResult dateCheckingResultWithRange:NSRangeFromCFRange(range) date:(__bridge NSDate *)dt]; }

//NSTextCheckingResult *TextCheckingResultDateCheckingResultWithRangeAndTimeZone( CFRange range, CFDateRef dt, CFTimeZoneRef zone, CFTimeInterval duration )
//{ return [NSTextCheckingResult dateCheckingResultWithRange:NSRangeFromCFRange(range) date:(__bridge NSDate *)dt timeZone:(__bridge NSTimeZone *)zone duration:duration]; }

NSTextCheckingResult *TextCheckingResultDateCheckingResultWithTimeZone( CFRange range, CFDateRef dt, CFTimeZoneRef zone, CFTimeInterval duration )
{ return [NSTextCheckingResult dateCheckingResultWithRange:NSRangeFromCFRange(range) date:(__bridge NSDate *)dt timeZone:(__bridge NSTimeZone *)zone duration:duration]; }

CFDateRef TextCheckingResultDate( NSTextCheckingResult *ref )
{ return (__bridge CFDateRef)[ref date]; }

CFTimeInterval TextCheckingResultDuration( NSTextCheckingResult *ref )
{ return [ref duration]; }

CFTimeZoneRef TextCheckingResultTimeZone( NSTextCheckingResult *ref )
{ return (__bridge CFTimeZoneRef)[ref timeZone]; }

// Typography
//NSTextCheckingResult *TextCheckingResultDashCheckingResultWithRange( CFRange range, CFStringRef replacementString )
//{ return [NSTextCheckingResult dashCheckingResultWithRange:NSRangeFromCFRange(range) replacementString:(__bridge NSString *)replacementString]; }

NSTextCheckingResult *TextCheckingResultDashCheckingResult( CFRange range, CFStringRef replacementString )
{ return [NSTextCheckingResult dashCheckingResultWithRange:NSRangeFromCFRange(range) replacementString:(__bridge NSString *)replacementString]; }

//NSTextCheckingResult *TextCheckingResultQuoteCheckingResultWithRange( CFRange range, CFStringRef replacementString )
//{ return [NSTextCheckingResult quoteCheckingResultWithRange:NSRangeFromCFRange(range) replacementString:(__bridge NSString *)replacementString]; }

NSTextCheckingResult *TextCheckingResultQuoteCheckingResult( CFRange range, CFStringRef replacementString )
{ return [NSTextCheckingResult quoteCheckingResultWithRange:NSRangeFromCFRange(range) replacementString:(__bridge NSString *)replacementString]; }

// Spelling
//NSTextCheckingResult *TextCheckingResultSpellCheckingResultWithRange( CFRange range )
//{ return [NSTextCheckingResult spellCheckingResultWithRange:NSRangeFromCFRange(range)]; }

NSTextCheckingResult *TextCheckingResultSpellCheckingResult( CFRange range )
{ return [NSTextCheckingResult spellCheckingResultWithRange:NSRangeFromCFRange(range)]; }

//NSTextCheckingResult *TextCheckingResultCorrectionCheckingResultWithRange( CFRange range, CFStringRef replacementString )
//{ return [NSTextCheckingResult correctionCheckingResultWithRange:NSRangeFromCFRange(range) replacementString:(__bridge NSString *)replacementString]; }

NSTextCheckingResult *TextCheckingResultCorrectionCheckingResult( CFRange range, CFStringRef replacementString )
{ return [NSTextCheckingResult correctionCheckingResultWithRange:NSRangeFromCFRange(range) replacementString:(__bridge NSString *)replacementString]; }

// Orthography
//NSTextCheckingResult *TextCheckingResultOrthographyCheckingResultWithRange( CFRange range, NSOrthography *orthography )
//{ return [NSTextCheckingResult orthographyCheckingResultWithRange:NSRangeFromCFRange(range) orthography:orthography]; }

NSTextCheckingResult *TextCheckingResultOrthographyCheckingResult( CFRange range, NSOrthography *orthography )
{ return [NSTextCheckingResult orthographyCheckingResultWithRange:NSRangeFromCFRange(range) orthography:orthography]; }

NSOrthography *TextCheckingResultOrthography( NSTextCheckingResult *ref )
{ return [ref orthography]; }

// Grammar
//NSTextCheckingResult *TextCheckingResultGrammarCheckingResultWithRange( CFRange range, CFArrayRef details )
//{ return [NSTextCheckingResult grammarCheckingResultWithRange:NSRangeFromCFRange(range) details:(__bridge NSArray *)details]; }

NSTextCheckingResult *TextCheckingResultGrammarCheckingResult( CFRange range, CFArrayRef details )
{ return [NSTextCheckingResult grammarCheckingResultWithRange:NSRangeFromCFRange(range) details:(__bridge NSArray *)details]; }

CFArrayRef TextCheckingResultGrammarDetails( NSTextCheckingResult *ref )
{ return (__bridge CFArrayRef)[ref grammarDetails]; }

// Adjust ranges
NSTextCheckingResult *TextCheckingResultByAdjustingRangesWithOffset( NSTextCheckingResult *ref, NSInteger offset )
{ return [ref resultByAdjustingRangesWithOffset:offset]; }

// Instance properties
CFArrayRef TextCheckingResultAlternativeStrings( NSTextCheckingResult *ref )
{ return (__bridge CFArrayRef)[ref alternativeStrings]; }

// Instance methods
CFRange TextCheckingResultRangeWithName( NSTextCheckingResult *ref, CFStringRef name )
{ return NSRangeToCFRange([ref rangeWithName:(__bridge NSString *)name]); }

// Type methods
//NSTextCheckingResult *TextCheckingResultCorrectionCheckingResultWithRange( CFRange range, CFStringRef replacementString, CFArrayRef alternativeStrings )
//{ return [NSTextCheckingResult correctionCheckingResultWithRange:NSRangeFromCFRange(range) replacementString:(__bridge NSString *)replacementString alternativeStrings:(__bridge NSArray *)alternativeStrings]; }

NSTextCheckingResult *TextCheckingResultCorrectionCheckingResultWithAlternativeStrings( CFRange range, CFStringRef replacementString, CFArrayRef alternativeStrings )
{ return [NSTextCheckingResult correctionCheckingResultWithRange:NSRangeFromCFRange(range) replacementString:(__bridge NSString *)replacementString alternativeStrings:(__bridge NSArray *)alternativeStrings]; }

