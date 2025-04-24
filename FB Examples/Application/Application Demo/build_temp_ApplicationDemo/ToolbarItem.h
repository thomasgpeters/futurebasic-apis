/*
 ToolbarItem.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "View.h"
//#import "Toolbar.h"

#pragma mark - subclass
@interface ToolbarItemSC : NSToolbarItem
@end

// Class
Class ToolbarItemClass( void );

NSToolbarItem *ToolbarItemWithTag( NSInteger toolbarTag, NSInteger itemTag );

// Attributes
CFStringRef ToolbarItemIdentifier( NSInteger toolbarTag, NSInteger itemTag );
CFStringRef ToolbarItemLabel( NSInteger toolbarTag, NSInteger itemTag );
void ToolbarItemSetLabel( NSInteger toolbarTag, NSInteger itemTag, CFStringRef label );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
CFStringRef ToolbarItemTitle( NSInteger toolbarTag, NSInteger itemTag );
API_AVAILABLE(macos(10.15))
void ToolbarItemSetTitle( NSInteger toolbarTag, NSInteger itemTag, CFStringRef title );
#endif// 101500

CFStringRef ToolbarItemPaletteLabel( NSInteger toolbarTag, NSInteger itemTag );
void ToolbarItemSetPaletteLabel( NSInteger toolbarTag, NSInteger itemTag, CFStringRef label );
CFStringRef ToolbarItemToolTip( NSInteger toolbarTag, NSInteger itemTag );
void ToolbarItemSetToolTip( NSInteger toolbarTag, NSInteger itemTag, CFStringRef toolTip );
NSMenuItem *ToolbarItemMenuFormRepresentation( NSInteger toolbarTag, NSInteger itemTag );
void ToolbarItemSetMenuFormRepresentation( NSInteger toolbarTag, NSInteger itemTag, NSMenuItem *menuItem );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
API_AVAILABLE(macos(13.0))
CFSetRef ToolbarItemPossibleLabels( NSInteger toolbarTag, NSInteger itemTag );
API_AVAILABLE(macos(13.0))
void ToolbarItemSetPossibleLabels( NSInteger toolbarTag, NSInteger itemTag, CFSetRef labels );
#endif// 130000

BOOL ToolbarItemIsEnabled( NSInteger toolbarTag, NSInteger itemTag );
void ToolbarItemSetEnabled( NSInteger toolbarTag, NSInteger itemTag, BOOL flag );
NSImage *ToolbarItemImage( NSInteger toolbarTag, NSInteger itemTag );
void ToolbarItemSetImage( NSInteger toolbarTag, NSInteger itemTag, NSImage *image );
NSView *ToolbarItemView( NSInteger toolbarTag, NSInteger itemTag );
void ToolbarItemSetView( NSInteger toolbarTag, NSInteger itemTag, NSInteger vwTag );

CGSize ToolbarItemMinSize( NSInteger toolbarTag, NSInteger itemTag );
void ToolbarItemSetMinSize( NSInteger toolbarTag, NSInteger itemTag, CGSize size );
CGSize ToolbarItemMaxSize( NSInteger toolbarTag, NSInteger itemTag );
void ToolbarItemSetMaxSize( NSInteger toolbarTag, NSInteger itemTag, CGSize size );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
BOOL ToolbarItemIsBordered( NSInteger toolbarTag, NSInteger itemTag );
API_AVAILABLE(macos(10.15))
void ToolbarItemSetBordered( NSInteger toolbarTag, NSInteger itemTag, BOOL flag );
#endif// 101500

// VisibilityPriority
NSInteger ToolbarItemVisibilityPriority( NSInteger toolbarTag, NSInteger itemTag );
void ToolbarItemSetVisibilityPriority( NSInteger toolbarTag, NSInteger itemTag, NSInteger priority );

// Validation
void ToolbarItemValidate( NSInteger toolbarTag, NSInteger itemTag );
BOOL ToolbarItemAutovalidates( NSInteger toolbarTag, NSInteger itemTag );
void ToolbarItemSetAutovalidates( NSInteger toolbarTag, NSInteger itemTag, BOOL flag );

// Duplicates
BOOL ToolbarItemAllowsDuplicatesInToolbar( NSInteger toolbarTag, NSInteger itemTag );

// Configuration
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
API_AVAILABLE(macos(13.0))
BOOL ToolbarItemIsVisible( NSInteger toolbarTag, NSInteger itemTag );
#endif// 130000
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
API_AVAILABLE(macos(15.0))
BOOL ToolbarItemIsHidden( NSInteger toolbarTag, NSInteger itemTag );
API_AVAILABLE(macos(15.0))
void ToolbarItemSetHidden( NSInteger toolbarTag, NSInteger itemTag, BOOL flag );
#endif // 150000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
BOOL ToolbarItemIsNavigational( NSInteger toolbarTag, NSInteger itemTag );
API_AVAILABLE(macos(11.0))
void ToolbarItemSetNavigational( NSInteger toolbarTag, NSInteger itemTag, BOOL flag );
#endif// 110000


// Custom
void ToolbarItemSetSelectable( NSInteger toolbarTag, NSInteger itemTag );


// Init
//NSToolbarItem *ToolbarItemInit( NSInteger inTag, CFStringRef inIdentifier );

// Statement
void CUI_ToolbarItem( NSInteger inTag, CFStringRef inIdentifier, CFStringRef inLabel, void *inImage, NSInteger inAllowed, NSInteger inDefault, NSInteger inToolbarTag );

