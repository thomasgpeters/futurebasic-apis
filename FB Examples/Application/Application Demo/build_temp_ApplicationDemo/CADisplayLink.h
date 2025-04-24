/*
 CADisplayLink.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000

// Schedule notifications
API_AVAILABLE(macos(14.0))
void CADisplayLinkAddToRunLoop( CADisplayLink *ref, NSRunLoop *runLoop, NSRunLoopMode mode );
API_AVAILABLE(macos(14.0))
void CADisplayLinkRemoveFromRunLoop( CADisplayLink *ref, NSRunLoop *runLoop, NSRunLoopMode mode );
API_AVAILABLE(macos(14.0))
void CADisplayLinkInvalidate( CADisplayLink *ref );

// Configure
API_AVAILABLE(macos(14.0))
CFTimeInterval CADisplayLinkDuration( CADisplayLink *ref );
API_AVAILABLE(macos(14.0))
BOOL CADisplayLinkIsPaused( CADisplayLink *ref );
API_AVAILABLE(macos(14.0))
void CADisplayLinkSetPaused( CADisplayLink *ref, BOOL flag );
API_AVAILABLE(macos(14.0))
CFTimeInterval CADisplayLinkTimestamp( CADisplayLink *ref );
API_AVAILABLE(macos(14.0))
CFTimeInterval CADisplayLinkTargetTimestamp( CADisplayLink *ref );

// Instance properties
API_AVAILABLE(macos(14.0))
CAFrameRateRange CADisplayLinkPreferredFrameRateRange( CADisplayLink *ref );
API_AVAILABLE(macos(14.0))
void CADisplayLinkSetPreferredFrameRateRange( CADisplayLink *ref, CAFrameRateRange range );

#endif// 140000
