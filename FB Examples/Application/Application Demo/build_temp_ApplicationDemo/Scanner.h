/*
 Scanner.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class ScannerClass( void );

// - create -
NSScanner *ScannerWithString( CFStringRef string );
NSScanner *ScannerLocalizedWithString( CFStringRef string );

// - get a scanner's string -
CFStringRef ScannerString( NSScanner *ref );

// - configure -
NSUInteger ScannerLocation( NSScanner *ref );
void ScannerSetLocation( NSScanner *ref, NSUInteger location );
BOOL ScannerCaseSensitive( NSScanner *ref );
void ScannerSetCaseSensitive( NSScanner *ref, BOOL flag );
CFCharacterSetRef ScannerCharactersToBeSkipped( NSScanner *ref );
void ScannerSetCharactersToBeSkipped( NSScanner *ref, CFCharacterSetRef set );
CFLocaleRef ScannerLocale( NSScanner *ref );
void ScannerSetLocale( NSScanner *ref, CFLocaleRef locale );

// - scanning a string -
BOOL ScannerScanCharactersFromSet( NSScanner *ref, CFCharacterSetRef set, CFStringRef *result );
BOOL ScannerScanUpToCharactersFromSet( NSScanner *ref, CFCharacterSetRef set, CFStringRef *result );
BOOL ScannerScanDecimal( NSScanner *ref, NSDecimal *result );
BOOL ScannerScanDouble( NSScanner *ref, double *result );
BOOL ScannerScanFloat( NSScanner *ref, float *result );
BOOL ScannerScanHexDouble( NSScanner *ref, double *result );
BOOL ScannerScanHexFloat( NSScanner *ref, float *result );
BOOL ScannerScanHexInt( NSScanner *ref, unsigned int *result );
BOOL ScannerScanHexLongLong( NSScanner *ref, UInt64 *result );
BOOL ScannerScanInteger( NSScanner *ref, NSInteger *result );
//BOOL ScannerScanInt( NSScanner *ref, long *result );
BOOL ScannerScanLongLong( NSScanner *ref, long long *result );
BOOL ScannerScanString( NSScanner *ref, CFStringRef string, CFStringRef *result );
//BOOL ScannerScanUnsignedLongLong( NSScanner *ref, UInt64 *result );
BOOL ScannerScanUpToString( NSScanner *ref, CFStringRef string, CFStringRef *result );
BOOL ScannerIsAtEnd( NSScanner *ref );

