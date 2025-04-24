
/*
 TabViewItem.m

 Bernie Wylde
 */

#import "TabViewItem.h"

// Class
Class TabViewItemClass( void )
{ return [NSTabViewItem class]; }

// Create
NSTabViewItem *TabViewItemWithIdentifier( CFTypeRef identifier )
{
#if __has_feature(objc_arc)
    return [[NSTabViewItem alloc] initWithIdentifier:(__bridge id)identifier];
#else
    return [[[NSTabViewItem alloc] initWithIdentifier:(__bridge id)identifier] autorelease];
#endif
}

// Labels
void TabViewItemDrawLabel( NSTabViewItem *ref, BOOL shouldTruncateLabel, CGRect inRect )
{ [ref drawLabel:shouldTruncateLabel inRect:NSRectFromCGRect(inRect)]; }

CFStringRef TabViewItemLabel( NSTabViewItem *ref )
{ return (__bridge CFStringRef)[ref label]; }

void TabViewItemSetLabel( NSTabViewItem *ref, CFStringRef label )
{ [ref setLabel:(__bridge NSString *)label]; }

CGSize TabViewItemSizeOfLabel( NSTabViewItem *ref, BOOL computeMin )
{ return NSSizeToCGSize([ref sizeOfLabel:computeMin]); }

// Display state
NSTabState TabViewItemTabState( NSTabViewItem *ref )
{ return [ref tabState]; }

// Identifier
CFTypeRef TabViewItemIdentifier( NSTabViewItem *ref )
{ return (__bridge CFTypeRef)[ref identifier]; }

void TabViewItemSetIdentifier( NSTabViewItem *ref, CFTypeRef identifier )
{ [ref setIdentifier:(__bridge id)identifier]; }

// Color
NSColor *TabViewItemColor( NSTabViewItem *ref )
{ return [ref color]; }

void TabViewItemSetColor( NSTabViewItem *ref, NSColor *col )
{ [ref setColor:col]; }

// View
NSView *TabViewItemView( NSTabViewItem *ref )
{ return [ref view]; }

void TabViewItemSetView( NSTabViewItem *ref, NSView *aView )
{ [ref setView:aView]; }

// Initial first responder
NSView *TabViewItemInitialFirstResponder( NSTabViewItem *ref )
{ return [ref initialFirstResponder]; }

void TabViewItemSetInitialFirstResponder( NSTabViewItem *ref, NSView *aView )
{ [ref setInitialFirstResponder:aView]; }

// View
NSTabView *TabViewItemTabView( NSTabViewItem *ref )
{ return [ref tabView]; }

NSInteger TabViewItemTabViewTag( NSTabViewItem *ref )
{
    NSTabView *tabView = [ref tabView];
    if ( tabView) return [tabView tag];
    return 0;
}

// ToolTip
CFStringRef TabViewItemToolTip( NSTabViewItem *ref )
{ return (__bridge CFStringRef)[ref toolTip]; }

void TabViewItemSetToolTip( NSTabViewItem *ref, CFStringRef toolTip )
{ [ref setToolTip:(__bridge NSString *)toolTip]; }

// Initializers
NSTabViewItem *TabViewItemWithViewController( NSViewController *viewController )
{ return [NSTabViewItem tabViewItemWithViewController:viewController]; }

// Instance properties
NSImage *TabViewItemImage( NSTabViewItem *ref )
{ return [ref image]; }

void TabViewItemSetImage( NSTabViewItem *ref, NSImage *image )
{ [ref setImage:image]; }

NSViewController *TabViewItemViewController( NSTabViewItem *ref )
{ return [ref viewController]; }

void TabViewItemSetViewController( NSTabViewItem *ref, NSViewController *viewController )
{ [ref setViewController:viewController]; }
