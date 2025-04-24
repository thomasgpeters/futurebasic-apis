/*
 CharacterSet.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class CharacterSetClass( void );

// Standard sets
CFCharacterSetRef CharacterSetAlphanumericSet( void );
CFCharacterSetRef CharacterSetCapitalizedLetterSet( void );
CFCharacterSetRef CharacterSetControlSet( void );
CFCharacterSetRef CharacterSetDecimalDigitSet( void );
CFCharacterSetRef CharacterSetDecomposableSet( void );
CFCharacterSetRef CharacterSetIllegalSet( void );
CFCharacterSetRef CharacterSetLetterSet( void );
CFCharacterSetRef CharacterSetLowercaseLetterSet( void );
CFCharacterSetRef CharacterSetNewlineSet( void );
CFCharacterSetRef CharacterSetNonBaseSet( void );
CFCharacterSetRef CharacterSetPunctuationSet( void );
CFCharacterSetRef CharacterSetSymbolSet( void );
CFCharacterSetRef CharacterSetUppercaseLetterSet( void );
CFCharacterSetRef CharacterSetWhitespaceAndNewlineSet( void );
CFCharacterSetRef CharacterSetWhitespaceSet( void );

// URL encoding
CFCharacterSetRef CharacterSetURLFragmentAllowedSet( void );
CFCharacterSetRef CharacterSetURLHostAllowedSet( void );
CFCharacterSetRef CharacterSetURLPasswordAllowedSet( void );
CFCharacterSetRef CharacterSetURLPathAllowedSet( void );
CFCharacterSetRef CharacterSetURLQueryAllowedSet( void );
CFCharacterSetRef CharacterSetURLUserAllowedSet( void );

// Custom sets
CFCharacterSetRef CharacterSetWithCoder( NSCoder *coder );
CFCharacterSetRef CharacterSetWithCharactersInString( CFStringRef string );
CFCharacterSetRef CharacterSetWithRange( CFRange range );

// Bitmap representations
CFCharacterSetRef CharacterSetWithBitmapRepresentation( CFDataRef data );
CFCharacterSetRef CharacterSetWithContentsOfURL( CFURLRef url );
CFDataRef CharacterSetBitmapRepresentation( CFCharacterSetRef ref );

// Inverting
CFCharacterSetRef CharacterSetInvertedSet( CFCharacterSetRef set );

// - testing membership -
BOOL CharacterSetCharacterIsMember( CFCharacterSetRef set, unichar chr );
BOOL CharacterSetHasMemberInPlane( CFCharacterSetRef set, UInt8 plane );
BOOL CharacterSetIsSupersetOfSet( CFCharacterSetRef set, CFCharacterSetRef otherSet );
BOOL CharacterSetLongCharacterIsMember( CFCharacterSetRef set, UInt32 longChar );


#pragma mark - MutabeCharacterSet
// Class
Class MutableCharacterSetClass( void );

// Create
CFMutableCharacterSetRef MutableCharacterSetInit( void );
CFMutableCharacterSetRef MutableCharacterSetNew( void );

// Standard sets
CFMutableCharacterSetRef MutableCharacterSetAlphanumericSet( void );
CFMutableCharacterSetRef MutableCharacterSetCapitalizedLetterSet( void );
CFMutableCharacterSetRef MutableCharacterSetControlSet( void );
CFMutableCharacterSetRef MutableCharacterSetDecimalDigitSet( void );
CFMutableCharacterSetRef MutableCharacterSetDecomposableSet( void );
CFMutableCharacterSetRef MutableCharacterSetIllegalSet( void );
CFMutableCharacterSetRef MutableCharacterSetLetterSet( void );
CFMutableCharacterSetRef MutableCharacterSetLowercaseLetterSet( void );
CFMutableCharacterSetRef MutableCharacterSetNewlineSet( void );
CFMutableCharacterSetRef MutableCharacterSetNonBaseSet( void );
CFMutableCharacterSetRef MutableCharacterSetPunctuationSet( void );
CFMutableCharacterSetRef MutableCharacterSetSymbolSet( void );
CFMutableCharacterSetRef MutableCharacterSetUppercaseLetterSet( void );
CFMutableCharacterSetRef MutableCharacterSetWhitespaceAndNewlineSet( void );
CFMutableCharacterSetRef MutableCharacterSetWhitespaceSet( void );

// Custom sets
CFMutableCharacterSetRef MutableCharacterSetWithCharactersInString( CFStringRef string );
CFMutableCharacterSetRef MutableCharacterSetWithRange( CFRange range );
CFMutableCharacterSetRef MutableCharacterSetWithBitmapRepresentation( CFDataRef dta );
CFMutableCharacterSetRef MutableCharacterSetWithContentsOfURL( CFURLRef url );

// Adding and removing characters
void MutableCharacterSetAddCharactersInRange( CFMutableCharacterSetRef set, CFRange range );
void MutableCharacterSetRemoveCharactersInRange( CFMutableCharacterSetRef set, CFRange range );
void MutableCharacterSetAddCharactersInString( CFMutableCharacterSetRef set, CFStringRef string );
void MutableCharacterSetRemoveCharactersInString( CFMutableCharacterSetRef set, CFStringRef string );

// Combining sets
void MutableCharacterSetFormIntersectionWithCharacterSet( CFMutableCharacterSetRef set, CFCharacterSetRef otherSet );
void MutableCharacterSetFormUnionWithCharacterSet( CFMutableCharacterSetRef set, CFCharacterSetRef otherSet );

// Inverting
void MutableCharacterSetInvert( CFMutableCharacterSetRef set );
