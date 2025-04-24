/*
 String.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef void (*CUI_StringEnumerateLinesCallbackType)(CFStringRef,CFStringRef,BOOL*,void*);
typedef void (*CUI_StringEnumerateSubstringsCallbackType)(CFStringRef,CFStringRef,CFRange,CFRange,BOOL*,void*);
typedef void (*CUI_StringLinguisticTaggerCallbackType)(CFStringRef,CFStringRef,CFRange,CFRange,BOOL*,void*);

// Class
Class StringClass( void );

// Init
CFStringRef StringWithBytes( void *bytes, NSUInteger length, NSStringEncoding encoding );
CFStringRef StringWithCharacters( const unichar *characters, NSUInteger length );
CFStringRef StringWithData( CFDataRef dta, NSStringEncoding encoding );
CFStringRef StringWithFormat( CFStringRef format, ... );
CFStringRef StringWithString( CFStringRef string );
CFStringRef StringWithCString( const char *cString, NSStringEncoding encoding );
CFStringRef StringWithUTF8String( const char *cString );

// Init from URL
CFStringRef StringWithContentsOfURL( CFURLRef url, NSStringEncoding enc, NSError **err );
CFStringRef StringWithContentsOfURLUsedEncoding( CFURLRef url, NSStringEncoding *enc, NSError **err );

// Length
NSUInteger StringLength( CFStringRef string );
NSUInteger StringLengthOfBytes( CFStringRef string, NSStringEncoding enc );
NSUInteger StringMaximumLengthOfBytes( CFStringRef string, NSStringEncoding enc );

// Characters and bytes
unichar StringCharacterAtIndex( CFStringRef string, NSUInteger index );
void StringGetCharacters( CFStringRef string, unichar *buffer, CFRange range );
BOOL StringGetBytes( CFStringRef string, void *bytes, NSUInteger maxLength, NSUInteger *usedLength, NSStringEncoding enc, NSStringEncodingConversionOptions options, CFRange range, CFRange *remainingRange );

// Getting c strings
void *StringCStringUsingEncoding( CFStringRef string, NSStringEncoding enc );
BOOL StringGetCString( CFStringRef string, void *buffer, NSUInteger maxLength, NSStringEncoding enc );
void *StringUTF8String( CFStringRef string );

// Identify and compare
NSComparisonResult StringCaseInsensitiveCompare( CFStringRef string, CFStringRef otherString );
NSComparisonResult StringLocalizedCaseInsensitiveCompare( CFStringRef string, CFStringRef otherString );
NSComparisonResult StringCompare( CFStringRef string, CFStringRef otherString );
NSComparisonResult StringLocalizedCompare( CFStringRef string, CFStringRef otherString );
NSComparisonResult StringCompareWithOptions( CFStringRef string, CFStringRef otherString, NSStringCompareOptions options );
NSComparisonResult StringCompareWithOptionsInRange( CFStringRef string, CFStringRef otherString, NSStringCompareOptions options, CFRange range );
NSComparisonResult StringCompareWithOptionsInRangeWithLocale( CFStringRef string, CFStringRef otherString, NSStringCompareOptions options, CFRange range, CFLocaleRef locale );
NSComparisonResult StringLocalizedStandardCompare( CFStringRef string, CFStringRef otherString );
BOOL StringHasPrefix( CFStringRef string, CFStringRef prefix );
BOOL StringHasSuffix( CFStringRef string, CFStringRef suffix );
BOOL StringIsEqual( CFStringRef string, CFStringRef otherString );
NSUInteger StringHash( CFStringRef string );

// Combine
CFStringRef StringByAppendingFormat( CFStringRef string, CFStringRef format, ... );
CFStringRef StringByAppendingString( CFStringRef string1, CFStringRef string2 );
CFStringRef StringByPaddingToLength( CFStringRef string, NSUInteger newLength, CFStringRef padString, NSUInteger padIndex );

// Case
CFStringRef StringLowercaseString( CFStringRef string );
CFStringRef StringLocalizedLowercaseString( CFStringRef string );
CFStringRef StringLowercaseStringWithLocale( CFStringRef string, CFLocaleRef locale );
CFStringRef StringUppercaseString( CFStringRef string );
CFStringRef StringLocalizedUppercaseString( CFStringRef string );
CFStringRef StringUppercaseStringWithLocale( CFStringRef string, CFLocaleRef locale );
CFStringRef StringCapitalizedString( CFStringRef string );
CFStringRef StringLocalizedCapitalizedString( CFStringRef string );
CFStringRef StringCapitalizedStringWithLocale( CFStringRef string, CFLocaleRef locale );

// Divide
CFArrayRef StringComponentsSeparatedByString( CFStringRef string, CFStringRef separator );
CFArrayRef StringComponentsSeparatedByCharactersInSet( CFStringRef string, CFCharacterSetRef set );
CFStringRef StringByTrimmingCharactersInSet( CFStringRef string, CFCharacterSetRef set );
CFStringRef StringSubstringFromIndex( CFStringRef string, NSUInteger index );
CFStringRef StringSubstringWithRange( CFStringRef string, CFRange range );
CFStringRef StringSubstringToIndex( CFStringRef string, NSUInteger index );

// Normalize
CFStringRef StringDecomposedStringWithCanonicalMapping( CFStringRef string );
CFStringRef StringDecomposedStringWithCompatibilityMapping( CFStringRef string );
CFStringRef StringPrecomposedStringWithCanonicalMapping( CFStringRef string );
CFStringRef StringPrecomposedStringWithCompatibilityMapping( CFStringRef string );

// Fold
CFStringRef StringByFolding( CFStringRef string, NSStringCompareOptions options, CFLocaleRef locale );

// Transform
CFStringRef StringByApplyingTransform( CFStringRef string, CFStringRef transform, BOOL reverse );

// Find
BOOL StringContainsString( CFStringRef string1, CFStringRef string2 );
BOOL StringLocalizedCaseInsensitiveContainsString( CFStringRef string1, CFStringRef string2 );

BOOL StringLocalizedStandardContainsString( CFStringRef string1, CFStringRef string2 );

CFRange StringRangeOfCharacterFromSet( CFStringRef string, CFCharacterSetRef set );
CFRange StringRangeOfCharacterFromSetWithOptions( CFStringRef string, CFCharacterSetRef set, NSStringCompareOptions options );
CFRange StringRangeOfCharacterFromSetWithOptionsInRange( CFStringRef string, CFCharacterSetRef set, NSStringCompareOptions options, CFRange inRange );
CFRange StringRangeOfString( CFStringRef string, CFStringRef searchString );
CFRange StringRangeOfStringWithOptions( CFStringRef string, CFStringRef searchString, NSStringCompareOptions options );
CFRange StringRangeOfStringWithOptionsInRange( CFStringRef string, CFStringRef searchString, NSStringCompareOptions options, CFRange inRange );
CFRange StringRangeOfStringWithOptionsInRangeAndLocale( CFStringRef string, CFStringRef searchString, NSStringCompareOptions options, CFRange inRange, CFLocaleRef locale );

CFRange StringLocalizedStandardRangeOfString( CFStringRef string1, CFStringRef string2 );

void StringEnumerateLines( CFStringRef string, CUI_StringEnumerateLinesCallbackType callback, void *userData );
void StringEnumerateSubstringsInRange( CFStringRef string, CFRange range, NSStringEnumerationOptions options, CUI_StringEnumerateSubstringsCallbackType callback, void *userData );

// Replace substrings
CFStringRef StringByReplacingOccurrencesOfString( CFStringRef string, CFStringRef target, CFStringRef replacement );
CFStringRef StringByReplacingOccurrencesOfStringWithOptions( CFStringRef string, CFStringRef target, CFStringRef replacement, NSStringCompareOptions options, CFRange range );
CFStringRef StringByReplacingCharactersInRange( CFStringRef string, CFRange range, CFStringRef replacement );

// Shared prefix
CFStringRef StringCommonPrefixWithString( CFStringRef string1, CFStringRef string2, NSStringCompareOptions options );

// Linguistic analysis
void StringEnumerateLinguisticTags( CFStringRef string, CFRange range, CFStringRef scheme, NSLinguisticTaggerOptions options, NSOrthography *orthRef, CUI_StringLinguisticTaggerCallbackType callback, void *userData );
CFArrayRef StringLinguisticTagsInRange( CFStringRef string, CFRange range, CFStringRef scheme, NSLinguisticTaggerOptions options, NSOrthography *orthRef, CFArrayRef *tokenRanges );

// Line and paragraph ranges
void StringGetLineStartEnd( CFStringRef string, NSUInteger *startPtr, NSUInteger *lineEndPtr, NSUInteger *contentsEndPtr, CFRange range );
CFRange StringLineRange( CFStringRef string, CFRange range );
void StringGetParagraphStartEnd( CFStringRef string, NSUInteger *startPtr, NSUInteger *parEndPtr, NSUInteger *contentsEndPtr, CFRange range );
CFRange StringParagraphRange( CFStringRef string, CFRange range );

// Composed char sequences
CFRange StringRangeOfComposedCharacterSequenceAtIndex( CFStringRef string, NSUInteger index );
CFRange StringRangeOfComposedCharacterSequencesForRange( CFStringRef string, CFRange range );

// Write to URL
BOOL StringWriteToURL( CFStringRef string, CFURLRef url, BOOL atomically, NSStringEncoding encoding, NSError **err );

// Property list
CFTypeRef StringPropertyList( CFStringRef string );
CFDictionaryRef StringPropertyListFromStringsFileFormat( CFStringRef string );

// Sizing and drawing
void StringDrawAtPoint( CFStringRef string, CGPoint pt, CFDictionaryRef attributes );
void StringDrawInRect( CFStringRef string, CGRect rect, CFDictionaryRef attributes );

void StringDrawWithRect( CFStringRef string, CGRect rect, NSStringDrawingOptions options, CFDictionaryRef attributes, NSStringDrawingContext *context );
CGRect StringBoundingRectWithSize( CFStringRef string, CGSize size, NSStringDrawingOptions options, CFDictionaryRef attributes, NSStringDrawingContext *context );

CGSize StringSizeWithAttributes( CFStringRef string, CFDictionaryRef attributes );

// Numeric values
double StringDoubleValue( CFStringRef string );
float StringFloatValue( CFStringRef string );
SInt32 StringIntValue( CFStringRef string );
NSInteger StringIntegerValue( CFStringRef string );
SInt64 StringLongLongValue( CFStringRef string );
BOOL StringBoolValue( CFStringRef string );

// Working with encodings
void *StringAvailableStringEncodings( void );
NSStringEncoding StringDefaultCStringEncoding( void );
NSStringEncoding StringEncodingForData( CFDataRef dta, CFDictionaryRef encodingOptions, CFStringRef *convertedString, BOOL *usedLossyConversion );
CFStringRef StringLocalizedNameOfStringEncoding( NSStringEncoding encoding );
BOOL StringCanBeConvertedToEncoding( CFStringRef string, NSStringEncoding encoding );
CFDataRef StringData( CFStringRef string, NSStringEncoding encoding );
CFDataRef StringDataAllowLossyConversion( CFStringRef string, NSStringEncoding encoding, BOOL lossy );
CFStringRef StringDescription( CFStringRef string );
NSStringEncoding StringFastestEncoding( CFStringRef string );
NSStringEncoding StringSmallestEncoding( CFStringRef string );

// Paths
CFStringRef StringPathWithComponents( CFArrayRef array );
CFArrayRef StringPathComponents( CFStringRef string );
NSUInteger StringCompletePathIntoString( CFStringRef string, CFStringRef *outputName, BOOL caseSensitive, CFArrayRef *outputArray, CFArrayRef filterTypes );
void *StringFileStystemRepresentation( CFStringRef string );
BOOL StringIsAbsolutePath( CFStringRef string );
CFStringRef StringLastPathComponent( CFStringRef string );
CFStringRef StringPathExtension( CFStringRef string );
CFStringRef StringByAbbreviatingWithTildeInPath( CFStringRef string );
CFStringRef StringByAppendingPathComponent( CFStringRef string, CFStringRef component );
CFStringRef StringByAppendingPathExtension( CFStringRef string, CFStringRef extension );
CFStringRef StringByDeletingLastPathComponent( CFStringRef string );
CFStringRef StringByDeletingPathExtension( CFStringRef string );
CFStringRef StringByExpandingTildeInPath( CFStringRef string );
CFStringRef StringByResolvingSymlinksInPath( CFStringRef string );
CFStringRef StringByStandardizingPath( CFStringRef string );
CFArrayRef StringStringsByAppendingPaths( CFStringRef string, CFArrayRef paths );

// Working with URL strings
CFStringRef StringByAddingPercentEncodingWithAllowedCharacters( CFStringRef string, CFCharacterSetRef allowedCharacters );
CFStringRef StringByRemovingPercentEncoding( CFStringRef string );

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130300
API_AVAILABLE(macos(13.3))
CFStringRef StringWithValidatedFormatArguments( CFStringRef format, CFStringRef specifiers, va_list args, NSError **err );
API_AVAILABLE(macos(13.3))
CFStringRef StringWithValidatedFormatLocaleArguments( CFStringRef format, CFStringRef specifiers, CFLocaleRef locale, va_list args, NSError **err );
API_AVAILABLE(macos(13.3))
CFStringRef StringWithValidatedFormatLocale( CFStringRef format, CFStringRef specifiers, CFLocaleRef locale, NSError **err, ... );
#endif// 130300

// Type methods
//#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
//CFStringRef StringDeferredLocalizedIntentsStringWithFormat( CFStringRef format, ... );
//CFStringRef StringDeferredLocalizedIntentsStringWithFormatFromTable( CFStringRef format, CFStringRef table, ... );
//CFStringRef StringDeferredLocalizedIntentsStringWithFormatFromTableArguments( CFStringRef format, CFStringRef table, va_list args );
//#endif// 101400

//CFStringRef StringLocalizedWithValidatedFormat( CFStringRef format, CFStringRef specifiers, NSError **err, ... );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130300
API_AVAILABLE(macos(13.3))
CFStringRef StringWithValidatedFormat( CFStringRef format, CFStringRef specifiers, NSError **err, ... );
#endif// 130300

// CF wrappers
Boolean StringIsSurrogateHighCharacter( UniChar chr );
Boolean StringIsSurrogateLowCharacter( UniChar chr );


#pragma mark - ScriptWhoseTests functions
BOOL StringIsCaseInsensitiveLike( CFStringRef string, CFStringRef object );
BOOL StringIsLike( CFStringRef string, CFStringRef object );


#pragma mark - Convenience
long StringToLong( CFStringRef string, CFStringRef *chr, long base );
CFStringRef StringConcatenate( CFStringRef string, ... );


#pragma mark - Unicode utilities
NSUInteger StringUnicodeLength( CFStringRef string );
UInt32 StringUnicodeCharacterAtIndex( CFStringRef string, NSUInteger charIndex );
CFStringRef StringUnicodeWithCodePoint( UInt64 codePoint );
CFStringRef StringUnicodeWithCodePoints( UInt64 codePoint, ... );
CFStringRef StringUnicodeWithCodePointsArray( CFArrayRef codePoints );
CFArrayRef StringUnicodeCodePoints( CFStringRef inString, NSUInteger graphemeIndex );
BOOL StringUnicodeIsSingleGraphemeCluster( CFStringRef inString );
CFStringRef StringUnicodeNormalize( CFStringRef inString, CFStringRef inForm );
typedef void (*CUI_StringUnicodeEnumerateGraphemeClustersCalllbackType)(CFStringRef,NSUInteger,BOOL*,void*);
void StringUnicodeEnumerateGraphemeClusters( CFStringRef inString, CUI_StringUnicodeEnumerateGraphemeClustersCalllbackType callback, void *userData );
CFArrayRef StringUnicodeGraphemeClusters( CFStringRef inString );
BOOL StringUnicodeContainsEmoji( CFStringRef inString );
UInt32 StringUnicodeCodePointAtByteOffset( CFStringRef inString, NSUInteger offset );



#pragma mark - mutable string
// Class
Class MutableStringClass( void );

// Create
CFMutableStringRef MutableStringNew( void );
CFMutableStringRef MutableStringWithCapacity( NSUInteger capacity );
CFMutableStringRef MutableStringWithBytes( void *bytes, NSUInteger length, NSStringEncoding encoding );
CFMutableStringRef MutableStringWithCharacters( const unichar *characters, NSUInteger length );
CFMutableStringRef MutableStringWithData( CFDataRef dta, NSStringEncoding encoding );
CFMutableStringRef MutableStringWithFormat( CFStringRef format, ... );
CFMutableStringRef MutableStringWithString( CFStringRef string );
CFMutableStringRef MutableStringWithCString( const char *cString, NSStringEncoding encoding );
CFMutableStringRef MutableStringWithUTF8String( const char *cString );
CFMutableStringRef MutableStringWithContentsOfURL( CFURLRef url, NSStringEncoding enc, NSError **err );
CFMutableStringRef MutableStringWithContentsOfURLUsedEncoding( CFURLRef url, NSStringEncoding *enc, NSError **err );

// Modify
void MutableStringAppendFormat( CFMutableStringRef string, CFStringRef format, ... );
void MutableStringAppendString( CFMutableStringRef string, CFStringRef otherString );

void MutableStringApplyTransform( CFMutableStringRef string, CFStringRef transform, BOOL reverse, CFRange range, CFRange *resultingRange );

void MutableStringDeleteCharacters( CFMutableStringRef string, CFRange range );
void MutableStringInsertString( CFMutableStringRef string, CFStringRef otherString, NSUInteger index );
void MutableStringReplaceCharacters( CFMutableStringRef string, CFStringRef otherString, CFRange range );
void MutableStringReplaceOccurrencesOfString( CFMutableStringRef string, CFStringRef targetString, CFStringRef replacementString, NSStringCompareOptions options, CFRange range );
void MutableStringSetString( CFMutableStringRef string, CFStringRef otherString );

/*
  Convenience
*/
void MutableStringReplaceAllOccurrencesOfString( CFMutableStringRef string, CFStringRef targetString, CFStringRef replacementString );
void MutableStringPad( CFMutableStringRef string, CFStringRef padString, NSInteger length, NSInteger indexIntoPad );
void MutableStringTrim( CFMutableStringRef string, CFStringRef trimString );
void MutableStringTrimWhitespace( CFMutableStringRef string );
void MutableStringCapitalize( CFMutableStringRef string );
void MutableStringCapitalizeWithLocale( CFMutableStringRef string, CFLocaleRef locale );
void MutableStringLowercase( CFMutableStringRef string );
void MutableStringLowercaseWithLocale( CFMutableStringRef string, CFLocaleRef locale );
void MutableStringUppercase( CFMutableStringRef string );
void MutableStringUppercaseWithLocale( CFMutableStringRef string, CFLocaleRef locale );
