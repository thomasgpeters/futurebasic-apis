/*
 Alert.m
 
 Bernie Wylde
 */

#import "Alert.h"

static NSMutableArray *sCUI_Alerts;

@implementation CUI_AlertDelegate

#pragma mark - alert delegate methods
- (BOOL)alertShowHelp:(NSAlert *)alert {
    DialogEventSetBool( NO );
    CallUserDefinedOnDialogFunction( alertShowHelp, [alert tag], [alert tag], (__bridge CFTypeRef)alert );
    return DialogEventBool();
}

- (void)alertDidEnd:(NSAlert *)alert returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo {
    self.lastSuppressionButtonState = [[alert suppressionButton] state];
    CallUserDefinedOnDialogFunction( alertDidEnd, returnCode, [alert tag], (__bridge CFTypeRef)alert );
}

@end

CUI_AlertDelegate *CUI_AlertDelegateObj( void )
{
    static CUI_AlertDelegate *sCUI_AlertDelegate = nil;
    if ( !sCUI_AlertDelegate ) sCUI_AlertDelegate = [[CUI_AlertDelegate alloc] init];
    return sCUI_AlertDelegate;
}

NSAlert *CUI_AlertWithTag( NSInteger tag, BOOL create )
{
    if ( tag ) {
        if ( tag > 1000000 ) {
            //return (NSAlert *)tag;// it's an NSAlert
            return (__bridge NSAlert *)(void *)tag;
        }
        if ( sCUI_Alerts ) {
            for ( NSAlert *alert in sCUI_Alerts ) {
                if ( [alert tag] == tag ) return alert;
            }
        }
        if ( create ) return AlertInit( tag );
    }
    return nil;
}

void CUI_AlertAdd( NSAlert *alert )
{
    if ( !sCUI_Alerts ) sCUI_Alerts = [[NSMutableArray alloc] initWithCapacity:0];
    [sCUI_Alerts addObject:alert];
}

void CUI_AlertRemove( NSAlert *alert )
{ [sCUI_Alerts removeObject:alert]; }


// -- custom --
void AlertRemove( NSInteger tag )
{
    NSAlert *alert = CUI_AlertWithTag( tag, NO );
    if ( alert ) {
        [sCUI_Alerts removeObject:alert];
    }
}

void AlertButtonSetKeyEquivalent( NSInteger alertTag, NSUInteger btnIndex, CFStringRef key )
{
    NSAlert *alert = CUI_AlertWithTag( alertTag, YES );
    if ( alert ) {
        NSArray *buttons = [alert buttons];
        if ( btnIndex < [buttons count] ) {
            NSButton *btn = [buttons objectAtIndex:btnIndex];
            [btn setKeyEquivalent:(__bridge NSString *)key];
        }
    }
}

void AlertButtonSetKeyEquivalentModifierMask( NSInteger alertTag, NSUInteger btnIndex, NSUInteger mask )
{
    NSAlert *alert = CUI_AlertWithTag( alertTag, YES );
    if ( alert ) {
        NSArray *buttons = [alert buttons];
        if ( btnIndex < [buttons count] ) {
            NSButton *btn = [buttons objectAtIndex:btnIndex];
            [btn setKeyEquivalentModifierMask:mask];
        }
    }
}


@implementation NSAlert (Additions)
@dynamic tagNumber;
@dynamic sheetNumber;

- (NSInteger)tag {
    return [objc_getAssociatedObject(self, @selector(tagNumber)) integerValue];
}

- (void)setTag:(NSInteger)tag {
    objc_setAssociatedObject(self, @selector(tagNumber), [NSNumber numberWithInteger:tag], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)sheet {
    return [objc_getAssociatedObject(self, @selector(sheetNumber)) boolValue];
}

- (void)setSheet:(BOOL)sheet {
    objc_setAssociatedObject(self, @selector(sheetNumber), [NSNumber numberWithBool:sheet], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

// Class
Class AlertClass( void )
{ return [NSAlert class]; }

NSAlert *AlertWithTag( NSInteger tag )
{ return CUI_AlertWithTag( tag, NO ); }

BOOL AlertExists( NSInteger tag )
{
    if ( sCUI_Alerts ) {
        for ( NSAlert *alert in sCUI_Alerts ) {
            if ( [alert tag] == tag ) return YES;
        }
    }
    return NO;
}

// Configure
void AlertLayout( NSInteger tag )
{
    NSAlert *alert = CUI_AlertWithTag( tag, YES );
    if ( alert ) [alert layout];
}

NSAlertStyle AlertStyle( NSInteger tag )
{
    NSAlert *alert = CUI_AlertWithTag( tag, NO );
    if ( alert ) return [alert alertStyle];
    return 0;
}

void AlertSetStyle( NSInteger tag, NSAlertStyle style )
{
    NSAlert *alert = CUI_AlertWithTag( tag, YES );
    if ( alert ) [alert setAlertStyle:style];
}

//NSView *AlertAccessoryView( NSInteger alertTag )
//{
//    NSAlert *alert = CUI_AlertWithTag( alertTag, NO );
//    if ( alert ) {
//        return [alert accessoryView];
//    }
//    return nil;
//}

CFTypeRef AlertAccessoryView( NSInteger alertTag )
{
    NSAlert *alert = CUI_AlertWithTag( alertTag, NO );
    if ( alert ) {
        return (__bridge CFTypeRef)[alert accessoryView];
    }
    return nil;
}

void AlertSetAccessoryView( NSInteger alertTag, NSInteger viewTag )
{
    NSAlert *alert = CUI_AlertWithTag( alertTag, YES );
    if ( alert ) {
        NSView *view = CUI_ViewWithTag( viewTag );
        if ( view ) [alert setAccessoryView:view];
    }
}

BOOL AlertShowsHelp( NSInteger tag )
{
    NSAlert *alert = CUI_AlertWithTag( tag, NO );
    if ( alert ) {
        return [alert showsHelp];
    }
    return NO;
}

void AlertSetShowsHelp( NSInteger tag, BOOL flag )
{
    NSAlert *alert = CUI_AlertWithTag( tag, YES );
    if ( alert ) {
        [alert setShowsHelp:flag];
    }
}

CFStringRef AlertHelpAnchor( NSInteger tag )
{
    NSAlert *alert = CUI_AlertWithTag( tag, NO );
    if ( alert ) {
        return (__bridge CFStringRef)[alert helpAnchor];
    }
    return nil;
}

void AlertSetHelpAnchor( NSInteger tag, CFStringRef anchorName )
{
    NSAlert *alert = CUI_AlertWithTag( tag, YES );
    if ( alert ) {
        [alert setHelpAnchor:(__bridge NSString *)anchorName];
    }
}

NSButton *AlertSuppressionButton( NSInteger tag )
{
    NSAlert *alert = CUI_AlertWithTag( tag, NO );
    if ( alert ) {
        return [alert suppressionButton];
    }
    return nil;
}

BOOL AlertShowsSuppressionButton( NSInteger tag )
{
    NSAlert *alert = CUI_AlertWithTag( tag, NO );
    if ( alert ) {
        return [alert showsSuppressionButton];
    }
    return NO;
}

void AlertSetShowsSuppressionButton( NSInteger tag, BOOL flag )
{
    NSAlert *alert = CUI_AlertWithTag( tag, YES );
    if ( alert ) {
        [alert setShowsSuppressionButton:flag];
    }
}

void AlertSuppressionButtonSetState( NSInteger tag, NSCellStateValue value )
{
    NSAlert *alert = CUI_AlertWithTag( tag, YES );
    if ( alert ) {
        [[alert suppressionButton] setState:value];
    }
}

NSCellStateValue AlertSuppressionButtonState( NSInteger tag )
{
    NSAlert *alert = CUI_AlertWithTag( tag, NO );
    if ( alert ) {
        CUI_AlertDelegate *delegate = [alert delegate];
        if ( !delegate ) delegate = CUI_AlertDelegateObj();
        if ( delegate ) return delegate.lastSuppressionButtonState;
    }
    return NSOffState;
}

CFStringRef AlertSuppressionButtonTitle( NSInteger tag )
{
    NSAlert *alert = CUI_AlertWithTag( tag, NO );
    if ( alert ) return (__bridge CFStringRef)[[alert suppressionButton] title];
    return nil;
}

void AlertSuppressionButtonSetTitle( NSInteger tag, CFStringRef title )
{
    NSAlert *alert = CUI_AlertWithTag( tag, YES );
    if ( alert ) {
        [[alert suppressionButton] setTitle:(__bridge NSString *)title];
    }
}

CFStringRef AlertInformativeText( NSInteger tag )
{
    NSAlert *alert = CUI_AlertWithTag( tag, NO );
    if ( alert ) return (__bridge CFStringRef)[alert informativeText];
    return nil;
}

void AlertSetInformativeText( NSInteger tag, CFStringRef string )
{
    NSAlert *alert = CUI_AlertWithTag( tag, YES );
    if ( alert ) [alert setInformativeText:(__bridge NSString *)string];
}

CFStringRef AlertMessageText( NSInteger tag )
{
    NSAlert *alert = CUI_AlertWithTag( tag, NO );
    if ( alert ) return (__bridge CFStringRef)[alert messageText];
    return nil;
}

void AlertSetMessageText( NSInteger tag, CFStringRef string )
{
    NSAlert *alert = CUI_AlertWithTag( tag, YES );
    if ( alert ) [alert setMessageText:(__bridge NSString *)string];
}

NSImage *AlertIcon( NSInteger tag )
{
    NSAlert *alert = CUI_AlertWithTag( tag, NO );
    if ( alert ) return [alert icon];
    return nil;
}

void AlertSetIcon( NSInteger tag, CFTypeRef inImage )
{
    NSAlert *alert = CUI_AlertWithTag( tag, YES );
    if ( alert ) {
        NSImage *image = CUI_FixImageValue( inImage );
        [alert setIcon:image];
    }
}

void AlertSetIconNamed( NSInteger tag, CFStringRef imageName )
{
    NSAlert *alert = CUI_AlertWithTag( tag, YES );
    if ( alert ) {
        NSImage *image = CUI_ImageResource( (__bridge NSString *)imageName );
        if ( image ) [alert setIcon:image];
    }
}

// Buttons
CFArrayRef AlertButtons( NSInteger tag )
{
    NSAlert *alert = CUI_AlertWithTag( tag, NO );
    if ( alert ) return (__bridge CFArrayRef)[alert buttons];
    return nil;
}

void AlertAddButtonWithTitle( NSInteger tag, CFStringRef title )
{
    NSAlert *alert = CUI_AlertWithTag( tag, YES );
    if ( alert ) [alert addButtonWithTitle:(__bridge NSString *)title];
}

void AlertButtonsSetHidden( NSInteger tag, BOOL flag )
{
    NSAlert *alert = CUI_AlertWithTag( tag, YES );
    if ( alert ) {
        NSArray *btns = [alert buttons];
        for ( NSButton *btn in btns ) {
            [btn setHidden:flag];
        }
    }
}

// Window
NSWindow *AlertWindow( NSInteger tag )
{
    NSAlert *alert = CUI_AlertWithTag( tag, NO );
    if ( alert ) return [alert window];
    return nil;
}

void AlertClose( NSInteger tag )
{
    NSAlert *alert = CUI_AlertWithTag( tag, NO );
    if ( alert ) {
        NSWindow *parentWindow = [[alert window] sheetParent];
        if ( parentWindow ) {
            [parentWindow endSheet:[alert window]];
            [sCUI_Alerts removeObject:alert];
        }
    }
}


NSAlert *AlertInit( NSInteger inTag )
{
    // init
    NSAlert *alert = [[NSAlert alloc] init];

    // delegate
    [alert setDelegate:CUI_AlertDelegateObj()];
    
    // tag
    [alert setTag:inTag];
    
    // add to sheets array
    CUI_AlertAdd( alert );
    
    return alert;
}

// FB statement
NSInteger CUI_Alert( NSInteger inTag, NSInteger inStyle, CFTypeRef inMsg, CFStringRef inInfo, CFTypeRef inButtonTitles, NSInteger inSheetFlag )
{
    NSInteger response = 0;
    
    BOOL createdFlag = NO;
    
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    //NSString *msg = (__bridge NSString *)inMsg;
    id msg = (__bridge id)inMsg;// 20210911
    BOOL errorMsgFlag = NO;
    if ( msg ) {
        if ( [msg isKindOfClass:[NSError class]] ) {
            errorMsgFlag = YES;
       }
    }
    
    NSString *info = (__bridge NSString *)inInfo;
    
    NSAlert *alert = CUI_AlertWithTag( inTag, NO );
    
    if ( alert ) {    // exists
        // style
        if ( inStyle != kFBParamMissing ) [alert setAlertStyle:(NSAlertStyle)inStyle];

        // button titles
        if ( inButtonTitles ) {
            NSArray *titles = nil;
            
            if ( CFGetTypeID(inButtonTitles) == CFStringGetTypeID() ) {
                titles = [(__bridge NSString *)inButtonTitles componentsSeparatedByString:@";"];
            } else if ( CFGetTypeID(inButtonTitles) == CFArrayGetTypeID() ) {
                titles = (__bridge NSArray *)inButtonTitles;
            }
            
            if ( titles ) {
                NSArray *existingTitles = [[alert buttons] valueForKey:@"title"]; // don't duplicate buttons with same title 20250220
                for ( NSString *title in titles ) {
                    if ( ![existingTitles containsObject:title] ) {
                        [alert addButtonWithTitle:title];
                    }
                }
            }
        }
        
        // sheet
        if ( inSheetFlag != kFBParamMissing ) [alert setSheet:(BOOL)inSheetFlag];        
        
    } else {        // create
        
        createdFlag = YES;
        
        // init
        if ( errorMsgFlag ) {
            alert = [NSAlert alertWithError:(NSError *)msg];
            
            // delegate
            [alert setDelegate:CUI_AlertDelegateObj()];
            
            // tag
            [alert setTag:inTag];
            
            // add to sheets array
            CUI_AlertAdd( alert );

        } else {
            //alert = [[NSAlert alloc] init];
            alert = AlertInit( inTag );
            
            // style
            if ( inStyle == kFBParamMissing ) {
                [alert setAlertStyle:NSWarningAlertStyle];
            } else {
                [alert setAlertStyle:(NSAlertStyle)inStyle];
            }
            
            // button titles
            if ( inButtonTitles ) {
                NSArray *titles = nil;
                
                if ( CFGetTypeID(inButtonTitles) == CFStringGetTypeID() ) {
                    titles = [(__bridge NSString *)inButtonTitles componentsSeparatedByString:@";"];
                } else if ( CFGetTypeID(inButtonTitles) == CFArrayGetTypeID() ) {
                    titles = (__bridge NSArray *)inButtonTitles;
                }
                
                if ( titles ) {
                    for ( NSString *title in titles ) {
                        [alert addButtonWithTitle:title];
                    }
                }
            }
        }

        // sheet
        if ( inSheetFlag != kFBParamMissing ) {
            [alert setSheet:(BOOL)inSheetFlag];
        }        
    }
    
    if ( !errorMsgFlag ) {
        // msg
        if ( msg != nil ) [alert setMessageText:msg];
        
        // info
        if ( info != nil ) [alert setInformativeText:info];
    }
    
    // get delegate
    CUI_AlertDelegate *delegate = CUI_AlertDelegateObj();

    if ( show ) {
        // get front window
        NSInteger wndTag = kFBParamMissing;
        NSWindow *window = CUI_TargetWindow( &wndTag );
        
        if ( [alert sheet] && window ) {  // sheet
            [alert beginSheetModalForWindow:window completionHandler:^(NSModalResponse returnCode) {
                [delegate alertDidEnd:alert returnCode:returnCode contextInfo:nil];
                CUI_AlertRemove( alert );
            }];
        } else {
            response = [alert runModal];
            delegate.lastSuppressionButtonState = [[alert suppressionButton] state];
            NSInteger tag = [alert tag];
            CallUserDefinedOnDialogFunction( alertDidEnd, response, tag, (__bridge CFTypeRef)alert );
            CUI_AlertRemove( alert );
        }
        
    } else {    // close
        if ( !createdFlag ) {
            delegate.lastSuppressionButtonState = [[alert suppressionButton] state];
            NSInteger tag = [alert tag];
            [[alert window] close];
            CallUserDefinedOnDialogFunction( alertDidEnd, 0, tag, (__bridge CFTypeRef)alert );
            CUI_AlertRemove( alert );
        }
    }
    
    return response;
}

