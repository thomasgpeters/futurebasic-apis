/*
 Responder.h

 Bernie Wylde
 */



//#import "DialogEvent.h"
//#import "Event.h"
//#import "Menu.h"
//#import "View.h"
//#import "Window.h"

@interface CUI_ResponderTarget : NSObject
@end

// dialog events
enum {
    responderDidPresentError = 4900
};


// common selector commands
enum {
    selectorComplete = 1,
    selectorDeleteBackward,
    selectorInsertBacktab,
    selectorInsertNewline,
    selectorInsertTab,
    selectorMoveLeft,
    selectorMoveRight
};

// command for selector
NSInteger CUI_ResponderCommandForSelector( SEL selector );


#pragma mark - private
void CUI_ResponderForwardWindowDialogEvent( NSWindow *w, NSInteger dialogEvent, NSEvent *event );
void CUI_ResponderForwardViewDialogEvent( NSView *view, NSInteger dialogEvent, NSEvent *event );

#pragma mark - mouse events
BOOL CUI_ResponderAcceptsFirstResponder( id responder );
void CUI_ResponderMouseDown( id responder, NSEvent *event );
void CUI_ResponderMouseDragged( id responder, NSEvent *event );
void CUI_ResponderMouseUp( id responder, NSEvent *event );
void CUI_ResponderMouseMoved( id responder, NSEvent *event );
void CUI_ResponderMouseEntered( id responder, NSEvent *event );
void CUI_ResponderMouseExited( id responder, NSEvent *event );

void CUI_ResponderRightMouseDown( id responder, NSEvent *event );
void CUI_ResponderRightMouseDragged( id responder, NSEvent *event );
void CUI_ResponderRightMouseUp( id responder, NSEvent *event );
void CUI_ResponderOtherMouseDown( id responder, NSEvent *event );
void CUI_ResponderOtherMouseDragged( id responder, NSEvent *event );
void CUI_ResponderOtherMouseUp( id responder, NSEvent *event );

#pragma mark - key events
void CUI_ResponderKeyDown( id responder, NSEvent *event );
void CUI_ResponderKeyUp( id responder, NSEvent *event );


#pragma mark - other events
void CUI_ResponderFlagsChanged( id responder, NSEvent *event );



#pragma mark - public
// Class
Class ResponderClass( void );

// Changing first responder
BOOL ResponderAcceptsFirstResponder( NSResponder *ref );

// Manage next responder
NSResponder *ResponderNextResponder( NSResponder *ref );

// Presenting and customizing error info
BOOL ResponderPresentError( NSResponder *ref, NSError *err );
void ResponderPresentErrorModalForWindow( NSResponder *ref, NSError *err, NSInteger wndTag, void *context );

// Managing a responder's menu
NSMenu *ResponderMenu( NSResponder *ref );
void ResponderSetMenu( NSResponder *ref, NSInteger menuID );
void ResponderSetMenuRef( NSResponder *ref, NSMenu *m );

// Getting the undo manager
NSUndoManager *ResponderUndoManager( NSResponder *ref );

#pragma mark - Responding to action messages
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
void ResponderDoCommandBySelector( NSResponder *ref, CFStringRef message );
API_AVAILABLE(macos(10.14))
void ResponderInsertBacktab( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderInsertContainerBreak( NSResponder *ref );
#endif// 101400
void ResponderInsertDoubleQuoteIgnoringSubstitution( NSResponder *ref );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
void ResponderInsertLineBreak( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderInsertNewline( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderInsertNewlineIgnoringFieldEditor( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderInsertParagraphSeparator( NSResponder *ref );
#endif// 101400
void ResponderInsertSingleQuoteIgnoringSubstitution( NSResponder *ref );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
void ResponderInsertTab( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderInsertTabIgnoringFieldEditor( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderInsertText( NSResponder *ref, CFStringRef string );
API_AVAILABLE(macos(10.14))
void ResponderDeleteBackward( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderDeleteBackwardByDecomposingPreviousCharacter( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderDeleteForward( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderDeleteToBeginningOfLine( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderDeleteToBeginningOfParagraph( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderDeleteToEndOfLine( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderDeleteToEndOfParagraph( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderDeleteWordBackward( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderDeleteWordForward( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderYank( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveBackward( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveDown( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveForward( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveLeft( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveRight( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveUp( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveBackwardAndModifySelection( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveDownAndModifySelection( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveForwardAndModifySelection( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveLeftAndModifySelection( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveRightAndModifySelection( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveUpAndModifySelection( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderScrollPageDown( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderScrollPageUp( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderScrollLineDown( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderScrollLineUp( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderScrollToBeginningOfDocument( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderScrollToEndOfDocument( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderPageDown( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderPageUp( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderPageDownAndModifySelection( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderPageUpAndModifySelection( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderCenterSelectionInVisibleArea( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderTranspose( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderTransposeWords( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderIndent( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderCancelOperation( NSResponder *ref );
#endif// 101400
void ResponderQuickLookPreviewItems( NSResponder *ref );
void ResponderMakeBaseWritingDirectionLeftToRight( NSResponder *ref );
void ResponderMakeBaseWritingDirectionNatural( NSResponder *ref );
void ResponderMakeBaseWritingDirectionRightToLeft( NSResponder *ref );
void ResponderMakeTextWritingDirectionLeftToRight( NSResponder *ref );
void ResponderMakeTextWritingDirectionNatural( NSResponder *ref );
void ResponderMakeTextWritingDirectionRightToLeft( NSResponder *ref );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
void ResponderCapitalizeWord( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderChangeCaseOfLetter( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderLowercaseWord( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderUppercaseWord( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveToBeginningOfDocument( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveToBeginningOfDocumentAndModifySelection( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveToEndOfDocument( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveToEndOfDocumentAndModifySelection( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveParagraphBackwardAndModifySelection( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveParagraphForwardAndModifySelection( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveToBeginningOfParagraph( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveToBeginningOfParagraphAndModifySelection( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveToEndOfParagraph( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveToEndOfParagraphAndModifySelection( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveToBeginningOfLine( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveToBeginningOfLineAndModifySelection( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveToEndOfLine( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveToEndOfLineAndModifySelection( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveToLeftEndOfLine( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveToLeftEndOfLineAndModifySelection( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveToRightEndOfLine( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveToRightEndOfLineAndModifySelection( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderSelectAll( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderSelectLine( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderSelectParagraph( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderSelectWord( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderSetMark( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderSelectToMark( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderDeleteToMark( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderSwapWithMark( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderComplete( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveWordBackward( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveWordBackwardAndModifySelection( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveWordForward( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveWordForwardAndModifySelection( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveWordLeft( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveWordLeftAndModifySelection( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveWordRight( NSResponder *ref );
API_AVAILABLE(macos(10.14))
void ResponderMoveWordRightAndModifySelection( NSResponder *ref );
#endif// 101400

// Handling window restoration
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
CFArrayRef ResponderAllowedClassesForRestorableStateKeyPath( CFStringRef keyPath );
#endif// 120000
CFArrayRef ResponderRestorableStateKeyPaths( void );
void ResponderInvalidateRestorableState( NSResponder *ref );

// Supporting user activities
UserActivityRef ResponderUserActivity( NSResponder *ref );
void ResponderSetUserActivity( NSResponder *ref, NSUserActivity*userActivity );
void ResponderUpdateUserActivityState( NSResponder *ref, NSUserActivity *userActivity );

// Performing text find actions
void ResponderPerformTextFinderAction( NSResponder *ref );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
void ResponderContextMenuKeyDown( NSResponder *ref, NSEvent *event );
#endif// 150000
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150200
void ResponderShowWritingTools( NSResponder *ref, id sender );
#endif// 150200

