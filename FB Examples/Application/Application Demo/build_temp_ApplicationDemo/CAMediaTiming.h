/*
  CAMediaTiming.h

  Bernie Wylde 20180828
*/

#import "CocoaUI.h"

// Animation start time
CFTimeInterval CAMediaTimingBeginTime( id<CAMediaTiming> ref );
void CAMediaTimingSetBeginTime( id<CAMediaTiming> ref, CFTimeInterval ti );
CFTimeInterval CAMediaTimingTimeOffset( id<CAMediaTiming> ref );
void CAMediaTimingSetTimeOffset( id<CAMediaTiming> ref, CFTimeInterval ti );

// Repeating animations
float CAMediaTimingRepeatCount( id<CAMediaTiming> ref );
void CAMediaTimingSetRepeatCount( id<CAMediaTiming> ref, float count );
CFTimeInterval CAMediaTimingRepeatDuration( id<CAMediaTiming> ref );
void CAMediaTimingSetRepeatDuration( id<CAMediaTiming> ref, CFTimeInterval ti );

// Duration and speed
CFTimeInterval CAMediaTimingDuration( id<CAMediaTiming> ref );
void CAMediaTimingSetDuration( id<CAMediaTiming> ref, CFTimeInterval ti );
float CAMediaTimingSpeed( id<CAMediaTiming> ref );
void CAMediaTimingSetSpeed( id<CAMediaTiming> ref, float speed );

// Playback modes
BOOL CAMediaTimingAutoreverses( id<CAMediaTiming> ref );
void CAMediaTimingSetAutoreverses( id<CAMediaTiming> ref, BOOL flag );
CFStringRef CAMediaTimingFillmode( id<CAMediaTiming> ref );// lowercase 'm' to avoid clash with var type
void CAMediaTimingSetFillMode( id<CAMediaTiming> ref, CFStringRef mode );
