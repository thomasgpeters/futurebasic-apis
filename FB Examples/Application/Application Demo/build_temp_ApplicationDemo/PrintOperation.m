/*
 PrintOperation.m

 Bernie Wylde
 */

#import "PrintOperation.h"

static CUI_PrintOperationDelegate *sCUI_PrintOperationDelegate;

@implementation CUI_PrintOperationDelegate

- (void)printOperationDidRun:(NSPrintOperation *)printOperation success:(BOOL)success contextInfo:(void *)contextInfo {
    if ( self.callback ) {
        (*self.callback)(printOperation,success,contextInfo);
    } else {
        DialogEventSetBool(success);
        DialogEventSetContext(contextInfo);
        CallUserDefinedOnDialogFunction( printOperationDidRun, 0, 0, (__bridge CFTypeRef)printOperation );
    }
}
@end

// Class
Class PrintOperationClass( void )
{ return [NSPrintOperation class]; }

NSPrintOperation *PrintOperationEPSWithViewToData( NSInteger viewTag, CGRect rect, CFMutableDataRef data )
{
    NSView *view = ViewWithTag( viewTag );
    if ( view ) return [NSPrintOperation EPSOperationWithView:view insideRect:NSRectFromCGRect(rect) toData:(__bridge NSMutableData *)data];
    return nil;
}

NSPrintOperation *PrintOperationEPSWithViewToDataPrintInfo( NSInteger viewTag, CGRect rect, CFMutableDataRef data, NSPrintInfo *printInfo )
{
    NSView *view = ViewWithTag( viewTag );
    if ( view ) return [NSPrintOperation EPSOperationWithView:view insideRect:NSRectFromCGRect(rect) toData:(__bridge NSMutableData *)data printInfo:printInfo];
    return nil;
}

NSPrintOperation *PrintOperationEPSWithViewToPath( NSInteger viewTag, CGRect rect, CFStringRef path, NSPrintInfo *printInfo )
{
    NSView *view = ViewWithTag( viewTag );
    if ( view ) return [NSPrintOperation EPSOperationWithView:view insideRect:NSRectFromCGRect(rect) toPath:(__bridge NSString *)path printInfo:printInfo];
    return nil;
}

NSPrintOperation *PrintOperationPDFWithViewToData( NSInteger viewTag, CGRect rect, CFMutableDataRef data )
{
    NSView *view = ViewWithTag( viewTag );
    if ( view ) return [NSPrintOperation PDFOperationWithView:view insideRect:NSRectFromCGRect(rect) toData:(__bridge NSMutableData *)data];
    return nil;
}

NSPrintOperation *PrintOperationPDFWithViewToDataPrintInfo( NSInteger viewTag, CGRect rect, CFMutableDataRef data, NSPrintInfo *printInfo )
{
    NSView *view = ViewWithTag( viewTag );
    if ( view ) return [NSPrintOperation PDFOperationWithView:view insideRect:NSRectFromCGRect(rect) toData:(__bridge NSMutableData *)data printInfo:printInfo];
    return nil;
}

NSPrintOperation *PrintOperationPDFWithViewToPath( NSInteger viewTag, CGRect rect, CFStringRef path, NSPrintInfo *printInfo )
{
    NSView *view = ViewWithTag( viewTag );
    if ( view ) return [NSPrintOperation PDFOperationWithView:view insideRect:NSRectFromCGRect(rect) toPath:(__bridge NSString *)path printInfo:printInfo];
    return nil;
}

NSPrintOperation *PrintOperationWithView( NSInteger viewTag )
{
    NSView *view = ViewWithTag( viewTag );
    if ( view ) return [NSPrintOperation printOperationWithView:view];
    return nil;
}

NSPrintOperation *PrintOperationWithViewPrintInfo( NSInteger viewTag, NSPrintInfo *printInfo )
{
    NSView *view = ViewWithTag( viewTag );
    if ( view ) return [NSPrintOperation printOperationWithView:view printInfo:printInfo];
    return nil;
}

NSPrintOperation *PrintOperationCurrent( void )
{ return [NSPrintOperation currentOperation]; }

BOOL PrintOperationIsCopying( NSPrintOperation *ref )
{ return [ref isCopyingOperation]; }

NSPrintInfo *PrintOperationPrintInfo( NSPrintOperation *ref )
{ return [ref printInfo]; }

void PrintOperationSetPrintInfo( NSPrintOperation *ref, NSPrintInfo *printInfo )
{ [ref setPrintInfo:printInfo]; }

NSInteger PrintOperationView( NSPrintOperation *ref )
{
    NSView *view = [ref view];
    if ( view ) return [view tag];
    return 0;
}

NSPrintRenderingQuality PrintOperationPreferredRenderingQuality( NSPrintOperation *ref )
{ return [ref preferredRenderingQuality]; }

BOOL PrintOperationRun( NSPrintOperation *ref )
{ return [ref runOperation]; }

void PrintOperationRunModal( NSPrintOperation *ref, NSInteger wndTag, CUI_PrintOperationDelegateCallbackType callback, void *contextInfo )
{
    NSWindow *window = WindowWithTag( wndTag );
    if ( window ) {
        if ( !sCUI_PrintOperationDelegate ) sCUI_PrintOperationDelegate = [[CUI_PrintOperationDelegate alloc] init];
        sCUI_PrintOperationDelegate.callback = callback;
        [ref runOperationModalForWindow:window delegate:sCUI_PrintOperationDelegate didRunSelector:@selector(printOperationDidRun:success:contextInfo:) contextInfo:contextInfo];
    }
}

BOOL PrintOperationDeliverResult( NSPrintOperation *ref )
{ return [ref deliverResult]; }

BOOL PrintOperationShowsPrintPanel( NSPrintOperation *ref )
{ return [ref showsPrintPanel]; }

void PrintOperationSetShowsPrintPanel( NSPrintOperation *ref, BOOL flag )
{ [ref setShowsPrintPanel:flag]; }

BOOL PrintOperationShowsProgressPanel( NSPrintOperation *ref )
{ return [ref showsProgressPanel]; }

void PrintOperationSetShowsProgressPanel( NSPrintOperation *ref, BOOL flag )
{ [ref setShowsProgressPanel:flag]; }

CFStringRef PrintOperationJobTitle( NSPrintOperation *ref )
{ return (__bridge CFStringRef)[ref jobTitle]; }

void PrintOperationSetJobTitle( NSPrintOperation *ref, CFStringRef title )
{ [ref setJobTitle:(__bridge NSString *)title]; }

NSPrintPanel *PrintOperationPrintPanel( NSPrintOperation *ref )
{ return [ref printPanel]; }

void PrintOperationSetPrintPanel( NSPrintOperation *ref, NSPrintPanel *printPanel )
{ [ref setPrintPanel:printPanel]; }

NSGraphicsContext *PrintOperationContext( NSPrintOperation *ref )
{ return [ref context]; }

NSGraphicsContext *PrintOperationCreateContext( NSPrintOperation *ref )
{ return [ref createContext]; }

NSInteger PrintOperationCurrentPage( NSPrintOperation *ref )
{ return [ref currentPage]; }

CFRange PrintOperationPageRange( NSPrintOperation *ref )
{
    NSRange range = [ref pageRange];
    return NSRangeToCFRange(range);
}

NSPrintingPageOrder PrintOperationPageOrder( NSPrintOperation *ref )
{ return [ref pageOrder]; }

void PrintOperationSetPageOrder( NSPrintOperation *ref, NSPrintingPageOrder pageOrder )
{ [ref setPageOrder:pageOrder]; }

BOOL PrintOperationCanSpawnSeparateThread( NSPrintOperation *ref )
{ return [ref canSpawnSeparateThread]; }

void PrintOperationSetCanSpawnSeparateThread( NSPrintOperation *ref, BOOL flag )
{ [ref setCanSpawnSeparateThread:flag]; }

