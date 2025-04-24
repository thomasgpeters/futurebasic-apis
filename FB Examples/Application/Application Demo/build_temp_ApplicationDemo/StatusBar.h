/*
 StatusBar.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class StatusBarClass( void );

// - system-wide instance
NSStatusBar *StatusBarSystem( void );

// - status items -
NSStatusItem *StatusBarStatusItem( NSStatusBar *ref, CGFloat length );
void StatusBarRemoveStatusItem( NSStatusBar *ref, NSStatusItem *item );

// - attributes -
BOOL StatusBarIsVertical( NSStatusBar *ref );
CGFloat StatusBarThickness( NSStatusBar *ref );

