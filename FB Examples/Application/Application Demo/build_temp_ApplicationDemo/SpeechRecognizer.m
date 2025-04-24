/*
 SpeechRecognizer.m

 Bernie Wylde
 */

#import "SpeechRecognizer.h"

@implementation CUI_SpeechRecognizerDelegate

#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.commandVal release];
    [super dealloc];
}
#endif

- (void)speechRecognizer:(NSSpeechRecognizer *)sender didRecognizeCommand:(NSString *)command {
    self.commandVal = command;
    (*self.callback)( sender, speechRecognizerDidRecognizeCommand, self.userData );
}
@end

// delegate callback values
CFStringRef SpeechRecognizerDelegateCommand( NSSpeechRecognizer *ref )
{ return (__bridge CFStringRef)[(CUI_SpeechRecognizerDelegate *)[ref delegate] commandVal]; }


// Class
Class SpeechRecognizerClass( void )
{ return [NSSpeechRecognizer class]; }

// Create
NSSpeechRecognizer *SpeechRecognizerInit( void )
{
#if __has_feature(objc_arc)
    return [[NSSpeechRecognizer alloc] init];
#else
    return [[[NSSpeechRecognizer alloc] init] autorelease];
#endif
}

// Delegate callback
void SpeechRecognizerSetDelegateCallback( NSSpeechRecognizer *ref, CUI_SpeechRecognizerDelegateCallbackType callback, void *userData )
{
    CUI_SpeechRecognizerDelegate *delegate = [[CUI_SpeechRecognizerDelegate alloc] init];
    delegate.callback = callback;
    delegate.userData = userData;
    [ref setDelegate:delegate];
}

// Configure
CFArrayRef SpeechRecognizerCommands( NSSpeechRecognizer *ref )
{ return (__bridge CFArrayRef)[ref commands]; }

void SpeechRecognizerSetCommands( NSSpeechRecognizer *ref, CFArrayRef commands )
{ [ref setCommands:(__bridge NSArray *)commands]; }

CFStringRef SpeechRecognizerDisplayedCommandsTitle( NSSpeechRecognizer *ref )
{ return (__bridge CFStringRef)[ref displayedCommandsTitle]; }

void SpeechRecognizerSetDisplayedCommandsTitle( NSSpeechRecognizer *ref, CFStringRef title )
{ [ref setDisplayedCommandsTitle:(__bridge NSString *)title]; }

BOOL SpeechRecognizerListensInForegroundOnly( NSSpeechRecognizer *ref )
{ return [ref listensInForegroundOnly]; }

void SpeechRecognizerSetListensInForegroundOnly( NSSpeechRecognizer *ref, BOOL flag )
{ [ref setListensInForegroundOnly:flag]; }

BOOL SpeechRecognizerBlocksOtherRecognizers( NSSpeechRecognizer *ref )
{ return [ref blocksOtherRecognizers]; }

void SpeechRecognizerSetBlocksOtherRecognizers( NSSpeechRecognizer *ref, BOOL flag )
{ [ref setBlocksOtherRecognizers:flag]; }

// Listening
void SpeechRecognizerStartListening( NSSpeechRecognizer *ref )
{ [ref startListening]; }

void SpeechRecognizerStopListening( NSSpeechRecognizer *ref )
{ [ref stopListening]; }
