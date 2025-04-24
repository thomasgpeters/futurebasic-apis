/*
 LayoutManager.m

 Bernie Wylde
 */

#import "LayoutManager.h"

// Class
Class LayoutManagerClass( void )
{ return [NSLayoutManager class]; }

// Init
NSLayoutManager *LayoutManagerInit( void )
{
#if __has_feature(objc_arc)
    return [[NSLayoutManager alloc] init];
#else
    return [[[NSLayoutManager alloc] init] autorelease];
#endif
}

// Text storage
NSTextStorage *LayoutManagerTextStorage(  NSLayoutManager *ref )
{ return [ref textStorage]; }

void LayoutManagerReplaceTextStorage( NSLayoutManager *ref, NSTextStorage *ts )
{ [ref replaceTextStorage:ts]; }

// Text containers
CFArrayRef LayoutManagerTextContainers( NSLayoutManager *ref )
{ return (__bridge CFArrayRef)[ref textContainers]; }

void LayoutManagerAddTextContainer( NSLayoutManager *ref, NSTextContainer *tc )
{ [ref addTextContainer:tc]; }

void LayoutManagerInsertTextContainer( NSLayoutManager *ref, NSTextContainer *tc, NSUInteger index )
{ [ref insertTextContainer:tc atIndex:index]; }

void LayoutManagerRemoveTextContainer( NSLayoutManager *ref, NSUInteger index )
{ [ref removeTextContainerAtIndex:index]; }

void LayoutManagerSetTextContainer( NSLayoutManager *ref, NSTextContainer *tc, CFRange glyphRange )
{ [ref setTextContainer:tc forGlyphRange:NSRangeFromCFRange(glyphRange)]; }

void LayoutManagerTextContainerChangedGeometry( NSLayoutManager *ref, NSTextContainer *tc )
{ [ref textContainerChangedGeometry:tc]; }

void LayoutManagerTextContainerChangedTextView( NSLayoutManager *ref, NSTextContainer *tc )
{ [ref textContainerChangedTextView:tc]; }

NSTextContainer *LayoutManagerTextContainerForGlyph( NSLayoutManager *ref, NSUInteger index, CFRange *effectiveRange )
{ return [ref textContainerForGlyphAtIndex:index effectiveRange:(NSRange *)effectiveRange]; }

NSTextContainer *LayoutManagerTextContainerForGlyphWithoutAdditionalLayout( NSLayoutManager *ref, NSUInteger index, CFRange *effectiveRange, BOOL flag )
{ return [ref textContainerForGlyphAtIndex:index effectiveRange:(NSRange *)effectiveRange withoutAdditionalLayout:flag]; }

CGRect LayoutManagerUsedRectForTextContainer( NSLayoutManager *ref, NSTextContainer *tc )
{ return NSRectToCGRect([ref usedRectForTextContainer:tc]); }

// Global layout manager options
BOOL LayoutManagerAllowsNonContiguousLayout( NSLayoutManager *ref )
{ return [ref allowsNonContiguousLayout]; }

void LayoutManagerSetAllowsNonContiguousLayout( NSLayoutManager *ref, BOOL flag )
{ [ref setAllowsNonContiguousLayout:flag]; }

BOOL LayoutManagerHasNonContiguousLayout( NSLayoutManager *ref )
{ return [ref hasNonContiguousLayout]; }

float LayoutManagerHyphenationFactor(NSLayoutManager *ref )
{ return [ref hyphenationFactor]; }

void LayoutManagerSetHyphenationFactor(NSLayoutManager *ref, float factor )
{ [ref setHyphenationFactor:factor]; }

BOOL LayoutManagerShowsInvisibleCharacters( NSLayoutManager *ref )
{ return [ref showsInvisibleCharacters]; }

void LayoutManagerSetShowsInvisibleCharacters( NSLayoutManager *ref, BOOL flag )
{ [ref setShowsInvisibleCharacters:flag]; }

BOOL LayoutManagerShowsControlCharacters( NSLayoutManager *ref )
{ return [ref showsControlCharacters]; }

void LayoutManagerSetShowsControlCharacters( NSLayoutManager *ref, BOOL flag )
{ [ref setShowsControlCharacters:flag]; }

BOOL LayoutManagerUsesFontLeading( NSLayoutManager *ref )
{ return [ref usesFontLeading]; }

void LayoutManagerSetUsesFontLeading( NSLayoutManager *ref, BOOL flag )
{ [ref setUsesFontLeading:flag]; }

BOOL LayoutManagerBackgroundLayoutEnabled( NSLayoutManager *ref )
{ return [ref backgroundLayoutEnabled]; }

void LayoutManagerSetBackgroundLayoutEnabled( NSLayoutManager *ref, BOOL flag )
{ [ref setBackgroundLayoutEnabled:flag]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
BOOL LayoutManagerUsesDefaultHyphenation( NSLayoutManager *ref )
{ return [ref usesDefaultHyphenation]; }

void LayoutManagerSetUsesDefaultHyphenation( NSLayoutManager *ref, BOOL flag )
{ [ref setUsesDefaultHyphenation:flag]; }
#endif// 101500

// Invalidate glyphs and layout
void LayoutManagerInvalidateDisplayForCharacterRange( NSLayoutManager *ref, CFRange range )
{ [ref invalidateDisplayForCharacterRange:NSRangeFromCFRange(range)]; }

void LayoutManagerInvalidateDisplayForGlyphRange( NSLayoutManager *ref, CFRange range )
{ [ref invalidateDisplayForGlyphRange:NSRangeFromCFRange(range)]; }

void LayoutManagerInvalidateGlyphsForCharacterRange( NSLayoutManager *ref, CFRange range, NSInteger delta, CFRange *actualCharacterRange )
{ [ref invalidateGlyphsForCharacterRange:NSRangeFromCFRange(range) changeInLength:delta actualCharacterRange:(NSRange *)actualCharacterRange]; }

void LayoutManagerInvalidateLayoutForCharacterRange( NSLayoutManager *ref, CFRange range, CFRange *actualCharacterRange )
{ [ref invalidateLayoutForCharacterRange:NSRangeFromCFRange(range) actualCharacterRange:(NSRange *)actualCharacterRange]; }

void LayoutManagerProcessEditingForTextStorage( NSLayoutManager *ref, NSTextStorage *textStorage, NSTextStorageEditActions edited, CFRange range, NSInteger delta, CFRange invalidatedRange )
{ [ref processEditingForTextStorage:textStorage edited:edited range:NSRangeFromCFRange(range) changeInLength:delta invalidatedRange:NSRangeFromCFRange(invalidatedRange)]; }

// Glyph generation and layout
void LayoutManagerEnsureGlyphsForCharacterRange( NSLayoutManager *ref, CFRange range )
{ [ref ensureGlyphsForCharacterRange:NSRangeFromCFRange(range)]; }

void LayoutManagerEnsureGlyphsForGlyphRange( NSLayoutManager *ref, CFRange range )
{ [ref ensureGlyphsForGlyphRange:NSRangeFromCFRange(range)]; }

void LayoutManagerEnsureLayoutForBoundingRect( NSLayoutManager *ref, CGRect r, NSTextContainer *tc )
{ [ref ensureLayoutForBoundingRect:NSRectFromCGRect(r) inTextContainer:tc]; }

void LayoutManagerEnsureLayoutForCharacterRange( NSLayoutManager *ref, CFRange range )
{ [ref ensureLayoutForCharacterRange:NSRangeFromCFRange(range)]; }

void LayoutManagerEnsureLayoutForGlyphRange( NSLayoutManager *ref, CFRange range )
{ [ref ensureLayoutForGlyphRange:NSRangeFromCFRange(range)]; }

void LayoutManagerEnsureLayoutForTextContainer( NSLayoutManager *ref, NSTextContainer *tc )
{ [ref ensureLayoutForTextContainer:tc]; }

NSGlyphGenerator *LayoutManagerGlyphGenerator( NSLayoutManager *ref )
{ return [ref glyphGenerator]; }

// Accessing glyphs
NSUInteger LayoutManagerGetGlyphs( NSLayoutManager *ref, CFRange range, CGGlyph *glyphBuffer, NSGlyphProperty *props, NSUInteger *charIndexBuffer, unsigned char *bidiLevelsBuffer )
{ return [ref getGlyphsInRange:NSRangeFromCFRange(range) glyphs:glyphBuffer properties:props characterIndexes:charIndexBuffer bidiLevels:bidiLevelsBuffer]; }

CGGlyph LayoutManagerCGGlyphAtIndex( NSLayoutManager *ref, NSUInteger glyphIndex )
{ return [ref CGGlyphAtIndex:glyphIndex]; }

CGGlyph LayoutManagerCGGlyphAtIndexIsValidIndex( NSLayoutManager *ref, NSUInteger glyphIndex, BOOL *isValidIndex )
{ return [ref CGGlyphAtIndex:glyphIndex isValidIndex:isValidIndex]; }

void LayoutManagerSetCGGlyphs( NSLayoutManager *ref, CGGlyph *glyphs, NSGlyphProperty *props, NSUInteger *charIndexes, NSFont *font, CFRange glyphRange )
{ [ref setGlyphs:glyphs properties:props characterIndexes:charIndexes font:font forGlyphRange:NSRangeFromCFRange(glyphRange)]; }

NSUInteger LayoutManagerCharacterIndexForGlyphAtIndex( NSLayoutManager *ref, NSUInteger glyphIndex )
{ return [ref characterIndexForGlyphAtIndex:glyphIndex]; }

NSUInteger LayoutManagerGlyphIndexForCharacterAtIndex( NSLayoutManager *ref, NSUInteger charIndex )
{ return [ref glyphIndexForCharacterAtIndex:charIndex]; }

BOOL LayoutManagerIsValidGlyphIndex( NSLayoutManager *ref, NSUInteger glyphIndex )
{ return [ref isValidGlyphIndex:glyphIndex]; }

NSUInteger LayoutManagerNumberOfGlyphs( NSLayoutManager *ref )
{ return [ref numberOfGlyphs]; }

NSGlyphProperty LayoutManagerPropertyForGlyphAtIndex( NSLayoutManager *ref, NSUInteger glyphIndex )
{ return [ref propertyForGlyphAtIndex:glyphIndex]; }

// Set layout info
void LayoutManagerSetAttachmentSize( NSLayoutManager *ref, CGSize size, CFRange glyphRange )
{ [ref setAttachmentSize:NSSizeFromCGSize(size) forGlyphRange:NSRangeFromCFRange(glyphRange)]; }

void LayoutManagerSetDrawsOutsideLineFragment( NSLayoutManager *ref, BOOL flag, NSUInteger glyphIndex )
{ [ref setDrawsOutsideLineFragment:flag forGlyphAtIndex:glyphIndex]; }

void LayoutManagerSetExtraLineFragmentRect( NSLayoutManager *ref, CGRect r, CGRect usedRect, NSTextContainer *textContainer )
{ [ref setExtraLineFragmentRect:NSRectFromCGRect(r) usedRect:NSRectFromCGRect(usedRect) textContainer:textContainer]; }

void LayoutManagerSetLineFragmentRect( NSLayoutManager *ref, CGRect r, CFRange glyphRange, CGRect usedRect )
{ [ref setLineFragmentRect:NSRectFromCGRect(r) forGlyphRange:NSRangeFromCFRange(glyphRange) usedRect:NSRectFromCGRect(usedRect)]; }

void LayoutManagerSetLocation( NSLayoutManager *ref, CGPoint pt, CFRange startOfGlyphRange )
{ [ref setLocation:NSPointFromCGPoint(pt) forStartOfGlyphRange:NSRangeFromCFRange(startOfGlyphRange)]; }

void LayoutManagerSetNotShownAttribute( NSLayoutManager *ref, BOOL flag, NSUInteger glyphIndex )
{ [ref setNotShownAttribute:flag forGlyphAtIndex:glyphIndex]; }

// Get layout info
CGSize LayoutManagerAttachmentSizeForGlyphAtIndex( NSLayoutManager *ref, NSUInteger index )
{ return NSSizeToCGSize([ref attachmentSizeForGlyphAtIndex:index]); }

BOOL LayoutManagerDrawsOutsideLineFragmentForGlyphAtIndex( NSLayoutManager *ref, NSUInteger index )
{ return [ref drawsOutsideLineFragmentForGlyphAtIndex:index]; }

CGRect LayoutManagerExtraLineFragmentRect( NSLayoutManager *ref )
{ return NSRectToCGRect([ref extraLineFragmentRect]); }

NSTextContainer *LayoutManagerExtraLineFragmentTextContainer( NSLayoutManager *ref )
{ return [ref extraLineFragmentTextContainer]; }

CGRect LayoutManagerExtraLineFragmentUsedRect( NSLayoutManager *ref )
{ return NSRectToCGRect([ref extraLineFragmentUsedRect]); }

NSUInteger LayoutManagerFirstUnlaidCharacterIndex( NSLayoutManager *ref )
{ return [ref firstUnlaidCharacterIndex]; }

NSUInteger LayoutManagerFirstUnlaidGlyphIndex( NSLayoutManager *ref )
{ return [ref firstUnlaidGlyphIndex]; }

void LayoutManagerGetFirstUnlaidCharacterIndex( NSLayoutManager *ref, NSUInteger *charIndex, NSUInteger *glyphIndex )
{ [ref getFirstUnlaidCharacterIndex:charIndex glyphIndex:glyphIndex]; }

CGRect LayoutManagerLineFragmentRectForGlyphAtIndex( NSLayoutManager *ref, NSUInteger index, CFRange *effectiveRange )
{ return NSRectToCGRect([ref lineFragmentRectForGlyphAtIndex:index effectiveRange:(NSRange *)effectiveRange]); }

CGRect LayoutManagerLineFragmentRectForGlyphAtIndexWithoutAdditionalLayout( NSLayoutManager *ref, NSUInteger index, CFRange *effectiveRange, BOOL flag )
{ return NSRectToCGRect([ref lineFragmentRectForGlyphAtIndex:index effectiveRange:(NSRange *)effectiveRange withoutAdditionalLayout:flag]); }

CGRect LayoutManagerExtraLineFragmentUsedRectForGlyphAtIndex( NSLayoutManager *ref, NSUInteger index, CFRange *effectiveRange )
{ return NSRectToCGRect([ref lineFragmentUsedRectForGlyphAtIndex:index effectiveRange:(NSRange *)effectiveRange]); }

CGRect LayoutManagerExtraLineFragmentUsedRectForGlyphAtIndexWithoutAdditionalLayout( NSLayoutManager *ref, NSUInteger index, CFRange *effectiveRange, BOOL flag )
{ return NSRectToCGRect([ref lineFragmentUsedRectForGlyphAtIndex:index effectiveRange:(NSRange *)effectiveRange withoutAdditionalLayout:flag]); }

CGPoint LayoutManagerLocationForGlyphAtIndex( NSLayoutManager *ref, NSUInteger index )
{ return NSPointToCGPoint([ref locationForGlyphAtIndex:index]); }

BOOL LayoutManagerNotShownAttributeForGlyphAtIndex( NSLayoutManager *ref, NSUInteger index )
{ return [ref notShownAttributeForGlyphAtIndex:index]; }

CFRange LayoutManagerTruncatedGlyphRangeInLineFragmentForGlyphAtIndex( NSLayoutManager *ref, NSUInteger index )
{ return NSRangeToCFRange([ref truncatedGlyphRangeInLineFragmentForGlyphAtIndex:index]); }

// Advanced layout queries
CGRect LayoutManagerBoundingRectForGlyphRange( NSLayoutManager *ref, CFRange glyphRange, NSTextContainer *tc )
{ return NSRectToCGRect([ref boundingRectForGlyphRange:NSRangeFromCFRange(glyphRange) inTextContainer:tc]); }

NSUInteger LayoutManagerCharacterIndexForPoint( NSLayoutManager *ref, CGPoint pt, NSTextContainer *tc, CGFloat *partialFraction )
{ return [ref characterIndexForPoint:NSPointFromCGPoint(pt) inTextContainer:tc fractionOfDistanceBetweenInsertionPoints:partialFraction]; }

CFRange LayoutManagerCharacterRangeForGlyphRange( NSLayoutManager *ref, CFRange glyphRange, CFRange *actualGlyphRange )
{ return NSRangeToCFRange([ref characterRangeForGlyphRange:NSRangeFromCFRange(glyphRange) actualGlyphRange:(NSRange *)actualGlyphRange]); }

CFRange LayoutManagerGlyphRangeForBoundingRect( NSLayoutManager *ref, CGRect bounds, NSTextContainer *tc )
{ return NSRangeToCFRange([ref glyphRangeForBoundingRect:NSRectFromCGRect(bounds) inTextContainer:tc]); }

CFRange LayoutManagerGlyphRangeForTextContainer( NSLayoutManager *ref, NSTextContainer *tc )
{ return NSRangeToCFRange([ref glyphRangeForTextContainer:tc]); }

CFRange LayoutManagerGlyphRangeForCharacterRange( NSLayoutManager *ref, CFRange charRange, CFRange *actualCharacterRange )
{ return NSRangeToCFRange([ref glyphRangeForCharacterRange:NSRangeFromCFRange(charRange) actualCharacterRange:(NSRange *)actualCharacterRange]); }

void LayoutManagerEnumerateEnclosingRectsForGlyphRange( NSLayoutManager *ref, CFRange glyphRange, CFRange selectedGlyphRange, NSTextContainer *textContainer, CUI_LayoutManagerEnumerateEnclosingRectsForGlyphRangeHandlerType handler, void *userData )
{
    [ref enumerateEnclosingRectsForGlyphRange:NSRangeFromCFRange(glyphRange) withinSelectedGlyphRange:NSRangeFromCFRange(selectedGlyphRange) inTextContainer:textContainer usingBlock:^(NSRect rect,BOOL *stop) {
        (*handler)(ref,NSRectToCGRect(rect),stop,userData);
    }];
}

void LayoutManagerEnumerateLineFragmentsForGlyphRange( NSLayoutManager *ref, CFRange glyphRange, CUI_LayoutManagerEnumerateLineFragmentsForGlyphRangeHandlerType handler, void *userData )
{
    [ref enumerateLineFragmentsForGlyphRange:NSRangeFromCFRange(glyphRange) usingBlock:^(NSRect rect,NSRect usedRect,NSTextContainer *textContainer,NSRange glyphRange,BOOL *stop) {
        (*handler)(ref,NSRectToCGRect(rect),NSRectToCGRect(usedRect),textContainer,NSRangeToCFRange(glyphRange),stop,userData);
    }];
}

CGFloat LayoutManagerFractionOfDistanceThroughGlyphForPoint( NSLayoutManager *ref, CGPoint pt, NSTextContainer *textContainer )
{ return [ref fractionOfDistanceThroughGlyphForPoint:NSPointFromCGPoint(pt) inTextContainer:textContainer]; }

NSUInteger LayoutManagerGetLineFragmentInsertionPointsForCharacterAtIndex( NSLayoutManager *ref, NSUInteger charIndex, BOOL alternatePositions, BOOL inDisplayOrder, CGFloat *positions, NSUInteger *charIndexes )
{ return [ref getLineFragmentInsertionPointsForCharacterAtIndex: charIndex alternatePositions:alternatePositions inDisplayOrder:inDisplayOrder positions:positions characterIndexes:charIndexes]; }

NSUInteger LayoutManagerGlyphIndexForPoint( NSLayoutManager *ref, CGPoint pt, NSTextContainer *textContainer )
{ return [ref glyphIndexForPoint:NSPointFromCGPoint(pt) inTextContainer:textContainer]; }

NSUInteger LayoutManagerGlyphIndexForPointFractionOfDistanceThroughGlyph( NSLayoutManager *ref, CGPoint pt, NSTextContainer *textContainer, CGFloat *partialFraction )
{ return [ref glyphIndexForPoint:NSPointFromCGPoint(pt) inTextContainer:textContainer fractionOfDistanceThroughGlyph:partialFraction]; }

CFRange LayoutManagerGlyphRangeForBoundingRectWithoutAdditionalLayout( NSLayoutManager *ref, CGRect bounds, NSTextContainer *tc )
{ return NSRangeToCFRange([ref glyphRangeForBoundingRect:NSRectFromCGRect(bounds) inTextContainer:tc]); }

CFRange LayoutManagerRangeOfNominallySpacedGlyphsContainingIndex( NSLayoutManager *ref, NSUInteger glyphIndex )
{ return NSRangeToCFRange([ref rangeOfNominallySpacedGlyphsContainingIndex:glyphIndex]); }

// Drawing
void LayoutManagerDrawBackgroundForGlyphRange( NSLayoutManager *ref, CFRange glyphsToShow, CGPoint origin )
{ [ref drawBackgroundForGlyphRange:NSRangeFromCFRange(glyphsToShow) atPoint:NSPointFromCGPoint(origin)]; }

void LayoutManagerDrawGlyphsForGlyphRange( NSLayoutManager *ref, CFRange glyphsToShow, CGPoint origin )
{ [ref drawGlyphsForGlyphRange:NSRangeFromCFRange(glyphsToShow) atPoint:NSPointFromCGPoint(origin)]; }

void LayoutManagerDrawStrikethroughForGlyphRange( NSLayoutManager *ref, CFRange glyphRange, NSInteger strikethroughType, CGFloat baselineOffset, CGRect lineRect, CFRange lineGlyphRange, CGPoint origin )
{ [ref drawStrikethroughForGlyphRange:NSRangeFromCFRange(glyphRange) strikethroughType:strikethroughType baselineOffset:baselineOffset lineFragmentRect:NSRectFromCGRect(lineRect) lineFragmentGlyphRange:NSRangeFromCFRange(lineGlyphRange) containerOrigin:NSPointFromCGPoint(origin)]; }

void LayoutManagerDrawUnderlineForGlyphRange( NSLayoutManager *ref, CFRange glyphRange, NSInteger underlineType, CGFloat baselineOffset, CGRect lineRect, CFRange lineGlyphRange, CGPoint origin )
{ [ref drawUnderlineForGlyphRange:NSRangeFromCFRange(glyphRange) underlineType:underlineType baselineOffset:baselineOffset lineFragmentRect:NSRectFromCGRect(lineRect) lineFragmentGlyphRange:NSRangeFromCFRange(lineGlyphRange) containerOrigin:NSPointFromCGPoint(origin)]; }

void LayoutManagerFillBackgroundRectArray( NSLayoutManager *ref, CGRect *rectArray, NSUInteger rectCount, CFRange charRange, NSColor *color )
{ [ref fillBackgroundRectArray:(NSRect *)rectArray count:rectCount forCharacterRange:NSRangeFromCFRange(charRange) color:color]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
void LayoutManagerShowCGGlyphs( NSLayoutManager *ref, CGGlyph *glyphs, CGPoint *positions, NSUInteger glyphCount, NSFont *font, CGAffineTransform textMatrix, CFDictionaryRef attributes, CGContextRef context )
{ [ref showCGGlyphs:glyphs positions:positions count:glyphCount font:font textMatrix:textMatrix attributes:(__bridge NSDictionary *)attributes inContext:context]; }
#endif// 101500

void LayoutManagerStrikethroughGlyphRange( NSLayoutManager *ref, CFRange glyphRange, NSInteger strikethroughType, CGRect lineRect, CFRange lineGlyphRange, CGPoint containerOrigin )
{ [ref strikethroughGlyphRange:NSRangeFromCFRange(glyphRange) strikethroughType:strikethroughType lineFragmentRect:NSRectFromCGRect(lineRect) lineFragmentGlyphRange:NSRangeFromCFRange(lineGlyphRange) containerOrigin:NSPointFromCGPoint(containerOrigin)]; }

void LayoutManagerUnderlineGlyphRange( NSLayoutManager *ref, CFRange glyphRange, NSInteger underlineType, CGRect lineRect, CFRange lineGlyphRange, CGPoint containerOrigin )
{ [ref underlineGlyphRange:NSRangeFromCFRange(glyphRange) underlineType:underlineType lineFragmentRect:NSRectFromCGRect(lineRect) lineFragmentGlyphRange:NSRangeFromCFRange(lineGlyphRange) containerOrigin:NSPointFromCGPoint(containerOrigin)]; }

// Text blocks
void LayoutManagerSetLayoutRectForTextBlock( NSLayoutManager *ref, CGRect rect, NSTextBlock *textBlock, CFRange glyphRange )
{ [ref setLayoutRect:NSRectFromCGRect(rect) forTextBlock:textBlock glyphRange:NSRangeFromCFRange(glyphRange)]; }

CGRect LayoutManagerLayoutRectForTextBlock( NSLayoutManager *ref, NSTextBlock *textBlock, CFRange glyphRange )
{ return NSRectToCGRect([ref layoutRectForTextBlock:textBlock glyphRange:NSRangeFromCFRange(glyphRange)]); }

void LayoutManagerSetBoundsRectForTextBlock( NSLayoutManager *ref, CGRect rect, NSTextBlock *textBlock, CFRange glyphRange )
{ [ref setBoundsRect:NSRectFromCGRect(rect) forTextBlock:textBlock glyphRange:NSRangeFromCFRange(glyphRange)]; }

CGRect LayoutManagerBoundsRectForTextBlock( NSLayoutManager *ref, NSTextBlock*textBlock, CFRange glyphRange )
{ return NSRectToCGRect([ref boundsRectForTextBlock:textBlock glyphRange:NSRangeFromCFRange(glyphRange)]); }

CGRect LayoutManagerLayoutRectForTextBlockAtIndex( NSLayoutManager *ref, NSTextBlock *textBlock, NSUInteger glyphIndex, CFRange *effectiveGlyphRange )
{ return NSRectToCGRect([ref layoutRectForTextBlock:textBlock atIndex:glyphIndex effectiveRange:(NSRange *)effectiveGlyphRange]); }

CGRect LayoutManagerBoundsRectForTextBlockAtIndex( NSLayoutManager *ref, NSTextBlock *textBlock, NSUInteger glyphIndex, CFRange *effectiveGlyphRange )
{ return NSRectToCGRect([ref boundsRectForTextBlock:textBlock atIndex:glyphIndex effectiveRange:(NSRange *)effectiveGlyphRange]); }

// Attachments
NSImageScaling LayoutManagerDefaultAttachmentScaling( NSLayoutManager *ref )
{ return [ref defaultAttachmentScaling]; }

void LayoutManagerSetDefaultAttachmentScaling( NSLayoutManager *ref, NSImageScaling scaling )
{ [ref setDefaultAttachmentScaling: scaling]; }

void LayoutManagerShowAttachmentCellInRect( NSLayoutManager *ref, NSCell *cell, CGRect rect, NSUInteger characterIndex )
{ [ref showAttachmentCell:cell inRect:NSRectFromCGRect(rect) characterIndex:characterIndex]; }

// Rulers
NSView *LayoutManagerRulerAccessoryViewForTextView( NSLayoutManager *ref, NSInteger txtViewTag, NSParagraphStyle *paraStyle, NSRulerView *ruler, BOOL enabled )
{
    NSTextView *textView = TextViewWithTag( txtViewTag );
    if ( textView ) {
        return [ref rulerAccessoryViewForTextView:textView paragraphStyle:paraStyle ruler:ruler enabled:enabled];
    }
    return nil;
}

CFArrayRef LayoutManagerRulerMarkersForTextView( NSLayoutManager *ref, NSInteger txtViewTag, NSParagraphStyle *paraStyle, NSRulerView *ruler )
{
    NSTextView *textView = TextViewWithTag( txtViewTag );
    if ( textView ) {
        return (__bridge CFArrayRef)[ref rulerMarkersForTextView:textView paragraphStyle:paraStyle ruler:ruler];
    }
    return nil;
}

// Responder chain
BOOL LayoutManagerOwnsFirstResponderInWindow( NSLayoutManager *ref, NSInteger wndTag )
{
    NSWindow *w = CUI_WindowWithTag( wndTag );
    if ( w ) {
        return [ref layoutManagerOwnsFirstResponderInWindow:w];
    }
    return NO;
}

NSInteger LayoutManagerFirstTextView( NSLayoutManager *ref )
{
    NSTextView *textView = [ref firstTextView];
    if ( textView ) {
        return [textView tag];
    }
    return 0;
}

NSInteger LayoutManagerTextViewForBeginningOfSelection( NSLayoutManager *ref )
{
    NSTextView *textView = [ref textViewForBeginningOfSelection];
    if ( textView ) {
        return [textView tag];
    }
    return 0;
}

// Typesetter
NSTypesetter *LayoutManagerTypesetter( NSLayoutManager *ref )
{ return [ref typesetter]; }

void LayoutManagerSetTypesetter( NSLayoutManager *ref, NSTypesetter *typesetter )
{ [ref setTypesetter:typesetter]; }

NSTypesetterBehavior LayoutManagerTypesetterBehavior( NSLayoutManager *ref )
{ return [ref typesetterBehavior]; }

void LayoutManagerSetTypesetterBehavior( NSLayoutManager *ref, NSTypesetterBehavior behavior )
{ [ref setTypesetterBehavior:behavior]; }

CGFloat LayoutManagerDefaultLineHeightForFont( NSLayoutManager *ref, NSFont *font )
{ return [ref defaultLineHeightForFont:font]; }

CGFloat LayoutManagerDefaultBaselineOffsetForFont( NSLayoutManager *ref, NSFont *font )
{ return [ref defaultBaselineOffsetForFont:font]; }

// Temporary attribute support
void LayoutManagerAddTemporaryAttributes( NSLayoutManager *ref, CFDictionaryRef attrs, CFRange charRange )
{ [ref addTemporaryAttributes:(__bridge NSDictionary *)attrs forCharacterRange:NSRangeFromCFRange(charRange)]; }

void LayoutManagerAddTemporaryAttribute( NSLayoutManager *ref, CFStringRef name, ObjectRef value, CFRange charRange )
{ [ref addTemporaryAttribute:(__bridge NSString *)name value:value forCharacterRange:NSRangeFromCFRange(charRange)]; }

void LayoutManagerSetTemporaryAttributes( NSLayoutManager *ref, CFDictionaryRef attrs, CFRange charRange )
{ [ref setTemporaryAttributes:(__bridge NSDictionary *)attrs forCharacterRange:NSRangeFromCFRange(charRange)]; }

void LayoutManagerRemoveTemporaryAttribute( NSLayoutManager *ref, CFStringRef name, CFRange charRange )
{ [ref removeTemporaryAttribute:(__bridge NSString *)name forCharacterRange:NSRangeFromCFRange(charRange)]; }

ObjectRef LayoutManagerTemporaryAttribute( NSLayoutManager *ref, CFStringRef name, NSUInteger charIndex, CFRange *effectiveRange )
{ return [ref temporaryAttribute:(__bridge NSString *)name atCharacterIndex:charIndex effectiveRange:(NSRange *)effectiveRange]; }

ObjectRef LayoutManagerTemporaryAttributeInRange( NSLayoutManager *ref, CFStringRef name, NSUInteger charIndex, CFRange *longestEffectiveRange, CFRange range )
{ return [ref temporaryAttribute:(__bridge NSString *)name atCharacterIndex:charIndex longestEffectiveRange:(NSRange *)longestEffectiveRange inRange:NSRangeFromCFRange(range)]; }

CFDictionaryRef LayoutManagerTemporaryAttributes( NSLayoutManager *ref, NSUInteger charIndex, CFRange *effectiveRange )
{ return (__bridge CFDictionaryRef)[ref temporaryAttributesAtCharacterIndex:charIndex effectiveRange:(NSRange *)effectiveRange]; }
    
CFDictionaryRef LayoutManagerTemporaryAttributesInRange( NSLayoutManager *ref, NSUInteger charIndex, CFRange *longestEffectiveRange, CFRange range )
{ return (__bridge CFDictionaryRef)[ref temporaryAttributesAtCharacterIndex:charIndex longestEffectiveRange:(NSRange *)longestEffectiveRange inRange:NSRangeFromCFRange(range)]; }

