/*
  CAAnimation.h

  Bernie Wylde 20180828
*/

#import "CocoaUI.h"

#pragma mark - private
// delegate
typedef void (*CUI_CAAnimationDelegateCallbackType)(NSInteger,CAAnimation*,void*);

@interface CUI_CAAnimationDelegate : NSObject <CAAnimationDelegate>
@property (nonatomic,assign) CUI_CAAnimationDelegateCallbackType callback;
@property (nonatomic,assign) void *userData;
@property (nonatomic,assign) BOOL finished;
@end

// callback events
enum {
    caAnimationDidStart,
    caAnimationDidEnd
};

BOOL CAAnimationDelegateFinished( CAAnimation *ref );


#pragma mark - public
// Create
CAAnimation *CAAnimationInit( void );

// Attributes
BOOL CAAnimationIsRemovedOnCompletion( CAAnimation *ref );
void CAAnimationSetRemovedOnCompletion( CAAnimation *ref, BOOL value );
CAMediaTimingFunction *CAAnimationTimingFunction( CAAnimation *ref );
void CAAnimationSetTimingFunction( CAAnimation *ref, CAMediaTimingFunction *value );

// Default values
CFTypeRef CAAnimationDefaultValueForKey( CFStringRef key );

// Delegate
void CAAnimationSetDelegateCallback( CAAnimation *ref, CUI_CAAnimationDelegateCallbackType callback, void *userData );

// Archiving
BOOL CAAnimationShouldArchiveValueForKey( CAAnimation *ref, CFStringRef key );

// SceneKit animation timing
//BOOL CAAnimationUsesSceneTimeBase( CAAnimation *ref );
//void CAAnimationSetUsesSceneTimeBase( CAAnimation *ref, BOOL flag );

// Fading between SceneKit animations
//CGFloat CAAnimationFadeInDuration( CAAnimation *ref );
//void CAAnimationSetFadeInDuration( CAAnimation *ref, CGFloat value );
//CGFloat CAAnimationFadeOutDuration( CAAnimation *ref );
//void CAAnimationSetFadeOutDuration( CAAnimation *ref, CGFloat value );

// SceneKit animation events
//CFArrayRef CAAnimationEvents( CAAnimation *ref );
//void CAAnimationSetEvents( CAAnimation *ref, CFArrayRef events );

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
CAFrameRateRange CAAnimationPreferredFrameRateRange( CAAnimation *ref );
API_AVAILABLE(macos(12.0))
void CAAnimationSetPreferredFrameRateRange( CAAnimation *ref, CAFrameRateRange range );
#endif// 120000


#pragma mark - CABasicAnimation
// Create
CABasicAnimation *CABasicAnimationInit( void );
CABasicAnimation *CABasicAnimationWithKeyPath( CFStringRef path );

// Interpolation values
CFTypeRef CABasicAnimationFromValue( CABasicAnimation *ref );
void CABasicAnimationSetFromValue( CABasicAnimation *ref, CFTypeRef value );
CFTypeRef CABasicAnimationToValue( CABasicAnimation *ref );
void CABasicAnimationSetToValue( CABasicAnimation *ref, CFTypeRef value );
CFTypeRef CABasicAnimationByValue( CABasicAnimation *ref );
void CABasicAnimationSetByValue( CABasicAnimation *ref, CFTypeRef value );


#pragma mark - CAKeyframeAnimation
// Create
CAKeyframeAnimation *CAKeyframeAnimationInit( void );
CAKeyframeAnimation *CAKeyframeAnimationWithKeyPath( CFStringRef path );

// Values
CFArrayRef CAKeyframeAnimationValues( CAKeyframeAnimation *ref );
void CAKeyframeAnimationSetValues( CAKeyframeAnimation *ref, CFArrayRef value );
CGPathRef CAKeyframeAnimationPath( CAKeyframeAnimation *ref );
NSBezierPath *CAKeyframeAnimationBezierPath( CAKeyframeAnimation *ref );
//void CAKeyframeAnimationSetPath( CAKeyframeAnimation *ref, CGPathRef path );
void CAKeyframeAnimationSetPath( CAKeyframeAnimation *ref, CFTypeRef path );

// Timing
CFArrayRef CAKeyframeAnimationKeyTimes( CAKeyframeAnimation *ref );
void CAKeyframeAnimationSetKeyTimes( CAKeyframeAnimation *ref, CFArrayRef value );
CFArrayRef CAKeyframeAnimationTimingFunctions( CAKeyframeAnimation *ref );
void CAKeyframeAnimationSetTimingFunctions( CAKeyframeAnimation *ref, CFArrayRef value );
CFStringRef CAKeyframeAnimationCalculationMode( CAKeyframeAnimation *ref );
void CAKeyframeAnimationSetCalculationMode( CAKeyframeAnimation *ref, CFStringRef value );

// Rotation mode
CFStringRef CAKeyframeAnimationRotationMode( CAKeyframeAnimation *ref );
void CAKeyframeAnimationSetRotationMode( CAKeyframeAnimation *ref, CFStringRef value );

// Cubic mode
CFArrayRef CAKeyframeAnimationTensionValues( CAKeyframeAnimation *ref );
void CAKeyframeAnimationSetTensionValues( CAKeyframeAnimation *ref, CFArrayRef value );
CFArrayRef CAKeyframeAnimationContinuityValues( CAKeyframeAnimation *ref );
void CAKeyframeAnimationSetContinuityValues( CAKeyframeAnimation *ref, CFArrayRef value );
CFArrayRef CAKeyframeAnimationBiasValues( CAKeyframeAnimation *ref );
void CAKeyframeAnimationSetBiasValues( CAKeyframeAnimation *ref, CFArrayRef value );


#pragma mark - CAPropertyAnimation
// Create
CAPropertyAnimation *CAPropertyAnimationInit( void );
CAPropertyAnimation *CAPropertyAnimationWithKeyPath( CFStringRef path );

// Key path
CFStringRef CAPropertyAnimationKeyPath( CAPropertyAnimation *ref );
void CAPropertyAnimationSetKeyPath( CAPropertyAnimation *ref, CFStringRef value );

// Property value calculation behavior
BOOL CAPropertyAnimationIsCumulative( CAPropertyAnimation *ref );
void CAPropertyAnimationSetCumulative( CAPropertyAnimation *ref, BOOL value );
BOOL CAPropertyAnimationIsAdditive( CAPropertyAnimation *ref );
void CAPropertyAnimationSetAdditive( CAPropertyAnimation *ref, BOOL value );
CAValueFunction *CAPropertyAnimationValueFunction( CAPropertyAnimation *ref );
void CAPropertyAnimationSetValueFunction( CAPropertyAnimation *ref, CAValueFunctionRef value );


#pragma mark - CASpringAnimation
// Create
CASpringAnimation *CASpringAnimationInit( void );
CASpringAnimation *CASpringAnimationWithKeyPath( CFStringRef path );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
CASpringAnimation *CASpringAnimationWithPerceptualDuration( CFTimeInterval duration, CGFloat bounce );
#endif// 140000

// Attributes
CGFloat CASpringAnimationDamping( CASpringAnimation *ref );
void CASpringAnimationSetDamping( CASpringAnimation *ref, CGFloat value );
CGFloat CASpringAnimationInitialVelocity( CASpringAnimation *ref );
void CASpringAnimationSetInitialVelocity( CASpringAnimation *ref, CGFloat value );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
BOOL CASpringAnimationAllowsOverdamping( CASpringAnimationRef ref );
API_AVAILABLE(macos(14.0))
void CASpringAnimationSetAllowsOverdamping( CASpringAnimationRef ref, BOOL flag );
API_AVAILABLE(macos(14.0))
CFTimeInterval CASpringAnimationPerceptualDuration( CASpringAnimationRef ref );
API_AVAILABLE(macos(14.0))
CGFloat CASpringAnimationBounce( CASpringAnimationRef ref );
#endif// 140000
CGFloat CASpringAnimationMass( CASpringAnimation *ref );
void CASpringAnimationSetMass( CASpringAnimation *ref, CGFloat value );
CFTimeInterval CASpringAnimationSettlingDuration( CASpringAnimation *ref );
CGFloat CASpringAnimationStiffness( CASpringAnimation *ref );
void CASpringAnimationSetStiffness( CASpringAnimation *ref, CGFloat value );


#pragma mark - CATransition
// Create
CATransition *CATransitionAnimation( void );

// Start and end point
float CATransitionStartProgress( CATransition *ref );
void CATransitionSetStartProgress( CATransition *ref, float value );
float CATransitionEndProgress( CATransition *ref );
void CATransitionSetEndProgress( CATransition *ref, float value );

// Properties
CFStringRef CATransitiontype( CATransition *ref );// lowercase 't' to avoid clash with var type
void CATransitionSetType( CATransition *ref, CFStringRef type );
CFStringRef CATransitionsubtype( CATransition *ref );// lowercase 's' to avoid clash with var type
void CATransitionSetSubtype( CATransition *ref, CFStringRef subtype );

// Filter
CFTypeRef CATransitionFilter( CATransition *ref );
void CATransitionSetFilter( CATransition *ref, CFTypeRef filter );


#pragma mark - CAAnimationGroup
// Create
CAAnimationGroup *CAAnimationGroupInit( void );

// Animations
CFArrayRef CAAnimationGroupAnimations( CAAnimationGroup *ref );
void CAAnimationGroupSetAnimations( CAAnimationGroup *ref, CFArrayRef animations );

