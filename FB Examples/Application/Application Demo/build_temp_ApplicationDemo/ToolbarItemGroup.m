/*
 ToolbarItemGroup.m

 Bernie Wylde
 */

#import "ToolbarItemGroup.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500

// Class
Class ToolbarItemGroupClass( void )
{ return [NSToolbarItemGroup class]; }

// Subitems
CFArrayRef ToolbarItemGroupSubitems( NSToolbarItemGroup *ref )
{ return (__bridge CFArrayRef)[ref subitems]; }

void ToolbarItemGroupSetSubitems( NSToolbarItemGroup *ref, CFArrayRef subitems )
{ [ref setSubitems:(__bridge NSArray *)subitems]; }

// Initializers
NSToolbarItemGroup *ToolbarItemGroupWithImages( CFStringRef identifier, CFArrayRef images, NSToolbarItemGroupSelectionMode selectionMode, CFArrayRef labels, CFTypeRef target, SEL action )
{ return [NSToolbarItemGroup groupWithItemIdentifier:(__bridge NSString *)identifier images:(__bridge NSArray *)images selectionMode:selectionMode labels:(__bridge NSArray *)labels target:(__bridge id)target action:action]; }

NSToolbarItemGroup *ToolbarItemGroupWithTitles( CFStringRef identifier, CFArrayRef titles, NSToolbarItemGroupSelectionMode selectionMode, CFArrayRef labels, CFTypeRef target, SEL action )
{ return [NSToolbarItemGroup groupWithItemIdentifier:(__bridge NSString *)identifier images:(__bridge NSArray *)titles selectionMode:selectionMode labels:(__bridge NSArray *)labels target:(__bridge id)target action:action]; }

// Instance properties
NSToolbarItemGroupControlRepresentation ToolbarItemGroupControlRepresentation( NSToolbarItemGroup *ref )
{ return [ref controlRepresentation]; }

void ToolbarItemGroupSetControlRepresentation( NSToolbarItemGroup *ref, NSToolbarItemGroupControlRepresentation representation )
{ [ref setControlRepresentation:representation]; }

NSInteger ToolbarItemGroupSelectedIndex( NSToolbarItemGroup *ref )
{ return [ref selectedIndex]; }

void ToolbarItemGroupSetSelectedIndex( NSToolbarItemGroup *ref, NSInteger index )
{ [ref setSelectedIndex:index]; }

NSToolbarItemGroupSelectionMode ToolbarItemGroupSelectionMode( NSToolbarItemGroup *ref )
{ return [ref selectionMode]; }

void ToolbarItemGroupSetSelectionMode( NSToolbarItemGroup *ref, NSToolbarItemGroupSelectionMode selectionMode )
{ [ref setSelectionMode:selectionMode]; }

// Instance methods
BOOL ToolbarItemGroupIsSelectedAtIndex( NSToolbarItemGroup *ref, NSInteger index )
{ return [ref isSelectedAtIndex:index]; }

void ToolbarItemGroupSetSelectedAtIndex( NSToolbarItemGroup *ref, BOOL flag, NSInteger index )
{ [ref setSelected:flag atIndex:index]; }

#endif// 101500

