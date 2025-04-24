/*
 CADisplayLink.m
 
 Bernie Wylde
 */

#import "CADisplayLink.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000

// Schedule notifications
void CADisplayLinkAddToRunLoop( CADisplayLink *ref, NSRunLoop *runLoop, NSRunLoopMode mode )
{ [ref addToRunLoop:runLoop forMode:mode]; }

void CADisplayLinkRemoveFromRunLoop( CADisplayLink *ref, NSRunLoop *runLoop, NSRunLoopMode mode )
{ [ref removeFromRunLoop:runLoop forMode:mode]; }

void CADisplayLinkInvalidate( CADisplayLink *ref )
{ [ref invalidate]; }

// Configure
CFTimeInterval CADisplayLinkDuration( CADisplayLink *ref )
{ return [ref duration]; }

BOOL CADisplayLinkIsPaused( CADisplayLink *ref )
{ return [ref isPaused]; }

void CADisplayLinkSetPaused( CADisplayLink *ref, BOOL flag )
{ [ref setPaused:flag]; }

CFTimeInterval CADisplayLinkTimestamp( CADisplayLink *ref )
{ return [ref timestamp]; }

CFTimeInterval CADisplayLinkTargetTimestamp( CADisplayLink *ref )
{ return [ref targetTimestamp]; }

// Instance properties
CAFrameRateRange CADisplayLinkPreferredFrameRateRange( CADisplayLink *ref )
{ return [ref preferredFrameRateRange]; }

void CADisplayLinkSetPreferredFrameRateRange( CADisplayLink *ref, CAFrameRateRange range )
{ [ref setPreferredFrameRateRange:range]; }

#endif// 140000
