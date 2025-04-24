/*
 TextView.m

 Bernie Wylde
 */

#import "TextView.h"

#pragma mark - subclass
@implementation TextViewSC
- (void)drawRect:(NSRect)dirtyRect {
    CUI_ViewSubclassDrawRect( self, dirtyRect );
    if ( !DialogEventBool() ) [super drawRect:dirtyRect];
}

// required for key events
//- (BOOL)acceptsFirstResponder {
//    return YES;//self.responderFlag;
//}

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

- (BOOL)wantsUpdateLayer {
    return CUI_ViewSubclassWantsUpdateLayer( self );
}

- (void)updateLayer {
    CUI_ViewSubclassUpdateLayer( self );
}

#pragma mark - dragging
- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    return CUI_ViewSubclassDraggingEntered( self, sender );
}

- (void)draggingExited:(id <NSDraggingInfo>)sender {
    CUI_ViewSubclassDraggingExited( self, sender );
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    return CUI_ViewSubclassPerformDragOperation( self, sender );
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


@implementation CUI_TextViewDelegate

#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.fromRanges release];
    [self.toRanges release];
    [super dealloc];
}
#endif

- (void)textView:(NSTextView *)textView callUserDefinedOnDialogFunctionWithEvent:(NSInteger)event object:obj {
    NSInteger wndTag = [textView wndTag];
    CUI_OutputWindowSetTag( wndTag );
    CallUserDefinedOnDialogFunction( event, [textView tag], wndTag, (__bridge CFTypeRef)obj );
}


- (NSRange)textView:(NSTextView *)textView willChangeSelectionFromCharacterRange:(NSRange)oldSelectedCharRange toCharacterRange:(NSRange)newSelectedCharRange {
    self.fromRange = oldSelectedCharRange;
    self.toRange = newSelectedCharRange;
    [self textView:textView callUserDefinedOnDialogFunctionWithEvent:textViewWillChangeSelectionFromCharacterRange object:textView];
    return self.toRange;
}

// we can't have both this method and the one above
//- (NSArray<NSValue *> *)textView:(NSTextView *)textView willChangeSelectionFromCharacterRanges:(NSArray<NSValue *> *)oldSelectedCharRanges toCharacterRanges:(NSArray<NSValue *> *)newSelectedCharRanges {
//    fromRanges = oldSelectedCharRanges;
//    toRanges = newSelectedCharRanges;
//    [self textView:textView callUserDefinedOnDialogFunctionWithEvent:textViewWillChangeSelectionFromCharacterRanges object:nil];
//    return toRanges;
//}

- (BOOL)textView:(NSTextView *)textView shouldChangeTextInRange:(NSRange)affectedCharRange replacementString:(NSString *)replacementString {
    DialogEventSetBool( YES );
    DialogEventSetNSRange(affectedCharRange);
    DialogEventSetNSString(replacementString);
    [self textView:textView callUserDefinedOnDialogFunctionWithEvent:textViewShouldChangeTextInRange object:replacementString];
    return DialogEventBool();
}

- (void)textDidBeginEditing:(NSNotification *)notification {
    [self textView:notification.object callUserDefinedOnDialogFunctionWithEvent:textDidBeginEditing object:notification.object];
}

- (void)textDidChange:(NSNotification *)notification {
    [self textView:notification.object callUserDefinedOnDialogFunctionWithEvent:textDidChange object:notification.object];
}

- (void)textDidEndEditing:(NSNotification *)notification {
    [self textView:notification.object callUserDefinedOnDialogFunctionWithEvent:textDidEndEditing object:notification.object];
}

- (void)textViewDidChangeSelection:(NSNotification *)notification {
    [self textView:notification.object callUserDefinedOnDialogFunctionWithEvent:textViewDidChangeSelection object:notification.object];
}

- (NSSharingServicePicker *)textView:(NSTextView *)textView willShowSharingServicePicker:(NSSharingServicePicker *)servicePicker forItems:(NSArray *)items {
    DialogEventSetNSArray( items );
    DialogEventSetNSObject( servicePicker );
    [self textView:textView callUserDefinedOnDialogFunctionWithEvent:textViewWillShowSharingServicePicker object:items];
    return DialogEventNSObject();
}

- (BOOL)textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector {
    DialogEventSetBool( NO );
    DialogEventSetLong( CUI_ResponderCommandForSelector(commandSelector) );
    NSString *string = NSStringFromSelector(commandSelector);
    DialogEventSetNSString( string );
    [self textView:textView callUserDefinedOnDialogFunctionWithEvent:textViewDoCommandBySelector object:string];
    return DialogEventBool();
}

- (NSArray *)textView:(NSTextView *)textView completions:(NSArray *)words forPartialWordRange:(NSRange)charRange indexOfSelectedItem:(NSInteger *)index {
    DialogEventSetNSArray( words );
    DialogEventSetNSRange( charRange );
    DialogEventSetLong( *index );
    [self textView:textView callUserDefinedOnDialogFunctionWithEvent:textViewCompletions object:[[textView string] substringWithRange:charRange]];
     *index = DialogEventLong();
    return DialogEventNSArray();
}

// ...

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
- (void)textViewWritingToolsWillBegin:(NSTextView *)textView {
    [self textView:textView callUserDefinedOnDialogFunctionWithEvent:textViewWritingToolsWillBegin object:textView];
}

- (void)textViewWritingToolsDidEnd:(NSTextView *)textView {
    [self textView:textView callUserDefinedOnDialogFunctionWithEvent:textViewWritingToolsDidEnd object:textView];
}

- (NSArray *)textView:(NSTextView *)textView writingToolsIgnoredRangesInEnclosingRange:(NSRange)enclosingRange {
    DialogEventSetNSRange( enclosingRange );
    DialogEventSetNSArray( nil );
    [self textView:textView callUserDefinedOnDialogFunctionWithEvent:textViewWritingToolsIgnoredRangesInEnclosingRange object:textView];
    return DialogEventNSArray();
}
#endif // 150000

@end

CUI_TextViewDelegate *CUI_TextViewDelegateObj( void )
{
    static CUI_TextViewDelegate *sCUI_TextViewDelegate = nil;
    if ( !sCUI_TextViewDelegate ) sCUI_TextViewDelegate = [[CUI_TextViewDelegate alloc] init];
    return sCUI_TextViewDelegate;
}

CFRange TextViewEventFromRange( void )
{
    NSRange range = [CUI_TextViewDelegateObj() fromRange];
    return NSRangeToCFRange(range);
}

CFRange TextViewEventToRange( void )
{
    NSRange range = [CUI_TextViewDelegateObj() toRange];
    return NSRangeToCFRange(range);
}

void TextViewEventSetToRange( CFRange range )
{ [CUI_TextViewDelegateObj() setToRange:NSRangeFromCFRange(range)]; }

// textViewWillChangeSelectionFromCharacterRanges
CFArrayRef TextViewEventFromRanges( void )
{ return (__bridge CFArrayRef)[CUI_TextViewDelegateObj() fromRanges]; }

CFArrayRef TextViewEventToRanges( void )
{ return (__bridge CFArrayRef)[CUI_TextViewDelegateObj() toRanges]; }

void TextViewEventSetToRanges( CFArrayRef ranges )
{ [CUI_TextViewDelegateObj() setToRanges:(__bridge NSArray *)ranges]; }


@implementation NSTextView (Additions)
@dynamic tagNumber;

- (NSInteger)tag {
    return [objc_getAssociatedObject(self, @selector(tagNumber)) integerValue];
}

- (void)setTag:(NSInteger)tag {
    objc_setAssociatedObject(self, @selector(tagNumber), [NSNumber numberWithInteger:tag], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end


// Functions
// Class
Class TextViewClass( void )
{ return [NSTextView class]; }

NSTextView *TextViewWithTag( NSInteger tag )
{ return (NSTextView *)CUI_ValidateViewKindOfClass( tag, [NSTextView class] ); }

BOOL TextViewExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSTextView class] ); }

void TextViewRegisterForServices( void )
{ [NSTextView registerForServices]; }

// Accessing text system objects
NSTextContainer *TextViewTextContainer( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView textContainer];
    return nil;
}

void TextViewSetTextContainer( NSInteger tag, NSTextContainer *tc )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setTextContainer:tc];
}

void TextViewReplaceTextContainer( NSInteger tag, NSTextContainer *tc )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView replaceTextContainer:tc];
}

CGSize TextViewTextContainerInset( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return NSSizeToCGSize([textView textContainerInset]);
    return CGSizeZero;
}

void TextViewSetTextContainerInset( NSInteger tag, CGSize inset )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setTextContainerInset:NSSizeFromCGSize(inset)];
}

CGPoint TextViewTextContainerOrigin( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return NSPointToCGPoint([textView textContainerOrigin]);
    return CGPointZero;
}

void TextViewInvalidateTextContainerOrigin( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView invalidateTextContainerOrigin];
}

NSColor *TextViewBackgroundColor( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView backgroundColor];
    return nil;
}

void TextViewSetBackgroundColor( NSInteger tag, NSColor *col )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setBackgroundColor:col];
}

BOOL TextViewDrawsBackground( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView drawsBackground];
    return NO;
}

void TextViewSetDrawsBackground( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setDrawsBackground:flag];
}

BOOL TextViewAllowsDocumentBackgroundColorChange( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView allowsDocumentBackgroundColorChange];
    return NO;
}

void TextViewSetAllowsDocumentBackgroundColorChange( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setAllowsDocumentBackgroundColorChange:flag];
}

void TextViewChangeDocumentBackgroundColor( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView changeDocumentBackgroundColor:nil];
}

// Controlling display
void TextViewShowFindIndicatorForRange( NSInteger tag, CFRange range )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView showFindIndicatorForRange:NSRangeFromCFRange(range)];
}

// Inserting text
CFArrayRef TextViewAllowedInputSourceLocales( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return (__bridge CFArrayRef)[textView allowedInputSourceLocales];
    return nil;
}

BOOL TextViewIsEditable( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView isEditable];
    return NO;
}

void TextViewSetEditable( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setEditable:flag];
}

BOOL TextViewIsSelectable( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView isSelectable];
    return NO;
}

void TextViewSetSelectable( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setSelectable:flag];
}

BOOL TextViewIsFieldEditor( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView isFieldEditor];
    return NO;
}

void TextViewSetFieldEditor( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setFieldEditor:flag];
}


BOOL TextViewUsesRuler( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView usesRuler];
    return NO;
}

void TextViewSetUsesRuler( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setUsesRuler:flag];
}

BOOL TextViewIsRulerVisible( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView isRulerVisible];
    return NO;
}

void TextViewSetRulerVisible( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setRulerVisible:flag];
}

BOOL TextViewUsesInspectorBar( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView usesInspectorBar];
    return NO;
}

void TextViewSetUsesInspectorBar( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setUsesInspectorBar:flag];
}

CFArrayRef TextViewSelectedRanges( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return (__bridge CFArrayRef)[textView selectedRanges];
    return nil;
}

void TextViewSetSelectedRanges( NSInteger tag, CFArrayRef ranges )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setSelectedRanges:(__bridge NSArray *)ranges];
}

void TextViewSetSelectedRange( NSInteger tag, CFRange range )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        [textView setSelectedRange:NSRangeFromCFRange(range)];
    }
}

void TextViewSetSelectedRangeAffinity( NSInteger tag, CFRange range, NSSelectionAffinity affinity, BOOL stillSelecting )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        [textView setSelectedRange:NSRangeFromCFRange(range) affinity:affinity stillSelecting:stillSelecting];
    }
}

NSSelectionAffinity TextViewSelectionAffinity( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        return [textView selectionAffinity];
    }
    return 0;
}

NSSelectionGranularity TextViewSelectionGranularity( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        return [textView selectionGranularity];
    }
    return 0;
}

void TextViewSetSelectionGranularity( NSInteger tag, NSSelectionGranularity granularity )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        [textView setSelectionGranularity:granularity];
    }
}

NSColor *TextViewInsertionPointColor( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        return [textView insertionPointColor];
    }
    return nil;
}

void TextViewSetInsertionPointColor( NSInteger tag, NSColor *col )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        [textView setInsertionPointColor:col];
    }
}

CFDictionaryRef TextViewSelectedTextAttributes( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        return (__bridge CFDictionaryRef)[textView selectedTextAttributes];
    }
    return nil;
}

void TextViewSetSelectedTextAttributes( NSInteger tag, CFDictionaryRef attributes )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        [textView setSelectedTextAttributes:(__bridge NSDictionary *)attributes];
    }
}

CFDictionaryRef TextViewMarkedTextAttributes( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        return (__bridge CFDictionaryRef)[textView markedTextAttributes];
    }
    return nil;
}

void TextViewSetMarkedTextAttributes( NSInteger tag, CFDictionaryRef attributes )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        [textView setMarkedTextAttributes:(__bridge NSDictionary *)attributes];
    }
}

CFDictionaryRef TextViewLinkTextAttributes( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        return (__bridge CFDictionaryRef)[textView linkTextAttributes];
    }
    return nil;
}

void TextViewSetLinkTextAttributes( NSInteger tag, CFDictionaryRef attributes )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        [textView setLinkTextAttributes:(__bridge NSDictionary *)attributes];
    }
}

NSUInteger TextViewCharacterIndexForInsertionAtPoint( NSInteger tag, CGPoint pt )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        return [textView characterIndexForInsertionAtPoint:NSPointFromCGPoint(pt)];
    }
    return 0;
}

// Managing the pasteboard
CFArrayRef TextViewReadablePasteboardTypes( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        return (__bridge CFArrayRef)[textView readablePasteboardTypes];
    }
    return nil;
}

CFArrayRef TextViewWritablePasteboardTypes( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        return (__bridge CFArrayRef)[textView writablePasteboardTypes];
    }
    return nil;
}

// Text attributes
void TextViewAlignJustified( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView alignJustified:nil];
}

void TextViewChangeAttributes( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView changeAttributes:nil];
}

void TextViewChangeColor( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView changeColor:nil];
}

void TextViewSetAlignment( NSInteger tag, NSTextAlignment alignment, CFRange range )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setAlignment:alignment range:NSRangeFromCFRange(range)];
}

CFDictionaryRef TextViewTypingAttributes( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return (__bridge CFDictionaryRef)[textView typingAttributes];
    return nil;
}

void TextViewSetTypingAttributes( NSInteger tag, CFDictionaryRef attributes )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setTypingAttributes:(__bridge NSDictionary *)attributes];
}

void TextViewUseStandardKerning( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView useStandardKerning:nil];
}

void TextViewLowerBaseline( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView lowerBaseline:nil];
}

void TextViewRaiseBaseline( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView raiseBaseline:nil];
}

void TextViewTurnOffKerning( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView turnOffKerning:nil];
}

void TextViewLoosenKerning( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView loosenKerning:nil];
}

void TextViewTightenKerning( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView tightenKerning:nil];
}

void TextViewUseStandardLigatures( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView useStandardLigatures:nil];
}

void TextViewTurnOffLigatures( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView turnOffLigatures:nil];
}

void TextViewUseAllLigatures( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView useAllLigatures:nil];
}

// Clicking and pasting
void TextViewPasteAsPlainText( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView pasteAsPlainText:nil];
}

void TextViewPasteAsRichText( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView pasteAsRichText:nil];
}

// Undo support
void TextViewBreakUndoCoalescing( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView breakUndoCoalescing];
}

BOOL TextViewIsCoalescingUndo( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView isCoalescingUndo];
    return NO;
}

CFRange TextViewRangeForUserTextChange( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        return NSRangeToCFRange([textView rangeForUserTextChange]);
    }
    return CFRangeMake(NSNotFound,0);
}

// Spell checker
BOOL TextViewIsContinuousSpellCheckingEnabled( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        return [textView isContinuousSpellCheckingEnabled];
    }
    return NO;
}

void TextViewSetContinuousSpellCheckingEnabled( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setContinuousSpellCheckingEnabled:flag];
}

void TextViewToggleContinuousSpellChecking( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        [textView toggleContinuousSpellChecking:nil];
    }
}

BOOL TextViewIsGrammarCheckingEnabled( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        return [textView isGrammarCheckingEnabled];
    }
    return NO;
}

void TextViewSetGrammarCheckingEnabled( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setGrammarCheckingEnabled:flag];
}

void TextViewToggleGrammarChecking( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        [textView toggleGrammarChecking:nil];
    }
}

void TextViewSetSpellingState( NSInteger tag, NSInteger value, CFRange range )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        [textView setSpellingState:value range:NSRangeFromCFRange(range)];
    }
}

// Sharing service picker
void TextViewOrderFrontSharingServicePicker( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView orderFrontSharingServicePicker:nil];
}

void TextViewStartSpeaking( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView startSpeaking:nil];
}

void TextViewStopSpeaking( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView stopSpeaking:nil];
}

void TextViewSetUsesFontPanel( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setUsesFontPanel:flag];
}

void TextViewSetUsesFindPanel( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setUsesFindPanel:flag];
}

void TextViewSetUsesFindBar( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setUsesFindBar:flag];
}

BOOL TextViewIsIncrementalSearchingEnabled( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView isIncrementalSearchingEnabled];
    return NO;
}

void TextViewSetIncrementalSearchingEnabled( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setIncrementalSearchingEnabled:flag];
}

void TextViewOrderFrontLinkPanel( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView orderFrontLinkPanel:nil];
}

void TextViewOrderFrontListPanel( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView orderFrontListPanel:nil];
}

void TextViewOrderFrontSpacingPanel( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView orderFrontSpacingPanel:nil];
}

void TextViewOrderFrontTablePanel( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView orderFrontTablePanel:nil];
}

void TextViewOrderFrontSubstitutionsPanel( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView orderFrontSubstitutionsPanel:nil];
}

// Text completion
void TextViewComplete( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView complete:nil];
}

CFArrayRef TextViewCompletions( NSInteger tag, CFRange partialWordRange, NSInteger *indexOfSelectedItem )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return (__bridge CFArrayRef)[textView completionsForPartialWordRange:NSRangeFromCFRange(partialWordRange) indexOfSelectedItem:indexOfSelectedItem];
    return nil;
}

void TextViewInsertCompletion( NSInteger tag, CFStringRef word, CFRange partialWordRange, NSInteger movement, BOOL isFinal )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView insertCompletion:(__bridge NSString *)word forPartialWordRange:NSRangeFromCFRange( partialWordRange) movement:movement isFinal:isFinal];
}

CFRange TextViewRangeForUserCompletion( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return NSRangeToCFRange( [textView rangeForUserCompletion] );
    return CFRangeMake(NSNotFound,0);
}


// Supporting quicklook
void TextViewUpdateQuickLookPreviewPanel( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView updateQuickLookPreviewPanel];
}

void TextViewToggleQuickLookPreviewPanel( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView toggleQuickLookPreviewPanel:nil];
}

CFArrayRef TextViewQuickLookPreviewableItemsInRanges( NSInteger tag, CFArrayRef ranges )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return (__bridge CFArrayRef)[textView quickLookPreviewableItemsInRanges:(__bridge NSArray *)ranges];
    return nil;
}

NSLayoutManager *TextViewLayoutManager( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView layoutManager];
    return nil;
}

//CFMutableAttributedStringRef TextViewTextStorage( NSInteger tag )
//{
//    NSTextView *textView = TextViewWithTag( tag );
//    if ( textView ) return (__bridge CFMutableAttributedStringRef)[textView textStorage];
//    return NULL;
//}

NSTextStorage *TextViewTextStorage( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView textStorage];
    return nil;
}

BOOL TextViewIsRichText( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView isRichText];
    return NO;
}

void TextViewSetRichText( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setRichText:flag];
}

BOOL TextViewAllowsUndo( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView allowsUndo];
    return NO;
}

void TextViewSetAllowsUndo( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setAllowsUndo:flag];
}

BOOL TextViewImportsGraphics( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView importsGraphics];
    return NO;
}

void TextViewSetImportsGraphics( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setImportsGraphics:flag];
}

void TextViewSetBaseWritingDirection( NSInteger tag, NSWritingDirection direction )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setBaseWritingDirection:direction];
}

NSParagraphStyle *TextViewDefaultParagraphStyle( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView defaultParagraphStyle];
    return nil;
}

void TextViewSetDefaultParagraphStyle( NSInteger tag, NSParagraphStyle *style )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setDefaultParagraphStyle:style];
}

void TextViewOutline( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView outline:nil];
}

BOOL TextViewAllowsImageEditing( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView allowsImageEditing];
    return NO;
}

void TextViewSetAllowsImageEditing( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setAllowsImageEditing:flag];
}

BOOL TextViewIsAutomaticLinkDetectionEnabled( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView isAutomaticLinkDetectionEnabled];
    return NO;
}

void TextViewSetAutomaticLinkDetectionEnabled( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setAutomaticLinkDetectionEnabled:flag];
}

void TextViewToggleAutomaticLinkDetection( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView toggleAutomaticLinkDetection:nil];
}

BOOL TextViewDisplaysLinkToolTips( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView displaysLinkToolTips];
    return NO;
}

void TextViewSetDisplaysLinkToolTips( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setDisplaysLinkToolTips:flag];
}

BOOL TextViewIsAutomaticQuoteSubstitutionEnabled( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView isAutomaticQuoteSubstitutionEnabled];
    return NO;
}

void TextViewSetAutomaticQuoteSubstitutionEnabled( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setAutomaticQuoteSubstitutionEnabled:flag];
}

void TextViewToggleAutomaticQuoteSubstitution( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView toggleAutomaticQuoteSubstitution:nil];
}



BOOL TextViewUsesFontPanel( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView usesFontPanel];
    return NO;
}

// Changing layout orientation
void TextViewChangeLayoutOrientation( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView changeLayoutOrientation:nil];
}

void TextViewSetLayoutOrientation( NSInteger tag, NSTextLayoutOrientation orientation )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setLayoutOrientation:orientation];
}

BOOL TextViewUsesFindPanel( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView usesFindPanel];
    return NO;
}

BOOL TextViewUsesFindBar( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView usesFindBar];
    return NO;
}

// Instance properties
BOOL TextViewIsAutomaticTextCompletionEnabled( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView isAutomaticTextCompletionEnabled];
    return NO;
}

void TextViewSetAutomaticTextCompletionEnabled( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setAutomaticTextCompletionEnabled:flag];
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
BOOL TextViewUsesAdaptiveColorMappingForDarkAppearance( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView usesAdaptiveColorMappingForDarkAppearance];
    return NO;
}

void TextViewSetUsesAdaptiveColorMappingForDarkAppearance( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setUsesAdaptiveColorMappingForDarkAppearance:flag];
}
#endif// 101500

BOOL TextViewUsesRolloverButtonForSelection( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView usesRolloverButtonForSelection];
    return NO;
}

void TextViewSetUsesRolloverButtonForSelection( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setUsesRolloverButtonForSelection:flag];
}

// Type properties
BOOL TextViewStronglyReferencesTextStorage( void )
{ return [NSTextView stronglyReferencesTextStorage]; }

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
BOOL TextViewPerformValidatedReplacementInRange( NSInteger tag, CFRange range, CFAttributedStringRef attributedString )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return [textView performValidatedReplacementInRange:NSRangeFromCFRange(range) withAttributedString:(__bridge NSAttributedString *)attributedString];
    return NO;
}
#endif// 101400

void TextViewToggleAutomaticTextCompletion( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView toggleAutomaticTextCompletion:nil];
}

void TextViewUpdateCandidates( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView updateCandidates];
}

// Type methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
CFTypeRef TextViewFieldEditor( void )
{ return (__bridge CFTypeRef)[NSTextView fieldEditor]; }

NSScrollView *TextViewScrollableDocumentContentTextView( void )
{ return [NSTextView scrollableDocumentContentTextView]; }

NSScrollView *TextViewScrollablePlainDocumentContentTextView( void )
{ return [NSTextView scrollablePlainDocumentContentTextView]; }

NSScrollView *TextViewScrollableTextView( void )
{ return [NSTextView scrollableTextView]; }
#endif// 101400

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
NSTextInputTraitType TextViewInlinePredictionType( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView inlinePredictionType];
    return 0;
}

void TextViewSetInlinePredictionType( NSInteger tag, NSTextInputTraitType type )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setInlinePredictionType:type];
}
#endif // 140000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
NSTextInputTraitType TextViewMathExpressionCompletionType( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView mathExpressionCompletionType];
    return 0;
}

void TextViewSetMathExpressionCompletionType( NSInteger tag, NSTextInputTraitType type )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setMathExpressionCompletionType:type];
}

CFDictionaryRef TextViewTextHighlightAttributes( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return (__bridge CFDictionaryRef)[textView textHighlightAttributes];
    return nil;
}

void TextViewSetTextHighlightAttributes( NSInteger tag, CFDictionaryRef attributes )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView setTextHighlightAttributes:(__bridge NSDictionary *)attributes];
}

void TextViewDrawTextHighlightBackgroundForTextRange( NSInteger tag, NSTextRange *textRange, CGPoint origin )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView drawTextHighlightBackgroundForTextRange:textRange origin:NSPointFromCGPoint(origin)];
}

void TextViewHighlight( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView highlight:nil];
}

#endif // 150000


#pragma mark - Responder action messages
void TextViewScrollToEndOfDocument( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) [textView scrollToEndOfDocument:nil];
}



// custom
void TextViewPerformFindPanelAction( NSInteger tag, NSTextFinderAction action )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        NSControl *c = [[NSControl alloc] init];
        [c setTag:action];
        [textView performFindPanelAction:c];
#if !__has_feature(objc_arc)
        [c release];
#endif
    }
}

BOOL TextViewIsFindBarVisible( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        NSScrollView *scrollView = [textView enclosingScrollView];
        if ( scrollView ) {
            return [scrollView isFindBarVisible];
        }
    }
    return NO;
}

void TextViewSetWordWrap( NSInteger tag, BOOL flag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        NSTextContainer *tc = [textView textContainer];
        if ( flag ) {
            NSScrollView *scrollView = [textView enclosingScrollView];
            if ( scrollView ) {
                NSSize size = [scrollView contentSize];
                [tc setWidthTracksTextView:YES];
                [tc setContainerSize:NSMakeSize(size.width, DBL_MAX)];
                [textView setHorizontallyResizable:NO];
                [textView setFrame:NSMakeRect(0,0,size.width,size.height)];
            }
        } else {
            [tc setWidthTracksTextView:NO];
            [tc setContainerSize:NSMakeSize(DBL_MAX,DBL_MAX)];
            [textView setMaxSize:NSMakeSize(DBL_MAX,DBL_MAX)];
            [textView setHorizontallyResizable:YES];
        }
    }
}

CFMutableAttributedStringRef TextViewMutableAttributedString( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return (__bridge CFMutableAttributedStringRef)[textView textStorage];
    return nil;
}

CFAttributedStringRef TextViewAttributedString( NSInteger tag )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) return (__bridge CFAttributedStringRef)[textView attributedString];
    return nil;
}

void TextViewSetLinkInRange( NSInteger tag, CFTypeRef link, CFRange range )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        NSTextStorage *aString = [textView textStorage];
        [aString addAttribute:NSLinkAttributeName value:(__bridge id)link range:NSRangeFromCFRange(range)];
    }
}

void TextViewSetLink( NSInteger tag, CFTypeRef link )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        NSTextStorage *aString = [textView textStorage];
        [aString addAttribute:NSLinkAttributeName value:(__bridge id)link range:NSMakeRange(0,[aString length])];
    }
}

void TextViewAppendString( NSInteger tag, CFStringRef string )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        //[[[textView textStorage] mutableString] appendString:(__bridge NSString *)string];
        
        // replacement for above line ensures text is correct attributes 20250309
        NSDictionary *attributes = [textView typingAttributes];
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:(__bridge NSString *)string attributes:attributes];
        [[textView textStorage] appendAttributedString:attributedText];

    }
}

void TextViewSetTextBackgroundColor( NSInteger tag, NSColor *col )
{
    NSTextView *textView = TextViewWithTag( tag );
    if ( textView ) {
        NSTextStorage *ts = [textView textStorage];
        [ts addAttribute:NSBackgroundColorAttributeName value:col range:NSMakeRange(0,[ts length])];
    }
}


// Init
NSTextView *TextViewInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) rect = NSMakeRect( 20, 20, 240, 135 );
    
    // subclass
    BOOL subclass = CUI_IsSubclassFlag();

    // init
    NSTextView *textView;
#if __has_feature(objc_arc)
    if ( subclass ) {
        textView = [[TextViewSC alloc] initWithFrame:rect];
    } else {
        textView = [[NSTextView alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        textView = [[[TextViewSC alloc] initWithFrame:rect] autorelease];
    } else {
        textView = [[[NSTextView alloc] initWithFrame:rect] autorelease];
    }
#endif
    
//#if !__has_feature(objc_arc)
//    [textView autorelease];
//#endif
    
    // vertically resizable
    [textView setVerticallyResizable:YES];

    // max size
    [textView setMaxSize:NSMakeSize(DBL_MAX, DBL_MAX)];

    // default to allows undo
    [textView setAllowsUndo:YES];

    // tag
    [textView setTag:inTag];
    
    // delegate
    [textView setDelegate:CUI_TextViewDelegateObj()];
    
    return textView;
}

// Statement
void CUI_TextView( NSInteger inTag, CGRect inRect, NSInteger inScrollTag, NSTextContainer *tc, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSTextView *textView = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !textView ) {
            textView = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( textView ) {    // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            // make sure it's same view class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, textView, [NSTextView class] ) ) {
                return;
            }

            // rect
            if ( !NSIsEmptyRect( rect ) ) [textView setFrame:rect];
            
        } else {            // create
            
            NSScrollView *scrollView = nil;
            if ( inScrollTag ) {
                scrollView = CUI_ViewSubviewWithTag( contentView, inScrollTag );
                
                if ( !scrollView ) {
                    scrollView = TitlebarAccessoryViewWithTag( inTag );
                }
                
            }
            
            // rect
            if ( NSIsEmptyRect( rect ) ) {
                if ( scrollView ) {
                    NSSize size = [scrollView contentSize];
                    rect = NSMakeRect( 0, 0, size.width, size.height );
                } else {
                    rect = NSMakeRect( 20, 20, 240, 135 );
                }
            }
            
            // init
            if ( tc ) {
                if ( CUI_IsSubclassFlag() ) {
                    textView = [[TextViewSC alloc] initWithFrame:rect textContainer:tc];
                } else {
                    textView = [[NSTextView alloc] initWithFrame:rect textContainer:tc];
                }
#if !__has_feature(objc_arc)
                [textView  autorelease];
#endif
                [textView setAllowsUndo:YES];
                [textView setMaxSize:NSMakeSize(DBL_MAX, DBL_MAX)];
                [textView setTag:inTag];
                [textView setDelegate:CUI_TextViewDelegateObj()];
            } else {
                textView = TextViewInit( inTag, NSRectToCGRect(rect) );
            }
            
            // autoresizing
            [textView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
            
            // add to superview
            if ( scrollView ) {
                [scrollView setDocumentView:textView];
            } else {
                [contentView addSubview:textView];
            }
            
            // wndTag
            [textView setWndTag:inWndTag];            
        }
        [textView setHidden:!show];
    } else {
        CUI_ShowAlert( NSWarningAlertStyle, @"Window error.", [NSString stringWithFormat:@"Window %ld does not exist.",(long)inWndTag] );
    }
}

