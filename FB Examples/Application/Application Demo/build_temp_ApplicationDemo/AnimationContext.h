/*
 AnimationContext.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

typedef void (*CUI_AnimationContextCallbackType)(NSAnimationContext*,void*);
typedef void (*CUI_AnimationContextCompletionHandlerType)(void*);

// Class
Class AnimationContextClass( void );

// Grouping
void AnimationContextBeginGrouping( void );
void AnimationContextEndGrouping( void );

// Current context
NSAnimationContext *AnimationContextCurrent( void );

// Completion handler
void AnimationContextRunAnimationGroupWithHandler( CUI_AnimationContextCallbackType changesCallback, void *changesUserData, CUI_AnimationContextCompletionHandlerType completionHandler, void *completionHandlerUserData );

// Duration
CFTimeInterval AnimationContextDuration( NSAnimationContext *ref );
void AnimationContextSetDuration( NSAnimationContext *ref, CFTimeInterval duration );
CAMediaTimingFunction *AnimationContextTimingFunction( NSAnimationContext *ref );
void AnimationContextSetTimingFunction( NSAnimationContext *ref, CAMediaTimingFunction *timingFunction );

// Implicit animation
BOOL AnimationContextAllowsImplicitAnimation( NSAnimationContext *ref );
void AnimationContextSetAllowsImplicitAnimation( NSAnimationContext *ref, BOOL flag );

// Type methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
void AnimationContextRunAnimationGroup( CUI_AnimationContextCallbackType changesCallback, void *userData );
#endif// 101400

