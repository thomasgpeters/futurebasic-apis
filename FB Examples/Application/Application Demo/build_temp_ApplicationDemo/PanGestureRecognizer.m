/*
 PanGestureRecognizer.m

 Bernie Wylde
 */

#import "PanGestureRecognizer.h"


/*
 Subclass
 */
@implementation CUI_PanGestureRecognizer
@end

// Class
Class PanGestureRecognizerClass( void )
{ return [NSPanGestureRecognizer class]; }

// - init -
NSPanGestureRecognizer *PanGestureRecognizerInit( CUI_GestureRecognizerCallbackType callback, void *userData )
{
#if __has_feature(objc_arc)
    CUI_GestureRecognizerTarget *target = [[CUI_GestureRecognizerTarget alloc] initWithCallback:callback userData:userData];
    return [[NSPanGestureRecognizer alloc] initWithTarget:target action:@selector(action:)];
#else
    CUI_GestureRecognizerTarget *target = [[[CUI_GestureRecognizerTarget alloc] initWithCallback:callback userData:userData] autorelease];
    return [[[NSPanGestureRecognizer alloc] initWithTarget:target action:@selector(action:)] autorelease];
#endif
}

// - configure -
NSUInteger PanGestureRecognizerButtonMask( NSPanGestureRecognizer *ref )
{ return [ref buttonMask]; }

void PanGestureRecognizerSetButtonMask( NSPanGestureRecognizer *ref, NSUInteger mask )
{ [ref setButtonMask:mask]; }

// - tracking location and velocity -
CGPoint PanGestureRecognizerTranslationInView( NSPanGestureRecognizer *ref, NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return NSPointToCGPoint([ref translationInView:view]);
    return CGPointZero;
}

void PanGestureRecognizerSetTranslationInView( NSPanGestureRecognizer *ref, CGPoint translation, NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [ref setTranslation:NSPointFromCGPoint(translation) inView:view];
}

CGPoint PanGestureRecognizerVelocityInView( NSPanGestureRecognizer *ref, NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return NSPointToCGPoint([ref velocityInView:view]);
    return CGPointZero;
}

// - instance properties -
NSInteger PanGestureRecognizerNumberOfTouchesRequired( NSPanGestureRecognizer *ref )
{ return [ref numberOfTouchesRequired]; }

void PanGestureRecognizerSetNumberOfTouchesRequired( NSPanGestureRecognizer *ref, NSInteger touches )
{ [ref setNumberOfTouchesRequired:touches]; }

