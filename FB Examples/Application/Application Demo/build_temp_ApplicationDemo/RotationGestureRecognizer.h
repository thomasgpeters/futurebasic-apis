/*
 RotationGestureRecognizer.h

 Bernie Wylde
 */

#import "CocoaUI.h"

/*
 Subclass
 */
@interface CUI_RotationGestureRecognizer : NSRotationGestureRecognizer
@end

// Class
Class RotationGestureRecognizerClass( void );

// - init -
NSRotationGestureRecognizer *RotationGestureRecognizerInit( CUI_GestureRecognizerCallbackType callback, void *userData );

// - interpreting -
CGFloat RotationGestureRecognizerRotation( NSRotationGestureRecognizer *ref );
void RotationGestureRecognizerSetRotation( NSRotationGestureRecognizer *ref, CGFloat rotation );
CGFloat RotationGestureRecognizerRotationInDegrees( NSRotationGestureRecognizer *ref );
void RotationGestureRecognizerSetRotationDegrees( NSRotationGestureRecognizer *ref, CGFloat rotation );


