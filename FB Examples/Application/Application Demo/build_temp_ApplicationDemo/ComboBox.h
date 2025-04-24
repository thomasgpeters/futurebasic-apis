/*
 ComboBox.h

 Bernie Wylde
 */


#import "CocoaUI.h"

#import "Control.h"
#import "DialogEvent.h"
#import "View.h"
#import "Window.h"

#pragma mark - subclass
@interface ComboBoxSC : NSComboBox
@end

// dialog events
enum {
    comboBoxSelectionDidChange = 1100,
    comboBoxSelectionIsChanging,
    comboBoxWillDismiss,
    comboBoxWillPopUp
};

@interface CUI_ComboBoxDelegate : NSObject <NSComboBoxDelegate,NSComboBoxDataSource>
@property (nonatomic,retain) NSMutableArray *comboBoxData;
@end

CUI_ComboBoxDelegate *CUI_ComboBoxDelegateObj( void );

// Class
Class ComboBoxClass( void );

NSComboBox *ComboBoxWithTag( NSInteger tag );
BOOL ComboBoxExists( NSInteger tag );

// - attributes -
BOOL ComboBoxHasVerticalScroller( NSInteger tag );
void ComboBoxSetHasVerticalScroller( NSInteger tag, BOOL flag );
CGSize ComboBoxIntercellSpacing( NSInteger tag );
void ComboBoxSetIntercellSpacing( NSInteger tag, CGSize size );
BOOL ComboBoxIsBordered( NSInteger tag );
void ComboBoxSetBordered( NSInteger tag, BOOL flag );
CGFloat ComboBoxItemHeight( NSInteger tag );
void ComboBoxSetItemHeight( NSInteger tag, CGFloat height );
NSInteger ComboBoxNumberOfVisibleItems( NSInteger tag );
void ComboBoxSetNumberOfVisibleItems( NSInteger tag, NSInteger value );

// - data source -
void ComboBoxSetUsesDataSource( NSInteger tag, BOOL flag );

// - items -
void ComboBoxAddItems( NSInteger tag, CFArrayRef items );
void ComboBoxAddItem( NSInteger tag, CFTypeRef item );
void ComboBoxInsertItem( NSInteger tag, CFTypeRef item, NSInteger index );
CFArrayRef ComboBoxValues( NSInteger tag );
void ComboBoxRemoveAllItems( NSInteger tag );
void ComboBoxRemoveItemAtIndex( NSInteger tag, NSInteger index );
void ComboBoxRemoveItemWithValue( NSInteger tag, CFTypeRef value );
NSInteger ComboBoxNumberOfItems( NSInteger tag );

// - display list -
NSInteger ComboBoxIndexOfItemWithValue( NSInteger tag, CFTypeRef value );
CFTypeRef ComboBoxItemValueAtIndex( NSInteger tag, NSInteger index );
void ComboBoxScrollItemAtIndexToTop( NSInteger tag, NSInteger index );
void ComboBoxScrollItemAtIndexToVisible( NSInteger tag, NSInteger index );
void ComboBoxReloadData( NSInteger tag );

// - selection -
void ComboBoxDeselectItemAtIndex( NSInteger tag, NSInteger index );
NSInteger ComboBoxIndexOfSelectedItem( NSInteger tag );
CFTypeRef ComboBoxValueOfSelectedItem( NSInteger tag );
void ComboBoxSelectItemAtIndex( NSInteger tag, NSInteger index );
void ComboBoxSelectItemWithValue( NSInteger tag, CFTypeRef value );
void ComboBoxNoteNumberOfItemsChanged( NSInteger tag );

// - completing the text field -
void ComboBoxSetCompletes( NSInteger tag, BOOL flag );

// custom
CFMutableArrayRef ComboBoxData( NSInteger tag );
void ComboBoxSetData( NSInteger tag, CFMutableArrayRef array );

// Init
NSComboBox *ComboBoxInit( NSInteger inTag, CGRect inRect );

// statement
void CUI_ComboBox( NSInteger inTag, NSInteger inEnabled, CFTypeRef inItems, CFStringRef inText, CGRect inRect, NSInteger inWndTag );

