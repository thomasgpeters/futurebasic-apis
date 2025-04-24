/*
 SearchField.m

 Bernie Wylde
 */

#import "SearchField.h"

@implementation SearchFieldSC
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

@implementation CUI_SearchFieldDelegate

- (void)controlTextDidBeginEditing:(NSNotification *)notification {
    CUI_ControlCallUserDefinedOnDialogOrCallback( textFieldDidBeginEditing, notification.object, NULL );
}

- (void)controlTextDidChange:(NSNotification *)notification {
    CUI_ControlCallUserDefinedOnDialogOrCallback( textFieldDidChange, notification.object, NULL );
}

- (void)controlTextDidEndEditing:(NSNotification *)notification {
    CUI_ControlCallUserDefinedOnDialogOrCallback( textFieldDidEndEditing, notification.object, NULL );
}

- (void)searchFieldDidStartSearching:(NSSearchField *)sender {
    CUI_ControlCallUserDefinedOnDialogOrCallback( searchFieldDidStartSearching, sender, NULL );
}

- (void)searchFieldDidEndSearching:(NSSearchField *)sender {
    CUI_ControlCallUserDefinedOnDialogOrCallback( searchFieldDidEndSearching, sender, NULL );
}

@end

CUI_SearchFieldDelegate *CUI_SearchFieldDelegateObj( void )
{
    static CUI_SearchFieldDelegate *sCUI_SearchFieldDelegate = nil;
    if ( !sCUI_SearchFieldDelegate ) sCUI_SearchFieldDelegate = [[CUI_SearchFieldDelegate alloc] init];
    return sCUI_SearchFieldDelegate;
}

// Class
Class SearchFieldClass( void )
{ return [NSSearchField class]; }

NSSearchField *SearchFieldWithTag( NSInteger tag )
{ return (NSSearchField *)CUI_ValidateViewKindOfClass( tag, [NSSearchField class] ); }

BOOL SearchFieldExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSSearchField class] ); }


BOOL SearchFieldSendsSearchStringImmediately( NSInteger tag )
{
    NSSearchField *fld = SearchFieldWithTag( tag );
    if ( fld ) {
        return [fld sendsSearchStringImmediately];
    }
    return NO;
}

void SearchFieldSetSendsSearchStringImmediately( NSInteger tag, BOOL flag )
{
    NSSearchField *fld = SearchFieldWithTag( tag );
    if ( fld ) {
        [fld setSendsSearchStringImmediately:flag];
    }
}

BOOL SearchFieldSendsWholeSearchString( NSInteger tag )
{
    NSSearchField *fld = SearchFieldWithTag( tag );
    if ( fld ) {
        return [fld sendsWholeSearchString];
    }
    return NO;
}

void SearchFieldSetSendsWholeSearchString( NSInteger tag, BOOL flag )
{
    NSSearchField *fld = SearchFieldWithTag( tag );
    if ( fld ) {
        [fld setSendsWholeSearchString:flag];
    }
}

CFArrayRef SearchFieldRecentSearches( NSInteger tag )
{
    NSSearchField *fld = SearchFieldWithTag( tag );
    if ( fld ) return (__bridge CFArrayRef)[fld recentSearches];
    return NULL;
}

BOOL SearchFieldCentersPlaceholder( NSInteger tag )
{
    NSSearchField *fld = SearchFieldWithTag( tag );
    if ( fld ) {
        return [fld centersPlaceholder];
    }
    return NO;
}

void SearchFieldSetCentersPlaceholder( NSInteger tag, BOOL flag )
{
    NSSearchField *fld = SearchFieldWithTag( tag );
    if ( fld ) {
        [fld setCentersPlaceholder:flag];
    }
}

NSInteger SearchFieldMaximumRecents( NSInteger tag )
{
    NSSearchField *fld = SearchFieldWithTag( tag );
    if ( fld ) {
        return [fld maximumRecents];
    }
    return 0;
}

void SearchFieldSetMaximumRecents( NSInteger tag, NSInteger value )
{
    NSSearchField *fld = SearchFieldWithTag( tag );
    if ( fld ) {
        [fld setMaximumRecents:value];
    }
}

CFStringRef SearchFieldRecentsAutosaveName( NSInteger tag )
{
    NSSearchField *fld = SearchFieldWithTag( tag );
    if ( fld ) {
        return (__bridge CFStringRef)[fld recentsAutosaveName];
    }
    return nil;
}

void SearchFieldSetRecentsAutosaveName( NSInteger tag, CFStringRef name )
{
    NSSearchField *fld = SearchFieldWithTag( tag );
    if ( fld ) {
        [fld setRecentsAutosaveName:(__bridge NSString *)name];
    }
}

NSInteger SearchFieldSearchMenuTemplate( NSInteger tag )
{
    NSSearchField *fld = SearchFieldWithTag( tag );
    if ( fld ) {
        NSMenu *menu = [fld searchMenuTemplate];
        if ( menu ) {
            // we need to get the menu index here
            // ...
            
            
        }
    }
    return -1;
}

void SearchFieldSetSearchMenuTemplate( NSInteger tag, NSInteger menuIndex )
{
    NSSearchField *fld = SearchFieldWithTag( tag );
    if ( fld ) {
        NSMenu *menu = MenuAtIndex( menuIndex );
        if ( menu ) {
            [fld setSearchMenuTemplate:menu];
            NSArray *items = [menu itemArray];
            for ( NSMenuItem *item in items ) {
                [item setTarget:nil];
                [item setAction:nil];
                
                // set search field tags here:
                // NSSearchFieldClearRecentsMenuItemTag
                // NSSearchFieldRecentsTitleMenuItemTag
                // NSSearchFieldRecentsMenuItemTag
            }
        }
    }
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
CGRect SearchFieldSearchTextBounds( NSInteger tag )
{
    NSSearchField *fld = SearchFieldWithTag( tag );
    if ( fld ) return NSRectToCGRect([fld searchTextBounds]);
    return CGRectZero;
}

CGRect SearchFieldSearchButtonBounds( NSInteger tag )
{
    NSSearchField *fld = SearchFieldWithTag( tag );
    if ( fld ) return NSRectToCGRect([fld searchButtonBounds]);
    return CGRectZero;
}

CGRect SearchFieldCancelButtonBounds( NSInteger tag )
{
    NSSearchField *fld = SearchFieldWithTag( tag );
    if ( fld ) return NSRectToCGRect([fld cancelButtonBounds]);
    return CGRectZero;
}
#endif// 110000

// Convenience
void SearchFieldSetSearchButtonImage( NSInteger tag, NSImage *image )
{
    NSSearchField *fld = SearchFieldWithTag( tag );
    if ( fld ) [[(NSSearchFieldCell *)[fld cell] searchButtonCell] setImage:image];
}

void SearchFieldSetCancelButtonImage( NSInteger tag, NSImage *image )
{
    NSSearchField *fld = SearchFieldWithTag( tag );
    if ( fld ) [[(NSSearchFieldCell *)[fld cell] cancelButtonCell] setImage:image];
}


// Init
NSSearchField *SearchFieldInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) rect = NSMakeRect( 20, 20, 96, 22 );

    // subclass
    BOOL subclass = CUI_IsSubclassFlag();

    // init
    NSSearchField *fld;
#if __has_feature(objc_arc)
    if ( subclass ) {
        fld = [[SearchFieldSC alloc] initWithFrame:rect];
    } else {
        fld = [[NSSearchField alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        fld = [[[SearchFieldSC alloc] initWithFrame:rect] autorelease];
    } else {
        fld = [[[NSSearchField alloc] initWithFrame:rect] autorelease];
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
    [fld setDelegate:CUI_SearchFieldDelegateObj()];

    return fld;
}

void CUI_SearchField( NSInteger inTag, NSInteger inEnabled, CFStringRef inText, CGRect inRect, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSString *text = (__bridge NSString *)inText;
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSSearchField *fld = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !fld ) {
            fld = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( fld ) {    // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            // make sure it's correct class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, fld, [NSSearchField class] ) ) {
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
            fld = SearchFieldInit( inTag, inRect );
            
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

