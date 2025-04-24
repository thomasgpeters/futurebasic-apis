/*
 Menu.h

 Bernie Wylde
 */

typedef void (*CUI_MenuItemCallbackType)(NSInteger,NSInteger,void *);
typedef BOOL (*CUI_ValidateMenuItemCallbackType)(NSInteger,NSInteger);

//void CUI_BuildMinimalMenu( void );// 20211002 moved to Application.h

@interface CUI_MenuItemTarget : NSObject
@property (nonatomic,assign) CUI_ValidateMenuItemCallbackType validateCallback;
@property (nonatomic,assign) BOOL boolVal;

- (void)menuItemAction:(id)sender;// 20210103
@end


#pragma mark - menu delegate
typedef void (*CUI_MenuDelegateCallbackType)(NSInteger,NSInteger,NSInteger,void*);

// events
enum {// 20220311
    menuHasKeyEquivalent,// not currently implemented
    menuUpdateItem,// not currently implemented
    menuConfinementRect,// not currently implemented
    menuWillHighlightItem,
    menuWillOpen,
    menuDidClose,
    menuNumberOfItems,// not currently implemented
    menuNeedsUpdate
};

@interface CUI_MenuDelegate : NSObject <NSMenuDelegate>// 20220311
@property (nonatomic,assign) CUI_MenuDelegateCallbackType callback;
@property (nonatomic,assign) void *userData;
@end

//CUI_MenuDelegate *CUI_MenuDelegateObj( void );

void CUI_NibMenuSetup( NSMenu *menu );
void CUI_NibMenuFixAppNameItems( NSMenu *mainMenu );

CUI_MenuItemTarget *CUI_MenuItemTargetObj( void );

NSArray *CUI_OtherMenus( void );// 20231227
void CUI_OtherMenuAdd( NSMenu *menu );
NSMenu *CUI_OtherMenuAtIndex( NSInteger index );
NSInteger CUI_MenuIndex( NSMenu *menu );

@interface NSMenu (Additions)
@property (nonatomic,retain) NSNumber *tagNumber;
- (NSInteger)tag;
- (void)setTag:(NSInteger)tag;
@end

// private
CUI_MenuItemTarget *CUI_MenuItemTargetForMenuAndGroup( NSInteger menuID, NSInteger groupID );

void CUI_MenuPadItemsToIndex( NSMenu *menu, NSInteger index );


@interface NSMenuItem (Additions)
@property (nonatomic,retain) NSValue *callbackValue;
@property (nonatomic,retain) NSValue *userDataValue;

- (CUI_MenuItemCallbackType)cuiMenuItemCallback;
- (void *)cuiMenuItemUserData;
- (void)setCuiMenuItemCallback:(CUI_MenuItemCallbackType)cb;
- (void)setCuiMenuItemUserData:(void *)userData;
@end


void MenuEventSetBool( BOOL flag );

// Class
Class MenuClass( void );

NSMenu *MenuAtIndex( NSInteger index );
BOOL MenuExists( NSInteger index );
NSInteger MenuIndex( NSMenu *m );


// MenuBar
BOOL MenuBarVisible( void );
void MenuBarSetVisible( BOOL flag );
CGFloat MenuBarHeight( void );

// Init
NSMenu *MenuWithTitle( CFStringRef title );

// Add remove items
void MenuInsertItem( NSInteger menuIndex, NSMenuItem *item, NSInteger itemIndex );
NSMenuItem *MenuInsertItemWithTitle( NSInteger menuIndex, NSInteger itemIndex, CFStringRef title, CFStringRef keyEquivalent, NSUInteger keyEquivalentModifierMask );
void MenuAddItem( NSInteger menuIndex, NSMenuItem *item );
NSMenuItem *MenuAddItemWithTitle( NSInteger menuIndex, CFStringRef title, CFStringRef keyEquivalent, NSUInteger keyEquivalentModifierMask );
void MenuRemoveItem( NSInteger menuIndex, NSInteger itemIndex );
void MenuRemoveAllItems( NSInteger menuIndex );

// Find items
NSMenuItem *MenuItemWithTag( NSInteger menuIndex, NSInteger itemTag );
NSInteger MenuItemWithTitle( NSInteger menuIndex, CFStringRef title );
NSMenuItem *MenuItemAtIndex( NSInteger menuIndex, NSInteger itemIndex );
NSInteger MenuNumberOfItems( NSInteger menuIndex );
CFArrayRef MenuItemArray( NSInteger menuIndex );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
void MenuSetItemArray( NSInteger menuIndex, CFArrayRef items );
#endif// 101400

// Find indices of items
NSInteger MenuIndexOfItem( NSInteger menuIndex, NSMenuItem *item );
NSInteger MenuIndexOfItemWithTitle( NSInteger menuIndex, CFStringRef title );
NSInteger MenuIndexOfItemWithTag( NSInteger menuIndex, NSInteger tag );
NSInteger MenuIndexOfItemWithRepresentedObject( NSInteger menuIndex, CFTypeRef obj );
NSInteger MenuIndexOfItemWithSubmenu( NSInteger menuIndex, NSInteger submenuID );

// Submenus
void MenuSetSubmenu( NSInteger parMenuIndex, NSInteger parItemIndex, NSInteger submenuIndex );
NSMenu *MenuSupermenu( NSInteger menuIndex );
NSInteger MenuSupermenuIndex( NSInteger menuIndex );

// Enable/disable items
BOOL MenuAutoenablesItems( NSInteger menuIndex );
void MenuSetAutoenablesItems( NSInteger menuIndex, BOOL flag );
void MenuUpdate( NSInteger menuIndex );

// Font
NSFont *MenuFont( NSInteger menuIndex );
void MenuSetFont( NSInteger menuIndex, CFTypeRef inFont );
void MenuSetFontWithName( NSInteger menuIndex, CFStringRef inName, CGFloat size );// convenience

// Keyboard equivalents
BOOL MenuPerformKeyEquivalent( NSInteger menuIndex, NSEvent *event );

// Simulate mouse clicks
void MenuPerformActionForItemAtIndex( NSInteger menuIndex, NSInteger itemID );

// Title
CFStringRef MenuTitle( NSInteger menuIndex );
void MenuSetTitle( NSInteger menuIndex, CFStringRef title );

// Size
CGFloat MenuMinimumWidth( NSInteger menuIndex );
void MenuSetMinimumWidth( NSInteger menuIndex, CGFloat width );
CGSize MenuSize( NSInteger menuIndex );

// Properties
NSMenuProperties MenuPropertiesToUpdate( NSInteger menuIndex );

// Contextual menus
BOOL MenuAllowsContextMenuPlugIns( NSInteger menuIndex );
void MenuSetAllowsContextMenuPlugIns( NSInteger menuIndex, BOOL flag );

// Context-sensitive help
void MenuPopUpContextMenuForView( NSInteger menuIndex, NSEvent *event, NSInteger aViewTag );
void MenuPopUpContextMenuForViewWithFont( NSInteger menuIndex, NSEvent *event, NSInteger aViewTag, NSFont *font );
BOOL MenuPopUp( NSInteger menuIndex, NSInteger itemIndex, CGPoint location, NSInteger viewTag );

// State column
BOOL MenuShowsStateColumn( NSInteger menuIndex );
void MenuSetShowsStateColumn( NSInteger menuIndex, BOOL flag );

// Highlighting
NSInteger MenuHighlightedItem( NSInteger menuIndex );

// Delegate
void MenuSetDelegateCallback( NSInteger menuIndex, CUI_MenuDelegateCallbackType callback, void *userData );

// User interface
NSUserInterfaceLayoutDirection MenuUserInterfaceLayoutDirection( NSInteger menuIndex );
void MenuSetUserInterfaceLayoutDirection( NSInteger menuIndex, NSUserInterfaceLayoutDirection direction );

// Tracking
void MenuCancelTracking( NSInteger menuIndex );
void MenuCancelTrackingWithoutAnimation( NSInteger menuIndex );

// Presentation style
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
NSMenuPresentationStyle MenuPresentationStyle( NSInteger menuIndex );
API_AVAILABLE(macos(14.0))
void MenuSetPresentationStyle( NSInteger menuIndex, NSMenuPresentationStyle style );
API_AVAILABLE(macos(14.0))
NSMenuSelectionMode MenuSelectionMode( NSInteger menuIndex );
API_AVAILABLE(macos(14.0))
void MenuSetSelectionMode( NSInteger menuIndex, NSMenuSelectionMode mode );
//API_AVAILABLE(macos(14.0))
//CFArrayRef MenuSelectedItems( NSInteger menuIndex );
API_AVAILABLE(macos(14.0))
void MenuSetSelectedItems( NSInteger menuIndex, CFArrayRef items );
#endif// 140000

CFArrayRef MenuSelectedItems( NSInteger menuIndex );

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150200
BOOL MenuAutomaticallyInsertsWritingToolsItems( NSInteger menuID );
void MenuSetAutomaticallyInsertsWritingToolsItems( NSInteger menuID, BOOL flag );
#endif// 150200

// Custom
void MenuSetTag( NSInteger menuIndex, NSInteger tag );
void MenuSetOneItemOnState( NSInteger menuIndex, NSInteger itemIndex );
void MenuSelectItem( NSInteger menuIndex, NSInteger itemIndex );
void MenuSelectGroupItem( NSInteger menuID, NSInteger itemID );
NSInteger MenuSelectedItem( NSInteger menuID );
void MenuSetValidateItemsCallback( CUI_ValidateMenuItemCallbackType callback );
BOOL MenuIsHidden( NSInteger menuIndex );
void MenuSetHidden( NSInteger menuIndex, BOOL flag );
BOOL MenuIsHiddenOrHasHiddenAncestor( NSInteger menuIndex );

CFTypeRef MenuProperty( NSInteger menuIndex, CFStringRef key );
void MenuSetProperty( NSInteger menuIndex, CFStringRef key, CFTypeRef value );
void MenuPropertySet( NSInteger menuIndex, CFStringRef key, CFTypeRef value );

BOOL MenuPropertyBool( NSInteger menuIndex, CFStringRef key );
void MenuPropertySetBool( NSInteger menuIndex, CFStringRef key, BOOL value );
long MenuPropertyLong( NSInteger menuIndex, CFStringRef key );
void MenuPropertySetLong( NSInteger menuIndex, CFStringRef key, long value );
double MenuPropertyDouble( NSInteger menuIndex, CFStringRef key );
void MenuPropertySetDouble( NSInteger menuIndex, CFStringRef key, double value );
CGRect MenuPropertyRect( NSInteger menuIndex, CFStringRef key );
void MenuPropertySetRect( NSInteger menuIndex, CFStringRef key, CGRect r );
CGPoint MenuPropertyPoint( NSInteger menuIndex, CFStringRef key );
void MenuPropertySetPoint( NSInteger menuIndex, CFStringRef key, CGPoint pt );
CGSize MenuPropertySize( NSInteger menuIndex, CFStringRef key );
void MenuPropertySetSize( NSInteger menuIndex, CFStringRef key, CGSize sz );
CFRange MenuPropertyRange( NSInteger menuIndex, CFStringRef key );
void MenuPropertySetRange( NSInteger menuIndex, CFStringRef key, CFRange range );
CFURLRef MenuPropertyBookmarkURL( NSInteger menuIndex, CFStringRef key );
void MenuPropertySetBookmarkURL( NSInteger menuIndex, CFStringRef key, CFURLRef url );
BOOL MenuPropertyGetBytes( NSInteger menuIndex, CFStringRef key, void *bytes );
void MenuPropertySetBytes( NSInteger menuIndex, CFStringRef key, void *bytes, long length );

void MenuRemoveProperty( NSInteger menuIndex, CFStringRef key );
void MenuPropertyRemove( NSInteger menuIndex, CFStringRef key );
void MenuRemoveAllProperties( NSInteger menuIndex );
void MenuPropertyRemoveAll( NSInteger menuIndex );

// Hide/show tooltips
void MenuSetToolTipsHidden( NSInteger menuID, BOOL flag );


// FB keywords
#if 1// attributed title (menu item only)
void CUI_Menu( NSInteger inMenuIndex, NSInteger inItemIndex, NSInteger inEnabled, CFTypeRef inTitle, CFStringRef inKeyEquivalent, NSInteger inKeyEquivalentModifier, NSInteger inSectionHeader );
#else// attributed title (menu item only)
void CUI_Menu( NSInteger inMenuIndex, NSInteger inItemIndex, NSInteger inEnabled, CFStringRef inTitle, CFStringRef inKeyEquivalent, NSInteger inKeyEquivalentModifier, NSInteger inSectionHeader );
#endif// attributed title (menu item only)

void CUI_EditMenu( NSInteger inMenuIndex );
void CUI_WindowMenu( NSInteger inMenuIndex );
void CUI_FileMenu( NSInteger inMenuIndex );
void CUI_FindMenu( NSInteger inMenuIndex );
void CUI_FormatMenu( NSInteger inMenuIndex );
void CUI_FontMenu( NSInteger inMenuIndex );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
void CUI_PaletteMenu( NSInteger inMenuIndex, CFArrayRef inColors, CFArrayRef inTitles, NSImage *inImage, NSInteger inSelectionMode );
#endif// 140000
void CUI_TextMenu( NSInteger inMenuIndex );
void CUI_ViewMenu( NSInteger inMenuIndex );
void CUI_HelpMenu( NSInteger inMenuIndex );

#pragma mark - nibmenu
void CUI_NibMenu( CFStringRef inNibName );


#pragma mark - menu events

#if 1
typedef void (*CUI_OnMenuFunctionType)(NSInteger,NSInteger,CFTypeRef);
#else
typedef void (*CUI_OnMenuFunctionType)(NSInteger,NSInteger);
#endif

static CUI_OnMenuFunctionType sCUI_OnMenuFunction;
CUI_OnMenuFunctionType CUI_OnMenuFunction( void );
void CUI_SetOnMenuFunction( CUI_OnMenuFunctionType onMenuFn );

#if 1
void CallUserDefinedOnMenuFunction( long menuIndex, long itemIndex, NSMenu *m );
#else
void CallUserDefinedOnMenuFunction( long menuIndex, long itemIndex );
#endif

