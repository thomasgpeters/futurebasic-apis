/*
 PressGestureRecognizer.h

 Bernie Wylde
 */


#import "CocoaUI.h"


/*
 Subclass
 */
@interface CUI_PressGestureRecognizer : NSPressGestureRecognizer
@end

// Class
Class PressGestureRecognizerClass( void );

// - init -
NSPressGestureRecognizer *PressGestureRecognizerInit( CUI_GestureRecognizerCallbackType callback, void *userData );

// - configure -
NSUInteger PressGestureRecognizerButtonMask( NSPressGestureRecognizer *ref );
void PressGestureRecognizerSetButtonMask( NSPressGestureRecognizer *ref, NSUInteger mask );
CFTimeInterval PressGestureRecognizerMinimumPressDuration( NSPressGestureRecognizer *ref );
void PressGestureRecognizerSetMinimumPressDuration( NSPressGestureRecognizer *ref, CFTimeInterval duration );
CGFloat PressGestureRecognizerAllowableMovement( NSPressGestureRecognizer *ref );
void PressGestureRecognizerSetAllowableMovement( NSPressGestureRecognizer *ref, CGFloat movement );

// - instance properties -
NSInteger PressGestureRecognizerNumberOfTouchesRequired( NSPressGestureRecognizer *ref );
void PressGestureRecognizerSetNumberOfTouchesRequired( NSPressGestureRecognizer *ref, NSInteger touches );

