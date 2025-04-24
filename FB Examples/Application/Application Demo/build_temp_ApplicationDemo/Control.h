/*
 Control.h

 Bernie Wylde
 */

#pragma mark - control formatter
typedef BOOL (*CUI_ControlFormatterIsParticalStringValidCallbackType)(NSInteger,CFStringRef*,CFRange*,CFStringRef,CFRange,CFStringRef*,void*);

// format case options - used by inkey and input keywords
enum {
    formatCaseInsensitive, // 0
    formatCaseSensitive, // 1
    formatLowercase, // 2
    formatUppercase, // 3
    formatCapitalize, // 4
    formatInteger, // 5
    formatUnsignedInteger, // 6
    formatFloat, // 7
    formatUnsignedFloat, // 8
    formatPassword = 16
};

// control function selectors
enum {
    controlState,
    controlEnabled,
    controlHidden,
    controlIntVal
};


@interface CUI_ControlFormatter : NSFormatter
@property (nonatomic,retain) NSControl *control;
@property (nonatomic,assign) CUI_ControlFormatterIsParticalStringValidCallbackType callback;
@property (nonatomic,assign) void *userData;
@property (nonatomic,retain) NSCharacterSet *set;
@property (nonatomic,assign) BOOL pass;
@property (nonatomic,assign) NSUInteger length;
@property (nonatomic,assign) NSUInteger option;

- (id)initWithControl:(NSControl *)c callback:(CUI_ControlFormatterIsParticalStringValidCallbackType)cb userData:(void *)ud;
- (id)initWithCharacters:(NSString *)inCharacters pass:(BOOL)inPass length:(NSUInteger)inLength option:(NSUInteger)option;
- (void)setCharacters:(NSString *)inCharacters pass:(BOOL)inPass length:(NSUInteger)inLength option:(NSUInteger)option;

@end





#pragma mark - control
// dialog events
enum {
    controlTextDidBeginEditing = 1200,
    controlTextDidChange,
    controlTextDidEndEditing,
    controlTextShouldBeginEditing,
    controlTextShouldEndEditing,
    controlDoCommandBySelector
};

typedef void (*CUI_ControlCallbackType)(NSInteger,NSInteger,CFTypeRef);

@interface NSControl (Additions)
@property (nonatomic,retain) NSValue *callbackValue;
@property (nonatomic,retain) NSValue *userDataValue;

- (CUI_ControlCallbackType)cuiControlCallback;
- (void *)cuiControlUserData;
- (void)setCuiControlCallback:(CUI_ControlCallbackType)cccb;
- (void)setCuiControlUserData:(void *)userData;
@end


@interface CUI_ControlTarget : NSObject {
//    CUI_ControlCallbackType allControlsCallback;
}
@property (nonatomic,assign) CUI_ControlCallbackType allControlsCallback;

- (void)controlAction:(id)sender;

@end

// private
CUI_ControlTarget *CUI_ControlTargetObj( void );
void CUI_ControlCallUserDefinedOnDialogOrCallback( NSInteger ev, id sender, id obj  );

// fix font to match I.B.
void CUI_ControlFixFont( id c );


#pragma mark - public
// Class
Class ControlClass( void );

NSControl *ControlWithTag( NSInteger tag );
BOOL ControlExists( NSInteger tag );

double ControlDoubleValue( NSInteger tag );
void ControlSetDoubleValue( NSInteger tag, double value );
float ControlFloatValue( NSInteger tag );
void ControlSetFloatValue( NSInteger tag, float value );
SInt32 ControlIntValue( NSInteger tag );
void ControlSetIntValue( NSInteger tag, SInt32 value );
NSInteger ControlIntegerValue( NSInteger tag );
void ControlSetIntegerValue( NSInteger tag, NSInteger value );
CFTypeRef ControlObjectValue( NSInteger tag );
void ControlSetObjectValue( NSInteger tag, CFTypeRef obj );
CFStringRef ControlStringValue( NSInteger tag );
void ControlSetStringValue( NSInteger tag, CFStringRef string );
CFAttributedStringRef ControlAttributedStringValue( NSInteger tag );
void ControlSetAttributedStringValue( NSInteger tag, CFAttributedStringRef string );

NSControlSize ControlSize( NSInteger tag );

void ControlSetSize( NSInteger tag, NSControlSize size );
NSTextAlignment ControlAlignment( NSInteger tag );
void ControlSetAlignment( NSInteger tag, NSTextAlignment alignment );
void ControlSizeToFit( NSInteger tag );

// Displaying a cell
BOOL ControlIsHighlighted( NSInteger tag );
void ControlSetHighlighted( NSInteger tag, BOOL flag );

NSLineBreakMode ControlLineBreakMode( NSInteger tag );
void ControlSetLineBreakMode( NSInteger tag, NSLineBreakMode mode );
BOOL ControlUsesSingleLineMode( NSInteger tag );
void ControlSetUsesSingleLineMode( NSInteger tag, BOOL flag );
NSFormatter *ControlFormatter( NSInteger tag );
void ControlSetFormatter( NSInteger tag, NSFormatter *formatter );
NSWritingDirection ControlBaseWritingDirection( NSInteger tag );
void ControlSetBaseWritingDirection( NSInteger tag, NSWritingDirection direction );

void ControlDrawWithExpansionFrameInView( NSInteger ctrlTag, CGRect contentFrame, NSInteger vwTag );

BOOL ControlAllowsExpansionToolTips( NSInteger tag );
void ControlSetAllowsExpansionToolTips( NSInteger tag, BOOL flag );

CGRect ControlExpansionFrameWithFrame( NSInteger tag, CGRect contentFrame );

// Managing the field editor
BOOL ControlAbortEditing( NSInteger tag );
NSText *ControlCurrentEditor( NSInteger tag );
void ControlValidateEditing( NSInteger tag );
void ControlEndEditing( NSInteger tag, NSText *textObj );

NSFont *ControlFont( NSInteger tag );
void ControlSetFont( NSInteger tag, CFTypeRef inFont );
void ControlTakeDoubleValueFrom( NSInteger tag, NSInteger otherCtrlTag );
void ControlTakeFloatValueFrom( NSInteger tag, NSInteger otherCtrlTag );
void ControlTakeIntValueFrom( NSInteger tag, NSInteger otherCtrlTag );
void ControlTakeIntegerValueFrom( NSInteger tag, NSInteger otherCtrlTag );
void ControlTakeObjectValueFrom( NSInteger tag, NSInteger otherCtrlTag );
void ControlTakeStringValueFrom( NSInteger tag, NSInteger otherCtrlTag );

BOOL ControlIsEnabled( NSInteger tag );
void ControlSetEnabled( NSInteger tag, BOOL flag );

CGSize ControlSizeThatFits( NSInteger tag, CGSize size );

BOOL ControlIsContinuous( NSInteger tag );
void ControlSetContinuous( NSInteger tag, BOOL flag );
void ControlPerformClick( NSInteger tag );

void ControlSendActionOn( NSInteger tag, NSEventMask mask );

NSInteger ControlTag( NSControl *ref );
void ControlSetTag( NSControl *ref, NSInteger tag );

BOOL ControlRefusesFirstResponder( NSInteger tag );
void ControlSetRefusesFirstResponder( NSInteger tag, BOOL flag );

BOOL ControlIgnoresMultiClick( NSInteger tag );
void ControlSetIgnoresMultiClick( NSInteger tag, BOOL flag );

// Constraint-based layout
void ControlInvalidateIntrinsicContentSizeForCell( NSInteger tag, NSCell *cell );

// Deprecated
NSCell *ControlCell( NSInteger tag );

// custom
SEL ControlAction( NSInteger tag );
CFStringRef ControlActionName( NSInteger tag );
id ControlTarget( NSInteger tag );

void ControlSetFontWithName( NSInteger tag, CFStringRef inName, CGFloat size );
void ControlSetTargetAction( NSInteger ctrlTag, NSInteger targetTag, CFStringRef actionName );
void ControlSetAction( NSInteger tag, CFStringRef actionName );
void ControlSetActionCallback( NSInteger tag, CUI_ControlCallbackType callback, void *userData );

void ControlSetFormat( NSInteger tag, CFStringRef characters, BOOL pass, NSUInteger length, NSUInteger option );
void ControlFormatterSetIsPartialStringValidCallback( NSInteger tag, CUI_ControlFormatterIsParticalStringValidCallbackType callback, void *userData );

void ControlSetActionID( NSInteger tag, NSInteger actionID );
void ControlRangeSetActionID( CFRange range, NSInteger actionID );
NSInteger ControlActionIDSelectedButtonTag( NSInteger actionID, NSInteger superviewTag );

#pragma mark - set attributes of multiple controls
// enable
void ControlRangeSetEnabled( CFRange range, BOOL flag );
void ControlIndexesSetEnabled( NSIndexSet *indexes, BOOL flag );

// size
void ControlRangeSetSize( CFRange range, NSControlSize size );
void ControlIndexesSetSize( NSIndexSet *indexes, NSControlSize size );

// alighment
void ControlRangeSetAlignment( CFRange range, NSTextAlignment alignment );
void ControlIndexesSetAlignment( NSIndexSet *indexes, NSTextAlignment alignment );

// font
void ControlRangeSetFont( CFRange range, NSFont *font );
void ControlIndexesSetFont( NSIndexSet *indexes, NSFont *font );

#pragma mark - control function
NSInteger CUI_ControlFunction( NSInteger inTag, NSInteger inSelector );
