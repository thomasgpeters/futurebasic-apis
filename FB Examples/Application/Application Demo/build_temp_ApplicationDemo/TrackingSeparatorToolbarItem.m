/*
 TrackingSeparatorToolbarItem.m

 Bernie Wylde
 */

#import "TrackingSeparatorToolbarItem.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000

// Class
Class TrackingSeparatorToolbarItemClass( void )
{ return [NSTrackingSeparatorToolbarItem class]; }

// Create
NSTrackingSeparatorToolbarItem *TrackingSeparatorToolbarItemWithIdentifier( CFStringRef identifier, NSInteger splitViewTag, NSInteger dividerIndex )
{
    NSSplitView *splitView = SplitViewWithTag( splitViewTag );
    if ( splitView ) {
        return [NSTrackingSeparatorToolbarItem trackingSeparatorToolbarItemWithIdentifier:(__bridge NSString *)identifier splitView:splitView dividerIndex:dividerIndex];
    }
    return nil;
}

// Configure
NSInteger TrackingSeparatorToolbarItemDividerIndex( NSTrackingSeparatorToolbarItem *ref )
{ return [ref dividerIndex]; }

void TrackingSeparatorToolbarItemSetDividerIndex( NSTrackingSeparatorToolbarItem *ref, NSInteger index )
{ [ref setDividerIndex:index]; }

NSInteger TrackingSeparatorToolbarItemSplitView( NSTrackingSeparatorToolbarItem *ref )
{
    NSSplitView *splitView = [ref splitView];
    if ( splitView ) return [splitView tag];
    return 0;
}

void TrackingSeparatorToolbarItemSetSplitView( NSTrackingSeparatorToolbarItem *ref, NSInteger splitViewTag )
{
    NSSplitView *splitView = SplitViewWithTag( splitViewTag );
    if ( splitView ) [ref setSplitView:splitView];
}

#endif// 110000
