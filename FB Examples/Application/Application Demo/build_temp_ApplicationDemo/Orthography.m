/*
 Orthography.m

 Bernie Wylde
 */

#import "Orthography.h"

// Class
Class OrthographyClass( void )
{ return [NSOrthography class]; }

// - create -
NSOrthography *OrthographyDefaultForLanguage( CFStringRef language )
{ return [NSOrthography defaultOrthographyForLanguage:(__bridge NSString *)language]; }

NSOrthography *OrthographyWithDominantScript( CFStringRef script, CFDictionaryRef map )
{ return [NSOrthography orthographyWithDominantScript:(__bridge NSString *)script languageMap:(__bridge NSDictionary *)map]; }

// - correspondences between languages and scripts -
CFDictionaryRef OrthographyLanguageMap( NSOrthography *ref )
{ return (__bridge CFDictionaryRef)[ref languageMap]; }

CFStringRef OrthographyDominantLanguage( NSOrthography *ref )
{ return (__bridge CFStringRef)[ref dominantLanguage]; }

CFStringRef OrthographyDominantScript( NSOrthography *ref )
{ return (__bridge CFStringRef)[ref dominantScript]; }

CFStringRef OrthographyDominantLanguageForScript( NSOrthography *ref, CFStringRef script )
{ return (__bridge CFStringRef)[ref dominantLanguageForScript:(__bridge NSString *)script]; }

CFArrayRef OrthographyLanguagesForScript( NSOrthography *ref, CFStringRef script )
{ return (__bridge CFArrayRef)[ref languagesForScript:(__bridge NSString *)script]; }

CFArrayRef OrthographyAllScripts( NSOrthography *ref )
{ return (__bridge CFArrayRef)[ref allScripts]; }

CFArrayRef OrthographyAllLanguages( NSOrthography *ref )
{ return (__bridge CFArrayRef)[ref allLanguages]; }

