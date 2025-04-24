/*
 Animation.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

typedef void (*CUI_AnimationDelegateCallbackType)(NSInteger,NSAnimation*,void*);

#pragma mark - private
@interface CUI_AnimationDelegate : NSObject <NSAnimationDelegate>
@property (nonatomic,assign) CUI_AnimationDelegateCallbackType callback;
@property (nonatomic,assign) void *userData;
@property (nonatomic,assign) float progress;
@property (nonatomic,assign) float valueForProgress;
@property (nonatomic,assign) BOOL shouldStart;
@end

// delegate callback events
enum {
    animationDidEnd,
    animationDidStop,
    animationShouldStart,
    animationValueForProgress,
    animationDidReachProgressMark
};

#pragma mark - public

// Delegate callback functions
float AnimationDelegateProgress( NSAnimation *ref );
void AnimationDelegateSetValueForProgress( NSAnimation *ref, float value );
void AnimationDelegateSetShouldStart( NSAnimation *ref, BOOL flag );

// Class
Class AnimationClass( void );

// Init
NSAnimation *AnimationWithDuration( CFTimeInterval duration, NSAnimationCurve curve );

// Configure
NSAnimationBlockingMode AnimationBlockingMode( NSAnimation *ref );
void AnimationSetBlockingMode( NSAnimation *ref, NSAnimationBlockingMode mode );
CFArrayRef AnimationRunLoopModesForAnimating( NSAnimation *ref );
NSAnimationCurve AnimationCurve( NSAnimation *ref );
void AnimationSetCurve( NSAnimation *ref, NSAnimationCurve curve );
CFTimeInterval AnimationDuration( NSAnimation *ref );
void AnimationSetDuration( NSAnimation *ref, CFTimeInterval duration );
float AnimationFrameRate( NSAnimation *ref );
void AnimationSetFrameRate( NSAnimation *ref, float rate );

// Delegate
void AnimationSetDelegateCallback( NSAnimation *ref, CUI_AnimationDelegateCallbackType callback, void *userData );

// Controlling and monitoring
void AnimationStart( NSAnimation *ref );
void AnimationStop( NSAnimation *ref );
BOOL AnimationIsAnimating( NSAnimation *ref );
NSAnimationProgress AnimationCurrentProgress( NSAnimation *ref );
void AnimationSetCurrentProgress( NSAnimation *ref, NSAnimationProgress progress );
float AnimationCurrentValue( NSAnimation *ref );

// Progress marks
void AnimationAddProgressMark( NSAnimation *ref, NSAnimationProgress progressMark );
void AnimationRemoveProgressMark( NSAnimation *ref, NSAnimationProgress progressMark );
CFArrayRef AnimationProgressMarks( NSAnimation *ref );
void AnimationSetProgressMarks( NSAnimation *ref, CFArrayRef progressMarks );

// Linking animations
void AnimationStartWhenAnimationReachesProgress( NSAnimation *ref, NSAnimation *animation, NSAnimationProgress progress );
void AnimationStopWhenAnimationReachesProgress( NSAnimation *ref, NSAnimation *animation, NSAnimationProgress progress );
void AnimationClearStartAnimation( NSAnimation *ref );
void AnimationClearStopAnimation( NSAnimation *ref );


#pragma mark - ViewAnimation

// Init
NSViewAnimation *ViewAnimationWithAnimations( CFArrayRef animations );

// Dictionaries
CFArrayRef ViewAnimationAnimations( NSViewAnimation *ref );
void ViewAnimationSetAnimations( NSViewAnimation *ref, CFArrayRef animations );


#pragma mark - AnimatablePropertyContainer

// Animator
CFTypeRef AnimatablePropertyContainerAnimator( id<NSAnimatablePropertyContainer> ref );

// Managing animations
CFDictionaryRef AnimatablePropertyContainerAnimations( id<NSAnimatablePropertyContainer> ref );
void AnimatablePropertyContainerSetAnimations( id<NSAnimatablePropertyContainer> ref, CFDictionaryRef animations );
CFTypeRef AnimatablePropertyContainerAnimationForKey( id<NSAnimatablePropertyContainer> ref, CFStringRef key );
//CFTypeRef AnimatablePropertyContainerDefaultAnimationForKey( CFStringRef key );

#pragma mark - Convenience
void AffineTransformFlip( CGRect viewBounds );
