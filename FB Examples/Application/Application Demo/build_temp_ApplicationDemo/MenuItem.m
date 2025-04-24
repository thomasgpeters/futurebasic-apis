/*
 MenuItem.m

 Bernie Wylde
 */

#import "MenuItem.h"

// Class
Class MenuItemClass( void )
{ return [NSMenuItem class]; }

NSMenuItem *CUI_MenuItemAtIndex( NSMenu *menu, NSInteger index )
{
    if ( index > 1000000 ) {
        //return (NSMenuItem *)index;
        return (__bridge NSMenuItem *)(void *)index;
    }
    
    NSInteger count = [menu numberOfItems];
    if ( index < count ) return [menu itemAtIndex:index];
    return nil;
}

BOOL MenuItemExists( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    return ( item != nil );
}

// Create
NSMenuItem *MenuItemInit( CFStringRef title, CFStringRef action, CFStringRef keyEquivalent )
{
#if __has_feature(objc_arc)
    return [[NSMenuItem alloc] initWithTitle:(__bridge NSString *)title action:NSSelectorFromString((__bridge NSString *)action) keyEquivalent:(__bridge NSString *)keyEquivalent];
#else
    return [[[NSMenuItem alloc] initWithTitle:(__bridge NSString *)title action:NSSelectorFromString((__bridge NSString *)action) keyEquivalent:(__bridge NSString *)keyEquivalent] autorelease];
#endif
}

// Enable
BOOL MenuItemIsEnabled( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return [item isEnabled];
    return NO;
}

void MenuItemSetEnabled( NSInteger menuIndex, NSInteger itemIndex, BOOL flag )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) [item setEnabled:flag];
}

// Hidden
BOOL MenuItemIsHidden( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return [item isHidden];
    return NO;
}

void MenuItemSetHidden( NSInteger menuIndex, NSInteger itemIndex, BOOL flag )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) [item setHidden:flag];
}

BOOL MenuItemIsHiddenOrHasHiddenAncestor( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return [item isHiddenOrHasHiddenAncestor];
    return NO;
}

// Target and action
void MenuItemSetAction( NSInteger menuIndex, NSInteger itemIndex, CFStringRef actionName )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) {
        if ( [(__bridge NSString *)actionName isEqualToString:@"menuItemAction:"]) {
            [item setTarget:CUI_MenuItemTargetObj()];
        } else {
            [item setTarget:nil];
        }
        [item setAction:NSSelectorFromString((__bridge NSString *)actionName)];
    }
}

// Title
CFStringRef MenuItemTitle( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return (__bridge CFStringRef)[item title];
    return nil;
}

void MenuItemSetTitle( NSInteger menuIndex, NSInteger itemIndex, CFStringRef title )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) [item setTitle:(__bridge NSString *)title];
}

CFAttributedStringRef MenuItemAttributedTitle( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return (__bridge CFAttributedStringRef)[item attributedTitle];
    return nil;
}

void MenuItemSetAttributedTitle( NSInteger menuIndex, NSInteger itemIndex, CFAttributedStringRef title )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) [item setAttributedTitle:(__bridge NSAttributedString *)title];
}

// Tag
NSInteger MenuItemTag( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return [item tag];
    return 0;
}

void MenuItemSetTag( NSInteger menuIndex, NSInteger itemIndex, NSInteger tag )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) [item setTag:tag];
}

// State
NSCellStateValue MenuItemState( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return [item state];
    return NSOffState;
}

void MenuItemSetState( NSInteger menuIndex, NSInteger itemIndex, NSCellStateValue state )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) [item setState:state];
}

// Image
NSImage *MenuItemImage( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return [item image];
    return nil;
}

void MenuItemSetImage( NSInteger menuIndex, NSInteger itemIndex, NSImage *image )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) [item setImage:image];
}

NSImage *MenuItemOnStateImage( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return [item onStateImage];
    return nil;
}

void MenuItemSetOnStateImage( NSInteger menuIndex, NSInteger itemIndex, NSImage *image )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) [item setOnStateImage:image];
}

NSImage *MenuItemOffStateImage( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return [item offStateImage];
    return nil;
}

void MenuItemSetOffStateImage( NSInteger menuIndex, NSInteger itemIndex, NSImage *image )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) [item setOffStateImage:image];
}

NSImage *MenuItemMixedStateImage( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return [item mixedStateImage];
    return nil;
}

void MenuItemSetMixedStateImage( NSInteger menuIndex, NSInteger itemIndex, NSImage *image )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) [item setMixedStateImage:image];
}

// Submenu
NSMenu *MenuItemSubmenu( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return [item submenu];
    return nil;
}

NSInteger MenuItemSubmenuIndex( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return CUI_MenuIndex( [item submenu] );
    return 0;
}

BOOL MenuItemHasSubmenu( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return [item hasSubmenu];
    return NO;
}

NSMenuItem *MenuItemParentItem( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return [item parentItem];
    return nil;
}

// Separator
BOOL MenuItemIsSeparator( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return [item isSeparatorItem];
    return NO;
}

NSMenuItem *MenuItemSeparatorItem( void )
{ return [NSMenuItem separatorItem]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
BOOL MenuItemIsSectionHeader( NSInteger menuID, NSInteger itemID )
{
    NSMenuItem *item = MenuItemAtIndex( menuID, itemID );
    if ( item ) return [item isSectionHeader];
    return NO;
}

//NSMenuItem *MenuItemSectionHeaderWithTitle( NSInteger menuID, NSInteger itemID, CFStringRef title )
//{ return [NSMenuItem sectionHeaderWithTitle:(__bridge NSString *)title]; }

NSMenuItem *MenuItemSectionHeaderWithTitle( CFStringRef title )// 20240705
{ return [NSMenuItem sectionHeaderWithTitle:(__bridge NSString *)title]; }

void MenuItemSetSectionHeader( NSInteger menuID, NSInteger itemID, CFStringRef inTitle )
{
    NSMenuItem *item = MenuItemAtIndex( menuID, itemID );
    if ( item ) {
        NSString *title = (__bridge NSString *)inTitle;
        NSMenu *menu = [item menu];
        if ( !title ) title = [item title];
        [menu removeItem:item];
        item = [NSMenuItem sectionHeaderWithTitle:title];
        [menu insertItem:item atIndex:itemID];
    }
}
#endif// 140000

// Menu
NSMenu *MenuItemMenu( NSMenuItem *item )
{ return [item menu]; }

NSInteger MenuItemMenuIndex( NSMenuItem *item )
{
    NSMenu *menu = [item menu];
    if ( menu ) return CUI_MenuIndex( menu );
    return -1;
}

// KeyEquivalent
CFStringRef MenuItemKeyEquivalent( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return (__bridge CFStringRef)[item keyEquivalent];
    return nil;
}

void MenuItemSetKeyEquivalent( NSInteger menuIndex, NSInteger itemIndex, CFStringRef string )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) [item setKeyEquivalent:(__bridge NSString *)string];
}

NSUInteger MenuItemKeyEquivalentModifierMask( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return [item keyEquivalentModifierMask];
    return 0;
}

void MenuItemSetKeyEquivalentModifierMask( NSInteger menuIndex, NSInteger itemIndex, NSUInteger mask )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) [item setKeyEquivalentModifierMask:mask];
}

// User key equivalents
BOOL MenuItemUsesUserKeyEquivalents( void )
{ return [NSMenuItem usesUserKeyEquivalents]; }

CFStringRef MenuItemUserKeyEquivalent( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return (__bridge CFStringRef)[item userKeyEquivalent];
    return nil;
}

// Alternate
BOOL MenuItemIsAlternate( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return [item isAlternate];
    return NO;
}

void MenuItemSetAlternate( NSInteger menuIndex, NSInteger itemIndex, BOOL flag )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) [item setAlternate:flag];
}

// Indentation level
NSInteger MenuItemIndentationLevel( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return [item indentationLevel];
    return 0;
}

void MenuItemSetIndentationLevel( NSInteger menuIndex, NSInteger itemIndex, NSInteger level )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) [item setIndentationLevel:level];
}

// ToolTip
CFStringRef MenuItemToolTip( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return (__bridge CFStringRef)[item toolTip];
    return nil;
}

void MenuItemSetToolTip( NSInteger menuIndex, NSInteger itemIndex, CFStringRef string )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) [item setToolTip:(__bridge NSString *)string];
}

// RepresentedObject
CFTypeRef MenuItemRepresentedObject( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return (__bridge CFTypeRef)[item representedObject];
    return nil;
}

void MenuItemSetRepresentedObject( NSInteger menuIndex, NSInteger itemIndex, CFTypeRef obj )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) [item setRepresentedObject:(__bridge id)obj];
}

// View
NSView *MenuItemView( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return [item view];
    return nil;
}

void MenuItemSetView( NSInteger menuIndex, NSInteger itemIndex, NSView *aView )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) [item setView:aView];
}

// Highlighted
BOOL MenuItemIsHighlighted( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return [item isHighlighted];
    return NO;
}

// Instance properties
BOOL MenuItemAllowsKeyEquivalentWhenHidden( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return [item allowsKeyEquivalentWhenHidden];
    return NO;
}

void MenuItemSetAllowsKeyEquivalentWhenHidden( NSInteger menuIndex, NSInteger itemIndex, BOOL flag )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) [item setAllowsKeyEquivalentWhenHidden:flag];
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
BOOL MenuItemAllowsAutomaticKeyEquivalentLocalization( NSInteger menuID, NSInteger itemID )
{
    NSMenuItem *item = MenuItemAtIndex( menuID, itemID );
    if ( item ) return [item allowsAutomaticKeyEquivalentLocalization];
    return NO;
}

void MenuItemSetAllowsAutomaticKeyEquivalentLocalization( NSInteger menuID, NSInteger itemID, BOOL flag )
{
    NSMenuItem *item = MenuItemAtIndex( menuID, itemID );
    if ( item ) [item setAllowsAutomaticKeyEquivalentLocalization:flag];
}

BOOL MenuItemAllowsAutomaticKeyEquivalentMirroring( NSInteger menuID, NSInteger itemID )
{
    NSMenuItem *item = MenuItemAtIndex( menuID, itemID );
    if ( item ) return [item allowsAutomaticKeyEquivalentMirroring];
    return NO;
}

void MenuItemSetAllowsAutomaticKeyEquivalentMirroring( NSInteger menuID, NSInteger itemID, BOOL flag )
{
    NSMenuItem *item = MenuItemAtIndex( menuID, itemID );
    if ( item ) [item setAllowsAutomaticKeyEquivalentMirroring:flag];
}
#endif// 120000

// Badge
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
NSMenuItemBadge *MenuItemBadge( NSInteger menuID, NSInteger itemID )
{
    NSMenuItem *item = MenuItemAtIndex( menuID, itemID );
    if ( item ) return [item badge];
    return nil;
}

void MenuItemSetBadge( NSInteger menuID, NSInteger itemID, NSMenuItemBadge *badge )
{
    NSMenuItem *item = MenuItemAtIndex( menuID, itemID );
    if ( item ) [item setBadge:badge];
}
#endif// 140000

// Type properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150200
CFArrayRef MenuItemWritingToolsItems( void )
{ return (__bridge CFArrayRef)[NSMenuItem writingToolsItems]; }
#endif// 150200


// Custom
void MenuItemSetOnMenuAction( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenu *mainMenu = [NSApp mainMenu];
    if ( !mainMenu ) CUI_BuildMinimalMenu();
    
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) {
        [item setTarget:CUI_MenuItemTargetObj()];
        [item setAction:@selector(menuItemAction:)];
    }
}

void MenuItemSetActionCallback( NSInteger menuIndex, NSInteger itemIndex, CUI_MenuItemCallbackType callback, void *userData )
{
    if ( itemIndex < 0 ) {
        NSMenu *menu = MenuAtIndex( menuIndex );
        NSArray *items = [menu itemArray];
        for ( NSMenuItem *item in items ) {
            [item setTarget:CUI_MenuItemTargetObj()];
            [item setAction:@selector(menuItemAction:)];
            [item setCuiMenuItemCallback:callback];
            [item setCuiMenuItemUserData:userData];
        }
    } else {
        NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
        if ( item ) {
            [item setTarget:CUI_MenuItemTargetObj()];
            [item setAction:@selector(menuItemAction:)];
            [item setCuiMenuItemCallback:callback];
            [item setCuiMenuItemUserData:userData];
        }
    }
}

CFTypeRef MenuItemProperty( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return ObjectProperty( (__bridge CFTypeRef)item, key );
    return nil;
}

void MenuItemSetProperty( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key, CFTypeRef value )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) ObjectSetProperty( (__bridge CFTypeRef)item, key, value );
}

void MenuItemPropertySet( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key, CFTypeRef value )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) ObjectPropertySet( (__bridge CFTypeRef)item, key, value );
}


BOOL MenuItemPropertyBool( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return ObjectPropertyBool( (__bridge CFTypeRef)item, key );
    return NO;
}

void MenuItemPropertySetBool( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key, BOOL value )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) ObjectPropertySetBool( (__bridge CFTypeRef)item, key, value );
}

long MenuItemPropertyLong( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return ObjectPropertyLong( (__bridge CFTypeRef)item, key );
    return 0;
}

void MenuItemPropertySetLong( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key, long value )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) ObjectPropertySetLong( (__bridge CFTypeRef)item, key, value );
}

double MenuItemPropertyDouble( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return ObjectPropertyDouble( (__bridge CFTypeRef)item, key );
    return 0.0;
}

void MenuItemPropertySetDouble( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key, double value )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) ObjectPropertySetDouble( (__bridge CFTypeRef)item, key, value );
}

CGRect MenuItemPropertyRect( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return ObjectPropertyRect( (__bridge CFTypeRef)item, key );
    return CGRectZero;
}

void MenuItemPropertySetRect( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key, CGRect r )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) ObjectPropertySetRect( (__bridge CFTypeRef)item, key, r );
}

CGPoint MenuItemPropertyPoint( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return ObjectPropertyPoint( (__bridge CFTypeRef)item, key );
    return CGPointZero;
}

void MenuItemPropertySetPoint( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key, CGPoint pt )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) ObjectPropertySetPoint( (__bridge CFTypeRef)item, key, pt );
}

CGSize MenuItemPropertySize( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return ObjectPropertySize( (__bridge CFTypeRef)item, key );
    return CGSizeZero;
}

void MenuItemPropertySetSize( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key, CGSize sz )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) ObjectPropertySetSize( (__bridge CFTypeRef)item, key, sz );
}

CFRange MenuItemPropertyRange( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return ObjectPropertyRange( (__bridge CFTypeRef)item, key );
    return CFRangeMake(NSNotFound,0);
}

void MenuItemPropertySetRange( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key, CFRange range )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) ObjectPropertySetRange( (__bridge CFTypeRef)item, key, range );
}

CFURLRef MenuItemPropertyBookmarkURL( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return ObjectPropertyBookmarkURL( (__bridge CFTypeRef)item, key );
    return nil;
}

void MenuItemPropertySetBookmarkURL( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key, CFURLRef url )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) ObjectPropertySetBookmarkURL( (__bridge CFTypeRef)item, key, url );
}

BOOL MenuItemPropertyGetBytes( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key, void *bytes )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) return ObjectPropertyGetBytes( (__bridge CFTypeRef)item, key, bytes );
    return NO;
}

void MenuItemPropertySetBytes( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key, void *bytes, long length )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) ObjectPropertySetBytes( (__bridge CFTypeRef)item, key, bytes, length );
}


void MenuItemRemoveProperty( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) ObjectRemoveProperty( (__bridge CFTypeRef)item, key );
}

void MenuItemPropertyRemove( NSInteger menuIndex, NSInteger itemIndex, CFStringRef key )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) ObjectPropertyRemove( (__bridge CFTypeRef)item, key );
}

void MenuItemRemoveAllProperties( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) ObjectRemoveAllProperties( (__bridge CFTypeRef)item );
}

void MenuItemPropertyRemoveAll( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenuItem *item = MenuItemAtIndex( menuIndex, itemIndex );
    if ( item ) ObjectPropertyRemoveAll( (__bridge CFTypeRef)item );
}

