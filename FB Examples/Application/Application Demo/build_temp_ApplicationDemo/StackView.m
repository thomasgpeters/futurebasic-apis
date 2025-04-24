/*
 StackView.m
 
 Bernie Wylde
 */

#import "StackView.h"

@implementation StackViewSC

- (void)resetCursorRects {
    CUI_ViewSubclassResetCursorRects( self );
}

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

@implementation NSStackView (Additions)
@dynamic tagNumber;

- (NSInteger)tag {
    return [objc_getAssociatedObject(self, @selector(tagNumber)) integerValue];
}

- (void)setTag:(NSInteger)tag {
    objc_setAssociatedObject(self, @selector(tagNumber), [NSNumber numberWithInteger:tag], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

@implementation CUI_StackViewDelegate
- (void)stackView:(NSStackView *)stackView didReattachViews:(NSArray *)views {
    DialogEventSetNSArray( views );
    CUI_OutputWindowSetTag( [stackView wndTag] );
    CallUserDefinedOnDialogFunction( stackViewDidReattachViews, [stackView tag], [stackView wndTag], (__bridge CFTypeRef)views );
}

- (void)stackView:(NSStackView *)stackView willDetachViews:(NSArray *)views {
    DialogEventSetNSArray( views );
    CUI_OutputWindowSetTag( [stackView wndTag] );
    CallUserDefinedOnDialogFunction( stackViewWillDetachViews, [stackView tag], [stackView wndTag], (__bridge CFTypeRef)views );
}
@end

CUI_StackViewDelegate *CUI_StackViewDelegateObj( void )
{
    static CUI_StackViewDelegate *sCUI_StackViewDelegate = nil;
    if ( !sCUI_StackViewDelegate ) sCUI_StackViewDelegate = [[CUI_StackViewDelegate alloc] init];
    return sCUI_StackViewDelegate;
}

// Class
Class StackViewClass( void )
{ return [NSStackView class]; }

NSStackView *StackViewWithTag( NSInteger tag )
{ return (NSStackView *)CUI_ValidateViewKindOfClass( tag, [NSStackView class] ); }

BOOL StackViewExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSStackView class] ); }

// Instance properties
BOOL StackViewDetachesHiddenViews( NSInteger tag )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) return [view detachesHiddenViews];
    return NO;
}

void StackViewSetDetachesHiddenViews( NSInteger tag, BOOL flag )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) [view setDetachesHiddenViews:flag];
}

// Adding and removing views
void StackViewAddView( NSInteger tag, NSInteger vwTag, NSStackViewGravity gravity )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) {
        NSView *otherView = ViewWithTag( vwTag );
        if ( otherView ) [view addView:otherView inGravity:gravity];
    }
}

void StackViewInsertView( NSInteger tag, NSInteger vwTag, NSUInteger index, NSStackViewGravity gravity )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) {
        NSView *otherView = ViewWithTag( vwTag );
        if ( otherView ) [view insertView:otherView atIndex:index inGravity:gravity];
    }
}

void StackViewSetViewsInGravity( NSInteger tag, CFArrayRef views, NSStackViewGravity gravity )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) [view setViews:(__bridge NSArray *)views inGravity:gravity];
}

void StackViewRemoveView( NSInteger tag, NSInteger vwTag )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) {
        NSView *otherView = ViewWithTag( vwTag );
        if ( otherView ) [view removeView:otherView];
    }
}

void StackViewAddArrangedSubview( NSInteger tag, NSInteger vwTag )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) {
        NSView *otherView = ViewWithTag( vwTag );
        if ( otherView ) [view addArrangedSubview:otherView];
    }
}

void StackViewInsertArrangedSubview( NSInteger tag, NSInteger vwTag, NSUInteger index )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) {
        NSView *otherView = ViewWithTag( vwTag );
        if ( otherView ) [view insertArrangedSubview:otherView atIndex:index];
    }
}

void StackViewRemoveArrangedSubview( NSInteger tag, NSInteger vwTag )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) {
        NSView *otherView = ViewWithTag( vwTag );
        if ( otherView ) [view removeArrangedSubview:otherView];
    }
}

CFArrayRef StackViewArrangedSubviews( NSInteger tag )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) return (__bridge CFArrayRef)[view arrangedSubviews];
    return nil;
}


// Inspecting
CFArrayRef StackViewViews( NSInteger tag )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) return (__bridge CFArrayRef)[view views];
    return nil;
}

CFArrayRef StackViewViewsInGravity( NSInteger tag, NSStackViewGravity gravity )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) return (__bridge CFArrayRef)[view viewsInGravity:gravity];
    return nil;
}

CFArrayRef StackViewDetachedViews( NSInteger tag )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) return (__bridge CFArrayRef)[view detachedViews];
    return nil;
}


NSLayoutPriority StackViewClippingResistancePriorityForOrientation( NSInteger tag, NSLayoutConstraintOrientation orientation )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) return [view clippingResistancePriorityForOrientation:orientation];
    return 0;
}

void StackViewSetClippingResistancePriorityForOrientation( NSInteger tag, NSLayoutPriority priority, NSLayoutConstraintOrientation orientation )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) [view setClippingResistancePriority:priority forOrientation:orientation];
}

NSLayoutPriority StackViewHuggingPriorityForOrientation( NSInteger tag, NSLayoutConstraintOrientation orientation )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) return [view huggingPriorityForOrientation:orientation];
    return 0;
}

void StackViewSetHuggingPriorityForOrientation( NSInteger tag, NSLayoutPriority priority, NSLayoutConstraintOrientation orientation )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) [view setHuggingPriority:priority forOrientation:orientation];
}

// Configure layout
NSUserInterfaceLayoutOrientation StackViewOrientation( NSInteger tag )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) return [view orientation];
    return 0;
}

void StackViewSetOrientation( NSInteger tag, NSUserInterfaceLayoutOrientation orientation )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) [view setOrientation:orientation];
}

NSLayoutAttribute StackViewAlignment( NSInteger tag )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) return [view alignment];
    return 0;
}

void StackViewSetAlignment( NSInteger tag, NSLayoutAttribute alignment )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) [view setAlignment:alignment];
}

CGFloat StackViewSpacing( NSInteger tag )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) return [view spacing];
    return 0.0;
}

void StackViewSetSpacing( NSInteger tag, CGFloat spacing )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) [view setSpacing:spacing];
}

NSEdgeInsets StackViewEdgeInsets( NSInteger tag )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) return [view edgeInsets];
    return NSEdgeInsetsMake(0.0,0.0,0.0,0.0);
}

void StackViewSetEdgeInsets( NSInteger tag, NSEdgeInsets insets )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) [view setEdgeInsets:insets];
}

NSStackViewDistribution StackViewDistribution( NSInteger tag )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) return [view distribution];
    return 0;
}

void StackViewSetDistribution( NSInteger tag, NSStackViewDistribution distribution )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) [view setDistribution:distribution];
}

// Configure views
CGFloat StackViewCustomSpacingAfterView( NSInteger tag, NSInteger vwTag )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) {
        NSView *otherView = ViewWithTag( vwTag );
        if ( otherView ) return [view customSpacingAfterView:otherView];
    }
    return 0.0;
}

void StackViewSetCustomSpacingAfterView( NSInteger tag, CGFloat spacing, NSInteger vwTag )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) {
        NSView *otherView = ViewWithTag( vwTag );
        if ( otherView ) [view setCustomSpacing:spacing afterView:otherView];
    }
}

NSStackViewVisibilityPriority StackViewVisibilityPriorityForView( NSInteger tag, NSInteger vwTag )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) {
        NSView *otherView = ViewWithTag( vwTag );
        if ( otherView ) return [view visibilityPriorityForView:otherView];
    }
    return 0;
}

void StackViewSetVisibilityPriorityForView( NSInteger tag, NSStackViewVisibilityPriority priority, NSInteger vwTag )
{
    NSStackView *view = StackViewWithTag( tag );
    if ( view ) {
        NSView *otherView = ViewWithTag( vwTag );
        if ( otherView ) [view setVisibilityPriority:priority forView:otherView];
    }
}


// Init
NSStackView *StackViewInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    
    // subclass
    BOOL subclass = CUI_IsSubclassFlag();
    
    // init
    NSStackView *view;
#if __has_feature(objc_arc)
    if ( subclass ) {
        view = [[StackViewSC alloc] initWithFrame:rect];
    } else {
        view = [[NSStackView alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        view = [[[StackViewSC alloc] initWithFrame:rect] autorelease];
    } else {
        view = [[[NSStackView alloc] initWithFrame:rect] autorelease];
    }
#endif
    
//#if !__has_feature(objc_arc)
//    [view autorelease];
//#endif
    
    // tag
    [view setTag:inTag];
        
    // delegate
    [view setDelegate:CUI_StackViewDelegateObj()];
    
    return view;
}

// Statement
void CUI_StackView( NSInteger inTag, CGRect inRect, NSInteger inHorizontal, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSStackView *view = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !view ) {
            view = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( view ) {    // exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);
            
            // make sure it's correct class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, view, [NSStackView class] ) ) {
                return;
            }
            
            // rect
            if ( !NSIsEmptyRect( rect ) ) [view setFrame:rect];
            
            // orientation
            if ( inHorizontal != kFBParamMissing ) {
                if ( inHorizontal ) {
                    [view setOrientation:NSUserInterfaceLayoutOrientationHorizontal];
                } else {
                    [view setOrientation:NSUserInterfaceLayoutOrientationVertical];
                }
            }
            
        } else {        // create
            BOOL horizontal = NO;
            if ( inHorizontal != kFBParamMissing ) horizontal = (BOOL)inHorizontal;
            
            
            if ( NSIsEmptyRect( rect ) ) {
                if ( horizontal ) {
                    rect = NSMakeRect( 20, 20, 200, 110 );
                } else {
                    rect = NSMakeRect( 20, 20, 110, 200 );
                }
            }
            
            // init
            view = StackViewInit( inTag, NSRectToCGRect( rect ) );
            
            // default autoresizing
            [view setAutoresizingMask:NSViewMinYMargin];
            
            // orientation
            if ( horizontal ) {
                [view setOrientation:NSUserInterfaceLayoutOrientationHorizontal];
            } else {
                [view setOrientation:NSUserInterfaceLayoutOrientationVertical];
            }
            
            // wndTag
            [view setWndTag:inWndTag];
            
            // add to window/popover/superview
            id superview = CUI_CurrentSuperview();
            if ( superview ) {
                [superview addSubview:view];
            } else {
                [contentView addSubview:view];
            }

        }
        
        [view setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
}

