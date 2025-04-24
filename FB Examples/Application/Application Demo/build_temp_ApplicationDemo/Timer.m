/*
 Timer.m

 Bernie Wylde
 */

#import "Timer.h"

@implementation CUI_TimerTarget

- (id)initWithCallback:(CUI_TimerCallbackType)cb {
    if ( (self = [super init]) ) {
        self.callback = cb;
    }
    return self;
}

- (void)timerFireMethod:(NSTimer *)timer {
    if ( self.callback ) (*self.callback)( (__bridge CFRunLoopTimerRef)timer, (__bridge CFTypeRef)[timer userInfo] );
}
@end

// Class
Class TimerClass( void )
{ return [NSTimer class]; }

// - create -
CFRunLoopTimerRef TimerScheduledWithInterval( CFTimeInterval ti, CUI_TimerCallbackType callback, CFTypeRef userInfo, BOOL repeats )
{
#if __has_feature(objc_arc)
    CUI_TimerTarget *target = [[CUI_TimerTarget alloc] initWithCallback:callback];
#else
    CUI_TimerTarget *target = [[[CUI_TimerTarget alloc] initWithCallback:callback] autorelease];
#endif
    return (__bridge CFRunLoopTimerRef)[NSTimer scheduledTimerWithTimeInterval:ti target:target selector:@selector(timerFireMethod:) userInfo:(__bridge id)userInfo repeats:repeats];
}

CFRunLoopTimerRef TimerWithInterval( CFTimeInterval ti, CUI_TimerCallbackType callback, CFTypeRef userInfo, BOOL repeats )
{
#if __has_feature(objc_arc)
    CUI_TimerTarget *target = [[CUI_TimerTarget alloc] initWithCallback:callback];
#else
    CUI_TimerTarget *target = [[[CUI_TimerTarget alloc] initWithCallback:callback] autorelease];
#endif
    NSTimer *timer = [NSTimer timerWithTimeInterval:ti target:target selector:@selector(timerFireMethod:) userInfo:(__bridge id)userInfo repeats:repeats];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    return (__bridge CFRunLoopTimerRef)timer;
}

CFRunLoopTimerRef TimerWithFireDate( CFDateRef dt, CFTimeInterval ti, CUI_TimerCallbackType callback, CFTypeRef userInfo, BOOL repeats )
{
#if __has_feature(objc_arc)
    CUI_TimerTarget *target = [[CUI_TimerTarget alloc] initWithCallback:callback];
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:(__bridge NSDate *)dt interval:ti target:target selector:@selector(timerFireMethod:) userInfo:(__bridge id)userInfo repeats:repeats];
#else
    CUI_TimerTarget *target = [[[CUI_TimerTarget alloc] initWithCallback:callback] autorelease];
    NSTimer *timer = [[[NSTimer alloc] initWithFireDate:(__bridge NSDate *)dt interval:ti target:target selector:@selector(timerFireMethod:) userInfo:(__bridge id)userInfo repeats:repeats] autorelease];
#endif
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    return (__bridge CFRunLoopTimerRef)timer;
}

// - fire -
void TimerFire( CFRunLoopTimerRef ref )
{ [(__bridge NSTimer *)ref fire]; }

// - stop -
void TimerInvalidate( CFRunLoopTimerRef ref )
{ [(__bridge NSTimer *)ref invalidate]; }

// - info -
BOOL TimerIsValid( CFRunLoopTimerRef ref )
{ return [(__bridge NSTimer *)ref isValid]; }

CFDateRef TimerFireDate( CFRunLoopTimerRef ref )
{ return (__bridge CFDateRef)[(__bridge NSTimer *)ref fireDate]; }

CFTimeInterval TimerTimeInterval( CFRunLoopTimerRef ref )
{ return [(__bridge NSTimer *)ref timeInterval]; }

CFTypeRef TimerUserInfo( CFRunLoopTimerRef ref )
{ return (__bridge CFTypeRef)[(__bridge NSTimer *)ref userInfo]; }

// - tolerance -
CFTimeInterval TimerTolerance( CFRunLoopTimerRef ref )
{ return [(__bridge NSTimer *)ref tolerance]; }

void TimerSetTolerance( CFRunLoopTimerRef ref, CFTimeInterval ti )
{ [(__bridge NSTimer *)ref setTolerance:ti]; }

