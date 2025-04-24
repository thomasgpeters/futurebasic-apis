/*
 SearchToolbarItem.m

 Bernie Wylde
 */

#import "SearchToolbarItem.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000

// Class
Class SearchToolbarItemClass( void )
{ return [NSSearchToolbarItem class]; }

// Configure
BOOL SearchToolbarItemResignsFirstResponderWithCancel( NSSearchToolbarItem *ref )
{ return [ref resignsFirstResponderWithCancel]; }

void SearchToolbarItemSetResignsFirstResponderWithCancel( NSSearchToolbarItem *ref, BOOL flag )
{ [ref setResignsFirstResponderWithCancel:flag]; }

NSSearchField *SearchToolbarItemSearchField( NSSearchToolbarItem *ref )
{ return [ref searchField]; }

void SearchToolbarItemSetSearchField( NSSearchToolbarItem *ref, NSSearchField *searchFld )
{ [ref setSearchField:searchFld]; }

// Instance properties
CGFloat SearchToolbarItemPreferredWidthForSearchField( NSSearchToolbarItem *ref )
{ return [ref preferredWidthForSearchField]; }

void SearchToolbarItemSetPreferredWidthForSearchField( NSSearchToolbarItem *ref, CGFloat width )
{ [ref setPreferredWidthForSearchField:width]; }

// Instance methods
void SearchToolbarItemBeginSearchInteraction( NSSearchToolbarItem *ref )
{ [ref beginSearchInteraction]; }

void SearchToolbarItemEndSearchInteraction( NSSearchToolbarItem *ref )
{ [ref endSearchInteraction]; }

#endif// 110000
