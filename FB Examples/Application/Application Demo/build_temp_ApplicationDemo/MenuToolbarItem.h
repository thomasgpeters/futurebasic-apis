/*
 MenuToolbarItem.h

 Bernie Wylde
 */



#import "Menu.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500

// Class
API_AVAILABLE(macos(10.15))
Class MenuToolbarItemClass( void );

// Instance properties
API_AVAILABLE(macos(10.15))
NSMenu *MenuToolbarItemMenu( NSMenuToolbarItem *ref );
API_AVAILABLE(macos(10.15))
void MenuToolbarItemSetMenu( NSMenuToolbarItem *ref, NSInteger menuIndex );
API_AVAILABLE(macos(10.15))
BOOL MenuToolbarItemShowsIndicator( NSMenuToolbarItem *ref );
API_AVAILABLE(macos(10.15))
void MenuToolbarItemSetShowsIndicator( NSMenuToolbarItem *ref, BOOL flag );

#endif// 101500
