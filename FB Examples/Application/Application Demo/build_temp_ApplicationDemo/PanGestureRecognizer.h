/*
 PanGestureRecognizer.h

 Bernie Wylde
 */

#import "CocoaUI.h"

/*
 Subclass
 */
@interface CUI_PanGestureRecognizer : NSPanGestureRecognizer
@end

// Class
Class PanGestureRecognizerClass( void );

// - init -
NSPanGestureRecognizer *PanGestureRecognizerInit( CUI_GestureRecognizerCallbackType callback, void *userData );

// - configure -
NSUInteger PanGestureRecognizerButtonMask( NSPanGestureRecognizer *ref );
void PanGestureRecognizerSetButtonMask( NSPanGestureRecognizer *ref, NSUInteger mask );

// - tracking location and velocity -
CGPoint PanGestureRecognizerTranslationInView( NSPanGestureRecognizer *ref, NSInteger tag );
void PanGestureRecognizerSetTranslationInView( NSPanGestureRecognizer *ref, CGPoint translation, NSInteger tag );
CGPoint PanGestureRecognizerVelocityInView( NSPanGestureRecognizer *ref, NSInteger tag );

// - instance properties -
NSInteger PanGestureRecognizerNumberOfTouchesRequired( NSPanGestureRecognizer *ref );
void PanGestureRecognizerSetNumberOfTouchesRequired( NSPanGestureRecognizer *ref, NSInteger touches );


