/*
 Switch.m

 Bernie Wylde
 */

#import "Switch.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500

@implementation SwitchSC

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

// Class
Class SwitchClass( void )
{ return [NSSwitch class]; }

NSSwitch *SwitchWithTag( NSInteger tag )
{ return (NSSwitch *)CUI_ValidateViewKindOfClass( tag, [NSSwitch class] ); }

BOOL SwitchExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSSwitch class] ); }

// State
NSControlStateValue SwitchState( NSInteger tag )
{
    NSSwitch *c = SwitchWithTag( tag );
    if ( c ) return [c state];
    return 0;
}

void SwitchSetState( NSInteger tag, NSControlStateValue state )
{
    NSSwitch *c = SwitchWithTag( tag );
    if ( c ) [c setState:state];
}


// Init
NSSwitch *SwitchInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) rect = NSMakeRect( 18, 18, 42, 24 );
    
    // subclass
    BOOL subclass = CUI_IsSubclassFlag();
    
    // init
    NSSwitch *c;
#if __has_feature(objc_arc)
    if ( subclass ) {
        c = [[SwitchSC alloc] initWithFrame:rect];
    } else {
        c = [[NSSwitch alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        c = [[[SwitchSC alloc] initWithFrame:rect] autorelease];
    } else {
        c = [[[NSSwitch alloc] initWithFrame:rect] autorelease];
    }
#endif
    
    // tag
    [c setTag:inTag];
    
    // target/action
    [c setTarget:CUI_ControlTargetObj()];
    [c setAction:@selector(controlAction:)];
    
    return c;
}


void CUI_Switch( NSInteger inTag, NSInteger inEnabled, NSControlStateValue inState, CGRect inRect, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSSwitch *c = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !c ) {
            c = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( c ) {      // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            // make sure it's correct class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, c, [NSSwitch class] ) ) {
                return;
            }

            // enabled
            if ( inEnabled != kFBParamMissing ) [c setEnabled:(BOOL)inEnabled];
            
            // state
            if ( inState != kFBParamMissing ) [c setState:inState];
        
            // rect
            if ( !NSIsEmptyRect( rect ) ) [c setFrame:rect];
            
        } else {
            // init
            c = SwitchInit( inTag, inRect );
            
            // default autoresizing
            [c setAutoresizingMask:NSViewMinYMargin];
            
            // enabled
            if ( inEnabled != kFBParamMissing ) [c setEnabled:(BOOL)inEnabled];
            
            // state
            if ( inState != kFBParamMissing ) [c setState:inState];
            
            // wndTag
            [c setWndTag:inWndTag];
                        
            // add to window/popover/superview
            id superview = CUI_CurrentSuperview();
            if ( superview ) {
                [superview addSubview:c];
            } else {
                [contentView addSubview:c];
            }

        }
        
        [c setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
}

#endif  // 101500
