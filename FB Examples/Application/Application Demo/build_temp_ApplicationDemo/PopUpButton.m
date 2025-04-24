/*
 PopUpButton.m

 Bernie Wylde
 */

#import "PopUpButton.h"

#pragma mark - subclass
@implementation PopUpButtonSC
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

// Class
Class PopUpButtonClass( void )
{ return [NSPopUpButton class]; }

NSPopUpButton *PopUpButtonWithTag( NSInteger tag )
{ return (NSPopUpButton *)CUI_ValidateViewKindOfClass( tag, [NSPopUpButton class] ); }

BOOL PopUpButtonExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSPopUpButton class] ); }


// Type of menu
BOOL PopUpButtonPullsDown( NSInteger tag )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) return [btn pullsDown];
    return NO;
}

void PopUpButtonSetPullsDown( NSInteger tag, BOOL flag )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) [btn setPullsDown:flag];
}

BOOL PopUpButtonAutoenablesItems( NSInteger tag )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) return [btn autoenablesItems];
    return NO;
}

// State
void PopUpButtonSynchronizeTitleAndSelectedItem( NSInteger tag )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) [btn synchronizeTitleAndSelectedItem];
}



void PopUpButtonAddItemWithTitle( NSInteger tag, CFStringRef title )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) [btn addItemWithTitle:(__bridge NSString *)title];
}

void PopUpButtonAddItemsWithTitles( NSInteger tag, CFArrayRef titles )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) [btn addItemsWithTitles:(__bridge NSArray *)titles];
}

void PopUpButtonInsertItemWithTitle( NSInteger tag, CFStringRef title, NSInteger index )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) [btn insertItemWithTitle:(__bridge NSString *)title atIndex:index];
}

void PopUpButtonRemoveAllItems( NSInteger tag )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) [btn removeAllItems];
}

void PopUpButtonRemoveItemWithTitle( NSInteger tag, CFStringRef title )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) [btn removeItemWithTitle:(__bridge NSString *)title];
}

void PopUpButtonRemoveItemAtIndex( NSInteger tag, NSInteger index )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) [btn removeItemAtIndex:index];
}

CFStringRef PopUpButtonTitleOfSelectedItem( NSInteger tag )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) return (__bridge CFStringRef)[btn titleOfSelectedItem];
    return NULL;
}

NSInteger PopUpButtonIndexOfSelectedItem( NSInteger tag )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) return [btn indexOfSelectedItem];
    return 0;
}

void PopUpButtonSelectItemAtIndex( NSInteger tag, NSInteger index )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) [btn selectItemAtIndex:index];
}

void PopUpButtonSelectItemWithTag( NSInteger popUpTag, NSInteger itemTag )
{
    NSPopUpButton *btn = PopUpButtonWithTag( popUpTag );
    if ( btn ) [btn selectItemWithTag:itemTag];
}

void PopUpButtonSelectItemWithTitle( NSInteger tag, CFStringRef title )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) [btn selectItemWithTitle:(__bridge NSString *)title];
}

NSInteger PopUpButtonNumberOfItems( NSInteger tag )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) return [btn numberOfItems];
    return 0;
}

CFArrayRef PopUpButtonItemArray( NSInteger tag )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) return (__bridge CFArrayRef)[btn itemArray];
    return NULL;
}

CFStringRef PopUpButtonItemTitleAtIndex( NSInteger tag, NSInteger index )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) return (__bridge CFStringRef)[btn itemTitleAtIndex:index];
    return NULL;
}

CFArrayRef PopUpButtonItemTitles( NSInteger tag )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) return (__bridge CFArrayRef)[btn itemTitles];
    return NULL;
}

NSInteger PopUpButtonIndexOfItemWithTag( NSInteger popUpTag, NSInteger itemTag )
{
    NSPopUpButton *btn = PopUpButtonWithTag( popUpTag );
    if ( btn ) return [btn indexOfItemWithTag:itemTag];
    return 0;
}

NSInteger PopUpButtonIndexOfItemWithTitle( NSInteger tag, CFStringRef title )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) return [btn indexOfItemWithTitle:(__bridge NSString *)title];
    return 0;
}

NSMenu *PopUpButtonMenu( NSInteger tag )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) return [btn menu];
    return nil;
}

NSInteger PopUpButtonMenuIndex( NSInteger tag )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) {
        NSMenu *menu = [btn menu];
        if ( menu ) {
            return CUI_MenuIndex( menu );
        }
    }
    return 0;
}

void PopUpButtonSetMenu( NSInteger tag, NSInteger menuIndex )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) {
        NSMenu *menu = MenuAtIndex( menuIndex );
        if ( menu ) [btn setMenu:menu];
    }
}

NSMenuItem *PopUpButtonItemAtIndex( NSInteger tag, NSInteger index )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) return [btn itemAtIndex:index];
    return nil;
}

NSMenuItem *PopUpButtonItemWithTitle( NSInteger tag, CFStringRef title )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) return [btn itemWithTitle:(__bridge NSString *)title];
    return nil;
}

NSMenuItem *PopUpButtonLastItem( NSInteger tag )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) return [btn lastItem];
    return nil;
}


// Indices of menu items
NSInteger PopUpButtonIndexOfItem( NSInteger tag, NSMenuItem *item )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) return [btn indexOfItem:item];
    return 0;
}

NSInteger PopUpButtonIndexOfItemWithRepresentedObject( NSInteger tag, CFTypeRef obj )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) return [btn indexOfItemWithRepresentedObject:(__bridge id)obj];
    return 0;
}




void PopUpButtonSetTitle( NSInteger tag, CFStringRef title )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) [btn setTitle:(__bridge NSString *)title];
}

void PopUpButtonSetPreferredEdge( NSInteger tag, CGRectEdge edge )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) [btn setPreferredEdge:(NSRectEdge)edge];
}

void PopUpButtonSetAutoenablesItems( NSInteger tag, BOOL flag )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) [btn setAutoenablesItems:flag];
}

void PopUpButtonItemSetEnabled( NSInteger tag, NSInteger index, BOOL flag )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) {
        NSMenuItem *item = [btn itemAtIndex:index];
        if ( item ) [item setEnabled:flag];
    }
}

// Edge
CGRectEdge PopUpButtonPreferredEdge( NSInteger tag )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) return (CGRectEdge)[btn preferredEdge];
    return CGRectMaxXEdge;
}


// -- PopUpButtonCell methods --
BOOL PopUpButtonUsesItemFromMenu( NSInteger tag )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) {
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
        if (@available(macOS 15.0, *)) {
            return [btn usesItemFromMenu];
        } else {
            return [[btn cell] usesItemFromMenu];
        }
#else // 150000
        return [[btn cell] usesItemFromMenu];
#endif // 150000
    }
    return NO;
}

void PopUpButtonSetUsesItemFromMenu( NSInteger tag, BOOL flag )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) {
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
        if (@available(macOS 15.0, *)) {
            [btn setUsesItemFromMenu:flag];
        } else {
            [[btn cell] setUsesItemFromMenu:flag];
        }
#else // 150000
        [[btn cell] setUsesItemFromMenu:flag];
#endif // 150000
    }
}

BOOL PopUpButtonAltersStateOfSelectedItem( NSInteger tag )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) {
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
        if (@available(macOS 15.0, *)) {
            return [btn altersStateOfSelectedItem];
        } else {
            return [[btn cell] altersStateOfSelectedItem];
        }
#else // 150000
        return [[btn cell] altersStateOfSelectedItem];
#endif // 150000
    }
    return NO;
}

void PopUpButtonSetAltersStateOfSelectedItem( NSInteger tag, BOOL flag )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) {
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
        if (@available(macOS 15.0, *)) {
            [btn setAltersStateOfSelectedItem:flag];
        } else {
            [[btn cell] setAltersStateOfSelectedItem:flag];
        }
#else // 150000
        [[btn cell] setAltersStateOfSelectedItem:flag];
#endif // 150000

    }
}

NSPopUpArrowPosition PopUpButtonArrowPosition( NSInteger tag )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) return [[btn cell] arrowPosition];
    return 0;
}

void PopUpButtonSetArrowPosition( NSInteger tag, NSPopUpArrowPosition position )
{
    NSPopUpButton *btn = PopUpButtonWithTag( tag );
    if ( btn ) [[btn cell] setArrowPosition:position];
}

// Init
NSPopUpButton *PopUpButtonInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) {
        rect = NSMakeRect( 18, 17, 76, 26 );
    }

    // subclass
    BOOL subclass = CUI_IsSubclassFlag();

    // init
    NSPopUpButton *btn;
#if __has_feature(objc_arc)
    if ( subclass ) {
        btn = [[PopUpButtonSC alloc] initWithFrame:rect pullsDown:NO];
    } else {
        btn = [[NSPopUpButton alloc] initWithFrame:rect pullsDown:NO];
    }
#else
    if ( subclass ) {
        btn = [[[PopUpButtonSC alloc] initWithFrame:rect pullsDown:NO] autorelease];
    } else {
        btn = [[[NSPopUpButton alloc] initWithFrame:rect pullsDown:NO] autorelease];
    }
#endif
    
//#if !__has_feature(objc_arc)
//    [btn autorelease];
//#endif
    
    // tag
    [btn setTag: inTag];

    // fix font
    CUI_ControlFixFont( btn );

    // target/action
    [btn setTarget:CUI_ControlTargetObj()];
    [btn setAction:@selector(controlAction:)];

    return btn;
}

// Statement
void CUI_PopUpButton( NSInteger inTag, NSInteger inEnabled, NSInteger inIndex, CFTypeRef inItems, CGRect inRect, NSInteger inPullsDown, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSPopUpButton *btn = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !btn ) {
            btn = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( btn ) {    // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            // make sure it's correct class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, btn, [NSPopUpButton class] ) ) {
                return;
            }

            // enabled
            if ( inEnabled != kFBParamMissing ) [btn setEnabled:(BOOL)inEnabled];
            
            // index
            if ( inIndex != kFBParamMissing ) {
                if ( inIndex < [btn numberOfItems] ) [btn selectItemAtIndex:inIndex];
            }
            
            // items
            if ( inItems ) {
                NSArray *items = nil;
                if ( CFGetTypeID(inItems) == CFStringGetTypeID() ) {
                    items = [(__bridge NSString *)inItems componentsSeparatedByString:@";"];
                } else if ( CFGetTypeID(inItems) == CFArrayGetTypeID() ) {
                    items = (__bridge NSArray *)inItems;
                }
                
                if ( items ) {
                    [btn removeAllItems];
                    NSMenu *menu = [btn menu];
                    for ( NSString *item in items ) {
                        if ( [item isEqualToString:@"-"] ) {
                            [menu addItem:[NSMenuItem separatorItem]];
                        } else {
                            [menu addItemWithTitle:item action:nil keyEquivalent:@""];
                        }
                    }
                }
            }
            
            // rect
            if ( !NSIsEmptyRect( rect ) ) [btn setFrame:rect];
            
            // pullsDown
            if ( inPullsDown != kFBParamMissing ) [btn setPullsDown:(BOOL)inPullsDown];
            
        } else {
            // init
            btn = PopUpButtonInit( inTag, inRect );
            
            // pulls down
            if ( inPullsDown != kFBParamMissing ) [btn setPullsDown:YES];

            // default autoresizing
            [btn setAutoresizingMask:NSViewMinYMargin];
            
            // enabled
            if ( inEnabled != kFBParamMissing ) [btn setEnabled:(BOOL)inEnabled];
            
            // items
            if ( inItems ) {
                NSArray *items = nil;
                if ( CFGetTypeID(inItems) == CFStringGetTypeID() ) {
                    items = [(__bridge NSString *)inItems componentsSeparatedByString:@";"];
                } else if ( CFGetTypeID(inItems) == CFArrayGetTypeID() ) {
                    items = (__bridge NSArray *)inItems;
                }
                if ( items ) {
                    NSMenu *menu = [btn menu];
                    for ( NSString *item in items ) {
                        if ( [item isEqualToString:@"-"] ) {
                            [menu addItem:[NSMenuItem separatorItem]];
                        } else {
                            [menu addItemWithTitle:item action:nil keyEquivalent:@""];
                        }
                    }
                }
            }
            
            // index
            if ( inIndex != kFBParamMissing ) {
                if ( inIndex < [btn numberOfItems] ) [btn selectItemAtIndex:inIndex];
            }
            
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

