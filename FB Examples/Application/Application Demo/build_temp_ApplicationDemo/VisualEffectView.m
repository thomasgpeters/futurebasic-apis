/*
 VisualEffectView.m

 Bernie Wylde
 */

#import "VisualEffectView.h"


@implementation VisualEffectViewSC

//- (void)drawLayer:(CALayer *)theLayer inContext:(CGContextRef)theContext {
//    CallUserDefinedOnDialogFunction( CALayerDraw, 0, 0, NULL );
//}

//- (void)setTrackingAreaRect:(NSRect)rect options:(NSTrackingAreaOptions)options {
//    NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:rect options:options owner:self userInfo:nil];
//    [self addTrackingArea:trackingArea];
//    [trackingArea release];
//}

//- (void)viewWillMoveToWindow:(NSWindow *)newWindow {
//    NSTrackingAreaOptions options = NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveAlways;
//    NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds] options:options owner:self userInfo:nil];
//    [self addTrackingArea:trackingArea];
//    //[trackingArea release];
//}

- (void)drawRect:(NSRect)dirtyRect {
    if ( ![self suspendDrawRect] ) {
        CUI_ViewSubclassDrawRect( self, dirtyRect );
        if ( !DialogEventBool() ) [super drawRect:dirtyRect];
    }
}

// this is required for key events
//- (BOOL)acceptsFirstResponder {
//    return self.responderFlag;
//}

- (BOOL)acceptsFirstResponder {
    DialogEventSetBool(NO);
    CUI_ViewSubclassAcceptsFirstResponder( self );
    return DialogEventBool();
}

- (void)mouseDown:(NSEvent *)event {
    CUI_ViewSubclassMouseDown( self, event );
    if ( !DialogEventBool() ) [super mouseDown:event];
}

- (void)mouseUp:(NSEvent *)event {
    CUI_ViewSubclassMouseUp( self, event );
}

- (void)mouseEntered:(NSEvent *)event {
    CUI_ViewSubclassMouseEntered( self, event );
}

- (void)mouseExited:(NSEvent *)event {
    CUI_ViewSubclassMouseExited( self, event );
}

- (void)mouseDragged:(NSEvent *)event {
    CUI_ViewSubclassMouseDragged( self, event );
}

- (void)mouseMoved:(NSEvent *)event {
    CUI_ViewSubclassMouseMoved( self, event );
}

- (void)rightMouseDown:(NSEvent *)event {
    CUI_ViewSubclassRightMouseDown( self, event );
    if ( !DialogEventBool() ) [super rightMouseDown:event];
}

- (void)rightMouseUp:(NSEvent *)event {
    CUI_ViewSubclassRightMouseUp( self, event );
}

- (void)rightMouseDragged:(NSEvent *)event {
    CUI_ViewSubclassRightMouseDragged( self, event );
}

- (void)keyDown:(NSEvent *)event {
    CUI_ViewSubclassKeyDown( self, event );
    if ( !DialogEventBool() ) [super keyDown:event];
}

- (void)keyUp:(NSEvent *)event {
    CUI_ViewSubclassKeyUp( self, event );
    //    if ( !DialogEventBool() ) [super keyUp:event];
}

- (void)flagsChanged:(NSEvent *)event {
    CUI_ViewSubclassFlagsChanged( self, event );
    //    if ( !DialogEventBool() ) [super flagsChanged:event];
}

//- (void)updateTrackingAreas {
//    CUI_ViewSubclassUpdateTrackingAreas( self );
//    [super updateTrackingAreas];
//}

//- (void)updateTrackingAreas {
//    NSArray *areas = [self trackingAreas];
//    if ( [areas count] > 0 ) {
//        NSTrackingArea *trackingArea = [areas objectAtIndex:0];
//        [self removeTrackingArea:trackingArea];
//        [trackingArea release];
//        NSTrackingAreaOptions options = NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveAlways;
//        trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds] options:options owner:self userInfo:nil];
//        [self addTrackingArea:trackingArea];
//        //[trackingArea release];
//    }
//    [super updateTrackingAreas];
//}

- (void)resetCursorRects {
    CUI_ViewSubclassResetCursorRects( self );
}

- (BOOL)wantsUpdateLayer {
    return CUI_ViewSubclassWantsUpdateLayer( self );
}

- (void)updateLayer {
    CUI_ViewSubclassUpdateLayer( self );
}

#pragma mark - dragging
- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    return CUI_ViewSubclassDraggingEntered( self, sender );
}

//- (BOOL)wantsPeriodicDraggingUpdates {
//    return NO;
//}

//- (NSDragOperation)draggingUpdated:(id<NSDraggingInfo>)sender {
//
//    return NSDragOperationNone;
//}

- (void)draggingEnded:(id<NSDraggingInfo>)sender {
    
}

- (void)draggingExited:(id <NSDraggingInfo>)sender {
    CUI_ViewSubclassDraggingExited( self, sender );
}

//- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender {
//    return NO;
//}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    return CUI_ViewSubclassPerformDragOperation( self, sender );
}

- (void)concludeDragOperation:(id<NSDraggingInfo>)sender {
    
}

- (void)updateDraggingItemsForDrag:(id<NSDraggingInfo>)sender {
    
}

- (void)viewDidChangeEffectiveAppearance {
    CUI_ViewSubclassViewDidChangeEffectiveAppearance( self );
}

- (void)awakeFromNib {
    [super awakeFromNib];
    CUI_ViewSubclassAwakeFromNib(self);
}

#pragma mark - flipped
- (BOOL)isFlipped {
    //return flip;
    return self.flipFlag;
}

#pragma mark - menu
- (NSMenu *)menuForEvent:(NSEvent*)theEvent {
    CUI_ViewSubclassMenuForEvent( self, theEvent );
    return DialogEventNSMenu();
}
@end

// Class
Class VisualEffectViewClass( void )
{ return [NSVisualEffectView class]; }

NSVisualEffectView *VisualEffectViewWithTag( NSInteger tag )
{ return (NSVisualEffectView *)CUI_ValidateViewKindOfClass( tag, [NSVisualEffectView class] ); }

BOOL VisualEffectViewExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSVisualEffectView class] ); }

// Functions
NSVisualEffectMaterial VisualEffectViewMaterial( NSInteger tag )
{
    NSVisualEffectView *view = VisualEffectViewWithTag( tag );
    if ( view ) return [view material];
    return 0;
}

void VisualEffectViewSetMaterial( NSInteger tag, NSVisualEffectMaterial material )
{
    NSVisualEffectView *view = VisualEffectViewWithTag( tag );
    if ( view ) [view setMaterial:material];
}

NSBackgroundStyle VisualEffectViewInteriorBackgroundStyle( NSInteger tag )
{
    NSVisualEffectView *view = VisualEffectViewWithTag( tag );
    if ( view ) return [view interiorBackgroundStyle];
    return 0;
}

NSVisualEffectBlendingMode VisualEffectViewBlendingMode( NSInteger tag )
{
    NSVisualEffectView *view = VisualEffectViewWithTag( tag );
    if ( view ) return [view blendingMode];
    return 0;
}

void VisualEffectViewSetBlendingMode( NSInteger tag, NSVisualEffectBlendingMode mode )
{
    NSVisualEffectView *view = VisualEffectViewWithTag( tag );
    if ( view ) [view setBlendingMode:mode];
}

NSVisualEffectState VisualEffectViewState( NSInteger tag )
{
    NSVisualEffectView *view = VisualEffectViewWithTag( tag );
    if ( view ) return [view state];
    return 0;
}

void VisualEffectViewSetState( NSInteger tag, NSVisualEffectState state )
{
    NSVisualEffectView *view = VisualEffectViewWithTag( tag );
    if ( view ) [view setState:state];
}

NSImage *VisualEffectViewMaskImage( NSInteger tag )
{
    NSVisualEffectView *view = VisualEffectViewWithTag( tag );
    if ( view ) return [view maskImage];
    return nil;
}

void VisualEffectViewSetMaskImage( NSInteger tag, NSImage *image )
{
    NSVisualEffectView *view = VisualEffectViewWithTag( tag );
    if ( view ) [view setMaskImage:image];
}

BOOL VisualEffectViewIsEmphasized( NSInteger tag )
{
    NSVisualEffectView *view = VisualEffectViewWithTag( tag );
    if ( view ) return [view isEmphasized];
    return NO;
}

void VisualEffectViewSetEmphasized( NSInteger tag, BOOL flag )
{
    NSVisualEffectView *view = VisualEffectViewWithTag( tag );
    if ( view ) [view setEmphasized:flag];
}

// Init
NSVisualEffectView *VisualEffectViewInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) rect = NSMakeRect( 20, 20, 128, 128 );

    // subclass
    BOOL subclass = CUI_IsSubclassFlag();

    // init
    NSVisualEffectView *view;
#if __has_feature(objc_arc)
    if ( subclass ) {
        view = [[VisualEffectViewSC alloc] initWithFrame:rect];
    } else {
        view = [[NSVisualEffectView alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        view = [[[VisualEffectViewSC alloc] initWithFrame:rect] autorelease];
    } else {
        view = [[[NSVisualEffectView alloc] initWithFrame:rect] autorelease];
    }
#endif
    
//#if !__has_feature(objc_arc)
//    [view autorelease];
//#endif
    
    // material
    [view setMaterial:NSVisualEffectMaterialAppearanceBased];
    
    // mode
    [view setBlendingMode:NSVisualEffectBlendingModeBehindWindow];
    
    // appearance
    [view setAppearance:[NSAppearance appearanceNamed:NSAppearanceNameVibrantDark]];

    // tag
    [view setIdentifier:[NSString stringWithFormat:@"%ld",(long)inTag]];

    // superview
//    if ( CUI_IsSuperview() ) {
//        CUI_AddSuperview( view );
//    }

    return view;
}

// Statement
void CUI_VisualEffectView( NSInteger inTag, CGRect inRect, NSInteger inMaterial, NSInteger inMode, NSInteger inState, void *inImage, NSInteger inEmphasized, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSRect rect = NSRectFromCGRect( inRect );
    
    // imageName, imagePath, NSImage, symbolName
    NSImage *image = CUI_FixImageValue( inImage );

    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSVisualEffectView *view = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !view ) {
            view = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( view ) {    // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            // make sure it's same view class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, view, [NSVisualEffectView class] ) ) {
                return;
            }

            // rect
            if ( !NSIsEmptyRect( rect ) ) [view setFrame:rect];
            
            // material
            if ( inMaterial != kFBParamMissing ) [view setMaterial:inMaterial];

            // mode
            if ( inMode != kFBParamMissing ) [view setBlendingMode:inMode];

            // state
            if ( inState != kFBParamMissing ) [view setState:inState];

            // image
            [view setMaskImage:image];

            // emphasized
            if ( inEmphasized != kFBParamMissing ) [view setEmphasized:(BOOL)inEmphasized];

        } else {            // create
            // init
            view = VisualEffectViewInit( inTag, inRect );
            
            // material
            if ( inMaterial != kFBParamMissing ) [view setMaterial:inMaterial];

            // mode
            if ( inMode != kFBParamMissing ) [view setBlendingMode:inMode];

            // state
            if ( inState != kFBParamMissing ) [view setState:inState];

            // image
            if ( image ) [view setMaskImage:image];

            // emphasized
            if ( inEmphasized != kFBParamMissing ) [view setEmphasized:(BOOL)inEmphasized];

            // autoresizing
            [view setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
            
            // if superview flag set, add view to superview stack
            if ( CUI_IsSuperview() ) CUI_AddSuperview( view );

            // add to window/popover/superview
            id superview = CUI_CurrentSuperview();
            if ( superview == view ) {
                superview = CUI_PenultimateSuperview();
            }

            if ( superview ) {
                [superview addSubview:view];
            } else {
                [contentView addSubview:view];
            }

            // wndTag
            [view setWndTag:inWndTag];
        }
        [view setHidden:!show];
    } else {
        CUI_ShowAlert( NSWarningAlertStyle, @"Window error.", [NSString stringWithFormat:@"Window %ld does not exist.",(long)inWndTag] );
    }
}


