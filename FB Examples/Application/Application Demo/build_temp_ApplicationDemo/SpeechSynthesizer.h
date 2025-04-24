/*
 SpeechSynthesizer.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef void (*CUI_SpeechSynthesizerDelegateCallbackType)(NSSpeechSynthesizer*,NSInteger,void*);

// Delegate
@interface CUI_SpeechSynthesizerDelegate : NSObject <NSSpeechSynthesizerDelegate>
@property (nonatomic,assign) CUI_SpeechSynthesizerDelegateCallbackType callback;
@property (nonatomic,assign) void *userData;
@property (nonatomic,assign) NSRange rangeVal;
@property (nonatomic,retain) NSString *stringVal;
@property (nonatomic,assign) short phonemeOpcodeVal;
@property (nonatomic,assign) NSUInteger characterIndexVal;
@property (nonatomic,retain) NSString *messageVal;
@property (nonatomic,assign) BOOL finishedSpeakingVal;
@end

// delegate callback
enum {
    speechSynthesizerWillSpeakWord,
    speechSynthesizerWillSpeakPhoneme,
    speechSynthesizerDidEncounterError,
    speechSynthesizerDidEncounterSyncMessage,
    speechSynthesizerDidFinishSpeaking
};

CFRange SpeechSynthesizerDelegateRange( NSSpeechSynthesizer *ref );
CFStringRef SpeechSynthesizerDelegateString( NSSpeechSynthesizer *ref );
short SpeechSynthesizerDelegatePhonemeOpcode( NSSpeechSynthesizer *ref );
NSUInteger SpeechSynthesizerDelegateCharacterIndex( NSSpeechSynthesizer *ref );
CFStringRef SpeechSynthesizerDelegateMessage( NSSpeechSynthesizer *ref );
BOOL SpeechSynthesizerDelegateFinishedSpeaking( NSSpeechSynthesizer *ref );

// Class
Class SpeechSynthesizerClass( void );

// Create
NSSpeechSynthesizer *SpeechSynthesizerWithVoice( CFStringRef voice );

// Customize behavior
void SpeechSynthesizerSetDelegateCallback( NSSpeechSynthesizer *ref, CUI_SpeechSynthesizerDelegateCallbackType callback, void *userData );

// Configure
BOOL SpeechSynthesizerUsesFeedbackWindow( NSSpeechSynthesizer *ref );
void SpeechSynthesizerSetUsesFeedbackWindow( NSSpeechSynthesizer *ref, BOOL flag );
CFStringRef SpeechSynthesizerVoice( NSSpeechSynthesizer *ref );
void SpeechSynthesizerSetVoice( NSSpeechSynthesizer *ref, CFStringRef voice );
float SpeechSynthesizerRate( NSSpeechSynthesizer *ref );
void SpeechSynthesizerSetRate( NSSpeechSynthesizer *ref, float rate );
float SpeechSynthesizerVolume( NSSpeechSynthesizer *ref );
void SpeechSynthesizerSetVolume( NSSpeechSynthesizer *ref, float volume );

// Attributes
void SpeechSynthesizerAddSpeechDictionary( NSSpeechSynthesizer *ref, CFDictionaryRef speechDictionary );
CFTypeRef SpeechSynthesizerObjectForProperty( NSSpeechSynthesizer *ref, CFStringRef property, NSError **err );
BOOL SpeechSynthesizerSetObjectForProperty( NSSpeechSynthesizer *ref, CFTypeRef object, CFStringRef property, NSError **err );

// Synthesizer info
CFArrayRef SpeechSynthesizerAvailableVoices( void );
CFDictionaryRef SpeechSynthesizerAttributesForVoice( CFStringRef voice );
CFStringRef SpeechSynthesizerDefaultVoice( void );

// State
BOOL SpeechSynthesizerIsAnyApplicationSpeaking( void );

// Synthesizing speech
BOOL SpeechSynthesizerIsSpeaking( NSSpeechSynthesizer *ref );
BOOL SpeechSynthesizerStartSpeakingString( NSSpeechSynthesizer *ref, CFStringRef string );
BOOL SpeechSynthesizerStartSpeakingStringToURL( NSSpeechSynthesizer *ref, CFStringRef string, CFURLRef url );
void SpeechSynthesizerPauseSpeakingAtBoundary( NSSpeechSynthesizer *ref, NSSpeechBoundary boundary );
void SpeechSynthesizerStopSpeakingAtBoundary( NSSpeechSynthesizer *ref, NSSpeechBoundary boundary );

// Phonemes
CFStringRef SpeechSynthesizerPhonemesFromText( NSSpeechSynthesizer *ref, CFStringRef txt );
