/*
 PrintInfo.m

 Bernie Wylde
 */

#import "PrintInfo.h"

// Class
Class PrintInfoClass( void )
{ return [NSPrintInfo class]; }

NSPrintInfo *PrintInfoInit( void )
{
#if __has_feature(objc_arc)
    return [[NSPrintInfo alloc] init];
#else
    return [[[NSPrintInfo alloc] init] autorelease];
#endif
}

NSPrintInfo *PrintInfoWithDictionary( CFDictionaryRef dict )
{
#if __has_feature(objc_arc)
    return [[NSPrintInfo alloc] initWithDictionary:(__bridge NSDictionary *)dict];
#else
    return [[[NSPrintInfo alloc] initWithDictionary:(__bridge NSDictionary *)dict] autorelease];
#endif
}

NSPrintInfo *PrintInfoShared( void )
{ return [NSPrintInfo sharedPrintInfo]; }

CGFloat PrintInfoLeftMargin( NSPrintInfo *ref )
{ return [ref leftMargin]; }

void PrintInfoSetLeftMargin( NSPrintInfo *ref, CGFloat value )
{ [ref setLeftMargin:value]; }

CGFloat PrintInfoTopMargin( NSPrintInfo *ref )
{ return [ref topMargin]; }

void PrintInfoSetTopMargin( NSPrintInfo *ref, CGFloat value )
{ [ref setTopMargin:value]; }

CGFloat PrintInfoRightMargin( NSPrintInfo *ref )
{ return [ref rightMargin]; }

void PrintInfoSetRightMargin( NSPrintInfo *ref, CGFloat value )
{ [ref setRightMargin:value]; }

CGFloat PrintInfoBottomMargin( NSPrintInfo *ref )
{ return [ref bottomMargin]; }

void PrintInfoSetBottomMargin( NSPrintInfo *ref, CGFloat value )
{ [ref setBottomMargin:value]; }

CGRect PrintInfoImageablePageBounds( NSPrintInfo *ref )
{ return NSRectToCGRect([ref imageablePageBounds]); }

NSInteger PrintInfoOrientation( NSPrintInfo *ref )
{ return [ref orientation]; }

void PrintInfoSetOrientation( NSPrintInfo *ref, NSInteger orientation )
{ [ref setOrientation:orientation]; }

CFStringRef PrintInfoPaperName( NSPrintInfo *ref )
{ return (__bridge CFStringRef)[ref paperName]; }

void PrintInfoSetPaperName( NSPrintInfo *ref, CFStringRef string )
{ [ref setPaperName:(__bridge NSString *)string]; }

CFStringRef PrintInfoLocalizedPaperName( NSPrintInfo *ref )
{ return (__bridge CFStringRef)[ref localizedPaperName]; }

CGSize PrintInfoPaperSize( NSPrintInfo *ref )
{ return NSSizeToCGSize([ref paperSize]); }

void PrintInfoSetPaperSize( NSPrintInfo *ref, CGSize size )
{ [ref setPaperSize:NSSizeFromCGSize(size)]; }

NSPrintingPaginationMode PrintInfoHorizontalPagination( NSPrintInfo *ref )
{ return [ref horizontalPagination]; }

void PrintInfoSetHorizontalPagination( NSPrintInfo *ref, NSPrintingPaginationMode value )
{ [ref setHorizontalPagination:value]; }

NSPrintingPaginationMode PrintInfoVerticalPagination( NSPrintInfo *ref )
{ return [ref verticalPagination]; }

void PrintInfoSetVerticalPagination( NSPrintInfo *ref, NSPrintingPaginationMode value )
{ [ref setVerticalPagination:value]; }

BOOL PrintInfoIsHorizontallyCentered( NSPrintInfo *ref )
{ return [ref isHorizontallyCentered]; }

void PrintInfoSetHorizontallyCentered( NSPrintInfo *ref, BOOL flag )
{ [ref setHorizontallyCentered:flag]; }

BOOL PrintInfoIsVerticallyCentered( NSPrintInfo *ref )
{ return [ref isVerticallyCentered]; }

void PrintInfoSetVerticallyCentered( NSPrintInfo *ref, BOOL flag )
{ [ref setVerticallyCentered:flag]; }

NSPrinter *PrintInfoPrinter( NSPrintInfo *ref )
{ return [ref printer]; }

void PrintInfoSetPrinter( NSPrintInfo *ref, NSPrinter *printer )
{ [ref setPrinter:printer]; }

CFStringRef PrintInfoJobDisposition( NSPrintInfo *ref )
{ return (__bridge CFStringRef)[ref jobDisposition]; }

void PrintInfoSetJobDisposition( NSPrintInfo *ref, CFStringRef value )
{ [ref setJobDisposition:(__bridge NSString *)value]; }

void PrintInfoSetUpPrintOperationDefaultValues( NSPrintInfo *ref )
{ [ref setUpPrintOperationDefaultValues]; }

CFMutableDictionaryRef PrintInfoDictionary( NSPrintInfo *ref )
{ return (__bridge CFMutableDictionaryRef)[ref dictionary]; }

BOOL PrintInfoIsSelectionOnly( NSPrintInfo *ref )
{ return [ref isSelectionOnly]; }

void PrintInfoSetSelectionOnly( NSPrintInfo *ref, BOOL flag )
{ [ref setSelectionOnly:flag]; }

CGFloat PrintInfoScalingFactor( NSPrintInfo *ref )
{ return [ref scalingFactor]; }

void PrintInfoSetScalingFactor( NSPrintInfo *ref, CGFloat value )
{ [ref setScalingFactor:value]; }

CFMutableDictionaryRef PrintInfoPrintSettings( NSPrintInfo *ref )
{ return (__bridge CFMutableDictionaryRef)[ref printSettings]; }

PMPrintSession PrintInfoPMPrintSession( NSPrintInfo *ref )
{ return [ref PMPrintSession]; }

PMPageFormat PrintInfoPMPageFormat( NSPrintInfo *ref )
{ return [ref PMPageFormat]; }

PMPrintSettings PrintInfoPMPrintSettings( NSPrintInfo *ref )
{ return [ref PMPrintSettings]; }

void PrintInfoUpdateFromPMPageFormat( NSPrintInfo *ref )
{ [ref updateFromPMPageFormat]; }

void PrintInfoUpdateFromPMPrintSettings( NSPrintInfo *ref )
{ [ref updateFromPMPrintSettings]; }

void PrintInfoTakeSettingsFromPDFInfo( NSPrintInfo *ref, NSPDFInfo *info )
{ [ref takeSettingsFromPDFInfo:info]; }

// Deprecated
NSPrinter *PrintInfoDefaultPrinter( void )
{ return [NSPrintInfo defaultPrinter]; }

