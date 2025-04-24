/*
 Button.m
 
 Bernie Wylde
 */

#import "Button.h"

#pragma mark - subclass
@implementation ButtonSC
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

#pragma mark - functions
// Class
Class ButtonClass( void )
{ return [NSButton class]; }

NSButton *ButtonWithTag( NSInteger tag )
{ return (NSButton *)CUI_ValidateViewKindOfClass( tag, [NSButton class] ); }

BOOL ButtonExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSButton class] ); }

NSButtonType ButtonType( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) {
        return [(__bridge id)ObjectProperty( btn, (__bridge CFStringRef)@"ButtonType" ) integerValue];
    }
    return 0;
}

void ButtonSetType( NSInteger tag, NSButtonType type )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) {
        [btn setButtonType:type];
        ObjectPropertySet( btn, (__bridge CFStringRef)@"ButtonType", @(type) );
    }
}

void ButtonGetPeriodicDelay( NSInteger tag, float *delay, float *interval )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn getPeriodicDelay:delay interval:interval];
}

CFStringRef ButtonAlternateTitle( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return (__bridge CFStringRef)[btn alternateTitle];
    return nil;
}

CFAttributedStringRef ButtonAttributedTitle( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return (__bridge CFAttributedStringRef)[btn attributedTitle];
    return nil;
}


CFAttributedStringRef ButtonAttributedAlternateTitle( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return (__bridge CFAttributedStringRef)[btn attributedAlternateTitle];
    return nil;
}

void ButtonSetTitle( NSInteger tag, CFStringRef title )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn setTitle:(__bridge NSString *)title];
}

NSSound *ButtonSound( NSInteger tag)
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return [btn sound];
    return nil;
}

NSImage *ButtonImage( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return [btn image];
    return nil;
}

NSImage *ButtonAlternateImage( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return [btn alternateImage];
    return nil;
}

NSCellImagePosition ButtonImagePosition( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return [btn imagePosition];
    return 0;
}

BOOL ButtonIsBordered( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return [btn isBordered];
    return NO;
}

BOOL ButtonIsTransparent( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return [btn isTransparent];
    return NO;
}

NSBezelStyle ButtonBezelStyle( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return [btn bezelStyle];
    return 0;
}

void ButtonSetBezelStyle( NSInteger tag, NSBezelStyle style )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn setBezelStyle:style];
}

NSColor *ButtonBezelColor( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return [btn bezelColor];
    return nil;
}

void ButtonSetBezelColor( NSInteger tag, NSColor *col )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn setBezelColor:col];
}

BOOL ButtonShowsBorderOnlyWhileMouseInside( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return [btn showsBorderOnlyWhileMouseInside];
    return NO;
}

BOOL ButtonImageHugsTitle( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return [btn imageHugsTitle];
    return NO;
}

void ButtonSetImageHugsTitle( NSInteger tag, BOOL flag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn setImageHugsTitle:flag];
}

NSImageScaling ButtonImageScaling( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return [[btn cell] imageScaling];
    return 0;
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
NSImageSymbolConfiguration *ButtonSymbolConfiguration( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return [btn symbolConfiguration];
    return nil;
}

void ButtonSetSymbolConfiguration( NSInteger tag, NSImageSymbolConfiguration *config )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn setSymbolConfiguration:config];
}
#endif// 110000

BOOL ButtonAllowsMixedState( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return [btn allowsMixedState];
    return NO;
}

void ButtonSetState( NSInteger tag, NSCellStateValue state )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn setState:state];
}

CFStringRef ButtonKeyEquivalent( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return (__bridge CFStringRef)[btn keyEquivalent];
    return nil;
}

NSUInteger ButtonKeyEquivalentModifierMask( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return [btn keyEquivalentModifierMask];
    return 0;
}

BOOL ButtonPerformKeyEquivalent( NSInteger tag, NSEvent *key )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return [btn performKeyEquivalent:key];
    return 0;
}

NSCellStateValue ButtonState( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return [btn state];
    return 0;
}

CFStringRef ButtonTitle( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return (__bridge CFStringRef)[btn title];
    return NULL;
}

void ButtonSetSound( NSInteger tag, NSSound *snd )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn setSound:snd];
}

void ButtonSetSoundNamed( NSInteger tag, CFStringRef sndName )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn setSound:[NSSound soundNamed:(__bridge NSString *)sndName]];
}

BOOL ButtonIsSpringLoaded( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return [btn isSpringLoaded];
    return NO;
}

void ButtonSetSpringLoaded( NSInteger tag, BOOL flag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn setSpringLoaded:flag];
}

NSInteger ButtonMaxAcceleratorLevel( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return [btn maxAcceleratorLevel];
    return 0;
}

void ButtonSetMaxAcceleratorLevel( NSInteger tag, NSInteger level )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn setMaxAcceleratorLevel:level];
}

void ButtonSetKeyEquivalent( NSInteger tag, CFStringRef key )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn setKeyEquivalent:(__bridge NSString *)key];
}

void ButtonSetKeyEquivalentModifierMask( NSInteger tag, NSUInteger mask )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn setKeyEquivalentModifierMask:mask];
}

void ButtonSetImage( NSInteger tag, CFTypeRef inImage )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) {
        NSImage *image = CUI_FixImageValue( inImage );
        [btn setImage:image];
    }
}

void ButtonSetImageNamed( NSInteger tag, CFStringRef imageName )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) {
        NSImage *image = CUI_ImageResource( (__bridge NSString *)imageName );
        if ( image ) [btn setImage:image];
    }
}

void ButtonSetImagePosition( NSInteger tag, NSCellImagePosition position )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn setImagePosition:position];
}

void ButtonSetImageScaling( NSInteger tag, NSImageScaling scaling )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [[btn cell] setImageScaling:scaling];
}

void ButtonSetBordered( NSInteger tag, BOOL flag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn setBordered:flag];
}

void ButtonSetShowsBorderOnlyWhileMouseInside( NSInteger tag, BOOL flag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn setShowsBorderOnlyWhileMouseInside:flag];
}

void ButtonPerformClick( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn performClick:nil];
}

void ButtonSetAttributedTitle( NSInteger tag, CFAttributedStringRef title )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn setAttributedTitle:(__bridge NSAttributedString *)title];
}

void ButtonSetAlternateTitle( NSInteger tag, CFStringRef title )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn setAlternateTitle:(__bridge NSString *)title];
}

void ButtonSetPeriodicDelay( NSInteger tag, float delay, float interval )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn setPeriodicDelay:delay interval:interval];
}

void ButtonSetAttributedAlternateTitle( NSInteger tag, CFAttributedStringRef title )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn setAttributedAlternateTitle:(__bridge NSAttributedString *)title];
}

void ButtonSetAlternateImage( NSInteger tag, CFTypeRef inImage )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) {
        NSImage *image = CUI_FixImageValue( inImage );
        [btn setAlternateImage:image];
    }
}

void ButtonSetAlternateImageNamed( NSInteger tag, CFStringRef imageName )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) {
        NSImage *image = CUI_ImageResource( (__bridge NSString *)imageName );
        if ( image ) [btn setAlternateImage:image];
    }
}

void ButtonSetTransparent( NSInteger tag, BOOL flag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn setTransparent:flag];
}

void ButtonSetAllowsMixedState( NSInteger tag, BOOL flag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn setAllowsMixedState:flag];
}

void ButtonSetNextState( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn setNextState];
}

void ButtonHighlight( NSInteger tag, BOOL flag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn highlight:flag];
}

BOOL ButtonIsOpaque( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return [btn isOpaque];
    return NO;
}

void ButtonSetHighlightsBy( NSInteger tag, NSUInteger mask )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [[btn cell] setHighlightsBy:mask];
}


// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
NSColor *ButtonContentTintColor( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return [btn contentTintColor];
    return nil;
}

void ButtonSetContentTintColor( NSInteger tag, NSColor *col )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn setContentTintColor:col];
}
#endif// 101400

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
BOOL ButtonHasDestructiveAction( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return [btn hasDestructiveAction];
    return NO;
}

void ButtonSetHasDestructiveAction( NSInteger tag, BOOL flag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn setHasDestructiveAction:flag];
}
#endif// 110000


// - buttoncell functions -
CFTypeRef ButtonKeyEquivalentFont( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return (__bridge CFTypeRef)[[btn cell] keyEquivalentFont];
    return nil;
}

void ButtonSetKeyEquivalentFont( NSInteger tag, CFTypeRef font )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [[btn cell] setKeyEquivalentFont:(__bridge NSFont *)font];
}


// custom
void ButtonClose( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [btn removeFromSuperview];
}

void ButtonSetTitleColor( NSInteger tag, NSColor *col )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) {
#if __has_feature(objc_arc)
        NSMutableAttributedString *as = [[btn attributedTitle] mutableCopy];
#else
        NSMutableAttributedString *as = [[[btn attributedTitle] mutableCopy] autorelease];
#endif
        [as addAttribute:NSForegroundColorAttributeName value:col range:NSMakeRange(0,[as length])];
        [btn setAttributedTitle:as];
    }
}

void ButtonSetBackgroundColor( NSInteger tag, NSColor *col )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [[btn cell] setBackgroundColor:col];
}

BOOL ButtonImageDimsWhenDisabled( NSInteger tag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) return [[btn cell] imageDimsWhenDisabled];
    return NO;
}

void ButtonSetImageDimsWhenDisabled( NSInteger tag, BOOL flag )
{
    NSButton *btn = ButtonWithTag( tag );
    if ( btn ) [[btn cell] setImageDimsWhenDisabled:flag];
}


// Init
NSButton *ButtonInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) {
        rect = NSMakeRect( 14, 13, 81, 32 );
    }

    // subclass
    BOOL subclass = CUI_IsSubclassFlag();
    
    // init
    NSButton *btn;
#if __has_feature(objc_arc)
    if ( subclass ) {
        btn = [[ButtonSC alloc] initWithFrame:rect];
    } else {
        btn = [[NSButton alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        btn = [[[ButtonSC alloc] initWithFrame:rect] autorelease];
    } else {
        btn = [[[NSButton alloc] initWithFrame:rect] autorelease];
    }
#endif
    
    // tag
    [btn setTag:inTag];
    
    // style
    [btn setBezelStyle:NSRoundedBezelStyle];

    // type
    [btn setButtonType:NSMomentaryLightButton];

    // font
    CUI_ControlFixFont( btn );

    // target/action
    [btn setTarget:CUI_ControlTargetObj()];
    [btn setAction:@selector(controlAction:)];
    
    return btn;
}

#pragma mark - button statement
#if 1// attributed title

void CUI_Button( NSInteger inTag, NSInteger inEnabled, NSInteger inState, CFTypeRef inTitle, CGRect inRect, NSInteger inType, NSInteger inStyle, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    //BOOL wndTagFlag = inWndTag != kFBParamMissing; // 20250226
    
    NSString *title = nil;
    NSAttributedString *attrTitle = nil;
    
    if ( inTitle ) {
        if ( CFGetTypeID(inTitle) == CFStringGetTypeID() ) {
            title = (__bridge NSString *)inTitle;
        } else if ( CFGetTypeID(inTitle) == CFAttributedStringGetTypeID() ) {
            attrTitle = (__bridge NSAttributedString *)inTitle;
        }
    }
    
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        
        NSButton *btn = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !btn ) {
            btn = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( btn ) {    // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);
            
//            if ( wndTagFlag ) { // 20250226
//                if ( !CUI_ValidateViewClass( inWndTag, inTag, btn, [NSButton class] ) ) {
//                    return;
//                }
//            } else {
//                // make sure it's same view class. if not, search all windows; front to back
//                btn = CUI_ViewWithKindOfClassInAnyWindow( inTag, [NSButton class] ); // 20250217
//                if ( btn ) {
//                    inWndTag = [[btn window] tag];
//                } else {
//                    return;
//                }
//            }

            // make sure it's same view class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, btn, [NSButton class] ) ) {
                return;
            }

            // enabled
            if ( inEnabled != kFBParamMissing ) [btn setEnabled:(BOOL)inEnabled];
            
            // state
            if ( inState != kFBParamMissing ) {
                if ( inState == NSMixedState ) [btn setAllowsMixedState:YES];
                [btn setState:inState];
            }
            
            // title
            if ( title ) [btn setTitle:title];
            if ( attrTitle ) [btn setAttributedTitle:attrTitle];
            
            // rect
            if ( !NSIsEmptyRect( rect ) ) [btn setFrame:rect];
            
            // type
            if ( inType != kFBParamMissing ) {
                [btn setButtonType:inType];
                ObjectPropertySet( btn, (__bridge CFStringRef)@"ButtonType", @(inType) );
            }
            
            // style
            if ( inStyle != kFBParamMissing ) [btn setBezelStyle:inStyle];
            
        } else {        // create
            btn = ButtonInit( inTag, inRect );
            
            // default autoresizing
            [btn setAutoresizingMask:NSViewMinYMargin];
            
            // state
            if ( inState != kFBParamMissing ) {
                if ( inState == NSMixedState ) [btn setAllowsMixedState:YES];
                [btn setState:inState];
            }
            
            // enabled
            if ( inEnabled != kFBParamMissing ) [btn setEnabled:(BOOL)inEnabled];
            
            // type
            if ( inType == kFBParamMissing ) inType = NSMomentaryLightButton;
            [btn setButtonType:inType];
            ObjectPropertySet( btn, (__bridge CFStringRef)@"ButtonType", @(inType) );

            // style
            if ( inStyle == kFBParamMissing ) inStyle = NSRoundedBezelStyle;
            [btn setBezelStyle:inStyle];
            
            switch ( inStyle ) {
                case NSHelpButtonBezelStyle:
                    if ( !title ) title = @"";
                    break;
                case NSRecessedBezelStyle:
                    [btn setShowsBorderOnlyWhileMouseInside:YES];
                    break;
                default:
                    break;
            }
            
            // title
            if ( title ) {
                [btn setTitle:title];
                if ( inStyle == NSRoundedBezelStyle ) {
                    if ( inType == NSMomentaryLightButton || inType == NSMomentaryPushInButton ) {
                        if ( [title isEqualToString:@"OK"] ) [btn setKeyEquivalent:@"\r"];
                        if ( [title isEqualToString:@"Cancel"] ) [btn setKeyEquivalent:@"\033"];
                    }
                    if ( inType == NSButtonTypeAccelerator || inType == NSButtonTypeMultiLevelAccelerator ) {
                        if ( [title isEqualToString:@"OK"] ) [btn setKeyEquivalent:@"\r"];;
                        if ( [title isEqualToString:@"Cancel"] ) [btn setKeyEquivalent:@"\033"];
                    }
                }
            } else if ( attrTitle ) {
                [btn setAttributedTitle:attrTitle];
                if ( inStyle == NSRoundedBezelStyle ) {
                    if ( inType == NSMomentaryLightButton || inType == NSMomentaryPushInButton ) {
                        if ( [[attrTitle string] isEqualToString:@"OK"] ) [btn setKeyEquivalent:@"\r"];
                        if ( [[attrTitle string] isEqualToString:@"Cancel"] ) [btn setKeyEquivalent:@"\033"];
                    }
                    if ( inType == NSButtonTypeAccelerator || inType == NSButtonTypeMultiLevelAccelerator ) {
                        if ( [[attrTitle string] isEqualToString:@"OK"] ) [btn setKeyEquivalent:@"\r"];;
                        if ( [[attrTitle string] isEqualToString:@"Cancel"] ) [btn setKeyEquivalent:@"\033"];
                    }
                }
            }

            // wndTag
            [btn setWndTag:inWndTag];
            
            // fix font
            switch ( inStyle ) {
                case NSRoundRectBezelStyle:
                    [btn setFont:[NSFont systemFontOfSize:12]];
                    break;
                case NSRecessedBezelStyle:
                    [[btn cell] setControlSize:NSSmallControlSize];
                    [btn setFont:[NSFont boldSystemFontOfSize:12]];
                    break;
                    
                case NSInlineBezelStyle:
                    [btn setFont:[NSFont boldSystemFontOfSize:11]];
                    break;
                    
                default:
                    CUI_ControlFixFont( btn );
                    break;
            }
            
            // add to window/popover/superview
            id superview = CUI_CurrentSuperview();
            if ( superview ) {
                [superview addSubview:btn];
            } else {
                [contentView addSubview:btn];
            }
        }
        
        [btn setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
}

void CUI_Checkbox( NSInteger inTag, NSInteger inEnabled, NSInteger inState, CFTypeRef inTitle, CGRect inRect, NSInteger inWndTag )
{ CUI_Button( inTag, inEnabled, inState, inTitle, inRect, NSSwitchButton, kFBParamMissing, inWndTag ); }

void CUI_RadioButton( NSInteger inTag, NSInteger inEnabled, NSInteger inState, CFTypeRef inTitle, CGRect inRect, NSInteger inWndTag )
{ CUI_Button( inTag, inEnabled, inState, inTitle, inRect, NSRadioButton, kFBParamMissing, inWndTag ); }

#else// attributed title

void CUI_Button( NSInteger inTag, NSInteger inEnabled, NSInteger inState, CFStringRef inTitle, CGRect inRect, NSInteger inType, NSInteger inStyle, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSString *title = (__bridge NSString *)inTitle;
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        
        NSButton *btn = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !btn ) {
            btn = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( btn ) {    // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            // make sure it's same view class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, btn, [NSButton class] ) ) {
                return;
            }

            // enabled
            if ( inEnabled != kFBParamMissing ) [btn setEnabled:(BOOL)inEnabled];
            
            // state
            if ( inState != kFBParamMissing ) {
                if ( inState == NSMixedState ) [btn setAllowsMixedState:YES];
                [btn setState:inState];
            }
            
            // title
            if ( title ) [btn setTitle:title];
            
            // rect
            if ( !NSIsEmptyRect( rect ) ) [btn setFrame:rect];
            
            // type
            if ( inType != kFBParamMissing ) {
                [btn setButtonType:inType];
            }
            
            // style
            if ( inStyle != kFBParamMissing ) [btn setBezelStyle:inStyle];
            
        } else {        // create
            btn = ButtonInit( inTag, inRect );
            
            // default autoresizing
            [btn setAutoresizingMask:NSViewMinYMargin];
            
            // state
            if ( inState != kFBParamMissing ) {
                if ( inState == NSMixedState ) [btn setAllowsMixedState:YES];
                [btn setState:inState];
            }
            
            // enabled
            if ( inEnabled != kFBParamMissing ) [btn setEnabled:(BOOL)inEnabled];
            
            // type
            if ( inType == kFBParamMissing ) inType = NSMomentaryLightButton;
            [btn setButtonType:inType];

            // style
            if ( inStyle == kFBParamMissing ) inStyle = NSRoundedBezelStyle;
            [btn setBezelStyle:inStyle];
            
            switch ( inStyle ) {
                case NSHelpButtonBezelStyle:
                    if ( !title ) title = @"";
                    break;
                case NSRecessedBezelStyle:
                    [btn setShowsBorderOnlyWhileMouseInside:YES];
                    break;
                default:
                    break;
            }
            
            // title
            if ( title ) {
                [btn setTitle:title];
                if ( inStyle == NSRoundedBezelStyle ) {
                    if ( inType == NSMomentaryLightButton || inType == NSMomentaryPushInButton ) {
                        if ( [title isEqualToString:@"OK"] ) [btn setKeyEquivalent:@"\r"];
                        if ( [title isEqualToString:@"Cancel"] ) [btn setKeyEquivalent:@"\033"];
                    }
                    if ( inType == NSButtonTypeAccelerator || inType == NSButtonTypeMultiLevelAccelerator ) {
                        if ( [title isEqualToString:@"OK"] ) [btn setKeyEquivalent:@"\r"];;
                        if ( [title isEqualToString:@"Cancel"] ) [btn setKeyEquivalent:@"\033"];
                    }
                }
            }
            
            // wndTag
            [btn setWndTag:inWndTag];
            
            // fix font
            switch ( inStyle ) {
                case NSRoundRectBezelStyle:
                    [btn setFont:[NSFont systemFontOfSize:12]];
                    break;
                case NSRecessedBezelStyle:
                    [[btn cell] setControlSize:NSSmallControlSize];
                    [btn setFont:[NSFont boldSystemFontOfSize:12]];
                    break;
                    
                case NSInlineBezelStyle:
                    [btn setFont:[NSFont boldSystemFontOfSize:11]];
                    break;
                    
                default:
                    CUI_ControlFixFont( btn );
                    break;
            }
            
            // add to window/popover/superview
            id superview = CUI_CurrentSuperview();
            if ( superview ) {
                [superview addSubview:btn];
            } else {
                [contentView addSubview:btn];
            }
        }
        
        [btn setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
}

void CUI_Checkbox( NSInteger inTag, NSInteger inEnabled, NSInteger inState, CFStringRef inTitle, CGRect inRect, NSInteger inWndTag )
{ CUI_Button( inTag, inEnabled, inState, inTitle, inRect, NSSwitchButton, kFBParamMissing, inWndTag ); }

void CUI_RadioButton( NSInteger inTag, NSInteger inEnabled, NSInteger inState, CFStringRef inTitle, CGRect inRect, NSInteger inWndTag )
{ CUI_Button( inTag, inEnabled, inState, inTitle, inRect, NSRadioButton, kFBParamMissing, inWndTag ); }

#endif// attributed title




#pragma mark - radiogroup
@implementation CUI_RadioGroup

- (void)drawRect:(NSRect)dirtyRect {
    if ( ![self suspendDrawRect] ) {
        CUI_ViewSubclassDrawRect( self, dirtyRect );
        if ( !DialogEventBool() ) [super drawRect:dirtyRect];
    }
}

// actions
- (void)btnAction:(id)sender {
    CUI_ControlCallUserDefinedOnDialogOrCallback( 1, self, nil );
}
@end


//@implementation CUI_RadioGroupSC
//- (void)drawRect:(NSRect)dirtyRect {
//    if ( ![self suspendDrawRect] ) {
//        CUI_ViewSubclassDrawRect( self, dirtyRect );
//        if ( !DialogEventBool() ) [super drawRect:dirtyRect];
//    }
//}
//
//- (BOOL)acceptsFirstResponder {
//    DialogEventSetBool(NO);
//    return CUI_ResponderAcceptsFirstResponder( self );
//}
//
//- (void)mouseDown:(NSEvent *)event {
//    DialogEventSetBool(NO);
//    CUI_ResponderMouseDown( self, event );
//    if ( !DialogEventBool() ) [super mouseDown:event];
//}
//
//- (void)mouseUp:(NSEvent *)event {
//    DialogEventSetBool(NO);
//    CUI_ResponderMouseUp( self, event );
//    if ( !DialogEventBool() ) [super mouseUp:event];
//}
//
//- (void)mouseEntered:(NSEvent *)event {
//    CUI_ResponderMouseEntered( self, event );
//}
//
//- (void)mouseExited:(NSEvent *)event {
//    CUI_ResponderMouseExited( self, event );
//}
//
//- (void)mouseDragged:(NSEvent *)event {
//    [super mouseDragged:event];
//    DialogEventSetBool(NO);
//    CUI_ResponderMouseDragged( self, event );
//}
//
//- (void)mouseMoved:(NSEvent *)event {
//    DialogEventSetBool(NO);
//    CUI_ViewSubclassMouseMoved( self, event );
//    if ( !DialogEventBool() ) [super mouseMoved:event];
//}
//
//- (void)rightMouseDown:(NSEvent *)event {
//    CUI_ViewSubclassRightMouseDown( self, event );
//    if ( !DialogEventBool() ) [super rightMouseDown:event];
//}
//
//- (void)rightMouseUp:(NSEvent *)event {
//    CUI_ViewSubclassRightMouseUp( self, event );
//}
//
//- (void)rightMouseDragged:(NSEvent *)event {
//    CUI_ViewSubclassRightMouseDragged( self, event );
//}
//
//- (void)keyDown:(NSEvent *)event {
//    CUI_ViewSubclassKeyDown( self, event );
//    if ( !DialogEventBool() ) [super keyDown:event];
//}
//
//- (void)keyUp:(NSEvent *)event {
//    CUI_ViewSubclassKeyUp( self, event );
//}
//
//- (void)flagsChanged:(NSEvent *)event {
//    CUI_ViewSubclassFlagsChanged( self, event );
//}
//
//- (void)updateTrackingAreas {
//    NSArray *areas = [self trackingAreas];
//    if ( [areas count] > 0 ) {
//        NSTrackingArea *trackingArea = [areas objectAtIndex:0];
//        [self removeTrackingArea:trackingArea];
//        
//        [trackingArea release];// ????
//        
//        NSTrackingAreaOptions options = NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow | NSTrackingInVisibleRect;
//        trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds] options:options owner:self userInfo:nil];
//        [self addTrackingArea:trackingArea];
//    }
//}
//
//- (void)resetCursorRects {
//    CUI_ViewSubclassResetCursorRects( self );
//}
//
//#pragma mark - dragging
//- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
//    return CUI_ViewSubclassDraggingEntered( self, sender );
//}
//
//- (void)draggingExited:(id <NSDraggingInfo>)sender {
//    CUI_ViewSubclassDraggingExited( self, sender );
//}
//
//- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
//    return CUI_ViewSubclassPerformDragOperation( self, sender );
//}
//
//- (void)viewDidChangeEffectiveAppearance {
//    CUI_ViewSubclassViewDidChangeEffectiveAppearance( self );
//}
//
//#pragma mark - flipped
//- (BOOL)isFlipped {
//    return self.flipFlag;
//}
//
//#pragma mark - menu
//- (NSMenu *)menuForEvent:(NSEvent*)theEvent {
//    CUI_ViewSubclassMenuForEvent( self, theEvent );
//    return DialogEventNSMenu();
//}
//
//#pragma mark - layer
//- (BOOL)wantsUpdateLayer {
//    return CUI_ViewSubclassWantsUpdateLayer( self );
//}
//
//- (void)updateLayer {
//    CUI_ViewSubclassUpdateLayer( self );
//}
//
//- (void)awakeFromNib {
//    CUI_ViewSubclassAwakeFromNib( self );
//}
//@end

NSButton *CUI_RadioGroupButtonAtIndex( NSInteger tag, NSUInteger index )
{
    CUI_RadioGroup *group = RadioGroupWithTag( tag );
    if ( group ) {
        NSArray *buttons = [group subviews];
        NSUInteger count = [buttons count];
        if ( index > 0 && index <= count ) {
            return buttons[index-1];
        }
    }
    return nil;
}

CUI_RadioGroup *RadioGroupWithTag( NSInteger tag )
{ return (CUI_RadioGroup *)CUI_ValidateViewKindOfClass( tag, [CUI_RadioGroup class] ); }


// Configure group
BOOL RadioGroupIsEnabled( NSInteger tag )
{
    BOOL flag = NO;
    CUI_RadioGroup *group = RadioGroupWithTag( tag );
    if ( group ) {
        NSArray *buttons = [group subviews];
        for ( NSButton *btn in buttons ) {
            if ( [btn isEnabled] ) {
                flag = YES;
                break;
            }
        }
    }
    return flag;
}

void RadioGroupSetEnabled( NSInteger tag, BOOL flag )
{
    CUI_RadioGroup *group = RadioGroupWithTag( tag );
    if ( group ) {
        NSArray *buttons = [group subviews];
        for ( NSButton *btn in buttons ) {
            [btn setEnabled:flag];
        }
    }
}

NSInteger RadioGroupIndex( NSInteger tag )
{
    CUI_RadioGroup *group = RadioGroupWithTag( tag );
    if ( group ) {
        NSArray *buttons = [group subviews];
        for ( NSButton *btn in buttons ) {
            if ( [btn state] == NSOnState ) return [[btn identifier] integerValue];
        }
    }
    return 0;
}

void RadioGroupSetIndex( NSInteger tag, NSUInteger index )
{
    CUI_RadioGroup *group = RadioGroupWithTag( tag );
    if ( group ) {
        NSArray *buttons = [group subviews];
        NSUInteger count = [buttons count];
        for ( NSUInteger i = 0; i < count; i++ ) {
            if ( (i+1) == index ) {
                [(NSButton *)buttons[i] setState:NSOnState];
                break;
            }
        }
    }
}

// Buttons
NSButton *RadioGroupButtonAtIndex( NSInteger tag, NSUInteger index )
{ return CUI_RadioGroupButtonAtIndex( tag, index ); }

BOOL RadioGroupButtonIsEnabled( NSInteger tag, NSUInteger index )
{
    NSButton *btn = CUI_RadioGroupButtonAtIndex( tag, index );
    if ( btn ) return [btn isEnabled];
    return NO;
}

void RadioGroupButtonSetEnabled( NSInteger tag, NSUInteger index, BOOL flag )
{
    NSButton *btn = CUI_RadioGroupButtonAtIndex( tag, index );
    if ( btn ) [btn setEnabled:flag];
}

BOOL RadioGroupButtonIsHidden( NSInteger tag, NSUInteger index )
{
    NSButton *btn = CUI_RadioGroupButtonAtIndex( tag, index );
    if ( btn ) return [btn isHidden];
    return NO;
}

void RadioGroupButtonSetHidden( NSInteger tag, NSUInteger index, BOOL flag )
{
    NSButton *btn = CUI_RadioGroupButtonAtIndex( tag, index );
    if ( btn ) [btn setHidden:flag];
}

CFStringRef RadioGroupButtonTitle( NSInteger tag, NSUInteger index )
{
    NSButton *btn = CUI_RadioGroupButtonAtIndex( tag, index );
    if ( btn ) return (__bridge CFStringRef)[btn title];
    return nil;
}

void RadioGroupButtonSetTitle( NSInteger tag, NSUInteger index, CFStringRef title )
{
    NSButton *btn = CUI_RadioGroupButtonAtIndex( tag, index );
    if ( btn ) [btn setTitle:(__bridge NSString *)title];
}


void CUI_RadioGroupStatement( NSInteger inTag, NSInteger inEnabled, NSInteger inIndex, CFTypeRef inTitles, NSInteger inRows, NSInteger inCols, NSInteger inSize, CGSize inSpacing, CGPoint inOrigin, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
        
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        CUI_RadioGroup *group = CUI_ViewSubviewWithTag( contentView, inTag );
        
        // titles
        NSArray *titles = nil;
        if ( inTitles ) {
            if ( CFGetTypeID(inTitles) == CFStringGetTypeID() ) {
                titles = [(__bridge NSString *)inTitles componentsSeparatedByString:@";"];
            } else if ( CFGetTypeID(inTitles) == CFArrayGetTypeID() ) {
                titles = (__bridge NSArray *)inTitles;
            }
        }
        
        NSInteger count = (NSInteger)[titles count];

        if ( !group ) {
            group = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( group ) { // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            NSArray *buttons = [group subviews];
            NSInteger count = (NSInteger)[buttons count];

            // enabled
            if ( inEnabled != kFBParamMissing ) RadioGroupSetEnabled( inTag, inEnabled );
                
            // index
            if ( inIndex != kFBParamMissing && inIndex > 0 && inIndex <= count ) {
                [(NSButton *)buttons[(NSUInteger)inIndex-1] setState:NSOnState];
            }
            
        } else {       // create
            // subclass
            //BOOL subclass = CUI_IsSubclassFlag();
            
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            // init
            CUI_RadioGroup *group;
#if __has_feature(objc_arc)
            //            if ( subclass ) {
            //                group = [[CUI_RadioGroupSC alloc] init];
            //            } else {
                            group = [[CUI_RadioGroup alloc] init];
             //           }
#else
//            if ( subclass ) {
//                group = [[[CUI_RadioGroupSC alloc] init] autorelease];
//            } else {
                group = [[[CUI_RadioGroup alloc] init] autorelease];
 //           }
#endif
            
            [[(NSWindow *)w contentView] addSubview:group];
            
            // tag
            [group setIdentifier:[NSString stringWithFormat:@"%ld",(long)inTag]];
            
            // index
            //if ( inIndex < 1 || inIndex >= count ) inIndex = 1;

            // rows, cols
            //BOOL colsHasPriority = NO;
            if ( inRows == kFBParamMissing && inCols == kFBParamMissing ) {
                inRows = count;
                inCols = 1;
            } else {
                if ( inRows == kFBParamMissing ) {
                    //inRows = ceil((double)count/inCols);
                    //inRows = (NSInteger)ceil((double)count / inCols);
                    double temp = ceil((double)count / inCols);
                    inRows = (NSInteger)temp;
                    
                    //colsHasPriority = YES;
                } else if ( inCols == kFBParamMissing ) {
                    //inCols = ceil((double)count / inRows);
                    //inCols = (NSInteger)ceil((double)count / inRows);
                    double temp = ceil((double)count / inRows);
                    inCols = (NSInteger)temp;
                }
            }
            
//            if ( colsHasPriority ) {// calc num rows in each column
//                long rowCount[inCols];
//                BlockZero( &rowCount, sizeof(long)*inCols );
//                long col = 0;
//                for ( long i = 0; i < count; i++ ) {
//                    rowCount[col]++;
//                    col++;
//                    if ( col >= inCols ) col = 0;
//                    NSLog(@"col: %ld",col);
//
//                }
//                
//                for ( long j = 0; j < inCols; j++ ) {
//                    NSLog(@"%ld",rowCount[j]);
//                }
//            }
            
            // size
            NSControlSize size = (NSControlSize)inSize;
            if ( inSize == kFBParamMissing ) size = NSRegularControlSize;
            
            // spacing
            NSSize spacing = NSSizeFromCGSize(inSpacing);
            if ( NSEqualSizes(spacing,NSZeroSize) ) spacing = NSMakeSize(0,0);
            
            // origin
            NSPoint origin = NSPointFromCGPoint(inOrigin);
            if ( NSEqualPoints(origin,NSZeroPoint) ) origin = NSMakePoint(18,19);

            // default autoresizing
            [(NSView *)group setAutoresizingMask:NSViewMinYMargin];

            // get required size of radiogroup and add radiobuttons
            CGFloat btnWidth = 0.0;
            CGFloat btnHeight = 0.0;
            NSUInteger count = [titles count];
             
            // enabled
            BOOL enabled = YES;
            if ( inEnabled != kFBParamMissing ) enabled = inEnabled;

            for ( NSUInteger i = 0; i < count; i++ ) {
                NSButton *btn = [[NSButton alloc] init];
                [btn setButtonType:NSRadioButton];
                [btn setTitle:titles[i]];
                [btn setIdentifier:[NSString stringWithFormat:@"%ld",(long)i+1]];
                [btn setEnabled:enabled];
                [btn setControlSize:size];
                if ( i == (NSUInteger)-1 ) [btn setState:NSOnState];
                [btn sizeToFit];
                NSRect bounds = [btn bounds];
                if ( bounds.size.width > btnWidth ) btnWidth = bounds.size.width;
                btnHeight = bounds.size.height;
                [btn setTarget:group];
                [btn setAction:@selector(btnAction:)];
                [group addSubview:btn];
                if ( [(NSString *)titles[i] isEqualToString:@"-"] ) [btn setHidden:YES];
            }
            
            NSRect r = NSMakeRect( origin.x, origin.y, (btnWidth * inCols) + spacing.width * (inCols-1), btnHeight * inRows + spacing.height * (inRows-1) );
            [group setFrame:r];
            
            CGFloat yTop = r.size.height - btnHeight;
            CGFloat xInc = btnWidth + spacing.width;
            CGFloat yInc = btnHeight + spacing.height;
            
            NSInteger rowNum = 1, colNum = 1;
            CGFloat x = 0;
            CGFloat y = yTop;

            NSArray *buttons = [group subviews];
            
//            count = [buttons count];
//            for ( NSInteger i = 0; i < count; i++ ) {
//                NSButton *btn = buttons[i];
//                [btn setFrameOrigin:NSMakePoint(x,y)];
//                if ( colNum > inCols ) [btn setHidden:YES];
//                rowNum++;
//                if ( rowNum > inRows ) {
//                    x += xInc;
//                    y = yTop;
//                    rowNum = 1;
//                    colNum++;
//                } else {
//                    y -= yInc;
//                }
//            }
            
            for ( NSButton *btn in buttons ) {
                [btn setFrameOrigin:NSMakePoint(x,y)];
                if ( colNum > inCols ) [btn setHidden:YES];
                rowNum++;
                if ( rowNum > inRows ) {
                    x += xInc;
                    y = yTop;
                    rowNum = 1;
                    colNum++;
                } else {
                    y -= yInc;
                }
            }
            
            // wndTag
            [group setWndTag:inWndTag];
            
            // if superview flag set, add view to superview stack
            if ( CUI_IsSuperview() ) CUI_AddSuperview( group );
        }
        
        [group setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
}

