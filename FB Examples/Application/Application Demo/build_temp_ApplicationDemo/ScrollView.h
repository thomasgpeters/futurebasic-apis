/*
 ScrollView.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "View.h"
//#import "Window.h"

@interface ScrollViewSC : NSScrollView
@property (nonatomic,assign) BOOL scrollingDisabled;
@end

@interface NSScrollView (Additions)
@property (nonatomic,retain) NSNumber *tagNumber;

- (NSInteger)tag;
- (void)setTag:(NSInteger)tag;
@end

// Class
Class ScrollViewClass( void );

NSScrollView *ScrollViewWithTag( NSInteger tag );
BOOL ScrollViewExists( NSInteger tag );

// Calculating layout
CGSize ScrollViewFrameSizeForContentSize( CGSize contentSize, Class horizScrollerClass, Class vertScrollerClass, NSBorderType borderType, NSControlSize controlSize, NSScrollerStyle scrollerStyle );
CGSize ScrollViewContentSizeForFrameSize( CGSize frameSize, Class horizScrollerClass, Class vertScrollerClass, NSBorderType borderType, NSControlSize controlSize, NSScrollerStyle scrollerStyle );

NSScroller *ScrollViewHorizontalScroller( NSInteger tag );
BOOL ScrollViewHasHorizontalScroller( NSInteger tag );
void ScrollViewSetHasHorizontalScroller( NSInteger tag, BOOL flag );
NSScroller *ScrollViewVerticalScroller( NSInteger tag );
BOOL ScrollViewHasVerticalScroller( NSInteger tag );
void ScrollViewSetHasVerticalScroller( NSInteger tag, BOOL flag );
BOOL ScrollViewAutohidesScrollers( NSInteger tag );
void ScrollViewSetAutohidesScrollers( NSInteger tag, BOOL flag );
void ScrollViewFlashScrollers( NSInteger tag );
NSClipView *ScrollViewContentView( NSInteger tag );
void ScrollViewSetContentView( NSInteger tag, NSClipView *clip );
NSView *ScrollViewDocumentView( NSInteger tag );
void ScrollViewSetDocumentView( NSInteger scrollTag, NSInteger docTag );
CGSize ScrollViewContentSize( NSInteger tag );
CGRect ScrollViewDocumentVisibleRect( NSInteger tag );
NSColor *ScrollViewBackgroundColor( NSInteger tag );
void ScrollViewSetBackgroundColor( NSInteger tag, NSColor *col );
BOOL ScrollViewDrawsBackground( NSInteger tag );
void ScrollViewSetDrawsBackground( NSInteger tag, BOOL flag );
NSBorderType ScrollViewBorderType( NSInteger tag );
void ScrollViewSetBorderType( NSInteger tag, NSBorderType type );
NSCursor *ScrollViewDocumentCursor( NSInteger tag );
void ScrollViewSetDocumentCursor( NSInteger tag, NSCursor *ref );

void ScrollViewAddFloatingSubview( NSInteger scrollTag, NSInteger subviewTag, NSEventGestureAxis axis );

Class ScrollViewRulerViewClass( void );

BOOL ScrollViewHasHorizontalRuler( NSInteger tag );
void ScrollViewSetHasHorizontalRuler( NSInteger tag, BOOL flag );

NSRulerView *ScrollViewHorizontalRulerView( NSInteger tag );
void ScrollViewSetHorizontalRulerView( NSInteger tag, NSRulerView *ruler );

BOOL ScrollViewHasVerticalRuler( NSInteger tag );
void ScrollViewSetHasVerticalRuler( NSInteger tag, BOOL flag );

NSRulerView *ScrollViewVerticalRulerView( NSInteger tag );
void ScrollViewSetVerticalRulerView( NSInteger tag, NSRulerView *ruler );

BOOL ScrollViewRulersVisible( NSInteger tag );
void ScrollViewSetRulersVisible( NSInteger tag, BOOL flag );

// Insets
BOOL ScrollViewAutomaticallyAdjustsContentInsets( NSInteger tag );
void ScrollViewSetAutomaticallyAdjustsContentInsets( NSInteger tag, BOOL flag );
NSEdgeInsets ScrollViewContentInsets( NSInteger tag );
void ScrollViewSetContentInsets( NSInteger tag, NSEdgeInsets insets );
NSEdgeInsets ScrollViewScrollerInsets( NSInteger tag );
void ScrollViewSetScrollerInsets( NSInteger tag, NSEdgeInsets insets );

// Style
NSScrollerKnobStyle ScrollViewScrollerKnobStyle( NSInteger tag );
void ScrollViewSetScrollerKnobStyle( NSInteger tag, NSScrollerKnobStyle style );
NSScrollerStyle ScrollViewScrollerStyle( NSInteger tag );
void ScrollViewSetScrollerStyle( NSInteger tag, NSScrollerStyle style );

// Behavior
CGFloat ScrollViewLineScroll( NSInteger tag );
void ScrollViewSetLineScroll( NSInteger tag, CGFloat value );
CGFloat ScrollViewHorizontalLineScroll( NSInteger tag );
void ScrollViewSetHorizontalLineScroll( NSInteger tag, CGFloat value );
CGFloat ScrollViewVerticalLineScroll( NSInteger tag );
void ScrollViewSetVerticalLineScroll( NSInteger tag, CGFloat value );
CGFloat ScrollViewPageScroll( NSInteger tag );
void ScrollViewSetPageScroll( NSInteger tag, CGFloat value );
CGFloat ScrollViewHorizontalPageScroll( NSInteger tag );
void ScrollViewSetHorizontalPageScroll( NSInteger tag, CGFloat value );
CGFloat ScrollViewVerticalPageScroll( NSInteger tag );
void ScrollViewSetVerticalPageScroll( NSInteger tag, CGFloat value );
BOOL ScrollViewScrollsDynamically( NSInteger tag );
void ScrollViewSetScrollsDynamically( NSInteger tag, BOOL flag );
void ScrollViewScrollWheel( NSInteger tag, NSEvent *evnt );


void ScrollViewReflectScrolledClipView( NSInteger tag );

NSScrollViewFindBarPosition ScrollViewFindBarPosition( NSInteger tag );
void ScrollViewSetFindBarPosition( NSInteger tag, NSScrollViewFindBarPosition position );

// Predominant behavior
BOOL ScrollViewUsesPredominantAxisScrolling( NSInteger tag );
void ScrollViewSetUsesPredominantAxisScrolling( NSInteger tag, BOOL flag );

// Elasticity -
NSInteger ScrollViewHorizontalScrollElasticity( NSInteger tag );
void ScrollViewSetHorizontalScrollElasticity( NSInteger tag, NSInteger elasticity );
NSInteger ScrollViewVerticalScrollElasticity( NSInteger tag );
void ScrollViewSetVerticalScrollElasticity( NSInteger tag, NSInteger elasticity );
BOOL ScrollViewAllowsMagnification( NSInteger tag );
void ScrollViewSetAllowsMagnification( NSInteger tag, BOOL flag );
CGFloat ScrollViewMagnification( NSInteger tag );
void ScrollViewSetMagnification( NSInteger tag, CGFloat value );
void ScrollViewMagnifyToFitRect( NSInteger tag, CGRect r );
CGFloat ScrollViewMaxMagnification( NSInteger tag );
void ScrollViewSetMaxMagnification( NSInteger tag, CGFloat value );
CGFloat ScrollViewMinMagnification( NSInteger tag );
void ScrollViewSetMinMagnification( NSInteger tag, CGFloat value );
void ScrollViewSetMagnificationCenteredAtPoint( NSInteger tag, CGFloat value, CGPoint pt );

// -- custom --
void ScrollViewScrollToPoint( NSInteger tag, CGPoint pt );
void ScrollViewScrollToTop( NSInteger tag );
void ScrollViewScrollToBottom( NSInteger tag );

// Subclass functions
void ScrollViewSetScrollingDisabled( NSInteger tag, BOOL flag );
BOOL ScrollViewIsScrollingDisabled( NSInteger tag );


// Init
NSScrollView *ScrollViewInit( NSInteger inTag, CGRect inRect );

// Statement
void CUI_ScrollView( NSInteger inTag, CGRect inRect, NSInteger inBorderType, NSInteger inDocTag, NSInteger inWndTag );

