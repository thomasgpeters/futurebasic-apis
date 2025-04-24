/*
 PDFInfo.m

 Bernie Wylde
 */

#import "PDFInfo.h"

// Class
Class PDFInfoClass( void )
{ return [NSPDFInfo class]; }

// - init -
NSPDFInfo *PDFInfoInit( void )
{
#if __has_feature(objc_arc)
    return [[NSPDFInfo alloc] init];
#else
    return [[[NSPDFInfo alloc] init] autorelease];
#endif
}

// - methods -
CFURLRef PDFInfoURL( NSPDFInfo *ref )
{ return (__bridge CFURLRef)[ref URL]; }

void PDFInfoSetURL( NSPDFInfo *ref, CFURLRef url )
{ [ref setURL:(__bridge NSURL *)url]; }

BOOL PDFInfoIsFileExtensionHidden( NSPDFInfo *ref )
{ return [ref isFileExtensionHidden]; }

void PDFInfoSetFileExtensionHidden( NSPDFInfo *ref, BOOL flag )
{ [ref setFileExtensionHidden:flag]; }

CFArrayRef PDFInfoTagNames( NSPDFInfo *ref )
{ return (__bridge CFArrayRef)[ref tagNames]; }

void PDFInfoSetTagNames( NSPDFInfo *ref, CFArrayRef names )
{ [ref setTagNames:(__bridge NSArray *)names]; }

NSPaperOrientation PDFInfoOrientation( NSPDFInfo *ref )
{ return [ref orientation]; }

void PDFInfoSetOrientation( NSPDFInfo *ref, NSPaperOrientation orientation )
{ [ref setOrientation:orientation]; }

CGSize PDFInfoPaperSize( NSPDFInfo *ref )
{ return NSSizeToCGSize([ref paperSize]); }

void PDFInfoSetPaperSize( NSPDFInfo *ref, CGSize size )
{ [ref setPaperSize:NSSizeFromCGSize(size)]; }

CFMutableDictionaryRef PDFInfoAttributes( NSPDFInfo *ref )
{ return (__bridge CFMutableDictionaryRef)[ref attributes]; }

