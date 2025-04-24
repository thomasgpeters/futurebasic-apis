/*
 Scanner.m

 Bernie Wylde
 */

#import "Scanner.h"

// Class
Class ScannerClass( void )
{ return [NSScanner class]; }

// - create -
NSScanner *ScannerWithString( CFStringRef string )
{ return [NSScanner scannerWithString:(__bridge NSString *)string]; }

NSScanner *ScannerLocalizedWithString( CFStringRef string )
{ return [NSScanner localizedScannerWithString:(__bridge NSString *)string]; }

// - get a scanner's string -
CFStringRef ScannerString( NSScanner *ref )
{ return (__bridge CFStringRef)[ref string]; }

// - configure -
NSUInteger ScannerLocation( NSScanner *ref )
{ return [ref scanLocation]; }

void ScannerSetLocation( NSScanner *ref, NSUInteger location )
{ [ref setScanLocation:location]; }

BOOL ScannerCaseSensitive( NSScanner *ref )
{ return [ref caseSensitive]; }

void ScannerSetCaseSensitive( NSScanner *ref, BOOL flag )
{ [ref setCaseSensitive:flag]; }

CFCharacterSetRef ScannerCharactersToBeSkipped( NSScanner *ref )
{ return (__bridge CFCharacterSetRef)[ref charactersToBeSkipped]; }

void ScannerSetCharactersToBeSkipped( NSScanner *ref, CFCharacterSetRef set )
{ [ref setCharactersToBeSkipped:(__bridge NSCharacterSet *)set]; }

CFLocaleRef ScannerLocale( NSScanner *ref )
{ return (__bridge CFLocaleRef)[ref locale]; }

void ScannerSetLocale( NSScanner *ref, CFLocaleRef locale )
{ [ref setLocale:(__bridge NSLocale *)locale]; }

// - scanning a string -
BOOL ScannerScanCharactersFromSet( NSScanner *ref, CFCharacterSetRef set, CFStringRef *result )
{
    NSString *temp = nil;
    BOOL flag = [ref scanCharactersFromSet:(__bridge NSCharacterSet *)set intoString:&temp];
    if ( result ) *result = (__bridge CFStringRef)temp;
    return flag;
}

BOOL ScannerScanUpToCharactersFromSet( NSScanner *ref, CFCharacterSetRef set, CFStringRef *result )
{
    NSString *temp = nil;
    BOOL flag = [ref scanUpToCharactersFromSet:(__bridge NSCharacterSet *)set intoString:&temp];
    if ( result ) *result = (__bridge CFStringRef)temp;
    return flag;
}

BOOL ScannerScanDecimal( NSScanner *ref, NSDecimal *result )
{ return [ref scanDecimal:result]; }

BOOL ScannerScanDouble( NSScanner *ref, double *result )
{ return [ref scanDouble:result]; }

BOOL ScannerScanFloat( NSScanner *ref, float *result )
{ return [ref scanFloat:result]; }

BOOL ScannerScanHexDouble( NSScanner *ref, double *result )
{ return [ref scanHexDouble:result]; }

BOOL ScannerScanHexFloat( NSScanner *ref, float *result )
{ return [ref scanHexFloat:result]; }

BOOL ScannerScanHexInt( NSScanner *ref, unsigned int *result )
{ return [ref scanHexInt:result]; }

BOOL ScannerScanHexLongLong( NSScanner *ref, UInt64 *result )
{ return [ref scanHexLongLong:result]; }

BOOL ScannerScanInteger( NSScanner *ref, NSInteger *result )
{ return [ref scanInteger:result]; }

//BOOL ScannerScanInt( NSScanner *ref, long *result )
//{ return [ref scanInt:result]; }

BOOL ScannerScanLongLong( NSScanner *ref, long long *result )
{ return [ref scanLongLong:result]; }

BOOL ScannerScanString( NSScanner *ref, CFStringRef string, CFStringRef *result )
{
    NSString *temp = nil;
    BOOL flag = [ref scanString:(__bridge NSString *)string intoString:&temp];
    if ( result ) *result = (__bridge CFStringRef)temp;
    return flag;
}

//BOOL ScannerScanUnsignedLongLong( NSScanner *ref, UInt64 *result )
//{ return [ref scanUnsignedLongLong:result]; }

BOOL ScannerScanUpToString( NSScanner *ref, CFStringRef string, CFStringRef *result )
{
    NSString *temp = nil;
    BOOL flag = [ref scanUpToString:(__bridge NSString *)string intoString:&temp];
    if ( result ) *result = (__bridge CFStringRef)temp;
    return flag;
}

BOOL ScannerIsAtEnd( NSScanner *ref )
{ return [ref isAtEnd]; }

