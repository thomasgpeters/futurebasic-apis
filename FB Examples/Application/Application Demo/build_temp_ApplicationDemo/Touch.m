/*
 Touch.m

 Bernie Wylde
 */

#import "Touch.h"

// Class
Class TouchClass( void )
{ return [NSTouch class]; }

// Type
NSTouchType TouchType( NSTouch *ref )
{ return [ref type]; }

// Properties of this touch
CFTypeRef TouchIdentity( NSTouch *ref )
{ return (__bridge CFTypeRef)[ref identity]; }

NSTouchPhase TouchPhase( NSTouch *ref )
{ return [ref phase]; }

CGPoint TouchNormalizedPosition( NSTouch *ref )
{ return NSPointToCGPoint([ref normalizedPosition]); }

BOOL TouchIsResting( NSTouch *ref )
{ return [ref isResting]; }

// Properties of touch device
CFTypeRef TouchDevice( NSTouch *ref )
{ return (__bridge CFTypeRef)[ref device]; }

CGSize TouchDeviceSize( NSTouch *ref )
{ return NSSizeToCGSize([ref deviceSize]); }

// Touch location
CGPoint TouchLocationInView( NSTouch *ref, NSInteger tag )
{
    NSView *view = ViewWithTag( tag );
    if ( view ) return NSPointToCGPoint([ref locationInView:view]);
    return CGPointZero;
}

CGPoint TouchPreviousLocationInView( NSTouch *ref, NSInteger tag )
{
    NSView *view = ViewWithTag( tag );
    if ( view ) return NSPointToCGPoint([ref previousLocationInView:view]);
    return CGPointZero;
}
