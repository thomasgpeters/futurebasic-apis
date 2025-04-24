/*
 ComboButton.m
 
 Bernie Wylde
 */

#import "ComboButton.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000

#pragma mark - subclass
@implementation ComboButtonSC
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
Class ComboButtonClass( void )
{ return [NSComboButton class]; }

API_AVAILABLE(macos(13.0))
NSComboButton *ComboButtonWithTag( NSInteger tag )
{ return (NSComboButton *)CUI_ValidateViewKindOfClass( tag, [NSComboButton class] ); }

BOOL ComboButtonExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSComboButton class] ); }


// Title
CFStringRef ComboButtonTitle( NSInteger tag )
{
    NSComboButton *btn = ComboButtonWithTag( tag );
    if ( btn ) return (__bridge CFStringRef)[btn title];
    return nil;
}

void ComboButtonSetTitle( NSInteger tag, CFStringRef title )
{
    NSComboButton *btn = ComboButtonWithTag( tag );
    if ( btn ) [btn setTitle:(__bridge NSString *)title];
}

// Image
NSImage *ComboButtonImage( NSInteger tag )
{
    NSComboButton *btn = ComboButtonWithTag( tag );
    if ( btn ) return [btn image];
    return nil;
}

void ComboButtonSetImage( NSInteger tag, CFTypeRef inImage )
{
    NSComboButton *btn = ComboButtonWithTag( tag );
    if ( btn ) {
        NSImage *image = CUI_FixImageValue( inImage );
        [btn setImage:image];
    }
}

// Image scaling
NSImageScaling ComboButtonImageScaling( NSInteger tag )
{
    NSComboButton *btn = ComboButtonWithTag( tag );
    if ( btn ) return [btn imageScaling];
    return 0;
}

void ComboButtonSetImageScaling( NSInteger tag, NSImageScaling scaling )
{
    NSComboButton *btn = ComboButtonWithTag( tag );
    if ( btn ) [btn setImageScaling:scaling];
}

// Menu
NSInteger ComboButtonMenuIndex( NSInteger tag )
{
    NSComboButton *btn = ComboButtonWithTag( tag );
    if ( btn ) {
        NSMenu *menu = [btn menu];
        if ( menu ) return CUI_MenuIndex( menu );
    }
    return 0;
}

void ComboButtonSetMenu( NSInteger tag, NSInteger menuID )
{
    NSComboButton *btn = ComboButtonWithTag( tag );
    if ( btn ) {
        NSMenu *menu = MenuAtIndex( menuID );
        if ( menu ) [btn setMenu:menu];
    }
}

NSMenu *ComboButtonMenu( NSInteger tag )
{
    NSComboButton *btn = ComboButtonWithTag( tag );
    if ( btn ) return [btn menu];
    return nil;
}

// Style
NSComboButtonStyle ComboButtonStyle( NSInteger tag )
{
    NSComboButton *btn = ComboButtonWithTag( tag );
    if ( btn ) return [btn style];
    return 0;
}

void ComboButtonSetStyle( NSInteger tag, NSComboButtonStyle style )
{
    NSComboButton *btn = ComboButtonWithTag( tag );
    if ( btn ) [btn setStyle:style];
}



// Init
NSComboButton *ComboButtonInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) {
        rect = NSMakeRect( 17, 18, 75, 24 );
    }
    
    // subclass
    BOOL subclass = CUI_IsSubclassFlag();
    
    // init
    NSComboButton *btn;
#if __has_feature(objc_arc)
    if ( subclass ) {
        btn = [[ComboButtonSC alloc] initWithFrame:rect];
    } else {
        btn = [[NSComboButton alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        btn = [[[ComboButtonSC alloc] initWithFrame:rect] autorelease];
    } else {
        btn = [[[NSComboButton alloc] initWithFrame:rect] autorelease];
    }
#endif
    
//#if !__has_feature(objc_arc)
//    [btn autorelease];
//#endif
    
    // tag
    [btn setTag:inTag];
    
    // style
    [btn setStyle:NSComboButtonStyleSplit];
    
    // font
    CUI_ControlFixFont( btn );
    
    // target/action
    [btn setTarget:CUI_ControlTargetObj()];
    [btn setAction:@selector(controlAction:)];
    
    return btn;
}


#pragma mark - combobutton statement
void CUI_ComboButton( NSInteger inTag, NSInteger inEnabled, CFStringRef inTitle, void *inImage, NSInteger inMenuID, CFTypeRef inMenuItems, CGRect inRect, NSInteger inStyle, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSString *title = (__bridge NSString *)inTitle;
    
    // imageName, imagePath, NSImage, symbolName
    NSImage *image = CUI_FixImageValue( inImage );
    
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        
        NSComboButton *btn = CUI_ViewSubviewWithTag( contentView, inTag );
        
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
            
            // title
            if ( title ) [btn setTitle:title];
            
            // image
            //if ( image ) [btn setImage:image];
            [btn setImage:image];// 20230718

            // menu
            if ( inMenuID != kFBParamMissing ) {
                if ( !inMenuItems ) {
                    NSMenu *menu = MenuAtIndex( inMenuID );
                    if ( menu ) [btn setMenu:menu];
                } else {
                    if ( inMenuItems ) {
                        NSArray *items = nil;
                        if ( CFGetTypeID(inMenuItems) == CFStringGetTypeID() ) {
                            items = [(__bridge NSString *)inMenuItems componentsSeparatedByString:@";"];
                        } else if ( CFGetTypeID(inMenuItems) == CFArrayGetTypeID() ) {
                            items = (__bridge NSArray *)inMenuItems;
                        }

                        if ( items ) {
                            NSMenu *menu = [[NSMenu alloc] init];
                            for ( NSString *item in items ) {
                                if ( [item isEqualToString:@"-"] ) {
                                    [menu addItem:[NSMenuItem separatorItem]];
                                } else {
                                    NSMenuItem *menuItem = [menu addItemWithTitle:item action:@selector(menuItemAction:) keyEquivalent:@""];
                                    [menuItem setTarget:CUI_MenuItemTargetObj()];
                                }
                            }
                            [menu setAutoenablesItems:NO];
                            [menu setTag:inMenuID];
                            [menu setAutoenablesItems:NO];
                            [btn setMenu:menu];
                            CUI_OtherMenuAdd( menu );
                        }
                    }
                }
            }
                   
            // rect
            if ( !NSIsEmptyRect( rect ) ) [btn setFrame:rect];
            
            // style
            if ( inStyle != kFBParamMissing ) [btn setStyle:inStyle];
            
        } else {        // create
            btn = ComboButtonInit( inTag, inRect );
            
            // default autoresizing
            [btn setAutoresizingMask:NSViewMinYMargin];
            
            // enabled
            if ( inEnabled != kFBParamMissing ) [btn setEnabled:(BOOL)inEnabled];
            
            // title
            if ( !title ) {
                title = @"Button";
            }
            [btn setTitle:title];
            
            // image
            if ( image ) [btn setImage:image];
            
            // menuID
            if ( inMenuID != kFBParamMissing ) {
                if ( !inMenuItems ) {
                    NSMenu *menu = MenuAtIndex( inMenuID );
                    if ( menu ) [btn setMenu:menu];
                } else {
                    //menuItems
                    if ( inMenuID != kFBParamMissing && inMenuItems != nil ) {
                        NSArray *items = nil;
                        if ( CFGetTypeID(inMenuItems) == CFStringGetTypeID() ) {
                            items = [(__bridge NSString *)inMenuItems componentsSeparatedByString:@";"];
                        } else if ( CFGetTypeID(inMenuItems) == CFArrayGetTypeID() ) {
                            items = (__bridge NSArray *)inMenuItems;
                        }

                        if ( items ) {
                            NSMenu *menu = [[NSMenu alloc] init];
                            for ( NSString *item in items ) {
                                if ( [item isEqualToString:@"-"] ) {
                                    [menu addItem:[NSMenuItem separatorItem]];
                                } else {
                                    NSMenuItem *menuItem = [menu addItemWithTitle:item action:@selector(menuItemAction:) keyEquivalent:@""];
                                    [menuItem setTarget:CUI_MenuItemTargetObj()];
                                }
                            }
                            [menu setTag:inMenuID];
                            [menu setAutoenablesItems:NO];
                            [btn setMenu:menu];
                            CUI_OtherMenuAdd( menu );
                        }
                    }
                }
            }
            
            // style
            if ( inStyle == kFBParamMissing ) inStyle = NSComboButtonStyleSplit;
            [btn setStyle:inStyle];
            
            // wndTag
            [btn setWndTag:inWndTag];
            
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

#endif// 130000
