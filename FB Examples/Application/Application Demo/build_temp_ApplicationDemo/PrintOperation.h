/*
 PrintOperation.h

 Bernie Wylde
 */



//#import "DialogEvent.h"
//#import "View.h"
//#import "Window.h"

#pragma mark - dialog events
enum {
    printOperationDidRun = 5200
};

#pragma mark - delegate
typedef void (*CUI_PrintOperationDelegateCallbackType)(NSPrintOperation *,BOOL,void*);// printOperation,success,userData

@interface CUI_PrintOperationDelegate : NSObject
@property (nonatomic,assign) CUI_PrintOperationDelegateCallbackType callback;
@end

#pragma mark - functions
// Class
Class PrintOperationClass( void );

NSPrintOperation *PrintOperationEPSWithViewToData( NSInteger viewTag, CGRect rect, CFMutableDataRef data );
NSPrintOperation *PrintOperationEPSWithViewToDataPrintInfo( NSInteger viewTag, CGRect rect, CFMutableDataRef data, NSPrintInfo *printInfo );
NSPrintOperation *PrintOperationEPSWithViewToPath( NSInteger viewTag, CGRect rect, CFStringRef path, NSPrintInfo *printInfo );
NSPrintOperation *PrintOperationPDFWithViewToData( NSInteger viewTag, CGRect rect, CFMutableDataRef data );
NSPrintOperation *PrintOperationPDFWithViewToDataPrintInfo( NSInteger viewTag, CGRect rect, CFMutableDataRef data, NSPrintInfo *printInfo );
NSPrintOperation *PrintOperationPDFWithViewToPath( NSInteger viewTag, CGRect rect, CFStringRef path, NSPrintInfo *printInfo );
NSPrintOperation *PrintOperationWithView( NSInteger viewTag );
NSPrintOperation *PrintOperationWithViewPrintInfo( NSInteger viewTag, NSPrintInfo *printInfo );
NSPrintOperation *PrintOperationCurrent( void );
BOOL PrintOperationIsCopying( NSPrintOperation *ref );
NSPrintInfo *PrintOperationPrintInfo( NSPrintOperation *ref );
void PrintOperationSetPrintInfo( NSPrintOperation *ref, NSPrintInfo *printInfo );
NSInteger PrintOperationView( NSPrintOperation *ref );
NSPrintRenderingQuality PrintOperationPreferredRenderingQuality( NSPrintOperation *ref );
BOOL PrintOperationRun( NSPrintOperation *ref );

void PrintOperationRunModal( NSPrintOperation *ref, NSInteger wndTag, CUI_PrintOperationDelegateCallbackType callback, void *contextInfo );

BOOL PrintOperationDeliverResult( NSPrintOperation *ref );
BOOL PrintOperationShowsPrintPanel( NSPrintOperation *ref );
void PrintOperationSetShowsPrintPanel( NSPrintOperation *ref, BOOL flag );
BOOL PrintOperationShowsProgressPanel( NSPrintOperation *ref );
void PrintOperationSetShowsProgressPanel( NSPrintOperation *ref, BOOL flag );
CFStringRef PrintOperationJobTitle( NSPrintOperation *ref );
void PrintOperationSetJobTitle( NSPrintOperation *ref, CFStringRef title );
NSPrintPanel *PrintOperationPrintPanel( NSPrintOperation *ref );
void PrintOperationSetPrintPanel( NSPrintOperation *ref, NSPrintPanel *printPanel );
NSGraphicsContext *PrintOperationContext( NSPrintOperation *ref );
NSGraphicsContext *PrintOperationCreateContext( NSPrintOperation *ref );
NSInteger PrintOperationCurrentPage( NSPrintOperation *ref );
CFRange PrintOperationPageRange( NSPrintOperation *ref );
NSPrintingPageOrder PrintOperationPageOrder( NSPrintOperation *ref );
void PrintOperationSetPageOrder( NSPrintOperation *ref, NSPrintingPageOrder pageOrder );
BOOL PrintOperationCanSpawnSeparateThread( NSPrintOperation *ref );
void PrintOperationSetCanSpawnSeparateThread( NSPrintOperation *ref, BOOL flag );

