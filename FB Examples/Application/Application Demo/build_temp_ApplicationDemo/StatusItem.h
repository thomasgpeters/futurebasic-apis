/*
 StatusItem.h

 Bernie Wylde
 */

#import "CocoaUI.h"
#import "StatusBarButton.h"

// Class
Class StatusItemClass( void );

// - status bar -
NSStatusBar *StatusItemStatusBar( NSStatusItem *ref );

// - behavior -
NSStatusBarButton *StatusItemButton( NSStatusItem *ref );
NSMenu *StatusItemMenu( NSStatusItem *ref );
void StatusItemSetMenu( NSStatusItem *ref, NSInteger menuIndex );

// - appearance -
CGFloat StatusItemLength( NSStatusItem *ref );
void StatusItemSetLength( NSStatusItem *ref, CGFloat length );

// - instance properties -
CFStringRef StatusItemAutosaveName( NSStatusItem *ref );
void StatusItemSetAutosaveName( NSStatusItem *ref, CFStringRef name );
NSStatusItemBehavior StatusItemBehavior( NSStatusItem *ref );
void StatusItemSetBehavior( NSStatusItem *ref, NSStatusItemBehavior behavior );
BOOL StatusItemIsVisible( NSStatusItem *ref );
void StatusItemSetVisible( NSStatusItem *ref, BOOL flag );

// - convenience -
void StatusItemButtonSetImage( NSStatusItem *ref, NSImage *image );
BOOL StatusItemButtonAppearsDisabled( NSStatusItem *ref );
void StatusItemButtonSetAppearsDisabled( NSStatusItem *ref, BOOL flag );
void StatusItemButtonSetActionCallback( NSStatusItem *ref, CUI_StatusBarButtonCallbackType callback, void *userData );

