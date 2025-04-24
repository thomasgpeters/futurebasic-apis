/*
 StatusBar.m

 Bernie Wylde
 */

#import "StatusBar.h"

// Class
Class StatusBarClass( void )
{ return [NSStatusBar class]; }

// - system-wide instance
NSStatusBar *StatusBarSystem( void )
{ return [NSStatusBar systemStatusBar]; }

// - status items -
NSStatusItem *StatusBarStatusItem( NSStatusBar *ref, CGFloat length )
{ return [ref statusItemWithLength:length]; }

void StatusBarRemoveStatusItem( NSStatusBar *ref, NSStatusItem *item )
{ [ref removeStatusItem:item]; }

// - attributes -
BOOL StatusBarIsVertical( NSStatusBar *ref )
{ return [ref isVertical]; }

CGFloat StatusBarThickness( NSStatusBar *ref )
{ return [ref thickness]; }

