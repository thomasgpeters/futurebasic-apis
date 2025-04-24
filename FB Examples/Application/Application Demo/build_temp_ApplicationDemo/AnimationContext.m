/*
 AnimationContext.m
 
 Bernie Wylde
 */

#import "AnimationContext.h"

// Class
Class AnimationContextClass( void )
{ return [NSAnimationContext class]; }

// Grouping
void AnimationContextBeginGrouping( void )
{ [NSAnimationContext beginGrouping]; }

void AnimationContextEndGrouping( void )
{ [NSAnimationContext endGrouping]; }

// Current context
NSAnimationContext *AnimationContextCurrent( void )
{ return [NSAnimationContext currentContext]; }

// Completion handler
void AnimationContextRunAnimationGroupWithHandler( CUI_AnimationContextCallbackType changesCallback, void *changesUserData, CUI_AnimationContextCompletionHandlerType completionHandler, void *completionHandlerUserData )
{
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        (*changesCallback)(context,changesUserData);
      } completionHandler:^{
          (*completionHandler)(completionHandlerUserData);
      }];
}

// Duration
CFTimeInterval AnimationContextDuration( NSAnimationContext *ref )
{ return [ref duration]; }

void AnimationContextSetDuration( NSAnimationContext *ref, CFTimeInterval duration )
{ [ref setDuration:duration]; }

CAMediaTimingFunction *AnimationContextTimingFunction( NSAnimationContext *ref )
{ return [ref timingFunction]; }

void AnimationContextSetTimingFunction( NSAnimationContext *ref, CAMediaTimingFunction *timingFunction )
{ [ref setTimingFunction:timingFunction]; }

// Implicit animation
BOOL AnimationContextAllowsImplicitAnimation( NSAnimationContext *ref )
{ return [ref allowsImplicitAnimation]; }

void AnimationContextSetAllowsImplicitAnimation( NSAnimationContext *ref, BOOL flag )
{ [ref setAllowsImplicitAnimation:flag]; }

// Type methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
void AnimationContextRunAnimationGroup( CUI_AnimationContextCallbackType changesCallback, void *userData )
{
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        (*changesCallback)(context,userData);
    }];
}
#endif// 101400

