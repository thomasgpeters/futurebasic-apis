/*
 ScrollView.m

 Bernie Wylde
 */

#import "ScrollView.h"

#pragma mark - subclass
@implementation ScrollViewSC

- (void)drawRect:(NSRect)dirtyRect {
    CUI_ViewSubclassDrawRect( self, dirtyRect );
    if ( !DialogEventBool() ) [super drawRect:dirtyRect];
}

- (void)scrollWheel:(NSEvent *)theEvent {
    if ( !self.scrollingDisabled ) {
        [super scrollWheel:theEvent];
    }
}

- (void)resetCursorRects {
    CUI_ViewSubclassResetCursorRects( self );
}

//- (void)updateTrackingAreas {
//    CUI_ViewSubclassUpdateTrackingAreas( self );
//    [super updateTrackingAreas];
//}

- (BOOL)wantsUpdateLayer {
    return CUI_ViewSubclassWantsUpdateLayer( self );
}

- (void)updateLayer {
    CUI_ViewSubclassUpdateLayer( self );
}

- (void)awakeFromNib {
    [super awakeFromNib];
    CUI_ViewSubclassAwakeFromNib(self);
}

#pragma mark - menu
- (NSMenu *)menuForEvent:(NSEvent*)theEvent {
    CUI_ViewSubclassMenuForEvent( self, theEvent );
    return DialogEventNSMenu();
}
@end


@implementation NSScrollView (Additions)
@dynamic tagNumber;

- (NSInteger)tag {
    return [objc_getAssociatedObject(self, @selector(tagNumber)) integerValue];
}

- (void)setTag:(NSInteger)tag {
    objc_setAssociatedObject(self, @selector(tagNumber), [NSNumber numberWithInteger:tag], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

// Class
Class ScrollViewClass( void )
{ return [NSScrollView class]; }

NSScrollView *ScrollViewWithTag( NSInteger tag )
{ return (NSScrollView *)CUI_ValidateViewKindOfClass( tag, [NSScrollView class] ); }

BOOL ScrollViewExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSScrollView class] ); }

// Calculating layout
CGSize ScrollViewFrameSizeForContentSize( CGSize contentSize, Class horizScrollerClass, Class vertScrollerClass, NSBorderType borderType, NSControlSize controlSize, NSScrollerStyle scrollerStyle )
{ return NSSizeToCGSize([NSScrollView frameSizeForContentSize:NSSizeFromCGSize(contentSize) horizontalScrollerClass:horizScrollerClass verticalScrollerClass:vertScrollerClass borderType:borderType controlSize:controlSize scrollerStyle:scrollerStyle]); }

CGSize ScrollViewContentSizeForFrameSize( CGSize frameSize, Class horizScrollerClass, Class vertScrollerClass, NSBorderType borderType, NSControlSize controlSize, NSScrollerStyle scrollerStyle )
{ return NSSizeToCGSize([NSScrollView contentSizeForFrameSize:NSSizeFromCGSize(frameSize) horizontalScrollerClass:horizScrollerClass verticalScrollerClass:vertScrollerClass borderType:borderType controlSize:controlSize scrollerStyle:scrollerStyle]); }

NSScroller *ScrollViewHorizontalScroller( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView horizontalScroller];
    return nil;
}

BOOL ScrollViewHasHorizontalScroller( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView hasHorizontalScroller];
    return NO;
}

void ScrollViewSetHasHorizontalScroller( NSInteger tag, BOOL flag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) {
        [scrollView setHasHorizontalScroller:flag];
    }
}

NSScroller *ScrollViewVerticalScroller( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView verticalScroller];
    return nil;
}

BOOL ScrollViewHasVerticalScroller( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView hasVerticalScroller];
    return NO;
}

void ScrollViewSetHasVerticalScroller( NSInteger tag, BOOL flag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) {
        [scrollView setHasVerticalScroller:flag];
    }
}

BOOL ScrollViewAutohidesScrollers( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView autohidesScrollers];
    return NO;
}

void ScrollViewSetAutohidesScrollers( NSInteger tag, BOOL flag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) {
        [scrollView setAutohidesScrollers:flag];
    }
}

void ScrollViewFlashScrollers( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) {
        [scrollView flashScrollers];
    }
}

NSClipView *ScrollViewContentView( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView contentView];
    return nil;
}
void ScrollViewSetContentView( NSInteger tag, NSClipView *clip )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setContentView:clip];
}

NSView *ScrollViewDocumentView( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView documentView];
    return nil;
}

void ScrollViewSetDocumentView( NSInteger scrollTag, NSInteger docTag )
{
    NSScrollView *scrollView = ScrollViewWithTag( scrollTag );
    if ( scrollView ) {
        NSView *docView = CUI_ViewWithTag( docTag );
        if ( docView ) [scrollView setDocumentView:docView];
    }
}

void ScrollViewAddFloatingSubview( NSInteger scrollTag, NSInteger subviewTag, NSEventGestureAxis axis )
{
    NSScrollView *scrollView = ScrollViewWithTag( scrollTag );
    if ( scrollView ) {
        NSView *subview = ViewWithTag( subviewTag );
        if ( subview ) [scrollView addFloatingSubview:subview forAxis:axis];
    }
}

Class ScrollViewRulerViewClass( void )
{ return [NSScrollView rulerViewClass]; }

CGSize ScrollViewContentSize( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return NSSizeToCGSize([scrollView contentSize]);
    return CGSizeZero;
}

CGRect ScrollViewDocumentVisibleRect( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return NSRectToCGRect([scrollView documentVisibleRect]);
    return CGRectZero;
}

NSColor *ScrollViewBackgroundColor( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView backgroundColor];
    return NULL;
}

void ScrollViewSetBackgroundColor( NSInteger tag, NSColor *col )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setBackgroundColor:col];
}

BOOL ScrollViewDrawsBackground( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView drawsBackground];
    return NO;
}

void ScrollViewSetDrawsBackground( NSInteger tag, BOOL flag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setDrawsBackground:flag];
}

NSBorderType ScrollViewBorderType( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView borderType];
    return 0;
}

void ScrollViewSetBorderType( NSInteger tag, NSBorderType type )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setBorderType:type];
}

NSCursor *ScrollViewDocumentCursor( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView documentCursor];
    return NULL;
}

void ScrollViewSetDocumentCursor( NSInteger tag, NSCursor *ref )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setDocumentCursor:ref];
}

BOOL ScrollViewHasHorizontalRuler( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView hasHorizontalRuler];
    return NO;
}

void ScrollViewSetHasHorizontalRuler( NSInteger tag, BOOL flag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setHasHorizontalRuler:flag];
}

NSRulerView *ScrollViewHorizontalRulerView( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView horizontalRulerView];
    return nil;
}

void ScrollViewSetHorizontalRulerView( NSInteger tag, NSRulerView *ruler )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setHorizontalRulerView:ruler];
}

BOOL ScrollViewHasVerticalRuler( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView hasVerticalRuler];
    return NO;
}

void ScrollViewSetHasVerticalRuler( NSInteger tag, BOOL flag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setHasVerticalRuler:flag];
}

NSRulerView *ScrollViewVerticalRulerView( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView verticalRulerView];
    return nil;
}

void ScrollViewSetVerticalRulerView( NSInteger tag, NSRulerView *ruler )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setVerticalRulerView:ruler];
}

BOOL ScrollViewRulersVisible( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView rulersVisible];
    return NO;
}

void ScrollViewSetRulersVisible( NSInteger tag, BOOL flag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setRulersVisible:flag];
}

// Insets
BOOL ScrollViewAutomaticallyAdjustsContentInsets( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView automaticallyAdjustsContentInsets];
    return NO;
}

void ScrollViewSetAutomaticallyAdjustsContentInsets( NSInteger tag, BOOL flag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setAutomaticallyAdjustsContentInsets:flag];
}

NSEdgeInsets ScrollViewContentInsets( NSInteger tag )
{
    NSEdgeInsets insets = {0,0,0,0};
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView contentInsets];
    return insets;
}

void ScrollViewSetContentInsets( NSInteger tag, NSEdgeInsets insets )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setContentInsets:insets];
}

NSEdgeInsets ScrollViewScrollerInsets( NSInteger tag )
{
    NSEdgeInsets insets = {0,0,0,0};
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView scrollerInsets];
    return insets;
}

void ScrollViewSetScrollerInsets( NSInteger tag, NSEdgeInsets insets )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setScrollerInsets:insets];
}

// Style
NSScrollerKnobStyle ScrollViewScrollerKnobStyle( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView scrollerKnobStyle];
    return 0;
}

void ScrollViewSetScrollerKnobStyle( NSInteger tag, NSScrollerKnobStyle style )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setScrollerKnobStyle:style];
}

NSScrollerStyle ScrollViewScrollerStyle( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView scrollerStyle];
    return 0;
}

void ScrollViewSetScrollerStyle( NSInteger tag, NSScrollerStyle style )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setScrollerStyle:style];
}

CGFloat ScrollViewLineScroll( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView lineScroll];
    return 0.0;
}

void ScrollViewSetLineScroll( NSInteger tag, CGFloat value )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setLineScroll:value];
}

CGFloat ScrollViewHorizontalLineScroll( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView horizontalLineScroll];
    return 0.0;
}

void ScrollViewSetHorizontalLineScroll( NSInteger tag, CGFloat value )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setHorizontalLineScroll:value];
}

CGFloat ScrollViewVerticalLineScroll( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView verticalLineScroll];
    return 0.0;
}

void ScrollViewSetVerticalLineScroll( NSInteger tag, CGFloat value )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setVerticalLineScroll:value];
}

CGFloat ScrollViewPageScroll( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView pageScroll];
    return 0.0;
}

void ScrollViewSetPageScroll( NSInteger tag, CGFloat value )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setPageScroll:value];
}

CGFloat ScrollViewHorizontalPageScroll( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView horizontalPageScroll];
    return 0.0;
}

void ScrollViewSetHorizontalPageScroll( NSInteger tag, CGFloat value )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setHorizontalPageScroll:value];
}

CGFloat ScrollViewVerticalPageScroll( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView verticalPageScroll];
    return 0.0;
}

void ScrollViewSetVerticalPageScroll( NSInteger tag, CGFloat value )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setVerticalPageScroll:value];
}

BOOL ScrollViewScrollsDynamically( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView scrollsDynamically];
    return NO;
}

void ScrollViewScrollWheel( NSInteger tag, NSEvent *evnt )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView scrollWheel:evnt];
}

void ScrollViewSetScrollsDynamically( NSInteger tag, BOOL flag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setScrollsDynamically:flag];
}

NSScrollViewFindBarPosition ScrollViewFindBarPosition( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView findBarPosition];
    return 0;
}

void ScrollViewSetFindBarPosition( NSInteger tag, NSScrollViewFindBarPosition position )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setFindBarPosition:position];
}

// Predominant behavior
BOOL ScrollViewUsesPredominantAxisScrolling( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView usesPredominantAxisScrolling];
    return NO;
}

void ScrollViewSetUsesPredominantAxisScrolling( NSInteger tag, BOOL flag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setUsesPredominantAxisScrolling:flag];
}

// Elasticity -
NSInteger ScrollViewHorizontalScrollElasticity( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView horizontalScrollElasticity];
    return 0;
}

void ScrollViewSetHorizontalScrollElasticity( NSInteger tag, NSInteger elasticity )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setHorizontalScrollElasticity:elasticity];
}

NSInteger ScrollViewVerticalScrollElasticity( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView verticalScrollElasticity];
    return 0;
}

void ScrollViewSetVerticalScrollElasticity( NSInteger tag, NSInteger elasticity )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setVerticalScrollElasticity:elasticity];
}


void ScrollViewReflectScrolledClipView( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView reflectScrolledClipView:[scrollView contentView]];
}

BOOL ScrollViewAllowsMagnification( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView allowsMagnification];
    return NO;
}

void ScrollViewSetAllowsMagnification( NSInteger tag, BOOL flag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setAllowsMagnification:flag];
}

CGFloat ScrollViewMagnification( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView magnification];
    return 0.0;
}

void ScrollViewSetMagnification( NSInteger tag, CGFloat value )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setMagnification:value];
}

void ScrollViewMagnifyToFitRect( NSInteger tag, CGRect r )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView magnifyToFitRect:NSRectFromCGRect(r)];
}

CGFloat ScrollViewMaxMagnification( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView maxMagnification];
    return 0.0;
}

void ScrollViewSetMaxMagnification( NSInteger tag, CGFloat value )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setMaxMagnification:value];
}

CGFloat ScrollViewMinMagnification( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) return [scrollView minMagnification];
    return 0.0;
}

void ScrollViewSetMinMagnification( NSInteger tag, CGFloat value )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setMinMagnification:value];
}

void ScrollViewSetMagnificationCenteredAtPoint( NSInteger tag, CGFloat value, CGPoint pt )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [scrollView setMagnification:value centeredAtPoint:NSPointFromCGPoint(pt)];
}

// -- convenience --
void ScrollViewScrollToPoint( NSInteger tag, CGPoint pt )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) [[scrollView contentView] scrollToPoint:NSPointFromCGPoint(pt)];
}

void ScrollViewScrollToTop( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) {
        [scrollView.contentView scrollToPoint:NSMakePoint(0,0)];
    }
}

void ScrollViewScrollToBottom( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) {
        [scrollView.contentView scrollToPoint:NSMakePoint(0, ((NSView*)scrollView.documentView).frame.size.height - scrollView.contentSize.height)];
        
        
    }
}

// Subclass functions
void ScrollViewSetScrollingDisabled( NSInteger tag, BOOL flag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) {
        if ( [scrollView isKindOfClass:[ScrollViewSC class]] ) {
            [(ScrollViewSC *)scrollView setScrollingDisabled:flag];
        }
    }
}

BOOL ScrollViewIsScrollingDisabled( NSInteger tag )
{
    NSScrollView *scrollView = ScrollViewWithTag( tag );
    if ( scrollView ) {
        if ( [scrollView isKindOfClass:[ScrollViewSC class]] ) {
            return [(ScrollViewSC *)scrollView scrollingDisabled];
        }
    }
    return NO;
}


// Init
NSScrollView *ScrollViewInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) rect = NSMakeRect( 20, 20, 240, 135 );

    // subclass
    BOOL subclass = CUI_IsSubclassFlag();

    // init
    NSScrollView *view;
#if __has_feature(objc_arc)
    if ( subclass ) {
        view = [[ScrollViewSC alloc] initWithFrame:rect];
    } else {
        view = [[NSScrollView alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        view = [[[ScrollViewSC alloc] initWithFrame:rect] autorelease];
    } else {
        view = [[[NSScrollView alloc] initWithFrame:rect] autorelease];
    }
#endif
    
//#if !__has_feature(objc_arc)
//    [view autorelease];
//#endif
    
    // vertical scroller
    [view setHasVerticalScroller:YES];

    // tag
    [view setTag:inTag];
    
    return view;
}


// Statement
void CUI_ScrollView( NSInteger inTag, CGRect inRect, NSInteger inBorderType, NSInteger inDocTag, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSScrollView *scrollView = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !scrollView ) {
            scrollView = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( scrollView ) {     // already exists
            
            // clear subclass flag
            CUI_SetSubclassFlag( NO );
            
            // make sure it's correct class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, scrollView, [NSScrollView class] ) ) {
                return;
            }

            // rect
            if ( !NSIsEmptyRect( rect ) ) [scrollView setFrame:rect];
            
            // border type
            if ( inBorderType != kFBParamMissing) [scrollView setBorderType:inBorderType];
            
        } else {            // create
            // init
            scrollView = ScrollViewInit( inTag, inRect );
            
            // border type
            if ( inBorderType != kFBParamMissing) [scrollView setBorderType:inBorderType];
            
            // document view
            if ( inDocTag != 0 ) {
                NSView *docView = CUI_ViewSubviewWithTag( contentView, inDocTag );
                
                if ( !docView ) {
                    docView = TitlebarAccessoryViewWithTag( inTag );
                }
                
                if ( docView ) {
#if !__has_feature(objc_arc)
                    [docView retain];
#endif
                    [docView removeFromSuperview];
                    [scrollView setDocumentView:docView];
#if !__has_feature(objc_arc)
                    [docView release];
#endif
                }
            }
            
            // default autoresizing
            [scrollView setAutoresizingMask:NSViewMinYMargin];
            
            // wndTag
            [scrollView setWndTag:inWndTag];
                        
            // add to window/popover/superview
            id superview = CUI_CurrentSuperview();
            if ( superview ) {
                [superview addSubview:scrollView];
            } else {
                [contentView addSubview:scrollView];
            }

        }
        
        [scrollView setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
}
