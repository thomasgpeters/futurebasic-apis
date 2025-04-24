/*
 PDFPanel.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef void (*CUI_PDFPanelCallbackType)(NSPDFInfo *,NSInteger,void*);

// Class
Class PDFPanelClass( void );

// - create -
NSPDFPanel *PDFPanelInit( void );

// - contents -
// accessoryController
NSPDFPanelOptions PDFPanelOptions( NSPDFPanel *ref );
void PDFPanelSetOptions( NSPDFPanel *ref, NSPDFPanelOptions options );
CFStringRef PDFPanelDefaultFileName( NSPDFPanel *ref );
void PDFPanelSetDefaultFileName( NSPDFPanel *ref, CFStringRef fileName );

// - display -
void PDFPanelBeginSheet( NSPDFPanel *ref, NSPDFInfo *info, NSInteger wndTag, CUI_PDFPanelCallbackType callback, void *userData );

