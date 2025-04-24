/*
 SpellChecker.m

 Bernie Wylde
 */

#import "SpellChecker.h"

// Class
Class SpellCheckerClass( void )
{ return [NSSpellChecker class]; }

// Shared spell checker
NSSpellChecker *SpellCheckerShared( void )
{ return [NSSpellChecker sharedSpellChecker]; }

BOOL SpellCheckerExists( void )
{ return [NSSpellChecker sharedSpellCheckerExists]; }

// Languages
CFArrayRef SpellCheckerAvailableLanguages( void )
{ return (__bridge CFArrayRef)[[NSSpellChecker sharedSpellChecker] availableLanguages]; }

CFArrayRef SpellCheckerUserPreferredLanguages( void )
{ return (__bridge CFArrayRef)[[NSSpellChecker sharedSpellChecker] userPreferredLanguages]; }

BOOL SpellCheckerAutomaticallyIdentifiesLanguages( void )
{ return [[NSSpellChecker sharedSpellChecker] automaticallyIdentifiesLanguages]; }

void SpellCheckerSetAutomaticallyIdentifiesLanguages( BOOL flag )
{ [[NSSpellChecker sharedSpellChecker] setAutomaticallyIdentifiesLanguages:flag]; }

CFStringRef SpellCheckerLanguage( void )
{ return (__bridge CFStringRef)[[NSSpellChecker sharedSpellChecker] language]; }

void SpellCheckerSetLanguage( CFStringRef language )
{ [[NSSpellChecker sharedSpellChecker] setLanguage:(__bridge NSString *)language]; }

// Panels
NSPanel *SpellCheckerSpellingPanel( void )
{ return [[NSSpellChecker sharedSpellChecker] spellingPanel]; }

NSPanel *SpellCheckerSubstitutionsPanel( void )
{ return [[NSSpellChecker sharedSpellChecker] substitutionsPanel]; }

void SpellCheckerUpdateSpellingPanelWithGrammarString( CFStringRef string, CFDictionaryRef detail )
{ [[NSSpellChecker sharedSpellChecker] updateSpellingPanelWithGrammarString:(__bridge NSString *)string detail:(__bridge NSDictionary *)detail]; }

void SpellCheckerUpdatePanels( void )
{ [[NSSpellChecker sharedSpellChecker] updatePanels]; }

NSView *SpellCheckerAccessoryView( void )
{ return [[NSSpellChecker sharedSpellChecker] accessoryView]; }

NSViewController *SpellCheckerSubsitutionsPanelAccessoryViewController( void )
{ return [[NSSpellChecker sharedSpellChecker] substitutionsPanelAccessoryViewController]; }

// Check spelling and grammar
NSInteger SpellCheckerCountWordsInString( CFStringRef string, CFStringRef language )
{ return [[NSSpellChecker sharedSpellChecker] countWordsInString:(__bridge NSString *)string language:(__bridge NSString *)language]; }

CFRange SpellCheckerCheckSpellingOfString( CFStringRef string, NSInteger startOffset )
{ return NSRangeToCFRange([[NSSpellChecker sharedSpellChecker] checkSpellingOfString:(__bridge NSString *)string startingAt:startOffset]); }

CFRange SpellCheckerCheckSpellingOfStringWithLanguage( CFStringRef string, NSInteger startOffset, CFStringRef language, BOOL wrap, NSInteger spellDocTag, NSInteger *wordCount )
{ return NSRangeToCFRange([[NSSpellChecker sharedSpellChecker] checkSpellingOfString:(__bridge NSString *)string startingAt:startOffset language:(__bridge NSString *)language wrap:wrap inSpellDocumentWithTag:spellDocTag wordCount:wordCount]); }

CFRange SpellCheckerCheckGrammarOfString( CFStringRef string, NSInteger startOffset, CFStringRef language, BOOL wrap, NSInteger spellDocTag, CFArrayRef *details )
{
    NSArray *tempDetails = nil;
    NSRange range = [[NSSpellChecker sharedSpellChecker] checkGrammarOfString:(__bridge NSString *)string startingAt:startOffset language:(__bridge NSString *)language wrap:wrap inSpellDocumentWithTag:spellDocTag details:&tempDetails];
    if ( details ) *details = (__bridge CFArrayRef)tempDetails;
    return NSRangeToCFRange(range);
}

CFArrayRef SpellCheckerCheckString( CFStringRef string, CFRange range, NSTextCheckingTypes types, CFDictionaryRef options, NSInteger spellDocTag, NSOrthography **orthography, NSInteger *wordCount )
{ return (__bridge CFArrayRef)[[NSSpellChecker sharedSpellChecker] checkString:(__bridge NSString *)string range:NSRangeFromCFRange(range) types:types options:(__bridge NSDictionary *)options inSpellDocumentWithTag:spellDocTag orthography:orthography wordCount:wordCount]; }

/*
  SpellCheckerRequestCheckingOfString

  completion handler example:
    void local fn MyCompletionHandler( sequenceNumber as NSInteger, results as CFArrayRef, orthography as NSOrthography *, wordCount as NSInteger, userData as ptr )
    // ...
    end fn
*/
NSInteger SpellCheckerRequestCheckingOfString( CFStringRef string, CFRange range, NSTextCheckingTypes types, CFDictionaryRef options, NSInteger spellDocTag, CUI_SpellCheckerRequestCheckingCompletionHandlerType completionHandler, void *userData )
{
    return [[NSSpellChecker sharedSpellChecker] requestCheckingOfString:(__bridge NSString *)string range:NSRangeFromCFRange(range) types:types options:(__bridge NSDictionary *)options inSpellDocumentWithTag:spellDocTag completionHandler:^(NSInteger sequenceNumber, NSArray *results, NSOrthography *orthography, NSInteger wordCount) {
        (*completionHandler)(sequenceNumber,(__bridge CFArrayRef)results,orthography,wordCount,userData);
    }];
}

CFArrayRef SpellCheckerGuessesForWordRange( CFRange range, CFStringRef string, CFStringRef language, NSInteger spellDocTag )
{ return (__bridge CFArrayRef)[[NSSpellChecker sharedSpellChecker] guessesForWordRange:NSRangeFromCFRange(range) inString:(__bridge NSString *)string language:(__bridge NSString *)language inSpellDocumentWithTag:spellDocTag]; }

// Spell-checking process
NSInteger SpellCheckerUniqueSpellDocumentTag( void )
{ return [NSSpellChecker uniqueSpellDocumentTag]; }

void SpellCheckerCloseSpellDocument( NSInteger spellDocTag )
{ [[NSSpellChecker sharedSpellChecker] closeSpellDocumentWithTag:spellDocTag]; }

void SpellCheckerIgnoreWord( CFStringRef wordToIgnore, NSInteger spellDocTag )
{ [[NSSpellChecker sharedSpellChecker] ignoreWord:(__bridge NSString *)wordToIgnore inSpellDocumentWithTag:spellDocTag]; }

CFArrayRef SpellCheckerIgnoredWords( NSInteger spellDocTag )
{ return (__bridge CFArrayRef)[[NSSpellChecker sharedSpellChecker] ignoredWordsInSpellDocumentWithTag:spellDocTag]; }

void SpellCheckerSetIgnoredWords( CFArrayRef ignoredWords, NSInteger spellDocTag )
{ [[NSSpellChecker sharedSpellChecker] setIgnoredWords:(__bridge NSArray *)ignoredWords inSpellDocumentWithTag:spellDocTag]; }

void SpellCheckerSetWordFieldStringValue( CFStringRef string )
{ [[NSSpellChecker sharedSpellChecker] setWordFieldStringValue:(__bridge NSString *)string]; }

void SpellCheckerUpdateSpellingPanelWithMisspelledWord( CFStringRef wrd )
{ [[NSSpellChecker sharedSpellChecker] updateSpellingPanelWithMisspelledWord:(__bridge NSString *)wrd]; }

CFArrayRef SpellCheckerCompletionsForPartialWordRange( CFRange range, CFStringRef string, CFStringRef language, NSInteger spellDocTag )
{ return (__bridge CFArrayRef)[[NSSpellChecker sharedSpellChecker] completionsForPartialWordRange:NSRangeFromCFRange(range) inString:(__bridge NSString *)string language:(__bridge NSString *)language inSpellDocumentWithTag:spellDocTag]; }

BOOL SpellCheckerHasLearnedWord( CFStringRef wrd )
{ return [[NSSpellChecker sharedSpellChecker] hasLearnedWord:(__bridge NSString *)wrd]; }

void SpellCheckerUnlearnWord( CFStringRef wrd )
{ [[NSSpellChecker sharedSpellChecker] unlearnWord:(__bridge NSString *)wrd]; }

void SpellCheckerLearnWord( CFStringRef wrd )
{ [[NSSpellChecker sharedSpellChecker] learnWord:(__bridge NSString *)wrd]; }

CFArrayRef SpellCheckerUserQuotesArrayForLanguage( CFStringRef language )
{ return (__bridge CFArrayRef)[[NSSpellChecker sharedSpellChecker] userQuotesArrayForLanguage:(__bridge NSString *)language]; }

CFDictionaryRef SpellCheckerUserReplacementsDictionary( void )
{ return (__bridge CFDictionaryRef)[[NSSpellChecker sharedSpellChecker] userReplacementsDictionary]; }

// Data detector
NSMenu *SpellCheckerMenuForResult( NSTextCheckingResult *result, CFStringRef string, CFDictionaryRef options, CGPoint location, NSInteger vwTag )
{
    NSView *view = CUI_ViewWithTag( vwTag );
    if ( view ) {
        return [[NSSpellChecker sharedSpellChecker] menuForResult:result string:(__bridge NSString *)string options:(__bridge NSDictionary *)options atLocation:NSPointFromCGPoint(location) inView:view];
    }
    return nil;
}

// Automatic spell correction
CFStringRef SpellCheckerCorrectionForWordRange( CFRange range, CFStringRef string, CFStringRef language, NSInteger spellDocTag )
{ return (__bridge CFStringRef)[[NSSpellChecker sharedSpellChecker] correctionForWordRange:NSRangeFromCFRange(range) inString:(__bridge NSString *)string language:(__bridge NSString *)language inSpellDocumentWithTag:spellDocTag]; }

/*
  SpellCheckerShowCorrectionIndicator

  completion handler example:
    void local fn MyCompletionHandler( acceptedString as CFStringRef, userData as ptr )
      // ...
    end fn
*/
void SpellCheckerShowCorrectionIndicator( NSCorrectionIndicatorType type, CFStringRef primaryString, CFArrayRef alternativeStrings, CGRect rectOfTypedString, NSInteger vwTag, CUI_SpellCheckerShowCorrectionIndicatorCompletionHandlerType completionHandler, void *userData )
{
    NSView *view = CUI_ViewWithTag( vwTag );
    if ( view ) {
        [[NSSpellChecker sharedSpellChecker] showCorrectionIndicatorOfType:type primaryString:(__bridge NSString *)primaryString alternativeStrings:(__bridge NSArray *)alternativeStrings forStringInRect:NSRectFromCGRect(rectOfTypedString) view:view completionHandler:^(NSString *acceptedString) {
            (*completionHandler)((__bridge CFStringRef)acceptedString,userData);
        }];
    }
}

void SpellCheckerRecordResponse( NSCorrectionResponse response, CFStringRef correction, CFStringRef wrd, CFStringRef language, NSInteger spellDocTag )
{ [[NSSpellChecker sharedSpellChecker] recordResponse:response toCorrection:(__bridge NSString *)correction forWord:(__bridge NSString *)wrd language:(__bridge NSString *)language inSpellDocumentWithTag:spellDocTag]; }

void SpellCheckerDismissCorrectionIndicator( NSInteger vwTag )
{
    NSView *view = CUI_ViewWithTag( vwTag );
    if ( view ) {
        [[NSSpellChecker sharedSpellChecker] dismissCorrectionIndicatorForView:view];
    }
}

// Type properties
BOOL SpellCheckerIsAutomaticCapitalizationEnabled( void )
{ return [NSSpellChecker isAutomaticCapitalizationEnabled]; }

BOOL SpellCheckerIsAutomaticDashSubstitutionEnabled( void )
{ return [NSSpellChecker isAutomaticDashSubstitutionEnabled]; }

BOOL SpellCheckerIsAutomaticPeriodSubstitutionEnabled( void )
{ return [NSSpellChecker isAutomaticPeriodSubstitutionEnabled]; }

BOOL SpellCheckerIsAutomaticQuoteSubstitutionEnabled( void )
{ return [NSSpellChecker isAutomaticQuoteSubstitutionEnabled]; }

BOOL SpellCheckerIsAutomaticSpellingCorrectionEnabled( void )
{ return [NSSpellChecker isAutomaticSpellingCorrectionEnabled]; }

BOOL SpellCheckerIsAutomaticTextCompletionEnabled( void )
{ return [NSSpellChecker isAutomaticTextCompletionEnabled]; }

BOOL SpellCheckerIsAutomaticTextReplacementEnabled( void )
{ return [NSSpellChecker isAutomaticTextReplacementEnabled]; }

// Instance methods
BOOL SpellCheckerDeletesAutospace( CFStringRef precedingString, CFStringRef followingString, CFStringRef language )
{ return [[NSSpellChecker sharedSpellChecker] deletesAutospaceBetweenString:(__bridge NSString *)precedingString andString:(__bridge NSString *)followingString language:(__bridge NSString *)language]; }

CFStringRef SpellCheckerLanguageForWordRange( CFRange range, CFStringRef string, NSOrthography *orthography )
{ return (__bridge CFStringRef)[[NSSpellChecker sharedSpellChecker] languageForWordRange:NSRangeFromCFRange(range) inString:(__bridge NSString *)string orthography:orthography]; }

BOOL SpellCheckerPreventsAutocorrectionBeforeString( CFStringRef string, CFStringRef language )
{ return [[NSSpellChecker sharedSpellChecker] preventsAutocorrectionBeforeString:(__bridge NSString *)string language:(__bridge NSString *)language]; }

/*
  SpellCheckerRequestCandidatesForSelectedRange

  completion handler example:
    void local fn MyCompletionHandler( sequenceNumber as NSInteger, CFArrayRef candidates, userData as ptr )
      // ...
    end fn
*/
NSInteger SpellCheckerRequestCandidatesForSelectedRange( CFRange range, CFStringRef string, NSTextCheckingTypes types, CFDictionaryRef options, NSInteger spellDocTag, CUI_SpellCheckerRequestCandidatesCompletionHandlerType completionHandler, void *userData )
{
    return [[NSSpellChecker sharedSpellChecker] requestCandidatesForSelectedRange:NSRangeFromCFRange(range) inString:(__bridge NSString *)string types:types options:(__bridge NSDictionary *)options inSpellDocumentWithTag:spellDocTag completionHandler:^(NSInteger sequenceNumber,NSArray *candidates) {
        (*completionHandler)(sequenceNumber,(__bridge CFArrayRef)candidates,userData);
    }];
}


/*
  Convenience
*/
CFArrayRef SpellCheckerGuessesForWord( CFStringRef wrd )
{ return (__bridge CFArrayRef)[[NSSpellChecker sharedSpellChecker] guessesForWordRange:NSMakeRange(0,[(__bridge NSString *)wrd length]) inString:(__bridge NSString *)wrd language:[[NSSpellChecker sharedSpellChecker] language] inSpellDocumentWithTag:0]; }

CFStringRef SpellCheckerCorrectionForWord( CFStringRef wrd )
{ return (__bridge CFStringRef)[[NSSpellChecker sharedSpellChecker] correctionForWordRange:NSMakeRange(0,[(__bridge NSString *)wrd length]) inString:(__bridge NSString *)wrd language:[[NSSpellChecker sharedSpellChecker] language] inSpellDocumentWithTag:0]; }

