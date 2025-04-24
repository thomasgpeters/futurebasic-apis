/*
 ClickGestureRecognizer.m

 Bernie Wylde
 */

#import "ClickGestureRecognizer.h"


/*
 Subclass
 */
@implementation CUI_ClickGestureRecognizer
@end

// Class
Class ClickGestureRecognizerClass( void )
{ return [NSClickGestureRecognizer class]; }

// - init -
NSClickGestureRecognizer *ClickGestureRecognizerInit( CUI_GestureRecognizerCallbackType callback, void *userData )
{
#if __has_feature(objc_arc)
    CUI_GestureRecognizerTarget *target = [[CUI_GestureRecognizerTarget alloc] initWithCallback:callback userData:userData];
    return [[NSClickGestureRecognizer alloc] initWithTarget:target action:@selector(action:)];
#else
    CUI_GestureRecognizerTarget *target = [[[CUI_GestureRecognizerTarget alloc] initWithCallback:callback userData:userData] autorelease];
    return [[[NSClickGestureRecognizer alloc] initWithTarget:target action:@selector(action:)] autorelease];
#endif
}

// - configure -
NSUInteger ClickGestureRecognizerButtonMask( NSClickGestureRecognizer *ref )
{ return [ref buttonMask]; }

void ClickGestureRecognizerSetButtonMask( NSClickGestureRecognizer *ref, NSUInteger mask )
{ [ref setButtonMask:mask]; }

NSInteger ClickGestureRecognizerNumberOfClicksRequired( NSClickGestureRecognizer *ref )
{ return [ref numberOfClicksRequired]; }

void ClickGestureRecognizerSetNumberOfClicksRequired( NSClickGestureRecognizer *ref, NSInteger clicks )
{ [ref setNumberOfClicksRequired:clicks]; }

// - instance properties -
NSInteger ClickGestureRecognizerNumberOfTouchesRequired( NSClickGestureRecognizer *ref )
{ return [ref numberOfTouchesRequired]; }

void ClickGestureRecognizerSetNumberOfTouchesRequired( NSClickGestureRecognizer *ref, NSInteger touches )
{ [ref setNumberOfTouchesRequired:touches]; }


