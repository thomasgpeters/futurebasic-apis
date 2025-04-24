/*
 SplitViewItem.h

 Bernie Wylde
 */


#import "CocoaUI.h"


// Class
Class SplitViewItemClass( void );

// Create
NSSplitViewItem *SplitViewItemSidebarWithViewController( NSViewController *vc );
NSSplitViewItem *SplitViewItemContentListWithViewController( NSViewController *vc );
NSSplitViewItem *SplitViewItemWithViewController( NSViewController *vc );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
NSSplitViewItem *SplitViewItemInspectorWithViewController( NSViewController *vc );
#endif// 140000

// Thickness
CGFloat SplitViewItemAutomaticMaximumThickness( NSSplitViewItem *ref );
void SplitViewItemSetAutomaticMaximumThickness( NSSplitViewItem *ref, CGFloat thickness );
CGFloat SplitViewItemPreferredThicknessFraction( NSSplitViewItem *ref );
void SplitViewItemSetPreferredThicknessFraction( NSSplitViewItem *ref, CGFloat fraction );
CGFloat SplitViewItemMinimumThickness( NSSplitViewItem *ref );
void SplitViewItemSetMinimumThicknessFraction( NSSplitViewItem *ref, CGFloat thickness );
CGFloat SplitViewItemMaximumThickness( NSSplitViewItem *ref );
void SplitViewItemSetMaximumThickness( NSSplitViewItem *ref, CGFloat thickness );

// Autolayout behaviors
NSLayoutPriority SplitViewItemHoldingPriority( NSSplitViewItem *ref );
void SplitViewItemSetHoldingPriority( NSSplitViewItem *ref, NSLayoutPriority priority );

// Behavior
NSSplitViewItemBehavior SplitViewItemBehavior( NSSplitViewItem *ref );

// Collapsing and expanding
BOOL SplitViewItemIsCollapsed( NSSplitViewItem *ref );
void SplitViewItemSetCollapsed( NSSplitViewItem *ref, BOOL flag );
BOOL SplitViewItemCanCollapse( NSSplitViewItem *ref );
void SplitViewItemSetCanCollapse( NSSplitViewItem *ref, BOOL flag );
NSSplitViewItemCollapseBehavior SplitViewItemCollapseBehavior( NSSplitViewItem *ref );
void SplitViewItemSetCollapseBehavior( NSSplitViewItem *ref, NSSplitViewItemCollapseBehavior behavior );
BOOL SplitViewItemIsSpringLoaded( NSSplitViewItem *ref );
void SplitViewItemSetSpringLoaded( NSSplitViewItem *ref, BOOL flag );

// Customizing appearance
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
BOOL SplitViewItemAllowsFullHeightLayout( NSSplitViewItem *ref );
API_AVAILABLE(macos(11.0))
void SplitViewItemSetAllowsFullHeightLayout( NSSplitViewItem *ref, BOOL flag );
API_AVAILABLE(macos(11.0))
NSTitlebarSeparatorStyle SplitViewItemTitlebarSeparatorStyle( NSSplitViewItem *ref );
API_AVAILABLE(macos(11.0))
void SplitViewItemSetTitlebarSeparatorStyle( NSSplitViewItem *ref, NSTitlebarSeparatorStyle style );
#endif// 110000

// View controller
NSViewController *SplitViewItemViewController( NSSplitViewItem *ref );

