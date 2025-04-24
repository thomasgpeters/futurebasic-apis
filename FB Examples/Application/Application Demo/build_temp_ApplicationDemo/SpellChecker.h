/*
 SpellChecker.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "View.h"

typedef void (*CUI_SpellCheckerRequestCheckingCompletionHandlerType)(NSInteger,CFArrayRef,NSOrthography *,NSInteger,void*);
typedef void (*CUI_SpellCheckerShowCorrectionIndicatorCompletionHandlerType)(CFStringRef,void*);
typedef void (*CUI_SpellCheckerRequestCandidatesCompletionHandlerType)(NSInteger,CFArrayRef,void*);

// Class
Class SpellCheckerClass( void );

// Shared spell checker
NSSpellChecker *SpellCheckerShared( void );
BOOL SpellCheckerExists( void );

// Languages
CFArrayRef SpellCheckerAvailableLanguages( void );
CFArrayRef SpellCheckerUserPreferredLanguages( void );
BOOL SpellCheckerAutomaticallyIdentifiesLanguages( void );
void SpellCheckerSetAutomaticallyIdentifiesLanguages( BOOL flag );
CFStringRef SpellCheckerLanguage( void );
void SpellCheckerSetLanguage( CFStringRef language );

// Panels
NSPanel *SpellCheckerSpellingPanel( void );
NSPanel *SpellCheckerSubstitutionsPanel( void );
void SpellCheckerUpdateSpellingPanelWithGrammarString( CFStringRef string, CFDictionaryRef detail );
void SpellCheckerUpdatePanels( void );
NSView *SpellCheckerAccessoryView( void );
NSViewController *SpellCheckerSubsitutionsPanelAccessoryViewController( void );

// Check spelling and grammar
NSInteger SpellCheckerCountWordsInString( CFStringRef string, CFStringRef language );
CFRange SpellCheckerCheckSpellingOfString( CFStringRef string, NSInteger startOffset );
CFRange SpellCheckerCheckSpellingOfStringWithLanguage( CFStringRef string, NSInteger startOffset, CFStringRef language, BOOL wrap, NSInteger spellDocTag, NSInteger *wordCount );
CFRange SpellCheckerCheckGrammarOfString( CFStringRef string, NSInteger startOffset, CFStringRef language, BOOL wrap, NSInteger spellDocTag, CFArrayRef *details );
CFArrayRef SpellCheckerCheckString( CFStringRef string, CFRange range, NSTextCheckingTypes types, CFDictionaryRef options, NSInteger spellDocTag, NSOrthography **orthography, NSInteger *wordCount );

/*
  SpellCheckerRequestCheckingOfString

  completion handler example:
    void local fn MyCompletionHandler( sequenceNumber as NSInteger, results as CFArrayRef, orthography as NSOrthography *, wordCount as NSInteger, userData as ptr )
    // ...
    end fn
*/
NSInteger SpellCheckerRequestCheckingOfString( CFStringRef string, CFRange range, NSTextCheckingTypes types, CFDictionaryRef options, NSInteger spellDocTag, CUI_SpellCheckerRequestCheckingCompletionHandlerType completionHandler, void *userData );
CFArrayRef SpellCheckerGuessesForWordRange( CFRange range, CFStringRef string, CFStringRef language, NSInteger spellDocTag );

// Spell-checking process
NSInteger SpellCheckerUniqueSpellDocumentTag( void );
void SpellCheckerCloseSpellDocument( NSInteger spellDocTag );
void SpellCheckerIgnoreWord( CFStringRef wordToIgnore, NSInteger spellDocTag );
CFArrayRef SpellCheckerIgnoredWords( NSInteger spellDocTag );
void SpellCheckerSetIgnoredWords( CFArrayRef ignoredWords, NSInteger spellDocTag );
void SpellCheckerSetWordFieldStringValue( CFStringRef string );
void SpellCheckerUpdateSpellingPanelWithMisspelledWord( CFStringRef wrd );
CFArrayRef SpellCheckerCompletionsForPartialWordRange( CFRange range, CFStringRef string, CFStringRef language, NSInteger spellDocTag );
BOOL SpellCheckerHasLearnedWord( CFStringRef wrd );
void SpellCheckerUnlearnWord( CFStringRef wrd );
void SpellCheckerLearnWord( CFStringRef wrd );
CFArrayRef SpellCheckerUserQuotesArrayForLanguage( CFStringRef language );
CFDictionaryRef SpellCheckerUserReplacementsDictionary( void );

// Data detector
NSMenu *SpellCheckerMenuForResult( NSTextCheckingResult *result, CFStringRef string, CFDictionaryRef options, CGPoint location, NSInteger vwTag );

// Automatic spell correction
CFStringRef SpellCheckerCorrectionForWordRange( CFRange range, CFStringRef string, CFStringRef language, NSInteger spellDocTag );

/*
  SpellCheckerShowCorrectionIndicator

  completion handler example:
    void local fn MyCompletionHandler( acceptedString as CFStringRef, userData as ptr )
      // ...
    end fn
*/
void SpellCheckerShowCorrectionIndicator( NSCorrectionIndicatorType type, CFStringRef primaryString, CFArrayRef alternativeStrings, CGRect rectOfTypedString, NSInteger vwTag, CUI_SpellCheckerShowCorrectionIndicatorCompletionHandlerType completionHandler, void *userData );
void SpellCheckerRecordResponse( NSCorrectionResponse response, CFStringRef correction, CFStringRef wrd, CFStringRef language, NSInteger spellDocTag );
void SpellCheckerDismissCorrectionIndicator( NSInteger vwTag );

// Type properties
BOOL SpellCheckerIsAutomaticCapitalizationEnabled( void );
BOOL SpellCheckerIsAutomaticDashSubstitutionEnabled( void );
BOOL SpellCheckerIsAutomaticPeriodSubstitutionEnabled( void );
BOOL SpellCheckerIsAutomaticQuoteSubstitutionEnabled( void );
BOOL SpellCheckerIsAutomaticSpellingCorrectionEnabled( void );
BOOL SpellCheckerIsAutomaticTextCompletionEnabled( void );
BOOL SpellCheckerIsAutomaticTextReplacementEnabled( void );

// Instance methods
BOOL SpellCheckerDeletesAutospace( CFStringRef precedingString, CFStringRef followingString, CFStringRef language );

CFStringRef SpellCheckerLanguageForWordRange( CFRange range, CFStringRef string, NSOrthography *orthography );

BOOL SpellCheckerPreventsAutocorrectionBeforeString( CFStringRef string, CFStringRef language );

/*
  SpellCheckerRequestCandidatesForSelectedRange

  completion handler example:
    void local fn MyCompletionHandler( sequenceNumber as NSInteger, CFArrayRef candidates, userData as ptr )
      // ...
    end fn
*/
NSInteger SpellCheckerRequestCandidatesForSelectedRange( CFRange range, CFStringRef string, NSTextCheckingTypes types, CFDictionaryRef options, NSInteger spellDocTag, CUI_SpellCheckerRequestCandidatesCompletionHandlerType completionHandler, void *userData );


/*
  Convenience
*/
CFArrayRef SpellCheckerGuessesForWord( CFStringRef wrd );
CFStringRef SpellCheckerCorrectionForWord( CFStringRef wrd );
