/*
 TabView.h

 Bernie Wylde
 */

#import "CocoaUI.h"

@interface TabViewSC : NSTabView
@end

@interface NSTabView (Additions)
@property (nonatomic,retain) NSNumber *tagNumber;
- (NSInteger)tag;
- (void)setTag:(NSInteger)tag;
@end

// dialog events
enum {
    tabViewDidChangeNumberOfTabViewItems = 1700,
    tabViewShouldSelectTabViewItem,
    tabViewWillSelectTabViewItem,
    tabViewDidSelectTabViewItem
};

@interface CUI_TabViewDelegate : NSObject <NSTabViewDelegate>
@property (nonatomic,assign) BOOL boolVal;
@property (nonatomic,assign) NSInteger indexVal;
@end

CUI_TabViewDelegate *CUI_TabViewDelegateObj( void );

void CUI_TabViewItemFixFrame( NSTabViewItem *item );

// Class
Class TabViewClass( void );

NSTabView *TabViewWithTag( NSInteger tag );
BOOL TabViewExists( NSInteger tag );

// Adding and removing tabs
void TabViewAddItem( NSInteger tag, NSTabViewItem *item );
void TabViewInsertItem( NSInteger tag, NSTabViewItem *item, NSInteger index );
void TabViewRemoveItem( NSInteger tag, NSTabViewItem *item );

// Accessing tabs
NSInteger TabViewIndexOfItem( NSInteger tag, NSTabViewItem *item );
NSInteger TabViewIndexOfItemWithIdentifier( NSInteger tag, CFTypeRef identifier );
NSInteger TabViewIndex( NSInteger tag );
NSInteger TabViewNumberOfItems( NSInteger tag );
NSTabViewItem *TabViewItemAtIndex( NSInteger tag, NSInteger index );
CFArrayRef TabViewItems( NSInteger tag );

// Configure
NSTabViewType TabViewType( NSInteger tag );
void TabViewSetType( NSInteger tag, NSTabViewType type );
NSTabPosition TabViewPosition( NSInteger tag );
void TabViewSetPosition( NSInteger tag, NSTabPosition position );
NSTabViewBorderType TabViewBorderType( NSInteger tag );
void TabViewSetBorderType( NSInteger tag, NSTabViewBorderType type );

// Select
void TabViewSelectFirstItem( NSInteger tag );
void TabViewSelectLastItem( NSInteger tag );
void TabViewSelectNextItem( NSInteger tag );
void TabViewSelectPreviousItem( NSInteger tag );
void TabViewSelectItemAtIndex( NSInteger tag, NSInteger index );
void TabViewSelectItemWithIdentifier( NSInteger tag, CFTypeRef identifier );
NSTabViewItem *TabViewSelectedItem( NSInteger tag );
void TabViewTakeSelectedItemFromSender( NSInteger tag, CFTypeRef sender );

// Font
NSFont *TabViewFont( NSInteger tag );
void TabViewSetFont( NSInteger tag, CFTypeRef inFont );

// Tint
void TabViewSetControlTint( NSInteger tag, NSControlTint tint );

// Background
BOOL TabViewDrawsBackground( NSInteger tag );
void TabViewSetDrawsBackground( NSInteger tag, BOOL flag );

// Size
CGSize TabViewMinimumSize( NSInteger tag );
CGRect TabViewContentRect( NSInteger tag );
NSControlSize TabViewControlSize( NSInteger tag );
void TabViewSetControlSize( NSInteger tag, NSControlSize size );

// Truncate
BOOL TabViewAllowsTruncatedLabels( NSInteger tag );
void TabViewSetAllowsTruncatedLabels( NSInteger tag, BOOL flag );

// Event handling
NSTabViewItem *TabViewItemAtPoint( NSInteger tag, CGPoint pt );


// custom
void TabViewAddSubview( NSInteger tabTag, NSInteger index, NSInteger subviewTag );

// Init
NSTabView *TabViewInit( NSInteger inTag, CGRect inRect );

// Statement
void CUI_TabView( NSInteger inTag, NSInteger inIndex, CFTypeRef inItems, CGRect inRect, NSInteger inWndTag );

