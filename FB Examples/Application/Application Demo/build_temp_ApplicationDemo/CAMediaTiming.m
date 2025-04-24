/*
  CAMediaTiming.m

  Bernie Wylde 20180828
*/

#import "CAMediaTiming.h"

// Animation start time
CFTimeInterval CAMediaTimingBeginTime( id<CAMediaTiming> ref )
{ return [ref beginTime]; }

void CAMediaTimingSetBeginTime( id<CAMediaTiming> ref, CFTimeInterval ti )
{ [ref setBeginTime:ti]; }

CFTimeInterval CAMediaTimingTimeOffset( id<CAMediaTiming> ref )
{ return [ref timeOffset]; }

void CAMediaTimingSetTimeOffset( id<CAMediaTiming> ref, CFTimeInterval ti )
{ [ref setTimeOffset:ti]; }

// Repeating animations
float CAMediaTimingRepeatCount( id<CAMediaTiming> ref )
{ return [ref repeatCount]; }

void CAMediaTimingSetRepeatCount( id<CAMediaTiming> ref, float count )
{ [ref setRepeatCount:count]; }

CFTimeInterval CAMediaTimingRepeatDuration( id<CAMediaTiming> ref )
{ return [ref repeatDuration]; }

void CAMediaTimingSetRepeatDuration( id<CAMediaTiming> ref, CFTimeInterval ti )
{ [ref setRepeatDuration:ti]; }

// Duration and speed
CFTimeInterval CAMediaTimingDuration( id<CAMediaTiming> ref )
{ return [ref duration]; }

void CAMediaTimingSetDuration( id<CAMediaTiming> ref, CFTimeInterval ti )
{ [ref setDuration:ti]; }

float CAMediaTimingSpeed( id<CAMediaTiming> ref )
{ return [ref speed]; }

void CAMediaTimingSetSpeed( id<CAMediaTiming> ref, float speed )
{ [ref setSpeed:speed]; }

// Playback modes
BOOL CAMediaTimingAutoreverses( id<CAMediaTiming> ref )
{ return [ref autoreverses]; }

void CAMediaTimingSetAutoreverses( id<CAMediaTiming> ref, BOOL flag )
{ [ref setAutoreverses:flag]; }

CFStringRef CAMediaTimingFillmode( id<CAMediaTiming> ref )// lowercase 'm' to avoid clash with var type
{ return (__bridge CFStringRef)[ref fillMode]; }

void CAMediaTimingSetFillMode( id<CAMediaTiming> ref, CFStringRef mode )
{ [ref setFillMode:(__bridge NSString *)mode]; }

