/*
 Text.m

 Bernie Wylde
 */

#import "Text.h"

// Class
Class TextClass( void )
{ return [NSText class]; }

NSText *TextWithTag( NSInteger tag )
{ return (NSText *)CUI_ValidateViewKindOfClass( tag, [NSText class] ); }

// Graphics attributes
NSColor *TextBackgroundColor( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) return [txtObj backgroundColor];
    return nil;
}

void TextSetBackgroundColor( NSInteger tag, NSColor *col )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj setBackgroundColor:col];
}

CFStringRef TextString( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) return (__bridge CFStringRef)[txtObj string];
    return nil;
}

void TextSetString( NSInteger tag, CFStringRef string )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj setString:(__bridge NSString *)string];
}

CFRange TextSelectedRange( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) {
        NSRange range = [txtObj selectedRange];
        return NSRangeToCFRange( range );
    }
    return CFRangeMake(0,0);
}

void TextSetSelectedRange( NSInteger tag, CFRange range )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj setSelectedRange:NSRangeFromCFRange(range)];
}

CFTypeRef TextFont( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) return (__bridge CFTypeRef)[txtObj font];
    return nil;
}

void TextSetFont( NSInteger tag, CFTypeRef inFont )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) {
        NSFont *font = CUI_FixFont( (const void *)inFont );
        [txtObj setFont:(NSFont *)font];
    }
}

void TextSetFontInRange( NSInteger tag, CFTypeRef inFont, CFRange range )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) {
        NSFont *font = CUI_FixFont( (const void *)inFont );
        [txtObj setFont:font range:NSRangeFromCFRange(range)];
    }
}

void TextSetFontWithName( NSInteger tag, CFStringRef inName, CGFloat size )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) {
        BOOL usePrevFont = NO;
        NSString *name = (__bridge NSString *)inName;
        if ( name ) {
            usePrevFont = ( [name length] == 0 );
        } else {
            usePrevFont = YES;
        }
        if ( usePrevFont ) name = [[txtObj font] fontName];
        if ( (int)size == 0 ) size = [[txtObj font] pointSize];
        
        [txtObj setFont:[NSFont fontWithName:name size:size]];
    }
}

void TextSetFontWithNameInRange( NSInteger tag, CFStringRef inName, CGFloat size, CFRange range )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) {
        BOOL usePrevFont = NO;
        NSString *name = (__bridge NSString *)inName;
        if ( name ) {
            usePrevFont = ( [name length] == 0 );
        } else {
            usePrevFont = YES;
        }
        if ( usePrevFont ) name = [[txtObj font] fontName];
        if ( (int)size == 0 ) size = [[txtObj font] pointSize];
        
        [txtObj setFont:[NSFont fontWithName:name size:size] range:NSRangeFromCFRange(range)];
    }
}

BOOL TextReadRTFDFromURL( NSInteger tag, CFURLRef url )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) return [txtObj readRTFDFromFile:[(__bridge NSURL *)url path]];
    return NO;
}

BOOL TextWriteRTFDToURL( NSInteger tag, CFURLRef url, BOOL atomically )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) return [txtObj writeRTFDToFile:[(__bridge NSURL *)url path] atomically:atomically];
    return NO;
}

void TextShowGuessPanel( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj showGuessPanel:nil];
}

// Constraining size
CGSize TextMaxSize( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) return NSSizeToCGSize([txtObj maxSize]);
    return CGSizeZero;
}

void TextSetMaxSize( NSInteger tag, CGSize size )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj setMaxSize:NSSizeFromCGSize(size)];
}

CGSize TextMinSize( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) return NSSizeToCGSize([txtObj minSize]);
    return CGSizeZero;
}

void TextSetMinSize( NSInteger tag, CGSize size )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj setMinSize:NSSizeFromCGSize(size)];
}

BOOL TextIsVerticallyResizable( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) return [txtObj isVerticallyResizable];
    return NO;
}

void TextSetVerticallyResizable( NSInteger tag, BOOL flag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj setVerticallyResizable:flag];
}

BOOL TextIsHorizontallyResizable( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) return [txtObj isHorizontallyResizable];
    return NO;
}

void TextSetHorizontallyResizable( NSInteger tag, BOOL flag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj setHorizontallyResizable:flag];
}

void TextSizeToFit( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj sizeToFit];
}


void TextSelectAll( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj selectAll:nil];
}

void TextCopy( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj copy:nil];
}

void TextCut( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj cut:nil];
}

void TextPaste( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj paste:nil];
}

void TextCopyFont( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj copyFont:nil];
}

void TextPasteFont( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj pasteFont:nil];
}

void TextDelete( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj delete:nil];
}

NSTextAlignment TextAlignment( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) return [txtObj alignment];
    return 0;
}

void TextSetAlignment( NSInteger tag, NSTextAlignment alignment )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj setAlignment:alignment];
}

void TextAlignCenter( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj alignCenter:nil];
}

void TextAlignLeft( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj alignLeft:nil];
}

void TextAlignRight( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj alignRight:nil];
}

NSColor *TextColor( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) return [txtObj textColor];
    return NULL;
}

void TextSetColor( NSInteger tag, NSColor *col )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj setTextColor:col];
}

void TextSetColorInRange( NSInteger tag, NSColor *col, CFRange range )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj setTextColor:col range:NSRangeFromCFRange(range)];
}

void TextSuperscript( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj superscript:nil];
}

void TextSubscript( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj subscript:nil];
}

void TextUnscript( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj unscript:nil];
}

void TextUnderline( NSInteger tag )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj underline:nil];
}

// - replacing text -
void TextReplaceCharactersInRangeWithString( NSInteger tag, CFRange range, CFStringRef string )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj replaceCharactersInRange:NSRangeFromCFRange(range) withString:(__bridge NSString *)string];
}

// - scrolling -
void TextScrollRangeToVisible( NSInteger tag, CFRange range )
{
    //NSText *txtObj = (NSText *)CUI_ViewWithTag( tag );
    NSText *txtObj = TextWithTag( tag );
    if ( txtObj ) [txtObj scrollRangeToVisible:NSRangeFromCFRange(range)];
}

