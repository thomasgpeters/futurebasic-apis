/*
 SearchField.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "Control.h"
//#import "DialogEvent.h"
//#import "Menu.h"
//#import "View.h"
//#import "Window.h"

@interface SearchFieldSC : NSSearchField
@end

// dialog events
enum {
    searchFieldDidStartSearching = 1400,
    searchFieldDidEndSearching
};


@interface CUI_SearchFieldDelegate : NSObject <NSSearchFieldDelegate>
@end

//@interface CUI_SearchFieldDelegate : NSObject <NSTextFieldDelegate>
//@end

CUI_SearchFieldDelegate *CUI_SearchFieldDelegateObj( void );

// Class
Class SearchFieldClass( void );

NSSearchField *SearchFieldWithTag( NSInteger tag );
BOOL SearchFieldExists( NSInteger tag );

BOOL SearchFieldSendsSearchStringImmediately( NSInteger tag );
void SearchFieldSetSendsSearchStringImmediately( NSInteger tag, BOOL flag );
BOOL SearchFieldSendsWholeSearchString( NSInteger tag );
void SearchFieldSetSendsWholeSearchString( NSInteger tag, BOOL flag );

CFArrayRef SearchFieldRecentSearches( NSInteger tag );

BOOL SearchFieldCentersPlaceholder( NSInteger tag );
void SearchFieldSetCentersPlaceholder( NSInteger tag, BOOL flag );

NSInteger SearchFieldMaximumRecents( NSInteger tag );
void SearchFieldSetMaximumRecents( NSInteger tag, NSInteger value );

CFStringRef SearchFieldRecentsAutosaveName( NSInteger tag );
void SearchFieldSetRecentsAutosaveName( NSInteger tag, CFStringRef name );

NSInteger SearchFieldSearchMenuTemplate( NSInteger tag );
void SearchFieldSetSearchMenuTemplate( NSInteger tag, NSInteger menuIndex );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
CGRect SearchFieldSearchTextBounds( NSInteger tag );
API_AVAILABLE(macos(11.0))
CGRect SearchFieldSearchButtonBounds( NSInteger tag );
API_AVAILABLE(macos(11.0))
CGRect SearchFieldCancelButtonBounds( NSInteger tag );
#endif// 110000

// Convenience
void SearchFieldSetSearchButtonImage( NSInteger tag, NSImage *image );
void SearchFieldSetCancelButtonImage( NSInteger tag, NSImage *image );



// Init
NSSearchField *SearchFieldInit( NSInteger inTag, CGRect inRect );

// Statement
void CUI_SearchField( NSInteger inTag, NSInteger inEnabled, CFStringRef inText, CGRect inRect, NSInteger inWndTag );
