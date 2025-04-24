/*
 PDFPanel.m

 Bernie Wylde
 */

#import "PDFPanel.h"

// Class
Class PDFPanelClass( void )
{ return [NSPDFPanel class]; }

// - create -
NSPDFPanel *PDFPanelInit( void )
{ return [NSPDFPanel panel]; }

// - contents -
// accessoryController
NSPDFPanelOptions PDFPanelOptions( NSPDFPanel *ref )
{ return [ref options]; }

void PDFPanelSetOptions( NSPDFPanel *ref, NSPDFPanelOptions options )
{ [ref setOptions:options]; }

CFStringRef PDFPanelDefaultFileName( NSPDFPanel *ref )
{ return (__bridge CFStringRef)[ref defaultFileName]; }

void PDFPanelSetDefaultFileName( NSPDFPanel *ref, CFStringRef fileName )
{ [ref setDefaultFileName:(__bridge NSString *)fileName]; }

// - display -
void PDFPanelBeginSheet( NSPDFPanel *ref, NSPDFInfo *info, NSInteger wndTag, CUI_PDFPanelCallbackType callback, void *userData )
{
    NSWindow *window = WindowWithTag( wndTag );
    if ( window ) {
        [ref beginSheetWithPDFInfo:info modalForWindow:window completionHandler:^(NSInteger returnCode) {
            if ( callback ) (*callback)(info,returnCode,userData);
        }];
    }
}

