/*
 SpeechSynthesizer.m

 Bernie Wylde
 */

#import "SpeechSynthesizer.h"

@implementation CUI_SpeechSynthesizerDelegate

#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.stringVal release];
    [self.messageVal release];
    [super dealloc];
}
#endif

- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender willSpeakWord:(NSRange)characterRange ofString:(NSString *)string {
    self.rangeVal = characterRange;
    self.stringVal = string;
    (*self.callback)( sender, speechSynthesizerWillSpeakWord, self.userData );
}

- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender willSpeakPhoneme:(short)phonemeOpcode {
    self.phonemeOpcodeVal = phonemeOpcode;
    (*self.callback)( sender, speechSynthesizerWillSpeakPhoneme, self.userData );
}

- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender didEncounterErrorAtIndex:(NSUInteger)characterIndex ofString:(NSString *)string message:(NSString *)message {
    self.characterIndexVal = characterIndex;
    self.stringVal = string;
    self.messageVal = message;
    (*self.callback)( sender, speechSynthesizerDidEncounterError, self.userData );
}

- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender didEncounterSyncMessage:(NSString *)message {
    self.messageVal = message;
    (*self.callback)( sender, speechSynthesizerDidEncounterSyncMessage, self.userData );
}

- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender didFinishSpeaking:(BOOL)finishedSpeaking {
    self.finishedSpeakingVal = finishedSpeaking;
    (*self.callback)( sender, speechSynthesizerDidFinishSpeaking, self.userData );
}
@end

// delegate callback values
CFRange SpeechSynthesizerDelegateRange( NSSpeechSynthesizer *ref )
{ return NSRangeToCFRange( [(CUI_SpeechSynthesizerDelegate *)[ref delegate] rangeVal] ); }

CFStringRef SpeechSynthesizerDelegateString( NSSpeechSynthesizer *ref )
{ return (__bridge CFStringRef)[(CUI_SpeechSynthesizerDelegate *)[ref delegate] stringVal]; }

short SpeechSynthesizerDelegatePhonemeOpcode( NSSpeechSynthesizer *ref )
{ return [(CUI_SpeechSynthesizerDelegate *)[ref delegate] phonemeOpcodeVal]; }

NSUInteger SpeechSynthesizerDelegateCharacterIndex( NSSpeechSynthesizer *ref )
{ return [(CUI_SpeechSynthesizerDelegate *)[ref delegate] characterIndexVal]; }

CFStringRef SpeechSynthesizerDelegateMessage( NSSpeechSynthesizer *ref )
{ return (__bridge CFStringRef)[(CUI_SpeechSynthesizerDelegate *)[ref delegate] messageVal]; }

BOOL SpeechSynthesizerDelegateFinishedSpeaking( NSSpeechSynthesizer *ref )
{ return [(CUI_SpeechSynthesizerDelegate *)[ref delegate] finishedSpeakingVal]; }

// Class
Class SpeechSynthesizerClass( void )
{ return [NSSpeechSynthesizer class]; }

// Create
NSSpeechSynthesizer *SpeechSynthesizerWithVoice( CFStringRef voice )
{
#if __has_feature(objc_arc)
    return [[NSSpeechSynthesizer alloc] initWithVoice:(__bridge NSString *)voice];
#else
    return [[[NSSpeechSynthesizer alloc] initWithVoice:(__bridge NSString *)voice] autorelease];
#endif
}

// Customize behavior
void SpeechSynthesizerSetDelegateCallback( NSSpeechSynthesizer *ref, CUI_SpeechSynthesizerDelegateCallbackType callback, void *userData )
{
    CUI_SpeechSynthesizerDelegate *delegate = [[CUI_SpeechSynthesizerDelegate alloc] init];
    delegate.callback = callback;
    delegate.userData = userData;
    [ref setDelegate:delegate];
}

// Configure
BOOL SpeechSynthesizerUsesFeedbackWindow( NSSpeechSynthesizer *ref )
{ return [ref usesFeedbackWindow]; }

void SpeechSynthesizerSetUsesFeedbackWindow( NSSpeechSynthesizer *ref, BOOL flag )
{ [ref setUsesFeedbackWindow:flag]; }

CFStringRef SpeechSynthesizerVoice( NSSpeechSynthesizer *ref )
{ return (__bridge CFStringRef)[ref voice]; }

void SpeechSynthesizerSetVoice( NSSpeechSynthesizer *ref, CFStringRef voice )
{ [ref setVoice:(__bridge NSString *)voice]; }

float SpeechSynthesizerRate( NSSpeechSynthesizer *ref )
{ return [ref rate]; }

void SpeechSynthesizerSetRate( NSSpeechSynthesizer *ref, float rate )
{ [ref setRate:rate]; }

float SpeechSynthesizerVolume( NSSpeechSynthesizer *ref )
{ return [ref volume]; }

void SpeechSynthesizerSetVolume( NSSpeechSynthesizer *ref, float volume )
{ [ref setVolume:volume]; }

// Attributes
void SpeechSynthesizerAddSpeechDictionary( NSSpeechSynthesizer *ref, CFDictionaryRef speechDictionary )
{ [ref addSpeechDictionary:(__bridge NSDictionary *)speechDictionary]; }

CFTypeRef SpeechSynthesizerObjectForProperty( NSSpeechSynthesizer *ref, CFStringRef property, NSError **err )
{ return (__bridge CFTypeRef)[ref objectForProperty:(__bridge NSString *)property error:err]; }

BOOL SpeechSynthesizerSetObjectForProperty( NSSpeechSynthesizer *ref, CFTypeRef object, CFStringRef property, NSError **err )
{ return [ref setObject:(__bridge id)object forProperty:(__bridge NSString *)property error:err]; }

// Synthesizer info
CFArrayRef SpeechSynthesizerAvailableVoices( void )
{ return (__bridge CFArrayRef)[NSSpeechSynthesizer availableVoices]; }

CFDictionaryRef SpeechSynthesizerAttributesForVoice( CFStringRef voice )
{ return (__bridge CFDictionaryRef)[NSSpeechSynthesizer attributesForVoice:(__bridge NSString *)voice]; }

CFStringRef SpeechSynthesizerDefaultVoice( void )
{ return (__bridge CFStringRef)[NSSpeechSynthesizer defaultVoice]; }

// State
BOOL SpeechSynthesizerIsAnyApplicationSpeaking( void )
{ return [NSSpeechSynthesizer isAnyApplicationSpeaking]; }

// Synthesizing speech
BOOL SpeechSynthesizerIsSpeaking( NSSpeechSynthesizer *ref )
{ return [ref isSpeaking]; }

BOOL SpeechSynthesizerStartSpeakingString( NSSpeechSynthesizer *ref, CFStringRef string )
{ return [ref startSpeakingString:(__bridge NSString *)string]; }

BOOL SpeechSynthesizerStartSpeakingStringToURL( NSSpeechSynthesizer *ref, CFStringRef string, CFURLRef url )
{ return [ref startSpeakingString:(__bridge NSString *)string toURL:(__bridge NSURL *)url]; }

void SpeechSynthesizerPauseSpeakingAtBoundary( NSSpeechSynthesizer *ref, NSSpeechBoundary boundary )
{ [ref pauseSpeakingAtBoundary:boundary]; }

void SpeechSynthesizerStopSpeakingAtBoundary( NSSpeechSynthesizer *ref, NSSpeechBoundary boundary )
{ [ref stopSpeakingAtBoundary:boundary]; }

// Phonemes
CFStringRef SpeechSynthesizerPhonemesFromText( NSSpeechSynthesizer *ref, CFStringRef txt )
{ return (__bridge CFStringRef)[ref phonemesFromText:(__bridge NSString *)txt]; }

