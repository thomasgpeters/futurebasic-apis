/*
 ParagraphStyle.m

 Bernie Wylde
 */

#import "ParagraphStyle.h"

// Class
Class ParagraphStyleClass( void )
{ return [NSParagraphStyle class]; }

// - create -
NSParagraphStyle *ParagraphStyleDefaultStyle( void )
{ return [NSParagraphStyle defaultParagraphStyle]; }

// - style -
NSTextAlignment ParagraphStyleAlignment( NSParagraphStyle *ref )
{ return [ref alignment]; }

CGFloat ParagraphStyleFirstLineHeadIndent( NSParagraphStyle *ref )
{ return [ref firstLineHeadIndent]; }

CGFloat ParagraphStyleHeadIndent( NSParagraphStyle *ref )
{ return [ref headIndent]; }

CGFloat ParagraphStyleTailIndent( NSParagraphStyle *ref )
{ return [ref tailIndent]; }

CGFloat ParagraphStyleLineHeightMultiple( NSParagraphStyle *ref )
{ return [ref lineHeightMultiple]; }

CGFloat ParagraphStyleMaximumLineHeight( NSParagraphStyle *ref )
{ return [ref maximumLineHeight]; }

CGFloat ParagraphStyleMinimumLineHeight( NSParagraphStyle *ref )
{ return [ref minimumLineHeight]; }

CGFloat ParagraphStyleLineSpacing( NSParagraphStyle *ref )
{ return [ref lineSpacing]; }

CGFloat ParagraphStyleParagraphSpacing( NSParagraphStyle *ref )
{ return [ref paragraphSpacing]; }

CGFloat ParagraphStyleParagraphSpacingBefore( NSParagraphStyle *ref )
{ return [ref paragraphSpacingBefore]; }

// - tab info -
CFArrayRef ParagraphStyleTabStops( NSParagraphStyle *ref )
{ return (__bridge CFArrayRef)[ref tabStops]; }

CGFloat ParagraphStyleDefaultTabInterval( NSParagraphStyle *ref )
{ return [ref defaultTabInterval]; }

// - text block and list info -
CFArrayRef ParagraphStyleTextBlocks( NSParagraphStyle *ref )
{ return (__bridge CFArrayRef)[ref textBlocks]; }

CFArrayRef ParagraphStyleTextLists( NSParagraphStyle *ref )
{ return (__bridge CFArrayRef)[ref textLists]; }

// - line breaking info -
NSLineBreakMode ParagraphStyleLineBreakMode( NSParagraphStyle *ref )
{ return [ref lineBreakMode]; }

float ParagraphStyleHyphenationFactor( NSParagraphStyle *ref )
{ return [ref hyphenationFactor]; }

float ParagraphStyleTighteningFactorForTruncation( NSParagraphStyle *ref )
{ return [ref tighteningFactorForTruncation]; }

BOOL ParagraphStyleAllowsDefaultTighteningForTruncation( NSParagraphStyle *ref )
{ return [ref allowsDefaultTighteningForTruncation]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
BOOL ParagraphStyleUsesDefaultHyphenation( NSParagraphStyle *ref )
{ return [ref usesDefaultHyphenation]; }
#endif// 120000

// - HTML header level -
NSInteger ParagraphStyleHeaderLevel( NSParagraphStyle *ref )
{ return [ref headerLevel]; }

// - writing direction -
NSWritingDirection ParagraphStyleDefaultWritingDrectionForLanguage( CFStringRef languageName )
{ return [NSParagraphStyle defaultWritingDirectionForLanguage:(__bridge NSString *)languageName]; }

NSWritingDirection ParagraphStyleBaseWritingDirection( NSParagraphStyle *ref )
{ return [ref baseWritingDirection]; }


#pragma mark - mutable paragraph style
// Class
Class MutableParagraphStyleClass( void )
{ return [NSMutableParagraphStyle class]; }

// - init -
NSMutableParagraphStyle *MutableParagraphStyleInit( void )
{
#if __has_feature(objc_arc)
    return [[NSMutableParagraphStyle alloc] init];
#else
    return [[[NSMutableParagraphStyle alloc] init] autorelease];
#endif
}

NSMutableParagraphStyle *MutableParagraphStyleNew( void )
{
#if __has_feature(objc_arc)
    return [NSMutableParagraphStyle new];
#else
    return [[NSMutableParagraphStyle new] autorelease];
#endif
}

// - style info -
void MutableParagraphStyleSet( NSMutableParagraphStyle *ref, NSParagraphStyle *style )
{ [ref setParagraphStyle:style]; }

void MutableParagraphStyleSetAlignment( NSMutableParagraphStyle *ref, NSTextAlignment alignment )
{ [ref setAlignment:alignment]; }

void MutableParagraphStyleSetFirstLineHeadIndent( NSMutableParagraphStyle *ref, CGFloat indent )
{ [ref setFirstLineHeadIndent:indent]; }

void MutableParagraphStyleSetHeadIndent( NSMutableParagraphStyle *ref, CGFloat indent )
{ [ref setHeadIndent:indent]; }

void MutableParagraphStyleSetTailIndent( NSMutableParagraphStyle *ref, CGFloat indent )
{ [ref setTailIndent:indent]; }

void MutableParagraphStyleSetLineBreakMode( NSMutableParagraphStyle *ref, NSLineBreakMode lineBreakMode )
{ [ref setLineBreakMode:lineBreakMode]; }

void MutableParagraphStyleSetMaximumLineHeight( NSMutableParagraphStyle *ref, CGFloat height )
{ [ref setMaximumLineHeight:height]; }

void MutableParagraphStyleSetMinimumLineHeight( NSMutableParagraphStyle *ref, CGFloat height )
{ [ref setMinimumLineHeight:height]; }

void MutableParagraphStyleSetLineSpacing( NSMutableParagraphStyle *ref, CGFloat spacing )
{ [ref setLineSpacing:spacing]; }

void MutableParagraphStyleSetParagraphSpacing( NSMutableParagraphStyle *ref, CGFloat spacing )
{ [ref setParagraphSpacing:spacing]; }

void MutableParagraphStyleSetParagraphSpacingBefore( NSMutableParagraphStyle *ref, CGFloat spacing )
{ [ref setParagraphSpacingBefore:spacing]; }

void MutableParagraphStyleSetBaseWritingDirection( NSMutableParagraphStyle *ref, NSWritingDirection direction )
{ [ref setBaseWritingDirection:direction]; }

void MutableParagraphStyleSetLineHeightMultiple( NSMutableParagraphStyle *ref, CGFloat height )
{ [ref setLineHeightMultiple:height]; }

// - tab info -
void MutableParagraphStyleAddTabStop( NSMutableParagraphStyle *ref, NSTextTab *textTab )
{ [ref addTabStop:textTab]; }

void MutableParagraphStyleRemoveTabStop( NSMutableParagraphStyle *ref, NSTextTab *textTab )
{ [ref removeTabStop:textTab]; }

void MutableParagraphStyleSetTabStops( NSMutableParagraphStyle *ref, CFArrayRef tabStops )
{ [ref setTabStops:(__bridge NSArray *)tabStops]; }

void MutableParagraphStyleSetDefaultTabInterval( NSMutableParagraphStyle *ref, CGFloat interval )
{ [ref setDefaultTabInterval:interval]; }

// - text blocks and lists
void MutableParagraphStyleSetTextBlocks( NSMutableParagraphStyle *ref, CFArrayRef blocks )
{ [ref setTextBlocks:(__bridge NSArray *)blocks]; }

void MutableParagraphStyleSetTextLists( NSMutableParagraphStyle *ref, CFArrayRef lists )
{ [ref setTextLists:(__bridge NSArray *)lists]; }

// - hyphenation factor -
void MutableParagraphStyleSetHyphenationFactor( NSMutableParagraphStyle *ref, float factor )
{ [ref setHyphenationFactor:factor]; }

void MutableParagraphStyleSetTighteningFactorForTruncation( NSMutableParagraphStyle *ref, float factor )
{ [ref setTighteningFactorForTruncation:factor]; }

void MutableParagraphStyleSetAllowsDefaultTighteningForTruncation( NSMutableParagraphStyle *ref, BOOL flag )
{ [ref setAllowsDefaultTighteningForTruncation:flag]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
void MutableParagraphStyleSetUsesDefaultHyphenation( NSMutableParagraphStyle *ref, BOOL flag )
{ [ref setUsesDefaultHyphenation:flag]; }
#endif// 120000

// - HTML header level -
void MutableParagraphStyleSetHeaderLevel( NSMutableParagraphStyle *ref, NSInteger level )
{ [ref setHeaderLevel:level]; }

#pragma mark - texttab

// - create -
NSTextTab *TextTabInit( NSTextAlignment alignment, CGFloat location, CFDictionaryRef options )
{
#if __has_feature(objc_arc)
    return [[NSTextTab alloc] initWithTextAlignment:alignment location:location options:(__bridge NSDictionary *)options];
#else
    return [[[NSTextTab alloc] initWithTextAlignment:alignment location:location options:(__bridge NSDictionary *)options] autorelease];
#endif
}

NSTextTab *TextTabWithAlignment( NSTextAlignment alignment, CGFloat location, CFDictionaryRef options )
{
#if __has_feature(objc_arc)
    return [[NSTextTab alloc] initWithTextAlignment:alignment location:location options:(__bridge NSDictionary *)options];
#else
    return [[[NSTextTab alloc] initWithTextAlignment:alignment location:location options:(__bridge NSDictionary *)options] autorelease];
#endif
}

// - tab stop info -
CGFloat TextTabLocation( NSTextTab *ref )
{ return [ref location]; }

// - text tab info -
NSTextAlignment TextTabAlignment( NSTextTab *ref )
{ return [ref alignment]; }

CFDictionaryRef TextTabOptions( NSTextTab *ref )
{ return (__bridge CFDictionaryRef)[ref options]; }

CFCharacterSetRef TextTabColumnTerminatorsForLocale( CFLocaleRef locale )
{ return (__bridge CFCharacterSetRef)[NSTextTab columnTerminatorsForLocale:(__bridge NSLocale *)locale]; }


