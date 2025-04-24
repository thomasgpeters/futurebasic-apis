/*
 RulerView.m

 Bernie Wylde
 */

#import "RulerView.h"

// Class
Class RulerViewClass( void )
{ return [NSRulerView class]; }

// Create
NSRulerView *RulerViewWithScrollView( NSInteger scrollTag, NSRulerOrientation orientation )
{
    NSScrollView *scrollView = ScrollViewWithTag( scrollTag );
#if __has_feature(objc_arc)
    if ( scrollView ) return [[NSRulerView alloc] initWithScrollView:scrollView orientation:orientation];
#else
    if ( scrollView ) return [[[NSRulerView alloc] initWithScrollView:scrollView orientation:orientation] autorelease];
#endif
    return nil;
}

// Measurement units
void RulerViewRegisterUnit( CFStringRef name, CFStringRef abbreviation, CGFloat unitToPointsFactor, CFArrayRef stepUpCycle, CFArrayRef stepDownCycle )
{ [NSRulerView registerUnitWithName:(__bridge NSString *)name abbreviation:(__bridge NSString *)abbreviation unitToPointsConversionFactor:unitToPointsFactor stepUpCycle:(__bridge NSArray *)stepUpCycle stepDownCycle:(__bridge NSArray *)stepDownCycle]; }

CFStringRef RulerViewMeasurementUnits( NSRulerView *ref )
{ return (__bridge CFStringRef)[ref measurementUnits]; }

void RulerViewSetMeasurementUnits( NSRulerView *ref, CFStringRef unitName )
{ [ref setMeasurementUnits:(__bridge NSString *)unitName]; }

// Client view
NSView *RulerViewClientView( NSRulerView *ref )
{ return [ref clientView]; }

void RulerViewSetClientView( NSRulerView *ref, NSView *clientView )
{ [ref setClientView:clientView]; }

// Accessory view
NSView *RulerViewAccessoryView( NSRulerView *ref )
{ return [ref accessoryView]; }

void RulerViewSetAccessoryView( NSRulerView *ref, NSView *accessoryView )
{ [ref setAccessoryView:accessoryView]; }

// Zero mark position
CGFloat RulerViewOriginOffset( NSRulerView *ref )
{ return [ref originOffset]; }

void RulerViewSetOriginOffset( NSRulerView *ref, CGFloat offset )
{ [ref setOriginOffset:offset]; }

// Markers
CFArrayRef RulerViewMarkers( NSRulerView *ref )
{ return (__bridge CFArrayRef)[ref markers]; }

void RulerViewSetMarkers( NSRulerView *ref, CFArrayRef markers )
{ [ref setMarkers:(__bridge NSArray *)markers]; }

void RulerViewAddMarker( NSRulerView *ref, NSRulerMarker *marker )
{ [ref addMarker:marker]; }

void RulerViewRemoveMarker( NSRulerView *ref, NSRulerMarker *marker )
{ [ref removeMarker:marker]; }

// Temporary ruler lines
void RulerViewMoveRulerline( NSRulerView *ref, CGFloat fromLocation, CGFloat toLocation )
{ [ref moveRulerlineFromLocation:fromLocation toLocation:toLocation]; }

// Drawing
void RulerViewDrawHashMarksAndLabelsInRect( NSRulerView *ref, CGRect r )
{ [ref drawHashMarksAndLabelsInRect:NSRectFromCGRect(r)]; }

void RulerViewDrawMarkersInRect( NSRulerView *ref, CGRect r )
{ [ref drawMarkersInRect:NSRectFromCGRect(r)]; }

void RulerViewInvalidateHashMarks( NSRulerView *ref )
{ [ref invalidateHashMarks]; }

// Layout
NSInteger RulerViewScrollView( NSRulerView *ref )
{
    NSScrollView *scrollView = [ref scrollView];
    if ( scrollView ) return [scrollView tag];
    return 0;
}

void RulerViewSetScrollView( NSRulerView *ref, NSInteger scrollTag )
{
    NSScrollView *scrollView = ScrollViewWithTag( scrollTag );
    if ( scrollView ) [ref setScrollView:scrollView];
}

NSRulerOrientation RulerViewOrientation( NSRulerView *ref )
{ return [ref orientation]; }

void RulerViewSetOrientation( NSRulerView *ref, NSRulerOrientation orientation )
{ [ref setOrientation:orientation]; }

CGFloat RulerViewReservedThicknessForAccessoryView( NSRulerView *ref )
{ return [ref reservedThicknessForAccessoryView]; }

void RulerViewSetReservedThicknessForAccessoryView( NSRulerView *ref, CGFloat thickness )
{ [ref setReservedThicknessForAccessoryView:thickness]; }

CGFloat RulerViewReservedThicknessForMarkers( NSRulerView *ref )
{ return [ref reservedThicknessForMarkers]; }

void RulerViewSetReservedThicknessForMarkers( NSRulerView *ref, CGFloat thickness )
{ [ref setReservedThicknessForMarkers:thickness]; }

CGFloat RulerViewRuleThickness( NSRulerView *ref )
{ return [ref ruleThickness]; }

void RulerViewSetRuleThickness( NSRulerView *ref, CGFloat thickness )
{ [ref setRuleThickness:thickness]; }

CGFloat RulerViewRequiredThickness( NSRulerView *ref )
{ return [ref requiredThickness]; }

CGFloat RulerViewBaselineLocation( NSRulerView *ref )
{ return [ref baselineLocation]; }

BOOL RulerViewIsFlipped( NSRulerView *ref )
{ return [ref isFlipped]; }

