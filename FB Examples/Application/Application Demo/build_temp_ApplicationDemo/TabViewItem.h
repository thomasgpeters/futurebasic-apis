/*
 TabViewItem.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class TabViewItemClass( void );

// Create
NSTabViewItem *TabViewItemWithIdentifier( CFTypeRef identifier );

// Labels
void TabViewItemDrawLabel( NSTabViewItem *ref, BOOL shouldTruncateLabel, CGRect inRect );
CFStringRef TabViewItemLabel( NSTabViewItem *ref );
void TabViewItemSetLabel( NSTabViewItem *ref, CFStringRef label );
CGSize TabViewItemSizeOfLabel( NSTabViewItem *ref, BOOL computeMin );

// Display state
NSTabState TabViewItemTabState( NSTabViewItem *ref );

// Identifier
CFTypeRef TabViewItemIdentifier( NSTabViewItem *ref );
void TabViewItemSetIdentifier( NSTabViewItem *ref, CFTypeRef identifier );

// Color
NSColor *TabViewItemColor( NSTabViewItem *ref );
void TabViewItemSetColor( NSTabViewItem *ref, NSColor *col );

// View
NSView *TabViewItemView( NSTabViewItem *ref );
void TabViewItemSetView( NSTabViewItem *ref, NSView *aView );

// Initial first responder
NSView *TabViewItemInitialFirstResponder( NSTabViewItem *ref );
void TabViewItemSetInitialFirstResponder( NSTabViewItem *ref, NSView *aView );

// View
NSTabView *TabViewItemTabView( NSTabViewItem *ref );
NSInteger TabViewItemTabViewTag( NSTabViewItem *ref );

// ToolTip
CFStringRef TabViewItemToolTip( NSTabViewItem *ref );
void TabViewItemSetToolTip( NSTabViewItem *ref, CFStringRef toolTip );

// Initializers
NSTabViewItem *TabViewItemWithViewController( NSViewController *viewController );

// Instance properties
NSImage *TabViewItemImage( NSTabViewItem *ref );
void TabViewItemSetImage( NSTabViewItem *ref, NSImage *image );
NSViewController *TabViewItemViewController( NSTabViewItem *ref );
void TabViewItemSetViewController( NSTabViewItem *ref, NSViewController *viewController );
