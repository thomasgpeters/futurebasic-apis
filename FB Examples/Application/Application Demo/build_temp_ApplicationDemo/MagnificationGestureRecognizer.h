/*
 MagnificationGestureRecognizer.h

 Bernie Wylde
 */

#import "CocoaUI.h"

/*
 Subclass
 */
@interface CUI_MagnificationGestureRecognizer : NSMagnificationGestureRecognizer
@end

// Class
Class MagnificationGestureRecognizerClass( void );

// - init -
NSMagnificationGestureRecognizer *MagnificationGestureRecognizerInit( CUI_GestureRecognizerCallbackType  callback, void *userData );

// - magnification factor -
CGFloat MagnificationGestureRecognizerMagnification( NSMagnificationGestureRecognizer *ref );
void MagnificationGestureRecognizerSetMagnification( NSMagnificationGestureRecognizer *ref, CGFloat magnification );

