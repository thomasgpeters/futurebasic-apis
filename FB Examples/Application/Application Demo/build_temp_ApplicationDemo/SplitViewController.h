/*
 SplitViewController.h

 Bernie Wylde
 */


#import "CocoaUI.h"


// Class
Class SplitViewControllerClass( void );

// Create
NSSplitViewController *SplitViewControllerInit( void );

// Configure
NSInteger SplitViewControllerSplitView( NSSplitViewController *ref );
void SplitViewControllerSetSplitView( NSSplitViewController *ref, NSInteger tag );
NSSplitViewItem *SplitViewControllerSplitViewItemForViewController( NSSplitViewController *ref, NSViewController *vc );
CFArrayRef SplitViewControllerSplitViewItems( NSSplitViewController *ref );
void SplitViewControllerSetSplitViewItems( NSSplitViewController *ref, CFArrayRef splitViewItems );

// Modify
void SplitViewControllerAddSplitViewItem( NSSplitViewController *ref, NSSplitViewItem *item );
void SplitViewControllerInsertSplitViewItem( NSSplitViewController *ref, NSSplitViewItem *item, NSInteger index );
void SplitViewControllerRemoveSplitViewItem( NSSplitViewController *ref, NSSplitViewItem *item );

// Sidebars
void SplitViewControllerToggleSidebar( NSSplitViewController *ref );
CGFloat SplitViewControllerMinimumThicknessForInlineSidebars( NSSplitViewController *ref );
void SplitViewControllerSetMinimumThicknessForInlineSidebars( NSSplitViewController *ref, CGFloat thickness );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
void SplitViewControllerToggleInspector( NSSplitViewController *ref, id inspector );
#endif// 140000

