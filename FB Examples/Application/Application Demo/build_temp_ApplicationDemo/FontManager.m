/*
 FontManager.m

 Bernie Wylde
 */

#import "FontManager.h"

static CUI_FontManagerDelegate *sCUI_FontManagerDelegate;

@implementation CUI_FontManagerDelegate

- (id)init {
    if ( (self = [super init]) ) {
        self.font = [NSFont fontWithName:@"Helvetica" size:12];
    }
    return self;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.font release];
    [super dealloc];
}
#endif

- (void)changeFont:(id)sender {
    NSFont *oldFont = [self font];
    if ( oldFont ) {
        NSFont *newFont = [sender convertFont:oldFont];
        if ( newFont ) {
            [self setFont:newFont];
            DialogEventSetFont( newFont );
            CallUserDefinedOnDialogFunction( fontManagerChangeFont, 0, 0, (__bridge CFTypeRef)newFont );
        }
    }
}
@end

void CUI_FontManagerSetDelegate( void )
{
    if ( !sCUI_FontManagerDelegate ) {
        sCUI_FontManagerDelegate = [[CUI_FontManagerDelegate alloc] init];
        NSFontManager *fm = [NSFontManager sharedFontManager];
        [fm setDelegate:sCUI_FontManagerDelegate];
        [fm setTarget:sCUI_FontManagerDelegate];
        NSFont *font = [NSFont fontWithName:@"Helvetica" size:12];
        if ( font ) [fm setSelectedFont:font isMultiple:NO];
    }
}

// Class
Class FontManagerClass( void )
{ return [NSFontManager class]; }

// Shared
NSFontManager *FontManagerShared( void )
{ return [NSFontManager sharedFontManager]; }

// Default conversion
void FontManagerSetFontManagerFactory( Class class )
{ [NSFontManager setFontManagerFactory:class]; }

void FontManagerSetFontPanelFactory( Class class )
{ [NSFontManager setFontPanelFactory:class]; }

// Available fonts
CFArrayRef FontManagerAvailableFonts( void )
{ return (__bridge CFArrayRef)[[NSFontManager sharedFontManager] availableFonts]; }

CFArrayRef FontManagerAvailableFontFamilies( void )
{ return (__bridge CFArrayRef)[[NSFontManager sharedFontManager] availableFontFamilies]; }

CFArrayRef FontManagerAvailableFontNamesWithTraits( NSFontTraitMask traits )
{ return (__bridge CFArrayRef)[[NSFontManager sharedFontManager] availableFontNamesWithTraits:traits]; }

CFArrayRef FontManagerAvailableMembersOfFontFamily( CFStringRef fam )
{ return (__bridge CFArrayRef)[[NSFontManager sharedFontManager] availableMembersOfFontFamily:(__bridge NSString *)fam]; }

// Set and examine
void FontManagerSetSelectedFont( CFTypeRef inFont, BOOL isMultiple )
{
    NSFontManager *fm = [NSFontManager sharedFontManager];
    CUI_FontManagerSetDelegate();
    if ( inFont ) {
        NSFont *font = CUI_FixFont( (const void *)inFont );
        [fm setSelectedFont:font isMultiple:isMultiple];
    }
}

BOOL FontManagerIsMultiple( void )
{ return [[NSFontManager sharedFontManager] isMultiple]; }

NSFont *FontManagerSelectedFont( void )
{ return [[NSFontManager sharedFontManager] selectedFont]; }

BOOL FontManagerSendAction( void )
{ return [[NSFontManager sharedFontManager] sendAction]; }

CFStringRef FontManagerLocalizedNameForFamily( CFStringRef family, CFStringRef faceKey )
{ return (__bridge CFStringRef)[[NSFontManager sharedFontManager] localizedNameForFamily:(__bridge NSString *)family face:(__bridge NSString *)faceKey]; }

// Sending actions
void FontManagerAddFontTrait( void )
{ [[NSFontManager sharedFontManager] addFontTrait:nil]; }

void FontManagerRemoveFontTrait( void )
{ [[NSFontManager sharedFontManager] removeFontTrait:nil]; }

void FontManagerModifyFont( void )
{ [[NSFontManager sharedFontManager] modifyFont:nil]; }

void FontManagerModifyFontViaPanel( void )
{ [[NSFontManager sharedFontManager] modifyFontViaPanel:nil]; }

void FontManagerOrderFrontStylesPanel( void )
{ [[NSFontManager sharedFontManager] orderFrontStylesPanel:nil]; }

void FontManagerOrderFrontFontPanel( void )
{ [[NSFontManager sharedFontManager] orderFrontFontPanel:nil]; }

// Converting automatically
NSFont *FontManagerConvertFont( NSFont *font )
{ return [[NSFontManager sharedFontManager] convertFont:font]; }

// Convert manually
NSFont *FontManagerConvertFontToFace( NSFont *font, CFStringRef face )
{ return [[NSFontManager sharedFontManager] convertFont:font toFace:(__bridge NSString *)face]; }

NSFont *FontManagerConvertFontToFamily( NSFont *font, CFStringRef family )
{ return [[NSFontManager sharedFontManager] convertFont:font toFamily:(__bridge NSString *)family]; }

NSFont *FontManagerConvertFontToHaveTrait( NSFont *font, NSFontTraitMask traitMask )
{ return [[NSFontManager sharedFontManager] convertFont:font toHaveTrait:traitMask]; }

NSFont *FontManagerConvertFontToNotHaveTrait( NSFont *font, NSFontTraitMask traitMask )
{ return [[NSFontManager sharedFontManager] convertFont:font toNotHaveTrait:traitMask]; }

NSFont *FontManagerConvertFontToSize( NSFont *font, CGFloat size )
{ return [[NSFontManager sharedFontManager] convertFont:font toSize:size]; }

NSFont *FontManagerConvertFontWeight( NSFont *font, BOOL upFlag )
{ return [[NSFontManager sharedFontManager] convertWeight:upFlag ofFont:font]; }

NSFontAction FontManagerCurrentFontAction( void )
{ return [[NSFontManager sharedFontManager] currentFontAction]; }

NSFontTraitMask FontManagerConvertFontTraits( NSFontTraitMask traitMask )
{ return [[NSFontManager sharedFontManager] convertFontTraits:traitMask]; }

// Get font
NSFont *FontManagerFontWithFamily( CFStringRef family, NSFontTraitMask traitMask, NSInteger weight, CGFloat size )
{ return [[NSFontManager sharedFontManager] fontWithFamily:(__bridge NSString *)family traits:traitMask weight:weight size:size]; }

// Examining fonts
NSFontTraitMask FontManagerTraitsOfFont( NSFont *font )
{ return [[NSFontManager sharedFontManager] traitsOfFont:font]; }

BOOL FontManagerFontNamedHasTraits( CFStringRef name, NSFontTraitMask traitMask )
{ return [[NSFontManager sharedFontManager] fontNamed:(__bridge NSString *)name hasTraits:traitMask]; }

NSInteger FontManagerWeightOfFont( NSFont *font )
{ return [[NSFontManager sharedFontManager] weightOfFont:font]; }

// Managing the font panel and font menu
BOOL FontManagerIsEnabled( void )
{ return [[NSFontManager sharedFontManager] isEnabled]; }

NSFontPanel *FontManagerFontPanel( BOOL create )
{ return [[NSFontManager sharedFontManager] fontPanel:create]; }

void FontManagerSetFontMenu( NSMenu *m )
{ [[NSFontManager sharedFontManager] setFontMenu:m]; }

NSMenu *FontManagerFontMenu( BOOL create )
{ return [[NSFontManager sharedFontManager] fontMenu:create]; }

// Action and target
SEL FontManagerAction( void )
{ return [[NSFontManager sharedFontManager] action]; }

CFTypeRef FontManagerTarget( void )
{ return (__bridge CFTypeRef)[[NSFontManager sharedFontManager] target]; }

// Attributes
void FontManagerSetSelectedAttributes( CFDictionaryRef attrs, BOOL isMultiple )
{ [[NSFontManager sharedFontManager] setSelectedAttributes:(__bridge NSDictionary *)attrs isMultiple:isMultiple]; }

CFDictionaryRef FontManagerConvertAttributes( CFDictionaryRef attrs )
{ return (__bridge CFDictionaryRef)[[NSFontManager sharedFontManager] convertAttributes:(__bridge NSDictionary *)attrs]; }

// Custom
void FontManagerShowPanel( void )
{
    NSFontManager *fm = [NSFontManager sharedFontManager];
    CUI_FontManagerSetDelegate();
    [fm orderFrontFontPanel:nil];
}

void FontManagerClosePanel( void )
{ [[[NSFontManager sharedFontManager] fontPanel:YES] orderOut:nil]; }

