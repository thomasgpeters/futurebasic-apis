/*
 SecureTextField.m

 Bernie Wylde
 */

#import "SecureTextField.h"

@implementation SecureTextFieldSC
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
Class SecureTextFieldClass( void )
{ return [NSSecureTextField class]; }

NSSecureTextField *SecureTextFieldWithTag( NSInteger tag )
{ return (NSSecureTextField *)CUI_ValidateViewKindOfClass( tag, [NSSecureTextField class] ); }

BOOL SecureTextFieldExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSSecureTextField class] ); }


BOOL SecureTextFieldEchosBullets( NSInteger tag )
{
    NSSecureTextField *fld = SecureTextFieldWithTag( tag );
    if ( fld ) [[fld cell] echosBullets];
    return NO;
}

void SecureTextFieldSetEchosBullets( NSInteger tag, BOOL flag )
{
    NSSecureTextField *fld = SecureTextFieldWithTag( tag );
    if ( fld ) [[fld cell] setEchosBullets:flag];
}


// Init
NSSecureTextField *SecureTextFieldInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) rect = NSMakeRect( 20, 20, 96, 22 );
    
    // subclass
    BOOL subclass = CUI_IsSubclassFlag();
    
    // init
    NSSecureTextField *fld;
#if __has_feature(objc_arc)
    if ( subclass ) {
        fld = [[SecureTextFieldSC alloc] initWithFrame:rect];
    } else {
        fld = [[NSSecureTextField alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        fld = [[[SecureTextFieldSC alloc] initWithFrame:rect] autorelease];
    } else {
        fld = [[[NSSecureTextField alloc] initWithFrame:rect] autorelease];
    }
#endif
    
//#if !__has_feature(objc_arc)
//    [fld autorelease];
//#endif
    
    // tag
    [fld setTag: inTag];
    
    // fix font to match I.B.
    CUI_ControlFixFont( fld );
    
    // delegate
    [fld setDelegate:CUI_TextFieldDelegateObj()];

    return fld;
}



void CUI_SecureTextField( NSInteger inTag, NSInteger inEnabled, CFStringRef inText, CGRect inRect, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSString *text = (__bridge NSString *)inText;
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSSecureTextField *fld = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !fld ) {
            fld = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( fld ) {    // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            // make sure it's correct class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, fld, [NSSecureTextField class] ) ) {
                return;
            }

            // enabled
            if ( inEnabled != kFBParamMissing ) [fld setEnabled:(BOOL)inEnabled];
            
            // text
            if ( text ) [fld setStringValue:text];
            
            // rect
            if ( !NSIsEmptyRect( rect ) ) [fld setFrame:rect];
            
        } else {        // create
            // init
            fld = SecureTextFieldInit( inTag, inRect );
            
            // default autoresizing
            [fld setAutoresizingMask:NSViewMinYMargin];
            
            // enabled
            if ( inEnabled != kFBParamMissing ) [fld setEnabled:(BOOL)inEnabled];
            
            // text
            if ( text ) [fld setStringValue:text];
            
            // wndTag
            [fld setWndTag:inWndTag];
            
            // add to window/popover/superview
            id superview = CUI_CurrentSuperview();
            if ( superview ) {
                [superview addSubview:fld];
            } else {
                [contentView addSubview:fld];
            }

        }
        
        [fld setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
}

