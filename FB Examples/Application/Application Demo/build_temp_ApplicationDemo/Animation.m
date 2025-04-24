/*
 Animation.m
 
 Bernie Wylde
 */

#import "Animation.h"

#pragma mark - private
@implementation CUI_AnimationDelegate

- (void)animationDidEnd:(NSAnimation *)animation {
    if ( self.callback ) (*self.callback)(animationDidEnd,animation,self.userData);
}

- (void)animationDidStop:(NSAnimation *)animation {
    if ( self.callback ) (*self.callback)(animationDidStop,animation,self.userData);
}

- (BOOL)animationShouldStart:(NSAnimation *)animation {
    self.shouldStart = YES;
    if ( self.callback ) (*self.callback)(animationShouldStart,animation,self.userData);
    return self.shouldStart;
}

- (float)animation:(NSAnimation *)animation valueForProgress:(NSAnimationProgress)inProgress {
    self.progress = inProgress;
    self.valueForProgress = [animation currentValue];
    if ( self.callback ) (*self.callback)(animationValueForProgress,animation,self.userData);
    return self.valueForProgress;
}

- (void)animation:(NSAnimation *)animation didReachProgressMark:(NSAnimationProgress)inProgress {
    self.progress = inProgress;
    if ( self.callback ) (*self.callback)(animationDidReachProgressMark,animation,self.userData);
}
@end


#pragma mark - public

// Delegate callback functions
float AnimationDelegateProgress( NSAnimation *ref )
{ return [(CUI_AnimationDelegate *)[ref delegate] progress]; }

void AnimationDelegateSetValueForProgress( NSAnimation *ref, float value )
{ [(CUI_AnimationDelegate *)[ref delegate] setValueForProgress:value]; }

void AnimationDelegateSetShouldStart( NSAnimation *ref, BOOL flag )
{ [(CUI_AnimationDelegate *)[ref delegate] setShouldStart:flag]; }


// Class
Class AnimationClass( void )
{ return [NSAnimation class]; }

// Init
NSAnimation *AnimationWithDuration( CFTimeInterval duration, NSAnimationCurve curve )
{
#if __has_feature(objc_arc)
    return [[NSAnimation alloc] initWithDuration:duration animationCurve:curve];
#else
    return [[[NSAnimation alloc] initWithDuration:duration animationCurve:curve] autorelease];
#endif
}

// Configure
NSAnimationBlockingMode AnimationBlockingMode( NSAnimation *ref )
{ return [ref animationBlockingMode]; }

void AnimationSetBlockingMode( NSAnimation *ref, NSAnimationBlockingMode mode )
{ [ref setAnimationBlockingMode:mode]; }

CFArrayRef AnimationRunLoopModesForAnimating( NSAnimation *ref )
{ return (__bridge CFArrayRef)[ref runLoopModesForAnimating]; }

NSAnimationCurve AnimationCurve( NSAnimation *ref )
{ return [ref animationCurve]; }

void AnimationSetCurve( NSAnimation *ref, NSAnimationCurve curve )
{ [ref setAnimationCurve:curve]; }

CFTimeInterval AnimationDuration( NSAnimation *ref )
{ return [ref duration]; }

void AnimationSetDuration( NSAnimation *ref, CFTimeInterval duration )
{ [ref setDuration:duration]; }

float AnimationFrameRate( NSAnimation *ref )
{ return [ref frameRate]; }

void AnimationSetFrameRate( NSAnimation *ref, float rate )
{ [ref setFrameRate:rate]; }

// Delegate
void AnimationSetDelegateCallback( NSAnimation *ref, CUI_AnimationDelegateCallbackType callback, void *userData )
{
#if __has_feature(objc_arc)
    CUI_AnimationDelegate *delegate = [[CUI_AnimationDelegate alloc] init];
#else
    CUI_AnimationDelegate *delegate = [[[CUI_AnimationDelegate alloc] init] autorelease];
#endif
    [delegate setCallback:callback];
    [delegate setUserData:userData];
    [ref setDelegate:delegate];
}

// Controlling and monitoring
void AnimationStart( NSAnimation *ref )
{ [ref startAnimation]; }

void AnimationStop( NSAnimation *ref )
{ [ref stopAnimation]; }

BOOL AnimationIsAnimating( NSAnimation *ref )
{ return [ref isAnimating]; }

NSAnimationProgress AnimationCurrentProgress( NSAnimation *ref )
{ return [ref currentProgress]; }

void AnimationSetCurrentProgress( NSAnimation *ref, NSAnimationProgress progress )
{ [ref setCurrentProgress:progress]; }

float AnimationCurrentValue( NSAnimation *ref )
{ return [ref currentValue]; }

// Progress marks
void AnimationAddProgressMark( NSAnimation *ref, NSAnimationProgress progressMark )
{ [ref addProgressMark:progressMark]; }

void AnimationRemoveProgressMark( NSAnimation *ref, NSAnimationProgress progressMark )
{ [ref removeProgressMark:progressMark]; }

CFArrayRef AnimationProgressMarks( NSAnimation *ref )
{ return (__bridge CFArrayRef)[ref progressMarks]; }

void AnimationSetProgressMarks( NSAnimation *ref, CFArrayRef progressMarks )
{ [ref setProgressMarks:(__bridge NSArray *)progressMarks]; }

// Linking animations
void AnimationStartWhenAnimationReachesProgress( NSAnimation *ref, NSAnimation *animation, NSAnimationProgress progress )
{ [ref startWhenAnimation:animation reachesProgress:progress]; }

void AnimationStopWhenAnimationReachesProgress( NSAnimation *ref, NSAnimation *animation, NSAnimationProgress progress )
{ [ref stopWhenAnimation:animation reachesProgress:progress]; }

void AnimationClearStartAnimation( NSAnimation *ref )
{ [ref clearStartAnimation]; }

void AnimationClearStopAnimation( NSAnimation *ref )
{ [ref clearStopAnimation]; }


#pragma mark - ViewAnimation

// Init
NSViewAnimation *ViewAnimationWithAnimations( CFArrayRef animations )
{
#if __has_feature(objc_arc)
    return [[NSViewAnimation alloc] initWithViewAnimations:(__bridge NSArray *)animations];
#else
    return [[[NSViewAnimation alloc] initWithViewAnimations:(__bridge NSArray *)animations] autorelease];
#endif
}

// Dictionaries
CFArrayRef ViewAnimationAnimations( NSViewAnimation *ref )
{ return (__bridge CFArrayRef)[ref viewAnimations]; }

void ViewAnimationSetAnimations( NSViewAnimation *ref, CFArrayRef animations )
{ [ref setViewAnimations:(__bridge NSArray *)animations]; }


#pragma mark - AnimatablePropertyContainer

// Animator
CFTypeRef AnimatablePropertyContainerAnimator( id<NSAnimatablePropertyContainer> ref )
{ return (__bridge CFTypeRef)[ref animator]; }

// Managing animations
CFDictionaryRef AnimatablePropertyContainerAnimations( id<NSAnimatablePropertyContainer> ref )
{ return (__bridge CFDictionaryRef)[ref animations]; }

void AnimatablePropertyContainerSetAnimations( id<NSAnimatablePropertyContainer> ref, CFDictionaryRef animations )
{ [ref setAnimations:(__bridge NSDictionary *)animations]; }

CFTypeRef AnimatablePropertyContainerAnimationForKey( id<NSAnimatablePropertyContainer> ref, CFStringRef key )
{ return (__bridge CFTypeRef)[ref animationForKey:(__bridge NSString *)key]; }

//CFTypeRef AnimatablePropertyContainerDefaultAnimationForKey( CFStringRef key )
//{ return (__bridge CFTypeRef)[id<NSAnimatablePropertyContainer> defaultAnimationForKey:(__bridge NSString *)key]; }

