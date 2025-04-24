/*
 CAShapeLayer.h

 Bernie Wylde
 */

#import "CocoaUI.h"

// - init -
CAShapeLayer *CAShapeLayerInit( void );

// - path -
CGPathRef CAShapeLayerPath( CAShapeLayer *layer );
CGPathRef CAShapeLayerCGPath( CAShapeLayer *layer );
NSBezierPath *CAShapeLayerBezierPath( CAShapeLayer *layer );
//void CAShapeLayerSetPath( CAShapeLayer *layer, CGPathRef path );
void CAShapeLayerSetPath( CAShapeLayer *layer, CFTypeRef path );
//void CAShapeLayerSetBezierPath( CAShapeLayer *layer, NSBezierPath *path );

// - properties -
NSColor *CAShapeLayerFillColor( CAShapeLayer *layer );
void CAShapeLayerSetFillColor( CAShapeLayer *layer, NSColor *fillColor );
CFStringRef caShapeLayerFillRule( CAShapeLayer *layer );
void CAShapeLayerSetFillRule( CAShapeLayer *layer, CFStringRef fillRule );
CFStringRef caShapeLayerLineCap( CAShapeLayer *layer );
void CAShapeLayerSetLineCap( CAShapeLayer *layer, CFStringRef lineCap );
CFArrayRef CAShapeLayerLineDashPattern( CAShapeLayer *layer );
void CAShapeLayerSetLineDashPattern( CAShapeLayer *layer, CFArrayRef lineDashPattern );
CGFloat CAShapeLayerLineDashPhase( CAShapeLayer *layer );
void CAShapeLayerSetLineDashPhase( CAShapeLayer *layer, CGFloat lineDashPhase );
CFStringRef caShapeLayerLineJoin( CAShapeLayer *layer );
void CAShapeLayerSetLineJoin( CAShapeLayer *layer, CFStringRef lineJoin );
CGFloat CAShapeLayerLineWidth( CAShapeLayer *layer );
void CAShapeLayerSetLineWidth( CAShapeLayer *layer, CGFloat lineWidth );
CGFloat CAShapeLayerMiterLimit( CAShapeLayer *layer );
void CAShapeLayerSetMiterLimit( CAShapeLayer *layer, CGFloat miterLimit );
NSColor *CAShapeLayerStrokeColor( CAShapeLayer *layer );
void CAShapeLayerSetStrokeColor( CAShapeLayer *layer, NSColor *strokeColor );
CGFloat CAShapeLayerStrokeStart( CAShapeLayer *layer );
void CAShapeLayerSetStrokeStart( CAShapeLayer *layer, CGFloat strokeStart );
CGFloat CAShapeLayerStrokeEnd( CAShapeLayer *layer );
void CAShapeLayerSetStrokeEnd( CAShapeLayer *layer, CGFloat strokeEnd );

