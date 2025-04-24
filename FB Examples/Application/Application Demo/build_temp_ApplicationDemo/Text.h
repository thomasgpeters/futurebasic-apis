/*
 Text.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// dialog events
enum {
    textDidBeginEditing = 2100,
    textDidChange,
    textDidEndEditing
};

// Class
Class TextClass( void );

NSText *TextWithTag( NSInteger tag );

// Graphics attributes
NSColor *TextBackgroundColor( NSInteger tag );
void TextSetBackgroundColor( NSInteger tag, NSColor *col );

CFStringRef TextString( NSInteger tag );
void TextSetString( NSInteger tag, CFStringRef string );
CFRange TextSelectedRange( NSInteger tag );
void TextSetSelectedRange( NSInteger tag, CFRange range );
CFTypeRef TextFont( NSInteger tag );
void TextSetFont( NSInteger tag, CFTypeRef inFont );
void TextSetFontInRange( NSInteger tag, CFTypeRef inFont, CFRange range );

void TextSetFontWithName( NSInteger tag, CFStringRef inName, CGFloat size );
void TextSetFontWithNameInRange( NSInteger tag, CFStringRef inName, CGFloat size, CFRange range );

BOOL TextReadRTFDFromURL( NSInteger tag, CFURLRef url );
BOOL TextWriteRTFDToURL( NSInteger tag, CFURLRef url, BOOL atomically );

void TextShowGuessPanel( NSInteger tag );

// Constraining size
CGSize TextMaxSize( NSInteger tag );
void TextSetMaxSize( NSInteger tag, CGSize size );
CGSize TextMinSize( NSInteger tag );
void TextSetMinSize( NSInteger tag, CGSize size );
BOOL TextIsVerticallyResizable( NSInteger tag );
void TextSetVerticallyResizable( NSInteger tag, BOOL flag );
BOOL TextIsHorizontallyResizable( NSInteger tag );
void TextSetHorizontallyResizable( NSInteger tag, BOOL flag );
void TextSizeToFit( NSInteger tag );

void TextSelectAll( NSInteger tag );
void TextCopy( NSInteger tag );
void TextCut( NSInteger tag );
void TextPaste( NSInteger tag );
void TextCopyFont( NSInteger tag );
void TextPasteFont( NSInteger tag );
void TextDelete( NSInteger tag );
NSTextAlignment TextAlignment( NSInteger tag );
void TextSetAlignment( NSInteger tag, NSTextAlignment alignment );
void TextAlignCenter( NSInteger tag );
void TextAlignLeft( NSInteger tag );
void TextAlignRight( NSInteger tag );
NSColor *TextColor( NSInteger tag );
void TextSetColor( NSInteger tag, NSColor *col );
void TextSetColorInRange( NSInteger tag, NSColor *col, CFRange range );
void TextSuperscript( NSInteger tag );
void TextSubscript( NSInteger tag );
void TextUnscript( NSInteger tag );
void TextUnderline( NSInteger tag );

// - replacing text -
void TextReplaceCharactersInRangeWithString( NSInteger tag, CFRange range, CFStringRef string );

// - scrolling -
void TextScrollRangeToVisible( NSInteger tag, CFRange range );
