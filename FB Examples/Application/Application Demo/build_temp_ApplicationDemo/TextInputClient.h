/*
 TextInputClient.h

 Bernie Wylde
 */

#import "CocoaUI.h"

// Marked text
BOOL TextInputClientHasMarkedText( NSInteger tag );
CFRange TextInputClientMarkedRange( NSInteger tag );
CFRange TextInputClientSelectedRange( NSInteger tag );
void TextInputClientSetMarkedText( NSInteger tag, ObjectRef string, CFRange selectedRange, CFRange replacementRange );
void TextInputClientUnmarkText( NSInteger tag );
CFArrayRef TextInputClientValidAttributesForMarkedText( NSInteger tag );

// Storing
CFAttributedStringRef TextInputClientAttributedSubstring( NSInteger tag, CFRange proposedRange, CFRange *actualRange );
void TextInputClientInsertText( NSInteger tag, ObjectRef string, CFRange replacementRange );

// Character coordinates
NSUInteger TextInputClientCharacterIndexForPoint( NSInteger tag, CGPoint pt );
CGRect TextInputClientFirstRectForCharacterRange( NSInteger tag, CFRange range, CFRange *actualRange );

// Binding keystrokes
void TextInputClientDoCommandBySelector( NSInteger tag, CFStringRef selectorString );

// Optional methods
CFAttributedStringRef TextInputClientAttributedString( NSInteger tag );
CGFloat TextInputClientFractionOfDistanceThroughGlyphForPoint( NSInteger tag, CGPoint pt );
CGFloat TextInputClientBaselineDeltaForCharacterAtIndex( NSInteger tag, NSUInteger index );
NSInteger TextInputClientWindowLevel( NSInteger tag );
BOOL TextInputClientDrawsVerticallyForCharacterAtIndex( NSInteger tag, NSUInteger index );

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
CGRect TextInputClientDocumentVisibleRect( NSInteger tag );
API_AVAILABLE(macos(14.0))
CGRect TextInputClientUnionRectInVisibleSelectedRange( NSInteger tag );
#endif // 140000
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
API_AVAILABLE(macos(15.0))
BOOL TextInputClientSupportsAdaptiveImageGlyph( NSInteger tag );
#endif // 150000

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
NSTextCursorAccessoryPlacement TextInputClientPreferredTextAccessoryPlacement( NSInteger tag );
#endif // 140000
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
API_AVAILABLE(macos(15.0))
void TextInputClientInsertAdaptiveImageGlyph( NSInteger tag, NSAdaptiveImageGlyph *glyph, CFRange replacementRange );
#endif // 150000

