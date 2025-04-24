/*
 Orthography.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class OrthographyClass( void );

// - create -
NSOrthography *OrthographyDefaultForLanguage( CFStringRef language );
NSOrthography *OrthographyWithDominantScript( CFStringRef script, CFDictionaryRef map );

// - correspondences between languages and scripts -
CFDictionaryRef OrthographyLanguageMap( NSOrthography *ref );
CFStringRef OrthographyDominantLanguage( NSOrthography *ref );
CFStringRef OrthographyDominantScript( NSOrthography *ref );
CFStringRef OrthographyDominantLanguageForScript( NSOrthography *ref, CFStringRef script );
CFArrayRef OrthographyLanguagesForScript( NSOrthography *ref, CFStringRef script );
CFArrayRef OrthographyAllScripts( NSOrthography *ref );
CFArrayRef OrthographyAllLanguages( NSOrthography *ref );

