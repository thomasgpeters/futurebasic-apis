/*
 TextInsertionIndicator.m

 Bernie Wylde
 */

#import "TextInsertionIndicator.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000

#pragma mark - subclass
@implementation TextInsertionIndicatorSC
- (void)drawRect:(NSRect)dirtyRect {
    CUI_ViewSubclassDrawRect( self, dirtyRect );
    if ( !DialogEventBool() ) [super drawRect:dirtyRect];
}

- (BOOL)acceptsFirstResponder {
    DialogEventSetBool(YES);
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
}

- (void)flagsChanged:(NSEvent *)event {
    CUI_ViewSubclassFlagsChanged( self, event );
}

//- (void)updateTrackingAreas {
//    CUI_ViewSubclassUpdateTrackingAreas( self );
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

- (void)awakeFromNib {
    [super awakeFromNib];
    CUI_ViewSubclassAwakeFromNib(self);
}
@end


// Class
Class TextInsertionIndicatorClass( void )
{ return [NSTextInsertionIndicator class]; }

NSTextInsertionIndicator *TextInsertionIndicatorWithTag( NSInteger tag )
{ return (NSTextInsertionIndicator *)CUI_ValidateViewKindOfClass( tag, [NSTextInsertionIndicator class] ); }

BOOL TextInsertionIndicatorExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSTextInsertionIndicator class] ); }

// Configure
NSTextInsertionIndicatorDisplayMode TextInsertionIndicatorDisplayMode( NSInteger tag )
{
    NSTextInsertionIndicator *view = TextInsertionIndicatorWithTag( tag );
    if ( view ) return [view displayMode];
    return 0;
}

void TextInsertionIndicatorSetDisplayMode( NSInteger tag, NSTextInsertionIndicatorDisplayMode displayMode )
{
    NSTextInsertionIndicator *view = TextInsertionIndicatorWithTag( tag );
    if ( view ) [view setDisplayMode:displayMode];
}

NSTextInsertionIndicatorAutomaticModeOptions TextInsertionIndicatorAutomaticModeOptions( NSInteger tag )
{
    NSTextInsertionIndicator *view = TextInsertionIndicatorWithTag( tag );
    if ( view ) return [view automaticModeOptions];
    return 0;
}

void TextInsertionIndicatorSetAutomaticModeOptions( NSInteger tag, NSTextInsertionIndicatorAutomaticModeOptions options )
{
    NSTextInsertionIndicator *view = TextInsertionIndicatorWithTag( tag );
    if ( view ) [view setAutomaticModeOptions:options];
}

NSColor *TextInsertionIndicatorColor( NSInteger tag )
{
    NSTextInsertionIndicator *view = TextInsertionIndicatorWithTag( tag );
    if ( view ) return [view color];
    return nil;
}

void TextInsertionIndicatorSetColor( NSInteger tag, NSColor *col )
{
    NSTextInsertionIndicator *view = TextInsertionIndicatorWithTag( tag );
    if ( view ) [view setColor:col];
}


// Init
NSTextInsertionIndicator *TextInsertionIndicatorInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) rect = NSMakeRect( 20, 20, 20, 20 );

    // subclass
    BOOL subclass = CUI_IsSubclassFlag();

    // init
    NSTextInsertionIndicator *view;
    
#if __has_feature(objc_arc)
    if ( subclass ) {
        view = [[TextInsertionIndicatorSC alloc] initWithFrame:rect];
    } else {
        view = [[NSTextInsertionIndicator alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        view = [[[TextInsertionIndicatorSC alloc] initWithFrame:rect] autorelease];
    } else {
        view = [[[NSTextInsertionIndicator alloc] initWithFrame:rect] autorelease];
    }
#endif
    
    // tag
    [view setIdentifier:[NSString stringWithFormat:@"%ld",(long)inTag]];

    return view;
}


// Statement
void CUI_TextInsertionIndicator( NSInteger inTag, CGRect inRect, long inColor, NSInteger inDisplayMode, NSInteger inAutoModeOptions, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
        
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSTextInsertionIndicator *view = CUI_ViewSubviewWithTag( contentView, inTag );
        
        NSColor *color = CUI_FixColor( inColor );
        
        if ( !view ) {
            view = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( view ) {    // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);
            
            // make sure it's same view class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, view, [NSTextInsertionIndicator class] ) ) {
                return;
            }
            
            // rect
            if ( !NSIsEmptyRect( rect ) ) [view setFrame:rect];
            
            // color
            if ( color ) [view setColor:color];

            // display mode
            if ( inDisplayMode != kFBParamMissing ) [view setDisplayMode:inDisplayMode];
            
            // auto mode options
            if ( inAutoModeOptions != kFBParamMissing ) [view setAutomaticModeOptions:inAutoModeOptions];

        } else {        // create
            // init
            view = TextInsertionIndicatorInit( inTag, inRect );
            
            // default autoresizing
            [view setAutoresizingMask:NSViewMinYMargin];
                        
            // color
            if ( color ) [view setColor:color];
            
            // display mode
            if ( inDisplayMode != kFBParamMissing ) [view setDisplayMode:inDisplayMode];
            
            // auto mode options
            if ( inAutoModeOptions != kFBParamMissing ) [view setAutomaticModeOptions:inAutoModeOptions];

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
        
        if ( show ) {
            [view setDisplayMode:NSTextInsertionIndicatorDisplayModeAutomatic];
        } else {
            [view setDisplayMode:NSTextInsertionIndicatorDisplayModeHidden];
        }
        //[view setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
}

#endif// 140000

