/*
 Printer.m

 Bernie Wylde
 */

#import "Printer.h"

// Class
Class PrinterClass( void )
{ return [NSPrinter class]; }

// - create -
NSPrinter *PrinterWithName( CFStringRef name )
{ return [NSPrinter printerWithName:(__bridge NSString *)name]; }

NSPrinter *PrinterWithType( CFStringRef type )
{ return [NSPrinter printerWithType:(__bridge NSString *)type]; }

// - printer info -
CFArrayRef PrinterNames( void )
{ return (__bridge CFArrayRef)[NSPrinter printerNames]; }

CFArrayRef PrinterTypes( void )
{ return (__bridge CFArrayRef)[NSPrinter printerTypes]; }

// - attributes -
CFStringRef PrinterName( NSPrinter *ref )
{ return (__bridge CFStringRef)[ref name]; }

CFStringRef PrinterType( NSPrinter *ref )
{ return (__bridge CFStringRef)[ref type]; }

// - specific info -
CGSize PrinterPageSizeForPaper( NSPrinter *ref, CFStringRef paperName )
{ return NSSizeToCGSize([ref pageSizeForPaper:(__bridge NSString *)paperName]); }

NSInteger PrinterLanguageLevel( NSPrinter *ref )
{ return [ref languageLevel]; }

// - query tables -
CFDictionaryRef PrinterDeviceDescription( NSPrinter *ref )
{ return (__bridge CFDictionaryRef)[ref deviceDescription]; }

