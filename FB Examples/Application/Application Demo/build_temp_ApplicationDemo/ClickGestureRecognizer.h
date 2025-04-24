/*
 ClickGestureRecognizer.h

 Bernie Wylde
 */


#import "CocoaUI.h"


/*
 Subclass
 */
@interface CUI_ClickGestureRecognizer : NSClickGestureRecognizer
@end

// Class
Class ClickGestureRecognizerClass( void );

// - init -
NSClickGestureRecognizer *ClickGestureRecognizerInit( CUI_GestureRecognizerCallbackType callback, void *userData );

// - configure -
NSUInteger ClickGestureRecognizerButtonMask( NSClickGestureRecognizer *ref );
void ClickGestureRecognizerSetButtonMask( NSClickGestureRecognizer *ref, NSUInteger mask );
NSInteger ClickGestureRecognizerNumberOfClicksRequired( NSClickGestureRecognizer *ref );
void ClickGestureRecognizerSetNumberOfClicksRequired( NSClickGestureRecognizer *ref, NSInteger clicks );

// - instance properties -
NSInteger ClickGestureRecognizerNumberOfTouchesRequired( NSClickGestureRecognizer *ref );
void ClickGestureRecognizerSetNumberOfTouchesRequired( NSClickGestureRecognizer *ref, NSInteger touches );

