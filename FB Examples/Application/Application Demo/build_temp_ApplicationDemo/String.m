/*
 String.m

 Bernie Wylde
 */

#import "String.h"

// Class
Class StringClass( void )
{ return [NSString class]; }

// Init
CFStringRef StringWithBytes( void *bytes, NSUInteger length, NSStringEncoding encoding )
{
#if __has_feature(objc_arc)
    return (__bridge CFStringRef)[[NSString alloc] initWithBytes:bytes length:length encoding:encoding];
#else
    return (__bridge CFStringRef)[[[NSString alloc] initWithBytes:bytes length:length encoding:encoding] autorelease];
#endif
}

CFStringRef StringWithCharacters( const unichar *characters, NSUInteger length )
{
#if __has_feature(objc_arc)
    return (__bridge CFStringRef)[[NSString alloc] initWithCharacters:characters length:length];
#else
    return (__bridge CFStringRef)[[[NSString alloc] initWithCharacters:characters length:length] autorelease];
#endif
}

CFStringRef StringWithData( CFDataRef dta, NSStringEncoding encoding )
{
#if __has_feature(objc_arc)
    return (__bridge CFStringRef)[[NSString alloc] initWithData:(__bridge NSData *)dta encoding:encoding];
#else
    return (__bridge CFStringRef)[[[NSString alloc] initWithData:(__bridge NSData *)dta encoding:encoding] autorelease];
#endif
}

CFStringRef StringWithFormat( CFStringRef format, ... )
{
    va_list ap;
    va_start( ap, format );
#if __has_feature(objc_arc)
    NSString *string = [[NSString alloc] initWithFormat:(__bridge NSString *)format arguments:ap];
#else
    NSString *string = [[[NSString alloc] initWithFormat:(__bridge NSString *)format arguments:ap] autorelease];
#endif
    va_end( ap );
    return (__bridge CFStringRef)string;
}

CFStringRef StringWithString( CFStringRef string )
{ return (__bridge CFStringRef)[NSString stringWithString:(__bridge NSString *)string]; }

CFStringRef StringWithCString( const char *cString, NSStringEncoding encoding )
{ return (__bridge CFStringRef)[NSString stringWithCString:cString encoding:encoding]; }

CFStringRef StringWithUTF8String( const char *cString )
{ return (__bridge CFStringRef)[NSString stringWithUTF8String:cString]; }

// Init from URL
CFStringRef StringWithContentsOfURL( CFURLRef url, NSStringEncoding enc, NSError **err )
{ return (__bridge CFStringRef)[NSString stringWithContentsOfURL:(__bridge NSURL *)url encoding:enc error:err]; }

CFStringRef StringWithContentsOfURLUsedEncoding( CFURLRef url, NSStringEncoding *enc, NSError **err )
{ return (__bridge CFStringRef)[NSString stringWithContentsOfURL:(__bridge NSURL *)url usedEncoding:enc error:err]; }

// Length
NSUInteger StringLength( CFStringRef string )
{ return [(__bridge NSString *)string length]; }

NSUInteger StringLengthOfBytes( CFStringRef string, NSStringEncoding enc )
{ return [(__bridge NSString *)string lengthOfBytesUsingEncoding:enc]; }

NSUInteger StringMaximumLengthOfBytes( CFStringRef string, NSStringEncoding enc )
{ return [(__bridge NSString *)string maximumLengthOfBytesUsingEncoding:enc]; }

// Characters and bytes
unichar StringCharacterAtIndex( CFStringRef string, NSUInteger index )
{ return [(__bridge NSString *)string characterAtIndex:index]; }

void StringGetCharacters( CFStringRef string, unichar *buffer, CFRange range )
{ [(__bridge NSString *)string getCharacters:buffer range:NSRangeFromCFRange(range)]; }

BOOL StringGetBytes( CFStringRef string, void *bytes, NSUInteger maxLength, NSUInteger *usedLength, NSStringEncoding enc, NSStringEncodingConversionOptions options, CFRange range, CFRange *remainingRange )
{ return [(__bridge NSString *)string getBytes:bytes maxLength:maxLength usedLength:usedLength encoding:enc options:options range:NSRangeFromCFRange(range) remainingRange:(NSRange *)remainingRange]; }

// Getting c strings
void *StringCStringUsingEncoding( CFStringRef string, NSStringEncoding enc )
{ return (void *)[(__bridge NSString *)string cStringUsingEncoding:enc]; }

BOOL StringGetCString( CFStringRef string, void *buffer, NSUInteger maxLength, NSStringEncoding enc )
{ return [(__bridge NSString *)string getCString:buffer maxLength:maxLength encoding:enc]; }

void *StringUTF8String( CFStringRef string )
{ return (void *)[(__bridge NSString *)string UTF8String]; }

// Identify and compare
NSComparisonResult StringCaseInsensitiveCompare( CFStringRef string, CFStringRef otherString )
{ return [(__bridge NSString *)string caseInsensitiveCompare:(__bridge NSString *)otherString]; }

NSComparisonResult StringLocalizedCaseInsensitiveCompare( CFStringRef string, CFStringRef otherString )
{ return [(__bridge NSString *)string localizedCaseInsensitiveCompare:(__bridge NSString *)otherString]; }

NSComparisonResult StringCompare( CFStringRef string, CFStringRef otherString )
{ return [(__bridge NSString *)string compare:(__bridge NSString *)otherString]; }

NSComparisonResult StringLocalizedCompare( CFStringRef string, CFStringRef otherString )
{ return [(__bridge NSString *)string localizedCompare:(__bridge NSString *)otherString]; }

NSComparisonResult StringCompareWithOptions( CFStringRef string, CFStringRef otherString, NSStringCompareOptions options )
{ return [(__bridge NSString *)string compare:(__bridge NSString *)otherString options:options]; }

NSComparisonResult StringCompareWithOptionsInRange( CFStringRef string, CFStringRef otherString, NSStringCompareOptions options, CFRange range )
{ return [(__bridge NSString *)string compare:(__bridge NSString *)otherString options:options range:NSRangeFromCFRange(range)]; }

NSComparisonResult StringCompareWithOptionsInRangeWithLocale( CFStringRef string, CFStringRef otherString, NSStringCompareOptions options, CFRange range, CFLocaleRef locale )
{ return [(__bridge NSString *)string compare:(__bridge NSString *)otherString options:options range:NSRangeFromCFRange(range) locale:(__bridge NSLocale *)locale]; }

NSComparisonResult StringLocalizedStandardCompare( CFStringRef string, CFStringRef otherString )
{ return [(__bridge NSString *)string localizedStandardCompare:(__bridge NSString *)otherString]; }

BOOL StringHasPrefix( CFStringRef string, CFStringRef prefix )
{ return [(__bridge NSString *)string hasPrefix:(__bridge NSString *)prefix]; }

BOOL StringHasSuffix( CFStringRef string, CFStringRef suffix )
{ return [(__bridge NSString *)string hasSuffix:(__bridge NSString *)suffix]; }

BOOL StringIsEqual( CFStringRef string, CFStringRef otherString )
{ return [(__bridge NSString *)string isEqualToString:(__bridge NSString *)otherString]; }

NSUInteger StringHash( CFStringRef string )
{ return [(__bridge NSString *)string hash]; }

// Combine
CFStringRef StringByAppendingFormat( CFStringRef string, CFStringRef format, ... )
{
    va_list ap;
    va_start( ap, format );
    NSString *formattedString = [[NSString alloc] initWithFormat:(__bridge NSString *)format arguments:ap];
    NSString *outString = [(__bridge NSString *)string stringByAppendingString:formattedString];
#if !__has_feature(objc_arc)
    [formattedString release];
#endif
    va_end( ap );
    return (__bridge CFStringRef)outString;
}

CFStringRef StringByAppendingString( CFStringRef string1, CFStringRef string2 )
{ return (__bridge CFStringRef)[(__bridge NSString *)string1 stringByAppendingString:(__bridge NSString *)string2]; }

CFStringRef StringByPaddingToLength( CFStringRef string, NSUInteger newLength, CFStringRef padString, NSUInteger padIndex )
{ return (__bridge CFStringRef)[(__bridge NSString *)string stringByPaddingToLength:newLength withString:(__bridge NSString *)padString startingAtIndex:padIndex]; }

// Case
CFStringRef StringLowercaseString( CFStringRef string )
{ return (__bridge CFStringRef)[(__bridge NSString *)string lowercaseString]; }

CFStringRef StringLocalizedLowercaseString( CFStringRef string )
{ return (__bridge CFStringRef)[(__bridge NSString *)string localizedLowercaseString]; }

CFStringRef StringLowercaseStringWithLocale( CFStringRef string, CFLocaleRef locale )
{ return (__bridge CFStringRef)[(__bridge NSString *)string lowercaseStringWithLocale:(__bridge NSLocale *)locale]; }

CFStringRef StringUppercaseString( CFStringRef string )
{ return (__bridge CFStringRef)[(__bridge NSString *)string uppercaseString]; }

CFStringRef StringLocalizedUppercaseString( CFStringRef string )
{ return (__bridge CFStringRef)[(__bridge NSString *)string localizedUppercaseString]; }

CFStringRef StringUppercaseStringWithLocale( CFStringRef string, CFLocaleRef locale )
{ return (__bridge CFStringRef)[(__bridge NSString *)string uppercaseStringWithLocale:(__bridge NSLocale *)locale]; }

CFStringRef StringCapitalizedString( CFStringRef string )
{ return (__bridge CFStringRef)[(__bridge NSString *)string capitalizedString]; }

CFStringRef StringLocalizedCapitalizedString( CFStringRef string )
{ return (__bridge CFStringRef)[(__bridge NSString *)string localizedCapitalizedString]; }

CFStringRef StringCapitalizedStringWithLocale( CFStringRef string, CFLocaleRef locale )
{ return (__bridge CFStringRef)[(__bridge NSString *)string capitalizedStringWithLocale:(__bridge NSLocale *)locale]; }

// Divide
CFArrayRef StringComponentsSeparatedByString( CFStringRef string, CFStringRef separator )
{ return (__bridge CFArrayRef)[(__bridge NSString *)string componentsSeparatedByString:(__bridge NSString *)separator]; }

CFArrayRef StringComponentsSeparatedByCharactersInSet( CFStringRef string, CFCharacterSetRef set )
{ return (__bridge CFArrayRef)[(__bridge NSString *)string componentsSeparatedByCharactersInSet:(__bridge NSCharacterSet *)set]; }

CFStringRef StringByTrimmingCharactersInSet( CFStringRef string, CFCharacterSetRef set )
{ return (__bridge CFStringRef)[(__bridge NSString *)string stringByTrimmingCharactersInSet:(__bridge NSCharacterSet *)set]; }

CFStringRef StringSubstringFromIndex( CFStringRef string, NSUInteger index )
{ return (__bridge CFStringRef)[(__bridge NSString *)string substringFromIndex:index]; }

CFStringRef StringSubstringWithRange( CFStringRef string, CFRange range )
{ return (__bridge CFStringRef)[(__bridge NSString *)string substringWithRange:NSRangeFromCFRange(range)]; }

CFStringRef StringSubstringToIndex( CFStringRef string, NSUInteger index )
{ return (__bridge CFStringRef)[(__bridge NSString *)string substringToIndex:index]; }

// Normalize
CFStringRef StringDecomposedStringWithCanonicalMapping( CFStringRef string )
{ return (__bridge CFStringRef)[(__bridge NSString *)string decomposedStringWithCanonicalMapping]; }

CFStringRef StringDecomposedStringWithCompatibilityMapping( CFStringRef string )
{ return (__bridge CFStringRef)[(__bridge NSString *)string decomposedStringWithCompatibilityMapping]; }

CFStringRef StringPrecomposedStringWithCanonicalMapping( CFStringRef string )
{ return (__bridge CFStringRef)[(__bridge NSString *)string precomposedStringWithCanonicalMapping]; }

CFStringRef StringPrecomposedStringWithCompatibilityMapping( CFStringRef string )
{ return (__bridge CFStringRef)[(__bridge NSString *)string precomposedStringWithCompatibilityMapping]; }

// Fold
CFStringRef StringByFolding( CFStringRef string, NSStringCompareOptions options, CFLocaleRef locale )
{ return (__bridge CFStringRef)[(__bridge NSString *)string stringByFoldingWithOptions:options locale:(__bridge NSLocale *)locale]; }

// Transform
CFStringRef StringByApplyingTransform( CFStringRef string, CFStringRef transform, BOOL reverse )
{ return (__bridge CFStringRef)[(__bridge NSString *)string stringByApplyingTransform:(__bridge NSString *)transform reverse:reverse]; }

// Find
BOOL StringContainsString( CFStringRef string1, CFStringRef string2 )
{ return [(__bridge NSString *)string1 containsString:(__bridge NSString *)string2]; }

BOOL StringLocalizedCaseInsensitiveContainsString( CFStringRef string1, CFStringRef string2 )
{ return [(__bridge NSString *)string1 localizedCaseInsensitiveContainsString:(__bridge NSString *)string2]; }

BOOL StringLocalizedStandardContainsString( CFStringRef string1, CFStringRef string2 )
{ return [(__bridge NSString *)string1 localizedStandardContainsString:(__bridge NSString *)string2]; }

CFRange StringRangeOfCharacterFromSet( CFStringRef string, CFCharacterSetRef set )
{
    NSRange range = [(__bridge NSString *)string rangeOfCharacterFromSet:(__bridge NSCharacterSet *)set];
    return NSRangeToCFRange( range );
}

CFRange StringRangeOfCharacterFromSetWithOptions( CFStringRef string, CFCharacterSetRef set, NSStringCompareOptions options )
{
    NSRange range = [(__bridge NSString *)string rangeOfCharacterFromSet:(__bridge NSCharacterSet *)set options:options];
    return NSRangeToCFRange( range );
}

CFRange StringRangeOfCharacterFromSetWithOptionsInRange( CFStringRef string, CFCharacterSetRef set, NSStringCompareOptions options, CFRange inRange )
{
    NSRange range = [(__bridge NSString *)string rangeOfCharacterFromSet:(__bridge NSCharacterSet *)set options:options range:NSRangeFromCFRange(inRange)];
    return NSRangeToCFRange( range );
}

CFRange StringRangeOfString( CFStringRef string, CFStringRef searchString )
{
    NSRange range = [(__bridge NSString *)string rangeOfString:(__bridge NSString *)searchString];
    return NSRangeToCFRange( range );
}

CFRange StringRangeOfStringWithOptions( CFStringRef string, CFStringRef searchString, NSStringCompareOptions options )
{
    NSRange range = [(__bridge NSString *)string rangeOfString:(__bridge NSString *)searchString options:options];
    return NSRangeToCFRange( range );
}

CFRange StringRangeOfStringWithOptionsInRange( CFStringRef string, CFStringRef searchString, NSStringCompareOptions options, CFRange inRange )
{
    NSRange range = [(__bridge NSString *)string rangeOfString:(__bridge NSString *)searchString options:options range:NSRangeFromCFRange(inRange)];
    return NSRangeToCFRange( range );
}

CFRange StringRangeOfStringWithOptionsInRangeAndLocale( CFStringRef string, CFStringRef searchString, NSStringCompareOptions options, CFRange inRange, CFLocaleRef locale )
{
    NSRange range = [(__bridge NSString *)string rangeOfString:(__bridge NSString *)searchString options:options range:NSRangeFromCFRange(inRange) locale:(__bridge NSLocale *)locale];
    return NSRangeToCFRange( range );
}

CFRange StringLocalizedStandardRangeOfString( CFStringRef string1, CFStringRef string2 )
{
    NSRange range = [(__bridge NSString *)string1 localizedStandardRangeOfString:(__bridge NSString *)string2];
    return NSRangeToCFRange( range );
}

void StringEnumerateLines( CFStringRef string, CUI_StringEnumerateLinesCallbackType callback, void *userData )
{
    [(__bridge NSString *)string enumerateLinesUsingBlock:^(NSString *line, BOOL *stop) {
        (*callback)( string, (__bridge CFStringRef)line, stop, userData );
    }];
}

void StringEnumerateSubstringsInRange( CFStringRef string, CFRange range, NSStringEnumerationOptions options, CUI_StringEnumerateSubstringsCallbackType callback, void *userData )
{
    [(__bridge NSString *)string enumerateSubstringsInRange:NSRangeFromCFRange(range) options:options usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        (*callback)( string, (__bridge CFStringRef)substring, NSRangeToCFRange(substringRange), NSRangeToCFRange(enclosingRange), stop, userData );
    }];
}

// Replace substrings
CFStringRef StringByReplacingOccurrencesOfString( CFStringRef string, CFStringRef target, CFStringRef replacement )
{ return (__bridge CFStringRef)[(__bridge NSString *)string stringByReplacingOccurrencesOfString:(__bridge NSString *)target withString:(__bridge NSString *)replacement]; }

CFStringRef StringByReplacingOccurrencesOfStringWithOptions( CFStringRef string, CFStringRef target, CFStringRef replacement, NSStringCompareOptions options, CFRange range )
{ return (__bridge CFStringRef)[(__bridge NSString *)string stringByReplacingOccurrencesOfString:(__bridge NSString *)target withString:(__bridge NSString *)replacement options:options range:NSRangeFromCFRange(range)]; }

CFStringRef StringByReplacingCharactersInRange( CFStringRef string, CFRange range, CFStringRef replacement )
{ return (__bridge CFStringRef)[(__bridge NSString *)string stringByReplacingCharactersInRange:NSRangeFromCFRange(range) withString:(__bridge NSString *)replacement]; }

// Shared prefix
CFStringRef StringCommonPrefixWithString( CFStringRef string1, CFStringRef string2, NSStringCompareOptions options )
{ return (__bridge CFStringRef)[(__bridge NSString *)string1 commonPrefixWithString:(__bridge NSString *)string2 options:options]; }

// Linguistic analysis
void StringEnumerateLinguisticTags( CFStringRef string, CFRange range, CFStringRef scheme, NSLinguisticTaggerOptions options, NSOrthography *orthRef, CUI_StringLinguisticTaggerCallbackType callback, void *userData )
{
    [(__bridge NSString *)string enumerateLinguisticTagsInRange:NSRangeFromCFRange(range)
                                                scheme:(__bridge NSString *)scheme
                                               options:options
                                           orthography:orthRef
                                            usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
                                                (*callback)( string, (__bridge CFStringRef)tag, NSRangeToCFRange(tokenRange), NSRangeToCFRange(sentenceRange), stop, userData );
                                            }];
}

CFArrayRef StringLinguisticTagsInRange( CFStringRef string, CFRange range, CFStringRef scheme, NSLinguisticTaggerOptions options, NSOrthography *orthRef, CFArrayRef *tokenRanges )
{
    NSArray *tempTokenRanges = nil;
    NSArray *tags = [(__bridge NSString *)string linguisticTagsInRange:NSRangeFromCFRange(range) scheme:(__bridge NSString *)scheme options:options orthography:orthRef tokenRanges:&tempTokenRanges];
    if ( tokenRanges ) *tokenRanges = (__bridge CFArrayRef)tempTokenRanges;
    return (__bridge CFArrayRef)tags;
}

// Line and paragraph ranges
void StringGetLineStartEnd( CFStringRef string, NSUInteger *startPtr, NSUInteger *lineEndPtr, NSUInteger *contentsEndPtr, CFRange range )
{ [(__bridge NSString *)string getLineStart:startPtr end:lineEndPtr contentsEnd:contentsEndPtr forRange:NSRangeFromCFRange(range)]; }

CFRange StringLineRange( CFStringRef string, CFRange range )
{ return NSRangeToCFRange([(__bridge NSString *)string lineRangeForRange:NSRangeFromCFRange(range)]); }

void StringGetParagraphStartEnd( CFStringRef string, NSUInteger *startPtr, NSUInteger *parEndPtr, NSUInteger *contentsEndPtr, CFRange range )
{ [(__bridge NSString *)string getParagraphStart:startPtr end:parEndPtr contentsEnd:contentsEndPtr forRange:NSRangeFromCFRange(range)]; }

CFRange StringParagraphRange( CFStringRef string, CFRange range )
{ return NSRangeToCFRange([(__bridge NSString *)string paragraphRangeForRange:NSRangeFromCFRange(range)]); }

// Composed char sequences
CFRange StringRangeOfComposedCharacterSequenceAtIndex( CFStringRef string, NSUInteger index )
{ return NSRangeToCFRange([(__bridge NSString *)string rangeOfComposedCharacterSequenceAtIndex:index]); }

CFRange StringRangeOfComposedCharacterSequencesForRange( CFStringRef string, CFRange range )
{ return NSRangeToCFRange([(__bridge NSString *)string rangeOfComposedCharacterSequencesForRange:NSRangeFromCFRange(range)]); }

// Write to URL
BOOL StringWriteToURL( CFStringRef string, CFURLRef url, BOOL atomically, NSStringEncoding encoding, NSError **err )
{ return [(__bridge NSString *)string writeToURL:(__bridge NSURL *)url atomically:atomically encoding:encoding error:err]; }

// Property list
CFTypeRef StringPropertyList( CFStringRef string )
{ return (__bridge CFTypeRef)[(__bridge NSString *)string propertyList]; }

CFDictionaryRef StringPropertyListFromStringsFileFormat( CFStringRef string )
{ return (__bridge CFDictionaryRef)[(__bridge NSString *)string propertyListFromStringsFileFormat]; }

// Sizing and drawing
void StringDrawAtPoint( CFStringRef string, CGPoint pt, CFDictionaryRef attributes )
{ [(__bridge NSString *)string drawAtPoint:NSPointFromCGPoint(pt) withAttributes:(__bridge NSDictionary *)attributes]; }

void StringDrawInRect( CFStringRef string, CGRect rect, CFDictionaryRef attributes )
{ [(__bridge NSString *)string drawInRect:NSRectFromCGRect(rect) withAttributes:(__bridge NSDictionary *)attributes]; }

void StringDrawWithRect( CFStringRef string, CGRect rect, NSStringDrawingOptions options, CFDictionaryRef attributes, NSStringDrawingContext *context )
{ [(__bridge NSString *)string drawWithRect:NSRectFromCGRect(rect) options:options attributes:(__bridge NSDictionary *)attributes context:context]; }

CGRect StringBoundingRectWithSize( CFStringRef string, CGSize size, NSStringDrawingOptions options, CFDictionaryRef attributes, NSStringDrawingContext *context )
{ return NSRectToCGRect([(__bridge NSString *)string boundingRectWithSize:NSSizeFromCGSize(size) options:options attributes:(__bridge NSDictionary *)attributes context:context]); }

CGSize StringSizeWithAttributes( CFStringRef string, CFDictionaryRef attributes )
{ return NSSizeToCGSize([(__bridge NSString *)string sizeWithAttributes:(__bridge NSDictionary *)attributes]); }

// Numeric values
double StringDoubleValue( CFStringRef string )
{ return [(__bridge NSString *)string doubleValue]; }

float StringFloatValue( CFStringRef string )
{ return [(__bridge NSString *)string floatValue]; }

SInt32 StringIntValue( CFStringRef string )
{ return [(__bridge NSString *)string intValue]; }

NSInteger StringIntegerValue( CFStringRef string )
{ return [(__bridge NSString *)string integerValue]; }

SInt64 StringLongLongValue( CFStringRef string )
{ return [(__bridge NSString *)string longLongValue]; }

BOOL StringBoolValue( CFStringRef string )
{ return [(__bridge NSString *)string boolValue]; }

// Working with encodings
void *StringAvailableStringEncodings( void )
{ return (char *)[NSString availableStringEncodings]; }

NSStringEncoding StringDefaultCStringEncoding( void )
{ return [NSString defaultCStringEncoding]; }

NSStringEncoding StringEncodingForData( CFDataRef dta, CFDictionaryRef encodingOptions, CFStringRef *convertedString, BOOL *usedLossyConversion )
{
    NSString *tempConvertedString = nil;
    NSStringEncoding encoding = [NSString stringEncodingForData:(__bridge NSData *)dta encodingOptions:(__bridge NSDictionary *)encodingOptions convertedString:&tempConvertedString usedLossyConversion:(BOOL *)usedLossyConversion];
    if ( convertedString ) *convertedString = (__bridge CFStringRef)tempConvertedString;
    return encoding;
}

CFStringRef StringLocalizedNameOfStringEncoding( NSStringEncoding encoding )
{ return (__bridge CFStringRef)[NSString localizedNameOfStringEncoding:encoding]; }

BOOL StringCanBeConvertedToEncoding( CFStringRef string, NSStringEncoding encoding )
{ return [(__bridge NSString *)string canBeConvertedToEncoding:encoding]; }

CFDataRef StringData( CFStringRef string, NSStringEncoding encoding )
{ return (__bridge CFDataRef)[(__bridge NSString *)string dataUsingEncoding:encoding]; }

CFDataRef StringDataAllowLossyConversion( CFStringRef string, NSStringEncoding encoding, BOOL lossy )
{ return (__bridge CFDataRef)[(__bridge NSString *)string dataUsingEncoding:encoding allowLossyConversion:lossy]; }

CFStringRef StringDescription( CFStringRef string )
{ return (__bridge CFStringRef)[(__bridge NSString *)string description]; }

NSStringEncoding StringFastestEncoding( CFStringRef string )
{ return [(__bridge NSString *)string fastestEncoding]; }

NSStringEncoding StringSmallestEncoding( CFStringRef string )
{ return [(__bridge NSString *)string smallestEncoding]; }

// Paths
CFStringRef StringPathWithComponents( CFArrayRef array )
{ return (__bridge CFStringRef)[NSString pathWithComponents:(__bridge NSArray *)array]; }

CFArrayRef StringPathComponents( CFStringRef string )
{ return (__bridge CFArrayRef)[(__bridge NSString *)string pathComponents]; }

NSUInteger StringCompletePathIntoString( CFStringRef string, CFStringRef *outputName, BOOL caseSensitive, CFArrayRef *outputArray, CFArrayRef filterTypes )
{ return [(__bridge NSString *)string completePathIntoString:(__bridge NSString **)outputName caseSensitive:caseSensitive matchesIntoArray:(__bridge NSArray **)outputArray filterTypes:(__bridge NSArray *)filterTypes]; }

BOOL StringIsAbsolutePath( CFStringRef string )
{ return [(__bridge NSString *)string isAbsolutePath]; }

CFStringRef StringLastPathComponent( CFStringRef string )
{ return (__bridge CFStringRef)[(__bridge NSString *)string lastPathComponent]; }

CFStringRef StringPathExtension( CFStringRef string )
{ return (__bridge CFStringRef)[(__bridge NSString *)string pathExtension]; }

CFStringRef StringByAbbreviatingWithTildeInPath( CFStringRef string )
{ return (__bridge CFStringRef)[(__bridge NSString *)string stringByAbbreviatingWithTildeInPath]; }

CFStringRef StringByAppendingPathComponent( CFStringRef string, CFStringRef component )
{ return (__bridge CFStringRef)[(__bridge NSString *)string stringByAppendingPathComponent:(__bridge NSString *)component]; }

CFStringRef StringByAppendingPathExtension( CFStringRef string, CFStringRef extension )
{ return (__bridge CFStringRef)[(__bridge NSString *)string stringByAppendingPathExtension:(__bridge NSString *)extension]; }

CFStringRef StringByDeletingLastPathComponent( CFStringRef string )
{ return (__bridge CFStringRef)[(__bridge NSString *)string stringByDeletingLastPathComponent]; }

CFStringRef StringByDeletingPathExtension( CFStringRef string )
{ return (__bridge CFStringRef)[(__bridge NSString *)string stringByDeletingPathExtension]; }

CFStringRef StringByExpandingTildeInPath( CFStringRef string )
{ return (__bridge CFStringRef)[(__bridge NSString *)string stringByExpandingTildeInPath]; }

CFStringRef StringByResolvingSymlinksInPath( CFStringRef string )
{ return (__bridge CFStringRef)[(__bridge NSString *)string stringByResolvingSymlinksInPath]; }

CFStringRef StringByStandardizingPath( CFStringRef string )
{ return (__bridge CFStringRef)[(__bridge NSString *)string stringByStandardizingPath]; }

CFArrayRef StringStringsByAppendingPaths( CFStringRef string, CFArrayRef paths )
{ return (__bridge CFArrayRef)[(__bridge NSString *)string stringsByAppendingPaths:(__bridge NSArray *)paths]; }

// Working with URL strings
CFStringRef StringByAddingPercentEncodingWithAllowedCharacters( CFStringRef string, CFCharacterSetRef allowedCharacters )
{ return (__bridge CFStringRef)[(__bridge NSString *)string stringByAddingPercentEncodingWithAllowedCharacters:(__bridge NSCharacterSet *)allowedCharacters]; }

CFStringRef StringByRemovingPercentEncoding( CFStringRef string )
{ return (__bridge CFStringRef)[(__bridge NSString *)string stringByRemovingPercentEncoding]; }

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130300
CFStringRef StringWithValidatedFormatArguments( CFStringRef format, CFStringRef specifiers, va_list args, NSError **err )
{
#if __has_feature(objc_arc)
    return (__bridge CFStringRef)[[NSString alloc] initWithValidatedFormat:(__bridge NSString *)format validFormatSpecifiers:(__bridge NSString *)specifiers arguments:args error:err];
#else
    return (__bridge CFStringRef)[[[NSString alloc] initWithValidatedFormat:(__bridge NSString *)format validFormatSpecifiers:(__bridge NSString *)specifiers arguments:args error:err] autorelease];
#endif
}

CFStringRef StringWithValidatedFormatLocaleArguments( CFStringRef format, CFStringRef specifiers, CFLocaleRef locale, va_list args, NSError **err )
{
#if __has_feature(objc_arc)
    return (__bridge CFStringRef)[[NSString alloc] initWithValidatedFormat:(__bridge NSString *)format validFormatSpecifiers:(__bridge NSString *)specifiers locale:(__bridge NSLocale *)locale arguments:args error:err];
#else
    return (__bridge CFStringRef)[[[NSString alloc] initWithValidatedFormat:(__bridge NSString *)format validFormatSpecifiers:(__bridge NSString *)specifiers locale:(__bridge NSLocale *)locale arguments:args error:err] autorelease];
#endif
}

CFStringRef StringWithValidatedFormatLocale( CFStringRef format, CFStringRef specifiers, CFLocaleRef locale, NSError **err, ... )
{
    va_list ap;
    va_start( ap, err );
#if __has_feature(objc_arc)
    NSString *string = [[NSString alloc] initWithValidatedFormat:(__bridge NSString *)format validFormatSpecifiers:(__bridge NSString *)specifiers locale:(__bridge NSLocale *)locale arguments:ap error:err];
#else
    NSString *string = [[[NSString alloc] initWithValidatedFormat:(__bridge NSString *)format validFormatSpecifiers:(__bridge NSString *)specifiers locale:(__bridge NSLocale *)locale arguments:ap error:err] autorelease];
#endif
    va_end( ap );
    return (__bridge CFStringRef)string;
}
#endif// 130300

// Type methods
//#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
//CFStringRef StringDeferredLocalizedIntentsStringWithFormat( CFStringRef format, ... )
//{
//    va_list ap;
//    va_start( ap, table );
//    NSString *string = [NSString deferredLocalizedIntentsStringWithFormat:(__bridge NSString *)format arguments:ap];
//    va_end( ap );
//    return (__bridge CFStringRef)string;
//}
//
//CFStringRef StringDeferredLocalizedIntentsStringWithFormatFromTable( CFStringRef format, CFStringRef table, ... )
//{
//    va_list ap;
//    va_start( ap, table );
//    NSString *string = [NSString deferredLocalizedIntentsStringWithFormat:(__bridge NSString *)format fromTable:(__bridge NSString *)table arguments:ap];
//    va_end( ap );
//    return (__bridge CFStringRef)string;
//}
//
//CFStringRef StringDeferredLocalizedIntentsStringWithFormatFromTableArguments( CFStringRef format, CFStringRef table, va_list args )
//{ return (__bridge CFStringRef)[NSString deferredLocalizedIntentsStringWithFormat:(__bridge NSString *)format fromTable:(__bridge NSString *)table arguments:args]; }
//#endif// 101400

//CFStringRef StringLocalizedWithValidatedFormat( CFStringRef format, CFStringRef specifiers, NSError **err, ... )
//{
//    va_list ap;
//    va_start( ap, err );
//    NSString *string = (__bridge CFStringRef)[NSString localizedStringWithValidatedFormat:(__bridge NSString *)format validFormatSpecifiers:(__bridge NSString *)specifiers error:err
//    return (__bridge CFStringRef)string;
//}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130300
CFStringRef StringWithValidatedFormat( CFStringRef format, CFStringRef specifiers, NSError **err, ... )
{
    va_list ap;
    va_start( ap, err );
#if __has_feature(objc_arc)
    NSString *string = [[NSString alloc] initWithValidatedFormat:(__bridge NSString *)format validFormatSpecifiers:(__bridge NSString *)specifiers arguments:ap error:err];
#else
    NSString *string = [[[NSString alloc] initWithValidatedFormat:(__bridge NSString *)format validFormatSpecifiers:(__bridge NSString *)specifiers arguments:ap error:err] autorelease];
#endif
    va_end( ap );
    return (__bridge CFStringRef)string;
}
#endif// 130300

// CF wrappers
Boolean StringIsSurrogateHighCharacter( UniChar chr )
{ return CFStringIsSurrogateHighCharacter(chr); }

Boolean StringIsSurrogateLowCharacter( UniChar chr )
{ return CFStringIsSurrogateLowCharacter(chr); }


#pragma mark - ScriptWhoseTests functions
BOOL StringIsCaseInsensitiveLike( CFStringRef string, CFStringRef object )
{ return [(__bridge NSString *)string isCaseInsensitiveLike:(__bridge NSString *)object]; }

BOOL StringIsLike( CFStringRef string, CFStringRef object )
{ return [(__bridge NSString *)string isLike:(__bridge NSString *)object]; }


#pragma mark - Convenience
long StringToLong( CFStringRef string, CFStringRef *chr, long base )
{
  char *c;
  long result = strtol( [(__bridge NSString *)string UTF8String], &c, (int)base );
  if ( chr ) *chr = (__bridge CFStringRef)[NSString stringWithFormat:@"%s",c];
  return result;
}

CFStringRef StringConcatenate( CFStringRef inString, ... )
{
    va_list ap;
    va_start(ap,inString);
    NSString *string = @"";
    NSString *s = (__bridge NSString *)inString;
    while ( s ) {
        string = [string stringByAppendingString:s];
        s = va_arg(ap,id);
    }
    va_end(ap);
    return (__bridge CFStringRef)string;
}


#pragma mark - Unicode utilities
NSUInteger StringUnicodeLength( CFStringRef inString )
{
    NSString *string = (__bridge NSString *)inString;
    __block NSUInteger count = 0;
    [string enumerateSubstringsInRange:NSMakeRange(0,[string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString __attribute__ ((__unused__)) * _Nullable substring, NSRange __attribute__ ((__unused__)) substringRange, NSRange __attribute__ ((__unused__)) enclosingRange, BOOL __attribute__ ((__unused__)) * _Nonnull stop) {
        count++;
    }];
    return count;
}

UInt32 StringUnicodeCharacterAtIndex( CFStringRef string, NSUInteger charIndex )
{ return UCC_Function( string, charIndex ); }

CFStringRef StringUnicodeWithCodePoint( UInt64 codePoint )
{ return UCS_Function( codePoint ); }


CFStringRef StringUnicodeWithCodePoints( UInt64 codePoint, ... )
{
    va_list ap;
    va_start(ap,codePoint);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    while ( codePoint > 0 ) {
        [array addObject:@(codePoint)];
        codePoint = va_arg(ap,UInt64);
    }
    va_end(ap);
    return StringUnicodeWithCodePointsArray( (__bridge CFArrayRef)array );
}

CFStringRef StringUnicodeWithCodePointsArray( CFArrayRef inCodePoints )
{
    NSArray *codePoints = (__bridge NSArray *)inCodePoints;
    if (!codePoints || [codePoints count] == 0) return (__bridge CFStringRef)@"";

    NSMutableString *result = [NSMutableString string];
    for ( NSNumber *num in codePoints ) {
        UTF32Char codePoint = [num unsignedIntValue];
        if (codePoint <= 0xFFFF) {
            [result appendFormat:@"%C", (unichar)codePoint];
        } else {
            UTF32Char cp = codePoint - 0x10000;
            unichar highSurrogate = (unichar)((cp >> 10) + 0xD800);
            unichar lowSurrogate = (unichar)((cp & 0x3FF) + 0xDC00);
            [result appendFormat:@"%C%C", highSurrogate, lowSurrogate];
        }
    }
    return (__bridge CFStringRef)result;
}

CFArrayRef StringUnicodeCodePoints( CFStringRef inString, NSUInteger graphemeIndex )
{
    NSString *string = (__bridge NSString *)inString;
    if (!string) return nil;

    __block NSUInteger currentGrapheme = 0;
    __block NSArray<NSNumber *> *result = nil;

    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString * _Nullable substring, NSRange __attribute__ ((__unused__)) substringRange, NSRange __attribute__ ((__unused__)) enclosingRange, BOOL * _Nonnull stop) {
        if (currentGrapheme == graphemeIndex) {
            NSMutableArray<NSNumber *> *codePoints = [NSMutableArray array];
            NSUInteger index = 0;
            while (index < substring.length) {
                unichar highSurrogate = [substring characterAtIndex:index++];
                if (CFStringIsSurrogateHighCharacter(highSurrogate) && index < substring.length) {
                    unichar lowSurrogate = [substring characterAtIndex:index++];
                    UTF32Char fullCodePoint = CFStringGetLongCharacterForSurrogatePair(highSurrogate, lowSurrogate);
                    [codePoints addObject:@(fullCodePoint)];
                } else {
                    [codePoints addObject:@(highSurrogate)];
                }
            }
            result = [codePoints copy];
            *stop = YES;
        }
        currentGrapheme++;
    }];
    return (__bridge CFArrayRef)result;
}

BOOL StringUnicodeIsSingleGraphemeCluster( CFStringRef inString )
{
    if (!inString) return NO;
    NSString *string = (__bridge NSString *)inString;
    __block NSUInteger count = 0;
    [string enumerateSubstringsInRange:NSMakeRange(0,[string length])
                                 options:NSStringEnumerationByComposedCharacterSequences
                              usingBlock:^(NSString __attribute__ ((__unused__)) *substring, NSRange __attribute__ ((__unused__)) substringRange, NSRange __attribute__ ((__unused__)) enclosingRange, BOOL *stop) {
        count++;
        if (count > 1) *stop = YES;
    }];
    return (count == 1);
}

CFStringRef StringUnicodeNormalize( CFStringRef inString, CFStringRef inForm )
{
    if (!inString || !inForm) return NULL;
    NSString *string = (__bridge NSString *)inString;
    NSString *form = (__bridge NSString *)inForm;
    NSString *normalized = nil;
    if ([form isEqualToString:@"NFC"]) {
        normalized = [string precomposedStringWithCanonicalMapping];
    } else if ([form isEqualToString:@"NFD"]) {
        normalized = [string decomposedStringWithCanonicalMapping];
    } else if ([form isEqualToString:@"NFKC"]) {
        normalized = [string precomposedStringWithCompatibilityMapping];
    } else if ([form isEqualToString:@"NFKD"]) {
        normalized = [string decomposedStringWithCompatibilityMapping];
    }
    return (__bridge CFStringRef)normalized;
}

void StringUnicodeEnumerateGraphemeClusters( CFStringRef inString, CUI_StringUnicodeEnumerateGraphemeClustersCalllbackType callback, void *userData )
{
    if (!inString || !callback) return;
    NSString *string = (__bridge NSString *)inString;
    __block NSUInteger index = 0;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                                 options:NSStringEnumerationByComposedCharacterSequences
                              usingBlock:^(NSString *substring, NSRange __attribute__ ((__unused__)) substringRange, NSRange __attribute__ ((__unused__)) enclosingRange, BOOL *stop) {
        (*callback)((__bridge CFStringRef)substring,index++,stop,userData);
    }];
}

CFArrayRef StringUnicodeGraphemeClusters( CFStringRef inString )
{
    if (!inString) return nil;
    NSString *string = (__bridge NSString *)inString;
    NSMutableArray *array = [NSMutableArray array];
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                                 options:NSStringEnumerationByComposedCharacterSequences
                              usingBlock:^(NSString *substring, NSRange __attribute__ ((__unused__)) substringRange, NSRange __attribute__ ((__unused__)) enclosingRange, BOOL __attribute__ ((__unused__)) *stop) {
        [array addObject:substring];
    }];
    return (__bridge CFArrayRef)[array copy];
}

BOOL StringUnicodeContainsEmoji( CFStringRef inString )
{
    if (!inString) return NO;
    NSString *string = (__bridge NSString *)inString;
    __block BOOL containsEmoji = NO;

    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                                 options:NSStringEnumerationByComposedCharacterSequences
                              usingBlock:^(NSString *substring, NSRange __attribute__ ((__unused__)) substringRange, NSRange __attribute__ ((__unused__)) enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];

        // Check surrogate pairs for emoji (higher-plane)
        if (0xD800 <= hs && hs <= 0xDBFF && [substring length] > 1) {
            const unichar ls = [substring characterAtIndex:1];
            const int uc = ((hs - 0xD800) * 0x400) + (ls - 0xDC00) + 0x10000;
            if (0x1F300 <= uc && uc <= 0x1FAFF) { // Broad emoji range (adjust as needed)
                containsEmoji = YES;
                *stop = YES;
            }
        } else {
            // BMP emoji & symbols
            if ((0x2100 <= hs && hs <= 0x27BF) || // Misc symbols
                (0x2B05 <= hs && hs <= 0x2B07) || // Arrows
                (0x2934 <= hs && hs <= 0x2935) || // Arrows
                (0x3297 <= hs && hs <= 0x3299) || // Misc symbols
                hs == 0xA9 || hs == 0xAE || hs == 0x303D || hs == 0x3030 ||
                hs == 0x2B55 || hs == 0x2B1C || hs == 0x2B1B || hs == 0x2B50 ||
                hs == 0x231A) { // Special symbols
                containsEmoji = YES;
                *stop = YES;
            }
        }
    }];

    return containsEmoji;
}

UInt32 StringUnicodeCodePointAtByteOffset( CFStringRef inString, NSUInteger offset )
{
    if (!inString) return 0;
    NSString *string = (__bridge NSString *)inString;
    if (offset >= [string length]) return 0;

    unichar high = [string characterAtIndex:offset];

    // Check for surrogate pair
    if (CFStringIsSurrogateHighCharacter(high) && offset + 1 < [string length]) {
        unichar low = [string characterAtIndex:offset + 1];
        if (CFStringIsSurrogateLowCharacter(low)) {
            uint32_t codePoint = CFStringGetLongCharacterForSurrogatePair(high, low);
            return codePoint;
        }
    }
    return (UInt32)high;
}


#pragma mark - mutable string
// Class
Class MutableStringClass( void )
{ return [NSMutableString class]; }

// Create
CFMutableStringRef MutableStringNew( void )
{
#if __has_feature(objc_arc)
    return (__bridge CFMutableStringRef)[NSMutableString new];
#else
    return (__bridge CFMutableStringRef)[[NSMutableString new] autorelease];
#endif
}

CFMutableStringRef MutableStringWithCapacity( NSUInteger capacity )
{ return (__bridge CFMutableStringRef)[NSMutableString stringWithCapacity:capacity]; }

CFMutableStringRef MutableStringWithBytes( void *bytes, NSUInteger length, NSStringEncoding encoding )
{
#if __has_feature(objc_arc)
    return (__bridge CFMutableStringRef)[[NSMutableString alloc] initWithBytes:bytes length:length encoding:encoding];
#else
    return (__bridge CFMutableStringRef)[[[NSMutableString alloc] initWithBytes:bytes length:length encoding:encoding] autorelease];
#endif
}

CFMutableStringRef MutableStringWithCharacters( const unichar *characters, NSUInteger length )
{
#if __has_feature(objc_arc)
    return (__bridge CFMutableStringRef)[[NSMutableString alloc] initWithCharacters:characters length:length];
#else
    return (__bridge CFMutableStringRef)[[[NSMutableString alloc] initWithCharacters:characters length:length] autorelease];
#endif
}

CFMutableStringRef MutableStringWithData( CFDataRef dta, NSStringEncoding encoding )
{
#if __has_feature(objc_arc)
    return (__bridge CFMutableStringRef)[[NSMutableString alloc] initWithData:(__bridge NSData *)dta encoding:encoding];
#else
    return (__bridge CFMutableStringRef)[[[NSMutableString alloc] initWithData:(__bridge NSData *)dta encoding:encoding] autorelease];
#endif
}

CFMutableStringRef MutableStringWithFormat( CFStringRef format, ... )
{
    va_list ap;
    va_start( ap, format );
#if __has_feature(objc_arc)
    NSMutableString *string = [[NSMutableString alloc] initWithFormat:(__bridge NSString *)format arguments:ap];
#else
    NSMutableString *string = [[[NSMutableString alloc] initWithFormat:(__bridge NSString *)format arguments:ap] autorelease];
#endif
    va_end( ap );
    return (__bridge CFMutableStringRef)string;
}

CFMutableStringRef MutableStringWithString( CFStringRef string )
{ return (__bridge CFMutableStringRef)[NSMutableString stringWithString:(__bridge NSString *)string]; }

CFMutableStringRef MutableStringWithCString( const char *cString, NSStringEncoding encoding )
{ return (__bridge CFMutableStringRef)[NSMutableString stringWithCString:cString encoding:encoding]; }

CFMutableStringRef MutableStringWithUTF8String( const char *cString )
{ return (__bridge CFMutableStringRef)[NSMutableString stringWithUTF8String:cString]; }

CFMutableStringRef MutableStringWithContentsOfURL( CFURLRef url, NSStringEncoding enc, NSError **err )
{ return (__bridge CFMutableStringRef)[NSMutableString stringWithContentsOfURL:(__bridge NSURL *)url encoding:enc error:err]; }

CFMutableStringRef MutableStringWithContentsOfURLUsedEncoding( CFURLRef url, NSStringEncoding *enc, NSError **err )
{ return (__bridge CFMutableStringRef)[NSMutableString stringWithContentsOfURL:(__bridge NSURL *)url usedEncoding:enc error:err]; }

// Modify
void MutableStringAppendFormat( CFMutableStringRef string, CFStringRef format, ... )
{
    va_list ap;
    va_start( ap, format );
    NSString *formattedString = [[NSString alloc] initWithFormat:(__bridge NSString *)format arguments:ap];
    [(__bridge NSMutableString *)string appendString:formattedString];
#if !__has_feature(objc_arc)
    [formattedString release];
#endif
    va_end( ap );
}

void MutableStringAppendString( CFMutableStringRef string, CFStringRef otherString )
{ [(__bridge NSMutableString *)string appendString:(__bridge NSString *)otherString]; }

void MutableStringApplyTransform( CFMutableStringRef string, CFStringRef transform, BOOL reverse, CFRange range, CFRange *resultingRange )
{ [(__bridge NSMutableString *)string applyTransform:(__bridge NSString *)transform reverse:reverse range:NSRangeFromCFRange(range) updatedRange:(NSRangePointer)resultingRange]; }

void MutableStringDeleteCharacters( CFMutableStringRef string, CFRange range )
{ [(__bridge NSMutableString *)string deleteCharactersInRange:NSRangeFromCFRange(range)]; }

void MutableStringInsertString( CFMutableStringRef string, CFStringRef otherString, NSUInteger index )
{ [(__bridge NSMutableString *)string insertString:(__bridge NSString *)otherString atIndex:index]; }

void MutableStringReplaceCharacters( CFMutableStringRef string, CFStringRef otherString, CFRange range )
{ [(__bridge NSMutableString *)string replaceCharactersInRange:NSRangeFromCFRange(range) withString:(__bridge NSString *)otherString]; }

void MutableStringReplaceOccurrencesOfString( CFMutableStringRef string, CFStringRef targetString, CFStringRef replacementString, NSStringCompareOptions options, CFRange range )
{ [(__bridge NSMutableString *)string replaceOccurrencesOfString:(__bridge NSString *)targetString withString:(__bridge NSString *)replacementString options:options range:NSRangeFromCFRange(range)]; }

void MutableStringSetString( CFMutableStringRef string, CFStringRef otherString )
{ [(__bridge NSMutableString *)string setString:(__bridge NSString *)otherString]; }


/*
  Convenience
*/
void MutableStringReplaceAllOccurrencesOfString( CFMutableStringRef string, CFStringRef targetString, CFStringRef replacementString )
{ [(__bridge NSMutableString *)string replaceOccurrencesOfString:(__bridge NSString *)targetString withString:(__bridge NSString *)replacementString options:0 range:NSMakeRange(0,[(__bridge NSMutableString *)string length])]; }

void MutableStringPad( CFMutableStringRef string, CFStringRef padString, NSInteger length, NSInteger indexIntoPad )
{ CFStringPad( string, padString, length, indexIntoPad ); }

void MutableStringTrim( CFMutableStringRef string, CFStringRef trimString )
{ CFStringTrim( string, trimString ); }

void MutableStringTrimWhitespace( CFMutableStringRef string )
{ CFStringTrimWhitespace( string ); }

void MutableStringCapitalize( CFMutableStringRef string )
{ CFStringCapitalize( string, NULL ); }

void MutableStringCapitalizeWithLocale( CFMutableStringRef string, CFLocaleRef locale )
{ CFStringCapitalize( string, locale ); }

void MutableStringLowercase( CFMutableStringRef string )
{ CFStringLowercase( string, NULL ); }

void MutableStringLowercaseWithLocale( CFMutableStringRef string, CFLocaleRef locale )
{ CFStringLowercase( string, locale ); }

void MutableStringUppercase( CFMutableStringRef string )
{ CFStringUppercase( string, NULL ); }

void MutableStringUppercaseWithLocale( CFMutableStringRef string, CFLocaleRef locale )
{ CFStringUppercase( string, locale ); }

