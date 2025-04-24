/*
 TextAlternatives.m

 Bernie Wylde
 */

#import "TextAlternatives.h"

// Init
NSTextAlternatives *TextAlternativesWithPrimaryString( CFStringRef primaryString, CFArrayRef alternativeStrings )
{
#if __has_feature(objc_arc)
    return [[NSTextAlternatives alloc] initWithPrimaryString:(__bridge NSString *)primaryString alternativeStrings:(__bridge NSArray *)alternativeStrings];
#else
    return [[[NSTextAlternatives alloc] initWithPrimaryString:(__bridge NSString *)primaryString alternativeStrings:(__bridge NSArray *)alternativeStrings] autorelease];
#endif
}

// Store
CFStringRef TextAlternativesPrimaryString( NSTextAlternatives *ref )
{ return (__bridge CFStringRef)[ref primaryString]; }

CFArrayRef TextAlternativesAlternativeStrings( NSTextAlternatives *ref )
{ return (__bridge CFArrayRef)[ref alternativeStrings]; }

// Select
void TextAlternativesNoteSelectedAlternativeString( NSTextAlternatives *ref, CFStringRef string )
{ [ref noteSelectedAlternativeString:(__bridge NSString *)string]; }
