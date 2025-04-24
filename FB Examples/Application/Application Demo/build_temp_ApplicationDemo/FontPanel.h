/*
 FontPanel.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class FontPanelClass( void );

// Font panel
NSFontPanel *FontPanelShared( void );
BOOL FontPanelSharedExists( void );

// Enable font changes
BOOL FontPanelIsEnabled( NSFontPanel *ref );
void FontPanelSetEnabled( NSFontPanel *ref, BOOL flag );
void FontPanelReloadDefaultFontFamilies( NSFontPanel *ref );

// Update
void FontPanelSetFont( NSFontPanel *ref, NSFont *font, BOOL isMultiple );

// Convert
NSFont *FontPanelConverFont( NSFontPanel *ref, NSFont *font );

// Modal loops
BOOL FontPanelWorksWhenModal( NSFontPanel *ref );
void FontPanelSetWorksWhenModal( NSFontPanel *ref, BOOL flag );

// Accessory view
NSView *FontPanelAccessoryView( NSFontPanel *ref );
void FontPanelSetAccessoryView( NSFontPanel *ref, NSView *theView );
