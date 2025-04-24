/*
 LayoutManager.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef void (*CUI_LayoutManagerEnumerateEnclosingRectsForGlyphRangeHandlerType)(NSLayoutManager*,CGRect,BOOL*,void*);
typedef void (*CUI_LayoutManagerEnumerateLineFragmentsForGlyphRangeHandlerType)(NSLayoutManager*,CGRect,CGRect,NSTextContainer*,CFRange,BOOL*,void*);

// Class
Class LayoutManagerClass( void );

// Init
NSLayoutManager *LayoutManagerInit( void );

// Text storage
NSTextStorage *LayoutManagerTextStorage(  NSLayoutManager *ref );
void LayoutManagerReplaceTextStorage( NSLayoutManager *ref, NSTextStorage *ts );

// Text containers
CFArrayRef LayoutManagerTextContainers( NSLayoutManager *ref );
void LayoutManagerAddTextContainer( NSLayoutManager *ref, NSTextContainer *tc );
void LayoutManagerInsertTextContainer( NSLayoutManager *ref, NSTextContainer *tc, NSUInteger index );
void LayoutManagerRemoveTextContainer( NSLayoutManager *ref, NSUInteger index );
void LayoutManagerSetTextContainer( NSLayoutManager *ref, NSTextContainer *tc, CFRange glyphRange );
void LayoutManagerTextContainerChangedGeometry( NSLayoutManager *ref, NSTextContainer *tc );
void LayoutManagerTextContainerChangedTextView( NSLayoutManager *ref, NSTextContainer *tc );
NSTextContainer *LayoutManagerTextContainerForGlyph( NSLayoutManager *ref, NSUInteger index, CFRange *effectiveRange );
NSTextContainer *LayoutManagerTextContainerForGlyphWithoutAdditionalLayout( NSLayoutManager *ref, NSUInteger index, CFRange *effectiveRange, BOOL flag );
CGRect LayoutManagerUsedRectForTextContainer( NSLayoutManager *ref, NSTextContainer *tc );

// Global layout manager options
BOOL LayoutManagerAllowsNonContiguousLayout( NSLayoutManager *ref );
void LayoutManagerSetAllowsNonContiguousLayout( NSLayoutManager *ref, BOOL flag );
BOOL LayoutManagerHasNonContiguousLayout( NSLayoutManager *ref );
float LayoutManagerHyphenationFactor(NSLayoutManager *ref );
void LayoutManagerSetHyphenationFactor(NSLayoutManager *ref, float factor );
BOOL LayoutManagerShowsInvisibleCharacters( NSLayoutManager *ref );
void LayoutManagerSetShowsInvisibleCharacters( NSLayoutManager *ref, BOOL flag );
BOOL LayoutManagerShowsControlCharacters( NSLayoutManager *ref );
void LayoutManagerSetShowsControlCharacters( NSLayoutManager *ref, BOOL flag );
BOOL LayoutManagerUsesFontLeading( NSLayoutManager *ref );
void LayoutManagerSetUsesFontLeading( NSLayoutManager *ref, BOOL flag );
BOOL LayoutManagerBackgroundLayoutEnabled( NSLayoutManager *ref );
void LayoutManagerSetBackgroundLayoutEnabled( NSLayoutManager *ref, BOOL flag );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
BOOL LayoutManagerUsesDefaultHyphenation( NSLayoutManager *ref );
API_AVAILABLE(macos(10.15))
void LayoutManagerSetUsesDefaultHyphenation( NSLayoutManager *ref, BOOL flag );
#endif// 101500

// Invalidate glyphs and layout
void LayoutManagerInvalidateDisplayForCharacterRange( NSLayoutManager *ref, CFRange range );
void LayoutManagerInvalidateDisplayForGlyphRange( NSLayoutManager *ref, CFRange range );
void LayoutManagerInvalidateGlyphsForCharacterRange( NSLayoutManager *ref, CFRange range, NSInteger delta, CFRange *actualCharacterRange );
void LayoutManagerInvalidateLayoutForCharacterRange( NSLayoutManager *ref, CFRange range, CFRange *actualCharacterRange );
void LayoutManagerProcessEditingForTextStorage( NSLayoutManager *ref, NSTextStorage *textStorage, NSTextStorageEditActions edited, CFRange range, NSInteger delta, CFRange invalidatedRange );

// Glyph generation and layout
void LayoutManagerEnsureGlyphsForCharacterRange( NSLayoutManager *ref, CFRange range );
void LayoutManagerEnsureGlyphsForGlyphRange( NSLayoutManager *ref, CFRange range );
void LayoutManagerEnsureLayoutForBoundingRect( NSLayoutManager *ref, CGRect r, NSTextContainer *tc );
void LayoutManagerEnsureLayoutForCharacterRange( NSLayoutManager *ref, CFRange range );
void LayoutManagerEnsureLayoutForGlyphRange( NSLayoutManager *ref, CFRange range );
void LayoutManagerEnsureLayoutForTextContainer( NSLayoutManager *ref, NSTextContainer *tc );
NSGlyphGenerator *LayoutManagerGlyphGenerator( NSLayoutManager *ref );

// Accessing glyphs
NSUInteger LayoutManagerGetGlyphs( NSLayoutManager *ref, CFRange range, CGGlyph *glyphBuffer, NSGlyphProperty *props, NSUInteger *charIndexBuffer, unsigned char *bidiLevelsBuffer );
CGGlyph LayoutManagerCGGlyphAtIndex( NSLayoutManager *ref, NSUInteger glyphIndex );
CGGlyph LayoutManagerCGGlyphAtIndexIsValidIndex( NSLayoutManager *ref, NSUInteger glyphIndex, BOOL *isValidIndex );
void LayoutManagerSetCGGlyphs( NSLayoutManager *ref, CGGlyph *glyphs, NSGlyphProperty *props, NSUInteger *charIndexes, NSFont *font, CFRange glyphRange );
NSUInteger LayoutManagerCharacterIndexForGlyphAtIndex( NSLayoutManager *ref, NSUInteger glyphIndex );
NSUInteger LayoutManagerGlyphIndexForCharacterAtIndex( NSLayoutManager *ref, NSUInteger charIndex );
BOOL LayoutManagerIsValidGlyphIndex( NSLayoutManager *ref, NSUInteger glyphIndex );
NSUInteger LayoutManagerNumberOfGlyphs( NSLayoutManager *ref );
NSGlyphProperty LayoutManagerPropertyForGlyphAtIndex( NSLayoutManager *ref, NSUInteger glyphIndex );

// Set layout info
void LayoutManagerSetAttachmentSize( NSLayoutManager *ref, CGSize size, CFRange glyphRange );
void LayoutManagerSetDrawsOutsideLineFragment( NSLayoutManager *ref, BOOL flag, NSUInteger glyphIndex );
void LayoutManagerSetExtraLineFragmentRect( NSLayoutManager *ref, CGRect r, CGRect usedRect, NSTextContainer *textContainer );
void LayoutManagerSetLineFragmentRect( NSLayoutManager *ref, CGRect r, CFRange glyphRange, CGRect usedRect );
void LayoutManagerSetLocation( NSLayoutManager *ref, CGPoint pt, CFRange startOfGlyphRange );
void LayoutManagerSetNotShownAttribute( NSLayoutManager *ref, BOOL flag, NSUInteger glyphIndex );

// Get layout info
CGSize LayoutManagerAttachmentSizeForGlyphAtIndex( NSLayoutManager *ref, NSUInteger index );
BOOL LayoutManagerDrawsOutsideLineFragmentForGlyphAtIndex( NSLayoutManager *ref, NSUInteger index );
CGRect LayoutManagerExtraLineFragmentRect( NSLayoutManager *ref );
NSTextContainer *LayoutManagerExtraLineFragmentTextContainer( NSLayoutManager *ref );
CGRect LayoutManagerExtraLineFragmentUsedRect( NSLayoutManager *ref );
NSUInteger LayoutManagerFirstUnlaidCharacterIndex( NSLayoutManager *ref );
NSUInteger LayoutManagerFirstUnlaidGlyphIndex( NSLayoutManager *ref );
void LayoutManagerGetFirstUnlaidCharacterIndex( NSLayoutManager *ref, NSUInteger *charIndex, NSUInteger *glyphIndex );
CGRect LayoutManagerLineFragmentRectForGlyphAtIndex( NSLayoutManager *ref, NSUInteger index, CFRange *effectiveRange );
CGRect LayoutManagerLineFragmentRectForGlyphAtIndexWithoutAdditionalLayout( NSLayoutManager *ref, NSUInteger index, CFRange *effectiveRange, BOOL flag );
CGRect LayoutManagerExtraLineFragmentUsedRectForGlyphAtIndex( NSLayoutManager *ref, NSUInteger index, CFRange *effectiveRange );
CGRect LayoutManagerExtraLineFragmentUsedRectForGlyphAtIndexWithoutAdditionalLayout( NSLayoutManager *ref, NSUInteger index, CFRange *effectiveRange, BOOL flag );
CGPoint LayoutManagerLocationForGlyphAtIndex( NSLayoutManager *ref, NSUInteger index );
BOOL LayoutManagerNotShownAttributeForGlyphAtIndex( NSLayoutManager *ref, NSUInteger index );
CFRange LayoutManagerTruncatedGlyphRangeInLineFragmentForGlyphAtIndex( NSLayoutManager *ref, NSUInteger index );

// Advanced layout queries
CGRect LayoutManagerBoundingRectForGlyphRange( NSLayoutManager *ref, CFRange glyphRange, NSTextContainer *tc );
NSUInteger LayoutManagerCharacterIndexForPoint( NSLayoutManager *ref, CGPoint pt, NSTextContainer *tc, CGFloat *partialFraction );
CFRange LayoutManagerCharacterRangeForGlyphRange( NSLayoutManager *ref, CFRange glyphRange, CFRange *actualGlyphRange );
CFRange LayoutManagerGlyphRangeForBoundingRect( NSLayoutManager *ref, CGRect bounds, NSTextContainer *tc );
CFRange LayoutManagerGlyphRangeForTextContainer( NSLayoutManager *ref, NSTextContainer *tc );
CFRange LayoutManagerGlyphRangeForCharacterRange( NSLayoutManager *ref, CFRange charRange, CFRange *actualCharacterRange );
void LayoutManagerEnumerateEnclosingRectsForGlyphRange( NSLayoutManager *ref, CFRange glyphRange, CFRange selectedGlyphRange, NSTextContainer *textContainer, CUI_LayoutManagerEnumerateEnclosingRectsForGlyphRangeHandlerType handler, void *userData );
void LayoutManagerEnumerateLineFragmentsForGlyphRange( NSLayoutManager *ref, CFRange glyphRange, CUI_LayoutManagerEnumerateLineFragmentsForGlyphRangeHandlerType handler, void *userData );

CGFloat LayoutManagerFractionOfDistanceThroughGlyphForPoint( NSLayoutManager *ref, CGPoint pt, NSTextContainer *textContainer );
NSUInteger LayoutManagerGetLineFragmentInsertionPointsForCharacterAtIndex( NSLayoutManager *ref, NSUInteger charIndex, BOOL alternatePositions, BOOL inDisplayOrder, CGFloat *positions, NSUInteger *charIndexes );
NSUInteger LayoutManagerGlyphIndexForPoint( NSLayoutManager *ref, CGPoint pt, NSTextContainer *textContainer );
NSUInteger LayoutManagerGlyphIndexForPointFractionOfDistanceThroughGlyph( NSLayoutManager *ref, CGPoint pt, NSTextContainer *textContainer, CGFloat *partialFraction );
CFRange LayoutManagerGlyphRangeForBoundingRectWithoutAdditionalLayout( NSLayoutManager *ref, CGRect bounds, NSTextContainer *tc );
CFRange LayoutManagerGlyphRangeForCharacterRange( NSLayoutManager *ref, CFRange charRange, CFRange *actualCharacterRange );
CFRange LayoutManagerRangeOfNominallySpacedGlyphsContainingIndex( NSLayoutManager *ref, NSUInteger glyphIndex );

// Drawing
void LayoutManagerDrawBackgroundForGlyphRange( NSLayoutManager *ref, CFRange glyphsToShow, CGPoint origin );
void LayoutManagerDrawGlyphsForGlyphRange( NSLayoutManager *ref, CFRange glyphsToShow, CGPoint origin );
void LayoutManagerDrawStrikethroughForGlyphRange( NSLayoutManager *ref, CFRange glyphRange, NSInteger strikethroughType, CGFloat baselineOffset, CGRect lineRect, CFRange lineGlyphRange, CGPoint origin );
void LayoutManagerDrawUnderlineForGlyphRange( NSLayoutManager *ref, CFRange glyphRange, NSInteger underlineType, CGFloat baselineOffset, CGRect lineRect, CFRange lineGlyphRange, CGPoint origin );
void LayoutManagerFillBackgroundRectArray( NSLayoutManager *ref, CGRect *rectArray, NSUInteger rectCount, CFRange charRange, NSColor *color );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
void LayoutManagerShowCGGlyphs( NSLayoutManager *ref, CGGlyph *glyphs, CGPoint *positions, NSUInteger glyphCount, NSFont *font, CGAffineTransform textMatrix, CFDictionaryRef attributes, CGContextRef context );
#endif// 101500
void LayoutManagerStrikethroughGlyphRange( NSLayoutManager *ref, CFRange glyphRange, NSInteger strikethroughType, CGRect lineRect, CFRange lineGlyphRange, CGPoint containerOrigin );
void LayoutManagerUnderlineGlyphRange( NSLayoutManager *ref, CFRange glyphRange, NSInteger underlineType, CGRect lineRect, CFRange lineGlyphRange, CGPoint containerOrigin );

// Text blocks
void LayoutManagerSetLayoutRectForTextBlock( NSLayoutManager *ref, CGRect rect, NSTextBlock *textBlock, CFRange glyphRange );
CGRect LayoutManagerLayoutRectForTextBlock( NSLayoutManager *ref, NSTextBlock *textBlock, CFRange glyphRange );
void LayoutManagerSetBoundsRectForTextBlock( NSLayoutManager *ref, CGRect rect, NSTextBlock *textBlock, CFRange glyphRange );
CGRect LayoutManagerBoundsRectForTextBlock( NSLayoutManager *ref, NSTextBlock*textBlock, CFRange glyphRange );
CGRect LayoutManagerLayoutRectForTextBlockAtIndex( NSLayoutManager *ref, NSTextBlock *textBlock, NSUInteger glyphIndex, CFRange *effectiveGlyphRange );
CGRect LayoutManagerBoundsRectForTextBlockAtIndex( NSLayoutManager *ref, NSTextBlock *textBlock, NSUInteger glyphIndex, CFRange *effectiveGlyphRange );

// Attachments
NSImageScaling LayoutManagerDefaultAttachmentScaling( NSLayoutManager *ref );
void LayoutManagerSetDefaultAttachmentScaling( NSLayoutManager *ref, NSImageScaling scaling );
void LayoutManagerShowAttachmentCellInRect( NSLayoutManager *ref, NSCell *cell, CGRect rect, NSUInteger characterIndex );

// Rulers
NSView *LayoutManagerRulerAccessoryViewForTextView( NSLayoutManager *ref, NSInteger txtViewTag, NSParagraphStyle *paraStyle, NSRulerView *ruler, BOOL enabled );
CFArrayRef LayoutManagerRulerMarkersForTextView( NSLayoutManager *ref, NSInteger txtViewTag, NSParagraphStyle *paraStyle, NSRulerView *ruler );

// Responder chain
BOOL LayoutManagerOwnsFirstResponderInWindow( NSLayoutManager *ref, NSInteger wndTag );
NSInteger LayoutManagerFirstTextView( NSLayoutManager *ref );
NSInteger LayoutManagerTextViewForBeginningOfSelection( NSLayoutManager *ref );

// Typesetter
NSTypesetter *LayoutManagerTypesetter( NSLayoutManager *ref );
void LayoutManagerSetTypesetter( NSLayoutManager *ref, NSTypesetter *typesetter );
NSTypesetterBehavior LayoutManagerTypesetterBehavior( NSLayoutManager *ref );
void LayoutManagerSetTypesetterBehavior( NSLayoutManager *ref, NSTypesetterBehavior behavior );

CGFloat LayoutManagerDefaultLineHeightForFont( NSLayoutManager *ref, NSFont *font );
CGFloat LayoutManagerDefaultBaselineOffsetForFont( NSLayoutManager *ref, NSFont *font );

// Temporary attribute support
void LayoutManagerAddTemporaryAttributes( NSLayoutManager *ref, CFDictionaryRef attrs, CFRange charRange );
void LayoutManagerAddTemporaryAttribute( NSLayoutManager *ref, CFStringRef name, ObjectRef value, CFRange charRange );
void LayoutManagerSetTemporaryAttributes( NSLayoutManager *ref, CFDictionaryRef attrs, CFRange charRange );
void LayoutManagerRemoveTemporaryAttribute( NSLayoutManager *ref, CFStringRef name, CFRange charRange );
ObjectRef LayoutManagerTemporaryAttribute( NSLayoutManager *ref, CFStringRef name, NSUInteger charIndex, CFRange *effectiveRange );
ObjectRef LayoutManagerTemporaryAttributeInRange( NSLayoutManager *ref, CFStringRef name, NSUInteger charIndex, CFRange *longestEffectiveRange, CFRange range );
CFDictionaryRef LayoutManagerTemporaryAttributes( NSLayoutManager *ref, NSUInteger charIndex, CFRange *effectiveRange );
CFDictionaryRef LayoutManagerTemporaryAttributesInRange( NSLayoutManager *ref, NSUInteger charIndex, CFRange *longestEffectiveRange, CFRange range );
