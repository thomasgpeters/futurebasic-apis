/*
 SearchToolbarItem.h

 Bernie Wylde
 */


#import "CocoaUI.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000

// Class
API_AVAILABLE(macos(11.0))
Class SearchToolbarItemClass( void );

// Configure
API_AVAILABLE(macos(11.0))
BOOL SearchToolbarItemResignsFirstResponderWithCancel( NSSearchToolbarItem *ref );
API_AVAILABLE(macos(11.0))
void SearchToolbarItemSetResignsFirstResponderWithCancel( NSSearchToolbarItem *ref, BOOL flag );
API_AVAILABLE(macos(11.0))
NSSearchField *SearchToolbarItemSearchField( NSSearchToolbarItem *ref );
API_AVAILABLE(macos(11.0))
void SearchToolbarItemSetSearchField( NSSearchToolbarItem *ref, NSSearchField *searchFld );

// Instance properties
API_AVAILABLE(macos(11.0))
CGFloat SearchToolbarItemPreferredWidthForSearchField( NSSearchToolbarItem *ref );
API_AVAILABLE(macos(11.0))
void SearchToolbarItemSetPreferredWidthForSearchField( NSSearchToolbarItem *ref, CGFloat width );

// Instance methods
API_AVAILABLE(macos(11.0))
void SearchToolbarItemBeginSearchInteraction( NSSearchToolbarItem *ref );
API_AVAILABLE(macos(11.0))
void SearchToolbarItemEndSearchInteraction( NSSearchToolbarItem *ref );

#endif// 110000
