/*
 ComboBox.m

 Bernie Wylde
 */

#import "ComboBox.h"

@implementation CUI_ComboBoxDelegate
#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.comboBoxData release];
    [super dealloc];
}
#endif

#pragma mark - combobox delegate methods
- (void)controlTextDidBeginEditing:(NSNotification *)notification {
    CUI_ControlCallUserDefinedOnDialogOrCallback( textFieldDidBeginEditing, notification.object, NULL );
}

- (void)controlTextDidChange:(NSNotification *)notification {
    CUI_ControlCallUserDefinedOnDialogOrCallback( textFieldDidChange, notification.object, NULL );
}

- (void)controlTextDidEndEditing:(NSNotification *)notification {
    CUI_ControlCallUserDefinedOnDialogOrCallback( textFieldDidEndEditing, notification.object, NULL );
}

- (void)comboBoxSelectionDidChange:(NSNotification *)notification {
    CUI_ControlCallUserDefinedOnDialogOrCallback( comboBoxSelectionDidChange, notification.object, NULL );
}

- (void)comboBoxSelectionIsChanging:(NSNotification *)notification {
    CUI_ControlCallUserDefinedOnDialogOrCallback( comboBoxSelectionIsChanging, notification.object, NULL );
}

- (void)comboBoxWillDismiss:(NSNotification *)notification {
    CUI_ControlCallUserDefinedOnDialogOrCallback( comboBoxWillDismiss, notification.object, NULL );
}

- (void)comboBoxWillPopUp:(NSNotification *)notification {
    CUI_ControlCallUserDefinedOnDialogOrCallback( comboBoxWillPopUp, notification.object, NULL );
}

#pragma mark - combobox data source methods
- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox {
    return [self.comboBoxData count];
}

- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index {
    return [self.comboBoxData objectAtIndex:index];
}
@end

CUI_ComboBoxDelegate *CUI_ComboBoxDelegateObj( void )
{
    static CUI_ComboBoxDelegate *sCUI_ComboBoxDelegate = nil;
    if ( !sCUI_ComboBoxDelegate ) sCUI_ComboBoxDelegate = [[CUI_ComboBoxDelegate alloc] init];
    return sCUI_ComboBoxDelegate;
}


#pragma mark - subclass
@implementation ComboBoxSC
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
Class ComboBoxClass( void )
{ return [NSComboBox class]; }

NSComboBox *ComboBoxWithTag( NSInteger tag )
{ return (NSComboBox *)CUI_ValidateViewKindOfClass( tag, [NSComboBox class] ); }

BOOL ComboBoxExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSComboBox class] ); }


// - attributes
BOOL ComboBoxHasVerticalScroller( NSInteger tag )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [combo hasVerticalScroller];
    return NO;
}

void ComboBoxSetHasVerticalScroller( NSInteger tag, BOOL flag )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [combo setHasVerticalScroller:flag];
}

CGSize ComboBoxIntercellSpacing( NSInteger tag )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [combo intercellSpacing];
    return CGSizeZero;
}

void ComboBoxSetIntercellSpacing( NSInteger tag, CGSize size )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [combo setIntercellSpacing:NSSizeFromCGSize(size)];
}

BOOL ComboBoxIsBordered( NSInteger tag )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [combo isButtonBordered];
    return NO;
}

void ComboBoxSetBordered( NSInteger tag, BOOL flag )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [combo setButtonBordered:flag];
}

CGFloat ComboBoxItemHeight( NSInteger tag )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [combo itemHeight];
    return 0.0;
}

void ComboBoxSetItemHeight( NSInteger tag, CGFloat height )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [combo setItemHeight:height];
}

NSInteger ComboBoxNumberOfVisibleItems( NSInteger tag )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [combo numberOfVisibleItems];
    return 0;
}

void ComboBoxSetNumberOfVisibleItems( NSInteger tag, NSInteger value )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [combo setNumberOfVisibleItems:value];
}

void ComboBoxSetUsesDataSource( NSInteger tag, BOOL flag )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) {
        [combo setUsesDataSource:flag];
        if ( flag ) {
            [combo setDataSource:CUI_ComboBoxDelegateObj()];
        }
    }
}

void ComboBoxSetCompletes( NSInteger tag, BOOL flag )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [combo setCompletes:flag];
}

void ComboBoxAddItems( NSInteger tag, CFArrayRef items )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [combo addItemsWithObjectValues:(__bridge NSArray *)items];
}

void ComboBoxAddItem( NSInteger tag, CFTypeRef item )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [combo addItemWithObjectValue:(__bridge id)item];
}

void ComboBoxInsertItem( NSInteger tag, CFTypeRef item, NSInteger index )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [combo insertItemWithObjectValue:(__bridge id)item atIndex:index];
}

CFArrayRef ComboBoxValues( NSInteger tag )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) return (__bridge CFArrayRef)[combo objectValues];
    return NULL;
}

void ComboBoxRemoveAllItems( NSInteger tag )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [combo removeAllItems];
}

void ComboBoxRemoveItemAtIndex( NSInteger tag, NSInteger index )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [combo removeItemAtIndex:index];
}

void ComboBoxRemoveItemWithValue( NSInteger tag, CFTypeRef value )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [combo removeItemWithObjectValue:(__bridge id)value];
}

NSInteger ComboBoxNumberOfItems( NSInteger tag )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) return [combo numberOfItems];
    return 0;
}

NSInteger ComboBoxIndexOfItemWithValue( NSInteger tag, CFTypeRef value )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) return [combo indexOfItemWithObjectValue:(__bridge id)value];
    return 0;
}

CFTypeRef ComboBoxItemValueAtIndex( NSInteger tag, NSInteger index )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) return (__bridge CFTypeRef)[combo itemObjectValueAtIndex:index];
    return NULL;
}

void ComboBoxNoteNumberOfItemsChanged( NSInteger tag )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [combo noteNumberOfItemsChanged];
}

void ComboBoxReloadData( NSInteger tag )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [combo reloadData];
}

void ComboBoxScrollItemAtIndexToTop( NSInteger tag, NSInteger index )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [combo scrollItemAtIndexToTop:index];
}

void ComboBoxScrollItemAtIndexToVisible( NSInteger tag, NSInteger index )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [combo scrollItemAtIndexToVisible:index];
}

void ComboBoxDeselectItemAtIndex( NSInteger tag, NSInteger index )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [combo deselectItemAtIndex:index];
}

NSInteger ComboBoxIndexOfSelectedItem( NSInteger tag )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) return [combo indexOfSelectedItem];
    return 0;
}

CFTypeRef ComboBoxValueOfSelectedItem( NSInteger tag )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) return (__bridge CFTypeRef)[combo objectValueOfSelectedItem];
    return NULL;
}

void ComboBoxSelectItemAtIndex( NSInteger tag, NSInteger index )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [combo selectItemAtIndex:index];
}
void ComboBoxSelectItemWithValue( NSInteger tag, CFTypeRef value )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [combo selectItemWithObjectValue:(__bridge id)value];
}

// custom
CFMutableArrayRef ComboBoxData( NSInteger tag )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) return (__bridge CFMutableArrayRef)[CUI_ComboBoxDelegateObj() comboBoxData];
    return nil;
}

void ComboBoxSetData( NSInteger tag, CFMutableArrayRef array )
{
    NSComboBox *combo = ComboBoxWithTag( tag );
    if ( combo ) [CUI_ComboBoxDelegateObj() setComboBoxData:(__bridge NSMutableArray *)array];
}

// Init
NSComboBox *ComboBoxInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) rect = NSMakeRect( 20, 16, 99, 26 );

    // subclass
    BOOL subclass = CUI_IsSubclassFlag();
    
    // init
    NSComboBox *combo;
#if __has_feature(objc_arc)
    if ( subclass ) {
        combo = [[ComboBoxSC alloc] initWithFrame:rect];
    } else {
        combo = [[NSComboBox alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        combo = [[[ComboBoxSC alloc] initWithFrame:rect] autorelease];
    } else {
        combo = [[[NSComboBox alloc] initWithFrame:rect] autorelease];
    }
#endif
    
//#if !__has_feature(objc_arc)
//    [combo autorelease];
//#endif
    
    // tag
    [combo setTag:inTag];
    
    // fix font to match I.B.
    CUI_ControlFixFont( combo );
    
    // delegate
    [combo setDelegate:CUI_ComboBoxDelegateObj()];
    
    return combo;
}

// statement
void CUI_ComboBox( NSInteger inTag, NSInteger inEnabled, CFTypeRef inItems, CFStringRef inText, CGRect inRect, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSString *text = (__bridge NSString *)inText;
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSComboBox *combo = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !combo ) {
            combo = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( combo ) {    // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            // make sure it's correct class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, combo, [NSComboBox class] ) ) {
                return;
            }

            // enabled
            if ( inEnabled != kFBParamMissing ) [combo setEnabled:(BOOL)inEnabled];
            
            // items
            if ( inItems ) {
                NSArray *items = nil;
                
                if ( CFGetTypeID(inItems) == CFStringGetTypeID() ) {
                    items = [(__bridge NSString *)inItems componentsSeparatedByString:@";"];
                    
                } else if ( CFGetTypeID(inItems) == CFArrayGetTypeID() ) {
                    items = (__bridge NSArray *)inItems;
                }
                
                if ( items ) {
                    [combo removeAllItems];
                    [combo addItemsWithObjectValues:items];
                }
            }
            
            // text
            if ( text ) [combo setStringValue:text];
            
            // rect
            if ( !NSIsEmptyRect( rect ) ) [combo setFrame:rect];
            
        } else {        // create
            // init
            combo = ComboBoxInit( inTag, inRect );
            
            // default autoresizing
            [combo setAutoresizingMask:NSViewMinYMargin];
            
            // enabled
            if ( inEnabled != kFBParamMissing ) [combo setEnabled:(BOOL)inEnabled];
            
            // items
            if ( inItems ) {
                NSArray *items = nil;
                
                if ( CFGetTypeID(inItems) == CFStringGetTypeID() ) {
                    items = [(__bridge NSString *)inItems componentsSeparatedByString:@";"];
                    
                } else if ( CFGetTypeID(inItems) == CFArrayGetTypeID() ) {
                    items = (__bridge NSArray *)inItems;
                }
                
                if ( items ) {
                    [combo addItemsWithObjectValues:items];
                }
            }
            
            // text
            if ( text ) [combo setStringValue:text];
            
            // wndTag
            [combo setWndTag:inWndTag];
            
            // add to window/popover/superview
            id superview = CUI_CurrentSuperview();
            if ( superview ) {
                [superview addSubview:combo];
            } else {
                [contentView addSubview:combo];
            }

        }
        
        [combo setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
}


