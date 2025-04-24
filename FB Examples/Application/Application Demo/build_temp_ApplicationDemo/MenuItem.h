/*
 MenuItem.h

 Bernie Wylde
 */

#import "Menu.h"
#import "Object.h"

// Class
Class MenuItemClass( void );

NSMenuItem *CUI_MenuItemAtIndex( NSMenu *menu, NSInteger index );

//NSMenuItem *MenuItemAtIndex( NSInteger menuIndex, NSInteger itemIndex );
BOOL MenuItemExists( NSInteger menuIndex, NSInteger itemIndex );

// Create
NSMenuItem *MenuItemInit( CFStringRef title, CFStringRef action, CFStringRef keyEquivalent );

// Enable
BOOL MenuItemIsEnabled( NSInteger menuIndex, NSInteger itemIndex );
void MenuItemSetEnabled( NSInteger menuIndex, NSInteger itemIndex, BOOL flag );

// Hidden
BOOL MenuItemIsHidden( NSInteger menuIndex, NSInteger itemIndex );
void MenuItemSetHidden( NSInteger menuIndex, NSInteger itemIndex, BOOL flag );
BOOL MenuItemIsHiddenOrHasHiddenAncestor( NSInteger menuIndex, NSInteger itemIndex );

// Target and action
void MenuItemSetAction( NSInteger menuIndex, NSInteger itemIndex, CFStringRef actionName );

// Title
CFStringRef MenuItemTitle( NSInteger menuIndex, NSInteger itemIndex );
void MenuItemSetTitle( NSInteger menuIndex, NSInteger itemIndex, CFStringRef title );
CFAttributedStringRef MenuItemAttributedTitle( NSInteger menuIndex, NSInteger itemIndex );
void MenuItemSetAttributedTitle( NSInteger menuIndex, NSInteger itemIndex, CFAttributedStringRef title );

// Tag
NSInteger MenuItemTag( NSInteger menuIndex, NSInteger itemIndex );
void MenuItemSetTag( NSInteger menuIndex, NSInteger itemIndex, NSInteger tag );

// State
NSCellStateValue MenuItemState( NSInteger menuIndex, NSInteger itemIndex );
void MenuItemSetState( NSInteger menuIndex, NSInteger itemIndex, NSCellStateValue state );

// Image
NSImage *MenuItemImage( NSInteger menuIndex, NSInteger itemIndex );
void MenuItemSetImage( NSInteger menuIndex, NSInteger itemIndex, NSImage *image );
NSImage *MenuItemOnStateImage( NSInteger menuIndex, NSInteger itemIndex );
void MenuItemSetOnStateImage( NSInteger menuIndex, NSInteger itemIndex, NSImage *image );
NSImage *MenuItemOffStateImage( NSInteger menuIndex, NSInteger itemIndex );
void MenuItemSetOffStateImage( NSInteger menuIndex, NSInteger itemIndex, NSImage *image );
NSImage *MenuItemMixedStateImage( NSInteger menuIndex, NSInteger itemIndex );
void MenuItemSetMixedStateImage( NSInteger menuIndex, NSInteger itemIndex, NSImage *image );

// Submenu
NSMenu *MenuItemSubmenu( NSInteger menuIndex, NSInteger itemIndex );
NSInteger MenuItemSubmenuIndex( NSInteger menuIndex, NSInteger itemIndex );
BOOL MenuItemHasSubmenu( NSInteger menuIndex, NSInteger itemIndex );
NSMenuItem *MenuItemParentItem( NSInteger menuIndex, NSInteger itemIndex );

// Separator
BOOL MenuItemIsSeparator( NSInteger menuIndex, NSInteger itemIndex );
NSMenuItem *MenuItemSeparatorItem( void );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
BOOL MenuItemIsSectionHeader( NSInteger menuID, NSInteger itemID );
API_AVAILABLE(macos(14.0))
//NSMenuItem *MenuItemSectionHeaderWithTitle( NSInteger menuID, NSInteger itemID, CFStringRef title );
NSMenuItem *MenuItemSectionHeaderWithTitle( CFStringRef title );// 20240705
API_AVAILABLE(macos(14.0))
void MenuItemSetSectionHeader( NSInteger menuID, NSInteger itemID, CFStringRef title );
#endif// 140000

// Menu
NSMenu *MenuItemMenu( NSMenuItem *item );
NSInteger MenuItemMenuIndex( NSMenuItem *item );

// KeyEquivalent
CFStringRef MenuItemKeyEquivalent( NSInteger menuIndex, NSInteger itemIndex );
void MenuItemSetKeyEquivalent( NSInteger menuIndex, NSInteger itemIndex, CFStringRef string );
NSUInteger MenuItemKeyEquivalentModifierMask( NSInteger menuIndex, NSInteger itemIndex );
void MenuItemSetKeyEquivalentModifierMask( NSInteger menuIndex, NSInteger itemIndex, NSUInteger mask );

// User key equivalents
BOOL MenuItemUsesUserKeyEquivalents( void );
CFStringRef MenuItemUserKeyEquivalent( NSInteger menuIndex, NSInteger itemIndex );

// Alternate
BOOL MenuItemIsAlternate( NSInteger menuIndex, NSInteger itemIndex );
void MenuItemSetAlternate( NSInteger menuIndex, NSInteger itemIndex, BOOL flag );

// Indentation level
NSInteger MenuItemIndentationLevel( NSInteger menuIndex, NSInteger itemIndex );
void MenuItemSetIndentationLevel( NSInteger menuIndex, NSInteger itemIndex, NSInteger level );

// ToolTip
CFStringRef MenuItemToolTip( NSInteger menuIndex, NSInteger itemIndex );
void MenuItemSetToolTip( NSInteger menuIndex, NSInteger itemIndex, CFStringRef string );

// RepresentedObject
CFTypeRef MenuItemRepresentedObject( NSInteger menuIndex, NSInteger itemIndex );
void MenuItemSetRepresentedObject( NSInteger menuIndex, NSInteger itemIndex, CFTypeRef obj );

// View
NSView *MenuItemView( NSInteger menuIndex, NSInteger itemIndex );
void MenuItemSetView( NSInteger menuIndex, NSInteger itemIndex, NSView *aView );

// Highlighted
BOOL MenuItemIsHighlighted( NSInteger menuIndex, NSInteger itemIndex );

// Instance properties
BOOL MenuItemAllowsKeyEquivalentWhenHidden( NSInteger menuIndex, NSInteger itemIndex );
void MenuItemSetAllowsKeyEquivalentWhenHidden( NSInteger menuIndex, NSInteger itemIndex, BOOL flag );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
BOOL MenuItemAllowsAutomaticKeyEquivalentLocalization( NSInteger menuID, NSInteger itemID );
API_AVAILABLE(macos(12.0))
void MenuItemSetAllowsAutomaticKeyEquivalentLocalization( NSInteger menuID, NSInteger itemID, BOOL flag );
API_AVAILABLE(macos(12.0))
BOOL MenuItemAllowsAutomaticKeyEquivalentMirroring( NSInteger menuID, NSInteger itemID );
API_AVAILABLE(macos(12.0))
void MenuItemSetAllowsAutomaticKeyEquivalentMirroring( NSInteger menuID, NSInteger itemID, BOOL flag );
#endif// 120000

// Badge
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
NSMenuItemBadge *MenuItemBadge( NSInteger menuID, NSInteger itemID );
API_AVAILABLE(macos(14.0))
void MenuItemSetBadge( NSInteger menuID, NSInteger itemID, NSMenuItemBadge *badge );
#endif// 140000


// Type properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150200
CFArrayRef MenuItemWritingToolsItems( void );
#endif// 150200


// Custom
void MenuItemSetOnMenuAction( NSInteger menuIndex, NSInteger itemIndex );
void MenuItemSetActionCallback( NSInteger menuIndex, NSInteger itemIndex, CUI_MenuItemCallbackType callback, void *userData );

CFTypeRef MenuItemProperty( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key );
void MenuItemSetProperty( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key, CFTypeRef value );
void MenuItemPropertySet( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key, CFTypeRef value );

BOOL MenuItemPropertyBool( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key );
void MenuItemPropertySetBool( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key, BOOL value );
long MenuItemPropertyLong( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key );
void MenuItemPropertySetLong( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key, long value );
double MenuItemPropertyDouble( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key );
void MenuItemPropertySetDouble( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key, double value );
CGRect MenuItemPropertyRect( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key );
void MenuItemPropertySetRect( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key, CGRect r );
CGPoint MenuItemPropertyPoint( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key );
void MenuItemPropertySetPoint( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key, CGPoint pt );
CGSize MenuItemPropertySize( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key );
void MenuItemPropertySetSize( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key, CGSize sz );
CFRange MenuItemPropertyRange( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key );
void MenuItemPropertySetRange( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key, CFRange range );
CFURLRef MenuItemPropertyBookmarkURL( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key );
void MenuItemPropertySetBookmarkURL( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key, CFURLRef url );
BOOL MenuItemPropertyGetBytes( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key, void *bytes );
void MenuItemPropertySetBytes( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key, void *bytes, long length );

void MenuItemRemoveProperty( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key );
void MenuItemPropertyRemove( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key );
void MenuItemRemoveAllProperties( NSInteger menuIndex, NSInteger itemIndex );
void MenuItemPropertyRemoveAll( NSInteger menuIndex, NSInteger itemIndex );

