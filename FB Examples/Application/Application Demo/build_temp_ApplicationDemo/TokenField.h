/*
 TokenField.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "Control.h"
//#import "DialogEvent.h"
//#import "View.h"
//#import "Window.h"

#pragma mark - subclass
@interface TokenFieldSC : NSTokenField
@end

// dialog events
enum {
    tokenFieldDisplayStringForRepresentedObject = 1800,
    tokenFieldStyleForRepresentedObject,
    tokenFieldCompletionsForSubstring,
    tokenFieldEditingStringForRepresentedObject,
    tokenFieldRepresentedObjectForEditingString,
    tokenFieldShouldAddObjects,
    tokenFieldReadFromPasteboard,
    tokenFieldWriteRepresentedObjectToPasteboard,
    tokenFieldHasMenuForRepresentedObject,
    tokenFieldMenuForRepresentedObject
};

@interface CUI_TokenFieldDelegate : NSObject <NSTokenFieldDelegate>
@property (nonatomic,assign) BOOL boolVal;
@end

CUI_TokenFieldDelegate *CUI_TokenFieldDelegateObj( void );

// Class
Class TokenFieldClass( void );

NSTokenField *TokenFieldWithTag( NSInteger tag );
BOOL TokenFieldExists( NSInteger tag );

// Style
NSUInteger TokenFieldStyle( NSInteger tag );
void TokenFieldSetStyle( NSInteger tag, NSUInteger style );

// Character set
CFCharacterSetRef TokenFieldTokenizingCharacterSet( NSInteger tag );
void TokenFieldSetTokenizingCharacterSet( NSInteger tag, CFCharacterSetRef set );
CFCharacterSetRef TokenFieldDefaultTokenizingCharacterSet( void );

// CompletionDelay
CFTimeInterval TokenFieldCompletionDelay( NSInteger tag );
void TokenFieldSetCompletionDelay( NSInteger tag, CFTimeInterval ti );
CFTimeInterval TokenFieldDefaultCompletionDelay( void );

// Custom
CFArrayRef TokenFieldRangesOfSelections( NSInteger tag );


// Init
NSTokenField *TokenFieldInit( NSInteger inTag, CGRect inRect );

// Statement
void CUI_TokenField( NSInteger inTag, NSInteger inEnabled, CFStringRef inText, CGRect inRect, NSInteger inStyle, NSInteger inWndTag );
