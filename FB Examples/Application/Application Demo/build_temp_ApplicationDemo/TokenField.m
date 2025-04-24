/*
 TokenField.m
 
 Bernie Wylde
 */

#import "TokenField.h"

#pragma mark - subclass
@implementation TokenFieldSC
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


@implementation CUI_TokenFieldDelegate

- (void)tokenField:(NSTokenField *)fld forwardEvent:(NSInteger)ev object:(id)obj {
    CUI_OutputWindowSetTag( [fld wndTag] );
    CallUserDefinedOnDialogFunction( ev, [fld tag], [fld wndTag], (__bridge CFTypeRef)obj );
}

- (NSString *)tokenField:(NSTokenField *)tokenField displayStringForRepresentedObject:(id)representedObject {
    DialogEventSetNSString( nil );
    [self tokenField:tokenField forwardEvent:tokenFieldDisplayStringForRepresentedObject object:representedObject];
    return DialogEventNSString();
}

- (NSTokenStyle)tokenField:(NSTokenField *)tokenField styleForRepresentedObject:(id)representedObject {
    DialogEventSetLong( 0 );
    [self tokenField:tokenField forwardEvent:tokenFieldStyleForRepresentedObject object:representedObject];
    return DialogEventLong();
}

- (NSArray *)tokenField:(NSTokenField *)tokenField completionsForSubstring:(NSString *)substring indexOfToken:(NSInteger)tokenIndex indexOfSelectedItem:(NSInteger *)selectedIndex {
    DialogEventSetNSArray(nil);
    DialogEventSetLong(tokenIndex);
    
    // should set dialog event selectedIndex value here
    
    [self tokenField:tokenField forwardEvent:tokenFieldCompletionsForSubstring object:substring];
    return DialogEventNSArray();
}

- (NSString *)tokenField:(NSTokenField *)tokenField editingStringForRepresentedObject:(id)representedObject {
    DialogEventSetNSString( nil );
    [self tokenField:tokenField forwardEvent:tokenFieldEditingStringForRepresentedObject object:representedObject];
    return DialogEventNSString();
}

- (id)tokenField:(NSTokenField *)tokenField representedObjectForEditingString:(NSString *)editingString {
    DialogEventSetNSObject( nil );
    [self tokenField:tokenField forwardEvent:tokenFieldRepresentedObjectForEditingString object:editingString];
    return DialogEventNSObject();
}

- (NSArray *)tokenField:(NSTokenField *)tokenField shouldAddObjects:(NSArray *)tokens atIndex:(NSUInteger)index {
    DialogEventSetLong( index );
    DialogEventSetNSArray( nil );
    [self tokenField:tokenField forwardEvent:tokenFieldShouldAddObjects object:tokens];
    return DialogEventNSArray();
}

- (NSArray *)tokenField:(NSTokenField *)tokenField readFromPasteboard:(NSPasteboard *)pboard {
    DialogEventSetNSArray( nil );
    [self tokenField:tokenField forwardEvent:tokenFieldReadFromPasteboard object:pboard];
    return DialogEventNSArray();
}

- (BOOL)tokenField:(NSTokenField *)tokenField writeRepresentedObjects:(NSArray *)objects toPasteboard:(NSPasteboard *)pboard {
    DialogEventSetBool(NO);
    DialogEventSetNSArray( objects );
    [self tokenField:tokenField forwardEvent:tokenFieldWriteRepresentedObjectToPasteboard object:pboard];
    return DialogEventBool();
}

- (BOOL)tokenField:(NSTokenField *)tokenField hasMenuForRepresentedObject:(id)representedObject {
    DialogEventSetBool(NO);
    [self tokenField:tokenField forwardEvent:tokenFieldHasMenuForRepresentedObject object:representedObject];
    return DialogEventBool();
}

- (NSMenu *)tokenField:(NSTokenField *)tokenField menuForRepresentedObject:(id)representedObject {
    DialogEventSetNSMenu(nil);
    [self tokenField:tokenField forwardEvent:tokenFieldMenuForRepresentedObject object:representedObject];
    return DialogEventNSMenu();
}

#pragma mark - control text delegate methods
- (void)controlTextDidBeginEditing:(NSNotification *)notification {
    CUI_ControlCallUserDefinedOnDialogOrCallback( textFieldDidBeginEditing, notification.object, NULL );
}

- (void)controlTextDidChange:(NSNotification *)notification {
    CUI_ControlCallUserDefinedOnDialogOrCallback( textFieldDidChange, notification.object, NULL );
}

- (void)controlTextDidEndEditing:(NSNotification *)notification {
    CUI_ControlCallUserDefinedOnDialogOrCallback( textFieldDidEndEditing, notification.object, NULL );
}

- (BOOL)control:(NSControl *)control textShouldBeginEditing:(NSText *)fieldEditor {
    DialogEventSetBool(YES);
    CUI_ControlCallUserDefinedOnDialogOrCallback( textFieldShouldBeginEditing, control, fieldEditor );
    return DialogEventBool();
}

- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor {
    DialogEventSetBool(YES);
    CUI_ControlCallUserDefinedOnDialogOrCallback( textFieldShouldEndEditing, control, fieldEditor );
    return DialogEventBool();
}
@end

CUI_TokenFieldDelegate *CUI_TokenFieldDelegateObj( void )
{
    static CUI_TokenFieldDelegate *sCUI_TokenFieldDelegate = nil;
    if ( !sCUI_TokenFieldDelegate ) sCUI_TokenFieldDelegate = [[CUI_TokenFieldDelegate alloc] init];
    return sCUI_TokenFieldDelegate;
}

// Class
Class TokenFieldClass( void )
{ return [NSTokenField class]; }

NSTokenField *TokenFieldWithTag( NSInteger tag )
{ return (NSTokenField *)CUI_ValidateViewKindOfClass( tag, [NSTokenField class] ); }

BOOL TokenFieldExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSTokenField class] ); }


// Style
NSUInteger TokenFieldStyle( NSInteger tag )
{
    NSTokenField *fld = TokenFieldWithTag( tag );
    if ( fld ) return [fld tokenStyle];
    return 0;
}

void TokenFieldSetStyle( NSInteger tag, NSUInteger style )
{
    NSTokenField *fld = TokenFieldWithTag( tag );
    if ( fld ) [fld setTokenStyle:style];
}

// Character set
CFCharacterSetRef TokenFieldTokenizingCharacterSet( NSInteger tag )
{
    NSTokenField *fld = TokenFieldWithTag( tag );
    if ( fld ) return (__bridge CFCharacterSetRef)[fld tokenizingCharacterSet];
    return nil;
}

void TokenFieldSetTokenizingCharacterSet( NSInteger tag, CFCharacterSetRef set )
{
    NSTokenField *fld = TokenFieldWithTag( tag );
    if ( fld ) [fld setTokenizingCharacterSet:(__bridge NSCharacterSet *)set];
}

CFCharacterSetRef TokenFieldDefaultTokenizingCharacterSet( void )
{ return (__bridge CFCharacterSetRef)[NSTokenField defaultTokenizingCharacterSet]; }

// CompletionDelay
CFTimeInterval TokenFieldCompletionDelay( NSInteger tag )
{
    NSTokenField *fld = TokenFieldWithTag( tag );
    if ( fld ) return [fld completionDelay];
    return 0.0;
}

void TokenFieldSetCompletionDelay( NSInteger tag, CFTimeInterval ti )
{
    NSTokenField *fld = TokenFieldWithTag( tag );
    if ( fld ) [fld setCompletionDelay:ti];
}

CFTimeInterval TokenFieldDefaultCompletionDelay( void )
{ return [NSTokenField defaultCompletionDelay]; }

// Custom
CFArrayRef TokenFieldRangesOfSelections( NSInteger tag )
{
    NSTokenField *fld = TokenFieldWithTag( tag );
    if ( fld ) {
        NSTextView *textView = [[fld cell] fieldEditorForView:fld];
        return (__bridge CFArrayRef)[textView selectedRanges];
    }
    return nil;
}


// Init
NSTokenField *TokenFieldInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) rect = NSMakeRect( 20, 20, 96, 22 );
    
    // subclass
    BOOL subclass = CUI_IsSubclassFlag();
    
    // init
    NSTokenField *fld;
#if __has_feature(objc_arc)
    if ( subclass ) {
        fld = [[TokenFieldSC alloc] initWithFrame:rect];
    } else {
        fld = [[NSTokenField alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        fld = [[[TokenFieldSC alloc] initWithFrame:rect] autorelease];
    } else {
        fld = [[[NSTokenField alloc] initWithFrame:rect] autorelease];
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
    [fld setDelegate:CUI_TokenFieldDelegateObj()];
    
    return fld;
}

// Statement
void CUI_TokenField( NSInteger inTag, NSInteger inEnabled, CFStringRef inText, CGRect inRect, NSInteger inStyle, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSString *text = (__bridge NSString *)inText;
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSTokenField *fld = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !fld ) {
            fld = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( fld ) {    // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            // make sure it's same view class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, fld, [NSTokenField class] ) ) {
                return;
            }

            // enabled
            if ( inEnabled != kFBParamMissing ) [fld setEnabled:(BOOL)inEnabled];
            
            // text
            if ( text ) [fld setStringValue:text];
            
            // rect
            if ( !NSIsEmptyRect( rect ) ) [fld setFrame:rect];
            
            // style
            if ( inStyle != kFBParamMissing ) [fld setTokenStyle:inStyle];
            
        } else {        // create
            // init
            fld = TokenFieldInit( inTag, inRect );
            
            // default autoresizing
            [fld setAutoresizingMask:NSViewMinYMargin];
            
            // enabled
            if ( inEnabled != kFBParamMissing ) [fld setEnabled:(BOOL)inEnabled];
            
            // text
            if ( text ) [fld setStringValue:text];
            
            // style
            if ( inStyle != kFBParamMissing ) [fld setTokenStyle:inStyle];
            
            // wndTag
            [fld setWndTag:inWndTag];
            
            // fix font to match I.B.
            CUI_ControlFixFont( fld );
            
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

