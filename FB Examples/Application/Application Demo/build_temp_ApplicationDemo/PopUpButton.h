/*
 PopUpButton.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "Control.h"
//#import "DialogEvent.h"
//#import "Menu.h"
//#import "View.h"
//#import "Window.h"

@interface PopUpButtonSC : NSPopUpButton
@end

//@interface CUI_PopUpButtonTarget : NSObject
//@end

// Class
Class PopUpButtonClass( void );

NSPopUpButton *PopUpButtonWithTag( NSInteger tag );
BOOL PopUpButtonExists( NSInteger tag );

// Type of menu
BOOL PopUpButtonPullsDown( NSInteger tag );
void PopUpButtonSetPullsDown( NSInteger tag, BOOL flag );
BOOL PopUpButtonAutoenablesItems( NSInteger tag );
void PopUpButtonSetAutoenablesItems( NSInteger tag, BOOL flag );

// Insert and delete
void PopUpButtonAddItemWithTitle( NSInteger tag, CFStringRef title );
void PopUpButtonAddItemsWithTitles( NSInteger tag, CFArrayRef titles );
void PopUpButtonInsertItemWithTitle( NSInteger tag, CFStringRef title, NSInteger index );
void PopUpButtonRemoveAllItems( NSInteger tag );
void PopUpButtonRemoveItemWithTitle( NSInteger tag, CFStringRef title );
void PopUpButtonRemoveItemAtIndex( NSInteger tag, NSInteger index );
CFStringRef PopUpButtonTitleOfSelectedItem( NSInteger tag );
NSInteger PopUpButtonIndexOfSelectedItem( NSInteger tag );
void PopUpButtonSelectItemAtIndex( NSInteger tag, NSInteger index );
void PopUpButtonSelectItemWithTag( NSInteger popUpTag, NSInteger itemTag );
void PopUpButtonSelectItemWithTitle( NSInteger tag, CFStringRef title );
NSInteger PopUpButtonNumberOfItems( NSInteger tag );
CFArrayRef PopUpButtonItemArray( NSInteger tag );
CFStringRef PopUpButtonItemTitleAtIndex( NSInteger tag, NSInteger index );
CFArrayRef PopUpButtonItemTitles( NSInteger tag );

NSInteger PopUpButtonIndexOfItemWithTag( NSInteger popUpTag, NSInteger itemTag );
NSInteger PopUpButtonIndexOfItemWithTitle( NSInteger tag, CFStringRef title );

NSMenu *PopUpButtonMenu( NSInteger tag );
NSInteger PopUpButtonMenuIndex( NSInteger tag );
void PopUpButtonSetMenu( NSInteger tag, NSInteger menuIndex );

NSMenuItem *PopUpButtonItemAtIndex( NSInteger tag, NSInteger index );
NSMenuItem *PopUpButtonItemWithTitle( NSInteger tag, CFStringRef title );
NSMenuItem *PopUpButtonLastItem( NSInteger tag );

// Indices of menu items
NSInteger PopUpButtonIndexOfItem( NSInteger tag, NSMenuItem *item );
NSInteger PopUpButtonIndexOfItemWithRepresentedObject( NSInteger tag, CFTypeRef obj );


void PopUpButtonSetTitle( NSInteger tag, CFStringRef title );
void PopUpButtonItemSetEnabled( NSInteger tag, NSInteger index, BOOL flag );

// Preferred edge
CGRectEdge PopUpButtonPreferredEdge( NSInteger tag );
void PopUpButtonSetPreferredEdge( NSInteger tag, CGRectEdge edge );

// State
void PopUpButtonSynchronizeTitleAndSelectedItem( NSInteger tag );

// -- PopUpButtonCell methods --
BOOL PopUpButtonUsesItemFromMenu( NSInteger tag );
void PopUpButtonSetUsesItemFromMenu( NSInteger tag, BOOL flag );
BOOL PopUpButtonAltersStateOfSelectedItem( NSInteger tag );
void PopUpButtonSetAltersStateOfSelectedItem( NSInteger tag, BOOL flag );
NSPopUpArrowPosition PopUpButtonArrowPosition( NSInteger tag );
void PopUpButtonSetArrowPosition( NSInteger tag, NSPopUpArrowPosition position );

// Init
NSPopUpButton *PopUpButtonInit( NSInteger inTag, CGRect inRect );

// Statement
void CUI_PopUpButton( NSInteger inTag, NSInteger inEnabled, NSInteger inIndex, CFTypeRef inItems, CGRect inRect, NSInteger inPullsDown, NSInteger inWndTag );
