/*
 AttributedString.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

#import <WebKit/WebKit.h>// required for AttributedStringLoadFromHTMLWithXxxx functions

typedef void (*CUI_AttributedStringLoadFromHTMLCompletionHandlerType)(CFAttributedStringRef,CFDictionaryRef,NSError *,void*);
typedef void (*CUI_AttributedStringEnumerateAttributeCallbackType)(CFAttributedStringRef,CFTypeRef,CFRange,BOOL*,void*);
typedef void (*CUI_AttributedStringEnumerateAttributesCallbackType)(CFAttributedStringRef,CFDictionaryRef,CFRange,BOOL*,void*);

// Class
Class AttributedStringClass( void );

// Create
CFAttributedStringRef AttributedStringWithString( CFStringRef string );
CFAttributedStringRef AttributedStringWithAttributes( CFStringRef string, CFDictionaryRef attributes );
CFAttributedStringRef AttributedStringWithAttributedString( CFAttributedStringRef aString );
CFAttributedStringRef AttributedStringWithData( CFDataRef dta, CFDictionaryRef options, CFDictionaryRef *attributes, NSError **err );
CFAttributedStringRef AttributedStringWithDocFormat( CFDataRef dta, CFDictionaryRef *attributes );
CFAttributedStringRef AttributedStringWithHTML( CFDataRef dta, CFDictionaryRef *attributes );
CFAttributedStringRef AttributedStringWithHTMLBaseURL( CFDataRef dta, CFURLRef url, CFDictionaryRef *attributes );
CFAttributedStringRef AttributedStringWithHTMLOptions( CFDataRef dta, CFDictionaryRef options, CFDictionaryRef *attributes );
CFAttributedStringRef AttributedStringWithRTF( CFDataRef dta, CFDictionaryRef *attributes );
CFAttributedStringRef AttributedStringWithRTFD( CFDataRef dta, CFDictionaryRef *attributes );
CFAttributedStringRef AttributedStringWithRTFDFileWrapper( NSFileWrapper *fw, CFDictionaryRef *attributes );
CFAttributedStringRef AttributedStringWithURL( CFURLRef url, CFDictionaryRef options, CFDictionaryRef *attributes, NSError **err );
CFAttributedStringRef AttributedStringWithAttachment( NSTextAttachment *attachment );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
API_AVAILABLE(macos(15.0))
CFAttributedStringRef AttributedStringWithAttachmentAndAttributes( NSTextAttachment *attachment, CFDictionaryRef attributes );
#endif // 150000
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
CFAttributedStringRef AttributedStringWithFormat( CFAttributedStringRef format, NSAttributedStringFormattingOptions options, CFLocaleRef locale, ... );
API_AVAILABLE(macos(14.0))
CFAttributedStringRef AttributedStringWithFormatAndArguments( CFAttributedStringRef format, NSAttributedStringFormattingOptions options, CFLocaleRef locale, va_list arguments );
API_AVAILABLE(macos(14.0))
//CFAttributedStringRef AttributedStringLocalizedWithFormat( CFAttributedStringRef format, ... );
//CFAttributedStringRef AttributedStringLocalizedWithFormatAndOptions( CFAttributedStringRef format, NSAttributedStringFormattingOptions options, ... );
API_AVAILABLE(macos(14.0))
CFAttributedStringRef AttributedStringWithFormatAndContext( CFAttributedStringRef format, NSAttributedStringFormattingOptions options, CFLocaleRef locale, CFDictionaryRef context, ... );
API_AVAILABLE(macos(14.0))
CFAttributedStringRef AttributedStringWithFormatContextAndArguments( CFAttributedStringRef format, NSAttributedStringFormattingOptions options, CFLocaleRef locale, CFDictionaryRef context, va_list arguments );
//CFAttributedStringRef AttributedStringLocalizedWithFormatAndContext( CFAttributedStringRef format, CFDictionaryRef context, ... );
//CFAttributedStringRef AttributedStringLocalizedWithFormatOptionsAndContext( CFAttributedStringRef format, NSAttributedStringFormattingOptions options, CFDictionaryRef context, ... );
#endif// 140000

// Load from HTML
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
void AttributedStringLoadFromHTMLWithRequest( NSURLRequest *request, CFDictionaryRef options, CUI_AttributedStringLoadFromHTMLCompletionHandlerType completionHandler, void *userData );
API_AVAILABLE(macos(10.15))
void AttributedStringLoadFromHTMLWithFileURL( CFURLRef url, CFDictionaryRef options, CUI_AttributedStringLoadFromHTMLCompletionHandlerType completionHandler, void *userData );
API_AVAILABLE(macos(10.15))
void AttributedStringLoadFromHTMLWithString( CFStringRef string, CFDictionaryRef options, CUI_AttributedStringLoadFromHTMLCompletionHandlerType completionHandler, void *userData );
API_AVAILABLE(macos(10.15))
void AttributedStringLoadFromHTMLWithData( CFDataRef dta, CFDictionaryRef options, CUI_AttributedStringLoadFromHTMLCompletionHandlerType completionHandler, void *userData );
#endif// 101500

// Character info
CFStringRef AttributedStringString( CFAttributedStringRef aString );
NSUInteger AttributedStringLength( CFAttributedStringRef aString );

// Attribute info
CFDictionaryRef AttributedStringAttributesAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );
CFDictionaryRef AttributedStringAttributesAtIndexInRange( CFAttributedStringRef aString, NSUInteger index, CFRange *longestEffectiveRange, CFRange range );
CFTypeRef AttributedStringAttributeAtIndex( CFAttributedStringRef aString, CFStringRef attrName, NSUInteger index, CFRange *effectiveRange );
CFTypeRef AttributedStringAttributeAtIndexInRange( CFAttributedStringRef aString, CFStringRef attrName, NSUInteger index, CFRange *longestEffectiveRange, CFRange range );

// Compare
BOOL AttributedStringIsEqual( CFAttributedStringRef aString1, CFAttributedStringRef aString2 );

// Substring
CFAttributedStringRef AttributedStringAttributedSubstringFromRange( CFAttributedStringRef aString, CFRange range );

// Enumerate
void AttributedStringEnumerateAttributeInRange( CFAttributedStringRef aString, CFStringRef attrName, CFRange range, NSAttributedStringEnumerationOptions options, CUI_AttributedStringEnumerateAttributeCallbackType fnAddress, void *userData );
void AttributedStringEnumerateAttributesInRange( CFAttributedStringRef aString, CFRange range, NSAttributedStringEnumerationOptions options, CUI_AttributedStringEnumerateAttributesCallbackType fnAddress, void *userData );

// Font info
CFDictionaryRef AttributedStringFontAttributesInRange( CFAttributedStringRef aString, CFRange range );
CFDictionaryRef AttributedStringRulerAttributesInRange( CFAttributedStringRef aString, CFRange range );

// Linguistic units
CFRange AttributedStringDoubleClickAtIndex( CFAttributedStringRef aString, NSUInteger index );
NSUInteger AttributedStringLineBreakBeforeIndex( CFAttributedStringRef aString, NSUInteger index, CFRange withinRange );
NSUInteger AttributedStringLineBreakByHyphenatingBeforeIndex( CFAttributedStringRef aString, NSUInteger index, CFRange withinRange );
NSUInteger AttributedStringNextWordFromIndex( CFAttributedStringRef aString, NSUInteger index, BOOL forward );

// Ranges
NSInteger AttributedStringItemNumberInTextList( CFAttributedStringRef aString, NSTextList *list, NSUInteger index );
CFRange AttributedStringRangeOfTextBlock( CFAttributedStringRef aString, NSTextBlock *block, NSUInteger index );
CFRange AttributedStringRangeOfTextList( CFAttributedStringRef aString, NSTextList *list, NSUInteger index );
CFRange AttributedStringRangeOfTextTable( CFAttributedStringRef aString, NSTextTable *table, NSUInteger index );

// Data
CFDataRef AttributedStringDataFromRange( CFAttributedStringRef aString, CFRange range, CFDictionaryRef attributes, NSError **err );
NSFileWrapper *AttributedStringFileWrapperFromRange( CFAttributedStringRef aString, CFRange range, CFDictionaryRef attributes, NSError **err );
CFDataRef AttributedStringDocFormatFromRange( CFAttributedStringRef aString, CFRange range, CFDictionaryRef attributes );
CFDataRef AttributedStringRTFFromRange( CFAttributedStringRef aString, CFRange range, CFDictionaryRef attributes );
CFDataRef AttributedStringRTFDFromRange( CFAttributedStringRef aString, CFRange range, CFDictionaryRef attributes );
NSFileWrapper *AttributedStringRTFDFileWrapperFromRange( CFAttributedStringRef aString, CFRange range, CFDictionaryRef attributes );

// Automatic grammar agreement
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
CFAttributedStringRef AttributedStringByInflectingString( CFAttributedStringRef aString );
#endif // 120000

// Draw
void AttributedStringDrawAtPoint( CFAttributedStringRef aString, CGPoint pt );
void AttributedStringDrawInRect( CFAttributedStringRef aString, CGRect r );
void AttributedStringDrawWithRect( CFAttributedStringRef aString, CGRect r, NSStringDrawingOptions options, NSStringDrawingContext *ctx );

// Metrics
CGSize AttributedStringSize( CFAttributedStringRef aString );
CGRect AttributedStringBoundingRectWithSize( CFAttributedStringRef aString, CGSize size, NSStringDrawingOptions options, NSStringDrawingContext *ctx );
BOOL AttributedStringContainsAttachmentsInRange( CFAttributedStringRef aString, CFRange range );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
API_AVAILABLE(macos(15.0))
BOOL AttributedStringPrefersRTFDInRange( CFAttributedStringRef aString, CFRange range );
#endif // 150000

// Data sources
CFArrayRef AttributedStringTextTypes( void );
CFArrayRef AttributedStringTextUnfilteredTypes( void );


/*
 Convenience
 */
// font
NSFont *AttributedStringFontAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// stroke width
CGFloat AttributedStringStrokeWidthAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// stroke color
NSColor *AttributedStringStrokeColorAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// foreground color
NSColor *AttributedStringForegroundColorAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// background color
NSColor *AttributedStringBackgroundColorAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// shadow
NSShadow *AttributedStringShadowAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// shadow color
NSColor *AttributedStringShadowColorAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// underline
NSInteger AttributedStringUnderlineAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// underline color
NSColor *AttributedStringUnderlineColorAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// strikethrough
NSInteger AttributedStringStrikethroughAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// strikethrough color
NSColor *AttributedStringStrikethroughColorAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// superscript
NSInteger AttributedStringSuperscriptAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// expansion
float AttributedStringExpansionAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// obliqueness
float AttributedStringObliquenessAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// link
CFTypeRef AttributedStringLinkAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// baseline offset
float AttributedStringBaselineOffsetAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// kerning
CGFloat AttributedStringKerningAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// paragraph style

// alignment
NSTextAlignment AttributedStringParagraphAlignmentAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// first line head indent
CGFloat AttributedStringFirstLineHeadIndentAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// head indent
CGFloat AttributedStringHeadIndentAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// tail indent
CGFloat AttributedStringTailIndentAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// line break mode
NSLineBreakMode AttributedStringLineBreakModeAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// maximum line height
CGFloat AttributedStringMaximumLineHeightAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// minimum line height
CGFloat AttributedStringMinimumLineHeightAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// line spacing
CGFloat AttributedStringLineSpacingAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// paragraph spacing
CGFloat AttributedStringParagraphSpacingAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// paragraph spacing before
CGFloat AttributedStringParagraphSpacingBeforeAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// line height multiple
CGFloat AttributedStringLineHeightMultipleAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// tab stops
CFArrayRef AttributedStringTabStopsAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// default tab interval
CGFloat AttributedStringDefaultTabIntervalAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );

// header level
NSInteger AttributedStringHeaderLevelAtIndex( CFAttributedStringRef aString, NSUInteger index, CFRange *effectiveRange );


#pragma mark - Mutable attributed string
// Class
Class MutableAttributedStringClass( void );

// Create
CFMutableAttributedStringRef MutableAttributedStringNew( void );
CFMutableAttributedStringRef MutableAttributedStringWithString( CFStringRef string );
CFMutableAttributedStringRef MutableAttributedStringWithAttributes( CFStringRef string, CFDictionaryRef attributes );
CFMutableAttributedStringRef MutableAttributedStringWithAttributedString( CFAttributedStringRef aString );
CFMutableAttributedStringRef MutableAttributedStringWithData( CFDataRef dta, CFDictionaryRef options, CFDictionaryRef *attributes, NSError **err );
CFMutableAttributedStringRef MutableAttributedStringWithDocFormat( CFDataRef dta, CFDictionaryRef *attributes );
CFMutableAttributedStringRef MutableAttributedStringWithHTML( CFDataRef dta, CFDictionaryRef *attributes );
CFMutableAttributedStringRef MutableAttributedStringWithHTMLBaseURL( CFDataRef dta, CFURLRef url, CFDictionaryRef *attributes );
CFMutableAttributedStringRef MutableAttributedStringWithHTMLOptions( CFDataRef dta, CFDictionaryRef options, CFDictionaryRef *attributes );
CFMutableAttributedStringRef MutableAttributedStringWithRTF( CFDataRef dta, CFDictionaryRef *attributes );
CFMutableAttributedStringRef MutableAttributedStringWithRTFD( CFDataRef dta, CFDictionaryRef *attributes );
CFMutableAttributedStringRef MutableAttributedStringWithRTFDFileWrapper( NSFileWrapper *fw, CFDictionaryRef *attributes );
CFMutableAttributedStringRef MutableAttributedStringWithURL( CFURLRef url, CFDictionaryRef options, CFDictionaryRef *attributes, NSError **err );
CFMutableAttributedStringRef MutableAttributedStringWithAttachment( NSTextAttachment *attachment );

// Character info
CFMutableStringRef MutableAttributedStringMutableString( CFMutableAttributedStringRef aString );

// Change characters
void MutableAttributedStringReplaceCharactersInRange( CFMutableAttributedStringRef aString, CFStringRef string, CFRange range );
void MutableAttributedStringDeleteCharactersInRange( CFMutableAttributedStringRef aString, CFRange range );

// Change attributes
void MutableAttributedStringSetAttributesInRange( CFMutableAttributedStringRef aString, CFDictionaryRef attrs, CFRange range );
void MutableAttributedStringAddAttributeInRange( CFMutableAttributedStringRef aString, CFStringRef name, CFTypeRef value, CFRange range );
void MutableAttributedStringAddAttributesInRange( CFMutableAttributedStringRef aString, CFDictionaryRef attrs, CFRange range );
void MutableAttributedStringRemoveAttributeInRange( CFMutableAttributedStringRef aString, CFStringRef name, CFRange range );
void MutableAttributedStringApplyFontTraitsInRange( CFMutableAttributedStringRef aString, NSFontTraitMask traitMask, CFRange range );
void MutableAttributedStringSetAlignmentInRange( CFMutableAttributedStringRef aString, NSTextAlignment alignment, CFRange range );
void MutableAttributedStringSetBaseWritingDirectionInRange( CFMutableAttributedStringRef aString, NSWritingDirection value, CFRange range );
void MutableAttributedStringSubscriptRange( CFMutableAttributedStringRef aString, CFRange range );
void MutableAttributedStringSuperscriptRange( CFMutableAttributedStringRef aString, CFRange range );
void MutableAttributedStringUnscriptRange( CFMutableAttributedStringRef aString, CFRange range );

// Change characters and attributes
void MutableAttributedStringAppendAttributedString( CFMutableAttributedStringRef aString, CFAttributedStringRef attrString );
void MutableAttributedStringInsertAttributedString( CFMutableAttributedStringRef aString, CFAttributedStringRef attrString, NSUInteger index );
void MutableAttributedStringReplaceCharactersInRangeWithAttributedString( CFMutableAttributedStringRef aString, CFRange range, CFAttributedStringRef attrString );
void MutableAttributedStringSetAttributedString( CFMutableAttributedStringRef aString, CFAttributedStringRef attrString );

// Grouping changes
void MutableAttributedStringBeginEditing( CFMutableAttributedStringRef aString );
void MutableAttributedStringEndEditing( CFMutableAttributedStringRef aString );

// Update attachment contents

// Fix attributes after changes
void MutableAttributedStringFixAttributesInRange( CFMutableAttributedStringRef aString, CFRange range );
void MutableAttributedStringFixAttachmentAttributeInRange( CFMutableAttributedStringRef aString, CFRange range );
void MutableAttributedStringFixFontAttributeInRange( CFMutableAttributedStringRef aString, CFRange range );
void MutableAttributedStringFixParagraphStyleAttributeInRange( CFMutableAttributedStringRef aString, CFRange range );

// Read content
BOOL MutableAttributedStringReadFromData( CFMutableAttributedStringRef aString, CFDataRef dta, CFDictionaryRef options, CFDictionaryRef *docAttributes, NSError **err );
BOOL MutableAttributedStringReadFromURL( CFMutableAttributedStringRef aString, CFURLRef url, CFDictionaryRef options, CFDictionaryRef *docAttributes, NSError **err );


/*
 Convenience
 */
// string
void MutableAttributedStringSetString( CFMutableAttributedStringRef as, CFStringRef string );

// append
void MutableAttributedStringAppendCharacters( CFMutableAttributedStringRef as, CFStringRef string );

// font
void MutableAttributedStringSetFontInRange( CFMutableAttributedStringRef aString, NSFont *font, CFRange range );
void MutableAttributedStringSetFont( CFMutableAttributedStringRef aString, NSFont *font );
void MutableAttributedStringSetFontWithNameInRange( CFMutableAttributedStringRef as, CFStringRef name, CGFloat size, CFRange range );
void MutableAttributedStringSetFontWithName( CFMutableAttributedStringRef as, CFStringRef name, CGFloat size );

// alignment
void MutableAttributedStringSetAlignment( CFMutableAttributedStringRef as, NSTextAlignment alignment );

// stroke width
void MutableAttributedStringSetStrokeWidthInRange( CFMutableAttributedStringRef as, CGFloat width, CFRange range );
void MutableAttributedStringSetStrokeWidth( CFMutableAttributedStringRef as, CGFloat width );

// stroke color
void MutableAttributedStringSetStrokeColorInRange( CFMutableAttributedStringRef as, NSColor *col, CFRange range );
void MutableAttributedStringSetStrokeColor( CFMutableAttributedStringRef as, NSColor *col );

// foreground color
void MutableAttributedStringSetForegroundColorInRange( CFMutableAttributedStringRef as, NSColor *col, CFRange range );
void MutableAttributedStringSetForegroundColor( CFMutableAttributedStringRef as, NSColor *col );

// background color
void MutableAttributedStringSetBackgroundColorInRange( CFMutableAttributedStringRef as, NSColor *col, CFRange range );
void MutableAttributedStringSetBackgroundColor( CFMutableAttributedStringRef as, NSColor *col );

// shadow
void MutableAttributedStringSetShadowInRange( CFMutableAttributedStringRef as, CGSize offset, CGFloat blur, CFRange range );
void MutableAttributedStringSetShadow( CFMutableAttributedStringRef as, CGSize offset, CGFloat blur );

// shadow color
void MutableAttributedStringSetShadowColorInRange( CFMutableAttributedStringRef as, NSColor *col, CFRange range );
void MutableAttributedStringSetShadowColor( CFMutableAttributedStringRef as, NSColor *col );

// underline
void MutableAttributedStringSetUnderlineInRange( CFMutableAttributedStringRef as, NSInteger style, CFRange range );
void MutableAttributedStringSetUnderline( CFMutableAttributedStringRef as, NSInteger style );

// underline color
void MutableAttributedStringSetUnderlineColorInRange( CFMutableAttributedStringRef as, NSColor *col, CFRange range );
void MutableAttributedStringSetUnderlineColor( CFMutableAttributedStringRef as, NSColor *col );

// strikethrough
void MutableAttributedStringSetStrikethroughInRange( CFMutableAttributedStringRef as, NSInteger style, CFRange range );
void MutableAttributedStringSetStrikethrough( CFMutableAttributedStringRef as, NSInteger style );

// strikethrough color
void MutableAttributedStringSetStrikethroughColorInRange( CFMutableAttributedStringRef as, NSColor *col, CFRange range );
void MutableAttributedStringSetStrikethroughColor( CFMutableAttributedStringRef as, NSColor *col );

// superscript
void MutableAttributedStringSetSuperscriptInRange( CFMutableAttributedStringRef as, NSInteger value, CFRange range );
void MutableAttributedStringSetSuperscript( CFMutableAttributedStringRef as, NSInteger value );

// expansion
void MutableAttributedStringSetExpansionInRange( CFMutableAttributedStringRef as, float value, CFRange range );
void MutableAttributedStringSetExpansion( CFMutableAttributedStringRef as, float value );

// obliqueness
void MutableAttributedStringSetObliquenessInRange( CFMutableAttributedStringRef as, float value, CFRange range );
void MutableAttributedStringSetObliqueness( CFMutableAttributedStringRef as, float value );

// link
void MutableAttributedStringSetLinkInRange( CFMutableAttributedStringRef as, CFTypeRef value, CFRange range );
void MutableAttributedStringSetLink( CFMutableAttributedStringRef as, CFTypeRef value );

// baseline offset
void MutableAttributedStringSetBaselineOffsetInRange( CFMutableAttributedStringRef as, float value, CFRange range );
void MutableAttributedStringSetBaselineOffset( CFMutableAttributedStringRef as, float value );

// kerning
void MutableAttributedStringSetKerningInRange( CFMutableAttributedStringRef as, CGFloat value, CFRange range );
void MutableAttributedStringSetKerning( CFMutableAttributedStringRef as, CGFloat value );

// NSTextEffectAttributeName

// NSGlyphInfoAttributeName

// - paragraph styles -
NSMutableParagraphStyle *CUI_AttributedStringCopyParagraphStyle( CFMutableAttributedStringRef as, CFRange range );

// alignment
void MutableAttributedStringSetParagraphAlignmentInRange( CFMutableAttributedStringRef as, NSTextAlignment value, CFRange range );
void MutableAttributedStringSetParagraphAlignment( CFMutableAttributedStringRef as, NSTextAlignment value );

// first line head indent
void MutableAttributedStringSetFirstLineHeadIndentInRange( CFMutableAttributedStringRef as, CGFloat value, CFRange range );
void MutableAttributedStringSetFirstLineHeadIndent( CFMutableAttributedStringRef as, CGFloat value );

// head indent
void MutableAttributedStringSetHeadIndentInRange( CFMutableAttributedStringRef as, CGFloat value, CFRange range );
void MutableAttributedStringSetHeadIndent( CFMutableAttributedStringRef as, CGFloat value );

// tail indent
void MutableAttributedStringSetTailIndentInRange( CFMutableAttributedStringRef as, CGFloat value, CFRange range );
void MutableAttributedStringSetTailIndent( CFMutableAttributedStringRef as, CGFloat value );

// line break mode
void MutableAttributedStringSetLIneBreakModeInRange( CFMutableAttributedStringRef as, NSLineBreakMode value, CFRange range );
void MutableAttributedStringSetLIneBreakMode( CFMutableAttributedStringRef as, NSLineBreakMode value );

// maximum line height
void MutableAttributedStringSetMaximumLineHeightInRange( CFMutableAttributedStringRef as, CGFloat value, CFRange range );
void MutableAttributedStringSetMaximumLineHeight( CFMutableAttributedStringRef as, CGFloat value );

// minimum line height
void MutableAttributedStringSetMinimumLineHeightInRange( CFMutableAttributedStringRef as, CGFloat value, CFRange range );
void MutableAttributedStringSetMinimumLineHeight( CFMutableAttributedStringRef as, CGFloat value );

// line spacing
void MutableAttributedStringSetLineSpacingInRange( CFMutableAttributedStringRef as, CGFloat value, CFRange range );
void MutableAttributedStringSetLineSpacing( CFMutableAttributedStringRef as, CGFloat value );

// paragraph spacing
void MutableAttributedStringSetParagraphSpacingInRange( CFMutableAttributedStringRef as, CGFloat value, CFRange range );
void MutableAttributedStringSetParagraphSpacing( CFMutableAttributedStringRef as, CGFloat value );

// paragraph spacing before
void MutableAttributedStringSetParagraphSpacingBeforeInRange( CFMutableAttributedStringRef as, CGFloat value, CFRange range );
void MutableAttributedStringSetParagraphSpacingBefore( CFMutableAttributedStringRef as, CGFloat value );

// base writing direction
void MutableAttributedStringSetBaseWritingDirection( CFMutableAttributedStringRef as, NSWritingDirection value );

// line height multiple
void MutableAttributedStringSetLineHeightMultipleInRange( CFMutableAttributedStringRef as, CGFloat value, CFRange range );
void MutableAttributedStringSetLineHeightMultiple( CFMutableAttributedStringRef as, CGFloat value );

// add tab stop
void MutableAttributedStringAddTabStopInRange( CFMutableAttributedStringRef as, NSTextAlignment alignment, CGFloat location, CFDictionaryRef options, CFRange range );
void MutableAttributedStringAddTabStop( CFMutableAttributedStringRef as, NSTextAlignment alignment, CGFloat location, CFDictionaryRef options );

// set tab stops
void MutableAttributedStringSetTabStopsInRange( CFMutableAttributedStringRef as, CFArrayRef tabStops, CFRange range );
void MutableAttributedStringSetTabStops( CFMutableAttributedStringRef as, CFArrayRef tabStops );

// set default tab interval
void MutableAttributedStringSetDefaultTabIntervalInRange( CFMutableAttributedStringRef as, CGFloat interval, CFRange range );
void MutableAttributedStringSetDefaultTabInterval( CFMutableAttributedStringRef as, CGFloat interval );

// header level
void MutableAttributedStringSetHeaderLevelInRange( CFMutableAttributedStringRef as, NSInteger value, CFRange range );
void MutableAttributedStringSetHeaderLevel( CFMutableAttributedStringRef as, NSInteger value );


#pragma mark - AttributedStringMarkdownParsingOptions

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000

// Create
API_AVAILABLE(macos(12.0))
NSAttributedStringMarkdownParsingOptions *AttributedStringMarkdownParsingOptionsInit( void );

// Options
API_AVAILABLE(macos(12.0))
BOOL AttributedStringMarkdownParsingOptionsAllowsExtendedAttributes( NSAttributedStringMarkdownParsingOptions *ref );
API_AVAILABLE(macos(12.0))
void AttributedStringMarkdownParsingOptionsSetAllowsExtendedAttributes( NSAttributedStringMarkdownParsingOptions *ref, BOOL flag );
API_AVAILABLE(macos(12.0))
NSAttributedStringMarkdownParsingFailurePolicy AttributedStringMarkdownParsingOptionsFailurePolicy( NSAttributedStringMarkdownParsingOptions *ref );
API_AVAILABLE(macos(12.0))
void AttributedStringMarkdownParsingOptionsSetFailurePolicy( NSAttributedStringMarkdownParsingOptions *ref, NSAttributedStringMarkdownParsingFailurePolicy policy );
API_AVAILABLE(macos(12.0))
NSAttributedStringMarkdownInterpretedSyntax AttributedStringMarkdownParsingOptionsInterpretedSyntax( NSAttributedStringMarkdownParsingOptions *ref );
API_AVAILABLE(macos(12.0))
void AttributedStringMarkdownParsingOptionsSetInterpretedSyntax( NSAttributedStringMarkdownParsingOptions *ref, NSAttributedStringMarkdownInterpretedSyntax syntax );
API_AVAILABLE(macos(12.0))
CFStringRef AttributedStringMarkdownParsingOptionsLanguageCode( NSAttributedStringMarkdownParsingOptions *ref );
API_AVAILABLE(macos(12.0))
void AttributedStringMarkdownParsingOptionsSetLanguageCode( NSAttributedStringMarkdownParsingOptions *ref, CFStringRef languageCode );
#endif// 120000


#pragma mark - PresentationIntent
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000

// Create
API_AVAILABLE(macos(12.0))
NSPresentationIntent *PresentationIntentBlockQuoteIntentWithIdentity( NSInteger identity, NSPresentationIntent *parent );
API_AVAILABLE(macos(12.0))
NSPresentationIntent *PresentationIntentCodeBlockIntentWithIdentity( NSInteger identity, CFStringRef languageHint, NSPresentationIntent *parent );
API_AVAILABLE(macos(12.0))
NSPresentationIntent *PresentationIntentHeaderIntentWithIdentity( NSInteger identity, NSInteger level, NSPresentationIntent *parent );
API_AVAILABLE(macos(12.0))
NSPresentationIntent *PresentationIntentListItemIntentWithIdentity( NSInteger identity, NSInteger ordinal, NSPresentationIntent *parent );
API_AVAILABLE(macos(12.0))
NSPresentationIntent *PresentationIntentOrderedListIntentWithIdentity( NSInteger identity, NSPresentationIntent *parent );
API_AVAILABLE(macos(12.0))
NSPresentationIntent *PresentationIntentParagraphIntentWithIdentity( NSInteger identity, NSPresentationIntent *parent );
API_AVAILABLE(macos(12.0))
NSPresentationIntent *PresentationIntentTableCellIntentWithIdentity( NSInteger identity, NSInteger column, NSPresentationIntent *parent );
API_AVAILABLE(macos(12.0))
NSPresentationIntent *PresentationIntentTableHeaderRowIntentWithIdentity( NSInteger identity, NSPresentationIntent *parent );
API_AVAILABLE(macos(12.0))
NSPresentationIntent *PresentationIntentTableIntentWithIdentity( NSInteger identity, NSInteger columnCount, CFArrayRef alignments, NSPresentationIntent *parent );
API_AVAILABLE(macos(12.0))
NSPresentationIntent *PresentationIntentTableRowIntentWithIdentity( NSInteger identity, NSInteger row, NSPresentationIntent *parent );
API_AVAILABLE(macos(12.0))
NSPresentationIntent *PresentationIntentThematicBreakIntentWithIdentity( NSInteger identity, NSPresentationIntent *parent );
API_AVAILABLE(macos(12.0))
NSPresentationIntent *PresentationIntentUnorderedListIntentWithIdentity( NSInteger identity, NSPresentationIntent *parent );

// Instance properties
API_AVAILABLE(macos(12.0))
NSInteger PresentationIntentColumn( NSPresentationIntent *ref );
API_AVAILABLE(macos(12.0))
CFArrayRef PresentationIntentColumnAlignments( NSPresentationIntent *ref );
API_AVAILABLE(macos(12.0))
NSInteger PresentationIntentColumnCount( NSPresentationIntent *ref );
API_AVAILABLE(macos(12.0))
NSInteger PresentationIntentHeaderLevel( NSPresentationIntent *ref );
API_AVAILABLE(macos(12.0))
NSInteger PresentationIntentIdentity( NSPresentationIntent *ref );
API_AVAILABLE(macos(12.0))
NSInteger PresentationIntentIndentationLevel( NSPresentationIntent *ref );
API_AVAILABLE(macos(12.0))
NSPresentationIntentKind PresentationIntentKind( NSPresentationIntent *ref );
API_AVAILABLE(macos(12.0))
CFStringRef PresentationIntentLanguageHint( NSPresentationIntent *ref );
API_AVAILABLE(macos(12.0))
NSInteger PresentationIntentOrdinal( NSPresentationIntent *ref );
API_AVAILABLE(macos(12.0))
NSPresentationIntent *PresentationIntentParentIntent( NSPresentationIntent *ref );
API_AVAILABLE(macos(12.0))
NSInteger PresentationIntentRow( NSPresentationIntent *ref );

// Instance methods
API_AVAILABLE(macos(12.0))
BOOL PresentationIntentIsEquivalentTo( NSPresentationIntent *ref, NSPresentationIntent *otherRef );

#endif // 120000

