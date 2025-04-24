/*
 Printer.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class PrinterClass( void );

// - create -
NSPrinter *PrinterWithName( CFStringRef name );
NSPrinter *PrinterWithType( CFStringRef type );

// - printer info -
CFArrayRef PrinterNames( void );
CFArrayRef PrinterTypes( void );

// - attributes -
CFStringRef PrinterName( NSPrinter *ref );
CFStringRef PrinterType( NSPrinter *ref );

// - specific info -
CGSize PrinterPageSizeForPaper( NSPrinter *ref, CFStringRef paperName );
NSInteger PrinterLanguageLevel( NSPrinter *ref );

// - query tables -
CFDictionaryRef PrinterDeviceDescription( NSPrinter *ref );

