/*
 PrintInfo.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class PrintInfoClass( void );

// Init
NSPrintInfo *PrintInfoInit( void );
NSPrintInfo *PrintInfoWithDictionary( CFDictionaryRef dict );

// Share print info
NSPrintInfo *PrintInfoShared( void );

// Printing rectangle
CGFloat PrintInfoLeftMargin( NSPrintInfo *ref );
void PrintInfoSetLeftMargin( NSPrintInfo *ref, CGFloat value );
CGFloat PrintInfoTopMargin( NSPrintInfo *ref );
void PrintInfoSetTopMargin( NSPrintInfo *ref, CGFloat value );
CGFloat PrintInfoRightMargin( NSPrintInfo *ref );
void PrintInfoSetRightMargin( NSPrintInfo *ref, CGFloat value );
CGFloat PrintInfoBottomMargin( NSPrintInfo *ref );
void PrintInfoSetBottomMargin( NSPrintInfo *ref, CGFloat value );
CGRect PrintInfoImageablePageBounds( NSPrintInfo *ref );
NSInteger PrintInfoOrientation( NSPrintInfo *ref );
void PrintInfoSetOrientation( NSPrintInfo *ref, NSInteger orientation );
CFStringRef PrintInfoPaperName( NSPrintInfo *ref );
void PrintInfoSetPaperName( NSPrintInfo *ref, CFStringRef string );
CFStringRef PrintInfoLocalizedPaperName( NSPrintInfo *ref );
CGSize PrintInfoPaperSize( NSPrintInfo *ref );
void PrintInfoSetPaperSize( NSPrintInfo *ref, CGSize size );

// Pagination
NSPrintingPaginationMode PrintInfoHorizontalPagination( NSPrintInfo *ref );
void PrintInfoSetHorizontalPagination( NSPrintInfo *ref, NSPrintingPaginationMode value );
NSPrintingPaginationMode PrintInfoVerticalPagination( NSPrintInfo *ref );
void PrintInfoSetVerticalPagination( NSPrintInfo *ref, NSPrintingPaginationMode value );

// Position
BOOL PrintInfoIsHorizontallyCentered( NSPrintInfo *ref );
void PrintInfoSetHorizontallyCentered( NSPrintInfo *ref, BOOL flag );
BOOL PrintInfoIsVerticallyCentered( NSPrintInfo *ref );
void PrintInfoSetVerticallyCentered( NSPrintInfo *ref, BOOL flag );

// Printer
NSPrinter *PrintInfoPrinter( NSPrintInfo *ref );
void PrintInfoSetPrinter( NSPrintInfo *ref, NSPrinter *printer );

// Controlling printing
CFStringRef PrintInfoJobDisposition( NSPrintInfo *ref );
void PrintInfoSetJobDisposition( NSPrintInfo *ref, CFStringRef value );
void PrintInfoSetUpPrintOperationDefaultValues( NSPrintInfo *ref );

// Dictionary
CFMutableDictionaryRef PrintInfoDictionary( NSPrintInfo *ref );

// Print settings convenience methods
BOOL PrintInfoIsSelectionOnly( NSPrintInfo *ref );
void PrintInfoSetSelectionOnly( NSPrintInfo *ref, BOOL flag );
CGFloat PrintInfoScalingFactor( NSPrintInfo *ref );
void PrintInfoSetScalingFactor( NSPrintInfo *ref, CGFloat value );

// Core printing info
CFMutableDictionaryRef PrintInfoPrintSettings( NSPrintInfo *ref );
PMPrintSession PrintInfoPMPrintSession( NSPrintInfo *ref );
PMPageFormat PrintInfoPMPageFormat( NSPrintInfo *ref );
PMPrintSettings PrintInfoPMPrintSettings( NSPrintInfo *ref );
void PrintInfoUpdateFromPMPageFormat( NSPrintInfo *ref );
void PrintInfoUpdateFromPMPrintSettings( NSPrintInfo *ref );
void PrintInfoTakeSettingsFromPDFInfo( NSPrintInfo *ref, NSPDFInfo *info );

// Deprecated
NSPrinter *PrintInfoDefaultPrinter( void );

