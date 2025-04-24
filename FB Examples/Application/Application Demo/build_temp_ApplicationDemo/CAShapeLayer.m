/*
 CAShapeLayer.m

 Bernie Wylde
 */

#import "CAShapeLayer.h"

// - init -
CAShapeLayer *CAShapeLayerInit( void )
{ return [CAShapeLayer layer]; }

// - path -
CGPathRef CAShapeLayerPath( CAShapeLayer *layer )
{ return [layer path]; }

CGPathRef CAShapeLayerCGPath( CAShapeLayer *layer )
{ return [layer path]; }

NSBezierPath *CAShapeLayerBezierPath( CAShapeLayer *layer )
{
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
    if ( @available(macOS 14.0, *) ) {
        return [NSBezierPath bezierPathWithCGPath:[layer path]];
    } else {
        return CUI_BezierPathWithCGPath( [layer path] );
    }
#else// 140000
    return CUI_BezierPathWithCGPath( [layer path] );
#endif// 140000
}

//void CAShapeLayerSetPath( CAShapeLayer *layer, CGPathRef path )
//{ [layer setPath:path]; }

void CAShapeLayerSetPath( CAShapeLayer *layer, CFTypeRef path )
{
    if ( [(__bridge id)path isKindOfClass:[NSBezierPath class]] ) {
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
        if ( @available( macOS 14.0, * ) ) {
            [layer setPath:[(__bridge NSBezierPath *)path CGPath]];
        } else {
            CGPathRef cgPath = CUI_BezierPathCGPath( (__bridge NSBezierPath *)path );
            if ( cgPath ) [layer setPath:cgPath];
        }
#else
        CGPathRef cgPath = CUI_BezierPathCGPath( (__bridge NSBezierPath *)path );
        if ( cgPath ) [layer setPath:cgPath];
#endif// 140000
    } else {
        if ( CFGetTypeID(path) == CGPathGetTypeID() ) {
            [layer setPath:path];
        }
    }
}

//void CAShapeLayerSetBezierPath( CAShapeLayer *layer, NSBezierPath *path )
//{
//#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
//    if ( @available( macOS 14.0, * ) ) {
//        [layer setPath:[path CGPath]];
//    } else {
//        CGPathRef cgPath = CUI_BezierPathCGPath( path );
//        if ( cgPath ) [layer setPath:cgPath];
//    }
//#else
//    CGPathRef cgPath = CUI_BezierPathCGPath( path );
//    if ( cgPath ) [layer setPath:cgPath];
//#endif// 140000
//}

// - properties -
NSColor *CAShapeLayerFillColor( CAShapeLayer *layer )
{ return [NSColor colorWithCGColor:[layer fillColor]]; }

void CAShapeLayerSetFillColor( CAShapeLayer *layer, NSColor *fillColor )
{ [layer setFillColor:[fillColor CGColor]]; }

CFStringRef caShapeLayerFillRule( CAShapeLayer *layer )
{ return (__bridge CFStringRef)[layer fillRule]; }

void CAShapeLayerSetFillRule( CAShapeLayer *layer, CFStringRef fillRule )
{ [layer setFillRule:(__bridge NSString *)fillRule]; }

CFStringRef caShapeLayerLineCap( CAShapeLayer *layer )
{ return (__bridge CFStringRef)[layer lineCap]; }

void CAShapeLayerSetLineCap( CAShapeLayer *layer, CFStringRef lineCap )
{ [layer setLineCap:(__bridge NSString *)lineCap]; }

CFArrayRef CAShapeLayerLineDashPattern( CAShapeLayer *layer )
{ return (__bridge CFArrayRef)[layer lineDashPattern]; }

void CAShapeLayerSetLineDashPattern( CAShapeLayer *layer, CFArrayRef lineDashPattern )
{ [layer setLineDashPattern:(__bridge NSArray *)lineDashPattern]; }

CGFloat CAShapeLayerLineDashPhase( CAShapeLayer *layer )
{ return [layer lineDashPhase]; }

void CAShapeLayerSetLineDashPhase( CAShapeLayer *layer, CGFloat lineDashPhase )
{ [layer setLineDashPhase:lineDashPhase]; }

CFStringRef caShapeLayerLineJoin( CAShapeLayer *layer )
{ return (__bridge CFStringRef)[layer lineJoin]; }

void CAShapeLayerSetLineJoin( CAShapeLayer *layer, CFStringRef lineJoin )
{ [layer setLineJoin:(__bridge NSString *)lineJoin]; }

CGFloat CAShapeLayerLineWidth( CAShapeLayer *layer )
{ return [layer lineWidth]; }

void CAShapeLayerSetLineWidth( CAShapeLayer *layer, CGFloat lineWidth )
{ [layer setLineWidth:lineWidth]; }

CGFloat CAShapeLayerMiterLimit( CAShapeLayer *layer )
{ return [layer miterLimit]; }

void CAShapeLayerSetMiterLimit( CAShapeLayer *layer, CGFloat miterLimit )
{ [layer setMiterLimit:miterLimit]; }

NSColor *CAShapeLayerStrokeColor( CAShapeLayer *layer )
{ return [NSColor colorWithCGColor:[layer strokeColor]]; }

void CAShapeLayerSetStrokeColor( CAShapeLayer *layer, NSColor *strokeColor )
{ [layer setStrokeColor:[strokeColor CGColor]]; }

CGFloat CAShapeLayerStrokeStart( CAShapeLayer *layer )
{ return [layer strokeStart]; }

void CAShapeLayerSetStrokeStart( CAShapeLayer *layer, CGFloat strokeStart )
{ [layer setStrokeStart:strokeStart]; }

CGFloat CAShapeLayerStrokeEnd( CAShapeLayer *layer )
{ return [layer strokeEnd]; }

void CAShapeLayerSetStrokeEnd( CAShapeLayer *layer, CGFloat strokeEnd )
{ [layer setStrokeEnd:strokeEnd]; }


