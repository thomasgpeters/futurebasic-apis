/*
 MenuItemBadge.m

 Bernie Wylde
 */

#import "MenuItemBadge.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000

// Create
NSMenuItemBadge *MenuItemBadgeWithCount( NSInteger count )
{
#if __has_feature(objc_arc)
    return [[NSMenuItemBadge alloc] initWithCount:count];
#else
    return [[[NSMenuItemBadge alloc] initWithCount:count] autorelease];
#endif
}

NSMenuItemBadge *MenuItemBadgeWithType( NSInteger count, NSMenuItemBadgeType type )
{
#if __has_feature(objc_arc)
    return [[NSMenuItemBadge alloc] initWithCount:count type:type];
#else
    return [[[NSMenuItemBadge alloc] initWithCount:count type:type] autorelease];
#endif
}

NSMenuItemBadge *MenuItemBadgeWithString( CFStringRef string )
{
#if __has_feature(objc_arc)
    return [[NSMenuItemBadge alloc] initWithString:(__bridge NSString *)string];
#else
    return [[[NSMenuItemBadge alloc] initWithString:(__bridge NSString *)string] autorelease];
#endif
}

// Attributes
NSInteger MenuItemBadgeItemCount( NSMenuItemBadge *ref )
{ return [ref itemCount]; }

CFStringRef MenuItemBadgeStringValue( NSMenuItemBadge *ref )
{ return (__bridge CFStringRef)[ref stringValue]; }

NSMenuItemBadgeType MenuItemBadgeType( NSMenuItemBadge *ref )
{ return [ref type]; }

// Configure
NSMenuItemBadge *MenuItemBadgeAlertsWithCount( NSInteger count )
{ return [NSMenuItemBadge alertsWithCount:count]; }

NSMenuItemBadge *MenuItemBadgeNewItemsWithCount( NSInteger count )
{ return [NSMenuItemBadge newItemsWithCount:count]; }

NSMenuItemBadge *MenuItemBadgeUpdatesWithCount( NSInteger count )
{ return [NSMenuItemBadge updatesWithCount:count]; }

#endif// 140000
