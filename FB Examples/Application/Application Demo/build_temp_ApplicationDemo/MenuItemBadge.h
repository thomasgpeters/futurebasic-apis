/*
 MenuItemBadge.h

 Bernie Wylde
 */

#import "CocoaUI.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000

// Create
API_AVAILABLE(macos(14.0))
NSMenuItemBadge *MenuItemBadgeWithCount( NSInteger count );
API_AVAILABLE(macos(14.0))
NSMenuItemBadge *MenuItemBadgeWithType( NSInteger count, NSMenuItemBadgeType type );
API_AVAILABLE(macos(14.0))
NSMenuItemBadge *MenuItemBadgeWithString( CFStringRef string );

// Attributes
API_AVAILABLE(macos(14.0))
NSInteger MenuItemBadgeItemCount( NSMenuItemBadge *ref );
API_AVAILABLE(macos(14.0))
CFStringRef MenuItemBadgeStringValue( NSMenuItemBadge *ref );
API_AVAILABLE(macos(14.0))
NSMenuItemBadgeType MenuItemBadgeType( NSMenuItemBadge *ref );

// Configure
API_AVAILABLE(macos(14.0))
NSMenuItemBadge *MenuItemBadgeAlertsWithCount( NSInteger count );
API_AVAILABLE(macos(14.0))
NSMenuItemBadge *MenuItemBadgeNewItemsWithCount( NSInteger count );
API_AVAILABLE(macos(14.0))
NSMenuItemBadge *MenuItemBadgeUpdatesWithCount( NSInteger count );

#endif// 140000
