/*
 RotationGestureRecognizer.m

 Bernie Wylde
 */

#import "RotationGestureRecognizer.h"

/*
 Subclass
 */
@implementation CUI_RotationGestureRecognizer
@end

// Class
Class RotationGestureRecognizerClass( void )
{ return [NSRotationGestureRecognizer class]; }

// - init -
NSRotationGestureRecognizer *RotationGestureRecognizerInit( CUI_GestureRecognizerCallbackType callback, void *userData )
{
#if __has_feature(objc_arc)
    CUI_GestureRecognizerTarget *target = [[CUI_GestureRecognizerTarget alloc] initWithCallback:callback userData:userData];
    return [[NSRotationGestureRecognizer alloc] initWithTarget:target action:@selector(action:)];
#else
    CUI_GestureRecognizerTarget *target = [[[CUI_GestureRecognizerTarget alloc] initWithCallback:callback userData:userData] autorelease];
    return [[[NSRotationGestureRecognizer alloc] initWithTarget:target action:@selector(action:)] autorelease];
#endif
}

// - interpreting -
CGFloat RotationGestureRecognizerRotation( NSRotationGestureRecognizer *ref )
{ return [ref rotation]; }

void RotationGestureRecognizerSetRotation( NSRotationGestureRecognizer *ref, CGFloat rotation )
{ [ref setRotation:rotation]; }

CGFloat RotationGestureRecognizerRotationInDegrees( NSRotationGestureRecognizer *ref )
{ return [ref rotationInDegrees]; }

void RotationGestureRecognizerSetRotationDegrees( NSRotationGestureRecognizer *ref, CGFloat rotation )
{ [ref setRotationInDegrees:rotation]; }

