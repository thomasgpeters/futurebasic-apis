/*
 PressGestureRecognizer.m

 Bernie Wylde
 */

#import "PressGestureRecognizer.h"

/*
 Subclass
 */
@implementation CUI_PressGestureRecognizer
@end

// Class
Class PressGestureRecognizerClass( void )
{ return [NSPressGestureRecognizer class]; }

// - init -
NSPressGestureRecognizer *PressGestureRecognizerInit( CUI_GestureRecognizerCallbackType callback, void *userData )
{
#if __has_feature(objc_arc)
    CUI_GestureRecognizerTarget *target = [[CUI_GestureRecognizerTarget alloc] initWithCallback:callback userData:userData];
    return [[NSPressGestureRecognizer alloc] initWithTarget:target action:@selector(action:)];
#else
    CUI_GestureRecognizerTarget *target = [[[CUI_GestureRecognizerTarget alloc] initWithCallback:callback userData:userData] autorelease];
    return [[[NSPressGestureRecognizer alloc] initWithTarget:target action:@selector(action:)] autorelease];
#endif
}

// - configure -
NSUInteger PressGestureRecognizerButtonMask( NSPressGestureRecognizer *ref )
{ return [ref buttonMask]; }

void PressGestureRecognizerSetButtonMask( NSPressGestureRecognizer *ref, NSUInteger mask )
{ [ref setButtonMask:mask]; }

CFTimeInterval PressGestureRecognizerMinimumPressDuration( NSPressGestureRecognizer *ref )
{ return [ref minimumPressDuration]; }

void PressGestureRecognizerSetMinimumPressDuration( NSPressGestureRecognizer *ref, CFTimeInterval duration )
{ [ref setMinimumPressDuration:duration]; }

CGFloat PressGestureRecognizerAllowableMovement( NSPressGestureRecognizer *ref )
{ return [ref allowableMovement]; }

void PressGestureRecognizerSetAllowableMovement( NSPressGestureRecognizer *ref, CGFloat movement )
{ [ref setAllowableMovement:movement]; }

// - instance properties -
NSInteger PressGestureRecognizerNumberOfTouchesRequired( NSPressGestureRecognizer *ref )
{ return [ref numberOfTouchesRequired]; }

void PressGestureRecognizerSetNumberOfTouchesRequired( NSPressGestureRecognizer *ref, NSInteger touches )
{ [ref setNumberOfTouchesRequired:touches]; }

