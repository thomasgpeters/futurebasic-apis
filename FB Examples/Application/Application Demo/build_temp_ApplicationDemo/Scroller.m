/*
 Scroller.m

 Bernie Wylde
 */

#import "Scroller.h"

// Class
Class ScrollerClass( void )
{ return [NSScroller class]; }

// Scroller size
CGFloat ScrollerWidth( NSControlSize size, NSScrollerStyle style )
{ return [NSScroller scrollerWidthForControlSize:size scrollerStyle:style]; }

NSControlSize ScrollerControlSize( NSScroller *ref )
{ return [ref controlSize]; }

// Knob position
CGFloat ScrollerKnobProportion( NSScroller *ref )
{ return [ref knobProportion]; }

void ScrollerSetKnobProportion( NSScroller *ref, CGFloat proportion )
{ [ref setKnobProportion:proportion]; }

// Calculate layout -
CGRect ScrollerRectForPart( NSScroller *ref, NSScrollerPart part )
{ return NSRectToCGRect([ref rectForPart:part]); }

NSScrollerPart ScrollerTestPart( NSScroller *ref, CGPoint pt )
{ return [ref testPart:NSPointFromCGPoint(pt)]; }

NSUsableScrollerParts ScrollerUsableParts( NSScroller *ref )
{ return [ref usableParts]; }

// Draw scroller parts
void ScrollerDrawKnobSlotInRect( NSScroller *ref, CGRect r, BOOL highlight )
{ [ref drawKnobSlotInRect:NSRectFromCGRect(r) highlight:highlight]; }

// Event handling
NSScrollerPart ScrollerHitPart( NSScroller *ref )
{ return [ref hitPart]; }

// Presentation style
NSScrollerStyle ScrollerPreferredScrollerStyle( void )
{ return [NSScroller preferredScrollerStyle]; }

NSScrollerStyle ScrollerScrollerStyle( NSScroller *ref )
{ return [ref scrollerStyle]; }

NSScrollerKnobStyle ScrollerKnobStyle( NSScroller *ref )
{ return [ref knobStyle]; }

// Type properties
BOOL ScrollerIsCompatibleWithOverlayScrollers( void )
{ return [NSScroller isCompatibleWithOverlayScrollers]; }


