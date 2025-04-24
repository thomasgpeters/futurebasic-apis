/*
 CAGradientLayer.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

// - init -
CAGradientLayer *CAGradientLayerInit( void );

// - style -
CFArrayRef CAGradientLayerColors( CAGradientLayer *layer );
void CAGradientLayerSetColors( CAGradientLayer *layer, CFArrayRef cols );
CFArrayRef CAGradientLayerLocations( CAGradientLayer *layer );
void CAGradientLayerSetLocations( CAGradientLayer *layer, CFArrayRef locations );
CGPoint CAGradientEndPoint( CAGradientLayer *layer );
void CAGradientLayerSetEndPoint( CAGradientLayer *layer, CGPoint pt );
CGPoint CAGradientStartPoint( CAGradientLayer *layer );
void CAGradientLayerSetStartPoint( CAGradientLayer *layer, CGPoint pt );
CFStringRef CAGradientType( CAGradientLayer *layer );
void CAGradientLayerSetType( CAGradientLayer *layer, CFStringRef type );

// - convenience -
CAGradientLayer *CAGradientLayerWithStartEndColors( CGRect r, NSColor *startColor, CGPoint startPt, NSColor *endColor, CGPoint endPt );

