/*
 Touch.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "View.h"

// Class
Class TouchClass( void );

// Type
NSTouchType TouchType( NSTouch *ref );

// Properties of this touch
CFTypeRef TouchIdentity( NSTouch *ref );
NSTouchPhase TouchPhase( NSTouch *ref );
CGPoint TouchNormalizedPosition( NSTouch *ref );
BOOL TouchIsResting( NSTouch *ref );

// Properties of touch device
CFTypeRef TouchDevice( NSTouch *ref );
CGSize TouchDeviceSize( NSTouch *ref );

// Touch location
CGPoint TouchLocationInView( NSTouch *ref, NSInteger tag );
CGPoint TouchPreviousLocationInView( NSTouch *ref, NSInteger tag );

