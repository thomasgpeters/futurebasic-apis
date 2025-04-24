/*
 Morphology.m

 Bernie Wylde
 */

#import "Morphology.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000

#pragma mark - Morphology

// User morphology
NSMorphology *MorphologyUser( void )
{ return [NSMorphology userMorphology]; }

// Grammatical properties
BOOL MorphologyIsUnspecified( NSMorphology *ref )
{ return [ref isUnspecified]; }

NSGrammaticalGender MorphologyGrammaticalGender( NSMorphology *ref )
{ return [ref grammaticalGender]; }

void MorphologySetGrammaticalGender( NSMorphology *ref, NSGrammaticalGender gender )
{ [ref setGrammaticalGender:gender]; }

NSGrammaticalNumber MorphologyNumber( NSMorphology *ref )
{ return [ref number]; }

void MorphologySetNumber( NSMorphology *ref, NSGrammaticalNumber number )
{ [ref setNumber:number]; }

NSGrammaticalPartOfSpeech MorphologyPartOfSpeech( NSMorphology *ref )
{ return [ref partOfSpeech]; }

void MorphologySetPartOfSpeech( NSMorphology *ref, NSGrammaticalPartOfSpeech partOfSpeech )
{ [ref setPartOfSpeech:partOfSpeech]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
NSGrammaticalCase MorphologyGrammaticalCase( NSMorphology *ref )
{ return [ref grammaticalCase]; }

void MorphologySetGrammaticalCase( NSMorphology *ref, NSGrammaticalCase grCase )
{ [ref setGrammaticalCase:grCase]; }

NSGrammaticalDetermination MorphologyDetermination( NSMorphology *ref )
{ return [ref determination]; }

void MorphologySetDetermination( NSMorphology *ref, NSGrammaticalDetermination determination )
{ [ref setDetermination:determination]; }

NSGrammaticalPerson MorphologyGrammaticalPerson( NSMorphology *ref )
{ return [ref grammaticalPerson]; }

void MorphologySetGrammaticalPerson( NSMorphology *ref, NSGrammaticalPerson person )
{ [ref setGrammaticalPerson:person]; }

NSGrammaticalPronounType MorphologyPronounType( NSMorphology *ref )
{ return [ref pronounType]; }

void MorphologySetPronounType( NSMorphology *ref, NSGrammaticalPronounType type )
{ [ref setPronounType:type]; }

NSGrammaticalDefiniteness MorphologyDefiniteness( NSMorphology *ref )
{ return [ref definiteness]; }

void MorphologySetDefiniteness( NSMorphology *ref, NSGrammaticalDefiniteness definiteness )
{ [ref setDefiniteness:definiteness]; }
#endif// 140000

// Per-language features
BOOL MorphologySetCustomPronoun( NSMorphology *ref, NSMorphologyCustomPronoun *pronoun, CFStringRef language, NSError **err )
{ return [ref setCustomPronoun:pronoun forLanguage:(__bridge NSString *)language error:err]; }

NSMorphologyCustomPronoun *MorphologyCustomPronoun( NSMorphology *ref, CFStringRef language )
{ return [ref customPronounForLanguage:(__bridge NSString *)language]; }


#pragma mark - MorphologyCustomPronoun

// Support
BOOL MorphologyCustomPronounIsSupportedForLanguage( CFStringRef language )
{ return [NSMorphologyCustomPronoun isSupportedForLanguage:(__bridge NSString *)language]; }

CFArrayRef MorphologyCustomPronounRequiredKeysForLanguage( CFStringRef language )
{ return (__bridge CFArrayRef)[NSMorphologyCustomPronoun requiredKeysForLanguage:(__bridge NSString *)language]; }

// Forms
CFStringRef MorphologyCustomPronounSubjectForm( NSMorphologyCustomPronoun *ref )
{ return (__bridge CFStringRef)[ref subjectForm]; }

void MorphologyCustomPronounSetSubjectForm( NSMorphologyCustomPronoun *ref, CFStringRef form )
{ [ref setSubjectForm:(__bridge NSString *)form]; }

CFStringRef MorphologyCustomPronounObjectForm( NSMorphologyCustomPronoun *ref )
{ return (__bridge CFStringRef)[ref objectForm]; }

void MorphologyCustomPronounSetObjectForm( NSMorphologyCustomPronoun *ref, CFStringRef form )
{ [ref setObjectForm:(__bridge NSString *)form]; }

CFStringRef MorphologyCustomPronounPossessiveForm( NSMorphologyCustomPronoun *ref )
{ return (__bridge CFStringRef)[ref possessiveForm]; }

void MorphologyCustomPronounSetPossessiveForm( NSMorphologyCustomPronoun *ref, CFStringRef form )
{ [ref setPossessiveForm:(__bridge NSString *)form]; }

CFStringRef MorphologyCustomPronounPossessiveAdjectiveForm( NSMorphologyCustomPronoun *ref )
{ return (__bridge CFStringRef)[ref possessiveAdjectiveForm]; }

void MorphologyCustomPronounSetPossessiveAdjectiveForm( NSMorphologyCustomPronoun *ref, CFStringRef form )
{ [ref setPossessiveAdjectiveForm:(__bridge NSString *)form]; }

CFStringRef MorphologyCustomPronounReflexiveForm( NSMorphologyCustomPronoun *ref )
{ return (__bridge CFStringRef)[ref reflexiveForm]; }

void MorphologyCustomPronounSetReflexiveForm( NSMorphologyCustomPronoun *ref, CFStringRef form )
{ [ref setReflexiveForm:(__bridge NSString *)form]; }


#pragma mark - MorphologyPronoun
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
NSMorphologyPronoun *MorphologyPronounWithPronoun( CFStringRef pronoun, NSMorphology *morphology, NSMorphology *dependentMorphology )
{
#if __has_feature(objc_arc)
    return [[NSMorphologyPronoun alloc] initWithPronoun:(__bridge NSString *)pronoun morphology:morphology dependentMorphology:dependentMorphology];
#else
    return [[[NSMorphologyPronoun alloc] initWithPronoun:(__bridge NSString *)pronoun morphology:morphology dependentMorphology:dependentMorphology] autorelease];
#endif
}

// Info
CFStringRef MorphologyPronounPronoun( NSMorphologyPronoun *ref )
{ return (__bridge CFStringRef)[ref pronoun]; }

NSMorphology *MorphologyPronounMorphology( NSMorphologyPronoun *ref )
{ return [ref morphology]; }

NSMorphology *MorphologyPronounDependentMorphology( NSMorphologyPronoun *ref )
{ return [ref dependentMorphology]; }
#endif// 140000


#endif// 120000
