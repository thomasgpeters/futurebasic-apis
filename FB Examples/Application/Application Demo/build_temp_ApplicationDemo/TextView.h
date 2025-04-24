/*
 TextView.h

 Bernie Wylde
 */

#import "CocoaUI.h"

#pragma mark - subclass
@interface TextViewSC : NSTextView
@end

// dialog events
enum {
    // text system objects
    textViewUndoManager = 2300,

    // controlling display
    textViewWillDisplayTooltip,

    // supporting quicklook
    textViewURLForContentsOfTextAttachment,

    // managing selection
    textViewWillChangeSelectionFromCharacterRange,
    textViewWillChangeSelectionFromCharacterRanges,
    textViewDidChangeSelection,

    // manage pasteboard
    textViewWritablePasteboardTypes,
    textViewWriteCell,

    // text attributes
    textViewShouldChangeTextInRange,
    textViewShouldChangeTextInRanges,
    textViewShouldChangeTypingAttributes,
    textViewDidChangeTypingAttributes,

    // clicking and pasting
    textViewClickedOnCell,
    textViewDoubleClickedOnCell,
    textViewClickedOnLink,

    // spell checker
    textViewShouldSetSpellingState,
    textViewWillCheckTextInRange,
    textViewDidCheckTextInRange,

    // dragging
    textViewDraggedCell,

    // text completion
    textViewCompletions,

    // sharing service picker
    textViewWillShowSharingServicePicker,

    // perform commands
    textViewDoCommandBySelector,

    // contextual menu
    textViewMenu,

    // instance methods
    textViewCandidates,
    textViewCandidatesForSelectedRange,
    textViewShouldSelectCandidate,
    
    textViewWritingToolsWillBegin,
    textViewWritingToolsDidEnd,
    textViewWritingToolsIgnoredRangesInEnclosingRange
};

#pragma mark - text view delegate
@interface CUI_TextViewDelegate : NSObject <NSTextViewDelegate>
@property (nonatomic,assign) NSRange fromRange;
@property (nonatomic,assign) NSRange toRange;
@property (nonatomic,retain) NSArray *fromRanges;
@property (nonatomic,retain) NSArray *toRanges;
@end

CUI_TextViewDelegate *CUI_TextViewDelegateObj( void );


#pragma mark - text view additions
@interface NSTextView (Additions)
@property (nonatomic,retain) NSNumber *tagNumber;
- (NSInteger)tag;
- (void)setTag:(NSInteger)tag;
@end


#pragma mark - text view events
// textViewWillChangeSelectionFromCharacterRange
CFRange TextViewEventFromRange( void );
CFRange TextViewEventToRange( void );
void TextViewEventSetToRange( CFRange range );

// textViewWillChangeSelectionFromCharacterRanges
CFArrayRef TextViewEventFromRanges( void );
CFArrayRef TextViewEventToRanges( void );
void TextViewEventSetToRanges( CFArrayRef ranges );


#pragma mark - text view functions
// Class
Class TextViewClass( void );

NSTextView *TextViewWithTag( NSInteger tag );
BOOL TextViewExists( NSInteger tag );

void TextViewRegisterForServices( void );

// Accessing text system objects
NSTextContainer *TextViewTextContainer( NSInteger tag );
void TextViewSetTextContainer( NSInteger tag, NSTextContainer *tc );
void TextViewReplaceTextContainer( NSInteger tag, NSTextContainer *tc );
CGSize TextViewTextContainerInset( NSInteger tag );
void TextViewSetTextContainerInset( NSInteger tag, CGSize inset );
CGPoint TextViewTextContainerOrigin( NSInteger tag );
void TextViewInvalidateTextContainerOrigin( NSInteger tag );
NSLayoutManager *TextViewLayoutManager( NSInteger tag );
//CFMutableAttributedStringRef TextViewTextStorage( NSInteger tag );
NSTextStorage *TextViewTextStorage( NSInteger tag );

// Graphics attributes
NSColor *TextViewBackgroundColor( NSInteger tag );
void TextViewSetBackgroundColor( NSInteger tag, NSColor *col );
BOOL TextViewDrawsBackground( NSInteger tag );
void TextViewSetDrawsBackground( NSInteger tag, BOOL flag );
BOOL TextViewAllowsDocumentBackgroundColorChange( NSInteger tag );
void TextViewSetAllowsDocumentBackgroundColorChange( NSInteger tag, BOOL flag );
void TextViewChangeDocumentBackgroundColor( NSInteger tag );

// Controlling display
void TextViewShowFindIndicatorForRange( NSInteger tag, CFRange range );




// Inserting text
CFArrayRef TextViewAllowedInputSourceLocales( NSInteger tag );




// Behavioral attributes
BOOL TextViewAllowsUndo( NSInteger tag );
void TextViewSetAllowsUndo( NSInteger tag, BOOL flag );
BOOL TextViewIsEditable( NSInteger tag );
void TextViewSetEditable( NSInteger tag, BOOL flag );
BOOL TextViewIsSelectable( NSInteger tag );
void TextViewSetSelectable( NSInteger tag, BOOL flag );




BOOL TextViewIsFieldEditor( NSInteger tag );
void TextViewSetFieldEditor( NSInteger tag, BOOL flag );




BOOL TextViewIsRichText( NSInteger tag );
void TextViewSetRichText( NSInteger tag, BOOL flag );
BOOL TextViewImportsGraphics( NSInteger tag );
void TextViewSetImportsGraphics( NSInteger tag, BOOL flag );
void TextViewSetBaseWritingDirection( NSInteger tag, NSWritingDirection direction );
NSParagraphStyle *TextViewDefaultParagraphStyle( NSInteger tag );
void TextViewSetDefaultParagraphStyle( NSInteger tag, NSParagraphStyle *style );
void TextViewOutline( NSInteger tag );
BOOL TextViewAllowsImageEditing( NSInteger tag );
void TextViewSetAllowsImageEditing( NSInteger tag, BOOL flag );
BOOL TextViewIsAutomaticQuoteSubstitutionEnabled( NSInteger tag );
void TextViewSetAutomaticQuoteSubstitutionEnabled( NSInteger tag, BOOL flag );
void TextViewToggleAutomaticQuoteSubstitution( NSInteger tag );
BOOL TextViewIsAutomaticLinkDetectionEnabled( NSInteger tag );
void TextViewSetAutomaticLinkDetectionEnabled( NSInteger tag, BOOL flag );
void TextViewToggleAutomaticLinkDetection( NSInteger tag );
BOOL TextViewDisplaysLinkToolTips( NSInteger tag );
void TextViewSetDisplaysLinkToolTips( NSInteger tag, BOOL flag );

// Formatting controls
BOOL TextViewUsesRuler( NSInteger tag );
void TextViewSetUsesRuler( NSInteger tag, BOOL flag );
BOOL TextViewIsRulerVisible( NSInteger tag );
void TextViewSetRulerVisible( NSInteger tag, BOOL flag );
BOOL TextViewUsesInspectorBar( NSInteger tag );
void TextViewSetUsesInspectorBar( NSInteger tag, BOOL flag );

// Selection
CFArrayRef TextViewSelectedRanges( NSInteger tag );
void TextViewSetSelectedRanges( NSInteger tag, CFArrayRef ranges );
void TextViewSetSelectedRange( NSInteger tag, CFRange range );
void TextViewSetSelectedRangeAffinity( NSInteger tag, CFRange range, NSSelectionAffinity affinity, BOOL stillSelecting );
NSSelectionAffinity TextViewSelectionAffinity( NSInteger tag );
NSSelectionGranularity TextViewSelectionGranularity( NSInteger tag );
void TextViewSetSelectionGranularity( NSInteger tag, NSSelectionGranularity granularity );
NSColor *TextViewInsertionPointColor( NSInteger tag );
void TextViewSetInsertionPointColor( NSInteger tag, NSColor *col );
CFDictionaryRef TextViewSelectedTextAttributes( NSInteger tag );
void TextViewSetSelectedTextAttributes( NSInteger tag, CFDictionaryRef attributes );
CFDictionaryRef TextViewMarkedTextAttributes( NSInteger tag );
void TextViewSetMarkedTextAttributes( NSInteger tag, CFDictionaryRef attributes );
CFDictionaryRef TextViewLinkTextAttributes( NSInteger tag );
void TextViewSetLinkTextAttributes( NSInteger tag, CFDictionaryRef attributes );
NSUInteger TextViewCharacterIndexForInsertionAtPoint( NSInteger tag, CGPoint pt );

// Managing the pasteboard
CFArrayRef TextViewReadablePasteboardTypes( NSInteger tag );
CFArrayRef TextViewWritablePasteboardTypes( NSInteger tag );

// Text attributes
void TextViewAlignJustified( NSInteger tag );
void TextViewChangeAttributes( NSInteger tag );
void TextViewChangeColor( NSInteger tag );
void TextViewSetAlignment( NSInteger tag, NSTextAlignment alignment, CFRange range );
CFDictionaryRef TextViewTypingAttributes( NSInteger tag );
void TextViewSetTypingAttributes( NSInteger tag, CFDictionaryRef attributes );
void TextViewUseStandardKerning( NSInteger tag );
void TextViewLowerBaseline( NSInteger tag );
void TextViewRaiseBaseline( NSInteger tag );
void TextViewTurnOffKerning( NSInteger tag );
void TextViewLoosenKerning( NSInteger tag );
void TextViewTightenKerning( NSInteger tag );
void TextViewUseStandardLigatures( NSInteger tag );
void TextViewTurnOffLigatures( NSInteger tag );
void TextViewUseAllLigatures( NSInteger tag );

// Clicking and pasting
// ...
void TextViewPasteAsPlainText( NSInteger tag );
void TextViewPasteAsRichText( NSInteger tag );

// Undo support
void TextViewBreakUndoCoalescing( NSInteger tag );
BOOL TextViewIsCoalescingUndo( NSInteger tag );

// Subclasses to override
CFRange TextViewRangeForUserTextChange( NSInteger tag );

// Spell checker
BOOL TextViewIsContinuousSpellCheckingEnabled( NSInteger tag );
void TextViewSetContinuousSpellCheckingEnabled( NSInteger tag, BOOL flag );
void TextViewToggleContinuousSpellChecking( NSInteger tag );
BOOL TextViewIsGrammarCheckingEnabled( NSInteger tag );
void TextViewSetGrammarCheckingEnabled( NSInteger tag, BOOL flag );
void TextViewToggleGrammarChecking( NSInteger tag );
void TextViewSetSpellingState( NSInteger tag, NSInteger value, CFRange range );

// Service picker
void TextViewOrderFrontSharingServicePicker( NSInteger tag );

// Speaking
void TextViewStartSpeaking( NSInteger tag );
void TextViewStopSpeaking( NSInteger tag );

// Working with panels
BOOL TextViewUsesFontPanel( NSInteger tag );
void TextViewSetUsesFontPanel( NSInteger tag, BOOL flag );
BOOL TextViewUsesFindPanel( NSInteger tag );
void TextViewSetUsesFindPanel( NSInteger tag, BOOL flag );
void TextViewOrderFrontLinkPanel( NSInteger tag );
void TextViewOrderFrontListPanel( NSInteger tag );
void TextViewOrderFrontSpacingPanel( NSInteger tag );
void TextViewOrderFrontTablePanel( NSInteger tag );
void TextViewOrderFrontSubstitutionsPanel( NSInteger tag );

// Text completion
void TextViewComplete( NSInteger tag );
CFArrayRef TextViewCompletions( NSInteger tag, CFRange partialWordRange, NSInteger *indexOfSelectedItem );
void TextViewInsertCompletion( NSInteger tag, CFStringRef word, CFRange partialWordRange, NSInteger movement, BOOL isFinal );
CFRange TextViewRangeForUserCompletion( NSInteger tag );



// Supporting quicklook
void TextViewUpdateQuickLookPreviewPanel( NSInteger tag );
void TextViewToggleQuickLookPreviewPanel( NSInteger tag );
CFArrayRef TextViewQuickLookPreviewableItemsInRanges( NSInteger tag, CFArrayRef ranges );



// Changing layout orientation
void TextViewChangeLayoutOrientation( NSInteger tag );
void TextViewSetLayoutOrientation( NSInteger tag, NSTextLayoutOrientation orientation );

// Find bar
BOOL TextViewUsesFindBar( NSInteger tag );
void TextViewSetUsesFindBar( NSInteger tag, BOOL flag );
BOOL TextViewIsIncrementalSearchingEnabled( NSInteger tag );
void TextViewSetIncrementalSearchingEnabled( NSInteger tag, BOOL flag );


// Instance properties
BOOL TextViewIsAutomaticTextCompletionEnabled( NSInteger tag );
void TextViewSetAutomaticTextCompletionEnabled( NSInteger tag, BOOL flag );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
BOOL TextViewUsesAdaptiveColorMappingForDarkAppearance( NSInteger tag );
API_AVAILABLE(macos(10.15))
void TextViewSetUsesAdaptiveColorMappingForDarkAppearance( NSInteger tag, BOOL flag );
#endif// 101500

BOOL TextViewUsesRolloverButtonForSelection( NSInteger tag );
void TextViewSetUsesRolloverButtonForSelection( NSInteger tag, BOOL flag );

// Type properties
BOOL TextViewStronglyReferencesTextStorage( void );

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
BOOL TextViewPerformValidatedReplacementInRange( NSInteger tag, CFRange range, CFAttributedStringRef attributedString );
#endif// 101400

void TextViewToggleAutomaticTextCompletion( NSInteger tag );
void TextViewUpdateCandidates( NSInteger tag );

// Type methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
CFTypeRef TextViewFieldEditor( void );
API_AVAILABLE(macos(10.14))
NSScrollView *TextViewScrollableDocumentContentTextView( void );
API_AVAILABLE(macos(10.14))
NSScrollView *TextViewScrollablePlainDocumentContentTextView( void );
API_AVAILABLE(macos(10.14))
NSScrollView *TextViewScrollableTextView( void );
#endif// 101400

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
NSTextInputTraitType TextViewInlinePredictionType( NSInteger tag );
API_AVAILABLE(macos(14.0))
void TextViewSetInlinePredictionType( NSInteger tag, NSTextInputTraitType type );
#endif // 140000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
API_AVAILABLE(macos(15.0))
NSTextInputTraitType TextViewMathExpressionCompletionType( NSInteger tag );
API_AVAILABLE(macos(15.0))
void TextViewSetMathExpressionCompletionType( NSInteger tag, NSTextInputTraitType type );
API_AVAILABLE(macos(15.0))
CFDictionaryRef TextViewTextHighlightAttributes( NSInteger tag );
API_AVAILABLE(macos(15.0))
void TextViewSetTextHighlightAttributes( NSInteger tag, CFDictionaryRef attributes );
API_AVAILABLE(macos(15.0))
void TextViewDrawTextHighlightBackgroundForTextRange( NSInteger tag, NSTextRange *textRange, CGPoint origin );
API_AVAILABLE(macos(15.0))
void TextViewHighlight( NSInteger tag );
#endif // 150000


#pragma mark - Responder action messages
void TextViewScrollToEndOfDocument( NSInteger tag );



#pragma mark - convenience
void TextViewPerformFindPanelAction( NSInteger tag, NSTextFinderAction action );
BOOL TextViewIsFindBarVisible( NSInteger tag );
void TextViewSetWordWrap( NSInteger tag, BOOL flag );
CFMutableAttributedStringRef TextViewMutableAttributedString( NSInteger tag );
CFAttributedStringRef TextViewAttributedString( NSInteger tag );

void TextViewSetLinkInRange( NSInteger tag, CFTypeRef link, CFRange range );
void TextViewSetLink( NSInteger tag, CFTypeRef link );

// Convenience
void TextViewAppendString( NSInteger tag, CFStringRef string );

void TextViewSetTextBackgroundColor( NSInteger tag, NSColor *col );


#pragma mark - FB keyword
// Init
NSTextView *TextViewInit( NSInteger inTag, CGRect inRect );

// Statement
void CUI_TextView( NSInteger inTag, CGRect inRect, NSInteger inScrollTag, NSTextContainer *tc, NSInteger inWndTag );
