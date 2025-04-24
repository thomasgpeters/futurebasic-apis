/*
 BezierPath.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

// Class
Class BezierPathClass( void );

NSBezierPath *BezierPathInit( void );
NSBezierPath *BezierPathWithOvalInRect( CGRect r );
NSBezierPath *BezierPathWithRect( CGRect r );
NSBezierPath *BezierPathWithRoundedRect( CGRect r, CGFloat xRadius, CGFloat yRadius );
NSBezierPath *BezierPathByFlatteningPath( NSBezierPath *path );
NSBezierPath *BezierPathByReversingPath( NSBezierPath *path );
NSBezierPath *BezierPathWithCGPath( CGPathRef cgPath );
CGPathRef BezierPathCGPath( NSBezierPath *ref );

void BezierPathMoveToPoint( NSBezierPath *path, CGPoint pt );
void BezierPathLineToPoint( NSBezierPath *path, CGPoint pt );
void BezierPathCurveToPoint( NSBezierPath *path, CGPoint pt, CGPoint cp1, CGPoint cp2 );
void BezierPathClose( NSBezierPath *path );
void BezierPathRelativeMoveToPoint( NSBezierPath *path, CGPoint pt );
void BezierPathRelativeLineToPoint( NSBezierPath *path, CGPoint pt );
void BezierPathRelativeCurveToPoint( NSBezierPath *path, CGPoint pt, CGPoint cp1, CGPoint cp2 );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
void BezierPathCurveToPointControlPoint( NSBezierPath *ref, CGPoint pt, CGPoint cp );
API_AVAILABLE(macos(14.0))
void BezierPathRelativeCurveToPointControlPoint( NSBezierPath *ref, CGPoint pt, CGPoint cp );
#endif// 140000

void BezierPathAppendPath( NSBezierPath *path1, NSBezierPath *path2 );
void BezierPathAppendPathWithPoints( NSBezierPath *path, CGPoint *points, NSInteger count );
void BezierPathAppendPathWithOvalInRect( NSBezierPath *path, CGRect r );
void BezierPathAppendPathWithArcFromPoint( NSBezierPath *path, CGPoint pt1, CGPoint pt2, CGFloat radius );
void BezierPathAppendPathWithArcWithCenter( NSBezierPath *path, CGPoint center, CGFloat radius, CGFloat startAngle, CGFloat endAngle, BOOL clockwise );

// void BezierPathAppendPathWithCGGlyph( NSBezierPath *path, CGGlyph glyph, CTFontRef font );
// //void BezierPathAppendPathWithCGGlyphs( NSBezierPath *path1, void *glyphs, NSInteger count, CTFontRef font );

void BezierPathAppendPathWithRect( NSBezierPath *path, CGRect r );
void BezierPathAppendPathWithRoundedRect( NSBezierPath *path, CGRect r, CGFloat xRadius, CGFloat yRadius );

void BezierPathSetWindingRule( NSBezierPath *path, NSWindingRule rule );
void BezierPathSetLineCapStyle( NSBezierPath *path, NSLineCapStyle style );
void BezierPathSetLineJoinStyle( NSBezierPath *path, NSLineJoinStyle style );
void BezierPathSetLineWidth( NSBezierPath *path, CGFloat lineWidth );
void BezierPathSetMiterLimit( NSBezierPath *path, CGFloat limit );
void BezierPathSetFlatness( NSBezierPath *path, CGFloat flatness );
void BezierPathGetLineDash( NSBezierPath *path, CGFloat *pattern, NSInteger *count, CGFloat *phase );
void BezierPathSetLineDash( NSBezierPath *path, CGFloat *pattern, NSInteger count, CGFloat phase );

NSWindingRule BezierPathDefaultWindingRule( void );
void BezierPathSetDefaultWindingRule( NSWindingRule rule );
NSLineCapStyle BezierPathDefaultLineCapStyle( void );
void BezierPathSetDefaultLineCapStyle( NSLineCapStyle style );
NSLineJoinStyle BezierPathDefaultLineJoinStyle( void );
void BezierPathSetDefaultLineJoinStyle( NSLineJoinStyle style );
CGFloat BezierPathDefaultLineWidth( void );
void BezierPathSetDefaultLineWidth( CGFloat lineWidth );
CGFloat BezierPathDefaultMiterLimit( void );
void BezierPathSetDefaultMiterLimit( CGFloat limit );
CGFloat BezierPathDefaultFlatness( void );
void BezierPathSetDefaultFlatness( CGFloat flatness );

void BezierPathStroke( NSBezierPath *path );
void BezierPathFill( NSBezierPath *path );
//+ drawPackedGlyphs:atPoint:

void BezierPathAddClip( NSBezierPath *path );
void BezierPathSetClip( NSBezierPath *path );
void BezierPathClipRect( CGRect r );

BOOL BezierPathContainsPoint( NSBezierPath *path, CGPoint pt );

CGRect BezierPathBounds( NSBezierPath *path );
CGRect BezierPathControlPointBounds( NSBezierPath *path );
CGPoint BezierPathCurrentPoint( NSBezierPath *path );
BOOL BezierPathIsEmpty( NSBezierPath *path );

void BezierPathTransformUsingAffineTranform( NSBezierPath *path, NSAffineTransform *tx );

NSInteger BezierPathElementCount( NSBezierPath *path );
NSBezierPathElement BezierPathElementAtIndex( NSBezierPath *path, NSInteger index );
NSBezierPathElement BezierPathElementAtIndexAssociatedPoints( NSBezierPath *path, NSInteger index, CGPoint *points );
void BezierPathRemoveAllPoints( NSBezierPath *path );
void BezierPathSetAssociatedPointsAtIndex( NSBezierPath *path, CGPoint *points, NSInteger index );


#pragma mark - convenience
NSBezierPath *BezierPathWithRotatedRect( CGRect r, CGFloat x, CGFloat y, CGFloat angle );
NSBezierPath *BezierPathWithPolygonInRect( CGRect r, NSInteger sides, CGFloat lineWidth, CGFloat cornerRadius );
NSBezierPath *BezierPathWithPolygonInRectRotate( CGRect r, NSInteger sides, CGFloat lineWidth, CGFloat cornerRadius, CGFloat rotateAngle );

void BezierPathStrokeFill( NSBezierPath *path, CGFloat lineWidth, NSColor *strokeCol, NSColor *fillCol );

void BezierPathStrokeFillOvalInRect( CGRect r, CGFloat lineWidth, NSColor *strokeCol, NSColor *fillCol );
void BezierPathStrokeFillRect( CGRect r, CGFloat lineWidth, NSColor *strokeCol, NSColor *fillCol );
void BezierPathStrokeFillRoundedRect( CGRect r, CGFloat xRadius, CGFloat yRadius, CGFloat lineWidth, NSColor *strokeCol, NSColor *fillCol );
void BezierPathStrokeFillPolygon( CFArrayRef pts, CGFloat lineWidth, NSColor *strokeCol, NSColor *fillCol );
void BezierPathStrokeFillRotatedRect( CGRect r, CGFloat x, CGFloat y, CGFloat angle, CGFloat lineWidth, NSColor *strokeCol, NSColor *fillCol );

void BezierPathStrokeOvalInRect( CGRect r, CGFloat lineWidth, NSColor *strokeCol );
void BezierPathStrokeRect( CGRect r, CGFloat lineWidth, NSColor *strokeCol );
void BezierPathStrokeRoundedRect( CGRect r, CGFloat xRadius, CGFloat yRadius, CGFloat lineWidth, NSColor *strokeCol );
void BezierPathStrokeLine( CGPoint pt1, CGPoint pt2, CGFloat lineWidth, NSColor *strokeCol );
void BezierPathStrokeCurve( CGPoint pt1, CGPoint pt2, CGPoint cp1, CGPoint cp2, CGFloat lineWidth, NSColor *strokeCol );
void BezierPathStrokePolygon( CFArrayRef pts, CGFloat lineWidth, NSColor *strokeCol );
void BezierPathStrokeRotatedRect( CGRect r, CGFloat x, CGFloat y, CGFloat angle, CGFloat lineWidth, NSColor *strokeCol );

void BezierPathFillOvalInRect( CGRect r, NSColor *fillCol );
void BezierPathFillRect( CGRect r, NSColor *fillCol );
void BezierPathFillRoundedRect( CGRect r, CGFloat xRadius, CGFloat yRadius, NSColor *fillCol );
void BezierPathFillRotatedRect( CGRect r, CGFloat x, CGFloat y, CGFloat angle, NSColor *fillCol );
void BezierPathFillPolygon( CFArrayRef pts, NSColor *fillCol );
//void BezierPathFillRotatedRect( CGRect r, CGFloat x, CGFloat y, CGFloat angle, NSColor *fillCol );
