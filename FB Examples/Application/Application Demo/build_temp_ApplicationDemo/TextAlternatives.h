/*
 TextAlternatives.h

 Bernie Wylde
 */

#import "CocoaUI.h"

// Init
NSTextAlternatives *TextAlternativesWithPrimaryString( CFStringRef primaryString, CFArrayRef alternativeStrings );

// Store
CFStringRef TextAlternativesPrimaryString( NSTextAlternatives *ref );
CFArrayRef TextAlternativesAlternativeStrings( NSTextAlternatives *ref );

// Select
void TextAlternativesNoteSelectedAlternativeString( NSTextAlternatives *ref, CFStringRef string );
