/*
 AffineTransform.m
 
 Bernie Wylde
 */

#import "AffineTransform.h"

// Class
Class AffineTransformClass( void )
{ return [NSAffineTransform class]; }


NSAffineTransform *AffineTransformInit( void )
{ return [NSAffineTransform transform]; }

NSAffineTransform *AffineTransformWithTransform( NSAffineTransform *ref )
{
#if __has_feature(objc_arc)
    return [[NSAffineTransform alloc] initWithTransform:ref];
#else
    return [[[NSAffineTransform alloc] initWithTransform:ref] autorelease];
#endif
}

void AffineTransformRotateByDegrees( NSAffineTransform *tx, CGFloat angle )
{ [tx rotateByDegrees:angle]; }

void AffineTransformRotateByRadians( NSAffineTransform *tx, CGFloat angle )
{ [tx rotateByRadians:angle]; }

void AffineTransformScale( NSAffineTransform *tx, CGFloat scale )
{ [tx scaleBy:scale]; }

void AffineTransformScaleXY( NSAffineTransform *tx, CGFloat xScale, CGFloat yScale )
{ [tx scaleXBy:xScale yBy:yScale]; }

void AffineTransformTranslate( NSAffineTransform *tx, CGFloat x, CGFloat y )
{ [tx translateXBy:x yBy:y]; }

void AffineTransformAppend( NSAffineTransform *tx1, NSAffineTransform *tx2 )
{ [tx1 appendTransform:tx2]; }

void AffineTransformPrepend( NSAffineTransform *tx1, NSAffineTransform *tx2 )
{ [tx1 prependTransform:tx2]; }

void AffineTransformInvert( NSAffineTransform *tx )
{ [tx invert]; }

CGPoint AffineTransformPoint( NSAffineTransform *tx, CGPoint pt )
{ return NSPointToCGPoint([tx transformPoint:NSPointFromCGPoint(pt)]); }

CGSize AffineTransformSize( NSAffineTransform *tx, CGSize size )
{ return NSSizeToCGSize([tx transformSize:NSSizeFromCGSize(size)]); }

NSBezierPath *AffineTransformBezierPath( NSAffineTransform *tx, NSBezierPath *path )
{ return [tx transformBezierPath:path]; }

NSAffineTransformStruct AffineTransformStruct( NSAffineTransform *tx )
{ return [tx transformStruct]; }

void AffineTransformSet( NSAffineTransform *tx )
{ [tx set]; }

void AffineTransformConcat( NSAffineTransform *tx )
{ [tx concat]; }

#pragma mark - Convenience
void AffineTransformFlip( CGRect viewBounds )
{
    NSAffineTransform *tx = [[NSAffineTransform alloc] init];
    [tx translateXBy:0.0 yBy:viewBounds.size.height];
    [tx scaleXBy:1.0 yBy:-1.0];
    [tx concat];
}
