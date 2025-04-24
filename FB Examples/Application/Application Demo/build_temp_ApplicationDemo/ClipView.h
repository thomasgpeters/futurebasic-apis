/*
 ClipView.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class ClipViewClass( void );

// Document view
NSView *ClipViewDocumentView( NSClipView *ref );
void ClipViewSetDocumentView( NSClipView *ref, NSView *docView );

// Scrolling
void ClipViewScrollToPoint( NSClipView *ref, CGPoint pt );
void ClipViewConstrainBoundsRect( NSClipView *ref, CGRect r );

// Scrolling efficiency
BOOL ClipViewCopiesOnScroll( NSClipView *ref );
void ClipViewSetCopiesOnScroll( NSClipView *ref, BOOL flag );

// Content insets
NSEdgeInsets ClipViewContentInsets( NSClipView *ref );
void ClipViewSetContentInsets( NSClipView *ref, NSEdgeInsets insets );
BOOL ClipViewAutomaticallyAdjustsContentInsets( NSClipView *ref );
void ClipViewSetAutomaticallyAdjustsContentInsets( NSClipView *ref, BOOL flag );

// Visible portion
CGRect ClipViewDocumentRect( NSClipView *ref );
CGRect ClipViewDocumentVisibleRect( NSClipView *ref );

// Document cursor
NSCursor *ClipViewDocumentCursor( NSClipView *ref );
void ClipViewSetDocumentCursor( NSClipView *ref, NSCursor *curs );

// Background color
BOOL ClipViewDrawsBackground( NSClipView *ref );
void ClipViewSetDrawsBackground( NSClipView *ref, BOOL flag );
NSColor *ClipViewBackgroundColor( NSClipView *ref );
void ClipViewSetBackgroundColor( NSClipView *ref, NSColor *col );

void ViewScrollClipViewToPoint( NSInteger tag, NSClipView *clipView, CGPoint pt );
void ViewReflectScrolledClipView( NSInteger tag, NSClipView *clipView );

// Custom
CGRect ClipViewBounds( NSClipView *ref );
void ClipViewSetBounds( NSClipView *ref, CGRect r );


