/*
 BezierPath.m
 
 Bernie Wylde
 */

#import "BezierPath.h"

#pragma mark - bezierpath
// Class
Class BezierPathClass( void )
{ return [NSBezierPath class]; }

NSBezierPath *BezierPathInit( void )
{ return [NSBezierPath bezierPath]; }

NSBezierPath *BezierPathWithOvalInRect( CGRect r )
{ return [NSBezierPath bezierPathWithOvalInRect:NSRectFromCGRect(r)]; }

NSBezierPath *BezierPathWithRect( CGRect r )
{ return [NSBezierPath bezierPathWithRect:NSRectFromCGRect(r)]; }

NSBezierPath *BezierPathWithRoundedRect( CGRect r, CGFloat xRadius, CGFloat yRadius )
{ return [NSBezierPath bezierPathWithRoundedRect:NSRectFromCGRect(r) xRadius:xRadius yRadius:yRadius]; }

NSBezierPath *BezierPathByFlatteningPath( NSBezierPath *path )
{ return [path bezierPathByFlatteningPath]; }

NSBezierPath *BezierPathByReversingPath( NSBezierPath *path )
{ return [path bezierPathByReversingPath]; }

NSBezierPath *BezierPathWithCGPath( CGPathRef cgPath )
{
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
    if ( @available( macOS 14.0, * ) ) {
        return [NSBezierPath bezierPathWithCGPath:cgPath];
    } else {
        return CUI_BezierPathWithCGPath( cgPath );
    }
#else
    return CUI_BezierPathWithCGPath( cgPath );
#endif// 140000
    return nil;
}

CGPathRef BezierPathCGPath( NSBezierPath *ref )
{
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
    if ( @available( macOS 14.0, * ) ) {
        return [ref CGPath];
    } else {
        return CUI_BezierPathCGPath( ref );
    }
#else
    return CUI_BezierPathCGPath( ref );
#endif
    return nil;
}


void BezierPathMoveToPoint( NSBezierPath *path, CGPoint pt )
{ [path moveToPoint:NSPointFromCGPoint(pt)]; }

void BezierPathLineToPoint( NSBezierPath *path, CGPoint pt )
{ [path lineToPoint:NSPointFromCGPoint(pt)]; }

void BezierPathCurveToPoint( NSBezierPath *path, CGPoint pt, CGPoint cp1, CGPoint cp2 )
{ [path curveToPoint:NSPointFromCGPoint(pt) controlPoint1:NSPointFromCGPoint(cp1) controlPoint2:NSPointFromCGPoint(cp2)]; }

void BezierPathClose( NSBezierPath *path )
{ [path closePath]; }

void BezierPathRelativeMoveToPoint( NSBezierPath *path, CGPoint pt )
{ [path relativeMoveToPoint:NSPointFromCGPoint(pt)]; }

void BezierPathRelativeLineToPoint( NSBezierPath *path, CGPoint pt )
{ [path relativeLineToPoint:NSPointFromCGPoint(pt)]; }

void BezierPathRelativeCurveToPoint( NSBezierPath *path, CGPoint pt, CGPoint cp1, CGPoint cp2 )
{ [path relativeCurveToPoint:NSPointFromCGPoint(pt) controlPoint1:NSPointFromCGPoint(cp1) controlPoint2:NSPointFromCGPoint(cp2)]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
void BezierPathCurveToPointControlPoint( NSBezierPath *ref, CGPoint pt, CGPoint cp )
{ [ref curveToPoint:NSPointFromCGPoint(pt) controlPoint:NSPointFromCGPoint(cp)]; }

void BezierPathRelativeCurveToPointControlPoint( NSBezierPath *ref, CGPoint pt, CGPoint cp )
{ [ref relativeCurveToPoint:NSPointFromCGPoint(pt) controlPoint:NSPointFromCGPoint(cp)]; }
#endif// 140000

void BezierPathAppendPath( NSBezierPath *path1, NSBezierPath *path2 )
{ [path1 appendBezierPath:path2]; }

void BezierPathAppendPathWithPoints( NSBezierPath *path, CGPoint *points, NSInteger count )
{ [path appendBezierPathWithPoints:(NSPointArray)points count:count]; }

void BezierPathAppendPathWithOvalInRect( NSBezierPath *path, CGRect r )
{ [path appendBezierPathWithOvalInRect:NSRectFromCGRect(r)]; }

void BezierPathAppendPathWithArcFromPoint( NSBezierPath *path, CGPoint pt1, CGPoint pt2, CGFloat radius )
{ [path appendBezierPathWithArcFromPoint:NSPointFromCGPoint(pt1) toPoint:NSPointFromCGPoint(pt2) radius:radius]; }

void BezierPathAppendPathWithArcWithCenter( NSBezierPath *path, CGPoint center, CGFloat radius, CGFloat startAngle, CGFloat endAngle, BOOL clockwise )
{ [path appendBezierPathWithArcWithCenter:NSPointFromCGPoint(center) radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise]; }

// void BezierPathAppendPathWithCGGlyph( NSBezierPath *path, CGGlyph glyph, CTFontRef font )
// { [path appendBezierPathWithCGGlyph:glyph inFont:(NSFont *)font]; }

void BezierPathAppendPathWithRect( NSBezierPath *path, CGRect r )
{ [path appendBezierPathWithRect:NSRectFromCGRect(r)]; }

void BezierPathAppendPathWithRoundedRect( NSBezierPath *path, CGRect r, CGFloat xRadius, CGFloat yRadius )
{ [path appendBezierPathWithRoundedRect:NSRectFromCGRect(r) xRadius:xRadius yRadius:yRadius]; }

void BezierPathSetWindingRule( NSBezierPath *path, NSWindingRule rule )
{ [path setWindingRule:rule]; }

void BezierPathSetLineCapStyle( NSBezierPath *path, NSLineCapStyle style )
{ [path setLineCapStyle:style]; }

void BezierPathSetLineJoinStyle( NSBezierPath *path, NSLineJoinStyle style )
{ [path setLineJoinStyle:style]; }

void BezierPathSetLineWidth( NSBezierPath *path, CGFloat lineWidth )
{ [path setLineWidth:lineWidth]; }

void BezierPathSetMiterLimit( NSBezierPath *path, CGFloat limit )
{ [path setMiterLimit:limit]; }

void BezierPathSetFlatness( NSBezierPath *path, CGFloat flatness )
{ [path setFlatness:flatness]; }

void BezierPathGetLineDash( NSBezierPath *path, CGFloat *pattern, NSInteger *count, CGFloat *phase )
{ [path getLineDash:pattern count:count phase:phase]; }

void BezierPathSetLineDash( NSBezierPath *path, CGFloat *pattern, NSInteger count, CGFloat phase )
{ [path setLineDash:pattern count:count phase:phase]; }

NSWindingRule BezierPathDefaultWindingRule( void )
{ return [NSBezierPath defaultWindingRule]; }

void BezierPathSetDefaultWindingRule( NSWindingRule rule )
{ [NSBezierPath setDefaultWindingRule:rule]; }

NSLineCapStyle BezierPathDefaultLineCapStyle( void )
{ return [NSBezierPath defaultLineCapStyle]; }

void BezierPathSetDefaultLineCapStyle( NSLineCapStyle style )
{ [NSBezierPath setDefaultLineCapStyle:style]; }

NSLineJoinStyle BezierPathDefaultLineJoinStyle( void )
{ return [NSBezierPath defaultLineJoinStyle]; }

void BezierPathSetDefaultLineJoinStyle( NSLineJoinStyle style )
{ [NSBezierPath setDefaultLineJoinStyle:style]; }

CGFloat BezierPathDefaultLineWidth( void )
{ return [NSBezierPath defaultLineWidth]; }

void BezierPathSetDefaultLineWidth( CGFloat lineWidth )
{ [NSBezierPath setDefaultLineWidth:lineWidth]; }

CGFloat BezierPathDefaultMiterLimit( void )
{ return [NSBezierPath defaultMiterLimit]; }

void BezierPathSetDefaultMiterLimit( CGFloat limit )
{ [NSBezierPath setDefaultMiterLimit:limit]; }

CGFloat BezierPathDefaultFlatness( void )
{ return [NSBezierPath defaultFlatness]; }

void BezierPathSetDefaultFlatness( CGFloat flatness )
{ [NSBezierPath setDefaultFlatness:flatness]; }

void BezierPathStroke( NSBezierPath *path )
{ [path stroke]; }

void BezierPathFill( NSBezierPath *path )
{ [path fill]; }

void BezierPathAddClip( NSBezierPath *path )
{ [path addClip]; }

void BezierPathSetClip( NSBezierPath *path )
{ [path setClip]; }

void BezierPathClipRect( CGRect r )
{ [NSBezierPath clipRect:NSRectFromCGRect(r)]; }

BOOL BezierPathContainsPoint( NSBezierPath *path, CGPoint pt )
{ return [path containsPoint:NSPointFromCGPoint(pt)]; }

CGRect BezierPathBounds( NSBezierPath *path )
{ return NSRectToCGRect( [path bounds] ); }

CGRect BezierPathControlPointBounds( NSBezierPath *path )
{ return NSRectToCGRect( [path controlPointBounds] ); }

CGPoint BezierPathCurrentPoint( NSBezierPath *path )
{ return NSPointToCGPoint([path currentPoint]); }

BOOL BezierPathIsEmpty( NSBezierPath *path )
{ return [path isEmpty]; }

void BezierPathTransformUsingAffineTranform( NSBezierPath *path, NSAffineTransform *tx )
{ [path transformUsingAffineTransform:tx]; }

NSInteger BezierPathElementCount( NSBezierPath *path )
{ return [path elementCount]; }

NSBezierPathElement BezierPathElementAtIndex( NSBezierPath *path, NSInteger index )
{ return [path elementAtIndex:index]; }

NSBezierPathElement BezierPathElementAtIndexAssociatedPoints( NSBezierPath *path, NSInteger index, CGPoint *points )
{ return [path elementAtIndex:index associatedPoints:(NSPointArray)points]; }

void BezierPathRemoveAllPoints( NSBezierPath *path )
{ [path removeAllPoints]; }

void BezierPathSetAssociatedPointsAtIndex( NSBezierPath *path, CGPoint *points, NSInteger index )
{ [path setAssociatedPoints:(NSPointArray)points atIndex:index]; }


#pragma mark - convenience
NSBezierPath *BezierPathWithRotatedRect( CGRect r, CGFloat x, CGFloat y, CGFloat angle )
{
    NSBezierPath *path = [NSBezierPath  bezierPathWithRect:NSRectFromCGRect(r)];

//    NSAffineTransform *tx = AffineTransformInit();
//    AffineTransformTranslate( tx, x, y );
//    AffineTransformRotateByDegrees( tx, angle );
//    AffineTransformConcat( tx );
//    [path transformUsingAffineTransform:tx];
//    AffineTransformInvert( tx );
//    AffineTransformConcat( tx );
    
    NSAffineTransform *tx = [NSAffineTransform transform];
    [tx translateXBy:x yBy:y];
    [tx rotateByDegrees:angle];
    [tx concat];
    [path transformUsingAffineTransform:tx];
    [tx invert];
    [tx concat];

    return path;
}

NSBezierPath *BezierPathWithPolygonInRect( CGRect r, NSInteger sides, CGFloat lineWidth, CGFloat cornerRadius )
{
    NSBezierPath *path  = [NSBezierPath bezierPath];
    CGFloat theta       = 2.0 * M_PI / sides;                           // how much to turn at every corner
    CGFloat offset      = cornerRadius * tan(theta / 2.0);             // offset from which to start rounding corners
    CGFloat squareWidth = MIN(r.size.width, r.size.height);       // width of the square

    // calculate the length of the sides of the polygon
    CGFloat length      = squareWidth - lineWidth;
    if (sides % 4 != 0) {                                               // if not dealing with polygon which will be square with all sides ...
        length = length * cos(theta / 2.0) + offset/2.0;               // ... offset it inside a circle inside the square
    }
    CGFloat sideLength = length * tan(theta / 2.0);

    // start drawing at `point` in lower right corner
    CGPoint point = CGPointMake(r.origin.x + r.size.width / 2.0 + sideLength / 2.0 - offset, r.origin.y + r.size.height / 2.0 + length / 2.0);
    CGFloat angle = M_PI;
    [path moveToPoint:point];

    // draw the sides and rounded corners of the polygon
    for (NSInteger side = 0; side < sides; side++) {
        point = CGPointMake(point.x + (sideLength - offset * 2.0) * cos(angle), point.y + (sideLength - offset * 2.0) * sin(angle));
        [path lineToPoint:point];
        CGPoint center = CGPointMake(point.x + cornerRadius * cos(angle + M_PI_2), point.y + cornerRadius * sin(angle + M_PI_2));
        [path appendBezierPathWithArcWithCenter:center radius:cornerRadius startAngle:(angle - M_PI_2) * 180 / M_PI endAngle:(angle + theta - M_PI_2) * 180 / M_PI clockwise:NO];
        point = path.currentPoint; // we don't have to calculate where the arc ended ... NSBezierPath did that for us
        angle += theta;
    }
    [path closePath];
    path.lineWidth = lineWidth;           // in case we're going to use CoreGraphics to stroke path, rather than CAShapeLayer
    path.lineJoinStyle = NSRoundLineJoinStyle;//kCGLineJoinRound;
    return path;
}

NSBezierPath *BezierPathWithPolygonInRectRotate( CGRect r, NSInteger sides, CGFloat lineWidth, CGFloat cornerRadius, CGFloat rotateAngle )
{
    NSBezierPath *path  = [NSBezierPath bezierPath];
    CGFloat theta       = 2.0 * M_PI / sides;                           // how much to turn at every corner
    CGFloat offset      = cornerRadius * tan(theta / 2.0);             // offset from which to start rounding corners
    CGFloat squareWidth = MIN(r.size.width, r.size.height);       // width of the square

    // calculate the length of the sides of the polygon
    CGFloat length      = squareWidth - lineWidth;
    if (sides % 4 != 0) {                                               // if not dealing with polygon which will be square with all sides ...
        length = length * cos(theta / 2.0) + offset/2.0;               // ... offset it inside a circle inside the square
    }
    CGFloat sideLength = length * tan(theta / 2.0);

    // start drawing at `point` in lower right corner
    CGPoint point = CGPointMake(r.origin.x + r.size.width / 2.0 + sideLength / 2.0 - offset, r.origin.y + r.size.height / 2.0 + length / 2.0);
        
    CGFloat angle = M_PI;
    [path moveToPoint:point];

    // draw the sides and rounded corners of the polygon
    for (NSInteger side = 0; side < sides; side++) {
        point = CGPointMake(point.x + (sideLength - offset * 2.0) * cos(angle), point.y + (sideLength - offset * 2.0) * sin(angle));
        [path lineToPoint:point];
        CGPoint center = CGPointMake(point.x + cornerRadius * cos(angle + M_PI_2), point.y + cornerRadius * sin(angle + M_PI_2));
        [path appendBezierPathWithArcWithCenter:center radius:cornerRadius startAngle:(angle - M_PI_2) * 180 / M_PI endAngle:(angle + theta - M_PI_2) * 180 / M_PI clockwise:NO];
        point = path.currentPoint; // we don't have to calculate where the arc ended ... NSBezierPath did that for us
        angle += theta;
    }
    [path closePath];
    path.lineWidth = lineWidth;           // in case we're going to use CoreGraphics to stroke path, rather than CAShapeLayer
    path.lineJoinStyle = NSRoundLineJoinStyle;//kCGLineJoinRound;
    
    if ( rotateAngle != 0.0 ) {
        NSPoint centerPt = NSMakePoint(NSMidX(r),NSMidY(r));
        NSAffineTransform *transform = [NSAffineTransform new];
        [transform translateXBy:centerPt.x yBy:centerPt.y];
        [transform rotateByDegrees:rotateAngle];
        [transform translateXBy:-centerPt.x yBy:-centerPt.y];
        [path transformUsingAffineTransform: transform];
    }
    
    return path;
}

void BezierPathStrokeFill( NSBezierPath *path, CGFloat lineWidth, NSColor *strokeCol, NSColor *fillCol )
{
    if ( fillCol ) {
        //ColorSetFill( fillCol );
        [fillCol setFill];
        BezierPathFill( path );
    }
    if ( lineWidth > 0 ) {
        if ( strokeCol ) {
            //ColorSetStroke( strokeCol );
            [strokeCol setStroke];
        } else {
            //ColorSetStrokeBlack();
            [[NSColor blackColor] setStroke];
        }
        BezierPathSetLineWidth( path, lineWidth );
        BezierPathStroke( path );
    }
}

void BezierPathStrokeFillOvalInRect( CGRect r, CGFloat lineWidth, NSColor *strokeCol, NSColor *fillCol )
{ BezierPathStrokeFill( BezierPathWithOvalInRect(r), lineWidth, strokeCol, fillCol ); }

void BezierPathStrokeFillRect( CGRect r, CGFloat lineWidth, NSColor *strokeCol, NSColor *fillCol )
{ BezierPathStrokeFill( BezierPathWithRect(r), lineWidth, strokeCol, fillCol );}

void BezierPathStrokeFillRoundedRect( CGRect r, CGFloat xRadius, CGFloat yRadius, CGFloat lineWidth, NSColor *strokeCol, NSColor *fillCol )
{ BezierPathStrokeFill( BezierPathWithRoundedRect(r,xRadius,yRadius), lineWidth, strokeCol, fillCol ); }

void BezierPathStrokeFillPolygon( CFArrayRef pts, CGFloat lineWidth, NSColor *strokeCol, NSColor *fillCol )
{
    NSArray *array = (__bridge NSArray *)pts;
    NSUInteger count = [array count];
    NSBezierPath *path = BezierPathInit();
    CGPoint pt = NSPointToCGPoint([(NSValue *)[array objectAtIndex:0] pointValue]);
    BezierPathMoveToPoint( path, pt );
    for ( NSUInteger index = 1; index < count; index++ ) {
        pt = NSPointToCGPoint([(NSValue *)[array objectAtIndex:index] pointValue]);
        BezierPathLineToPoint( path, pt );
    }
    BezierPathClose( path );
    BezierPathStrokeFill( path, lineWidth, strokeCol, fillCol );
}

void BezierPathStrokeFillRotatedRect( CGRect r, CGFloat x, CGFloat y, CGFloat angle, CGFloat lineWidth, NSColor *strokeCol, NSColor *fillCol )
{
    NSBezierPath *path = [NSBezierPath  bezierPathWithRect:NSRectFromCGRect(r)];
    NSAffineTransform *tx = AffineTransformInit();
    AffineTransformTranslate( tx, x, y );
    AffineTransformRotateByDegrees( tx, angle );
    AffineTransformConcat( tx );
    [path transformUsingAffineTransform:tx];
    AffineTransformInvert( tx );
    AffineTransformConcat( tx );
    [path setLineWidth:lineWidth];
    [fillCol set];
    [path fill];
    [strokeCol set];
    [path stroke];
}

void BezierPathStrokeOvalInRect( CGRect r, CGFloat lineWidth, NSColor *strokeCol )
{ BezierPathStrokeFill( BezierPathWithOvalInRect(r), lineWidth, strokeCol, 0 ); }

void BezierPathStrokeRect( CGRect r, CGFloat lineWidth, NSColor *strokeCol )
{ BezierPathStrokeFill( BezierPathWithRect(r), lineWidth, strokeCol, 0 ); }

void BezierPathStrokeRoundedRect( CGRect r, CGFloat xRadius, CGFloat yRadius, CGFloat lineWidth, NSColor *strokeCol )
{ BezierPathStrokeFill(  BezierPathWithRoundedRect(r,xRadius,yRadius), lineWidth, strokeCol, 0 ); }

void BezierPathStrokeRotatedRect( CGRect r, CGFloat x, CGFloat y, CGFloat angle, CGFloat lineWidth, NSColor *strokeCol )
{
    NSAffineTransform *tx = [NSAffineTransform transform];
    [tx translateXBy:x yBy:y];
    [tx rotateByDegrees:angle];
    [tx concat];
    BezierPathStrokeRect( r, lineWidth, strokeCol );
    [tx invert];
    [tx concat];
}

void BezierPathStrokeLine( CGPoint pt1, CGPoint pt2, CGFloat lineWidth, NSColor *strokeCol )
{
    NSBezierPath *path = BezierPathInit();
    BezierPathMoveToPoint( path, pt1 );
    BezierPathLineToPoint( path, pt2 );
    BezierPathStrokeFill( path, lineWidth, strokeCol, 0 );
}

void BezierPathStrokeCurve( CGPoint pt1, CGPoint pt2, CGPoint cp1, CGPoint cp2, CGFloat lineWidth, NSColor *strokeCol )
{
    NSBezierPath *path = BezierPathInit();
    BezierPathMoveToPoint( path, pt1 );
    BezierPathCurveToPoint( path, pt2, cp1, cp2 );
    BezierPathStrokeFill( path, lineWidth, strokeCol, 0 );
}

void BezierPathStrokePolygon( CFArrayRef pts, CGFloat lineWidth, NSColor *strokeCol )
{
    NSArray *array = (__bridge NSArray *)pts;
    NSUInteger count = [array count];
    NSBezierPath *path = BezierPathInit();
    CGPoint pt = NSPointToCGPoint([(NSValue *)[array objectAtIndex:0] pointValue]);
    BezierPathMoveToPoint( path, pt );
    for ( NSUInteger index = 1; index < count; index++ ) {
        pt = NSPointToCGPoint([(NSValue *)[array objectAtIndex:index] pointValue]);
        BezierPathLineToPoint( path, pt );
    }
    BezierPathClose( path );
    BezierPathStrokeFill( path, lineWidth, strokeCol, 0 );
}

void BezierPathFillOvalInRect( CGRect r, NSColor *fillCol )
{ BezierPathStrokeFill( BezierPathWithOvalInRect(r), 0, 0, fillCol ); }

void BezierPathFillRect( CGRect r, NSColor *fillCol )
{ BezierPathStrokeFill( BezierPathWithRect(r), 0, 0, fillCol ); }

void BezierPathFillRoundedRect( CGRect r, CGFloat xRadius, CGFloat yRadius, NSColor *fillCol )
{ BezierPathStrokeFill( BezierPathWithRoundedRect(r,xRadius,yRadius), 0, 0, fillCol ); }

void BezierPathFillRotatedRect( CGRect r, CGFloat x, CGFloat y, CGFloat angle, NSColor *fillCol )
{
    NSBezierPath *path = [NSBezierPath  bezierPathWithRect:NSRectFromCGRect(r)];
    NSAffineTransform *tx = AffineTransformInit();
    AffineTransformTranslate( tx, x, y );
    AffineTransformRotateByDegrees( tx, angle );
    AffineTransformConcat( tx );
    [path transformUsingAffineTransform:tx];
    AffineTransformInvert( tx );
    AffineTransformConcat( tx );
    [fillCol set];
    [path fill];
}

void BezierPathFillPolygon( CFArrayRef pts, NSColor *fillCol )
{
    NSArray *array = (__bridge NSArray *)pts;
    NSUInteger count = [array count];
    NSBezierPath *path = BezierPathInit();
    CGPoint pt = NSPointToCGPoint([(NSValue *)[array objectAtIndex:0] pointValue]);
    BezierPathMoveToPoint( path, pt );
    for ( NSUInteger index = 1; index < count; index++ ) {
        pt = NSPointToCGPoint([(NSValue *)[array objectAtIndex:index] pointValue]);
        BezierPathLineToPoint( path, pt );
    }
    BezierPathClose( path );
    BezierPathStrokeFill( path, 0, 0, fillCol );
}

//void BezierPathFillRotatedRect( CGRect r, CGFloat x, CGFloat y, CGFloat angle, NSColor *fillCol )
//{
//    NSAffineTransform *tx = AffineTransformInit();
//    AffineTransformTranslate( tx, x, y );
//    AffineTransformRotateByDegrees( tx, angle );
//    AffineTransformConcat( tx );
//    BezierPathFillRect( r, fillCol );
//    AffineTransformInvert( tx );
//    AffineTransformConcat( tx );
//}
