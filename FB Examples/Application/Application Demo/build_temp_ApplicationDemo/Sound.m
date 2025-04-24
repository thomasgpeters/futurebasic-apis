/*
 Sound.m

 Bernie Wylde
 */

#import "Sound.h"

static NSMutableDictionary *sCUI_Sounds;

@implementation CUI_SoundDelegate
- (void)sound:(NSSound *)sound didFinishPlaying:(BOOL)flag {
    DialogEventSetBool(flag);
    NSInteger tag = 0;
    if ( sCUI_Sounds ) {
        NSArray *keys = [sCUI_Sounds allKeys];
        NSInteger count = [keys count];
        for ( NSInteger index = 0; index < count; index++ ) {
            NSString *key = keys[index];
            NSSound *snd = sCUI_Sounds[key];
            if ( snd == sound ) {
                tag = [key integerValue];
                break;
            }
        }
    }
    CallUserDefinedOnDialogFunction( soundDidFinishPlaying, tag, 0, (__bridge CFTypeRef)sound );
}
@end

// private
CUI_SoundDelegate *CUI_SoundDelegateObj( void )
{
    static CUI_SoundDelegate *sCUI_SoundDelegate = nil;
    if ( !sCUI_SoundDelegate ) sCUI_SoundDelegate = [[CUI_SoundDelegate alloc] init];
    return sCUI_SoundDelegate;
}


#pragma mark - public
// Class
Class SoundClass( void )
{ return [NSSound class]; }

NSSound *SoundWithTag( CFTypeRef ref )
{
    if ( (NSInteger)ref > 1000000 ) {
        CFTypeRef obj = (__bridge id)(void *)ref;
        if ( CFGetTypeID((__bridge CFTypeRef)obj) == CFStringGetTypeID() ) {
            obj = CUI_SoundResource( obj );
        }
        return obj;
    }
    if ( sCUI_Sounds ) {
        NSString *key = [NSString stringWithFormat:@"%ld",(NSInteger)ref];
        NSSound *snd = sCUI_Sounds[key];
        if ( snd ) return snd;
    }
    return nil;
}

BOOL SoundExists( NSSound *ref )
{
    if ( SoundWithTag( ref ) ) return YES;
    return NO;
}

NSInteger SoundTag( SoundRef ref )
{
    if ( sCUI_Sounds ) {
        NSArray *keys = [sCUI_Sounds allKeys];
        for ( NSString *key in keys ) {
            if ( [sCUI_Sounds[key] isEqualTo:ref] ) {
                return [key integerValue];
            }
        }
    }
    return 0;
}

// -- create --
BOOL SoundCanInitWithPasteboard( NSPasteboard *pb )
{ return [NSSound canInitWithPasteboard:pb]; }

NSSound *SoundWithContentsOfURL( CFURLRef url, BOOL byReference )
{
#if __has_feature(objc_arc)
    return [[NSSound alloc] initWithContentsOfURL:(__bridge NSURL *)url byReference:byReference];
#else
    return [[[NSSound alloc] initWithContentsOfURL:(__bridge NSURL *)url byReference:byReference] autorelease];
#endif
}

NSSound *SoundWithData( CFDataRef data )
{
#if __has_feature(objc_arc)
    return [[NSSound alloc] initWithData:(__bridge NSData *)data];
#else
    return [[[NSSound alloc] initWithData:(__bridge NSData *)data] autorelease];
#endif
}

NSSound *SoundWithPasteboard( NSPasteboard *pb )
{
#if __has_feature(objc_arc)
    return [[NSSound alloc] initWithPasteboard:pb];
#else
    return [[[NSSound alloc] initWithPasteboard:pb] autorelease];
#endif
}

// -- configure --
CFStringRef SoundName( NSSound *ref )
{
    NSSound *snd = SoundWithTag( ref );
    if ( snd ) return (__bridge CFStringRef)[snd name];
    return nil;
}

BOOL SoundSetName( NSSound *ref, CFStringRef name )
{
    NSSound *snd = SoundWithTag( ref );
    if ( snd ) return [snd setName:(__bridge NSString *)name];
    return NO;
}

float SoundVolume( NSSound *ref )
{
    NSSound *snd = SoundWithTag( ref );
    if ( snd ) return [snd volume];
    return 0.0;
}

void SoundSetVolume( NSSound *ref, float value )
{
    NSSound *snd = SoundWithTag( ref );
    if ( snd ) [snd setVolume:value];
}

CFTimeInterval SoundCurrentTime( NSSound *ref )
{
    NSSound *snd = SoundWithTag( ref );
    if ( snd ) return [snd currentTime];
    return 0.0;
}

void SoundSetCurrentTime( NSSound *ref, CFTimeInterval ti )
{
    NSSound *snd = SoundWithTag( ref );
    if ( snd ) [snd setCurrentTime:ti];
}

BOOL SoundLoops( NSSound *ref )
{
    NSSound *snd = SoundWithTag( ref );
    if ( snd ) return [snd loops];
    return NO;
}

void SoundSetLoops( NSSound *ref, BOOL flag )
{
    NSSound *snd = SoundWithTag( ref );
    if ( snd ) [snd setLoops:flag];
}

CFStringRef SoundPlaybackDeviceIdentifier( NSSound *ref )
{
    NSSound *snd = SoundWithTag( ref );
    if ( snd ) return (__bridge CFStringRef)[snd playbackDeviceIdentifier];
    return nil;
}

void SoundSetPlaybackDeviceIdentifier( NSSound *ref, CFStringRef identifier )
{
    NSSound *snd = SoundWithTag( ref );
    if ( snd ) [snd setPlaybackDeviceIdentifier:(__bridge NSString *)identifier];
}

// -- info --
CFArrayRef SoundUnfilteredTypes( void )
{ return (__bridge CFArrayRef)[NSSound soundUnfilteredTypes]; }

NSSound *SoundNamed( CFStringRef name )
{ return CUI_SoundResource( (__bridge NSString *)name ); }// 20240725

CFTimeInterval SoundDuration( NSSound *ref )
{
    NSSound *snd = SoundWithTag( ref );
    if ( snd ) return [snd duration];
    return 0.0;
}

// -- play --
BOOL SoundIsPlaying( NSSound *ref )
{
    NSSound *snd = SoundWithTag( ref );
    if ( snd ) return [snd isPlaying];
    return NO;
}

BOOL SoundIsPaused( NSSound *ref )
{
    NSSound *snd = SoundWithTag( ref );
    if ( snd ) {
        CUI_SoundDelegate *delegate = [snd delegate];
        if ( delegate ) {
            return delegate.paused;
        }
    }
    return NO;
}

BOOL SoundPause( NSSound *ref )
{
    NSSound *snd = SoundWithTag( ref );
    if ( snd ) {
        BOOL flag = [snd pause];
        CUI_SoundDelegate *delegate = [snd delegate];
        if ( delegate ) {
            delegate.paused = flag;
        }
        return flag;
    }
    return NO;
}

BOOL SoundPlay( CFTypeRef ref )
{
    NSSound *snd = SoundWithTag( ref );
    if ( snd ) {
        CUI_SoundDelegate *delegate = CUI_SoundDelegateObj();
        delegate.paused = NO;
        [snd setDelegate:delegate];
        return [snd play];
    }
    return NO;
}

BOOL SoundResume( NSSound *ref )
{
    NSSound *snd = SoundWithTag( ref );
    if ( snd ) {
        CUI_SoundDelegate *delegate = [snd delegate];
        delegate.paused = NO;
        return [snd resume];
    }
    return NO;
}

BOOL SoundStop( NSSound *ref )
{
    NSSound *snd = SoundWithTag( ref );
    if ( snd ) return [snd stop];
    return NO;
}

// -- write --
void SoundWriteToPasteboard( NSSound *ref, NSPasteboard *pb )
{
    NSSound *snd = SoundWithTag( ref );
    if ( snd ) [snd writeToPasteboard:pb];
}

// Custom
void SoundClose( NSSound *ref )
{
    if ( sCUI_Sounds ) {
        if ( (NSInteger)ref > 1000000 ) {
            NSSound *sound = (__bridge NSSound *)(void *)ref;
            NSArray *keys = [sCUI_Sounds allKeys];
            NSInteger count = [keys count];
            for ( NSInteger index = 0; index < count; index++ ) {
                NSString *key = keys[index];
                NSSound *snd = sCUI_Sounds[key];
                if ( snd == sound ) {
                    [sCUI_Sounds removeObjectForKey:key];
                    break;
                }
            }
        } else {
            NSString *key = [NSString stringWithFormat:@"%ld",(NSInteger)ref];
            NSSound *snd = sCUI_Sounds[key];
            if ( snd ) [sCUI_Sounds removeObjectForKey:key];
        }
    }
}


#pragma mark - FB statement
BOOL CUI_SoundStatement( NSInteger inTag, CFStringRef inName, CFTypeRef inURLDataPasteboard, double inVolume, NSInteger inLoops )
{
    BOOL result = NO;
    BOOL pause = ( inTag < 0 );
    inTag = ABS(inTag);
    
    NSString *name = (__bridge NSString *)inName;
    
    NSSound *snd = SoundWithTag( (NSSound *)inTag );
    if ( snd ) {    // already exists
        if ( pause ) {
            SoundPause( snd );
        } else {
            if ( SoundIsPlaying( snd ) ) {
                SoundResume( snd );
            } else {
                SoundPlay( snd );
            }
        }

        if ( inVolume >= 0.0 ) [snd setVolume:(float)inVolume];
        
        if ( inLoops != kFBParamMissing ) [snd setLoops:inLoops];
        
        result = YES;
    } else {           // create
        if ( inURLDataPasteboard ) {
            if ( CFGetTypeID(inURLDataPasteboard) == CFURLGetTypeID() ) {
                snd = [[NSSound alloc] initWithContentsOfURL:(__bridge NSURL *)inURLDataPasteboard byReference:YES];
            } else if ( CFGetTypeID(inURLDataPasteboard) == CFDataGetTypeID() ) {
                snd = [[NSSound alloc] initWithData:(__bridge NSData *)inURLDataPasteboard];
            } else if ( [(__bridge id)inURLDataPasteboard isKindOfClass:[NSPasteboard class]] ) {
                snd = [[NSSound alloc] initWithPasteboard:(__bridge NSPasteboard *)inURLDataPasteboard];
            }
        } else {
            if ( name ) {
                snd = CUI_SoundResource( name );//[NSSound soundNamed:name];// 20240725
            }
        }
        
        if ( snd ) {
            if ( !sCUI_Sounds ) sCUI_Sounds = [[NSMutableDictionary alloc] initWithCapacity:0];
            NSString *key = [NSString stringWithFormat:@"%ld",inTag];
            [sCUI_Sounds setValue:snd forKey:key];
            
            if ( inVolume >= 0.0 ) [snd setVolume:(float)inVolume];
            
            if ( inLoops != kFBParamMissing ) [snd setLoops:inLoops];
            
            CUI_SoundDelegate *delegate = CUI_SoundDelegateObj();
            delegate.paused = pause;
            [snd setDelegate:delegate];
            
            result = YES;
            if ( !pause ) {
                result = SoundPlay( (NSSound *)inTag );
            }
            
        } else {
            // error
        }
    }
    return result;
}

#pragma mark - FB function
BOOL CUI_SoundFunction( NSInteger inTag )
{
    inTag = ABS(inTag);
    NSSound *snd = SoundWithTag( (NSSound *)inTag );
    if ( snd ) {
        return [snd isPlaying];
    }
    return NO;
}

