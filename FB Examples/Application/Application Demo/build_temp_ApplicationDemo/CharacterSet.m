/*
 CharacterSet.m

 Bernie Wylde
 */

#import "CharacterSet.h"

// Class
Class CharacterSetClass( void )
{ return [NSCharacterSet class]; }

// Standard sets
CFCharacterSetRef CharacterSetAlphanumericSet( void )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet alphanumericCharacterSet]; }

CFCharacterSetRef CharacterSetCapitalizedLetterSet( void )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet capitalizedLetterCharacterSet]; }

CFCharacterSetRef CharacterSetControlSet( void )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet controlCharacterSet]; }

CFCharacterSetRef CharacterSetDecimalDigitSet( void )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet decimalDigitCharacterSet]; }

CFCharacterSetRef CharacterSetDecomposableSet( void )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet decomposableCharacterSet]; }

CFCharacterSetRef CharacterSetIllegalSet( void )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet illegalCharacterSet]; }

CFCharacterSetRef CharacterSetLetterSet( void )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet letterCharacterSet]; }

CFCharacterSetRef CharacterSetLowercaseLetterSet( void )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet lowercaseLetterCharacterSet]; }

CFCharacterSetRef CharacterSetNewlineSet( void )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet newlineCharacterSet]; }

CFCharacterSetRef CharacterSetNonBaseSet( void )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet nonBaseCharacterSet]; }

CFCharacterSetRef CharacterSetPunctuationSet( void )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet punctuationCharacterSet]; }

CFCharacterSetRef CharacterSetSymbolSet( void )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet symbolCharacterSet]; }

CFCharacterSetRef CharacterSetUppercaseLetterSet( void )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet uppercaseLetterCharacterSet]; }

CFCharacterSetRef CharacterSetWhitespaceAndNewlineSet( void )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet whitespaceAndNewlineCharacterSet]; }

CFCharacterSetRef CharacterSetWhitespaceSet( void )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet whitespaceCharacterSet]; }

// URL encoding
CFCharacterSetRef CharacterSetURLFragmentAllowedSet( void )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet URLFragmentAllowedCharacterSet]; }

CFCharacterSetRef CharacterSetURLHostAllowedSet( void )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet URLHostAllowedCharacterSet]; }

CFCharacterSetRef CharacterSetURLPasswordAllowedSet( void )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet URLPasswordAllowedCharacterSet]; }

CFCharacterSetRef CharacterSetURLPathAllowedSet( void )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet URLPathAllowedCharacterSet]; }

CFCharacterSetRef CharacterSetURLQueryAllowedSet( void )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet URLQueryAllowedCharacterSet]; }

CFCharacterSetRef CharacterSetURLUserAllowedSet( void )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet URLUserAllowedCharacterSet]; }

// Custom sets
CFCharacterSetRef CharacterSetWithCoder( NSCoder *coder )
{
#if __has_feature(objc_arc)
    return (__bridge CFCharacterSetRef)[[NSCharacterSet alloc] initWithCoder:coder];
#else
    return (__bridge CFCharacterSetRef)[[[NSCharacterSet alloc] initWithCoder:coder] autorelease];
#endif
}

CFCharacterSetRef CharacterSetWithCharactersInString( CFStringRef string )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet characterSetWithCharactersInString:(__bridge NSString *)string]; }

CFCharacterSetRef CharacterSetWithRange( CFRange range )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet characterSetWithRange:NSRangeFromCFRange(range)]; }

// Bitmap representations
CFCharacterSetRef CharacterSetWithBitmapRepresentation( CFDataRef data )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet characterSetWithBitmapRepresentation:(__bridge NSData *)data]; }

CFCharacterSetRef CharacterSetWithContentsOfURL( CFURLRef url )
{ return (__bridge CFCharacterSetRef)[NSCharacterSet characterSetWithContentsOfFile:[(__bridge NSURL *)url path]]; }

CFDataRef CharacterSetBitmapRepresentation( CFCharacterSetRef ref )
{ return (__bridge CFDataRef)[(__bridge NSCharacterSet *)ref bitmapRepresentation]; }

// Inverting
CFCharacterSetRef CharacterSetInvertedSet( CFCharacterSetRef set )
{ return (__bridge CFCharacterSetRef)[(__bridge NSCharacterSet *)set invertedSet]; }

// - testing membership -
BOOL CharacterSetCharacterIsMember( CFCharacterSetRef set, unichar chr )
{ return [(__bridge NSCharacterSet *)set characterIsMember:chr]; }

BOOL CharacterSetHasMemberInPlane( CFCharacterSetRef set, UInt8 plane )
{ return [(__bridge NSCharacterSet *)set hasMemberInPlane:plane]; }

BOOL CharacterSetIsSupersetOfSet( CFCharacterSetRef set, CFCharacterSetRef otherSet )
{ return [(__bridge NSCharacterSet *)set isSupersetOfSet:(__bridge NSCharacterSet *)otherSet]; }

BOOL CharacterSetLongCharacterIsMember( CFCharacterSetRef set, UInt32 longChar )
{ return [(__bridge NSCharacterSet *)set longCharacterIsMember:longChar]; }


#pragma mark - MutabeCharacterSet
// Class
Class MutableCharacterSetClass( void )
{ return [NSMutableCharacterSet class]; }

// Create
CFMutableCharacterSetRef MutableCharacterSetInit( void )
{
#if __has_feature(objc_arc)
    return (__bridge CFMutableCharacterSetRef)[[NSMutableCharacterSet alloc] init];
#else
    return (__bridge CFMutableCharacterSetRef)[[[NSMutableCharacterSet alloc] init] autorelease];
#endif
}

CFMutableCharacterSetRef MutableCharacterSetNew( void )
{
#if __has_feature(objc_arc)
    return (__bridge CFMutableCharacterSetRef)[NSMutableCharacterSet new];
#else
    return (__bridge CFMutableCharacterSetRef)[[NSMutableCharacterSet new] autorelease];
#endif
}

// Standard sets
CFMutableCharacterSetRef MutableCharacterSetAlphanumericSet( void )
{ return (__bridge CFMutableCharacterSetRef)[NSMutableCharacterSet alphanumericCharacterSet]; }

CFMutableCharacterSetRef MutableCharacterSetCapitalizedLetterSet( void )
{ return (__bridge CFMutableCharacterSetRef)[NSMutableCharacterSet capitalizedLetterCharacterSet]; }

CFMutableCharacterSetRef MutableCharacterSetControlSet( void )
{ return (__bridge CFMutableCharacterSetRef)[NSMutableCharacterSet controlCharacterSet]; }

CFMutableCharacterSetRef MutableCharacterSetDecimalDigitSet( void )
{ return (__bridge CFMutableCharacterSetRef)[NSMutableCharacterSet decimalDigitCharacterSet]; }

CFMutableCharacterSetRef MutableCharacterSetDecomposableSet( void )
{ return (__bridge CFMutableCharacterSetRef)[NSMutableCharacterSet decomposableCharacterSet]; }

CFMutableCharacterSetRef MutableCharacterSetIllegalSet( void )
{ return (__bridge CFMutableCharacterSetRef)[NSMutableCharacterSet illegalCharacterSet]; }

CFMutableCharacterSetRef MutableCharacterSetLetterSet( void )
{ return (__bridge CFMutableCharacterSetRef)[NSMutableCharacterSet letterCharacterSet]; }

CFMutableCharacterSetRef MutableCharacterSetLowercaseLetterSet( void )
{ return (__bridge CFMutableCharacterSetRef)[NSMutableCharacterSet lowercaseLetterCharacterSet]; }

CFMutableCharacterSetRef MutableCharacterSetNewlineSet( void )
{ return (__bridge CFMutableCharacterSetRef)[NSMutableCharacterSet newlineCharacterSet]; }

CFMutableCharacterSetRef MutableCharacterSetNonBaseSet( void )
{ return (__bridge CFMutableCharacterSetRef)[NSMutableCharacterSet nonBaseCharacterSet]; }

CFMutableCharacterSetRef MutableCharacterSetPunctuationSet( void )
{ return (__bridge CFMutableCharacterSetRef)[NSMutableCharacterSet punctuationCharacterSet]; }

CFMutableCharacterSetRef MutableCharacterSetSymbolSet( void )
{ return (__bridge CFMutableCharacterSetRef)[NSMutableCharacterSet symbolCharacterSet]; }

CFMutableCharacterSetRef MutableCharacterSetUppercaseLetterSet( void )
{ return (__bridge CFMutableCharacterSetRef)[NSMutableCharacterSet uppercaseLetterCharacterSet]; }

CFMutableCharacterSetRef MutableCharacterSetWhitespaceAndNewlineSet( void )
{ return (__bridge CFMutableCharacterSetRef)[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]; }

CFMutableCharacterSetRef MutableCharacterSetWhitespaceSet( void )
{ return (__bridge CFMutableCharacterSetRef)[NSMutableCharacterSet whitespaceCharacterSet]; }

// Custom sets
CFMutableCharacterSetRef MutableCharacterSetWithCharactersInString( CFStringRef string )
{ return (__bridge CFMutableCharacterSetRef)[NSMutableCharacterSet characterSetWithCharactersInString:(__bridge NSString *)string]; }

CFMutableCharacterSetRef MutableCharacterSetWithRange( CFRange range )
{ return (__bridge CFMutableCharacterSetRef)[NSMutableCharacterSet characterSetWithRange:NSRangeFromCFRange(range)]; }

CFMutableCharacterSetRef MutableCharacterSetWithBitmapRepresentation( CFDataRef dta )
{ return (__bridge CFMutableCharacterSetRef)[NSMutableCharacterSet characterSetWithBitmapRepresentation:(__bridge NSData *)dta]; }

CFMutableCharacterSetRef MutableCharacterSetWithContentsOfURL( CFURLRef url )
{ return (__bridge CFMutableCharacterSetRef)[NSMutableCharacterSet characterSetWithContentsOfFile:[(__bridge NSURL *)url path]]; }

// Adding and removing characters
void MutableCharacterSetAddCharactersInRange( CFMutableCharacterSetRef set, CFRange range )
{ [(__bridge NSMutableCharacterSet *)set addCharactersInRange:NSRangeFromCFRange(range)]; }

void MutableCharacterSetRemoveCharactersInRange( CFMutableCharacterSetRef set, CFRange range )
{ [(__bridge NSMutableCharacterSet *)set removeCharactersInRange:NSRangeFromCFRange(range)]; }

void MutableCharacterSetAddCharactersInString( CFMutableCharacterSetRef set, CFStringRef string )
{ [(__bridge NSMutableCharacterSet *)set addCharactersInString:(__bridge NSString *)string]; }

void MutableCharacterSetRemoveCharactersInString( CFMutableCharacterSetRef set, CFStringRef string )
{ [(__bridge NSMutableCharacterSet *)set removeCharactersInString:(__bridge NSString *)string]; }

// Combining sets
void MutableCharacterSetFormIntersectionWithCharacterSet( CFMutableCharacterSetRef set, CFCharacterSetRef otherSet )
{ [(__bridge NSMutableCharacterSet *)set formIntersectionWithCharacterSet:(__bridge NSCharacterSet *)otherSet]; }

void MutableCharacterSetFormUnionWithCharacterSet( CFMutableCharacterSetRef set, CFCharacterSetRef otherSet )
{ [(__bridge NSMutableCharacterSet *)set formUnionWithCharacterSet:(__bridge NSCharacterSet *)otherSet]; }

// Inverting
void MutableCharacterSetInvert( CFMutableCharacterSetRef set )
{ [(__bridge NSMutableCharacterSet *)set invert]; }

