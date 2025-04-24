/*
 FontPanel.m

 Bernie Wylde
 */

#import "FontPanel.h"

// Class
Class FontPanelClass( void )
{ return [NSFontPanel class]; }

// Font panel
NSFontPanel *FontPanelShared( void )
{ return [NSFontPanel sharedFontPanel]; }

BOOL FontPanelSharedExists( void )
{ return [NSFontPanel sharedFontPanelExists]; }

// Enable font changes
BOOL FontPanelIsEnabled( NSFontPanel *ref )
{ return [ref isEnabled]; }

void FontPanelSetEnabled( NSFontPanel *ref, BOOL flag )
{ [ref setEnabled:flag]; }

void FontPanelReloadDefaultFontFamilies( NSFontPanel *ref )
{ [ref reloadDefaultFontFamilies]; }

// Update
void FontPanelSetFont( NSFontPanel *ref, NSFont *font, BOOL isMultiple )
{ [ref setPanelFont:font isMultiple:isMultiple]; }

// Convert
NSFont *FontPanelConverFont( NSFontPanel *ref, NSFont *font )
{ return [ref panelConvertFont:font]; }

// Modal loops
BOOL FontPanelWorksWhenModal( NSFontPanel *ref )
{ return [ref worksWhenModal]; }

void FontPanelSetWorksWhenModal( NSFontPanel *ref, BOOL flag )
{ [ref setWorksWhenModal:flag]; }

// Accessory view
NSView *FontPanelAccessoryView( NSFontPanel *ref )
{ return [ref accessoryView]; }

void FontPanelSetAccessoryView( NSFontPanel *ref, NSView *theView )
{ [ref setAccessoryView:theView]; }
