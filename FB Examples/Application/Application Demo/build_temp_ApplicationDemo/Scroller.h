/*
 Scroller.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class ScrollerClass( void );

// Scroller size
CGFloat ScrollerWidth( NSControlSize size, NSScrollerStyle style );
NSControlSize ScrollerControlSize( NSScroller *ref );

// Knob position
CGFloat ScrollerKnobProportion( NSScroller *ref );
void ScrollerSetKnobProportion( NSScroller *ref, CGFloat proportion );

// Calculate layout -
CGRect ScrollerRectForPart( NSScroller *ref, NSScrollerPart part );
NSScrollerPart ScrollerTestPart( NSScroller *ref, CGPoint pt );
NSUsableScrollerParts ScrollerUsableParts( NSScroller *ref );

// Draw scroller parts
void ScrollerDrawKnobSlotInRect( NSScroller *ref, CGRect r, BOOL highlight );

// Event handling
NSScrollerPart ScrollerHitPart( NSScroller *ref );

// Presentation style
NSScrollerStyle ScrollerPreferredScrollerStyle( void );
NSScrollerStyle ScrollerScrollerStyle( NSScroller *ref );
NSScrollerKnobStyle ScrollerKnobStyle( NSScroller *ref );

// Type properties
BOOL ScrollerIsCompatibleWithOverlayScrollers( void );

