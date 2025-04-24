/*
 TextField.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "Control.h"
//#import "DialogEvent.h"
//#import "Responder.h"
//#import "View.h"
//#import "Window.h"

@interface TextFieldSC : NSTextField
@end

// dialog events
enum {
    textFieldDidBeginEditing    = controlTextDidBeginEditing,
    textFieldDidChange          = controlTextDidChange,
    textFieldDidEndEditing      = controlTextDidEndEditing,
    textFieldShouldBeginEditing = controlTextShouldBeginEditing,
    textFieldShouldEndEditing   = controlTextShouldEndEditing,
};

enum {
    textFieldDidChangeSelection = 3800
};

@interface CUI_TextFieldDelegate : NSObject <NSTextFieldDelegate>
- (void)textFieldAction:(id)sender;
@end

CUI_TextFieldDelegate *CUI_TextFieldDelegateObj( void );

// Class
Class TextFieldClass( void );

NSTextField *TextFieldWithTag( NSInteger tag );
BOOL TextFieldExists( NSInteger tag );

// Selection and editing
BOOL TextFieldIsEditable( NSInteger tag );
void TextFieldSetEditable( NSInteger tag, BOOL flag );
BOOL TextFieldIsSelectable( NSInteger tag );
void TextFieldSetSelectable( NSInteger tag, BOOL flag );

// Rich text behavior
BOOL TextFieldAllowsEditingTextAttributes( NSInteger tag );
void TextFieldSetAllowsEditingTextAttributes( NSInteger tag, BOOL flag );
BOOL TextFieldImportsGraphics( NSInteger tag );
void TextFieldSetImportsGraphics( NSInteger tag, BOOL flag );

// Text color
NSColor *TextFieldTextColor( NSInteger tag );
void TextFieldSetTextColor( NSInteger tag, NSColor *col );

// Autolayout sizing
CGFloat TextFieldPreferredMaxLayoutWidth( NSInteger tag );
void TextFieldSetPreferredMaxLayoutWidth( NSInteger tag, CGFloat width );

// Background
NSColor *TextFieldBackgroundColor( NSInteger tag );
void TextFieldSetBackgroundColor( NSInteger tag, NSColor *col );
BOOL TextFieldDrawsBackground( NSInteger tag );
void TextFieldSetDrawsBackground( NSInteger tag, BOOL flag );

// Border
BOOL TextFieldIsBezeled( NSInteger tag );
void TextFieldSetBezeled( NSInteger tag, BOOL flag );
NSTextFieldBezelStyle TextFieldBezelStyle( NSInteger tag );
void TextFieldSetBezelStyle( NSInteger tag, NSTextFieldBezelStyle style );
BOOL TextFieldIsBordered( NSInteger tag );
void TextFieldSetBordered( NSInteger tag, BOOL flag );

// Selecting text
void TextFieldSelectText( NSInteger tag );

// Responder
BOOL TextFieldAcceptsFirstResponder( NSInteger tag );

// Instance properties
BOOL TextFieldAllowsDefaultTighteningForTruncation( NSInteger tag );
void TextFieldSetAllowsDefaultTighteningForTruncation( NSInteger tag, BOOL flag );
BOOL TextFieldIsAutomaticTextCompletionEnabled( NSInteger tag );
void TextFieldSetAutomaticTextCompletionEnabled( NSInteger tag, BOOL flag );
NSInteger TextFieldMaximumNumberOfLines( NSInteger tag );
void TextFieldSetMaximumNumberOfLines( NSInteger tag, NSInteger lines );
CFAttributedStringRef TextFieldPlaceholderAttributedString( NSInteger tag );
void TextFieldSetPlaceholderAttributedString( NSInteger tag, CFAttributedStringRef string );
CFStringRef TextFieldPlaceholderString( NSInteger tag );
void TextFieldSetPlaceholderString( NSInteger tag, CFStringRef string );

// Line wrapping
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
NSLineBreakStrategy TextFieldLineBreakStrategy( NSInteger tag );
API_AVAILABLE(macos(11.0))
void TextFieldSetLineBreakStrategy( NSInteger tag, NSLineBreakStrategy strategy );
#endif// 110000

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150200
BOOL TextFieldAllowsWritingTools( NSInteger tag );
void TextFieldSetAllowsWritingTools( NSInteger tag, BOOL flag );
#endif// 150200


// Cell methods
BOOL TextFieldSendsActionOnEndEditing( NSInteger tag );
void TextFieldSetSendsActionOnEndEditing( NSInteger tag, BOOL flag );
BOOL TextFieldAllowsUndo( NSInteger tag );
void TextFieldSetAllowsUndo( NSInteger tag, BOOL flag );

// Convenience
// Selected ranges
void TextFieldSetSelectedRange( NSInteger tag, CFRange range );
CFRange TextFieldSelectedRange( NSInteger tag );

// Init
NSTextField *TextFieldInit( NSInteger inTag, CGRect inRect );

// Statement
void CUI_TextField( NSInteger inTag, NSInteger inEnabled, CFStringRef inText, CGRect inRect, NSInteger inWndTag );

