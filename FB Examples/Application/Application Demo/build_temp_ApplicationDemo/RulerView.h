/*
 RulerView.h

 Bernie Wylde
 */


#import "CocoaUI.h"

#import "ScrollView.h"

// Class
Class RulerViewClass( void );

// Create
NSRulerView *RulerViewWithScrollView( NSInteger scrollTag, NSRulerOrientation orientation );

// Measurement units
void RulerViewRegisterUnit( CFStringRef name, CFStringRef abbreviation, CGFloat unitToPointsFactor, CFArrayRef stepUpCycle, CFArrayRef stepDownCycle );
CFStringRef RulerViewMeasurementUnits( NSRulerView *ref );
void RulerViewSetMeasurementUnits( NSRulerView *ref, CFStringRef unitName );

// Client view
NSView *RulerViewClientView( NSRulerView *ref );
void RulerViewSetClientView( NSRulerView *ref, NSView *clientView );

// Accessory view
NSView *RulerViewAccessoryView( NSRulerView *ref );
void RulerViewSetAccessoryView( NSRulerView *ref, NSView *accessoryView );

// Zero mark position
CGFloat RulerViewOriginOffset( NSRulerView *ref );
void RulerViewSetOriginOffset( NSRulerView *ref, CGFloat offset );

// Markers
CFArrayRef RulerViewMarkers( NSRulerView *ref );
void RulerViewSetMarkers( NSRulerView *ref, CFArrayRef markers );
void RulerViewAddMarker( NSRulerView *ref, NSRulerMarker *marker );
void RulerViewRemoveMarker( NSRulerView *ref, NSRulerMarker *marker );

// Temporary ruler lines
void RulerViewMoveRulerline( NSRulerView *ref, CGFloat fromLocation, CGFloat toLocation );

// Drawing
void RulerViewDrawHashMarksAndLabelsInRect( NSRulerView *ref, CGRect r );
void RulerViewDrawMarkersInRect( NSRulerView *ref, CGRect r );
void RulerViewInvalidateHashMarks( NSRulerView *ref );

// Layout
NSInteger RulerViewScrollView( NSRulerView *ref );
void RulerViewSetScrollView( NSRulerView *ref, NSInteger scrollTag );
NSRulerOrientation RulerViewOrientation( NSRulerView *ref );
void RulerViewSetOrientation( NSRulerView *ref, NSRulerOrientation orientation );
CGFloat RulerViewReservedThicknessForAccessoryView( NSRulerView *ref );
void RulerViewSetReservedThicknessForAccessoryView( NSRulerView *ref, CGFloat thickness );
CGFloat RulerViewReservedThicknessForMarkers( NSRulerView *ref );
void RulerViewSetReservedThicknessForMarkers( NSRulerView *ref, CGFloat thickness );
CGFloat RulerViewRuleThickness( NSRulerView *ref );
void RulerViewSetRuleThickness( NSRulerView *ref, CGFloat thickness );
CGFloat RulerViewRequiredThickness( NSRulerView *ref );
CGFloat RulerViewBaselineLocation( NSRulerView *ref );
BOOL RulerViewIsFlipped( NSRulerView *ref );

