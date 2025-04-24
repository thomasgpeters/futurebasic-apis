/*
 Sound.h

 Bernie Wylde
 */

#import "CocoaUI.h"

// dialog events
enum {
    soundDidFinishPlaying = 3700
};

@interface CUI_SoundDelegate : NSObject <NSSoundDelegate>
@property (nonatomic,assign) BOOL paused;
@end

CUI_SoundDelegate *CUI_SoundDelegateObj( void );

#pragma mark - public
// Class
Class SoundClass( void );

NSSound *SoundWithTag( CFTypeRef ref );
BOOL SoundExists( NSSound *ref );

NSInteger SoundTag( SoundRef ref );

// -- create --
BOOL SoundCanInitWithPasteboard( NSPasteboard *pb );
NSSound *SoundWithContentsOfURL( CFURLRef url, BOOL byReference );
NSSound *SoundWithData( CFDataRef data );
NSSound *SoundWithPasteboard( NSPasteboard *pb );

// -- configure --
CFStringRef SoundName( NSSound *ref );
BOOL SoundSetName( NSSound *ref, CFStringRef name );
float SoundVolume( NSSound *ref );
void SoundSetVolume( NSSound *ref, float value );
CFTimeInterval SoundCurrentTime( NSSound *ref );
void SoundSetCurrentTime( NSSound *ref, CFTimeInterval ti );
BOOL SoundLoops( NSSound *ref );
void SoundSetLoops( NSSound *ref, BOOL flag );
CFStringRef SoundPlaybackDeviceIdentifier( NSSound *ref );
void SoundSetPlaybackDeviceIdentifier( NSSound *ref, CFStringRef identifier );

// -- info --
CFArrayRef SoundUnfilteredTypes( void );
NSSound *SoundNamed( CFStringRef name );
CFTimeInterval SoundDuration( NSSound *ref );

// -- play --
BOOL SoundIsPlaying( NSSound *ref );
BOOL SoundIsPaused( NSSound *ref );
BOOL SoundPause( NSSound *ref );
BOOL SoundPlay( CFTypeRef snd );
BOOL SoundResume( NSSound *ref );
BOOL SoundStop( NSSound *ref );

// -- write --
void SoundWriteToPasteboard( NSSound *ref, NSPasteboard *pb );

// Custom
void SoundClose( NSSound *ref );

#pragma mark - FB statement
BOOL CUI_SoundStatement( NSInteger inTag, CFStringRef inName, CFTypeRef inURLDataPasteboard, double inVolume, NSInteger inLoops );

#pragma mark - FB function
BOOL CUI_SoundFunction( NSInteger inTag );
