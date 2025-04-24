/*
 SplitViewItem.m

 Bernie Wylde
 */

#import "SplitViewItem.h"


// Class
Class SplitViewItemClass( void )
{ return [NSSplitViewItem class]; }

// Create
NSSplitViewItem *SplitViewItemSidebarWithViewController( NSViewController *vc )
{ return [NSSplitViewItem sidebarWithViewController:vc]; }

NSSplitViewItem *SplitViewItemContentListWithViewController( NSViewController *vc )
{ return [NSSplitViewItem contentListWithViewController:vc]; }

NSSplitViewItem *SplitViewItemWithViewController( NSViewController *vc )
{ return [NSSplitViewItem splitViewItemWithViewController:vc]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
NSSplitViewItem *SplitViewItemInspectorWithViewController( NSViewController *vc )
{ return [NSSplitViewItem inspectorWithViewController:vc]; }
#endif// 140000

// Thickness
CGFloat SplitViewItemAutomaticMaximumThickness( NSSplitViewItem *ref )
{return [ref automaticMaximumThickness]; }

void SplitViewItemSetAutomaticMaximumThickness( NSSplitViewItem *ref, CGFloat thickness )
{ [ref setAutomaticMaximumThickness:thickness]; }

CGFloat SplitViewItemPreferredThicknessFraction( NSSplitViewItem *ref )
{ return [ref preferredThicknessFraction]; }

void SplitViewItemSetPreferredThicknessFraction( NSSplitViewItem *ref, CGFloat fraction )
{ [ref setPreferredThicknessFraction:fraction]; }

CGFloat SplitViewItemMinimumThickness( NSSplitViewItem *ref )
{ return [ref minimumThickness]; }

void SplitViewItemSetMinimumThicknessFraction( NSSplitViewItem *ref, CGFloat thickness )
{ [ref setMinimumThickness:thickness]; }

CGFloat SplitViewItemMaximumThickness( NSSplitViewItem *ref )
{ return [ref maximumThickness]; }

void SplitViewItemSetMaximumThickness( NSSplitViewItem *ref, CGFloat thickness )
{ [ref setMaximumThickness:thickness]; }

// Autolayout behaviors
NSLayoutPriority SplitViewItemHoldingPriority( NSSplitViewItem *ref )
{ return [ref holdingPriority]; }

void SplitViewItemSetHoldingPriority( NSSplitViewItem *ref, NSLayoutPriority priority )
{ [ref setHoldingPriority:priority]; }

// Behavior
NSSplitViewItemBehavior SplitViewItemBehavior( NSSplitViewItem *ref )
{ return [ref behavior]; }

// Collapsing and expanding
BOOL SplitViewItemIsCollapsed( NSSplitViewItem *ref )
{ return [ref isCollapsed]; }

void SplitViewItemSetCollapsed( NSSplitViewItem *ref, BOOL flag )
{ [ref setCollapsed:flag]; }

BOOL SplitViewItemCanCollapse( NSSplitViewItem *ref )
{ return [ref canCollapse]; }

void SplitViewItemSetCanCollapse( NSSplitViewItem *ref, BOOL flag )
{ [ref setCanCollapse:flag]; }

NSSplitViewItemCollapseBehavior SplitViewItemCollapseBehavior( NSSplitViewItem *ref )
{ return [ref collapseBehavior]; }

void SplitViewItemSetCollapseBehavior( NSSplitViewItem *ref, NSSplitViewItemCollapseBehavior behavior )
{ [ref setCollapseBehavior:behavior]; }

BOOL SplitViewItemIsSpringLoaded( NSSplitViewItem *ref )
{ return [ref isSpringLoaded]; }

void SplitViewItemSetSpringLoaded( NSSplitViewItem *ref, BOOL flag )
{ [ref setSpringLoaded:flag]; }

// Customizing appearance
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
BOOL SplitViewItemAllowsFullHeightLayout( NSSplitViewItem *ref )
{ return [ref allowsFullHeightLayout]; }

void SplitViewItemSetAllowsFullHeightLayout( NSSplitViewItem *ref, BOOL flag )
{ [ref setAllowsFullHeightLayout:flag]; }

NSTitlebarSeparatorStyle SplitViewItemTitlebarSeparatorStyle( NSSplitViewItem *ref )
{ return [ref titlebarSeparatorStyle]; }

void SplitViewItemSetTitlebarSeparatorStyle( NSSplitViewItem *ref, NSTitlebarSeparatorStyle style )
{ [ref setTitlebarSeparatorStyle:style]; }
#endif// 110000

// View controller
NSViewController *SplitViewItemViewController( NSSplitViewItem *ref )
{ return [ref viewController]; }

