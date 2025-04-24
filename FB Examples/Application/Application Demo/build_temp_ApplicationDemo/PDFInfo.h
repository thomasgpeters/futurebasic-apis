/*
 PDFInfo.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class PDFInfoClass( void );

// - init -
NSPDFInfo *PDFInfoInit( void );

// - methods -
CFURLRef PDFInfoURL( NSPDFInfo *ref );
void PDFInfoSetURL( NSPDFInfo *ref, CFURLRef url );
BOOL PDFInfoIsFileExtensionHidden( NSPDFInfo *ref );
void PDFInfoSetFileExtensionHidden( NSPDFInfo *ref, BOOL flag );
CFArrayRef PDFInfoTagNames( NSPDFInfo *ref );
void PDFInfoSetTagNames( NSPDFInfo *ref, CFArrayRef names );
NSPaperOrientation PDFInfoOrientation( NSPDFInfo *ref );
void PDFInfoSetOrientation( NSPDFInfo *ref, NSPaperOrientation orientation );
CGSize PDFInfoPaperSize( NSPDFInfo *ref );
void PDFInfoSetPaperSize( NSPDFInfo *ref, CGSize size );
CFMutableDictionaryRef PDFInfoAttributes( NSPDFInfo *ref );

