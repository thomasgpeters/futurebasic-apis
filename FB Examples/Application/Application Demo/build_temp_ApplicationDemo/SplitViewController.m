/*
 SplitViewController.m

 Bernie Wylde
 */

#import "SplitViewItem.h"


// Class
Class SplitViewControllerClass( void )
{ return [NSSplitViewController class]; }

// Create
NSSplitViewController *SplitViewControllerInit( void )
{
#if __has_feature(objc_arc)
    return [[NSSplitViewController alloc] init];
#else
    return [[[NSSplitViewController alloc] init] autorelease];
#endif
}

// Configure
NSInteger SplitViewControllerSplitView( NSSplitViewController *ref )
{
    NSSplitView *splitView = [ref splitView];
    if ( splitView ) return [splitView tag];
    return 0;
}

void SplitViewControllerSetSplitView( NSSplitViewController *ref, NSInteger tag )
{
    NSSplitView *splitView = SplitViewWithTag( tag );
    if ( splitView ) [ref setSplitView:splitView];
}

NSSplitViewItem *SplitViewControllerSplitViewItemForViewController( NSSplitViewController *ref, NSViewController *vc )
{ return [ref splitViewItemForViewController:vc]; }

CFArrayRef SplitViewControllerSplitViewItems( NSSplitViewController *ref )
{ return (__bridge CFArrayRef)[ref splitViewItems]; }

void SplitViewControllerSetSplitViewItems( NSSplitViewController *ref, CFArrayRef splitViewItems )
{ [ref setSplitViewItems:(__bridge NSArray *)splitViewItems]; }

// Modify
void SplitViewControllerAddSplitViewItem( NSSplitViewController *ref, NSSplitViewItem *item )
{ [ref addSplitViewItem:item]; }

void SplitViewControllerInsertSplitViewItem( NSSplitViewController *ref, NSSplitViewItem *item, NSInteger index )
{ [ref insertSplitViewItem:item atIndex:index]; }

void SplitViewControllerRemoveSplitViewItem( NSSplitViewController *ref, NSSplitViewItem *item )
{ [ref removeSplitViewItem:item]; }

// Sidebars
void SplitViewControllerToggleSidebar( NSSplitViewController *ref )
{ [ref toggleSidebar:nil]; }

CGFloat SplitViewControllerMinimumThicknessForInlineSidebars( NSSplitViewController *ref )
{ return [ref minimumThicknessForInlineSidebars]; }

void SplitViewControllerSetMinimumThicknessForInlineSidebars( NSSplitViewController *ref, CGFloat thickness )
{ [ref setMinimumThicknessForInlineSidebars:thickness]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
void SplitViewControllerToggleInspector( NSSplitViewController *ref, id inspector )
{ [ref toggleInspector:inspector]; }
#endif// 140000


