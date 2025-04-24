/*
 SplitView.m

 Bernie Wylde
 */

#import "SplitView.h"

@implementation SplitViewSC
//- (void)drawRect:(NSRect)dirtyRect {
//    CUI_ViewSubclassDrawRect( self, dirtyRect );
//    if ( !DialogEventBool() ) [super drawRect:dirtyRect];
//}

- (NSColor *)dividerColor {
    DialogEventSetColor( [NSColor clearColor] );
    CUI_OutputWindowSetTag( [self wndTag] );
    CallUserDefinedOnDialogFunction( splitViewDividerColor, [self tag], [self wndTag], (__bridge CFTypeRef)self );
    return DialogEventColor();
}

- (CGFloat)dividerThickness {
    CGFloat thickness;
    switch ( [self dividerStyle] ) {
        case NSSplitViewDividerStyleThin:
            thickness = 1.0;
            break;
        case NSSplitViewDividerStyleThick:
            thickness = 9.0;
            break;
        case NSSplitViewDividerStylePaneSplitter:
        default:
            thickness = 10.0;
            break;
    }
    DialogEventSetDouble( thickness );
    CUI_OutputWindowSetTag( [self wndTag] );
    CallUserDefinedOnDialogFunction( splitViewDividerThickness, [self tag], [self wndTag], (__bridge CFTypeRef)self );
    return DialogEventDouble();
}

- (void)drawDividerInRect:(NSRect)rect {
    DialogEventSetBool(NO);
    CUI_OutputWindowSetTag( [self wndTag] );
    DialogEventSetNSRect( rect );
    CallUserDefinedOnDialogFunction( splitViewDrawDividerInRect, [self tag], [self wndTag], (__bridge CFTypeRef)self );
    if ( !DialogEventBool() ) [super drawDividerInRect:rect];
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

@implementation NSSplitView (Additions)
@dynamic tagNumber;

- (NSInteger)tag {
    return [objc_getAssociatedObject(self, @selector(tagNumber)) integerValue];
}

- (void)setTag:(NSInteger)tag {
    objc_setAssociatedObject(self, @selector(tagNumber), [NSNumber numberWithInteger:tag], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

@implementation CUI_SplitViewDelegate

//- (void)splitView:(NSSplitView *)splitView resizeSubviewsWithOldSize:(NSSize)oldSize {
//    DialogEventSetNSSize( oldSize );
////    CUI_OutputWindowSetTag( [splitView wndTag] );
//    CUI_OutputWindowSetTag( [[splitView window] tag] );
//    CallUserDefinedOnDialogFunction( splitViewResizeSubviewsWithOldSize, [splitView tag], [[splitView window] tag], NULL );
//}

- (void)splitViewWillResizeSubviews:(NSNotification *)notification {
    CUI_OutputWindowSetTag( [notification.object wndTag] );
    CallUserDefinedOnDialogFunction( splitViewWillResizeSubviews, [notification.object tag], [notification.object wndTag], (__bridge CFTypeRef)notification.object );
}

- (void)splitViewDidResizeSubviews:(NSNotification *)notification {
    CUI_OutputWindowSetTag( [notification.object wndTag] );
    CallUserDefinedOnDialogFunction( splitViewDidResizeSubviews, [notification.object tag], [notification.object wndTag], (__bridge CFTypeRef)notification.object );
}

- (BOOL)splitView:(NSSplitView *)splitView canCollapseSubview:(NSView *)subview {
    DialogEventSetBool( NO );
    DialogEventSetLong( [[splitView subviews] indexOfObject:subview] );
    CUI_OutputWindowSetTag( [splitView wndTag] );
    CallUserDefinedOnDialogFunction( splitViewCanCollapseSubview, [splitView tag], [splitView wndTag], (__bridge CFTypeRef)splitView );
    return DialogEventBool();
}

- (BOOL)splitView:(NSSplitView *)splitView shouldAdjustSizeOfSubview:(NSView *)view {
    DialogEventSetBool( YES );
    DialogEventSetLong( [[splitView subviews] indexOfObject:view] );
    CUI_OutputWindowSetTag( [splitView wndTag] );
    CallUserDefinedOnDialogFunction( splitViewShouldAdjustSizeOfSubview, [splitView tag], [splitView wndTag], (__bridge CFTypeRef)view );
    return DialogEventBool();
}

- (NSRect)splitView:(NSSplitView *)splitView effectiveRect:(NSRect)proposedEffectiveRect forDrawnRect:(NSRect)drawnRect ofDividerAtIndex:(NSInteger)dividerIndex {
    
    return proposedEffectiveRect;
}

- (BOOL)splitView:(NSSplitView *)splitView shouldHideDividerAtIndex:(NSInteger)dividerIndex {
    DialogEventSetBool( NO );
    DialogEventSetLong( dividerIndex );
    CUI_OutputWindowSetTag( [splitView wndTag] );
    CallUserDefinedOnDialogFunction( splitViewShouldHideDividerAtIndex, [splitView tag], [splitView wndTag], (__bridge CFTypeRef)splitView );
    return DialogEventBool();
}

//- (NSRect)splitView:(NSSplitView *)splitView additionalEffectiveRectOfDividerAtIndex:(NSInteger)dividerIndex {
//
//    return rect;
//}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMaximumPosition ofSubviewAt:(NSInteger)dividerIndex {
    DialogEventSetDouble( proposedMaximumPosition );
    DialogEventSetLong( dividerIndex );
    CUI_OutputWindowSetTag( [splitView wndTag] );
    CallUserDefinedOnDialogFunction( splitViewConstrainMaxCoordinate, [splitView tag], [splitView wndTag],(__bridge CFTypeRef)splitView );
    return DialogEventDouble();
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMinimumPosition ofSubviewAt:(NSInteger)dividerIndex {
    DialogEventSetDouble( proposedMinimumPosition );
    DialogEventSetLong( dividerIndex );
    CUI_OutputWindowSetTag( [splitView wndTag] );
    CallUserDefinedOnDialogFunction( splitViewConstrainMinCoordinate, [splitView tag], [splitView wndTag], (__bridge CFTypeRef)splitView );
    return DialogEventDouble();
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainSplitPosition:(CGFloat)proposedPosition ofSubviewAt:(NSInteger)dividerIndex {
    DialogEventSetDouble( proposedPosition );
    DialogEventSetLong( dividerIndex );
    CallUserDefinedOnDialogFunction( splitViewConstrainSplitPosition, [splitView tag], [splitView wndTag], (__bridge CFTypeRef)splitView );
    return DialogEventDouble();;
}
@end

CUI_SplitViewDelegate *CUI_SplitViewDelegateObj( void )
{
    static CUI_SplitViewDelegate *sCUI_SplitViewDelegate = nil;
    if ( !sCUI_SplitViewDelegate ) sCUI_SplitViewDelegate = [[CUI_SplitViewDelegate alloc] init];
    return sCUI_SplitViewDelegate;
}

// Class
Class SplitViewClass( void )
{ return [NSSplitView class]; }

NSSplitView *SplitViewWithTag( NSInteger tag )
{ return (NSSplitView *)CUI_ValidateViewKindOfClass( tag, [NSSplitView class] ); }

BOOL SplitViewExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSSplitView class] ); }

// Arranging subviews
CFArrayRef SplitViewArrangedSubviews( NSInteger tag )
{
    NSSplitView *splitView = SplitViewWithTag( tag );
    if ( splitView ) return (__bridge CFArrayRef)[splitView arrangedSubviews];
    return nil;
}

BOOL SplitViewArrangesAllSubviews( NSInteger tag )
{
    NSSplitView *splitView = SplitViewWithTag( tag );
    if ( splitView ) return [splitView arrangesAllSubviews];
    return NO;
}

void SplitViewAddArrangedSubview( NSInteger tag, NSInteger vwTag )
{
    NSSplitView *splitView = SplitViewWithTag( tag );
    if ( splitView ) {
        NSView *vwRef = CUI_ViewWithTag( vwTag );
        if ( vwRef ) [splitView addArrangedSubview:vwRef];
    }
}

void SplitViewInsertArrangedSubview( NSInteger tag, NSInteger vwTag, NSInteger index )
{
    NSSplitView *splitView = SplitViewWithTag( tag );
    if ( splitView ) {
        NSView *vwRef = CUI_ViewWithTag( vwTag );
        if ( vwRef ) [splitView insertArrangedSubview:vwRef atIndex:index];
    }
}

void SplitViewRemoveArrangedSubview( NSInteger tag, NSInteger vwTag )
{
    NSSplitView *splitView = SplitViewWithTag( tag );
    if ( splitView ) {
        NSView *vwRef = CUI_ViewWithTag( vwTag );
        if ( vwRef ) [splitView removeArrangedSubview:vwRef];
    }
}

// Managing subviews
void SplitViewAdjustSubviews( NSInteger tag )
{
    NSSplitView *splitView = SplitViewWithTag( tag );
    if ( splitView ) [splitView adjustSubviews];
}

BOOL SplitViewIsPaneCollapsed( NSInteger tag, NSInteger index )
{
    NSSplitView *splitView = SplitViewWithTag( tag );
    if ( splitView ) {
        NSArray *views = [splitView subviews];
        if ( views ) {
            NSView *view = [views objectAtIndex:index];
            return [splitView isSubviewCollapsed:view];
        }
    }
    return NO;
}

float SplitViewHoldingPriority( NSInteger tag, NSInteger paneIndex )
{
    NSSplitView *splitView = SplitViewWithTag( tag );
    if ( splitView ) return [splitView holdingPriorityForSubviewAtIndex:paneIndex];
    return 0.0;
}

void SplitViewSetHoldingPriority( NSInteger tag, NSInteger index, float priority )
{
    NSSplitView *splitView = SplitViewWithTag( tag );
    if ( splitView ) {
        if ( [splitView respondsToSelector:@selector(setHoldingPriority:forSubviewAtIndex:)] ) {
            [splitView setHoldingPriority:priority forSubviewAtIndex:index];
        }
    }
}

// Divider orientation
BOOL SplitViewIsVertical( NSInteger tag )
{
    NSSplitView *splitView = SplitViewWithTag( tag );
    if ( splitView ) return [splitView isVertical];
    return NO;
}

void SplitViewSetVertical( NSInteger tag, BOOL flag )
{
    NSSplitView *splitView = SplitViewWithTag( tag );
    if ( splitView ) [splitView setVertical:flag];
}

// Configure and draw dividers
NSSplitViewDividerStyle SplitViewDividerStyle( NSInteger tag )
{
    NSSplitView *splitView = SplitViewWithTag( tag );
    if ( splitView ) return [splitView dividerStyle];
    return 0;
}

void SplitViewSetDividerStyle( NSInteger tag, NSSplitViewDividerStyle style )
{
    NSSplitView *splitView = SplitViewWithTag( tag );
    if ( splitView ) [splitView setDividerStyle:style];
}

CGFloat SplitViewDividerThickness( NSInteger tag )
{
    NSSplitView *splitView = SplitViewWithTag( tag );
    if ( splitView ) {
        return [splitView dividerThickness];
    }
    return 0.0;
}

// Saving subview positions
CFStringRef SplitViewAutosaveName( NSInteger tag )
{
    NSSplitView *splitView = SplitViewWithTag( tag );
    if ( splitView ) return (__bridge CFStringRef)[splitView autosaveName];
    return nil;
}

void SplitViewSetAutosaveName( NSInteger tag, CFStringRef name )
{
    NSSplitView *splitView = SplitViewWithTag( tag );
    if ( splitView ) [splitView setAutosaveName:(__bridge NSString *)name];
}

// Constraining split position
CGFloat SplitViewMinPossiblePositionOfDivider( NSInteger tag, NSInteger index )
{
    NSSplitView *splitView = SplitViewWithTag( tag );
    if ( splitView ) {
        return [splitView minPossiblePositionOfDividerAtIndex:index];
    }
    return 0.0;
}

CGFloat SplitViewMaxPossiblePositionOfDivider( NSInteger tag, NSInteger index )
{
    NSSplitView *splitView = SplitViewWithTag( tag );
    if ( splitView ) {
        return [splitView maxPossiblePositionOfDividerAtIndex:index];
    }
    return 0.0;
}

void SplitViewSetPositionOfDivider( NSInteger tag, NSInteger index, CGFloat position )
{
    NSSplitView *splitView = SplitViewWithTag( tag );
    if ( splitView ) {
        [splitView setPosition:position ofDividerAtIndex:index];
    }
}

// Convenience
void SplitViewAddSubview( NSInteger splitViewTag, NSInteger index, NSInteger subviewTag )
{
    NSSplitView *splitView = SplitViewWithTag( splitViewTag );
    if ( splitView ) {
        NSArray *views = [splitView subviews];
        NSView *view = [views objectAtIndex:index];
        id subview = CUI_ViewWithTag( subviewTag );
        if ( subview ) {
            [view addSubview:subview];
        }
    }
}

void SplitViewAddSubviewSizeToFit( NSInteger splitViewTag, NSInteger index, NSInteger subviewTag )
{
    NSSplitView *splitView = SplitViewWithTag( splitViewTag );
    if ( splitView ) {
        NSArray *views = [splitView subviews];
        NSView *view = [views objectAtIndex:index];
        id subview = CUI_ViewWithTag( subviewTag );
        if ( subview ) {
            [subview setFrame:[view bounds]];
            [view addSubview:subview];
        }
    }
}

NSView *SplitViewPaneView( NSInteger tag, NSInteger paneIndex )
{
    NSSplitView *splitView = SplitViewWithTag( tag );
    if ( splitView ) {
        NSArray *views = [splitView subviews];
        return [views objectAtIndex:paneIndex];
    }
    return nil;
}

CGSize SplitViewPaneSize( NSInteger tag, NSInteger paneIndex )
{
    NSSplitView *splitView = SplitViewWithTag( tag );
    if ( splitView ) {
        NSArray *views = [splitView subviews];
        return NSSizeToCGSize([[views objectAtIndex:paneIndex] bounds].size);
    }
    return CGSizeZero;
}

void SplitViewMakeSidebar( NSInteger tag )
{
    NSSplitView *splitView = SplitViewWithTag( tag );
    if ( splitView ) {
        NSArray *subviews = [splitView subviews];
        if ( [subviews count] == 2 ) {
            // left and right view controllers
            NSViewController *leftVC = [[NSViewController alloc] init];
            [leftVC setView:[subviews firstObject]];
            
            NSViewController *rightVC = [[NSViewController alloc] init];
            [rightVC setView:[subviews lastObject]];

            // left and right items
            NSSplitViewItem *leftItem = [NSSplitViewItem sidebarWithViewController:leftVC];
            NSSplitViewItem *rightItem = [NSSplitViewItem splitViewItemWithViewController:rightVC];
            
            // split view controller
            NSSplitViewController *splitVC = [[NSSplitViewController alloc] init];
            [splitVC setSplitViewItems:@[leftItem,rightItem]];
            [splitVC setSplitView:splitView];

            // window
            NSWindow *window = [splitView window];
            [window setContentViewController:splitVC];            
        }
    }
}


// Init
NSSplitView *SplitViewInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) rect = NSMakeRect( 20, 20, 163, 96 );

    // subclass
    BOOL subclass = CUI_IsSubclassFlag();

    // init
    NSSplitView *splitView;
#if __has_feature(objc_arc)
    if ( subclass ) {
        splitView = [[SplitViewSC alloc] initWithFrame:rect];
    } else {
        splitView = [[NSSplitView alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        splitView = [[[SplitViewSC alloc] initWithFrame:rect] autorelease];
    } else {
        splitView = [[[NSSplitView alloc] initWithFrame:rect] autorelease];
    }
#endif
    
//#if !__has_feature(objc_arc)
//    [splitView autorelease];
//#endif
    
    // tag
    [splitView setTag:inTag];

    // delegate
    [splitView setDelegate:CUI_SplitViewDelegateObj()];

    return splitView;
}

// Statement
void CUI_SplitView( NSInteger inTag, CGRect inRect, NSInteger inVertical, NSInteger inDividerStyle, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSSplitView *splitView = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !splitView ) {
            splitView = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( splitView ) {    // exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            // make sure it's correct class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, splitView, [NSSplitView class] ) ) {
                return;
            }

            // rect
            if ( !NSIsEmptyRect( rect ) ) [splitView setFrame:rect];
            
            // vertical
            if ( inVertical != kFBParamMissing ) [splitView setVertical:(BOOL)inVertical];
            
            // divider style
            if ( inDividerStyle != kFBParamMissing ) [splitView setDividerStyle:inDividerStyle];
            
        } else {        // create
            BOOL vertical = NO;
            if ( inVertical != kFBParamMissing ) vertical = (BOOL)inVertical;
            
            // init
            splitView = SplitViewInit( inTag, inRect );
            
            // default autoresizing
            [splitView setAutoresizingMask:NSViewMinYMargin];
            
            // vertical
            [splitView setVertical:vertical];
            
            // divider style
            if ( inDividerStyle == kFBParamMissing ) {
                [splitView setDividerStyle:NSSplitViewDividerStylePaneSplitter];
            } else {
                [splitView setDividerStyle:inDividerStyle];
            }
            
            // subviews
            CGFloat dividerThickness = [splitView dividerThickness];
            CGFloat viewWidth, viewHeight;
            CGFloat view1x = 0.0;
            CGFloat view1y = 0.0;

            if ( vertical ) {
                viewWidth = (rect.size.width - dividerThickness) / 2;
                viewHeight = rect.size.height;
                view1x = viewWidth+dividerThickness;
            } else {
                viewWidth = rect.size.width;
                viewHeight = (rect.size.height - dividerThickness) / 2;
                view1y = viewHeight+dividerThickness;
            }

            NSView *view0 = [[NSView alloc] initWithFrame:NSMakeRect(0,0,viewWidth,viewHeight)];
            NSView *view1 = [[NSView alloc] initWithFrame:NSMakeRect(view1x,view1y,viewWidth,viewHeight)];

            [splitView addSubview:view0];
            [splitView addSubview:view1];
            
            // wndTag
            [splitView setWndTag:inWndTag];
            
            // add to window/popover/superview
            id superview = CUI_CurrentSuperview();
            if ( superview ) {
                [superview addSubview:splitView];
            } else {
                [contentView addSubview:splitView];
            }

            [splitView adjustSubviews];
        }
        
        [splitView setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
}

