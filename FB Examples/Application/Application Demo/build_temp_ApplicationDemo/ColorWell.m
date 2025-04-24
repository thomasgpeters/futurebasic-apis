/*
 ColorWell.m

 Bernie Wylde
 */

#import "ColorWell.h"

#pragma mark - pulldown target
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
@implementation CUI_ColorWellPulldownTarget
- (void)colorWellPulldownAction:(id)sender {
    CUI_ControlCallUserDefinedOnDialogOrCallback( colorWellPulldown, sender, sender );
}
@end

CUI_ColorWellPulldownTarget *CUI_ColorWellPulldownTargetObj( void )
{
    static CUI_ColorWellPulldownTarget *sCUI_ColorWellPulldownTarget = nil;
    if ( !sCUI_ColorWellPulldownTarget ) sCUI_ColorWellPulldownTarget = [[CUI_ColorWellPulldownTarget alloc] init];
    return sCUI_ColorWellPulldownTarget;
}
#endif// 130000


#pragma mark - subclass
@implementation ColorWellSC
- (void)drawRect:(NSRect)dirtyRect {
    CUI_ViewSubclassDrawRect( self, dirtyRect );
    if ( !DialogEventBool() ) [super drawRect:dirtyRect];
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
}

- (void)flagsChanged:(NSEvent *)event {
    CUI_ViewSubclassFlagsChanged( self, event );
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

// Class
Class ColorWellClass( void )
{ return [NSColorWell class]; }

NSColorWell *ColorWellWithTag( NSInteger tag )
{ return (NSColorWell *)CUI_ValidateViewKindOfClass( tag, [NSColorWell class] ); }

BOOL ColorWellExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSColorWell class] ); }



NSColor *ColorWellColor( NSInteger tag )
{
    NSColorWell *well = ColorWellWithTag( tag );
    if ( well ) return [well color];
    return nil;
}

void ColorWellSetColor( NSInteger tag, NSColor *col )
{
    NSColorWell *well = ColorWellWithTag( tag );
    if ( well ) [well setColor:col];
}

void ColorWellTakeColorFrom( NSInteger tag, NSInteger senderTag )
{
    NSColorWell *well = ColorWellWithTag( tag );
    if ( well ) {
        id sender = CUI_ViewWithTag( senderTag );
        if ( sender ) {
            NSColor *color = [sender color];
            [well setColor:color];
        }
    }
}

void ColorWellActivate( NSInteger tag, BOOL exclusive )
{
    NSColorWell *well = ColorWellWithTag( tag );
    if ( well ) [well activate:exclusive];
}

BOOL ColorWellIsActive( NSInteger tag )
{
    NSColorWell *well = ColorWellWithTag( tag );
    if ( well ) return [well isActive];
    return false;
}

void ColorWellDeactivate( NSInteger tag )
{
    NSColorWell *well = ColorWellWithTag( tag );
    if ( well ) [well deactivate];
}

void ColorWellDrawWellInside( NSInteger tag, CGRect insideRect )
{
    NSColorWell *well = ColorWellWithTag( tag );
    if ( well ) [well drawWellInside:NSRectFromCGRect(insideRect)];
}

BOOL ColorWellIsBordered( NSInteger tag )
{
    NSColorWell *well = ColorWellWithTag( tag );
    if ( well ) return [well isBordered];
    return false;
}

void ColorWellSetBordered( NSInteger tag, BOOL flag )
{
    NSColorWell *well = ColorWellWithTag( tag );
    if ( well ) [well setBordered:flag];
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
// Style
NSColorWellStyle ColorWellStyle( NSInteger tag )
{
    NSColorWell *well = ColorWellWithTag( tag );
    if ( well ) return [well colorWellStyle];
    return 0;
}

void ColorWellSetStyle( NSInteger tag, NSColorWellStyle style )
{
    NSColorWell *well = ColorWellWithTag( tag );
    if ( well ) [well setColorWellStyle:style];
}

// Image
NSImage *ColorWellImage( NSInteger tag )
{
    NSColorWell *well = ColorWellWithTag( tag );
    if ( well ) return [well image];
    return nil;
}

//void ColorWellSetImage( NSInteger tag, NSImage *image )
//{
//    NSColorWell *well = ColorWellWithTag( tag );
//    if ( well ) [well setImage:image];
//}

void ColorWellSetImage( NSInteger tag, CFTypeRef inImage )
{
    NSColorWell *well = ColorWellWithTag( tag );
    if ( well ) {
        NSImage *image = CUI_FixImageValue( inImage );
        [well setImage:image];
    }
}

// Pulldown action
void ColorWellEnablePulldownAction( NSInteger tag, BOOL flag )
{
    NSColorWell *well = ColorWellWithTag( tag );
    if ( well ) {
        if ( flag ) {
            [well setPulldownTarget:CUI_ColorWellPulldownTargetObj()];
            [well setPulldownAction:@selector(colorWellPulldownAction:)];
        } else {
            [well setPulldownTarget:nil];
            [well setPulldownAction:nil];
        }
    }
}
#endif// 130000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
BOOL ColorWellSupportsAlpha( NSInteger tag )
{
    NSColorWell *well = ColorWellWithTag( tag );
    if ( well ) return [well supportsAlpha];
    return NO;
}

void ColorWellSetSupportsAlpha( NSInteger tag, BOOL flag )
{
    NSColorWell *well = ColorWellWithTag( tag );
    if ( well ) [well setSupportsAlpha:flag];
}
#endif// 140000


// Init
NSColorWell *ColorWellInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) {
        rect = NSMakeRect( 17, 18, 44, 28 );
    }
    
    // subclass
    BOOL subclass = CUI_IsSubclassFlag();
    
    // init
    NSColorWell *well;
#if __has_feature(objc_arc)
    if ( subclass ) {
        well = [[ColorWellSC alloc] initWithFrame:rect];
    } else {
        well = [[NSColorWell alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        well = [[[ColorWellSC alloc] initWithFrame:rect] autorelease];
    } else {
        well = [[[NSColorWell alloc] initWithFrame:rect] autorelease];
    }
#endif
    
    // tag
    [well setTag:inTag];
    
    // target/action
    [well setTarget:CUI_ControlTargetObj()];
    [well setAction:@selector(controlAction:)];
    
    return well;
}

// statement
void CUI_ColorWell( NSInteger inTag, NSInteger inEnabled, long inColor, CGRect inRect, NSInteger inStyle, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSColor *color = CUI_FixColor( inColor );
        
        NSView *contentView = CUI_TargetContentView( w );
        
        NSColorWell *well = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !well ) {
            well = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( well ) {   // exists
            // make sure it's same view class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, well, [NSColorWell class] ) ) {
                return;
            }

            // enabled
            if ( inEnabled != kFBParamMissing ) [well setEnabled:(BOOL)inEnabled];
            
            // color
            if ( color ) [well setColor:color];
            
            // rect
            if ( !NSIsEmptyRect( rect ) ) [well setFrame:rect];
            
            // style
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
            if ( @available(macOS 13.0, *) ) {
                if ( inStyle != kFBParamMissing ) [well setColorWellStyle:inStyle];
            }
#else
            inStyle++;// silence clang 'unused parameter' warning when running macOS 12 or earlier
#endif// 130000

        } else {    // create
            well = ColorWellInit( inTag, inRect );
            
            // default autoresizing
            [well setAutoresizingMask:NSViewMinYMargin];
            
            // enabled
            if ( inEnabled != kFBParamMissing ) [well setEnabled:(BOOL)inEnabled];
            
            // color
            if ( color ) [well setColor:color];
            
            // style
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
            if ( @available(macOS 13.0, *) ) {
                if ( inStyle != kFBParamMissing ) {
                    [well setColorWellStyle:inStyle];
                }
            }
#endif// 130000

            // wndTag
            [well setWndTag:inWndTag];
            
            // add to window/popover/superview
            id superview = CUI_CurrentSuperview();
            if ( superview ) {
                [superview addSubview:well];
            } else {
                [contentView addSubview:well];
            }

        }
        
        [well setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
}

