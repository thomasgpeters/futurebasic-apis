/*
  CAAnimation.m

  Bernie Wylde 20180828
*/
#import "CAAnimation.h"

#pragma mark - private
// delegate
@implementation CUI_CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {
    (*self.callback)(caAnimationDidStart,anim,self.userData);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.finished = flag;
    (*self.callback)(caAnimationDidEnd,anim,self.userData);
}
@end

BOOL CAAnimationDelegateFinished( CAAnimation *ref )
{ return [(CUI_CAAnimationDelegate *)[ref delegate] finished]; }

#pragma mark - public
// Create
CAAnimation *CAAnimationInit( void )
{ return [CAAnimation animation]; }

// Attributes
BOOL CAAnimationIsRemovedOnCompletion( CAAnimation *ref )
{ return [ref isRemovedOnCompletion]; }

void CAAnimationSetRemovedOnCompletion( CAAnimation *ref, BOOL value )
{ [ref setRemovedOnCompletion:value]; }

CAMediaTimingFunction *CAAnimationTimingFunction( CAAnimation *ref )
{ return [ref timingFunction]; }

void CAAnimationSetTimingFunction( CAAnimation *ref, CAMediaTimingFunction *value )
{ [ref setTimingFunction:value]; }

// Default values
CFTypeRef CAAnimationDefaultValueForKey( CFStringRef key )
{ return (__bridge CFTypeRef)[CAAnimation defaultValueForKey:(__bridge NSString *)key]; }

// Delegate
void CAAnimationSetDelegateCallback( CAAnimation *ref, CUI_CAAnimationDelegateCallbackType callback, void *userData )
{
    CUI_CAAnimationDelegate *delegate = [[CUI_CAAnimationDelegate alloc] init];
    [delegate setCallback:callback];
    [delegate setUserData:userData];
    [ref setDelegate:delegate];
}

// Archiving
BOOL CAAnimationShouldArchiveValueForKey( CAAnimation *ref, CFStringRef key )
{ return [ref shouldArchiveValueForKey:(__bridge NSString *)key]; }

// SceneKit animation timing
//BOOL CAAnimationUsesSceneTimeBase( CAAnimation *ref )
//{ return [ref usesSceneTimeBase]; }
//
//void CAAnimationSetUsesSceneTimeBase( CAAnimation *ref, BOOL flag )
//{ [ref setUsesSceneTimeBase:flag]; }

// Fading between SceneKit animations
//CGFloat CAAnimationFadeInDuration( CAAnimation *ref )
//{ return [ref fadeInDuration]; }
//
//void CAAnimationSetFadeInDuration( CAAnimation *ref, CGFloat value )
//{ [ref setFadeInDuration:value]; }
//
//CGFloat CAAnimationFadeOutDuration( CAAnimation *ref )
//{ return [ref fadeOutDuration]; }
//
//void CAAnimationSetFadeOutDuration( CAAnimation *ref, CGFloat value )
//{ [ref setFadeOutDuration:value]; }

// SceneKit animation events
//CFArrayRef CAAnimationEvents( CAAnimation *ref )
//{ return (__bridge CFArrayRef)[ref animationEvents]; }
//
//void CAAnimationSetEvents( CAAnimation *ref, CFArrayRef events )
//{ [ref setAnimationEvents:(__bridge NSArray *)events]; }

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
CAFrameRateRange CAAnimationPreferredFrameRateRange( CAAnimation *ref )
{ return [ref preferredFrameRateRange]; }

API_AVAILABLE(macos(12.0))
void CAAnimationSetPreferredFrameRateRange( CAAnimation *ref, CAFrameRateRange range )
{ [ref setPreferredFrameRateRange:range]; }
#endif// 120000


/*
 CABasicAnimation.m
 */
// Create
CABasicAnimation *CABasicAnimationInit( void )
{ return [CABasicAnimation animation]; }

CABasicAnimation *CABasicAnimationWithKeyPath( CFStringRef path )
{ return [CABasicAnimation animationWithKeyPath:(__bridge NSString *)path]; }

// Interpolation values
CFTypeRef CABasicAnimationFromValue( CABasicAnimation *ref )
{ return (__bridge CFTypeRef)[ref fromValue]; }

void CABasicAnimationSetFromValue( CABasicAnimation *ref, CFTypeRef value )
{ [ref setFromValue:(__bridge id)value]; }

CFTypeRef CABasicAnimationToValue( CABasicAnimation *ref )
{ return (__bridge CFTypeRef)[ref toValue]; }

void CABasicAnimationSetToValue( CABasicAnimation *ref, CFTypeRef value )
{ [ref setToValue:(__bridge id)value]; }

CFTypeRef CABasicAnimationByValue( CABasicAnimation *ref )
{ return (__bridge CFTypeRef)[ref byValue]; }

void CABasicAnimationSetByValue( CABasicAnimation *ref, CFTypeRef value )
{ [ref setByValue:(__bridge id)value]; }


/*
 CAKeyframeAnimation.m
 */
// Create
CAKeyframeAnimation *CAKeyframeAnimationInit( void )
{ return [CAKeyframeAnimation animation]; }

CAKeyframeAnimation *CAKeyframeAnimationWithKeyPath( CFStringRef path )
{ return [CAKeyframeAnimation animationWithKeyPath:(__bridge NSString *)path]; }

// Values
CFArrayRef CAKeyframeAnimationValues( CAKeyframeAnimation *ref )
{ return (__bridge CFArrayRef)[ref values]; }

void CAKeyframeAnimationSetValues( CAKeyframeAnimation *ref, CFArrayRef value )
{ [ref setValues:(__bridge NSArray *)value]; }

CGPathRef CAKeyframeAnimationPath( CAKeyframeAnimation *ref )
{ return [ref path]; }

NSBezierPath *CAKeyframeAnimationBezierPath( CAKeyframeAnimation *ref )
{
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
    if ( @available( macOS 14.0, * ) ) {
        return [NSBezierPath bezierPathWithCGPath:[ref path]];
    } else {
        return CUI_BezierPathWithCGPath( [ref path] );
    }
#else
    return CUI_BezierPathWithCGPath( [ref path] );
#endif
    return nil;
}

//void CAKeyframeAnimationSetPath( CAKeyframeAnimation *ref, CGPathRef path )
//{ [ref setPath:path]; }

void CAKeyframeAnimationSetPath( CAKeyframeAnimation *ref, CFTypeRef path )
{
    if ( [(__bridge id)path isKindOfClass:[NSBezierPath class]] ) {
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
        if ( @available( macOS 14.0, * ) ) {
            [ref setPath:[(__bridge NSBezierPath *)path CGPath]];
        } else {
            CGPathRef cgPath = CUI_BezierPathCGPath( (__bridge NSBezierPath *)path );
            if ( cgPath ) [ref setPath:cgPath];
        }
#else
        CGPathRef cgPath = CUI_BezierPathCGPath( (__bridge NSBezierPath *)path );
        if ( cgPath ) [ref setPath:cgPath];
#endif// 140000
    } else {
        if ( CFGetTypeID(path) == CGPathGetTypeID() ) {
            [ref setPath:path];
        }
    }
}

// Timing
CFArrayRef CAKeyframeAnimationKeyTimes( CAKeyframeAnimation *ref )
{ return (__bridge CFArrayRef)[ref keyTimes]; }

void CAKeyframeAnimationSetKeyTimes( CAKeyframeAnimation *ref, CFArrayRef value )
{ [ref setKeyTimes:(__bridge NSArray *)value]; }

CFArrayRef CAKeyframeAnimationTimingFunctions( CAKeyframeAnimation *ref )
{ return (__bridge CFArrayRef)[ref timingFunctions]; }

void CAKeyframeAnimationSetTimingFunctions( CAKeyframeAnimation *ref, CFArrayRef value )
{ [ref setTimingFunctions:(__bridge NSArray *)value]; }

CFStringRef CAKeyframeAnimationCalculationMode( CAKeyframeAnimation *ref )
{ return (__bridge CFStringRef)[ref calculationMode]; }

void CAKeyframeAnimationSetCalculationMode( CAKeyframeAnimation *ref, CFStringRef value )
{ [ref setCalculationMode:(__bridge NSString *)value]; }

// Rotation mode
CFStringRef CAKeyframeAnimationRotationMode( CAKeyframeAnimation *ref )
{ return (__bridge CFStringRef)[ref rotationMode]; }

void CAKeyframeAnimationSetRotationMode( CAKeyframeAnimation *ref, CFStringRef value )
{ [ref setRotationMode:(__bridge NSString *)value]; }

// Cubic mode
CFArrayRef CAKeyframeAnimationTensionValues( CAKeyframeAnimation *ref )
{ return (__bridge CFArrayRef)[ref tensionValues]; }

void CAKeyframeAnimationSetTensionValues( CAKeyframeAnimation *ref, CFArrayRef value )
{ [ref setTensionValues:(__bridge NSArray *)value]; }

CFArrayRef CAKeyframeAnimationContinuityValues( CAKeyframeAnimation *ref )
{ return (__bridge CFArrayRef)[ref continuityValues]; }

void CAKeyframeAnimationSetContinuityValues( CAKeyframeAnimation *ref, CFArrayRef value )
{ [ref setContinuityValues:(__bridge NSArray *)value]; }

CFArrayRef CAKeyframeAnimationBiasValues( CAKeyframeAnimation *ref )
{ return (__bridge CFArrayRef)[ref biasValues]; }

void CAKeyframeAnimationSetBiasValues( CAKeyframeAnimation *ref, CFArrayRef value )
{ [ref setBiasValues:(__bridge NSArray *)value]; }

/*
 CAPropertyAnimation.m
 */
// Create
CAPropertyAnimation *CAPropertyAnimationInit( void )
{ return [CAPropertyAnimation animation]; }

CAPropertyAnimation *CAPropertyAnimationWithKeyPath( CFStringRef path )
{ return [CAPropertyAnimation animationWithKeyPath:(__bridge NSString *)path]; }

// Key path
CFStringRef CAPropertyAnimationKeyPath( CAPropertyAnimation *ref )
{ return (__bridge CFStringRef)[ref keyPath]; }

void CAPropertyAnimationSetKeyPath( CAPropertyAnimation *ref, CFStringRef value )
{ [ref setKeyPath:(__bridge NSString *)value]; }

// Property value calculation behavior
BOOL CAPropertyAnimationIsCumulative( CAPropertyAnimation *ref )
{ return [ref isCumulative]; }

void CAPropertyAnimationSetCumulative( CAPropertyAnimation *ref, BOOL value )
{ [ref setCumulative:value]; }

BOOL CAPropertyAnimationIsAdditive( CAPropertyAnimation *ref )
{ return [ref isAdditive]; }

void CAPropertyAnimationSetAdditive( CAPropertyAnimation *ref, BOOL value )
{ [ref setAdditive:value]; }

CAValueFunction *CAPropertyAnimationValueFunction( CAPropertyAnimation *ref )
{ return [ref valueFunction]; }

void CAPropertyAnimationSetValueFunction( CAPropertyAnimation *ref, CAValueFunctionRef value )
{ [ref setValueFunction:value]; }

/*
 CASpringAnimation.m
 */
// Create
CASpringAnimation *CASpringAnimationInit( void )
{ return [CASpringAnimation animation]; }

CASpringAnimation *CASpringAnimationWithKeyPath( CFStringRef path )
{ return [CASpringAnimation animationWithKeyPath:(__bridge NSString *)path]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
CASpringAnimation *CASpringAnimationWithPerceptualDuration( CFTimeInterval duration, CGFloat bounce )
{
#if __has_feature(objc_arc)
    return [[CASpringAnimation alloc] initWithPerceptualDuration:duration bounce:bounce];
#else
    return [[[CASpringAnimation alloc] initWithPerceptualDuration:duration bounce:bounce] autorelease];
#endif
}
#endif// 140000

// Attributes
CGFloat CASpringAnimationDamping( CASpringAnimation *ref )
{ return [ref damping]; }

void CASpringAnimationSetDamping( CASpringAnimation *ref, CGFloat value )
{ [ref setDamping:value]; }

CGFloat CASpringAnimationInitialVelocity( CASpringAnimation *ref )
{ return [ref initialVelocity]; }

void CASpringAnimationSetInitialVelocity( CASpringAnimation *ref, CGFloat value )
{ [ref setInitialVelocity:value]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
BOOL CASpringAnimationAllowsOverdamping( CASpringAnimationRef ref )
{ return [ref allowsOverdamping]; }

void CASpringAnimationSetAllowsOverdamping( CASpringAnimationRef ref, BOOL flag )
{ [ref setAllowsOverdamping:flag]; }

CFTimeInterval CASpringAnimationPerceptualDuration( CASpringAnimationRef ref )
{ return [ref perceptualDuration]; }

CGFloat CASpringAnimationBounce( CASpringAnimationRef ref )
{ return [ref bounce]; }
#endif// 140000

CGFloat CASpringAnimationMass( CASpringAnimation *ref )
{ return [ref mass]; }

void CASpringAnimationSetMass( CASpringAnimation *ref, CGFloat value )
{ [ref setMass:value]; }

CFTimeInterval CASpringAnimationSettlingDuration( CASpringAnimation *ref )
{ return [ref settlingDuration]; }

CGFloat CASpringAnimationStiffness( CASpringAnimation *ref )
{ return [ref stiffness]; }

void CASpringAnimationSetStiffness( CASpringAnimation *ref, CGFloat value )
{ [ref setStiffness:value]; }

/*
 CATransition
 */
// Create
CATransition *CATransitionAnimation( void )
{ return [CATransition animation]; }

// Start and end point
float CATransitionStartProgress( CATransition *ref )
{ return [ref startProgress]; }

void CATransitionSetStartProgress( CATransition *ref, float value )
{ [ref setStartProgress:value]; }

float CATransitionEndProgress( CATransition *ref )
{ return [ref endProgress]; }

void CATransitionSetEndProgress( CATransition *ref, float value )
{ [ref setEndProgress:value]; }

// Properties
CFStringRef CATransitiontype( CATransition *ref )// lowercase 't' to avoid clash with var type
{ return (__bridge CFStringRef)[ref type]; }

void CATransitionSetType( CATransition *ref, CFStringRef type )
{ [ref setType:(__bridge NSString *)type]; }

CFStringRef CATransitionsubtype( CATransition *ref )// lowercase 's' to avoid clash with var type
{ return (__bridge CFStringRef)[ref subtype]; }

void CATransitionSetSubtype( CATransition *ref, CFStringRef subtype )
{ [ref setSubtype:(__bridge NSString *)subtype]; }

// Filter
CFTypeRef CATransitionFilter( CATransition *ref )
{ return (__bridge CFTypeRef)[ref filter]; }

void CATransitionSetFilter( CATransition *ref, CFTypeRef filter )
{ [ref setFilter:(__bridge id)filter]; }


/*
  CAAnimationGroup
*/
// Create
CAAnimationGroup *CAAnimationGroupInit( void )
{ return [CAAnimationGroup animation]; }

// Animations
CFArrayRef CAAnimationGroupAnimations( CAAnimationGroup *ref )
{ return (__bridge CFArrayRef)[ref animations]; }

void CAAnimationGroupSetAnimations( CAAnimationGroup *ref, CFArrayRef animations )
{ [ref setAnimations:(__bridge NSArray *)animations]; }

