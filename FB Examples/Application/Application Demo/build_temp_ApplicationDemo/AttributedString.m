/*
 AttributedString.M
 
 Bernie Wylde
 */

#import "AttributedString.h"

// Class
Class AttributedStringClass( void )
{ return [NSAttributedString class]; }

// Create
CFAttributedStringRef AttributedStringWithString( CFStringRef string )
{
#if __has_feature(objc_arc)
    return (__bridge CFAttributedStringRef)[[NSAttributedString alloc] initWithString:(__bridge NSString *)string];
#else
    return (__bridge CFAttributedStringRef)[[[NSAttributedString alloc] initWithString:(__bridge NSString *)string] autorelease];
#endif
}

CFAttributedStringRef AttributedStringWithAttributes( CFStringRef string, CFDictionaryRef attributes )
{
#if __has_feature(objc_arc)
    return (__bridge CFAttributedStringRef)[[NSAttributedString alloc] initWithString:(__bridge NSString *)string attributes:(__bridge NSDictionary *)attributes];
#else
    return (__bridge CFAttributedStringRef)[[[NSAttributedString alloc] initWithString:(__bridge NSString *)string attributes:(__bridge NSDictionary *)attributes] autorelease];
#endif
}

CFAttributedStringRef AttributedStringWithAttributedString( CFAttributedStringRef aString )
{
#if __has_feature(objc_arc)
    return (__bridge CFAttributedStringRef)[[NSAttributedString alloc] initWithAttributedString:(__bridge NSAttributedString *)aString];
#else
    return (__bridge CFAttributedStringRef)[[[NSAttributedString alloc] initWithAttributedString:(__bridge NSAttributedString *)aString] autorelease];
#endif
}

CFAttributedStringRef AttributedStringWithData( CFDataRef dta, CFDictionaryRef options, CFDictionaryRef *attributes, NSError **err )
{
    NSAttributedString *aString;
    NSDictionary *tempAttributes = nil;
#if __has_feature(objc_arc)
    aString = [[NSAttributedString alloc] initWithData:(__bridge NSData *)dta options:(__bridge NSDictionary *)options documentAttributes:&tempAttributes error:err];
#else
    aString = [[[NSAttributedString alloc] initWithData:(__bridge NSData *)dta options:(__bridge NSDictionary *)options documentAttributes:&tempAttributes error:err] autorelease];
#endif
    if ( attributes ) *attributes = (__bridge CFDictionaryRef)tempAttributes;
    return (__bridge CFAttributedStringRef)aString;
}

CFAttributedStringRef AttributedStringWithDocFormat( CFDataRef dta, CFDictionaryRef *attributes )
{
    NSAttributedString *aString;
    NSDictionary *tempAttributes = nil;
#if __has_feature(objc_arc)
    aString = [[NSAttributedString alloc] initWithDocFormat:(__bridge NSData *)dta documentAttributes:&tempAttributes];
#else
    aString = [[[NSAttributedString alloc] initWithDocFormat:(__bridge NSData *)dta documentAttributes:&tempAttributes] autorelease];
#endif
    if ( attributes ) *attributes = (__bridge CFDictionaryRef)tempAttributes;
    return (__bridge CFAttributedStringRef)aString;
}

CFAttributedStringRef AttributedStringWithHTML( CFDataRef dta, CFDictionaryRef *attributes )
{
    NSAttributedString *aString;
    NSDictionary *tempAttributes = nil;
#if __has_feature(objc_arc)
    aString = [[NSAttributedString alloc] initWithHTML:(__bridge NSData *)dta documentAttributes:&tempAttributes];
#else
    aString = [[[NSAttributedString alloc] initWithHTML:(__bridge NSData *)dta documentAttributes:&tempAttributes] autorelease];
#endif
    if ( attributes ) *attributes = (__bridge CFDictionaryRef)tempAttributes;
    return (__bridge CFAttributedStringRef)aString;
}

CFAttributedStringRef AttributedStringWithHTMLBaseURL( CFDataRef dta, CFURLRef url, CFDictionaryRef *attributes )
{
    NSAttributedString *aString;
    NSDictionary *tempAttributes = nil;
#if __has_feature(objc_arc)
    aString = [[NSAttributedString alloc] initWithHTML:(__bridge NSData *)dta baseURL:(__bridge NSURL *)url documentAttributes:&tempAttributes];
#else
    aString = [[[NSAttributedString alloc] initWithHTML:(__bridge NSData *)dta baseURL:(__bridge NSURL *)url documentAttributes:&tempAttributes] autorelease];
#endif
    if ( attributes ) *attributes = (__bridge CFDictionaryRef)tempAttributes;
    return (__bridge CFAttributedStringRef)aString;
}

CFAttributedStringRef AttributedStringWithHTMLOptions( CFDataRef dta, CFDictionaryRef options, CFDictionaryRef *attributes )
{
    NSAttributedString *aString;
    NSDictionary *tempAttributes = nil;
#if __has_feature(objc_arc)
    aString = [[NSAttributedString alloc] initWithHTML:(__bridge NSData *)dta options:(__bridge NSDictionary *)options documentAttributes:&tempAttributes];
#else
    aString = [[[NSAttributedString alloc] initWithHTML:(__bridge NSData *)dta options:(__bridge NSDictionary *)options documentAttributes:&tempAttributes] autorelease];
#endif
    if ( attributes ) *attributes = (__bridge CFDictionaryRef)tempAttributes;
    return (__bridge CFAttributedStringRef)aString;
}

CFAttributedStringRef AttributedStringWithRTF( CFDataRef dta, CFDictionaryRef *attributes )
{
    NSAttributedString *aString;
    NSDictionary *tempAttributes = nil;
#if __has_feature(objc_arc)
    aString = [[NSAttributedString alloc] initWithRTF:(__bridge NSData *)dta documentAttributes:&tempAttributes];
#else
    aString = [[[NSAttributedString alloc] initWithRTF:(__bridge NSData *)dta documentAttributes:&tempAttributes] autorelease];
#endif
    if ( attributes ) *attributes = (__bridge CFDictionaryRef)tempAttributes;
    return (__bridge CFAttributedStringRef)aString;
}

CFAttributedStringRef AttributedStringWithRTFD( CFDataRef dta, CFDictionaryRef *attributes )
{
    NSAttributedString *aString;
    NSDictionary *tempAttributes = nil;
#if __has_feature(objc_arc)
    aString = [[NSAttributedString alloc] initWithRTFD:(__bridge NSData *)dta documentAttributes:&tempAttributes];
#else
    aString = [[[NSAttributedString alloc] initWithRTFD:(__bridge NSData *)dta documentAttributes:&tempAttributes] autorelease];
#endif
    if ( attributes ) *attributes = (__bridge CFDictionaryRef)tempAttributes;
    return (__bridge CFAttributedStringRef)aString;
}

CFAttributedStringRef AttributedStringWithRTFDFileWrapper( NSFileWrapper *fw, CFDictionaryRef *attributes )
{
    NSAttributedString *aString;
    NSDictionary *tempAttributes = nil;
#if __has_feature(objc_arc)
    aString = [[NSAttributedString alloc] initWithRTFDFileWrapper:fw documentAttributes:&tempAttributes];
#else
    aString = [[[NSAttributedString alloc] initWithRTFDFileWrapper:fw documentAttributes:&tempAttributes] autorelease];
#endif
    if ( attributes ) *attributes = (__bridge CFDictionaryRef)tempAttributes;
    return (__bridge CFAttributedStringRef)aString;
}

CFAttributedStringRef AttributedStringWithURL( CFURLRef url, CFDictionaryRef options, CFDictionaryRef *attributes, NSError **err )
{
    NSAttributedString *aString;
    NSDictionary *tempAttributes = nil;
#if __has_feature(objc_arc)
    aString = [[NSAttributedString alloc] initWithURL:(__bridge NSURL *)url options:(__bridge NSDictionary *)options documentAttributes:&tempAttributes error:err];
#else
    aString = [[[NSAttributedString alloc] initWithURL:(__bridge NSURL *)url options:(__bridge NSDictionary *)options documentAttributes:&tempAttributes error:err] autorelease];
#endif
    if ( attributes ) *attributes = (__bridge CFDictionaryRef)tempAttributes;
    return (__bridge CFAttributedStringRef)aString;
}

CFAttributedStringRef AttributedStringWithAttachment( NSTextAttachment *attachment )
{ return (__bridge CFAttributedStringRef)[NSAttributedString attributedStringWithAttachment:attachment]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
CFAttributedStringRef AttributedStringWithAttachmentAndAttributes( NSTextAttachment *attachment, CFDictionaryRef attributes )
{ return (__bridge CFAttributedStringRef)[NSAttributedString attributedStringWithAttachment:attachment attributes:(__bridge NSDictionary *)attributes]; }
#endif // 150000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
CFAttributedStringRef AttributedStringWithFormat( CFAttributedStringRef format, NSAttributedStringFormattingOptions options, CFLocaleRef locale, ... )
{
    va_list ap;
    va_start( ap, locale );
#if __has_feature(objc_arc)
    NSAttributedString *string = [[NSAttributedString alloc] initWithFormat:(__bridge NSAttributedString *)format options:options locale:(__bridge NSLocale *)locale arguments:ap];
#else
    NSAttributedString *string = [[[NSAttributedString alloc] initWithFormat:(__bridge NSAttributedString *)format options:options locale:(__bridge NSLocale *)locale arguments:ap] autorelease];
#endif
    va_end( ap );
    return (__bridge CFAttributedStringRef)string;
}

CFAttributedStringRef AttributedStringWithFormatAndArguments( CFAttributedStringRef format, NSAttributedStringFormattingOptions options, CFLocaleRef locale, va_list arguments )
{
#if __has_feature(objc_arc)
    return (__bridge CFAttributedStringRef)[[NSAttributedString alloc] initWithFormat:(__bridge NSAttributedString *)format options:options locale:(__bridge NSLocale *)locale arguments:arguments];
#else
    return (__bridge CFAttributedStringRef)[[[NSAttributedString alloc] initWithFormat:(__bridge NSAttributedString *)format options:options locale:(__bridge NSLocale *)locale arguments:arguments] autorelease];
#endif
}

//CFAttributedStringRef AttributedStringLocalizedWithFormat( CFAttributedStringRef format, ... );
//CFAttributedStringRef AttributedStringLocalizedWithFormatAndOptions( CFAttributedStringRef format, NSAttributedStringFormattingOptions options, ... );

CFAttributedStringRef AttributedStringWithFormatAndContext( CFAttributedStringRef format, NSAttributedStringFormattingOptions options, CFLocaleRef locale, CFDictionaryRef context, ... )
{
    va_list ap;
    va_start( ap, context );
#if __has_feature(objc_arc)
    NSAttributedString *string = [[NSAttributedString alloc] initWithFormat:(__bridge NSAttributedString *)format options:options locale:(__bridge NSLocale *)locale context:(__bridge NSDictionary *)context arguments:ap];
#else
    NSAttributedString *string = [[[NSAttributedString alloc] initWithFormat:(__bridge NSAttributedString *)format options:options locale:(__bridge NSLocale *)locale context:(__bridge NSDictionary *)context arguments:ap] autorelease];
#endif
    va_end( ap );
    return (__bridge CFAttributedStringRef)string;
}

CFAttributedStringRef AttributedStringWithFormatContextAndArguments( CFAttributedStringRef format, NSAttributedStringFormattingOptions options, CFLocaleRef locale, CFDictionaryRef context, va_list arguments )
{
#if __has_feature(objc_arc)
    return (__bridge CFAttributedStringRef)[[NSAttributedString alloc] initWithFormat:(__bridge NSAttributedString *)format options:options locale:(__bridge NSLocale *)locale context:(__bridge NSDictionary *)context arguments:arguments];
#else
    return (__bridge CFAttributedStringRef)[[[NSAttributedString alloc] initWithFormat:(__bridge NSAttributedString *)format options:options locale:(__bridge NSLocale *)locale context:(__bridge NSDictionary *)context arguments:arguments] autorelease];
#endif
}

//CFAttributedStringRef AttributedStringLocalizedWithFormatAndContext( CFAttributedStringRef format, CFDictionaryRef context, ... );
//CFAttributedStringRef AttributedStringLocalizedWithFormatOptionsAndContext( CFAttributedStringRef format, NSAttributedStringFormattingOptions options, CFDictionaryRef context, ... );

#endif// 140000

// Load from HTML
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
void AttributedStringLoadFromHTMLWithRequest( NSURLRequest *request, CFDictionaryRef options, CUI_AttributedStringLoadFromHTMLCompletionHandlerType completionHandler, void *userData )
{
#ifdef WK_EXTERN
    [NSAttributedString loadFromHTMLWithRequest:request options:(__bridge NSDictionary *)options completionHandler:^(NSAttributedString *aString, NSDictionary *attributes, NSError *error) {
        (*completionHandler)( (__bridge CFAttributedStringRef)aString, (__bridge CFDictionaryRef)attributes, error, userData );
    }];
#endif// WK_EXTERN
}

void AttributedStringLoadFromHTMLWithFileURL( CFURLRef url, CFDictionaryRef options, CUI_AttributedStringLoadFromHTMLCompletionHandlerType completionHandler, void *userData )
{
#ifdef WK_EXTERN
    [NSAttributedString loadFromHTMLWithFileURL:(__bridge NSURL *)url options:(__bridge NSDictionary *)options completionHandler:^(NSAttributedString *aString, NSDictionary *attributes, NSError *error) {
        (*completionHandler)( (__bridge CFAttributedStringRef)aString, (__bridge CFDictionaryRef)attributes, error, userData );
    }];
#endif// WK_EXTERN
}

void AttributedStringLoadFromHTMLWithString( CFStringRef string, CFDictionaryRef options, CUI_AttributedStringLoadFromHTMLCompletionHandlerType completionHandler, void *userData )
{
//#ifdef WK_EXTERN
    [NSAttributedString loadFromHTMLWithString:(__bridge NSString *)string options:(__bridge NSDictionary *)options completionHandler:^(NSAttributedString *aString, NSDictionary *attributes, NSError *error) {
        (*completionHandler)( (__bridge CFAttributedStringRef)aString, (__bridge CFDictionaryRef)attributes, error, userData );
    }];
//#endif// WK_EXTERN
}

void AttributedStringLoadFromHTMLWithData( CFDataRef dta, CFDictionaryRef options, CUI_AttributedStringLoadFromHTMLCompletionHandlerType completionHandler, void *userData )
{
#ifdef WK_EXTERN
    [NSAttributedString loadFromHTMLWithData:(__bridge NSData *)dta options:(__bridge NSDictionary *)options completionHandler:^(NSAttributedString *aString, NSDictionary *attributes, NSError *error) {
        (*completionHandler)( (__bridge CFAttributedStringRef)aString, (__bridge CFDictionaryRef)attributes, error, userData );
    }];
#endif// WK_EXTERN
}
#endif// 101500

// Character info
CFStringRef AttributedStringString( CFAttributedStringRef aString )
{ return (__bridge CFStringRef)[(__bridge NSAttributedString *)aString string]; }

NSUInteger AttributedStringLength( CFAttributedStringRef aString )
{ return [(__bridge NSAttributedString *)aString length]; }

// Attribute info
CFDictionaryRef AttributedStringAttributesAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{ return (__bridge CFDictionaryRef)[(__bridge NSAttributedString *)aString attributesAtIndex:index effectiveRange:(NSRange *)effectiveRange]; }

CFDictionaryRef AttributedStringAttributesAtIndexInRange( CFAttributedStringRef aString, NSUInteger index, CFRange *longestEffectiveRange, CFRange range )
{ return (__bridge CFDictionaryRef)[(__bridge NSAttributedString *)aString attributesAtIndex:index longestEffectiveRange:(NSRange *)longestEffectiveRange inRange:NSRangeFromCFRange(range)]; }

CFTypeRef AttributedStringAttributeAtIndex( CFAttributedStringRef aString, CFStringRef attrName, NSUInteger index, CFRange *effectiveRange )
{ return (__bridge CFTypeRef)[(__bridge NSAttributedString *)aString attribute:(__bridge NSString *)attrName atIndex:index effectiveRange:(NSRange *)effectiveRange]; }

CFTypeRef AttributedStringAttributeAtIndexInRange( CFAttributedStringRef aString, CFStringRef attrName, NSUInteger index, CFRange *longestEffectiveRange, CFRange range )
{ return (__bridge CFTypeRef)[(__bridge NSAttributedString *)aString attribute:(__bridge NSString *)attrName atIndex:index longestEffectiveRange:(NSRange *)longestEffectiveRange inRange:NSRangeFromCFRange(range)]; }

// Compare
BOOL AttributedStringIsEqual( CFAttributedStringRef aString1, CFAttributedStringRef aString2 )
{ return [(__bridge NSAttributedString *)aString1 isEqualToAttributedString:(__bridge NSAttributedString *)aString2]; }

// Substring
CFAttributedStringRef AttributedStringAttributedSubstringFromRange( CFAttributedStringRef aString, CFRange range )
{ return (__bridge CFAttributedStringRef)[(__bridge NSAttributedString *)aString attributedSubstringFromRange:NSRangeFromCFRange(range)]; }

// Enumerate
void AttributedStringEnumerateAttributeInRange( CFAttributedStringRef aString, CFStringRef attrName, CFRange range, NSAttributedStringEnumerationOptions options, CUI_AttributedStringEnumerateAttributeCallbackType fnAddress, void *userData )
{
    [(__bridge NSAttributedString *)aString enumerateAttribute:(__bridge NSString *)attrName inRange:NSRangeFromCFRange(range) options:options usingBlock:^(id value, NSRange range, BOOL *stop) {
        (*fnAddress)(aString,(__bridge CFTypeRef)value,NSRangeToCFRange(range),stop,userData);
    }];
}

void AttributedStringEnumerateAttributesInRange( CFAttributedStringRef aString, CFRange range, NSAttributedStringEnumerationOptions options, CUI_AttributedStringEnumerateAttributesCallbackType fnAddress, void *userData )
{
    [(__bridge NSAttributedString *)aString enumerateAttributesInRange:NSRangeFromCFRange(range) options:options usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        (*fnAddress)(aString,(__bridge CFDictionaryRef)attrs,NSRangeToCFRange(range),stop,userData);
    }];
}

// Font info
CFDictionaryRef AttributedStringFontAttributesInRange( CFAttributedStringRef aString, CFRange range )
{ return (__bridge CFDictionaryRef)[(__bridge NSAttributedString *)aString fontAttributesInRange:NSRangeFromCFRange(range)]; }

CFDictionaryRef AttributedStringRulerAttributesInRange( CFAttributedStringRef aString, CFRange range )
{ return (__bridge CFDictionaryRef)[(__bridge NSAttributedString *)aString rulerAttributesInRange:NSRangeFromCFRange(range)]; }

// Linguistic units
CFRange AttributedStringDoubleClickAtIndex( CFAttributedStringRef aString, NSUInteger index )
{
    NSRange range = [(__bridge NSAttributedString *)aString doubleClickAtIndex:index];
    return NSRangeToCFRange(range);
}

NSUInteger AttributedStringLineBreakBeforeIndex( CFAttributedStringRef aString, NSUInteger index, CFRange withinRange )
{ return [(__bridge NSAttributedString *)aString lineBreakBeforeIndex:index withinRange:NSRangeFromCFRange(withinRange)]; }

NSUInteger AttributedStringLineBreakByHyphenatingBeforeIndex( CFAttributedStringRef aString, NSUInteger index, CFRange withinRange )
{ return [(__bridge NSAttributedString *)aString lineBreakByHyphenatingBeforeIndex:index withinRange:NSRangeFromCFRange(withinRange)]; }

NSUInteger AttributedStringNextWordFromIndex( CFAttributedStringRef aString, NSUInteger index, BOOL forward )
{ return [(__bridge NSAttributedString *)aString nextWordFromIndex:index forward:forward]; }

// Ranges
NSInteger AttributedStringItemNumberInTextList( CFAttributedStringRef aString, NSTextList *list, NSUInteger index )
{ return [(__bridge NSAttributedString *)aString itemNumberInTextList:list atIndex:index]; }

CFRange AttributedStringRangeOfTextBlock( CFAttributedStringRef aString, NSTextBlock *block, NSUInteger index )
{ return NSRangeToCFRange([(__bridge NSAttributedString *)aString rangeOfTextBlock:block atIndex:index]); }

CFRange AttributedStringRangeOfTextList( CFAttributedStringRef aString, NSTextList *list, NSUInteger index )
{ return NSRangeToCFRange([(__bridge NSAttributedString *)aString rangeOfTextList:list atIndex:index]); }

CFRange AttributedStringRangeOfTextTable( CFAttributedStringRef aString, NSTextTable *table, NSUInteger index )
{ return NSRangeToCFRange([(__bridge NSAttributedString *)aString rangeOfTextTable:table atIndex:index]); }

// Data
CFDataRef AttributedStringDataFromRange( CFAttributedStringRef aString, CFRange range, CFDictionaryRef attributes, NSError **err )
{ return (__bridge CFDataRef)[(__bridge NSAttributedString *)aString dataFromRange:NSRangeFromCFRange(range) documentAttributes:(__bridge NSDictionary *)attributes error:err]; }

NSFileWrapper *AttributedStringFileWrapperFromRange( CFAttributedStringRef aString, CFRange range, CFDictionaryRef attributes, NSError **err )
{ return [(__bridge NSAttributedString *)aString fileWrapperFromRange:NSRangeFromCFRange(range) documentAttributes:(__bridge NSDictionary *)attributes error:err]; }

CFDataRef AttributedStringDocFormatFromRange( CFAttributedStringRef aString, CFRange range, CFDictionaryRef attributes )
{ return (__bridge CFDataRef)[(__bridge NSAttributedString *)aString docFormatFromRange:NSRangeFromCFRange(range) documentAttributes:(__bridge NSDictionary *)attributes]; }

CFDataRef AttributedStringRTFFromRange( CFAttributedStringRef aString, CFRange range, CFDictionaryRef attributes )
{ return (__bridge CFDataRef)[(__bridge NSAttributedString *)aString RTFFromRange:NSRangeFromCFRange(range) documentAttributes:(__bridge NSDictionary *)attributes]; }

CFDataRef AttributedStringRTFDFromRange( CFAttributedStringRef aString, CFRange range, CFDictionaryRef attributes )
{ return (__bridge CFDataRef)[(__bridge NSAttributedString *)aString RTFDFromRange:NSRangeFromCFRange(range) documentAttributes:(__bridge NSDictionary *)attributes]; }

NSFileWrapper *AttributedStringRTFDFileWrapperFromRange( CFAttributedStringRef aString, CFRange range, CFDictionaryRef attributes )
{ return [(__bridge NSAttributedString *)aString RTFDFileWrapperFromRange:NSRangeFromCFRange(range) documentAttributes:(__bridge NSDictionary *)attributes]; }

// Automatic grammar agreement
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
CFAttributedStringRef AttributedStringByInflectingString( CFAttributedStringRef aString )
{
    if ( @available(macOS 12.0,*) ) {
        return (__bridge CFAttributedStringRef)[(__bridge NSAttributedString *)aString attributedStringByInflectingString];
    } else {
        return nil;
    }
}
#endif // 120000

// Draw
void AttributedStringDrawAtPoint( CFAttributedStringRef aString, CGPoint pt )
{ [(__bridge NSAttributedString *)aString drawAtPoint:NSPointFromCGPoint(pt)]; }

void AttributedStringDrawInRect( CFAttributedStringRef aString, CGRect r )
{ [(__bridge NSAttributedString *)aString drawInRect:NSRectFromCGRect(r)]; }

void AttributedStringDrawWithRect( CFAttributedStringRef aString, CGRect r, NSStringDrawingOptions options, NSStringDrawingContext *ctx )
{ [(__bridge NSAttributedString *)aString drawWithRect:NSRectFromCGRect(r) options:options context:ctx]; }

// Metrics
CGSize AttributedStringSize( CFAttributedStringRef aString )
{ return NSSizeToCGSize( [(__bridge NSAttributedString *)aString size] ); }

CGRect AttributedStringBoundingRectWithSize( CFAttributedStringRef aString, CGSize size, NSStringDrawingOptions options, NSStringDrawingContext *ctx )
{ return NSRectToCGRect([(__bridge NSAttributedString *)aString boundingRectWithSize:NSSizeFromCGSize(size) options:options context:ctx]); }

BOOL AttributedStringContainsAttachmentsInRange( CFAttributedStringRef aString, CFRange range )
{ return [(__bridge NSAttributedString *)aString containsAttachmentsInRange:NSRangeFromCFRange(range)]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
BOOL AttributedStringPrefersRTFDInRange( CFAttributedStringRef aString, CFRange range )
{ return [(__bridge NSAttributedString *)aString prefersRTFDInRange:NSRangeFromCFRange(range)]; }
#endif // 150000

// Data sources
CFArrayRef AttributedStringTextTypes( void )
{ return (__bridge CFArrayRef)[NSAttributedString textTypes]; }

CFArrayRef AttributedStringTextUnfilteredTypes( void )
{ return (__bridge CFArrayRef)[NSAttributedString textUnfilteredTypes]; }


#pragma mark - convenience
// - font -
NSFont *AttributedStringFontAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{ return [(__bridge NSMutableAttributedString *)aString attribute:NSFontAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange]; }

// - stroke -
CGFloat AttributedStringStrokeWidthAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{ return [[(__bridge NSMutableAttributedString *)aString attribute:NSStrokeWidthAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange] doubleValue]; }

NSColor *AttributedStringStrokeColorAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{ return [(__bridge NSMutableAttributedString *)aString attribute:NSStrokeColorAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange]; }

// - foreground color -
NSColor *AttributedStringForegroundColorAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{ return [(__bridge NSMutableAttributedString *)aString attribute:NSForegroundColorAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange]; }

// - background color -
NSColor *AttributedStringBackgroundColorAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{ return [(__bridge NSMutableAttributedString *)aString attribute:NSBackgroundColorAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange]; }

// - shadow -
NSShadow *AttributedStringShadowAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{ return [(__bridge NSMutableAttributedString *)aString attribute:NSShadowAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange]; }

NSColor *AttributedStringShadowColorAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{
    NSShadow *shadow = [(__bridge NSMutableAttributedString *)aString attribute:NSShadowAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange];
    return [shadow shadowColor];
}

// - underline -
NSInteger AttributedStringUnderlineAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{ return [[(__bridge NSMutableAttributedString *)aString attribute:NSUnderlineStyleAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange] integerValue]; }

NSColor *AttributedStringUnderlineColorAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{ return [(__bridge NSMutableAttributedString *)aString attribute:NSUnderlineColorAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange]; }

// - strikethrough -
NSInteger AttributedStringStrikethroughAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{ return [[(__bridge NSMutableAttributedString *)aString attribute:NSStrikethroughStyleAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange] integerValue]; }

NSColor *AttributedStringStrikethroughColorAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{ return [(__bridge NSMutableAttributedString *)aString attribute:NSStrikethroughColorAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange]; }

// - superscript -
NSInteger AttributedStringSuperscriptAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{ return [[(__bridge NSMutableAttributedString *)aString attribute:NSSuperscriptAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange] integerValue]; }

// - expansion -
float AttributedStringExpansionAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{ return [[(__bridge NSMutableAttributedString *)aString attribute:NSExpansionAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange] floatValue]; }

// - olbliqueness -
float AttributedStringObliquenessAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{ return [[(__bridge NSMutableAttributedString *)aString attribute:NSObliquenessAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange] floatValue]; }

// - link -
CFTypeRef AttributedStringLinkAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{ return (__bridge CFTypeRef)[(__bridge NSMutableAttributedString *)aString attribute:NSLinkAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange]; }

// - baseline offset -
float AttributedStringBaselineOffsetAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{ return [[(__bridge NSMutableAttributedString *)aString attribute:NSBaselineOffsetAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange] floatValue]; }

// - kerning -
CGFloat AttributedStringKerningAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{ return [[(__bridge NSMutableAttributedString *)aString attribute:NSKernAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange] doubleValue]; }

// alignment
NSTextAlignment AttributedStringParagraphAlignmentAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{ return [[(__bridge NSMutableAttributedString *)aString attribute:NSObliquenessAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange] integerValue]; }

// first line head indent
CGFloat AttributedStringFirstLineHeadIndentAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{
    NSParagraphStyle *style = [(__bridge NSMutableAttributedString *)aString attribute:NSParagraphStyleAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange];
    return [style firstLineHeadIndent];
}

// head indent
CGFloat AttributedStringHeadIndentAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{
    NSParagraphStyle *style = [(__bridge NSMutableAttributedString *)aString attribute:NSParagraphStyleAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange];
    return [style headIndent];
}

// tail indent
CGFloat AttributedStringTailIndentAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{
    NSParagraphStyle *style = [(__bridge NSMutableAttributedString *)aString attribute:NSParagraphStyleAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange];
    return [style tailIndent];
}

// line break mode
NSLineBreakMode AttributedStringLineBreakModeAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{
    NSParagraphStyle *style = [(__bridge NSMutableAttributedString *)aString attribute:NSParagraphStyleAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange];
    return [style lineBreakMode];
}

// maximum line height
CGFloat AttributedStringMaximumLineHeightAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{
    NSParagraphStyle *style = [(__bridge NSMutableAttributedString *)aString attribute:NSParagraphStyleAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange];
    return [style maximumLineHeight];
}

// minimum line height
CGFloat AttributedStringMinimumLineHeightAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{
    NSParagraphStyle *style = [(__bridge NSMutableAttributedString *)aString attribute:NSParagraphStyleAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange];
    return [style minimumLineHeight];
}

// line spacing
CGFloat AttributedStringLineSpacingAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{
    NSParagraphStyle *style = [(__bridge NSMutableAttributedString *)aString attribute:NSParagraphStyleAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange];
    return [style lineSpacing];
}

// paragraph spacing
CGFloat AttributedStringParagraphSpacingAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{
    NSParagraphStyle *style = [(__bridge NSMutableAttributedString *)aString attribute:NSParagraphStyleAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange];
    return [style paragraphSpacing];
}

// paragraph spacing before
CGFloat AttributedStringParagraphSpacingBeforeAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{
    NSParagraphStyle *style = [(__bridge NSMutableAttributedString *)aString attribute:NSParagraphStyleAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange];
    return [style paragraphSpacingBefore];
}

// line height multiple
CGFloat AttributedStringLineHeightMultipleAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{
    NSParagraphStyle *style = [(__bridge NSMutableAttributedString *)aString attribute:NSParagraphStyleAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange];
    return [style lineHeightMultiple];
}

// tab stops
CFArrayRef AttributedStringTabStopsAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{
    NSParagraphStyle *style = [(__bridge NSMutableAttributedString *)aString attribute:NSParagraphStyleAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange];
    return (__bridge CFArrayRef)[style tabStops];
}

// default tab interval
CGFloat AttributedStringDefaultTabIntervalAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{
    NSParagraphStyle *style = [(__bridge NSMutableAttributedString *)aString attribute:NSParagraphStyleAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange];
    return [style defaultTabInterval];
}

// header level
NSInteger AttributedStringHeaderLevelAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange )
{
    NSParagraphStyle *style = [(__bridge NSMutableAttributedString *)aString attribute:NSParagraphStyleAttributeName atIndex:index effectiveRange:(NSRange *)effectiveRange];
    return [style headerLevel];
}








#pragma mark - Mutable attributed string
// Class
Class MutableAttributedStringClass( void )
{ return [NSMutableAttributedString class]; }

// - create -
CFMutableAttributedStringRef MutableAttributedStringNew( void )
{
#if __has_feature(objc_arc)
    return (__bridge CFMutableAttributedStringRef)[NSMutableAttributedString new];
#else
    return (__bridge CFMutableAttributedStringRef)[[NSMutableAttributedString new] autorelease];
#endif
}

CFMutableAttributedStringRef MutableAttributedStringWithString( CFStringRef string )
{
#if __has_feature(objc_arc)
    return (__bridge CFMutableAttributedStringRef)[[NSMutableAttributedString alloc] initWithString:(__bridge NSString *)string];
#else
    return (__bridge CFMutableAttributedStringRef)[[[NSMutableAttributedString alloc] initWithString:(__bridge NSString *)string] autorelease];
#endif
}

CFMutableAttributedStringRef MutableAttributedStringWithAttributes( CFStringRef string, CFDictionaryRef attributes )
{
#if __has_feature(objc_arc)
    return (__bridge CFMutableAttributedStringRef)[[NSMutableAttributedString alloc] initWithString:(__bridge NSString *)string attributes:(__bridge NSDictionary *)attributes];
#else
    return (__bridge CFMutableAttributedStringRef)[[[NSMutableAttributedString alloc] initWithString:(__bridge NSString *)string attributes:(__bridge NSDictionary *)attributes] autorelease];
#endif
}

CFMutableAttributedStringRef MutableAttributedStringWithAttributedString( CFAttributedStringRef aString )
{
#if __has_feature(objc_arc)
    return (__bridge CFMutableAttributedStringRef)[[NSMutableAttributedString alloc] initWithAttributedString:(__bridge NSAttributedString *)aString];
#else
    return (__bridge CFMutableAttributedStringRef)[[[NSMutableAttributedString alloc] initWithAttributedString:(__bridge NSAttributedString *)aString] autorelease];
#endif
}

CFMutableAttributedStringRef MutableAttributedStringWithData( CFDataRef dta, CFDictionaryRef options, CFDictionaryRef *attributes, NSError **err )
{
    NSMutableAttributedString *aString;
    NSDictionary *tempAttributes = nil;
#if __has_feature(objc_arc)
    aString = [[NSMutableAttributedString alloc] initWithData:(__bridge NSData *)dta options:(__bridge NSDictionary *)options documentAttributes:&tempAttributes error:err];
#else
    aString = [[[NSMutableAttributedString alloc] initWithData:(__bridge NSData *)dta options:(__bridge NSDictionary *)options documentAttributes:&tempAttributes error:err] autorelease];
#endif
    if ( attributes ) *attributes = (__bridge CFDictionaryRef)tempAttributes;
    return (__bridge CFMutableAttributedStringRef)aString;
}

CFMutableAttributedStringRef MutableAttributedStringWithDocFormat( CFDataRef dta, CFDictionaryRef *attributes )
{
    NSMutableAttributedString *aString;
    NSDictionary *tempAttributes = nil;
#if __has_feature(objc_arc)
    aString = [[NSMutableAttributedString alloc] initWithDocFormat:(__bridge NSData *)dta documentAttributes:&tempAttributes];
#else
    aString = [[[NSMutableAttributedString alloc] initWithDocFormat:(__bridge NSData *)dta documentAttributes:&tempAttributes] autorelease];
#endif
    if ( attributes ) *attributes = (__bridge CFDictionaryRef)tempAttributes;
    return (__bridge CFMutableAttributedStringRef)aString;
}

CFMutableAttributedStringRef MutableAttributedStringWithHTML( CFDataRef dta, CFDictionaryRef *attributes )
{
    NSMutableAttributedString *aString;
    NSDictionary *tempAttributes = nil;
#if __has_feature(objc_arc)
    aString = [[NSMutableAttributedString alloc] initWithHTML:(__bridge NSData *)dta documentAttributes:&tempAttributes];
#else
    aString = [[[NSMutableAttributedString alloc] initWithHTML:(__bridge NSData *)dta documentAttributes:&tempAttributes] autorelease];
#endif
    if ( attributes ) *attributes = (__bridge CFDictionaryRef)tempAttributes;
    return (__bridge CFMutableAttributedStringRef)aString;
}

CFMutableAttributedStringRef MutableAttributedStringWithHTMLBaseURL( CFDataRef dta, CFURLRef url, CFDictionaryRef *attributes )
{
    NSMutableAttributedString *aString;
    NSDictionary *tempAttributes = nil;
#if __has_feature(objc_arc)
    aString = [[NSMutableAttributedString alloc] initWithHTML:(__bridge NSData *)dta baseURL:(__bridge NSURL *)url documentAttributes:&tempAttributes];
#else
    aString = [[[NSMutableAttributedString alloc] initWithHTML:(__bridge NSData *)dta baseURL:(__bridge NSURL *)url documentAttributes:&tempAttributes] autorelease];
#endif
    if ( attributes ) *attributes = (__bridge CFDictionaryRef)tempAttributes;
    return (__bridge CFMutableAttributedStringRef)aString;
}

CFMutableAttributedStringRef MutableAttributedStringWithHTMLOptions( CFDataRef dta, CFDictionaryRef options, CFDictionaryRef *attributes )
{
    NSMutableAttributedString *aString;
    NSDictionary *tempAttributes = nil;
#if __has_feature(objc_arc)
    aString = [[NSMutableAttributedString alloc] initWithHTML:(__bridge NSData *)dta options:(__bridge NSDictionary *)options documentAttributes:&tempAttributes];
#else
    aString = [[[NSMutableAttributedString alloc] initWithHTML:(__bridge NSData *)dta options:(__bridge NSDictionary *)options documentAttributes:&tempAttributes] autorelease];
#endif
    if ( attributes ) *attributes = (__bridge CFDictionaryRef)tempAttributes;
    return (__bridge CFMutableAttributedStringRef)aString;
}

CFMutableAttributedStringRef MutableAttributedStringWithRTF( CFDataRef dta, CFDictionaryRef *attributes )
{
    NSMutableAttributedString *aString;
    NSDictionary *tempAttributes = nil;
#if __has_feature(objc_arc)
    aString = [[NSMutableAttributedString alloc] initWithRTF:(__bridge NSData *)dta documentAttributes:&tempAttributes];
#else
    aString = [[[NSMutableAttributedString alloc] initWithRTF:(__bridge NSData *)dta documentAttributes:&tempAttributes] autorelease];
#endif
    if ( attributes ) *attributes = (__bridge CFDictionaryRef)tempAttributes;
    return (__bridge CFMutableAttributedStringRef)aString;
}

CFMutableAttributedStringRef MutableAttributedStringWithRTFD( CFDataRef dta, CFDictionaryRef *attributes )
{
    NSMutableAttributedString *aString;
    NSDictionary *tempAttributes = nil;
#if __has_feature(objc_arc)
    aString = [[NSMutableAttributedString alloc] initWithRTFD:(__bridge NSData *)dta documentAttributes:&tempAttributes];
#else
    aString = [[[NSMutableAttributedString alloc] initWithRTFD:(__bridge NSData *)dta documentAttributes:&tempAttributes] autorelease];
#endif
    if ( attributes ) *attributes = (__bridge CFDictionaryRef)tempAttributes;
    return (__bridge CFMutableAttributedStringRef)aString;
}

CFMutableAttributedStringRef MutableAttributedStringWithRTFDFileWrapper( NSFileWrapper *fw, CFDictionaryRef *attributes )
{
    NSMutableAttributedString *aString;
    NSDictionary *tempAttributes = nil;
#if __has_feature(objc_arc)
    aString = [[NSMutableAttributedString alloc] initWithRTFDFileWrapper:fw documentAttributes:&tempAttributes];
#else
    aString = [[[NSMutableAttributedString alloc] initWithRTFDFileWrapper:fw documentAttributes:&tempAttributes] autorelease];
#endif
    if ( attributes ) *attributes = (__bridge CFDictionaryRef)tempAttributes;
    return (__bridge CFMutableAttributedStringRef)aString;
}

CFMutableAttributedStringRef MutableAttributedStringWithURL( CFURLRef url, CFDictionaryRef options, CFDictionaryRef *attributes, NSError **err )
{
    NSMutableAttributedString *aString;
    NSDictionary *tempAttributes = nil;
#if __has_feature(objc_arc)
    aString = [[NSMutableAttributedString alloc] initWithURL:(__bridge NSURL *)url options:(__bridge NSDictionary *)options documentAttributes:&tempAttributes error:err];
#else
    aString = [[[NSMutableAttributedString alloc] initWithURL:(__bridge NSURL *)url options:(__bridge NSDictionary *)options documentAttributes:&tempAttributes error:err] autorelease];
#endif
    if ( attributes ) *attributes = (__bridge CFDictionaryRef)tempAttributes;
    return (__bridge CFMutableAttributedStringRef)aString;
}

CFMutableAttributedStringRef MutableAttributedStringWithAttachment( NSTextAttachment *attachment )
{ return (__bridge CFMutableAttributedStringRef)[NSMutableAttributedString attributedStringWithAttachment:attachment]; }

// Character info
CFMutableStringRef MutableAttributedStringMutableString( CFMutableAttributedStringRef aString )
{ return (__bridge CFMutableStringRef)[(__bridge NSMutableAttributedString *)aString mutableString]; }

// Change characters
void MutableAttributedStringReplaceCharactersInRange( CFMutableAttributedStringRef aString, CFStringRef string, CFRange range )
{ [(__bridge NSMutableAttributedString *)aString replaceCharactersInRange:NSRangeFromCFRange(range) withString:(__bridge NSString *)string]; }

void MutableAttributedStringDeleteCharactersInRange( CFMutableAttributedStringRef aString, CFRange range )
{ [(__bridge NSMutableAttributedString *)aString deleteCharactersInRange:NSRangeFromCFRange(range)]; }

// Change attributes
void MutableAttributedStringSetAttributesInRange( CFMutableAttributedStringRef aString, CFDictionaryRef attrs, CFRange range )
{ [(__bridge NSMutableAttributedString *)aString setAttributes:(__bridge NSDictionary *)attrs range:NSRangeFromCFRange(range)]; }

void MutableAttributedStringAddAttributeInRange( CFMutableAttributedStringRef aString, CFStringRef name, CFTypeRef value, CFRange range )
{ [(__bridge NSMutableAttributedString *)aString addAttribute:(__bridge NSString *)name value:(__bridge id)value range:NSRangeFromCFRange(range)]; }

void MutableAttributedStringAddAttributesInRange( CFMutableAttributedStringRef aString, CFDictionaryRef attrs, CFRange range )
{ [(__bridge NSMutableAttributedString *)aString addAttributes:(__bridge NSDictionary *)attrs range:NSRangeFromCFRange(range)]; }

void MutableAttributedStringRemoveAttributeInRange( CFMutableAttributedStringRef aString, CFStringRef name, CFRange range )
{ [(__bridge NSMutableAttributedString *)aString removeAttribute:(__bridge NSString *)name range:NSRangeFromCFRange(range)]; }

void MutableAttributedStringApplyFontTraitsInRange( CFMutableAttributedStringRef aString, NSFontTraitMask traitMask, CFRange range )
{ [(__bridge NSMutableAttributedString *)aString applyFontTraits:traitMask range:NSRangeFromCFRange(range)]; }

void MutableAttributedStringSetAlignmentInRange( CFMutableAttributedStringRef aString, NSTextAlignment alignment, CFRange range )
{ [(__bridge NSMutableAttributedString *)aString setAlignment:alignment range:NSRangeFromCFRange(range)]; }

void MutableAttributedStringSetBaseWritingDirectionInRange( CFMutableAttributedStringRef aString, NSWritingDirection value, CFRange range )
{ [(__bridge NSMutableAttributedString *)aString setBaseWritingDirection:value range:NSRangeFromCFRange(range)]; }

void MutableAttributedStringSubscriptRange( CFMutableAttributedStringRef aString, CFRange range )
{ [(__bridge NSMutableAttributedString *)aString subscriptRange:NSRangeFromCFRange(range)]; }

void MutableAttributedStringSuperscriptRange( CFMutableAttributedStringRef aString, CFRange range )
{ [(__bridge NSMutableAttributedString *)aString superscriptRange:NSRangeFromCFRange(range)]; }

void MutableAttributedStringUnscriptRange( CFMutableAttributedStringRef aString, CFRange range )
{ [(__bridge NSMutableAttributedString *)aString unscriptRange:NSRangeFromCFRange(range)]; }

// Change characters and attributes
void MutableAttributedStringAppendAttributedString( CFMutableAttributedStringRef aString, CFAttributedStringRef attrString )
{ [(__bridge NSMutableAttributedString *)aString appendAttributedString:(__bridge NSAttributedString *)attrString]; }

void MutableAttributedStringInsertAttributedString( CFMutableAttributedStringRef aString, CFAttributedStringRef attrString, NSUInteger index )
{ [(__bridge NSMutableAttributedString *)aString insertAttributedString:(__bridge NSAttributedString *)attrString atIndex:index]; }

void MutableAttributedStringReplaceCharactersInRangeWithAttributedString( CFMutableAttributedStringRef aString, CFRange range, CFAttributedStringRef attrString )
{ [(__bridge NSMutableAttributedString *)aString replaceCharactersInRange:NSRangeFromCFRange(range) withAttributedString:(__bridge NSAttributedString *)attrString]; }

void MutableAttributedStringSetAttributedString( CFMutableAttributedStringRef aString, CFAttributedStringRef attrString )
{ [(__bridge NSMutableAttributedString *)aString setAttributedString:(__bridge NSAttributedString *)attrString]; }

// Grouping changes
void MutableAttributedStringBeginEditing( CFMutableAttributedStringRef aString )
{ [(__bridge NSMutableAttributedString *)aString beginEditing]; }

void MutableAttributedStringEndEditing( CFMutableAttributedStringRef aString )
{ [(__bridge NSMutableAttributedString *)aString endEditing]; }

// Update attachment contents

// Fix attributes after changes
void MutableAttributedStringFixAttributesInRange( CFMutableAttributedStringRef aString, CFRange range )
{ [(__bridge NSMutableAttributedString *)aString fixAttributesInRange:NSRangeFromCFRange(range)]; }

void MutableAttributedStringFixAttachmentAttributeInRange( CFMutableAttributedStringRef aString, CFRange range )
{ [(__bridge NSMutableAttributedString *)aString fixAttachmentAttributeInRange:NSRangeFromCFRange(range)]; }

void MutableAttributedStringFixFontAttributeInRange( CFMutableAttributedStringRef aString, CFRange range )
{ [(__bridge NSMutableAttributedString *)aString fixFontAttributeInRange:NSRangeFromCFRange(range)]; }

void MutableAttributedStringFixParagraphStyleAttributeInRange( CFMutableAttributedStringRef aString, CFRange range )
{ [(__bridge NSMutableAttributedString *)aString fixParagraphStyleAttributeInRange:NSRangeFromCFRange(range)]; }

// Read content
BOOL MutableAttributedStringReadFromData( CFMutableAttributedStringRef aString, CFDataRef dta, CFDictionaryRef options, CFDictionaryRef *docAttributes, NSError **err )
{
    NSDictionary *tempAttributes = nil;
    BOOL flag = [(__bridge NSMutableAttributedString *)aString readFromData:(__bridge NSData *)dta options:(__bridge NSDictionary *)options documentAttributes:&tempAttributes error:err];
    if ( docAttributes ) *docAttributes = (__bridge CFDictionaryRef)tempAttributes;
    return flag;
}

BOOL MutableAttributedStringReadFromURL( CFMutableAttributedStringRef aString, CFURLRef url, CFDictionaryRef options, CFDictionaryRef *docAttributes, NSError **err )
{
    NSDictionary *tempAttributes = nil;
    BOOL flag = [(__bridge NSMutableAttributedString *)aString readFromURL:(__bridge NSURL *)url options:(__bridge NSDictionary *)options documentAttributes:&tempAttributes error:err];
    if ( docAttributes ) *docAttributes = (__bridge CFDictionaryRef)tempAttributes;
    return flag;
}




// -- convenience --
// sring
void MutableAttributedStringSetString( CFMutableAttributedStringRef as, CFStringRef string )
{ MutableAttributedStringReplaceCharactersInRange( as, string, CFRangeMake(0,AttributedStringLength( as )) ); }

// append
void MutableAttributedStringAppendCharacters( CFMutableAttributedStringRef as, CFStringRef string )
{ [(__bridge NSMutableAttributedString *)as replaceCharactersInRange:NSMakeRange([(__bridge NSMutableAttributedString *)as length],0) withString:(__bridge NSString *)string]; }

// - font -
void MutableAttributedStringSetFontInRange( CFMutableAttributedStringRef aString, NSFont *font, CFRange range )
{ [(__bridge NSMutableAttributedString *)aString addAttribute:NSFontAttributeName value:font range:NSRangeFromCFRange(range)]; }

void MutableAttributedStringSetFont( CFMutableAttributedStringRef aString, NSFont *font )
{ MutableAttributedStringSetFontInRange( aString, font, CFRangeMake(0,CFAttributedStringGetLength(aString)) ); }

void MutableAttributedStringSetFontWithNameInRange( CFMutableAttributedStringRef as, CFStringRef name, CGFloat size, CFRange range )
{ [(__bridge NSMutableAttributedString *)as addAttribute:NSFontAttributeName value:[NSFont fontWithName:(__bridge NSString *)name size:size] range:NSRangeFromCFRange(range)]; }

void MutableAttributedStringSetFontWithName( CFMutableAttributedStringRef as, CFStringRef name, CGFloat size )
{ MutableAttributedStringSetFontWithNameInRange( as, name, size, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// alignment
void MutableAttributedStringSetAlignment( CFMutableAttributedStringRef as, NSTextAlignment alignment )
{ MutableAttributedStringSetAlignmentInRange( as, alignment, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// - stroke -
void MutableAttributedStringSetStrokeWidthInRange( CFMutableAttributedStringRef as, CGFloat width, CFRange range )
{ [(__bridge NSMutableAttributedString *)as addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithDouble:width] range:NSRangeFromCFRange(range)]; }

void MutableAttributedStringSetStrokeWidth( CFMutableAttributedStringRef as, CGFloat width )
{ MutableAttributedStringSetStrokeWidthInRange( as, width, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

void MutableAttributedStringSetStrokeColorInRange( CFMutableAttributedStringRef as, NSColor *col, CFRange range )
{ [(__bridge NSMutableAttributedString *)as addAttribute:NSStrokeColorAttributeName value:col range:NSRangeFromCFRange(range)]; }

void MutableAttributedStringSetStrokeColor( CFMutableAttributedStringRef as, NSColor *col )
{ MutableAttributedStringSetStrokeColorInRange( as, col, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// - foreground color -
void MutableAttributedStringSetForegroundColorInRange( CFMutableAttributedStringRef as, NSColor *col, CFRange range )
{ [(__bridge NSMutableAttributedString *)as addAttribute:NSForegroundColorAttributeName value:col range:NSRangeFromCFRange(range)]; }

void MutableAttributedStringSetForegroundColor( CFMutableAttributedStringRef as, NSColor *col )
{ MutableAttributedStringSetForegroundColorInRange( as, col, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// - background color -
void MutableAttributedStringSetBackgroundColorInRange( CFMutableAttributedStringRef as, NSColor *col, CFRange range )
{ [(__bridge NSMutableAttributedString *)as addAttribute:NSBackgroundColorAttributeName value:col range:NSRangeFromCFRange(range)]; }

void MutableAttributedStringSetBackgroundColor( CFMutableAttributedStringRef as, NSColor *col )
{ MutableAttributedStringSetBackgroundColorInRange( as, col, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// - shadow -
void MutableAttributedStringSetShadowInRange( CFMutableAttributedStringRef as, CGSize offset, CGFloat blur, CFRange range )
{
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowOffset:NSSizeFromCGSize(offset)];
    [shadow setShadowBlurRadius:blur];
    [(__bridge NSMutableAttributedString *)as addAttribute:NSShadowAttributeName value:shadow range:NSRangeFromCFRange(range)];
#if !__has_feature(objc_arc)
    [shadow release];
#endif
}

void MutableAttributedStringSetShadow( CFMutableAttributedStringRef as, CGSize offset, CGFloat blur )
{ MutableAttributedStringSetShadowInRange( as, offset, blur, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

void MutableAttributedStringSetShadowColorInRange( CFMutableAttributedStringRef as, NSColor *col, CFRange range )
{
    NSShadow *shadow = [(__bridge NSMutableAttributedString *)as attribute:NSShadowAttributeName atIndex:range.location effectiveRange:nil];
    if ( shadow ) {
        [shadow setShadowColor:col];
    } else {
        shadow = [[NSShadow alloc] init];
        [shadow setShadowColor:col];
        [(__bridge NSMutableAttributedString *)as addAttribute:NSShadowAttributeName value:shadow range:NSRangeFromCFRange(range)];
#if !__has_feature(objc_arc)
        [shadow release];
#endif
    }
}

void MutableAttributedStringSetShadowColor( CFMutableAttributedStringRef as, NSColor *col )
{ MutableAttributedStringSetShadowColorInRange( as, col, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// - underline -
void MutableAttributedStringSetUnderlineInRange( CFMutableAttributedStringRef as, NSInteger style, CFRange range )
{ [(__bridge NSMutableAttributedString *)as addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:style] range:NSRangeFromCFRange(range)]; }

void MutableAttributedStringSetUnderline( CFMutableAttributedStringRef as, NSInteger style )
{ MutableAttributedStringSetUnderlineInRange( as, style, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

void MutableAttributedStringSetUnderlineColorInRange( CFMutableAttributedStringRef as, NSColor *col, CFRange range )
{ [(__bridge NSMutableAttributedString *)as addAttribute:NSUnderlineColorAttributeName value:col range:NSRangeFromCFRange(range)]; }

void MutableAttributedStringSetUnderlineColor( CFMutableAttributedStringRef as, NSColor *col )
{ MutableAttributedStringSetUnderlineColorInRange( as, col, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// - strikethrough -
void MutableAttributedStringSetStrikethroughInRange( CFMutableAttributedStringRef as, NSInteger style, CFRange range )
{ [(__bridge NSMutableAttributedString *)as addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:style] range:NSRangeFromCFRange(range)]; }

void MutableAttributedStringSetStrikethrough( CFMutableAttributedStringRef as, NSInteger style )
{ MutableAttributedStringSetStrikethroughInRange( as, style, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

void MutableAttributedStringSetStrikethroughColorInRange( CFMutableAttributedStringRef as, NSColor *col, CFRange range )
{ [(__bridge NSMutableAttributedString *)as addAttribute:NSStrikethroughColorAttributeName value:col range:NSRangeFromCFRange(range)]; }

void MutableAttributedStringSetStrikethroughColor( CFMutableAttributedStringRef as, NSColor *col )
{ MutableAttributedStringSetStrikethroughColorInRange( as, col, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// - superscript -
void MutableAttributedStringSetSuperscriptInRange( CFMutableAttributedStringRef as, NSInteger value, CFRange range )
{ [(__bridge NSMutableAttributedString *)as addAttribute:NSSuperscriptAttributeName value:[NSNumber numberWithInteger:value] range:NSRangeFromCFRange(range)]; }

void MutableAttributedStringSetSuperscript( CFMutableAttributedStringRef as, NSInteger value )
{ MutableAttributedStringSetSuperscriptInRange( as, value, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// - expansion -
void MutableAttributedStringSetExpansionInRange( CFMutableAttributedStringRef as, float value, CFRange range )
{ [(__bridge NSMutableAttributedString *)as addAttribute:NSExpansionAttributeName value:[NSNumber numberWithFloat:value] range:NSRangeFromCFRange(range)]; }

void MutableAttributedStringSetExpansion( CFMutableAttributedStringRef as, float value )
{ MutableAttributedStringSetExpansionInRange( as, value, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// - olbliqueness -
void MutableAttributedStringSetObliquenessInRange( CFMutableAttributedStringRef as, float value, CFRange range )
{ [(__bridge NSMutableAttributedString *)as addAttribute:NSObliquenessAttributeName value:[NSNumber numberWithFloat:value] range:NSRangeFromCFRange(range)]; }

void MutableAttributedStringSetObliqueness( CFMutableAttributedStringRef as, float value )
{ MutableAttributedStringSetObliquenessInRange( as, value, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// - link -
void MutableAttributedStringSetLinkInRange( CFMutableAttributedStringRef as, CFTypeRef value, CFRange range )
{ [(__bridge NSMutableAttributedString *)as addAttribute:NSLinkAttributeName value:(__bridge id)value range:NSRangeFromCFRange(range)]; }

void MutableAttributedStringSetLink( CFMutableAttributedStringRef as, CFTypeRef value )
{ MutableAttributedStringSetLinkInRange( as, value, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// - baseline offset -
void MutableAttributedStringSetBaselineOffsetInRange( CFMutableAttributedStringRef as, float value, CFRange range )
{ [(__bridge NSMutableAttributedString *)as addAttribute:NSBaselineOffsetAttributeName value:[NSNumber numberWithFloat:value] range:NSRangeFromCFRange(range)]; }

void MutableAttributedStringSetBaselineOffset( CFMutableAttributedStringRef as, float value )
{ MutableAttributedStringSetBaselineOffsetInRange( as, value, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// - kerning -
void MutableAttributedStringSetKerningInRange( CFMutableAttributedStringRef as, CGFloat value, CFRange range )
{ [(__bridge NSMutableAttributedString *)as addAttribute:NSKernAttributeName value:[NSNumber numberWithDouble:value] range:NSRangeFromCFRange(range)]; }

void MutableAttributedStringSetKerning( CFMutableAttributedStringRef as, CGFloat value )
{ MutableAttributedStringSetKerningInRange( as, value, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// - paragraph style -
NSMutableParagraphStyle *CUI_AttributedStringCopyParagraphStyle( CFMutableAttributedStringRef as, CFRange range )
{
    NSParagraphStyle *style = [(__bridge NSAttributedString *)as attribute:NSParagraphStyleAttributeName atIndex:range.location effectiveRange:nil];
    if ( !style ) style = [NSParagraphStyle defaultParagraphStyle];
    return [style mutableCopy];
}

// alignment
void MutableAttributedStringSetParagraphAlignmentInRange( CFMutableAttributedStringRef as, NSTextAlignment value, CFRange range )
{
    NSMutableParagraphStyle *mutStyle = CUI_AttributedStringCopyParagraphStyle( as, range );
    [mutStyle setAlignment:value];
    [(__bridge NSMutableAttributedString *)as addAttribute:NSParagraphStyleAttributeName value:mutStyle range:NSRangeFromCFRange(range)];
#if !__has_feature(objc_arc)
    [mutStyle release];
#endif
}

void MutableAttributedStringSetParagraphAlignment( CFMutableAttributedStringRef as, NSTextAlignment value )
{ MutableAttributedStringSetParagraphAlignmentInRange( as, value, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// first line head indent
void MutableAttributedStringSetFirstLineHeadIndentInRange( CFMutableAttributedStringRef as, CGFloat value, CFRange range )
{
    NSMutableParagraphStyle *mutStyle = CUI_AttributedStringCopyParagraphStyle( as, range );
    [mutStyle setFirstLineHeadIndent:value];
    [(__bridge NSMutableAttributedString *)as addAttribute:NSParagraphStyleAttributeName value:mutStyle range:NSRangeFromCFRange(range)];
#if !__has_feature(objc_arc)
    [mutStyle release];
#endif
}

void MutableAttributedStringSetFirstLineHeadIndent( CFMutableAttributedStringRef as, CGFloat value )
{ MutableAttributedStringSetFirstLineHeadIndentInRange( as, value, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// head indent
void MutableAttributedStringSetHeadIndentInRange( CFMutableAttributedStringRef as, CGFloat value, CFRange range )
{
    NSMutableParagraphStyle *mutStyle = CUI_AttributedStringCopyParagraphStyle( as, range );
    [mutStyle setHeadIndent:value];
    [(__bridge NSMutableAttributedString *)as addAttribute:NSParagraphStyleAttributeName value:mutStyle range:NSRangeFromCFRange(range)];
#if !__has_feature(objc_arc)
    [mutStyle release];
#endif
}

void MutableAttributedStringSetHeadIndent( CFMutableAttributedStringRef as, CGFloat value )
{ MutableAttributedStringSetHeadIndentInRange( as, value, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// tail indent
void MutableAttributedStringSetTailIndentInRange( CFMutableAttributedStringRef as, CGFloat value, CFRange range )
{
    NSMutableParagraphStyle *mutStyle = CUI_AttributedStringCopyParagraphStyle( as, range );
    [mutStyle setTailIndent:value];
    [(__bridge NSMutableAttributedString *)as addAttribute:NSParagraphStyleAttributeName value:mutStyle range:NSRangeFromCFRange(range)];
#if !__has_feature(objc_arc)
    [mutStyle release];
#endif
}

void MutableAttributedStringSetTailIndent( CFMutableAttributedStringRef as, CGFloat value )
{ MutableAttributedStringSetTailIndentInRange( as, value, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// line break mode
void MutableAttributedStringSetLIneBreakModeInRange( CFMutableAttributedStringRef as, NSLineBreakMode value, CFRange range )
{
    NSMutableParagraphStyle *mutStyle = CUI_AttributedStringCopyParagraphStyle( as, range );
    [mutStyle setLineBreakMode:value];
    [(__bridge NSMutableAttributedString *)as addAttribute:NSParagraphStyleAttributeName value:mutStyle range:NSRangeFromCFRange(range)];
#if !__has_feature(objc_arc)
    [mutStyle release];
#endif
}

void MutableAttributedStringSetLIneBreakMode( CFMutableAttributedStringRef as, NSLineBreakMode value )
{ MutableAttributedStringSetLIneBreakModeInRange( as, value, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// maximum line height
void MutableAttributedStringSetMaximumLineHeightInRange( CFMutableAttributedStringRef as, CGFloat value, CFRange range )
{
    NSMutableParagraphStyle *mutStyle = CUI_AttributedStringCopyParagraphStyle( as, range );
    [mutStyle setMaximumLineHeight:value];
    [(__bridge NSMutableAttributedString *)as addAttribute:NSParagraphStyleAttributeName value:mutStyle range:NSRangeFromCFRange(range)];
#if !__has_feature(objc_arc)
    [mutStyle release];
#endif
}

void MutableAttributedStringSetMaximumLineHeight( CFMutableAttributedStringRef as, CGFloat value )
{ MutableAttributedStringSetMaximumLineHeightInRange( as, value, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// minimum line height
void MutableAttributedStringSetMinimumLineHeightInRange( CFMutableAttributedStringRef as, CGFloat value, CFRange range )
{
    NSMutableParagraphStyle *mutStyle = CUI_AttributedStringCopyParagraphStyle( as, range );
    [mutStyle setMinimumLineHeight:value];
    [(__bridge NSMutableAttributedString *)as addAttribute:NSParagraphStyleAttributeName value:mutStyle range:NSRangeFromCFRange(range)];
#if !__has_feature(objc_arc)
    [mutStyle release];
#endif
}

void MutableAttributedStringSetMinimumLineHeight( CFMutableAttributedStringRef as, CGFloat value )
{ MutableAttributedStringSetMinimumLineHeightInRange( as, value, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// line spacing
void MutableAttributedStringSetLineSpacingInRange( CFMutableAttributedStringRef as, CGFloat value, CFRange range )
{
    NSMutableParagraphStyle *mutStyle = CUI_AttributedStringCopyParagraphStyle( as, range );
    [mutStyle setLineSpacing:value];
    [(__bridge NSMutableAttributedString *)as addAttribute:NSParagraphStyleAttributeName value:mutStyle range:NSRangeFromCFRange(range)];
#if !__has_feature(objc_arc)
    [mutStyle release];
#endif
}

void MutableAttributedStringSetLineSpacing( CFMutableAttributedStringRef as, CGFloat value )
{ MutableAttributedStringSetLineSpacingInRange( as, value, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// paragraph spacing
void MutableAttributedStringSetParagraphSpacingInRange( CFMutableAttributedStringRef as, CGFloat value, CFRange range )
{
    NSMutableParagraphStyle *mutStyle = CUI_AttributedStringCopyParagraphStyle( as, range );
    [mutStyle setParagraphSpacing:value];
    [(__bridge NSMutableAttributedString *)as addAttribute:NSParagraphStyleAttributeName value:mutStyle range:NSRangeFromCFRange(range)];
#if !__has_feature(objc_arc)
    [mutStyle release];
#endif
}

void MutableAttributedStringSetParagraphSpacing( CFMutableAttributedStringRef as, CGFloat value )
{ MutableAttributedStringSetParagraphSpacingInRange( as, value, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// paragraph spacing before
void MutableAttributedStringSetParagraphSpacingBeforeInRange( CFMutableAttributedStringRef as, CGFloat value, CFRange range )
{
    NSMutableParagraphStyle *mutStyle = CUI_AttributedStringCopyParagraphStyle( as, range );
    [mutStyle setParagraphSpacingBefore:value];
    [(__bridge NSMutableAttributedString *)as addAttribute:NSParagraphStyleAttributeName value:mutStyle range:NSRangeFromCFRange(range)];
#if !__has_feature(objc_arc)
    [mutStyle release];
#endif
}

void MutableAttributedStringSetParagraphSpacingBefore( CFMutableAttributedStringRef as, CGFloat value )
{ MutableAttributedStringSetParagraphSpacingBeforeInRange( as, value, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// base writing direction
void MutableAttributedStringSetBaseWritingDirection( CFMutableAttributedStringRef as, NSWritingDirection value )
{ MutableAttributedStringSetBaseWritingDirectionInRange( as, value, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// line height multiple
void MutableAttributedStringSetLineHeightMultipleInRange( CFMutableAttributedStringRef as, CGFloat value, CFRange range )
{
    NSMutableParagraphStyle *mutStyle = CUI_AttributedStringCopyParagraphStyle( as, range );
    [mutStyle setLineHeightMultiple:value];
    [(__bridge NSMutableAttributedString *)as addAttribute:NSParagraphStyleAttributeName value:mutStyle range:NSRangeFromCFRange(range)];
#if !__has_feature(objc_arc)
    [mutStyle release];
#endif
}

void MutableAttributedStringSetLineHeightMultiple( CFMutableAttributedStringRef as, CGFloat value )
{ MutableAttributedStringSetLineHeightMultipleInRange( as, value, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// add tab stop
void MutableAttributedStringAddTabStopInRange( CFMutableAttributedStringRef as, NSTextAlignment alignment, CGFloat location, CFDictionaryRef options, CFRange range )
{
    NSMutableParagraphStyle *mutStyle = CUI_AttributedStringCopyParagraphStyle( as, range );
#if __has_feature(objc_arc)
    NSTextTab *tab = [[NSTextTab alloc] initWithTextAlignment:alignment location:location options:(__bridge NSDictionary *)options];
#else
    NSTextTab *tab = [[[NSTextTab alloc] initWithTextAlignment:alignment location:location options:(__bridge NSDictionary *)options] autorelease];
#endif
    [mutStyle addTabStop:tab];
    [(__bridge NSMutableAttributedString *)as addAttribute:NSParagraphStyleAttributeName value:mutStyle range:NSRangeFromCFRange(range)];
#if !__has_feature(objc_arc)
    [mutStyle release];
#endif
}

void MutableAttributedStringAddTabStop( CFMutableAttributedStringRef as, NSTextAlignment alignment, CGFloat location, CFDictionaryRef options )
{ MutableAttributedStringAddTabStopInRange( as, alignment, location, options, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// set tab stops
void MutableAttributedStringSetTabStopsInRange( CFMutableAttributedStringRef as, CFArrayRef tabStops, CFRange range )
{
    NSMutableParagraphStyle *mutStyle = CUI_AttributedStringCopyParagraphStyle( as, range );
    [mutStyle setTabStops:(__bridge NSArray *)tabStops];
    [(__bridge NSMutableAttributedString *)as addAttribute:NSParagraphStyleAttributeName value:mutStyle range:NSRangeFromCFRange(range)];
#if !__has_feature(objc_arc)
    [mutStyle release];
#endif
}

void MutableAttributedStringSetTabStops( CFMutableAttributedStringRef as, CFArrayRef tabStops )
{ MutableAttributedStringSetTabStopsInRange( as, tabStops, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// set default tab interval
void MutableAttributedStringSetDefaultTabIntervalInRange( CFMutableAttributedStringRef as, CGFloat interval, CFRange range )
{
    NSMutableParagraphStyle *mutStyle = CUI_AttributedStringCopyParagraphStyle( as, range );
    [mutStyle setDefaultTabInterval:interval];
    [(__bridge NSMutableAttributedString *)as addAttribute:NSParagraphStyleAttributeName value:mutStyle range:NSRangeFromCFRange(range)];
#if !__has_feature(objc_arc)
    [mutStyle release];
#endif
}

void MutableAttributedStringSetDefaultTabInterval( CFMutableAttributedStringRef as, CGFloat interval )
{ MutableAttributedStringSetDefaultTabIntervalInRange( as, interval, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }

// header level
void MutableAttributedStringSetHeaderLevelInRange( CFMutableAttributedStringRef as, NSInteger value, CFRange range )
{
    NSMutableParagraphStyle *mutStyle = CUI_AttributedStringCopyParagraphStyle( as, range );
    [mutStyle setHeaderLevel:value];
    [(__bridge NSMutableAttributedString *)as addAttribute:NSParagraphStyleAttributeName value:mutStyle range:NSRangeFromCFRange(range)];
#if !__has_feature(objc_arc)
    [mutStyle release];
#endif
}

void MutableAttributedStringSetHeaderLevel( CFMutableAttributedStringRef as, NSInteger value )
{ MutableAttributedStringSetHeaderLevelInRange( as, value, CFRangeMake(0,CFAttributedStringGetLength(as)) ); }


#pragma mark - AttributedStringMarkdownParsingOptions

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000

// Create
NSAttributedStringMarkdownParsingOptions *AttributedStringMarkdownParsingOptionsInit( void )
{
#if __has_feature(objc_arc)
    return [[NSAttributedStringMarkdownParsingOptions alloc] init];
#else
    return [[[NSAttributedStringMarkdownParsingOptions alloc] init] autorelease];
#endif
}

// Options
BOOL AttributedStringMarkdownParsingOptionsAllowsExtendedAttributes( NSAttributedStringMarkdownParsingOptions *ref )
{ return [ref allowsExtendedAttributes]; }

void AttributedStringMarkdownParsingOptionsSetAllowsExtendedAttributes( NSAttributedStringMarkdownParsingOptions *ref, BOOL flag )
{ [ref setAllowsExtendedAttributes:flag]; }

NSAttributedStringMarkdownParsingFailurePolicy AttributedStringMarkdownParsingOptionsFailurePolicy( NSAttributedStringMarkdownParsingOptions *ref )
{ return [ref failurePolicy]; }

void AttributedStringMarkdownParsingOptionsSetFailurePolicy( NSAttributedStringMarkdownParsingOptions *ref, NSAttributedStringMarkdownParsingFailurePolicy policy )
{ [ref setFailurePolicy:policy]; }

NSAttributedStringMarkdownInterpretedSyntax AttributedStringMarkdownParsingOptionsInterpretedSyntax( NSAttributedStringMarkdownParsingOptions *ref )
{ return [ref interpretedSyntax]; }

void AttributedStringMarkdownParsingOptionsSetInterpretedSyntax( NSAttributedStringMarkdownParsingOptions *ref, NSAttributedStringMarkdownInterpretedSyntax syntax )
{ [ref setInterpretedSyntax:syntax]; }

CFStringRef AttributedStringMarkdownParsingOptionsLanguageCode( NSAttributedStringMarkdownParsingOptions *ref )
{ return (__bridge CFStringRef)[ref languageCode]; }

void AttributedStringMarkdownParsingOptionsSetLanguageCode( NSAttributedStringMarkdownParsingOptions *ref, CFStringRef languageCode )
{ [ref setLanguageCode:(__bridge NSString *)languageCode]; }

#endif// 120000

#pragma mark - PresentationIntent
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000

// Create
NSPresentationIntent *PresentationIntentBlockQuoteIntentWithIdentity( NSInteger identity, NSPresentationIntent *parent )
{ return [NSPresentationIntent blockQuoteIntentWithIdentity:identity nestedInsideIntent:parent]; }

NSPresentationIntent *PresentationIntentCodeBlockIntentWithIdentity( NSInteger identity, CFStringRef languageHint, NSPresentationIntent *parent )
{ return [NSPresentationIntent codeBlockIntentWithIdentity:identity languageHint:(__bridge NSString *)languageHint nestedInsideIntent:parent]; }

NSPresentationIntent *PresentationIntentHeaderIntentWithIdentity( NSInteger identity, NSInteger level, NSPresentationIntent *parent )
{ return [NSPresentationIntent headerIntentWithIdentity:identity level:level nestedInsideIntent:parent]; }

NSPresentationIntent *PresentationIntentListItemIntentWithIdentity( NSInteger identity, NSInteger ordinal, NSPresentationIntent *parent )
{ return [NSPresentationIntent listItemIntentWithIdentity:identity ordinal:ordinal nestedInsideIntent:parent]; }

NSPresentationIntent *PresentationIntentOrderedListIntentWithIdentity( NSInteger identity, NSPresentationIntent *parent )
{ return [NSPresentationIntent orderedListIntentWithIdentity:identity nestedInsideIntent:parent]; }

NSPresentationIntent *PresentationIntentParagraphIntentWithIdentity( NSInteger identity, NSPresentationIntent *parent )
{ return [NSPresentationIntent paragraphIntentWithIdentity:identity nestedInsideIntent:parent]; }

NSPresentationIntent *PresentationIntentTableCellIntentWithIdentity( NSInteger identity, NSInteger column, NSPresentationIntent *parent )
{ return [NSPresentationIntent tableCellIntentWithIdentity:identity column:column nestedInsideIntent:parent]; }

NSPresentationIntent *PresentationIntentTableHeaderRowIntentWithIdentity( NSInteger identity, NSPresentationIntent *parent )
{ return [NSPresentationIntent tableHeaderRowIntentWithIdentity:identity nestedInsideIntent:parent]; }

NSPresentationIntent *PresentationIntentTableIntentWithIdentity( NSInteger identity, NSInteger columnCount, CFArrayRef alignments, NSPresentationIntent *parent )
{ return [NSPresentationIntent tableIntentWithIdentity:identity columnCount:columnCount alignments:(__bridge NSArray *)alignments nestedInsideIntent:parent]; }

NSPresentationIntent *PresentationIntentTableRowIntentWithIdentity( NSInteger identity, NSInteger row, NSPresentationIntent *parent )
{ return [NSPresentationIntent tableRowIntentWithIdentity:identity row:row nestedInsideIntent:parent]; }

NSPresentationIntent *PresentationIntentThematicBreakIntentWithIdentity( NSInteger identity, NSPresentationIntent *parent )
{ return [NSPresentationIntent thematicBreakIntentWithIdentity:identity nestedInsideIntent:parent]; }

NSPresentationIntent *PresentationIntentUnorderedListIntentWithIdentity( NSInteger identity, NSPresentationIntent *parent )
{ return [NSPresentationIntent unorderedListIntentWithIdentity:identity nestedInsideIntent:parent]; }

// Instance properties
NSInteger PresentationIntentColumn( NSPresentationIntent *ref )
{ return [ref column]; }

CFArrayRef PresentationIntentColumnAlignments( NSPresentationIntent *ref )
{ return (__bridge CFArrayRef)[ref columnAlignments]; }

NSInteger PresentationIntentColumnCount( NSPresentationIntent *ref )
{ return [ref columnCount]; }

NSInteger PresentationIntentHeaderLevel( NSPresentationIntent *ref )
{ return [ref headerLevel]; }

NSInteger PresentationIntentIdentity( NSPresentationIntent *ref )
{ return [ref identity]; }

NSInteger PresentationIntentIndentationLevel( NSPresentationIntent *ref )
{ return [ref indentationLevel]; }

NSPresentationIntentKind PresentationIntentKind( NSPresentationIntent *ref )
{ return [ref intentKind]; }

CFStringRef PresentationIntentLanguageHint( NSPresentationIntent *ref )
{ return (__bridge CFStringRef)[ref languageHint]; }

NSInteger PresentationIntentOrdinal( NSPresentationIntent *ref )
{ return [ref ordinal]; }

NSPresentationIntent *PresentationIntentParentIntent( NSPresentationIntent *ref )
{ return [ref parentIntent]; }

NSInteger PresentationIntentRow( NSPresentationIntent *ref )
{ return [ref row]; }

// Instance methods
BOOL PresentationIntentIsEquivalentTo( NSPresentationIntent *ref, NSPresentationIntent *otherRef )
{ return [ref isEquivalentToPresentationIntent:otherRef]; }

#endif // 120000
