/*
 SpeechRecognizer.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef void (*CUI_SpeechRecognizerDelegateCallbackType)(NSSpeechRecognizer*,NSInteger,void*);

// Delegate
@interface CUI_SpeechRecognizerDelegate : NSObject <NSSpeechRecognizerDelegate>
@property (nonatomic,assign) CUI_SpeechRecognizerDelegateCallbackType callback;
@property (nonatomic,assign) void *userData;
@property (nonatomic,retain) NSString *commandVal;
@end

// delegate callback
enum {
    speechRecognizerDidRecognizeCommand
};

CFStringRef SpeechRecognizerDelegateCommand( NSSpeechRecognizer *ref );

// Class
Class SpeechRecognizerClass( void );

// Create
NSSpeechRecognizer *SpeechRecognizerInit( void );

// Delegate callback
void SpeechRecognizerSetDelegateCallback( NSSpeechRecognizer *ref, CUI_SpeechRecognizerDelegateCallbackType callback, void *userData );

// Configure
CFArrayRef SpeechRecognizerCommands( NSSpeechRecognizer *ref );
void SpeechRecognizerSetCommands( NSSpeechRecognizer *ref, CFArrayRef commands );
CFStringRef SpeechRecognizerDisplayedCommandsTitle( NSSpeechRecognizer *ref );
void SpeechRecognizerSetDisplayedCommandsTitle( NSSpeechRecognizer *ref, CFStringRef title );
BOOL SpeechRecognizerListensInForegroundOnly( NSSpeechRecognizer *ref );
void SpeechRecognizerSetListensInForegroundOnly( NSSpeechRecognizer *ref, BOOL flag );
BOOL SpeechRecognizerBlocksOtherRecognizers( NSSpeechRecognizer *ref );
void SpeechRecognizerSetBlocksOtherRecognizers( NSSpeechRecognizer *ref, BOOL flag );

// Listening
void SpeechRecognizerStartListening( NSSpeechRecognizer *ref );
void SpeechRecognizerStopListening( NSSpeechRecognizer *ref );

