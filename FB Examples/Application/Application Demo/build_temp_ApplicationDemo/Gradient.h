/*
 Gradient.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class GradientClass( void );

// Init
NSGradient *GradientWithStartEndColors( NSColor *startColor, NSColor *endColor );
NSGradient *GradientWithColors( CFArrayRef colors );
NSGradient *GradientWithColorsAndLocations( NSColor *firstColor, ... );
NSGradient *GradientWithColorsAtLocations( CFArrayRef colors, CGFloat *locations, NSColorSpace *cs );

// Primitive drawing methods
void GradientDrawFromPoint( NSGradient *ref, CGPoint pt1, CGPoint pt2, NSGradientDrawingOptions options );
void GradientDrawFromCenter( NSGradient *ref, CGPoint startCenter, CGFloat startRadius, CGPoint endCenter, CGFloat endRadius, NSGradientDrawingOptions options );

// Draw linear gradients
void GradientDrawInRect( NSGradient *ref, CGRect rect, CGFloat angle );
void GradientDrawInBezierPath( NSGradient *ref, NSBezierPath *path, CGFloat angle );

// Draw radial gradients
void GradientDrawInRectRelativeCenterPosition( NSGradient *ref, CGRect rect, CGPoint position );
void GradientDrawInBezierPathRelativeCenterPosition( NSGradient *ref, NSBezierPath *path, CGPoint position );

// Gradient properties
NSColorSpace *GradientColorSpace( NSGradient *ref );
NSInteger GradientNumberOfColorStops( NSGradient *ref );
void GradientGetColor( NSGradient *ref, NSColor **col, CGFloat *location, NSInteger index );
NSColor *GradientInterpolatedColorAtLocation( NSGradient *ref, CGFloat location );

// convenience
void GradientDrawFromPointWithStartEndColors( CGPoint pt1, CGPoint pt2, NSColor *startColor, NSColor *endColor, NSGradientDrawingOptions options );
void GradientDrawFromCenterWithStartEndColors( CGPoint startCenter, CGFloat startRadius, CGPoint endCenter, CGFloat endRadius, NSColor *startColor, NSColor *endColor, NSGradientDrawingOptions options );
void GradientDrawInRectWithStartEndColors( CGRect rect, CGFloat angle, NSColor *startColor, NSColor *endColor );
void GradientDrawInBezierPathWithStartEndColors( NSBezierPath *path, CGFloat angle, NSColor *startColor, NSColor *endColor );
void GradientDrawInRectRelativeCenterPositionWithStartEndColors( CGRect rect, CGPoint position, NSColor *startColor, NSColor *endColor );
void GradientDrawInBezierPathRelativeCenterPositionWithStartEndColors( NSBezierPath *path, CGPoint position, NSColor *startColor, NSColor *endColor );
