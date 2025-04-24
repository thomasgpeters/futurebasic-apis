/*
 Toolbar.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "Application.h"
//#import "DialogEvent.h"
//#import "ToolbarItem.h"
//#import "Window.h"

#pragma mark - subclass
@interface ToolbarSC : NSToolbar
@end

// toolbarItem dialog events
enum {
    toolbarItemClick = 1900,
    toolbarItemValidate
};

@interface CUI_ToolbarItemTarget : NSObject

- (void)toolbarItemAction:(id)sender;

@end

CUI_ToolbarItemTarget *CUI_ToolbarItemTargetObj( void );

@interface CUI_ToolbarDelegate : NSObject <NSToolbarDelegate>
@end

CUI_ToolbarDelegate *CUI_ToolbarDelegateObj( void );

@interface CUI_ToolbarObj : NSObject
@property (nonatomic,retain) NSToolbar *toolbar;
@property (nonatomic,retain) NSMutableDictionary *items;
@property (nonatomic,retain) NSMutableArray *allowedIdentifiers;
@property (nonatomic,retain) NSMutableArray *defaultIdentifiers;
@property (nonatomic,retain) NSMutableArray *selectableIdentifiers;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
@property (nonatomic,retain) NSMutableSet *immovableIdentifiers API_AVAILABLE(macos(13.0));
#endif// 130000

- (id)initWithToolbar:(NSToolbar *)tb;

@end

CUI_ToolbarObj *CUI_ToolbarObjWithTag( NSInteger tag );
void CUI_ToolbarObjAdd( NSToolbar *tb );
void CUI_ToolbarObjAddItem( CUI_ToolbarObj *obj, NSString *identifier, NSInteger tag, NSString *label, NSImage *image, BOOL allowed, BOOL dflt );
void CUI_ToolbarObjAddSelectableItem( CUI_ToolbarObj *obj, NSString *identifier );

NSInteger CUI_ToolbarTag( NSToolbar *tb );
NSInteger CUI_ToolbarLastTag( void );
NSToolbar *CUI_ToolbarWithTag( NSInteger tag );


// Class
Class ToolbarClass( void );

NSToolbar *ToolbarWithTag( NSInteger tag );
BOOL ToolbarExists( NSInteger tag );

// Attributes
CFStringRef ToolbarIdentifier( NSInteger tag );
NSToolbarDisplayMode ToolbarDisplayMode( NSInteger tag );
void ToolbarSetDisplayMode( NSInteger tag, NSToolbarDisplayMode mode );
BOOL ToolbarShowsBaselineSeparator( NSInteger tag );
void ToolbarSetShowsBaselineSeparator( NSInteger tag, BOOL flag );
BOOL ToolbarAllowsUserCustomization( NSInteger tag );
void ToolbarSetAllowsUserCustomization( NSInteger tag, BOOL flag );
BOOL ToolbarAllowsExtensionItems( NSInteger tag );
void ToolbarSetAllowsExtensionItems( NSInteger tag, BOOL flag );
CFArrayRef ToolbarItems( NSInteger tag );
CFArrayRef ToolbarVisibleItems( NSInteger tag );
NSToolbarSizeMode ToolbarSizeMode( NSInteger tag );
void ToolbarSetSizeMode( NSInteger tag, NSToolbarSizeMode size );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
API_AVAILABLE(macos(15.0))
BOOL ToolbarAllowsDisplayModeCustomization( NSInteger tag );
API_AVAILABLE(macos(15.0))
void ToolbarSetAllowsDisplayModeCustomization( NSInteger tag, BOOL flag );
#endif // 150000

// Managing items
CFStringRef ToolbarSelectedItemIdentifier( NSInteger tag );
void ToolbarSetSelectedItemIdentifier( NSInteger tag, CFStringRef itemIdentifier );
NSToolbarItem *ToolbarSelectedItem( NSInteger tag );
NSInteger ToolbarSelectedItemTag( NSInteger tag );
void ToolbarSetSelectedItem( NSInteger tag, NSInteger itemTag );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
CFStringRef ToolbarCenteredItemIdentifier( NSInteger tag );
#endif// 101400
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
API_AVAILABLE(macos(13.0))
CFSetRef ToolbarCenteredItemIdentifiers( NSInteger tag );
API_AVAILABLE(macos(13.0))
void ToolbarSetCenteredItemIdentifiers( NSInteger tag, CFSetRef identifiers );
#endif// 130000
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
API_AVAILABLE(macos(15.0))
CFArrayRef ToolbarItemIdentifiers( NSInteger tag );
API_AVAILABLE(macos(15.0))
void ToolbarSetItemIdentifiers( NSInteger tag, CFArrayRef identifiers );
#endif // 150000

// Display
BOOL ToolbarIsVisible( NSInteger tag );
void ToolbarSetVisible( NSInteger tag, BOOL flag );

// Customization
void ToolbarRunCustomizationPalette( NSInteger tag );
BOOL ToolbarCustomizationPaletteIsRunning( NSInteger tag );

// Autosaving
BOOL ToolbarAutosavesConfiguration( NSInteger tag );
void ToolbarSetAutosavesConfiguration( NSInteger tag, BOOL flag );
CFDictionaryRef ToolbarConfigurationDictionary( NSInteger tag );
void ToolbarSetConfigurationFromDictionary( NSInteger tag, CFDictionaryRef dict );

//void ToolbarInsertItem( NSInteger toolbarTag, NSInteger itemTag, CFStringRef inIdentifier, CFStringRef inLabel, CFStringRef inImageName, BOOL allowed, BOOL dflt );


// Custom
void ToolbarSetSelectableItemIdentifiers( NSInteger tag, CFTypeRef identifiers );

// Hide/show tooltips
void ToolbarSetToolTipsHidden( NSInteger tag, BOOL flag );

// Init
NSToolbar *ToolbarInit( NSInteger inTag );

// Statement
void CUI_Toolbar( NSInteger inTag );
