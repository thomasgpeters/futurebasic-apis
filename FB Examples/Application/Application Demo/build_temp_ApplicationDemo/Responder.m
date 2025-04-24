/*
 Responder.m

 Bernie Wylde
 */

#import "Responder.h"

@implementation CUI_ResponderTarget

// command for selector
NSInteger CUI_ResponderCommandForSelector( SEL selector )
{
    if ( selector == @selector(complete:) ) {
        return selectorComplete;
    } else if ( selector == @selector(deleteBackward:) ) {
        return selectorDeleteBackward;
    } else if ( selector == @selector(insertBacktab:) ) {
        return selectorInsertBacktab;
    } else if ( selector == @selector(insertNewline:) ) {
        return selectorInsertNewline;
    } else if ( selector == @selector(insertTab:) ) {
        return selectorInsertTab;
    } else if ( selector == @selector(moveLeft:) ) {
        return selectorMoveLeft;
    } else if ( selector == @selector(moveRight:) ) {
        return selectorMoveRight;
    }
    // .....
    return 0;
}


static CUI_ResponderTarget *sCUI_ResponderTarget;

- (void)didPresentErrorWithRecovery:(BOOL)didRecover contextInfo:(void *)contextInfo {
    DialogEventSetBool( didRecover );
    DialogEventSetContext( contextInfo );
    NSInteger wndTag = CUI_OutputWindowTag();
    CallUserDefinedOnDialogFunction( responderDidPresentError, 0, wndTag, nil );
}
@end


#pragma mark - forward events
void CUI_ResponderForwardWindowDialogEvent( NSWindow *w, NSInteger dialogEvent, NSEvent *event )
{
    CUI_EventSetEvent( event );
    NSInteger wndTag = [w tag];
    CUI_OutputWindowSetTag( wndTag );
    CallUserDefinedOnDialogFunction( dialogEvent, wndTag, wndTag, (__bridge CFTypeRef)event );
    CUI_EventSetEvent( nil );
}

void CUI_ResponderForwardViewDialogEvent( NSView *view, NSInteger dialogEvent, NSEvent *event )
{
    CUI_EventSetEvent( event );
    NSInteger viewTag = CUI_ViewTag(view);
    NSInteger wndTag = CUI_ViewWindowTag( view );
    CUI_OutputWindowSetTag( wndTag );
    CallUserDefinedOnDialogFunction( dialogEvent, viewTag, wndTag, (__bridge CFTypeRef)event );
    CUI_EventSetEvent( nil );
}



#pragma mark - events
BOOL CUI_ResponderAcceptsFirstResponder( id responder )
{
    if ( [responder isKindOfClass:[NSWindow class]] ) {
        CUI_ResponderForwardWindowDialogEvent( (NSWindow *)responder, windowAcceptsFirstResponder, nil );
    } else if ( [responder isKindOfClass:[NSView class]] ) {
        CUI_ResponderForwardViewDialogEvent( (NSView *)responder, viewAcceptsFirstResponder, nil );
    } else {
        // ...
    }
    return DialogEventBool();
}

void CUI_ResponderMouseDown( id responder, NSEvent *event )
{
    if ( [responder isKindOfClass:[NSWindow class]] ) {
        CUI_ResponderForwardWindowDialogEvent( (NSWindow *)responder, windowMouseDown, event );
    } else if ( [responder isKindOfClass:[NSView class]] ) {
        CUI_ResponderForwardViewDialogEvent( (NSView *)responder, viewMouseDown, event );
    } else {
        // ...
    }
}

void CUI_ResponderMouseDragged( id responder, NSEvent *event )
{
    if ( [responder isKindOfClass:[NSWindow class]] ) {
        CUI_ResponderForwardWindowDialogEvent( (NSWindow *)responder, windowMouseDragged, event );
    } else if ( [responder isKindOfClass:[NSView class]] ) {
        CUI_ResponderForwardViewDialogEvent( (NSView *)responder, viewMouseDragged, event );
    } else {
        // ...
    }
}

void CUI_ResponderMouseUp( id responder, NSEvent *event )
{
    if ( [responder isKindOfClass:[NSWindow class]] ) {
        CUI_ResponderForwardWindowDialogEvent( (NSWindow *)responder, windowMouseUp, event );
    } else if ( [responder isKindOfClass:[NSView class]] ) {
        CUI_ResponderForwardViewDialogEvent( (NSView *)responder, viewMouseUp, event );
    } else {
        // ...
    }
}

void CUI_ResponderMouseMoved( id responder, NSEvent *event )
{
    if ( [responder isKindOfClass:[NSWindow class]] ) {
        CUI_ResponderForwardWindowDialogEvent( (NSWindow *)responder, windowMouseMoved, event );
    } else if ( [responder isKindOfClass:[NSView class]] ) {
        CUI_ResponderForwardViewDialogEvent( (NSView *)responder, viewMouseMoved, event );
    } else {
        // ...
    }
}

void CUI_ResponderMouseEntered( id responder, NSEvent *event )
{
    if ( [responder isKindOfClass:[NSWindow class]] ) {
        CUI_ResponderForwardWindowDialogEvent( (NSWindow *)responder, windowMouseEntered, event );
    } else if ( [responder isKindOfClass:[NSView class]] ) {
        CUI_ResponderForwardViewDialogEvent( (NSView *)responder, viewMouseEntered, event );
    } else {
        // ...
    }
}

void CUI_ResponderMouseExited( id responder, NSEvent *event )
{
    if ( [responder isKindOfClass:[NSWindow class]] ) {
        CUI_ResponderForwardWindowDialogEvent( (NSWindow *)responder, windowMouseExited, event );
    } else if ( [responder isKindOfClass:[NSView class]] ) {
        CUI_ResponderForwardViewDialogEvent( (NSView *)responder, viewMouseExited, event );
    } else {
        // ...
    }
}










#pragma mark - public
// Class
Class ResponderClass( void )
{ return [NSResponder class]; }

// Manage next responder
NSResponder *ResponderNextResponder( NSResponder *ref )
{ return [ref nextResponder]; }

// Presenting and customizing error info
BOOL ResponderPresentError( NSResponder *ref, NSError *err )
{ return [ref presentError:err]; }

void ResponderPresentErrorModalForWindow( NSResponder *ref, NSError *err, NSInteger wndTag, void *context )
{
    NSWindow *w = CUI_WindowWithTag( wndTag );
    if ( w ) {
        if ( !sCUI_ResponderTarget ) sCUI_ResponderTarget = [[CUI_ResponderTarget alloc] init];
        [ref presentError:err modalForWindow:w delegate:sCUI_ResponderTarget didPresentSelector:@selector(didPresentErrorWithRecovery:contextInfo:) contextInfo:context];
    }
}

// Managing a responder's menu
NSMenu *ResponderMenu( NSResponder *ref )
{ return [ref menu]; }

void ResponderSetMenu( NSResponder *ref, NSInteger menuID )
{
    if ( menuID >= 0 ) {
        NSMenu *menu = MenuAtIndex( menuID );
        if ( menu ) [ref setMenu:menu];
    } else {
        [ref setMenu:nil];
    }
}

void ResponderSetMenuRef( NSResponder *ref, NSMenu *m )
{ [ref setMenu:m]; }

// Getting the undo manager
NSUndoManager *ResponderUndoManager( NSResponder *ref )
{ return [ref undoManager]; }


#pragma mark - Responding to action messages
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
void ResponderDoCommandBySelector( NSResponder *ref, CFStringRef message )
{ [ref doCommandBySelector:NSSelectorFromString((__bridge NSString *)message)]; }

void ResponderInsertBacktab( NSResponder *ref )
{ [ref insertBacktab:nil]; }

void ResponderInsertContainerBreak( NSResponder *ref )
{ [ref insertContainerBreak:nil]; }

#endif// 101400
void ResponderInsertDoubleQuoteIgnoringSubstitution( NSResponder *ref )
{ [ref insertDoubleQuoteIgnoringSubstitution:nil]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
void ResponderInsertLineBreak( NSResponder *ref )
{ [ref insertLineBreak:nil]; }

void ResponderInsertNewline( NSResponder *ref )
{ [ref insertNewline:nil]; }

void ResponderInsertNewlineIgnoringFieldEditor( NSResponder *ref )
{ [ref insertNewlineIgnoringFieldEditor:nil]; }

void ResponderInsertParagraphSeparator( NSResponder *ref )
{ [ref insertParagraphSeparator:nil]; }
#endif// 101400

void ResponderInsertSingleQuoteIgnoringSubstitution( NSResponder *ref )
{ [ref insertSingleQuoteIgnoringSubstitution:nil]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
void ResponderInsertTab( NSResponder *ref )
{ [ref insertTab:nil]; }

void ResponderInsertTabIgnoringFieldEditor( NSResponder *ref )
{ [ref insertTabIgnoringFieldEditor:nil]; }

void ResponderInsertText( NSResponder *ref, CFStringRef string )
{ [ref insertText:(__bridge NSString *)string]; }

void ResponderDeleteBackward( NSResponder *ref )
{ [ref deleteBackward:nil]; }

void ResponderDeleteBackwardByDecomposingPreviousCharacter( NSResponder *ref )
{ [ref deleteBackwardByDecomposingPreviousCharacter:nil]; }

void ResponderDeleteForward( NSResponder *ref )
{ [ref deleteForward:nil]; }

void ResponderDeleteToBeginningOfLine( NSResponder *ref )
{ [ref deleteToBeginningOfLine:nil]; }

void ResponderDeleteToBeginningOfParagraph( NSResponder *ref )
{ [ref deleteToBeginningOfParagraph:nil]; }

void ResponderDeleteToEndOfLine( NSResponder *ref )
{ [ref deleteToEndOfLine:nil]; }

void ResponderDeleteToEndOfParagraph( NSResponder *ref )
{ [ref deleteToEndOfParagraph:nil]; }

void ResponderDeleteWordBackward( NSResponder *ref )
{ [ref deleteWordBackward:nil]; }

void ResponderDeleteWordForward( NSResponder *ref )
{ [ref deleteWordForward:nil]; }

void ResponderYank( NSResponder *ref )
{ [ref yank:nil]; }

void ResponderMoveBackward( NSResponder *ref )
{ [ref moveBackward:nil]; }

void ResponderMoveDown( NSResponder *ref )
{ [ref moveDown:nil]; }

void ResponderMoveForward( NSResponder *ref )
{ [ref moveForward:nil]; }

void ResponderMoveLeft( NSResponder *ref )
{ [ref moveLeft:nil]; }

void ResponderMoveRight( NSResponder *ref )
{ [ref moveRight:nil]; }

void ResponderMoveUp( NSResponder *ref )
{ [ref moveUp:nil]; }

void ResponderMoveBackwardAndModifySelection( NSResponder *ref )
{ [ref moveBackwardAndModifySelection:nil]; }

void ResponderMoveDownAndModifySelection( NSResponder *ref )
{ [ref moveDownAndModifySelection:nil]; }

void ResponderMoveForwardAndModifySelection( NSResponder *ref )
{ [ref moveForwardAndModifySelection:nil]; }

void ResponderMoveLeftAndModifySelection( NSResponder *ref )
{ [ref moveLeftAndModifySelection:nil]; }

void ResponderMoveRightAndModifySelection( NSResponder *ref )
{ [ref moveRightAndModifySelection:nil]; }

void ResponderMoveUpAndModifySelection( NSResponder *ref )
{ [ref moveUpAndModifySelection:nil]; }

void ResponderScrollPageDown( NSResponder *ref )
{ [ref scrollPageDown:nil]; }

void ResponderScrollPageUp( NSResponder *ref )
{ [ref scrollPageUp:nil]; }

void ResponderScrollLineDown( NSResponder *ref )
{ [ref scrollLineDown:nil]; }

void ResponderScrollLineUp( NSResponder *ref )
{ [ref scrollLineUp:nil]; }

void ResponderScrollToBeginningOfDocument( NSResponder *ref )
{ [ref scrollToBeginningOfDocument:nil]; }

void ResponderScrollToEndOfDocument( NSResponder *ref )
{ [ref scrollToEndOfDocument:nil]; }

void ResponderPageDown( NSResponder *ref )
{ [ref pageDown:nil]; }

void ResponderPageUp( NSResponder *ref )
{ [ref pageUp:nil]; }

void ResponderPageDownAndModifySelection( NSResponder *ref )
{ [ref pageDownAndModifySelection:nil]; }

void ResponderPageUpAndModifySelection( NSResponder *ref )
{ [ref pageUpAndModifySelection:nil]; }

void ResponderCenterSelectionInVisibleArea( NSResponder *ref )
{ [ref centerSelectionInVisibleArea:nil]; }

void ResponderTranspose( NSResponder *ref )
{ [ref transpose:nil]; }

void ResponderTransposeWords( NSResponder *ref )
{ [ref transposeWords:nil]; }

void ResponderIndent( NSResponder *ref )
{ [ref indent:nil]; }

void ResponderCancelOperation( NSResponder *ref )
{ [ref cancelOperation:nil]; }
#endif// 101400

void ResponderQuickLookPreviewItems( NSResponder *ref )
{ [ref quickLookPreviewItems:nil]; }

void ResponderMakeBaseWritingDirectionLeftToRight( NSResponder *ref )
{ [ref makeBaseWritingDirectionLeftToRight:nil]; }

void ResponderMakeBaseWritingDirectionNatural( NSResponder *ref )
{ [ref makeBaseWritingDirectionNatural:nil]; }

void ResponderMakeBaseWritingDirectionRightToLeft( NSResponder *ref )
{ [ref makeBaseWritingDirectionRightToLeft:nil]; }

void ResponderMakeTextWritingDirectionLeftToRight( NSResponder *ref )
{ [ref makeTextWritingDirectionLeftToRight:nil]; }

void ResponderMakeTextWritingDirectionNatural( NSResponder *ref )
{ [ref makeTextWritingDirectionNatural:nil]; }

void ResponderMakeTextWritingDirectionRightToLeft( NSResponder *ref )
{ [ref makeTextWritingDirectionRightToLeft:nil]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
void ResponderCapitalizeWord( NSResponder *ref )
{ [ref capitalizeWord:nil]; }

void ResponderChangeCaseOfLetter( NSResponder *ref )
{ [ref changeCaseOfLetter:nil]; }

void ResponderLowercaseWord( NSResponder *ref )
{ [ref lowercaseWord:nil]; }

void ResponderUppercaseWord( NSResponder *ref )
{ [ref uppercaseWord:nil]; }

void ResponderMoveToBeginningOfDocument( NSResponder *ref )
{ [ref moveToBeginningOfDocument:nil]; }

void ResponderMoveToBeginningOfDocumentAndModifySelection( NSResponder *ref )
{ [ref moveToBeginningOfDocumentAndModifySelection:nil]; }

void ResponderMoveToEndOfDocument( NSResponder *ref )
{ [ref moveToEndOfDocument:nil]; }

void ResponderMoveToEndOfDocumentAndModifySelection( NSResponder *ref )
{ [ref moveToEndOfDocumentAndModifySelection:nil]; }

void ResponderMoveParagraphBackwardAndModifySelection( NSResponder *ref )
{ [ref moveParagraphBackwardAndModifySelection:nil]; }

void ResponderMoveParagraphForwardAndModifySelection( NSResponder *ref )
{ [ref moveParagraphForwardAndModifySelection:nil]; }

void ResponderMoveToBeginningOfParagraph( NSResponder *ref )
{ [ref moveToBeginningOfParagraph:nil]; }

void ResponderMoveToBeginningOfParagraphAndModifySelection( NSResponder *ref )
{ [ref moveToBeginningOfParagraphAndModifySelection:nil]; }

void ResponderMoveToEndOfParagraph( NSResponder *ref )
{ [ref moveToEndOfParagraph:nil]; }

void ResponderMoveToEndOfParagraphAndModifySelection( NSResponder *ref )
{ [ref moveToEndOfParagraphAndModifySelection:nil]; }

void ResponderMoveToBeginningOfLine( NSResponder *ref )
{ [ref moveToBeginningOfLine:nil]; }

void ResponderMoveToBeginningOfLineAndModifySelection( NSResponder *ref )
{ [ref moveToBeginningOfLineAndModifySelection:nil]; }

void ResponderMoveToEndOfLine( NSResponder *ref )
{ [ref moveToEndOfLine:nil]; }

void ResponderMoveToEndOfLineAndModifySelection( NSResponder *ref )
{ [ref moveToEndOfLineAndModifySelection:nil]; }

void ResponderMoveToLeftEndOfLine( NSResponder *ref )
{ [ref moveToLeftEndOfLine:nil]; }

void ResponderMoveToLeftEndOfLineAndModifySelection( NSResponder *ref )
{ [ref moveToLeftEndOfLineAndModifySelection:nil]; }

void ResponderMoveToRightEndOfLine( NSResponder *ref )
{ [ref moveToRightEndOfLine:nil]; }

void ResponderMoveToRightEndOfLineAndModifySelection( NSResponder *ref )
{ [ref moveToRightEndOfLineAndModifySelection:nil]; }

void ResponderSelectAll( NSResponder *ref )
{ [ref selectAll:nil]; }

void ResponderSelectLine( NSResponder *ref )
{ [ref selectLine:nil]; }

void ResponderSelectParagraph( NSResponder *ref )
{ [ref selectParagraph:nil]; }

void ResponderSelectWord( NSResponder *ref )
{ [ref selectWord:nil]; }

void ResponderSetMark( NSResponder *ref )
{ [ref setMark:nil]; }

void ResponderSelectToMark( NSResponder *ref )
{ [ref selectToMark:nil]; }

void ResponderDeleteToMark( NSResponder *ref )
{ [ref deleteToMark:nil]; }

void ResponderSwapWithMark( NSResponder *ref )
{ [ref swapWithMark:nil]; }

void ResponderComplete( NSResponder *ref )
{ [ref complete:nil]; }

void ResponderMoveWordBackward( NSResponder *ref )
{ [ref moveWordBackward:nil]; }

void ResponderMoveWordBackwardAndModifySelection( NSResponder *ref )
{ [ref moveWordBackwardAndModifySelection:nil]; }

void ResponderMoveWordForward( NSResponder *ref )
{ [ref moveWordForward:nil]; }

void ResponderMoveWordForwardAndModifySelection( NSResponder *ref )
{ [ref moveWordForwardAndModifySelection:nil]; }

void ResponderMoveWordLeft( NSResponder *ref )
{ [ref moveWordLeft:nil]; }

void ResponderMoveWordLeftAndModifySelection( NSResponder *ref )
{ [ref moveWordLeftAndModifySelection:nil]; }

void ResponderMoveWordRight( NSResponder *ref )
{ [ref moveWordRight:nil]; }

void ResponderMoveWordRightAndModifySelection( NSResponder *ref )
{ [ref moveWordRightAndModifySelection:nil]; }
#endif// 101400

// Handling window restoration
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
CFArrayRef ResponderAllowedClassesForRestorableStateKeyPath( CFStringRef keyPath )
{ return (__bridge CFArrayRef)[NSResponder allowedClassesForRestorableStateKeyPath:(__bridge NSString *)keyPath]; }
#endif// 120000

CFArrayRef ResponderRestorableStateKeyPaths( void )
{ return (__bridge CFArrayRef)[NSResponder restorableStateKeyPaths]; }

void ResponderInvalidateRestorableState( NSResponder *ref )
{ [ref invalidateRestorableState]; }

// Supporting user activities
UserActivityRef ResponderUserActivity( NSResponder *ref )
{ return [ref userActivity]; }

void ResponderSetUserActivity( NSResponder *ref, NSUserActivity *userActivity )
{ [ref setUserActivity:userActivity]; }

void ResponderUpdateUserActivityState( NSResponder *ref, NSUserActivity *userActivity )
{ [ref updateUserActivityState:userActivity]; }

// Performing text find actions
void ResponderPerformTextFinderAction( NSResponder *ref )
{ [ref performTextFinderAction:nil]; }

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
void ResponderContextMenuKeyDown( NSResponder *ref, NSEvent *event )
{ [ref contextMenuKeyDown:event]; }
#endif// 150000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150200
void ResponderShowWritingTools( NSResponder *ref, id sender )
{ [ref showWritingTools:sender]; }
#endif// 150200

