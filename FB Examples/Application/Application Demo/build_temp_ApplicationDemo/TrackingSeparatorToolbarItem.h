/*
 TrackingSeparatorToolbarItem.h

 Bernie Wylde
 */


#import "CocoaUI.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000

// Class
API_AVAILABLE(macos(11.0))
Class TrackingSeparatorToolbarItemClass( void );

// Create
API_AVAILABLE(macos(11.0))
NSTrackingSeparatorToolbarItem *TrackingSeparatorToolbarItemWithIdentifier( CFStringRef identifier, NSInteger splitViewTag, NSInteger dividerIndex );

// Configure
API_AVAILABLE(macos(11.0))
NSInteger TrackingSeparatorToolbarItemDividerIndex( NSTrackingSeparatorToolbarItem *ref );
API_AVAILABLE(macos(11.0))
void TrackingSeparatorToolbarItemSetDividerIndex( NSTrackingSeparatorToolbarItem *ref, NSInteger index );
API_AVAILABLE(macos(11.0))
NSInteger TrackingSeparatorToolbarItemSplitView( NSTrackingSeparatorToolbarItem *ref );
API_AVAILABLE(macos(11.0))
void TrackingSeparatorToolbarItemSetSplitView( NSTrackingSeparatorToolbarItem *ref, NSInteger splitViewTag );

#endif// 110000
