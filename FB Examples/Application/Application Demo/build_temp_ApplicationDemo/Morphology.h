/*
 Morphology.h

 Bernie Wylde
 */

#import "CocoaUI.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000

#pragma mark - Morphology

// User morphology
API_AVAILABLE(macos(12.0))
NSMorphology *MorphologyUser( void );

// Grammatical properties
API_AVAILABLE(macos(12.0))
BOOL MorphologyIsUnspecified( NSMorphology *ref );
API_AVAILABLE(macos(12.0))
NSGrammaticalGender MorphologyGrammaticalGender( NSMorphology *ref );
API_AVAILABLE(macos(12.0))
void MorphologySetGrammaticalGender( NSMorphology *ref, NSGrammaticalGender gender );
API_AVAILABLE(macos(12.0))
NSGrammaticalNumber MorphologyNumber( NSMorphology *ref );
API_AVAILABLE(macos(12.0))
void MorphologySetNumber( NSMorphology *ref, NSGrammaticalNumber number );
API_AVAILABLE(macos(12.0))
NSGrammaticalPartOfSpeech MorphologyPartOfSpeech( NSMorphology *ref );
API_AVAILABLE(macos(12.0))
void MorphologySetPartOfSpeech( NSMorphology *ref, NSGrammaticalPartOfSpeech partOfSpeech );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
NSGrammaticalCase MorphologyGrammaticalCase( NSMorphology *ref );
API_AVAILABLE(macos(14.0))
void MorphologySetGrammaticalCase( NSMorphology *ref, NSGrammaticalCase grCase );
API_AVAILABLE(macos(14.0))
NSGrammaticalDetermination MorphologyDetermination( NSMorphology *ref );
API_AVAILABLE(macos(14.0))
void MorphologySetDetermination( NSMorphology *ref, NSGrammaticalDetermination determination );
API_AVAILABLE(macos(14.0))
NSGrammaticalPerson MorphologyGrammaticalPerson( NSMorphology *ref );
API_AVAILABLE(macos(14.0))
void MorphologySetGrammaticalPerson( NSMorphology *ref, NSGrammaticalPerson person );
API_AVAILABLE(macos(14.0))
NSGrammaticalPronounType MorphologyPronounType( NSMorphology *ref );
API_AVAILABLE(macos(14.0))
void MorphologySetPronounType( NSMorphology *ref, NSGrammaticalPronounType type );
API_AVAILABLE(macos(14.0))
NSGrammaticalDefiniteness MorphologyDefiniteness( NSMorphology *ref );
API_AVAILABLE(macos(14.0))
void MorphologySetDefiniteness( NSMorphology *ref, NSGrammaticalDefiniteness definiteness );
#endif// 140000

// Per-language features
API_AVAILABLE(macos(12.0))
BOOL MorphologySetCustomPronoun( NSMorphology *ref, NSMorphologyCustomPronoun *pronoun, CFStringRef language, NSError **err );
API_AVAILABLE(macos(12.0))
NSMorphologyCustomPronoun *MorphologyCustomPronoun( NSMorphology *ref, CFStringRef language );


#pragma mark - MorphologyCustomPronoun

// Support
API_AVAILABLE(macos(12.0))
BOOL MorphologyCustomPronounIsSupportedForLanguage( CFStringRef language );
API_AVAILABLE(macos(12.0))
CFArrayRef MorphologyCustomPronounRequiredKeysForLanguage( CFStringRef language );

// Forms
API_AVAILABLE(macos(12.0))
CFStringRef MorphologyCustomPronounSubjectForm( NSMorphologyCustomPronoun *ref );
API_AVAILABLE(macos(12.0))
void MorphologyCustomPronounSetSubjectForm( NSMorphologyCustomPronoun *ref, CFStringRef form );
API_AVAILABLE(macos(12.0))
CFStringRef MorphologyCustomPronounObjectForm( NSMorphologyCustomPronoun *ref );
API_AVAILABLE(macos(12.0))
void MorphologyCustomPronounSetObjectForm( NSMorphologyCustomPronoun *ref, CFStringRef form );
API_AVAILABLE(macos(12.0))
CFStringRef MorphologyCustomPronounPossessiveForm( NSMorphologyCustomPronoun *ref );
API_AVAILABLE(macos(12.0))
void MorphologyCustomPronounSetPossessiveForm( NSMorphologyCustomPronoun *ref, CFStringRef form );
API_AVAILABLE(macos(12.0))
CFStringRef MorphologyCustomPronounPossessiveAdjectiveForm( NSMorphologyCustomPronoun *ref );
API_AVAILABLE(macos(12.0))
void MorphologyCustomPronounSetPossessiveAdjectiveForm( NSMorphologyCustomPronoun *ref, CFStringRef form );
API_AVAILABLE(macos(12.0))
CFStringRef MorphologyCustomPronounReflexiveForm( NSMorphologyCustomPronoun *ref );
API_AVAILABLE(macos(12.0))
void MorphologyCustomPronounSetReflexiveForm( NSMorphologyCustomPronoun *ref, CFStringRef form );

#pragma mark - MorphologyPronoun
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000

API_AVAILABLE(macos(14.0))
NSMorphologyPronoun *MorphologyPronounWithPronoun( CFStringRef pronoun, NSMorphology *morphology, NSMorphology *dependentMorphology );

// Info
API_AVAILABLE(macos(14.0))
CFStringRef MorphologyPronounPronoun( NSMorphologyPronoun *ref );
API_AVAILABLE(macos(14.0))
NSMorphology *MorphologyPronounMorphology( NSMorphologyPronoun *ref );
API_AVAILABLE(macos(14.0))
NSMorphology *MorphologyPronounDependentMorphology( NSMorphologyPronoun *ref );

#endif// 140000


#endif// 120000

