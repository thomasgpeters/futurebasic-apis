/*
 ToolbarItemGroup.h

 Bernie Wylde
 */

#import "CocoaUI.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500

// Class
API_AVAILABLE(macos(10.15))
Class ToolbarItemGroupClass( void );

// Subitems
API_AVAILABLE(macos(10.15))
CFArrayRef ToolbarItemGroupSubitems( NSToolbarItemGroup *ref );
API_AVAILABLE(macos(10.15))
void ToolbarItemGroupSetSubitems( NSToolbarItemGroup *ref, CFArrayRef subitems );

// Initializers
API_AVAILABLE(macos(10.15))
NSToolbarItemGroup *ToolbarItemGroupWithImages( CFStringRef identifier, CFArrayRef images, NSToolbarItemGroupSelectionMode selectionMode, CFArrayRef labels, CFTypeRef target, SEL action );
API_AVAILABLE(macos(10.15))
NSToolbarItemGroup *ToolbarItemGroupWithTitles( CFStringRef identifier, CFArrayRef titles, NSToolbarItemGroupSelectionMode selectionMode, CFArrayRef labels, CFTypeRef target, SEL action );

// Instance properties
API_AVAILABLE(macos(10.15))
NSToolbarItemGroupControlRepresentation ToolbarItemGroupControlRepresentation( NSToolbarItemGroup *ref );
API_AVAILABLE(macos(10.15))
void ToolbarItemGroupSetControlRepresentation( NSToolbarItemGroup *ref, NSToolbarItemGroupControlRepresentation representation );
API_AVAILABLE(macos(10.15))
NSInteger ToolbarItemGroupSelectedIndex( NSToolbarItemGroup *ref );
API_AVAILABLE(macos(10.15))
void ToolbarItemGroupSetSelectedIndex( NSToolbarItemGroup *ref, NSInteger index );
API_AVAILABLE(macos(10.15))
NSToolbarItemGroupSelectionMode ToolbarItemGroupSelectionMode( NSToolbarItemGroup *ref );
API_AVAILABLE(macos(10.15))
void ToolbarItemGroupSetSelectionMode( NSToolbarItemGroup *ref, NSToolbarItemGroupSelectionMode selectionMode );

// Instance methods
API_AVAILABLE(macos(10.15))
BOOL ToolbarItemGroupIsSelectedAtIndex( NSToolbarItemGroup *ref, NSInteger index );
API_AVAILABLE(macos(10.15))
void ToolbarItemGroupSetSelectedAtIndex( NSToolbarItemGroup *ref, BOOL flag, NSInteger index );

#endif// 101500

