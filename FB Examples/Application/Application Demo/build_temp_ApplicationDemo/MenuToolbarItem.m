/*
 MenuToolbarItem.m

 Bernie Wylde
 */

#import "MenuToolbarItem.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500

// Class
Class MenuToolbarItemClass( void )
{ return [NSMenuToolbarItem class]; }

// Instance properties
NSMenu *MenuToolbarItemMenu( NSMenuToolbarItem *ref )
{ return [ref menu]; }

void MenuToolbarItemSetMenu( NSMenuToolbarItem *ref, NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) [ref setMenu:menu];
}

BOOL MenuToolbarItemShowsIndicator( NSMenuToolbarItem *ref )
{ return [ref showsIndicator]; }

void MenuToolbarItemSetShowsIndicator( NSMenuToolbarItem *ref, BOOL flag )
{ [ref setShowsIndicator:flag]; }

#endif// 101500
