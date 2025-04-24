/*
 ClipView.m

 Bernie Wylde
 */

#import "ClipView.h"

// Class
Class ClipViewClass( void )
{ return [NSClipView class]; }

// Document view
NSView *ClipViewDocumentView( NSClipView *ref )
{ return [ref documentView]; }

void ClipViewSetDocumentView( NSClipView *ref, NSView *docView )
{ [ref setDocumentView:docView]; }

// Scrolling
void ClipViewScrollToPoint( NSClipView *ref, CGPoint pt )
{ [ref scrollToPoint:NSPointFromCGPoint(pt)]; }

void ClipViewConstrainBoundsRect( NSClipView *ref, CGRect r )
{ [ref constrainBoundsRect:NSRectFromCGRect(r)]; }

// Scrolling efficiency
BOOL ClipViewCopiesOnScroll( NSClipView *ref )
{ return [ref copiesOnScroll]; }

void ClipViewSetCopiesOnScroll( NSClipView *ref, BOOL flag )
{ [ref setCopiesOnScroll:flag]; }

// Content insets
NSEdgeInsets ClipViewContentInsets( NSClipView *ref )
{ return [ref contentInsets]; }

void ClipViewSetContentInsets( NSClipView *ref, NSEdgeInsets insets )
{ [ref setContentInsets:insets]; }

BOOL ClipViewAutomaticallyAdjustsContentInsets( NSClipView *ref )
{ return [ref automaticallyAdjustsContentInsets]; }

void ClipViewSetAutomaticallyAdjustsContentInsets( NSClipView *ref, BOOL flag )
{ [ref setAutomaticallyAdjustsContentInsets:flag]; }

// Visible portion
CGRect ClipViewDocumentRect( NSClipView *ref )
{ return NSRectToCGRect([ref documentRect]); }

CGRect ClipViewDocumentVisibleRect( NSClipView *ref )
{ return NSRectToCGRect([ref documentVisibleRect]); }

// Document cursor
NSCursor *ClipViewDocumentCursor( NSClipView *ref )
{ return [ref documentCursor]; }

void ClipViewSetDocumentCursor( NSClipView *ref, NSCursor *curs )
{ [ref setDocumentCursor:curs]; }

// Background color
BOOL ClipViewDrawsBackground( NSClipView *ref )
{ return [ref drawsBackground]; }

void ClipViewSetDrawsBackground( NSClipView *ref, BOOL flag )
{ [ref setDrawsBackground:flag]; }

NSColor *ClipViewBackgroundColor( NSClipView *ref )
{ return [ref backgroundColor]; }

void ClipViewSetBackgroundColor( NSClipView *ref, NSColor *col )
{ [ref setBackgroundColor:col]; }

void ViewScrollClipViewToPoint( NSInteger tag, NSClipView *clipView, CGPoint pt )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) [view scrollClipView:clipView toPoint:NSPointFromCGPoint(pt)];
}

void ViewReflectScrolledClipView( NSInteger tag, NSClipView *clipView )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) [view reflectScrolledClipView:clipView];
}

// Custom
CGRect ClipViewBounds( NSClipView *ref )
{ return NSRectToCGRect([ref bounds]); }

void ClipViewSetBounds( NSClipView *ref, CGRect r )
{ [ref setBounds:NSRectFromCGRect(r)]; }


