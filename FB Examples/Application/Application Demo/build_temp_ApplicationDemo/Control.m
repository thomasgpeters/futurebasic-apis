/*
 Control.m

 Bernie Wylde
 */

#import "Control.h"

#pragma mark - control formatter
@implementation CUI_ControlFormatter

- (id)initWithControl:(NSControl *)c callback:(CUI_ControlFormatterIsParticalStringValidCallbackType)cb userData:(void *)ud {
    if ( (self = [super init]) ) {
        self.control = c;
        self.callback = cb;
        self.userData = ud;
    }
    return self;
}

- (id)initWithCharacters:(NSString *)inCharacters pass:(BOOL)inPass length:(NSUInteger)inLength option:(NSUInteger)option {
    if ( (self = [super init]) ) {
        if ( option & formatPassword ) { // 20250401
            option -= formatPassword;
        }

        if ( inCharacters == NULL ) inCharacters = @"";
        NSMutableString *string = [inCharacters mutableCopy];
        switch ( option ) {
            case formatInteger:
                inPass = YES;
                [string setString:@"0123456789-"];
                break;
            case formatUnsignedInteger:
                inPass = YES;
                [string setString:@"0123456789"];
                break;
            case formatFloat:
                inPass = YES;
                [string setString:@"0123456789.-"];
                break;
            case formatUnsignedFloat:
                inPass = YES;
                [string setString:@"0123456789."];
                break;
            default:
                if ( option != formatCaseSensitive ) {
                    [string appendString:[string uppercaseString]];
                    [string appendString:[string lowercaseString]];
                }
                break;
        }
        
#if __has_feature(objc_arc)
        if ( inPass ) {
            self.set = [[NSMutableCharacterSet characterSetWithCharactersInString:string] invertedSet];
        } else {
            self.set = [NSMutableCharacterSet characterSetWithCharactersInString:string];
        }
#else
        if ( inPass ) {
            if ( [inCharacters length] == 0 ) {
                NSMutableCharacterSet *set = [NSMutableCharacterSet alphanumericCharacterSet];
                [set formUnionWithCharacterSet:[NSCharacterSet punctuationCharacterSet]];
                [set formUnionWithCharacterSet:[NSCharacterSet symbolCharacterSet]];
                [set formUnionWithCharacterSet:[NSCharacterSet controlCharacterSet]];
                [set formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
                self.set = [[set invertedSet] retain];
            } else {
                self.set = [[[NSMutableCharacterSet characterSetWithCharactersInString:string] invertedSet] retain];
            }

        } else {
            self.set = [[NSMutableCharacterSet characterSetWithCharactersInString:string] retain];
        }
#endif
        
        self.pass = inPass;
        self.length = inLength;
        self.option = option;
        
#if !__has_feature(objc_arc)
        [string release];
#endif
    }
    return self;
}

- (void)setCharacters:(NSString *)inCharacters pass:(BOOL)inPass length:(NSUInteger)inLength option:(NSUInteger)option {
    if ( inCharacters == NULL ) inCharacters = @"";
    NSMutableString *string = [inCharacters mutableCopy];
    
    if ( option != formatCaseSensitive ) {
        [string appendString:[string uppercaseString]];
        [string appendString:[string lowercaseString]];
    }
    
#if __has_feature(objc_arc)
    if ( inPass ) {
        self.set = [[NSMutableCharacterSet characterSetWithCharactersInString:string] invertedSet];
    } else {
        self.set = [NSMutableCharacterSet characterSetWithCharactersInString:string];
    }
#else
    if ( inPass ) {
        self.set = [[[NSMutableCharacterSet characterSetWithCharactersInString:string] invertedSet] retain];
    } else {
        self.set = [[NSMutableCharacterSet characterSetWithCharactersInString:string] retain];
    }
#endif
    
    self.pass = inPass;
    self.length = inLength;
    self.option = option;
    
#if !__has_feature(objc_arc)
    [string release];
#endif
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.set release];
    [super dealloc];
}
#endif

- (NSString *)stringForObjectValue:(id)obj {
    if ( [obj isKindOfClass:[NSString class]] ) return [NSString stringWithString:obj];
    return nil;
}

- (BOOL)getObjectValue:(id *)obj forString:(NSString *)string errorDescription:(NSString **)error {
    if ( string != nil ) {
        *obj = [NSString stringWithString:string];
        return YES;
    }
    return NO;
}

- (BOOL)isPartialStringValid:(NSString **)partialStringPtr proposedSelectedRange:(NSRangePointer)proposedSelRangePtr originalString:(NSString *)origString originalSelectedRange:(NSRange)origSelRange errorDescription:(NSString **)error {
    BOOL accept = YES;

    if ( self.callback ) {
        accept = (*self.callback)( [self.control tag], (CFStringRef *)partialStringPtr, (CFRange *)proposedSelRangePtr, (__bridge CFStringRef)origString, NSRangeToCFRange(origSelRange), (CFStringRef *)error, self.userData );
        
        // kludge to replace above
//        CFStringRef tempCFString = nil;// !!!
//        CFStringRef tempCFString = (__bridge CFStringRef *)*partialStringPtr;
//        CFStringRef tempCFError = (__bridge CFStringRef)*error;
//        accept = (*_callback)( [_control tag], &tempCFString, (CFRange *)proposedSelRangePtr, (__bridge CFStringRef)origString, NSRangeToCFRange(origSelRange), &tempCFError, _userData );
//        if ( tempCFString ) {
//            NSString *tempNSString = (__bridge NSString *)tempCFString;
//            *partialStringPtr = tempNSString;
//        }
    } else {
        if ( self.length ) {
            if ([*partialStringPtr length] > self.length) {
                accept = NO;
            }
        }
        
        if ( accept ) {
            NSString *resultString;
            if ( self.set ) {
                resultString = [[*partialStringPtr componentsSeparatedByCharactersInSet:self.set] componentsJoinedByString:@""];
            } else {
                resultString = *partialStringPtr;
            }
                        
            switch ( self.option ) {
                case formatLowercase:
                    if (![*partialStringPtr isEqual:[resultString lowercaseString]]) {
                        *partialStringPtr = [resultString lowercaseString];
                        accept = NO;
                    }
                    break;
                case formatUppercase:
                    if (![*partialStringPtr isEqual:[resultString uppercaseString]]) {
                        *partialStringPtr = [resultString uppercaseString];
                        accept = NO;
                    }
                    break;
                case formatCapitalize:
                    if (![*partialStringPtr isEqual:[resultString capitalizedString]]) {
                        *partialStringPtr = [resultString capitalizedString];
                        accept = NO;
                    }
                    break;
                case formatInteger: {
                    NSArray *dashes = [resultString componentsSeparatedByString:@"-"];
                    if ( [dashes count] < 3 ) {
                        if ( [dashes count] > 1 ) {
                            if ( ![resultString hasPrefix:@"-"] ) return NO;
                        }
                    } else {
                        return NO;
                    }
                    if ( ![resultString isEqualToString:*partialStringPtr] ) {
                        *partialStringPtr = resultString;
                        accept = NO;
                    }
                    break;
                }
                case formatUnsignedInteger: {
                    if ( ![resultString isEqualToString:*partialStringPtr] ) {
                        *partialStringPtr = resultString;
                        accept = NO;
                    }
                    break;
                }
                case formatFloat: {
                    NSArray *dashes = [resultString componentsSeparatedByString:@"-"];
                    if ( [dashes count] < 3 ) {
                        if ( [dashes count] > 1 ) {
                            if ( ![resultString hasPrefix:@"-"] ) return NO;
                        }
                    } else {
                        return NO;
                    }
                    
                    NSArray *periods = [resultString componentsSeparatedByString:@"."];
                    if ( [periods count] > 2 ) return NO;
                        
                    if ( ![resultString isEqualToString:*partialStringPtr] ) {
                        *partialStringPtr = resultString;
                        accept = NO;
                    }
                    break;
                }
                case formatUnsignedFloat: {
                    NSArray *periods = [resultString componentsSeparatedByString:@"."];
                    if ( [periods count] > 2 ) return NO;
                    if ( ![resultString isEqualToString:*partialStringPtr] ) {
                        *partialStringPtr = resultString;
                        accept = NO;
                    }
                    break;
                }
                case formatCaseSensitive:
                default:
                    if ( ![resultString isEqualToString:*partialStringPtr] ) {
                        *partialStringPtr = resultString;
                        accept = NO;
                    }
                    break;
            }
        }

    }
    return accept;
}
@end


#pragma mark - control
// Class
Class ControlClass( void )
{ return [NSControl class]; }

NSControl *ControlWithTag( NSInteger tag )
{ return (NSControl *)CUI_ValidateViewKindOfClass( tag, [NSControl class] ); }

BOOL ControlExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSControl class] ); }


@implementation NSControl (Additions)
@dynamic callbackValue;
@dynamic userDataValue;

- (CUI_ControlCallbackType)cuiControlCallback {
    return (CUI_ControlCallbackType)[(NSValue *)objc_getAssociatedObject(self, @selector(callbackValue)) pointerValue];
}

- (void *)cuiControlUserData {
    return [(NSValue *)objc_getAssociatedObject(self, @selector(userDataValue)) pointerValue];
}

- (void)setCuiControlCallback:(CUI_ControlCallbackType)callback {
    objc_setAssociatedObject(self, @selector(callbackValue), [NSValue valueWithPointer:(void *)callback], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setCuiControlUserData:(void *)userData {
    objc_setAssociatedObject(self, @selector(userDataValue), [NSValue valueWithPointer:userData], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end



@implementation CUI_ControlTarget

- (void)controlAction:(id)sender {
    NSInteger wndTag = [sender wndTag];// 20190609
    if ( wndTag < 1 ) {
        wndTag = [[sender window] tag];
    }
    CUI_OutputWindowSetTag( wndTag );
    CUI_ControlCallbackType callback = [(NSControl *)sender cuiControlCallback];

    if ( wndTag == 0 ) { // if wndTag is zero, search open and save panels for view 20250306
        wndTag = CUI_OpenPanelContainingAccessoryView( sender );
        if ( wndTag == 0 ) {
            wndTag = CUI_SavePanelContainingAccessoryView( sender );
        }
    }
    
    if ( callback ) {
        void *userData = [(NSControl *)sender cuiControlUserData];
        (*callback)([sender tag],wndTag,userData);
    } else if ( self.allControlsCallback ) {
        (*self.allControlsCallback)([sender tag],wndTag,NULL);
    } else {
        CallUserDefinedOnDialogFunction( 1, [sender tag], wndTag, (__bridge CFTypeRef)sender );// 1 == kFBBtnClick
    }
}

// these actions used by ControlSetActionID
- (void)controlAction1:(id)sender {
    [self controlAction:sender];
}

- (void)controlAction2:(id)sender {
    [self controlAction:sender];
}

- (void)controlAction3:(id)sender {
    [self controlAction:sender];
}

- (void)controlAction4:(id)sender {
    [self controlAction:sender];
}

- (void)controlAction5:(id)sender {
    [self controlAction:sender];
}

- (void)controlAction6:(id)sender {
    [self controlAction:sender];
}

- (void)controlAction7:(id)sender {
    [self controlAction:sender];
}

- (void)controlAction8:(id)sender {
    [self controlAction:sender];
}

- (void)controlAction9:(id)sender {
    [self controlAction:sender];
}

- (void)controlAction10:(id)sender {
    [self controlAction:sender];
}

@end

// private
CUI_ControlTarget *CUI_ControlTargetObj( void )
{
    static CUI_ControlTarget *sCUI_ControlTarget = nil;
    if ( !sCUI_ControlTarget ) sCUI_ControlTarget = [[CUI_ControlTarget alloc] init];
    return sCUI_ControlTarget;
}


void CUI_ControlCallUserDefinedOnDialogOrCallback( NSInteger ev, id sender, id obj  )
{
    CUI_EventSetEvent( [NSApp currentEvent] );
    CUI_OutputWindowSetTag( [sender wndTag] );
    NSInteger wndTag = [sender wndTag];// 20190609
    
    if ( [sender class] == [CUI_RadioGroup class] ) {
        CallUserDefinedOnDialogFunction( ev, [[sender identifier] integerValue], wndTag, (__bridge CFTypeRef)obj );
    } else {
        CUI_ControlTarget *target = CUI_ControlTargetObj();
        CUI_ControlCallbackType allControlsCallback = target.allControlsCallback;
        CUI_ControlCallbackType callback = [(NSControl *)sender cuiControlCallback];
        if ( wndTag < 1 ) {
            wndTag = [[sender window] tag];
        }
        NSInteger tag = [sender tag];
        if ( callback ) {
            void *userData = [(NSControl *)sender cuiControlUserData];
            (*callback)(tag,wndTag,userData);
        } else if ( allControlsCallback ) {
            (*allControlsCallback)(tag,wndTag,(__bridge CFTypeRef)obj);
        } else {
            CallUserDefinedOnDialogFunction( ev, tag, wndTag, (__bridge CFTypeRef)obj );
        }
    }
}


// private
// fix font to match IB
void CUI_ControlFixFont( id c )
{ [c setFont:[NSFont systemFontOfSize:[NSFont systemFontSizeForControlSize:[[c cell] controlSize]]]]; }

// public
double ControlDoubleValue( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return [c doubleValue];
    return 0.0;
}

void ControlSetDoubleValue( NSInteger tag, double value )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [c setDoubleValue:value];
}

float ControlFloatValue( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return [c floatValue];
    return 0.0;
}

void ControlSetFloatValue( NSInteger tag, float value )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [c setFloatValue:value];
}

SInt32 ControlIntValue( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return [c intValue];
    return 0;
}

void ControlSetIntValue( NSInteger tag, SInt32 value )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [c setIntValue:value];
}

NSInteger ControlIntegerValue( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return [c integerValue];
    return 0;
}

void ControlSetIntegerValue( NSInteger tag, NSInteger value )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [c setIntegerValue:value];
}

CFTypeRef ControlObjectValue( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return (__bridge CFTypeRef)[c objectValue];
    return NULL;
}

void ControlSetObjectValue( NSInteger tag, CFTypeRef obj )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [c setObjectValue:(__bridge id)obj];
}

CFStringRef ControlStringValue( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return (__bridge CFStringRef)[c stringValue];
    return NULL;
}

void ControlSetStringValue( NSInteger tag, CFStringRef string )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [c setStringValue:(__bridge NSString *)string];
}

CFAttributedStringRef ControlAttributedStringValue( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return (__bridge CFAttributedStringRef)[c attributedStringValue];
    return NULL;
}

void ControlSetAttributedStringValue( NSInteger tag, CFAttributedStringRef string )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [c setAttributedStringValue:(__bridge NSAttributedString *)string];
}

NSControlSize ControlSize( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return [c controlSize];
    return 0;
}

void ControlSetSize( NSInteger tag, NSControlSize size )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) {
        [c setControlSize:size];
//        if ( [c respondsToSelector:@selector(setControlSize:)] ) {
//            [c setControlSize:size];
//        } else {
//            [[c cell] setControlSize:size];
//        }
        [c setFont:[NSFont systemFontOfSize:[NSFont systemFontSizeForControlSize:size]]];
    }
}

NSTextAlignment ControlAlignment( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return [c alignment];
    return 0;
}

void ControlSetAlignment( NSInteger tag, NSTextAlignment alignment )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [c setAlignment:alignment];
}


void ControlSizeToFit( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [c sizeToFit];
}

// Displaying a cell
BOOL ControlIsHighlighted( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return [c isHighlighted];
    return NO;
}

void ControlSetHighlighted( NSInteger tag, BOOL flag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [c setHighlighted:flag];
}

NSLineBreakMode ControlLineBreakMode( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return [[c cell] lineBreakMode];
    return 0;
}

void ControlSetLineBreakMode( NSInteger tag, NSLineBreakMode mode )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [[c cell] setLineBreakMode:mode];
}

BOOL ControlUsesSingleLineMode( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return [[c cell] usesSingleLineMode];
    return NO;
}

void ControlSetUsesSingleLineMode( NSInteger tag, BOOL flag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [[c cell] setUsesSingleLineMode:flag];
}

NSFormatter *ControlFormatter( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return [c formatter];
    return nil;
}

void ControlSetFormatter( NSInteger tag, NSFormatter *formatter )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [c setFormatter:formatter];
}

NSWritingDirection ControlBaseWritingDirection( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return [c baseWritingDirection];
    return 0;
}

void ControlSetBaseWritingDirection( NSInteger tag, NSWritingDirection direction )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [c setBaseWritingDirection:direction];
}

void ControlDrawWithExpansionFrameInView( NSInteger ctrlTag, CGRect contentFrame, NSInteger vwTag )
{
    NSControl *c = (NSControl *)ControlWithTag( ctrlTag );
    if ( c ) {
        NSView *view = ViewWithTag( vwTag );
        if ( view ) [c drawWithExpansionFrame:NSRectFromCGRect(contentFrame) inView:view];
    }
}

BOOL ControlAllowsExpansionToolTips( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return [c allowsExpansionToolTips];
    return NO;
}

void ControlSetAllowsExpansionToolTips( NSInteger tag, BOOL flag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [c setAllowsExpansionToolTips:flag];
}

CGRect ControlExpansionFrameWithFrame( NSInteger tag, CGRect contentFrame )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return NSRectToCGRect([c expansionFrameWithFrame:NSRectFromCGRect(contentFrame)]);
    return CGRectZero;
}

// Managing the field editor
BOOL ControlAbortEditing( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [c abortEditing];
    return NO;
}

NSText *ControlCurrentEditor( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return [c currentEditor];
    return nil;
}

void ControlValidateEditing( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [c validateEditing];
}

void ControlEndEditing( NSInteger tag, NSText *textObj )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [c endEditing:textObj];
}


NSFont *ControlFont( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return [c font];
    return nil;
}

void ControlSetFont( NSInteger tag, CFTypeRef inFont )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) {
        NSFont *font = CUI_FixFont( (const void *)inFont );
        [c setFont:font];
    }
}

void ControlTakeDoubleValueFrom( NSInteger tag, NSInteger otherCtrlTag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) {
        id otherCtrl = (id)CUI_ViewWithTag( otherCtrlTag );
        if ( otherCtrl ) [c takeDoubleValueFrom:otherCtrl];
    }
}

void ControlTakeFloatValueFrom( NSInteger tag, NSInteger otherCtrlTag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) {
        id otherCtrl = (id)CUI_ViewWithTag( otherCtrlTag );
        if ( otherCtrl ) [c takeFloatValueFrom:otherCtrl];
    }
}

void ControlTakeIntValueFrom( NSInteger tag, NSInteger otherCtrlTag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) {
        id otherCtrl = (id)CUI_ViewWithTag( otherCtrlTag );
        if ( otherCtrl ) [c takeIntValueFrom:otherCtrl];
    }
}

void ControlTakeIntegerValueFrom( NSInteger tag, NSInteger otherCtrlTag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) {
        id otherCtrl = (id)CUI_ViewWithTag( otherCtrlTag );
        if ( otherCtrl ) [c takeIntegerValueFrom:otherCtrl];
    }
}

void ControlTakeObjectValueFrom( NSInteger tag, NSInteger otherCtrlTag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) {
        id otherCtrl = (id)CUI_ViewWithTag( otherCtrlTag );
        if ( otherCtrl ) [c takeIntegerValueFrom:otherCtrl];
    }
}

void ControlTakeStringValueFrom( NSInteger tag, NSInteger otherCtrlTag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) {
        id otherCtrl = (id)CUI_ViewWithTag( otherCtrlTag );
        if ( otherCtrl ) [c takeStringValueFrom:otherCtrl];
    }
}

void ControlSetEnabled( NSInteger tag, BOOL flag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [c setEnabled:flag];
}

BOOL ControlIsEnabled( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return [c isEnabled];
    return false;
}

CGSize ControlSizeThatFits( NSInteger tag, CGSize size )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return NSSizeToCGSize([c sizeThatFits:NSSizeFromCGSize(size)]);
    return CGSizeZero;
}

BOOL ControlIsContinuous( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return [c isContinuous];
    return NO;
}

void ControlSetContinuous( NSInteger tag, BOOL flag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [c setContinuous:flag];
}

void ControlPerformClick( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [c performClick:nil];
}

void ControlSendActionOn( NSInteger tag, NSEventMask mask )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [c sendActionOn:mask];
}

NSInteger ControlTag( NSControl *ref )
{ return [ref tag]; }

void ControlSetTag( NSControl *ref, NSInteger tag )
{ [ref setTag:tag]; }

BOOL ControlRefusesFirstResponder( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return [c refusesFirstResponder];
    return NO;
}

void ControlSetRefusesFirstResponder( NSInteger tag, BOOL flag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [c setRefusesFirstResponder:flag];
}

BOOL ControlIgnoresMultiClick( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return [c ignoresMultiClick];
    return NO;
}

void ControlSetIgnoresMultiClick( NSInteger tag, BOOL flag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [c setIgnoresMultiClick:flag];
}

// Constraint-based layout
void ControlInvalidateIntrinsicContentSizeForCell( NSInteger tag, NSCell *cell )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) [c invalidateIntrinsicContentSizeForCell:cell];
}


// Deprecated
NSCell *ControlCell( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return [c cell];
    return nil;
}


// custom
SEL ControlAction( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return [c action];
    return nil;
}

CFStringRef ControlActionName( NSInteger tag )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) return (__bridge CFStringRef)NSStringFromSelector([c action]);
    return nil;
}

id ControlTarget( NSInteger tag );

void ControlSetFontWithName( NSInteger tag, CFStringRef inName, CGFloat size )
{
    BOOL usePrevFont = NO;
    NSString *name = (__bridge NSString *)inName;
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) {
        if ( name ) {
            usePrevFont = ( [name length] == 0 );
        } else {
            usePrevFont = YES;
        }
        if ( usePrevFont ) name = [[c font] fontName];
        if ( (int)size == 0 ) size = [[c font] pointSize];
        [c setFont:[NSFont fontWithName:name size:size]];// hm, this clips descenders
        
        //        CTFontRef font = CTFontCreateWithName( (__bridge CFStringRef)name, size, NULL );
        //        [c setFont:(NSFont *)font];
        //        CFRelease(font);
    }
}

void ControlSetTargetAction( NSInteger ctrlTag, NSInteger targetTag, CFStringRef actionName )
{
    NSControl *ctrl = (NSControl *)ControlWithTag( ctrlTag );
    if ( ctrl ) {
        id target = nil;
        if ( targetTag ) target = ViewWithTag( targetTag );
        [ctrl setTarget:target];
        [ctrl setAction:NSSelectorFromString((__bridge NSString *)actionName)];
    }
}

void ControlSetAction( NSInteger tag, CFStringRef actionName )
{
    NSControl *c = (NSControl *)ControlWithTag( tag );
    if ( c ) {
        [c setTarget:nil];
        [c setAction:NSSelectorFromString((__bridge NSString *)actionName)];
    }
}

void ControlSetActionCallback( NSInteger tag, CUI_ControlCallbackType callback, void *userData )
{
    if ( tag == 0 ) {   // all controls
        CUI_ControlTarget *target = CUI_ControlTargetObj();
        [target setAllControlsCallback:callback];
    } else {            // individual control
        NSControl *c = (NSControl *)ControlWithTag( tag );
        if ( c ) {
            [c setCuiControlCallback:callback];
            [c setCuiControlUserData:userData];
        }
    }
}

void ControlSetFormat( NSInteger tag, CFStringRef characters, BOOL pass, NSUInteger length, NSUInteger option )
{
    NSControl *c = ControlWithTag( tag );
    if ( c ) {
        CUI_ControlFormatter *formatter = [[CUI_ControlFormatter alloc] initWithCharacters:(__bridge NSString *)characters pass:pass length:length option:option];
        [c setFormatter:formatter];
#if !__has_feature(objc_arc)
        [formatter release];
#endif
    }
}

void ControlFormatterSetIsPartialStringValidCallback( NSInteger tag, CUI_ControlFormatterIsParticalStringValidCallbackType callback, void *userData )
{
    NSControl *c = ControlWithTag( tag );
    if ( c ) {
        CUI_ControlFormatter *formatter = [c formatter];
        if ( !formatter ) {
#if __has_feature(objc_arc)
            formatter = [[CUI_ControlFormatter alloc] initWithControl:c callback:callback userData:userData];
#else
            formatter = [[[CUI_ControlFormatter alloc] initWithControl:c callback:callback userData:userData] autorelease];
#endif
            [c setFormatter:formatter];
        } else {
            [formatter setControl:c];
            [formatter setCallback:callback];
            [formatter setUserData:userData];
        }
    }
}


void ControlSetActionID( NSInteger tag, NSInteger actionID )
{
    if ( actionID < 1 || actionID > 10 ) return;
    NSControl *c = ControlWithTag( tag );
    if ( c ) {
        NSString *actionName = [NSString stringWithFormat:@"controlAction%ld:",actionID];
        [c setAction:NSSelectorFromString(actionName)];
    }
}

void ControlRangeSetActionID( CFRange range, NSInteger actionID )
{
    for ( NSInteger tag = range.location; tag < (range.location + range.length); tag++ ) {
        ControlSetActionID( tag, actionID );
    }
}

NSInteger ControlActionIDSelectedButtonTag( NSInteger actionID, NSInteger superviewTag )
{
    NSInteger tag = 0;
    NSView *superview = nil;
    
    NSString *actionString = [NSString stringWithFormat:@"controlAction%ld:",actionID];
    
    if ( superviewTag ) {
      superview = CUI_ViewWithTag( superviewTag );
    } else {
        superview = CUI_OutputWindowContentView();
        if ( !superview ) {
            id w = CUI_FrontWindow();
            if ( w ) superview = [(NSWindow *)w contentView];
        }
    }
    
    if ( superview ) {
        NSArray *subviews = [superview subviews];
        for ( NSView *subview in subviews ) {
            if ( [subview isKindOfClass:[NSButton class]] ) {
                NSButton *btn = (NSButton *)subview;
                    if ( [btn action] == NSSelectorFromString(actionString) ) {
                        if ( [btn state] == NSOnState ) {
                            return [btn tag];
                        }
                    }
            }
        }
    }
    
    return tag;
}

#pragma mark - set attributes of multiple controls
// enable
void ControlRangeSetEnabled( CFRange range, BOOL flag )
{
    for ( NSInteger tag = range.location; tag < range.location + range.length; tag++ ) {
        if ( CUI_ViewWithKindOfClassExists( tag, [NSControl class] ) ) {
            NSControl *c = ControlWithTag( tag );
            if ( c ) {
                if ( [c respondsToSelector:@selector(setEnabled:)] ) {
                    [c setEnabled:flag];
                }
            }
        }
    }
}

void ControlIndexesSetEnabled( NSIndexSet *indexes, BOOL flag )
{
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop __attribute__ ((__unused__))) {
        if ( CUI_ViewWithKindOfClassExists( idx, [NSControl class] ) ) {
            NSControl *c = ControlWithTag( idx );
            if ( c ) {
                if ( [c respondsToSelector:@selector(setEnabled:)] ) {
                    [c setEnabled:flag];
                }
            }
        }
    }];
}


// size
void ControlRangeSetSize( CFRange range, NSControlSize size )
{
    for ( NSInteger tag = range.location; tag < range.location + range.length; tag++ ) {
        if ( CUI_ViewWithKindOfClassExists( tag, [NSControl class] ) ) {
            NSControl *c = ControlWithTag( tag );
            if ( c ) {
                if ( [[c cell] respondsToSelector:@selector(setControlSize:)] ) {
                    [[c cell] setControlSize:size];
                    [c setFont:[NSFont systemFontOfSize:[NSFont systemFontSizeForControlSize:size]]];
                }
            }
        }
    }
}

void ControlIndexesSetSize( NSIndexSet *indexes, NSControlSize size )
{
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop __attribute__ ((__unused__))) {
        if ( CUI_ViewWithKindOfClassExists( idx, [NSControl class] ) ) {
            NSControl *c = ControlWithTag( idx );
            if ( c ) {
                if ( [[c cell] respondsToSelector:@selector(setControlSize:)] ) {
                    [[c cell] setControlSize:size];
                    [c setFont:[NSFont systemFontOfSize:[NSFont systemFontSizeForControlSize:size]]];
                }
            }
        }
    }];
}

// alignment
void ControlRangeSetAlignment( CFRange range, NSTextAlignment alignment )
{
    for ( NSInteger tag = range.location; tag < range.location + range.length; tag++ ) {
        if ( CUI_ViewWithKindOfClassExists( tag, [NSControl class] ) ) {
            NSControl *c = ControlWithTag( tag );
            if ( c ) {
                if ( [c respondsToSelector:@selector(setAlignment:)] ) {
                    [c setAlignment:alignment];
                }
            }
        }
    }
}

void ControlIndexesSetAlignment( NSIndexSet *indexes, NSTextAlignment alignment )
{
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop __attribute__ ((__unused__))) {
        if ( CUI_ViewWithKindOfClassExists( idx, [NSControl class] ) ) {
            NSControl *c = ControlWithTag( idx );
            if ( c ) {
                if ( [c respondsToSelector:@selector(setAlignment:)] ) {
                    [c setAlignment:alignment];
                }
            }
        }
    }];
}

// font
void ControlRangeSetFont( CFRange range, NSFont *font )
{
    for ( NSInteger tag = range.location; tag < range.location + range.length; tag++ ) {
        if ( CUI_ViewWithKindOfClassExists( tag, [NSControl class] ) ) {
            NSControl *c = ControlWithTag( tag );
            if ( c ) {
                if ( [c respondsToSelector:@selector(setFont:)] ) {
                    [c setFont:font];
                }
            }
        }
    }
}

void ControlIndexesSetFont( NSIndexSet *indexes, NSFont *font )
{
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop __attribute__ ((__unused__))) {
        if ( CUI_ViewWithKindOfClassExists( idx, [NSControl class] ) ) {
            NSControl *c = ControlWithTag( idx );
            if ( c ) {
                if ( [c respondsToSelector:@selector(setFont:)] ) {
                    [c setFont:font];
                }
            }
        }
    }];
}


#pragma mark - control function
NSInteger CUI_ControlFunction( NSInteger inTag, NSInteger inSelector )
{
    NSInteger result = 0, wndTag = kFBParamMissing;
    inTag = ABS(inTag);
    
    // target window
    id w = CUI_TargetWindow( &wndTag );
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSButton *c = CUI_ViewSubviewWithTag( contentView, inTag );
        if ( !c ) {
            c = TitlebarAccessoryViewWithTag( inTag );
        }
        if ( c ) {    // control exists
            if ( inSelector == kFBParamMissing ) inSelector = 0;// state
            switch ( inSelector ) {
                case controlEnabled:
                    if ( [c respondsToSelector:@selector(isEnabled)] ) result = [c isEnabled];
                    break;
                case controlHidden:
                    if ( [c respondsToSelector:@selector(isHidden)] ) result = [c isHidden];
                    break;
                case controlIntVal:
                    if ( [c respondsToSelector:@selector(integerValue)] ) result = [c integerValue];
                    break;
                case controlState:// state
                default:
                    if ( [c respondsToSelector:@selector(state)] ) result = [c state];
                    break;
            }
        }
    } else {
        CUI_ShowWindowDoesNotExistAlert( wndTag );
    }
    return result;
}

