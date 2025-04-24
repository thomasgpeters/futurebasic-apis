/*
 TextInputClient.m

 Bernie Wylde
 */

#import "TextInputClient.h"

// Marked text
BOOL TextInputClientHasMarkedText( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView hasMarkedText];
    return NO;
}

CFRange TextInputClientMarkedRange( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return NSRangeToCFRange( [textView markedRange] );
    return CFRangeMake(NSNotFound,0);
}

CFRange TextInputClientSelectedRange( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return NSRangeToCFRange( [textView selectedRange] );
    return CFRangeMake(NSNotFound,0);
}

void TextInputClientSetMarkedText( NSInteger tag, ObjectRef string, CFRange selectedRange, CFRange replacementRange )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setMarkedText:string selectedRange:NSRangeFromCFRange(selectedRange) replacementRange:NSRangeFromCFRange(replacementRange)];
}

void TextInputClientUnmarkText( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView unmarkText];
}

CFArrayRef TextInputClientValidAttributesForMarkedText( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return (__bridge CFArrayRef)[textView validAttributesForMarkedText];
    return nil;
}

// Storing
CFAttributedStringRef TextInputClientAttributedSubstring( NSInteger tag, CFRange proposedRange, CFRange *actualRange )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return (__bridge CFAttributedStringRef)[textView attributedSubstringForProposedRange:NSRangeFromCFRange(proposedRange) actualRange:(NSRangePointer)actualRange];
    return nil;
}

void TextInputClientInsertText( NSInteger tag, ObjectRef string, CFRange replacementRange )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView insertText:string replacementRange:NSRangeFromCFRange(replacementRange)];
}

// Character coordinates
NSUInteger TextInputClientCharacterIndexForPoint( NSInteger tag, CGPoint pt )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView characterIndexForPoint:NSPointFromCGPoint(pt)];
    return 0;
}

CGRect TextInputClientFirstRectForCharacterRange( NSInteger tag, CFRange range, CFRange *actualRange )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return NSRectToCGRect([textView firstRectForCharacterRange:NSRangeFromCFRange(range) actualRange:(NSRangePointer)actualRange]);
    return CGRectZero;
}

// Binding keystrokes
void TextInputClientDoCommandBySelector( NSInteger tag, CFStringRef selectorString )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        [textView doCommandBySelector:NSSelectorFromString( (__bridge NSString *)selectorString )];
    }
}

// Optional methods
CFAttributedStringRef TextInputClientAttributedString( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return (__bridge CFAttributedStringRef)[textView attributedString];
    return nil;
}

CGFloat TextInputClientFractionOfDistanceThroughGlyphForPoint( NSInteger tag, CGPoint pt )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView fractionOfDistanceThroughGlyphForPoint:NSPointFromCGPoint(pt)];
    return 0.0;
}

CGFloat TextInputClientBaselineDeltaForCharacterAtIndex( NSInteger tag, NSUInteger index )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView baselineDeltaForCharacterAtIndex:index];
    return 0.0;
}

NSInteger TextInputClientWindowLevel( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView windowLevel];
    return 0;
}

BOOL TextInputClientDrawsVerticallyForCharacterAtIndex( NSInteger tag, NSUInteger index )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView drawsVerticallyForCharacterAtIndex:index];
    return NO;
}

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
CGRect TextInputClientDocumentVisibleRect( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return NSRectToCGRect([textView documentVisibleRect]);
    return CGRectZero;
}

CGRect TextInputClientUnionRectInVisibleSelectedRange( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return NSRectToCGRect([textView unionRectInVisibleSelectedRange]);
    return CGRectZero;
}

#endif // 140000
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
BOOL TextInputClientSupportsAdaptiveImageGlyph( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView supportsAdaptiveImageGlyph];
    return NO;
}
#endif // 150000

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
NSTextCursorAccessoryPlacement TextInputClientPreferredTextAccessoryPlacement( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView preferredTextAccessoryPlacement];
    return 0;
}
#endif // 140000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
void TextInputClientInsertAdaptiveImageGlyph( NSInteger tag, NSAdaptiveImageGlyph *glyph, CFRange replacementRange )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView insertAdaptiveImageGlyph:glyph replacementRange:NSRangeFromCFRange(replacementRange)];
}
#endif // 150000
