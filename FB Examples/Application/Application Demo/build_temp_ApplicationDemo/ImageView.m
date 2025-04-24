/*
 ImageView.m

 Bernie Wylde
 */

#import "ImageView.h"

#pragma mark - subclass
@implementation ImageViewSC
- (void)drawRect:(NSRect)dirtyRect {
    CUI_ViewSubclassDrawRect( self, dirtyRect );
    if ( !DialogEventBool() ) [super drawRect:dirtyRect];
}

- (BOOL)acceptsFirstResponder {
    DialogEventSetBool(NO);
    CUI_ViewSubclassAcceptsFirstResponder( self );
    return DialogEventBool();
}

- (void)mouseDown:(NSEvent *)event {
    DialogEventSetBool(NO);
    CUI_ResponderMouseDown( self, event );
    //CUI_ViewSubclassMouseDown( self, event );
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
Class ImageViewClass( void )
{ return [NSImageView class]; }

NSImageView *ImageViewWithTag( NSInteger tag )
{ return (NSImageView *)CUI_ValidateViewKindOfClass( tag, [NSImageView class] ); }

BOOL ImageViewExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSImageView class] ); }


// - image
NSImage *ImageViewImage( NSInteger tag )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) return [view image];
    return nil;
}

void ImageViewSetImage( NSInteger tag, CFTypeRef inImage )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) {
        NSImage *image = CUI_FixImageValue( inImage );
        [view setImage:image];
    }
}

void ImageViewSetImageNamed( NSInteger tag, CFStringRef imageName )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) {
        NSImage *image = CUI_ImageResource( (__bridge NSString *)imageName );
        if ( image ) [view setImage:image];
    }
}

// - visual characteristics -
NSImageFrameStyle ImageViewFrameStyle( NSInteger tag )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) return [view imageFrameStyle];
    return 0;
}

void ImageViewSetFrameStyle( NSInteger tag, NSImageFrameStyle style )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) [view setImageFrameStyle:style];
}

NSImageAlignment ImageViewAlignment( NSInteger tag )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) return [view imageAlignment];
    return 0;
}

void ImageViewSetAlignment( NSInteger tag, NSImageAlignment alignment )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) [view setImageAlignment:alignment];
}

NSImageScaling ImageViewScaling( NSInteger tag )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) return [view imageScaling];
    return 0;
}

void ImageViewSetScaling( NSInteger tag, NSImageScaling scaling )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) [view setImageScaling:scaling];
}

BOOL ImageViewAnimates( NSInteger tag )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) return [view animates];
    return NO;
}

void ImageViewSetAnimates( NSInteger tag, BOOL flag )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) [view setAnimates:flag];
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
NSImageSymbolConfiguration *ImageViewSymbolConfiguration( NSInteger tag )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) return [view symbolConfiguration];
    return nil;
}

API_AVAILABLE(macos(11.0))
void ImageViewSetSymbolConfiguration( NSInteger tag, NSImageSymbolConfiguration *config )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) [view setSymbolConfiguration:config];
}
#endif// 110000

// - user events -
void ImageViewSetEditable( NSInteger tag, BOOL flag )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) [view setEditable:flag];
}

void ImageViewSetAllowsCutCopyPaste( NSInteger tag, BOOL flag )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) [view setAllowsCutCopyPaste:flag];
}

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
NSColor *ImageViewContentTintColor( NSInteger tag )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) return [view contentTintColor];
    return nil;
}

void ImageViewSetContentTintColor( NSInteger tag, NSColor *col )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) [view setContentTintColor:col];
}
#endif// 101400

// Symbol effects
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
void ImageViewAddSymbolEffect( NSInteger tag, NSSymbolEffect *effect )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) [view addSymbolEffect:effect];
}

void ImageViewAddSymbolEffectWithOptions( NSInteger tag, NSSymbolEffect *effect, NSSymbolEffectOptions *options )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) [view addSymbolEffect:effect options:options];
}

void ImageViewAddSymbolEffectAnimated( NSInteger tag, NSSymbolEffect *effect, NSSymbolEffectOptions *options, BOOL animated )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) [view addSymbolEffect:effect options:options animated:animated];
}

void ImageViewRemoveSymbolEffect( NSInteger tag, NSSymbolEffect *effect )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) [view removeSymbolEffectOfType:effect];
}

void ImageViewRemoveSymbolEffectWithOptions( NSInteger tag, NSSymbolEffect *effect, NSSymbolEffectOptions *options )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) [view removeSymbolEffectOfType:effect options:options];
}

void ImageViewRemoveSymbolEffectAnimated( NSInteger tag, NSSymbolEffect *effect, NSSymbolEffectOptions *options, BOOL animated )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) [view removeSymbolEffectOfType:effect options:options animated:animated];
}

void ImageViewRemoveAllSymbolEffects( NSInteger tag )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) [view removeAllSymbolEffects];
}

void ImageViewRemoveAllSymbolEffectsWithOptions( NSInteger tag, NSSymbolEffectOptions *options )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) [view removeAllSymbolEffectsWithOptions:options];
}

void ImageViewRemoveAllSymbolEffectsAnimated( NSInteger tag, NSSymbolEffectOptions *options, BOOL animated )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) [view removeAllSymbolEffectsWithOptions:options animated:animated];
}

void ImageViewSetSymbolImage( NSInteger tag, NSImage *image, NSSymbolContentTransition *transition )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) [view setSymbolImage:image withContentTransition:transition];
}

void ImageViewSetSymbolImageWithOptions( NSInteger tag, NSImage *image, NSSymbolContentTransition *transition, NSSymbolEffectOptions *options )
{
    NSImageView *view = ImageViewWithTag( tag );
    if ( view ) [view setSymbolImage:image withContentTransition:transition options:options];
}
#endif// 140000


// Init
NSImageView *ImageViewInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) rect = NSMakeRect( 20, 20, 48, 48 );

    // subclass
    BOOL subclass = CUI_IsSubclassFlag();
    
    // init
    NSImageView *view;
#if __has_feature(objc_arc)
    if ( subclass ) {
        view = [[ImageViewSC alloc] initWithFrame:rect];
    } else {
        view = [[NSImageView alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        view = [[[ImageViewSC alloc] initWithFrame:rect] autorelease];
    } else {
        view = [[[NSImageView alloc] initWithFrame:rect] autorelease];
    }
#endif
    
//#if !__has_feature(objc_arc)
//    [view autorelease];
//#endif
    
    // tag
    [view setTag:inTag];
    
    // target/action
    [view setTarget:CUI_ControlTargetObj()];
    [view setAction:@selector(controlAction:)];

    return view;
}


// Statement
void CUI_ImageView( NSInteger inTag, NSInteger inEnabled, void *inImage, CGRect inRect, NSInteger inScaling, NSInteger inAlignment, NSInteger inFrameStyle, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    // imageName, imagePath, NSImage, symbolName
    NSImage *image = CUI_FixImageValue( inImage );
    
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSImageView *view = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !view ) {
            view = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( view ) {    // already exists
            
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            // make sure it's correct class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, view, [NSImageView class] ) ) {
                return;
            }

            // enabled
            if ( inEnabled != kFBParamMissing ) [view setEnabled:(BOOL)inEnabled];
            
            // image
            if ( image ) [view setImage:image];
            
            // rect
            if ( !NSIsEmptyRect( rect ) ) [view setFrame:rect];
            
            // scaling
            if ( inScaling != kFBParamMissing ) [view setImageScaling:inScaling];
            
            // alignment
            if ( inAlignment != kFBParamMissing ) [view setImageAlignment:inAlignment];
            
            // frame style
            if ( inFrameStyle != kFBParamMissing ) [view setImageFrameStyle:inFrameStyle];
            
        } else {
            // init
            view = ImageViewInit( inTag, inRect );
            
            // default autoresizing
            [view setAutoresizingMask:NSViewMinYMargin];
             
            // enabled
            if ( inEnabled != kFBParamMissing ) [view setEnabled:(BOOL)inEnabled];
            
            // image
            if ( image ) [view setImage:image];
            
            // scaling
            if ( inScaling != kFBParamMissing ) [view setImageScaling:inScaling];
            
            // alignment
            if ( inAlignment != kFBParamMissing ) [view setImageAlignment:inAlignment];
            
            // frame style
            if ( inFrameStyle != kFBParamMissing ) [view setImageFrameStyle:inFrameStyle];
            
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
