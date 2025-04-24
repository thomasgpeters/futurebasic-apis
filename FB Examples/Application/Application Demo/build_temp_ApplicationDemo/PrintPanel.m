/*
 PrintPanel.m

 Bernie Wylde
 */

#import "PrintPanel.h"

static CUI_PrintPanelDelegate *sCUI_PrintPanelDelegate;

@implementation CUI_PrintPanelDelegate

- (void)printPanelDidEnd:(NSPrintPanel *)printPanel returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo {
    if ( self.callback ) (*self.callback)(printPanel,returnCode,contextInfo);
}
@end

// Class
Class PrintPanelClass( void )
{ return [NSPrintPanel class]; }

NSPrintPanel *PrintPanelInit( void )
{ return [NSPrintPanel printPanel]; }

CFStringRef PrintPanelJobStyleHint( NSPrintPanel *ref )
{ return (__bridge CFStringRef)[ref jobStyleHint]; }

void PrintPanelSetJobStyleHint( NSPrintPanel *ref, CFStringRef hint )
{ [ref setJobStyleHint:(__bridge NSString *)hint]; }

NSPrintPanelOptions PrintPanelOptions( NSPrintPanel *ref )
{ return [ref options]; }

void PrintPanelSetOptions( NSPrintPanel *ref, NSPrintPanelOptions options )
{ [ref setOptions:options]; }

CFStringRef PrintPanelDefaultButtonTitle( NSPrintPanel *ref )
{ return (__bridge CFStringRef)[ref defaultButtonTitle]; }

void PrintPanelSetDefaultButtonTitle( NSPrintPanel *ref, CFStringRef string )
{ [ref setDefaultButtonTitle:(__bridge NSString *)string]; }

CFStringRef PrintPanelHelpAnchor( NSPrintPanel *ref )
{ return (__bridge CFStringRef)[ref helpAnchor]; }

void PrintPanelSetHelpAnchor( NSPrintPanel *ref, CFStringRef string )
{ [ref setHelpAnchor:(__bridge NSString *)string]; }

void PrintPanelBeginSheet( NSPrintPanel *ref, NSPrintInfo *printInfo, NSInteger wndTag, CUI_PrintPanelDelegateCallbackType callback, void *userData )
{
    NSWindow *window = WindowWithTag( wndTag );
    if ( window ) {
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
        if (@available(macOS 14.0, *)) {
            [ref beginSheetUsingPrintInfo:printInfo onWindow:window completionHandler:^(NSPrintPanelResult result) {
                if ( callback ) (*callback)(ref,result,userData);
            }];
        } else {
            if ( !sCUI_PrintPanelDelegate ) sCUI_PrintPanelDelegate = [[CUI_PrintPanelDelegate alloc] init];
            sCUI_PrintPanelDelegate.callback = callback;
            
            [ref beginSheetWithPrintInfo:printInfo modalForWindow:window delegate:sCUI_PrintPanelDelegate didEndSelector:@selector(printPanelDidEnd:returnCode:contextInfo:) contextInfo:userData];
        }
#else// 140000
        if ( !sCUI_PrintPanelDelegate ) sCUI_PrintPanelDelegate = [[CUI_PrintPanelDelegate alloc] init];
        sCUI_PrintPanelDelegate.callback = callback;
        
        [ref beginSheetWithPrintInfo:printInfo modalForWindow:window delegate:sCUI_PrintPanelDelegate didEndSelector:@selector(printPanelDidEnd:returnCode:contextInfo:) contextInfo:userData];
#endif// 140000
    }
}

NSInteger PrintPanelRunModal( NSPrintPanel *ref )
{ return [ref runModal]; }

NSInteger PrintPanelRunModalWithPrintInfo( NSPrintPanel *ref, NSPrintInfo *printInfo )
{ return [ref runModalWithPrintInfo:printInfo]; }

NSPrintInfo *PrintPanelPrintInfo( NSPrintPanel *ref )
{ return [ref printInfo]; }

