/*
 TextField.m

 Bernie Wylde
 */

#import "TextField.h"

#pragma mark - subclass
@implementation TextFieldSC
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

#pragma mark - menu
- (NSMenu *)menuForEvent:(NSEvent*)theEvent {
    CUI_ViewSubclassMenuForEvent( self, theEvent );
    return DialogEventNSMenu();
}


#pragma mark - custom
- (void)textViewDidChangeSelection:(NSNotification *)notification {
    CUI_ControlCallUserDefinedOnDialogOrCallback( textFieldDidChangeSelection, self, [notification object] );
}

@end

@implementation CUI_TextFieldDelegate
- (void)textFieldAction:(id)sender {
    CUI_ControlCallUserDefinedOnDialogOrCallback( 1, sender, NULL );// 1 = _btnClick
}

- (void)controlTextDidBeginEditing:(NSNotification *)notification {
    CUI_ControlCallUserDefinedOnDialogOrCallback( textFieldDidBeginEditing, notification.object, notification );
}

- (void)controlTextDidChange:(NSNotification *)notification {
    CUI_ControlCallUserDefinedOnDialogOrCallback( textFieldDidChange, notification.object, notification );
}

- (void)controlTextDidEndEditing:(NSNotification *)notification {
    CUI_ControlCallUserDefinedOnDialogOrCallback( textFieldDidEndEditing, notification.object, notification );
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

- (BOOL)control:(NSControl *)control textView:(NSTextView *)fieldEditor doCommandBySelector:(SEL)commandSelector {
    DialogEventSetBool( NO );
    DialogEventSetLong( CUI_ResponderCommandForSelector(commandSelector) );
    NSString *string = NSStringFromSelector(commandSelector);
    DialogEventSetNSString( string );
    CUI_ControlCallUserDefinedOnDialogOrCallback( controlDoCommandBySelector, control, string );
    return DialogEventBool();
}

//- (NSArray<NSTextCheckingResult *> *)textField:(NSTextField *)textField textView:(NSTextView *)textView candidates:(NSArray<NSTextCheckingResult *> *)candidates forSelectedRange:(NSRange)selectedRange {
//    
//    return nil;
//}
//
//- (NSArray *)textField:(NSTextField *)textField textView:(NSTextView *)textView candidatesForSelectedRange:(NSRange)selectedRange {
//    
//    return nil;
//}
//
//- (BOOL)textField:(NSTextField *)textField textView:(NSTextView *)textView shouldSelectCandidateAtIndex:(NSUInteger)index {
//    
//    return NO;
//}

@end

CUI_TextFieldDelegate *CUI_TextFieldDelegateObj( void )
{
    static CUI_TextFieldDelegate *sCUI_TextFieldDelegate = nil;
    if ( !sCUI_TextFieldDelegate ) sCUI_TextFieldDelegate = [[CUI_TextFieldDelegate alloc] init];
    return sCUI_TextFieldDelegate;
}

// Class
Class TextFieldClass( void )
{ return [NSTextField class]; }

NSTextField *TextFieldWithTag( NSInteger tag )
{ return (NSTextField *)CUI_ValidateViewKindOfClass( tag, [NSTextField class] ); }

BOOL TextFieldExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSTextField class] ); }

// Selection and editing
BOOL TextFieldIsEditable( NSInteger tag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) return [fld isEditable];
    return NO;
}

void TextFieldSetEditable( NSInteger tag, BOOL flag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) [fld setEditable:flag];
}

BOOL TextFieldIsSelectable( NSInteger tag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) return [fld isSelectable];
    return NO;
}

void TextFieldSetSelectable( NSInteger tag, BOOL flag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) [fld setSelectable:flag];
}

// Rich text behavior
BOOL TextFieldAllowsEditingTextAttributes( NSInteger tag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) return [fld allowsEditingTextAttributes];
    return NO;
}

void TextFieldSetAllowsEditingTextAttributes( NSInteger tag, BOOL flag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) [fld setAllowsEditingTextAttributes:flag];
}

BOOL TextFieldImportsGraphics( NSInteger tag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) return [fld importsGraphics];
    return NO;
}

void TextFieldSetImportsGraphics( NSInteger tag, BOOL flag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) [fld setImportsGraphics:flag];
}

// Text color
NSColor *TextFieldTextColor( NSInteger tag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) return [fld textColor];
    return nil;
}

void TextFieldSetTextColor( NSInteger tag, NSColor *col )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) [fld setTextColor:col];
}

// Autolayout sizing
CGFloat TextFieldPreferredMaxLayoutWidth( NSInteger tag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) return [fld preferredMaxLayoutWidth];
    return 0.0;
}

void TextFieldSetPreferredMaxLayoutWidth( NSInteger tag, CGFloat width )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) [fld setPreferredMaxLayoutWidth:width];
}

// Background
NSColor *TextFieldBackgroundColor( NSInteger tag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) return [fld backgroundColor];
    return nil;
}

void TextFieldSetBackgroundColor( NSInteger tag, NSColor *col )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) [fld setBackgroundColor:col];
}

BOOL TextFieldDrawsBackground( NSInteger tag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) return [fld drawsBackground];
    return NO;
}

void TextFieldSetDrawsBackground( NSInteger tag, BOOL flag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) [fld setDrawsBackground:flag];
}

// Border
BOOL TextFieldIsBezeled( NSInteger tag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) return [fld isBezeled];
    return NO;
}

void TextFieldSetBezeled( NSInteger tag, BOOL flag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) [fld setBezeled:flag];
}

NSTextFieldBezelStyle TextFieldBezelStyle( NSInteger tag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) return [fld bezelStyle];
    return NO;
}

void TextFieldSetBezelStyle( NSInteger tag, NSTextFieldBezelStyle style )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) [fld setBezelStyle:style];
}

BOOL TextFieldIsBordered( NSInteger tag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) return [fld isBordered];
    return NO;
}

void TextFieldSetBordered( NSInteger tag, BOOL flag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) [fld setBordered:flag];
}

// Selecting text
void TextFieldSelectText( NSInteger tag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) [fld selectText:nil];
}

// Responder
BOOL TextFieldAcceptsFirstResponder( NSInteger tag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) return [fld acceptsFirstResponder];
    return NO;
}

// Instance properties
BOOL TextFieldAllowsDefaultTighteningForTruncation( NSInteger tag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) return [fld allowsDefaultTighteningForTruncation];
    return NO;
}

void TextFieldSetAllowsDefaultTighteningForTruncation( NSInteger tag, BOOL flag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) [fld setAllowsDefaultTighteningForTruncation:flag];
}

BOOL TextFieldIsAutomaticTextCompletionEnabled( NSInteger tag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) return [fld isAutomaticTextCompletionEnabled];
    return NO;
}

void TextFieldSetAutomaticTextCompletionEnabled( NSInteger tag, BOOL flag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) [fld setAutomaticTextCompletionEnabled:flag];
}

NSInteger TextFieldMaximumNumberOfLines( NSInteger tag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) return [fld maximumNumberOfLines];
    return 0;
}

void TextFieldSetMaximumNumberOfLines( NSInteger tag, NSInteger lines )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) [fld setMaximumNumberOfLines:lines];
}

CFAttributedStringRef TextFieldPlaceholderAttributedString( NSInteger tag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) return (__bridge CFAttributedStringRef)[fld placeholderAttributedString];
    return nil;
}

void TextFieldSetPlaceholderAttributedString( NSInteger tag, CFAttributedStringRef string )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) [fld setPlaceholderAttributedString:(__bridge NSAttributedString *)string];
}

CFStringRef TextFieldPlaceholderString( NSInteger tag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) return (__bridge CFStringRef)[fld placeholderString];
    return nil;
}

void TextFieldSetPlaceholderString( NSInteger tag, CFStringRef string )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) {
        if ( [fld respondsToSelector:@selector(setPlaceholderString:)] ) {
            [fld setPlaceholderString:(__bridge NSString *)string];
        }
    }
}

// Line wrapping
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
NSLineBreakStrategy TextFieldLineBreakStrategy( NSInteger tag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) return [fld lineBreakStrategy];
    return 0;
}
void TextFieldSetLineBreakStrategy( NSInteger tag, NSLineBreakStrategy strategy )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld )  [fld setLineBreakStrategy:strategy];
}
#endif// 110000

// Cell methods
BOOL TextFieldSendsActionOnEndEditing( NSInteger tag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) return [[fld cell] sendsActionOnEndEditing];
    return NO;
}

void TextFieldSetSendsActionOnEndEditing( NSInteger tag, BOOL flag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) [[fld cell] setSendsActionOnEndEditing:flag];
}

BOOL TextFieldAllowsUndo( NSInteger tag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) return [[fld cell] allowsUndo];
    return NO;
}

void TextFieldSetAllowsUndo( NSInteger tag, BOOL flag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) [[fld cell] setAllowsUndo:flag];
}

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150200
BOOL TextFieldAllowsWritingTools( NSInteger tag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) return [fld allowsWritingTools];
    return NO;
}

void TextFieldSetAllowsWritingTools( NSInteger tag, BOOL flag )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) [fld setAllowsWritingTools:flag];
}

#endif// 150200

// Convenience
CFRange TextFieldSelectedRange( NSInteger tag )
{
    CFRange range = {0,0};
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) {
        NSText *fldEditor = [fld currentEditor];
        NSRange nsRange = [fldEditor selectedRange];
        range.location = nsRange.location;
        range.length = nsRange.length;
    }
    return range;
}

void TextFieldSetSelectedRange( NSInteger tag, CFRange range )
{
    NSTextField *fld = TextFieldWithTag( tag );
    if ( fld ) {
        NSText *fldEditor = [fld currentEditor];
        [fldEditor setSelectedRange:NSRangeFromCFRange(range)];
    }
}


// Init
NSTextField *TextFieldInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) rect = NSMakeRect( 20, 20, 96, 22 );

    // subclass
    BOOL subclass = CUI_IsSubclassFlag();

    // init
    NSTextField *fld;
    
#if __has_feature(objc_arc)
    if ( subclass ) {
        fld = [[TextFieldSC alloc] initWithFrame:rect];
    } else {
        fld = [[NSTextField alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        fld = [[[TextFieldSC alloc] initWithFrame:rect] autorelease];
    } else {
        fld = [[[NSTextField alloc] initWithFrame:rect] autorelease];
    }
#endif
    
    // tag
    [fld setTag: inTag];

    // fix font to match I.B.
    CUI_ControlFixFont( fld );
    
    // delegate
    [fld setDelegate:CUI_TextFieldDelegateObj()];
    
    // target/action (to intercept mouse clicks)
    [fld setTarget:CUI_TextFieldDelegateObj()];
    [fld setAction:@selector(textFieldAction:)];
    [[fld cell] setSendsActionOnEndEditing:YES];
    
    return fld;
}


// Statement
void CUI_TextField( NSInteger inTag, NSInteger inEnabled, CFStringRef inText, CGRect inRect, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    //BOOL wndTagFlag = inWndTag != kFBParamMissing; // 20250226

    NSString *text = (__bridge NSString *)inText;
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
        
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSTextField *fld = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !fld ) {
            fld = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( fld ) {    // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);
            
//            if ( wndTagFlag ) { // 20250226
//                if ( !CUI_ValidateViewClass( inWndTag, inTag, fld, [NSTextField class] ) ) {
//                    return;
//                }
//            } else {
//                // make sure it's same view class. if not, search all windows; front to back
//                fld = CUI_ViewWithKindOfClassInAnyWindow( inTag, [NSTextField class] ); // 20250217
//                if ( fld ) {
//                    inWndTag = [[fld window] tag];
//                } else {
//                    return;
//                }
//            }

            // make sure it's same view class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, fld, [NSTextField class] ) ) {
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
            fld = TextFieldInit( inTag, inRect );
            
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

