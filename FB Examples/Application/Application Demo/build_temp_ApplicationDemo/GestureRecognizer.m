/*
 GestureRecognizer.m

 Bernie Wylde
 */

#import "GestureRecognizer.h"

/*
 Target
 */
@implementation CUI_GestureRecognizerTarget

- (id)initWithCallback:(CUI_GestureRecognizerCallbackType)cb userData:(void *)ud {
    if ( [super init] ) {
        self.callback = cb;
        self.userData = ud;
    }
    return self;
}

- (void)object:(id)object forwardGestureRecognizerEvent:(NSInteger)event {
    NSView *view = [object view];
    NSInteger tag = 0;
    if ( view ) tag = CUI_ViewTag(view);
    if ( self.callback ) {
        (*self.callback)(object,tag,self.userData);
    } else {
        CallUserDefinedOnDialogFunction( event, tag, [view wndTag], (__bridge CFTypeRef)object );
    }
}

- (void)action:(id)object {
    NSView *view = [object view];
    NSInteger tag = 0;
    if ( view ) tag = CUI_ViewTag(view);
    
    if ( self.callback ) {
        (*self.callback)(object,tag,self.userData);
    } else {
        CallUserDefinedOnDialogFunction( gestureRecognizerClick, tag, [view wndTag], (__bridge CFTypeRef)object );
    }
}

- (void)clickAction:(id)object {
    [self object:object forwardGestureRecognizerEvent:gestureRecognizerClick];
}

- (void)magnificationAction:(id)object {
    [self object:object forwardGestureRecognizerEvent:gestureRecognizerMagnification];
}

- (void)panAction:(id)object {
    [self object:object forwardGestureRecognizerEvent:gestureRecognizerPan];
}

- (void)pressAction:(id)object {
    [self object:object forwardGestureRecognizerEvent:gestureRecognizerPress];
}

- (void)rotationAction:(id)object {
    [self object:object forwardGestureRecognizerEvent:gestureRecognizerRotation];
}

@end


/*
 Subclass
 */
@implementation CUI_GestureRecognizer
@end

// Class
Class GestureRecognizerClass( void )
{ return [NSGestureRecognizer class]; }

// Init
//NSGestureRecognizer *GestureRecognizerWithCallback( CUI_GestureRecognizerCallbackType callback, void *userData )
//{
//    
//    return [[[NSGestureRecognizer alloc] initWithCallback:callback userData:userData] autorelease];
//    
//}

// - location of events -
CGPoint GestureRecognizerLocationInView( NSGestureRecognizer *ref, NSInteger tag )
{
    NSView *view = ViewWithTag(tag);
    if ( view ) return NSPointToCGPoint([ref locationInView:view]);
    return CGPointZero;
}

// - state -
NSGestureRecognizerState GestureRecognizerState( NSGestureRecognizer *ref )
{ return [ref state]; }

NSInteger GestureRecognizerView( NSGestureRecognizer *ref )
{
    NSView *view = [ref view];
    if ( view ) return CUI_ViewTag(view);
    return 0;
}

BOOL GestureRecognizerIsEnabled( NSGestureRecognizer *ref )
{ return [ref isEnabled]; }

void GestureRecognizerSetEnabled( NSGestureRecognizer *ref, BOOL flag )
{ [ref setEnabled:flag]; }

// - delaying -
BOOL GestureRecognizerDelaysPrimaryMouseButtonEvents( NSGestureRecognizer *ref )
{ return [ref delaysPrimaryMouseButtonEvents]; }

void GestureRecognizerSetDelaysPrimaryMouseButtonEvents( NSGestureRecognizer *ref, BOOL flag )
{ [ref setDelaysPrimaryMouseButtonEvents:flag]; }

BOOL GestureRecognizerDelaysSecondaryMouseButtonEvents( NSGestureRecognizer *ref )
{ return [ref delaysSecondaryMouseButtonEvents]; }

void GestureRecognizerSetDelaysSecondaryMouseButtonEvents( NSGestureRecognizer *ref, BOOL flag )
{ [ref setDelaysSecondaryMouseButtonEvents:flag]; }

BOOL GestureRecognizerDelaysOtherMouseButtonEvents( NSGestureRecognizer *ref )
{ return [ref delaysOtherMouseButtonEvents]; }

void GestureRecognizerSetDelaysOtherMouseButtonEvents( NSGestureRecognizer *ref, BOOL flag )
{ [ref setDelaysOtherMouseButtonEvents:flag]; }

BOOL GestureRecognizerDelaysKeyEvents( NSGestureRecognizer *ref )
{ return [ref delaysKeyEvents]; }

void GestureRecognizerSetDelaysKeyEvents( NSGestureRecognizer *ref, BOOL flag )
{ [ref setDelaysKeyEvents:flag]; }

BOOL GestureRecognizerDelaysMagnificationEvents( NSGestureRecognizer *ref )
{ return [ref delaysMagnificationEvents]; }

void GestureRecognizerSetDelaysMagnificationEvents( NSGestureRecognizer *ref, BOOL flag )
{ [ref setDelaysMagnificationEvents:flag]; }

BOOL GestureRecognizerDelaysRotationEvents( NSGestureRecognizer *ref )
{ return [ref delaysRotationEvents]; }

void GestureRecognizerSetDelaysRotationEvents( NSGestureRecognizer *ref, BOOL flag )
{ [ref setDelaysRotationEvents:flag]; }

// - delegate -

// - methods for subclasses -

// Pressure -
NSPressureConfiguration *GestureRecognizerPressureConfiguration( NSGestureRecognizer *ref )
{ return [ref pressureConfiguration]; }

void GestureRecognizerSetPressureConfiguration( NSGestureRecognizer *ref, NSPressureConfiguration *config )
{ [ref setPressureConfiguration:config]; }

// Instance properties -
NSTouchTypeMask GestureRecognizerAllowedTouchTypes( NSGestureRecognizer *ref )
{ return [ref allowedTouchTypes]; }

void GestureRecognizerSetAllowedTouchTypes( NSGestureRecognizer *ref, NSTouchTypeMask touchTypes )
{ [ref setAllowedTouchTypes:touchTypes]; }

// - instance methods -

