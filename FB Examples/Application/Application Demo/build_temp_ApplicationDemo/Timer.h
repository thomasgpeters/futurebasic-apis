/*
 Timer.h

 Bernie Wylde
 */

#import "CocoaUI.h"

typedef void (*CUI_TimerCallbackType)(CFRunLoopTimerRef,CFTypeRef);

@interface CUI_TimerTarget : NSObject
- (id)initWithCallback:(CUI_TimerCallbackType)cb;
@property (nonatomic,assign) CUI_TimerCallbackType callback;
@end

// Class
Class TimerClass( void );

// - create -
CFRunLoopTimerRef TimerScheduledWithInterval( CFTimeInterval ti, CUI_TimerCallbackType callback, CFTypeRef userInfo, BOOL repeats );
CFRunLoopTimerRef TimerWithInterval( CFTimeInterval ti, CUI_TimerCallbackType callback, CFTypeRef userInfo, BOOL repeats );
CFRunLoopTimerRef TimerWithFireDate( CFDateRef dt, CFTimeInterval ti, CUI_TimerCallbackType callback, CFTypeRef userInfo, BOOL repeats );

// - fire -
void TimerFire( CFRunLoopTimerRef ref );

// - stop -
void TimerInvalidate( CFRunLoopTimerRef ref );

// - info -
BOOL TimerIsValid( CFRunLoopTimerRef ref );
CFDateRef TimerFireDate( CFRunLoopTimerRef ref );
CFTimeInterval TimerTimeInterval( CFRunLoopTimerRef ref );
CFTypeRef TimerUserInfo( CFRunLoopTimerRef ref );

// - tolerance -
CFTimeInterval TimerTolerance( CFRunLoopTimerRef ref );
void TimerSetTolerance( CFRunLoopTimerRef ref, CFTimeInterval ti );

