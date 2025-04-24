/*
 ParagraphStyle.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class ParagraphStyleClass( void );

// - create -
NSParagraphStyle *ParagraphStyleDefaultStyle( void );

// - style -
NSTextAlignment ParagraphStyleAlignment( NSParagraphStyle *ref );
CGFloat ParagraphStyleFirstLineHeadIndent( NSParagraphStyle *ref );
CGFloat ParagraphStyleHeadIndent( NSParagraphStyle *ref );
CGFloat ParagraphStyleTailIndent( NSParagraphStyle *ref );
CGFloat ParagraphStyleLineHeightMultiple( NSParagraphStyle *ref );
CGFloat ParagraphStyleMaximumLineHeight( NSParagraphStyle *ref );
CGFloat ParagraphStyleMinimumLineHeight( NSParagraphStyle *ref );
CGFloat ParagraphStyleLineSpacing( NSParagraphStyle *ref );
CGFloat ParagraphStyleParagraphSpacing( NSParagraphStyle *ref );
CGFloat ParagraphStyleParagraphSpacingBefore( NSParagraphStyle *ref );

// - tab info -
CFArrayRef ParagraphStyleTabStops( NSParagraphStyle *ref );
CGFloat ParagraphStyleDefaultTabInterval( NSParagraphStyle *ref );

// - text block and list info -
CFArrayRef ParagraphStyleTextBlocks( NSParagraphStyle *ref );
CFArrayRef ParagraphStyleTextLists( NSParagraphStyle *ref );

// - line breaking info -
NSLineBreakMode ParagraphStyleLineBreakMode( NSParagraphStyle *ref );
float ParagraphStyleHyphenationFactor( NSParagraphStyle *ref );
float ParagraphStyleTighteningFactorForTruncation( NSParagraphStyle *ref );
BOOL ParagraphStyleAllowsDefaultTighteningForTruncation( NSParagraphStyle *ref );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
BOOL ParagraphStyleUsesDefaultHyphenation( NSParagraphStyle *ref );
#endif// 120000

// - HTML header level -
NSInteger ParagraphStyleHeaderLevel( NSParagraphStyle *ref );

// - writing direction -
NSWritingDirection ParagraphStyleDefaultWritingDrectionForLanguage( CFStringRef languageName );
NSWritingDirection ParagraphStyleBaseWritingDirection( NSParagraphStyle *ref );


#pragma mark - mutable paragraph style
// Class
Class MutableParagraphStyleClass( void );

// - init -
NSMutableParagraphStyle *MutableParagraphStyleInit( void );
NSMutableParagraphStyle *MutableParagraphStyleNew( void );

// - style info -
void MutableParagraphStyleSet( NSMutableParagraphStyle *ref, NSParagraphStyle *style );
void MutableParagraphStyleSetAlignment( NSMutableParagraphStyle *ref, NSTextAlignment alignment );
void MutableParagraphStyleSetFirstLineHeadIndent( NSMutableParagraphStyle *ref, CGFloat indent );
void MutableParagraphStyleSetHeadIndent( NSMutableParagraphStyle *ref, CGFloat indent );
void MutableParagraphStyleSetTailIndent( NSMutableParagraphStyle *ref, CGFloat indent );
void MutableParagraphStyleSetLineBreakMode( NSMutableParagraphStyle *ref, NSLineBreakMode lineBreakMode );
void MutableParagraphStyleSetMaximumLineHeight( NSMutableParagraphStyle *ref, CGFloat height );
void MutableParagraphStyleSetMinimumLineHeight( NSMutableParagraphStyle *ref, CGFloat height );
void MutableParagraphStyleSetLineSpacing( NSMutableParagraphStyle *ref, CGFloat spacing );
void MutableParagraphStyleSetParagraphSpacing( NSMutableParagraphStyle *ref, CGFloat spacing );
void MutableParagraphStyleSetParagraphSpacingBefore( NSMutableParagraphStyle *ref, CGFloat spacing );
void MutableParagraphStyleSetBaseWritingDirection( NSMutableParagraphStyle *ref, NSWritingDirection direction );
void MutableParagraphStyleSetLineHeightMultiple( NSMutableParagraphStyle *ref, CGFloat height );

// - tab info -
void MutableParagraphStyleAddTabStop( NSMutableParagraphStyle *ref, NSTextTab *textTab );
void MutableParagraphStyleRemoveTabStop( NSMutableParagraphStyle *ref, NSTextTab *textTab );
void MutableParagraphStyleSetTabStops( NSMutableParagraphStyle *ref, CFArrayRef tabStops );
void MutableParagraphStyleSetDefaultTabInterval( NSMutableParagraphStyle *ref, CGFloat interval );

// - text blocks and lists
void MutableParagraphStyleSetTextBlocks( NSMutableParagraphStyle *ref, CFArrayRef blocks );
void MutableParagraphStyleSetTextLists( NSMutableParagraphStyle *ref, CFArrayRef lists );

// - hyphenation factor -
void MutableParagraphStyleSetHyphenationFactor( NSMutableParagraphStyle *ref, float factor );
void MutableParagraphStyleSetTighteningFactorForTruncation( NSMutableParagraphStyle *ref, float factor );
void MutableParagraphStyleSetAllowsDefaultTighteningForTruncation( NSMutableParagraphStyle *ref, BOOL flag );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
void MutableParagraphStyleSetUsesDefaultHyphenation( NSMutableParagraphStyle *ref, BOOL flag );
#endif// 120000

// - HTML header level -
void MutableParagraphStyleSetHeaderLevel( NSMutableParagraphStyle *ref, NSInteger level );


#pragma mark - texttab

// - create -
NSTextTab *TextTabInit( NSTextAlignment alignment, CGFloat location, CFDictionaryRef options );
NSTextTab *TextTabWithAlignment( NSTextAlignment alignment, CGFloat location, CFDictionaryRef options );

// - tab stop info -
CGFloat TextTabLocation( NSTextTab *ref );

// - text tab info -
NSTextAlignment TextTabAlignment( NSTextTab *ref );
CFDictionaryRef TextTabOptions( NSTextTab *ref );
CFCharacterSetRef TextTabColumnTerminatorsForLocale( CFLocaleRef locale );


