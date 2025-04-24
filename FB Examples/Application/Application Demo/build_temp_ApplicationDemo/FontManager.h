/*
 FontManager.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "DialogEvent.h"

// dialog events
enum {
    fontManagerChangeFont = 2200
};

@interface CUI_FontManagerDelegate : NSObject
@property (nonatomic,retain) NSFont *font;
@end

void CUI_FontManagerSetDelegate( void );

// Class
Class FontManagerClass( void );

// Shared
NSFontManager *FontManagerShared( void );

// Default conversion
void FontManagerSetFontManagerFactory( Class class );
void FontManagerSetFontPanelFactory( Class class );

// Available fonts
CFArrayRef FontManagerAvailableFonts( void );
CFArrayRef FontManagerAvailableFontFamilies( void );
CFArrayRef FontManagerAvailableFontNamesWithTraits( NSFontTraitMask traits );
CFArrayRef FontManagerAvailableMembersOfFontFamily( CFStringRef fam );

// Set and examine
void FontManagerSetSelectedFont( CFTypeRef inFont, BOOL isMultiple );
BOOL FontManagerIsMultiple( void );
NSFont *FontManagerSelectedFont( void );
BOOL FontManagerSendAction( void );
CFStringRef FontManagerLocalizedNameForFamily( CFStringRef family, CFStringRef faceKey );

// Sending actions
void FontManagerAddFontTrait( void );
void FontManagerRemoveFontTrait( void );
void FontManagerModifyFont( void );
void FontManagerModifyFontViaPanel( void );
void FontManagerOrderFrontStylesPanel( void );
void FontManagerOrderFrontFontPanel( void );

// Converting automatically
NSFont *FontManagerConvertFont( NSFont *font );

// Convert manually
NSFont *FontManagerConvertFontToFace( NSFont *font, CFStringRef face );
NSFont *FontManagerConvertFontToFamily( NSFont *font, CFStringRef family );
NSFont *FontManagerConvertFontToHaveTrait( NSFont *font, NSFontTraitMask traitMask );
NSFont *FontManagerConvertFontToNotHaveTrait( NSFont *font, NSFontTraitMask traitMask );
NSFont *FontManagerConvertFontToSize( NSFont *font, CGFloat size );
NSFont *FontManagerConvertFontWeight( NSFont *font, BOOL upFlag );
NSFontAction FontManagerCurrentFontAction( void );
NSFontTraitMask FontManagerConvertFontTraits( NSFontTraitMask traitMask );

// Get font
NSFont *FontManagerFontWithFamily( CFStringRef family, NSFontTraitMask traitMask, NSInteger weight, CGFloat size );

// Examining fonts
NSFontTraitMask FontManagerTraitsOfFont( NSFont *font );
BOOL FontManagerFontNamedHasTraits( CFStringRef name, NSFontTraitMask traitMask );
NSInteger FontManagerWeightOfFont( NSFont *font );

// Managing the font panel and font menu
BOOL FontManagerIsEnabled( void );
NSFontPanel *FontManagerFontPanel( BOOL create );
NSMenu *FontManagerFontMenu( BOOL create );
void FontManagerSetFontMenu( NSMenu *m );

// Action and target
SEL FontManagerAction( void );
CFTypeRef FontManagerTarget( void );

// Attributes
void FontManagerSetSelectedAttributes( CFDictionaryRef attrs, BOOL isMultiple );
CFDictionaryRef FontManagerConvertAttributes( CFDictionaryRef attrs );


// Custom
void FontManagerShowPanel( void );
void FontManagerClosePanel( void );

