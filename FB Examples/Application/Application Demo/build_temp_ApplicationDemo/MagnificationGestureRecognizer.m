/*
 MagnificationGestureRecognizer.m

 Bernie Wylde
 */

#import "MagnificationGestureRecognizer.h"

/*
 Subclass
 */
@implementation CUI_MagnificationGestureRecognizer
@end

// Class
Class MagnificationGestureRecognizerClass( void )
{ return [NSMagnificationGestureRecognizer class]; }

// - init -
NSMagnificationGestureRecognizer *MagnificationGestureRecognizerInit( CUI_GestureRecognizerCallbackType callback, void *userData )
{
#if __has_feature(objc_arc)
    CUI_GestureRecognizerTarget *target = [[CUI_GestureRecognizerTarget alloc] initWithCallback:callback userData:userData];
    return [[NSMagnificationGestureRecognizer alloc] initWithTarget:target action:@selector(action:)];
#else
    CUI_GestureRecognizerTarget *target = [[[CUI_GestureRecognizerTarget alloc] initWithCallback:callback userData:userData] autorelease];
    return [[[NSMagnificationGestureRecognizer alloc] initWithTarget:target action:@selector(action:)] autorelease];
#endif
}

// - magnification factor -
CGFloat MagnificationGestureRecognizerMagnification( NSMagnificationGestureRecognizer *ref )
{ return [ref magnification]; }

void MagnificationGestureRecognizerSetMagnification( NSMagnificationGestureRecognizer *ref, CGFloat magnification )
{ [ref setMagnification:magnification]; }

