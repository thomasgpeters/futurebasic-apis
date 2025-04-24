/*
 AffineTransform.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

// Class
Class AffineTransformClass( void );

NSAffineTransform *AffineTransformInit( void );
NSAffineTransform *AffineTransformWithTransform( NSAffineTransform *ref );

void AffineTransformRotateByDegrees( NSAffineTransform *tx, CGFloat angle );
void AffineTransformRotateByRadians( NSAffineTransform *tx, CGFloat angle );
void AffineTransformScale( NSAffineTransform *tx, CGFloat scale );
void AffineTransformScaleXY( NSAffineTransform *tx, CGFloat xScale, CGFloat yScale );
void AffineTransformTranslate( NSAffineTransform *tx, CGFloat x, CGFloat y );
void AffineTransformAppend( NSAffineTransform *tx1, NSAffineTransform *tx2 );
void AffineTransformPrepend( NSAffineTransform *tx1, NSAffineTransform *tx2 );
void AffineTransformInvert( NSAffineTransform *tx );
CGPoint AffineTransformPoint( NSAffineTransform *tx, CGPoint pt );
CGSize AffineTransformSize( NSAffineTransform *tx, CGSize size );
NSBezierPath *AffineTransformBezierPath( NSAffineTransform *tx, NSBezierPath *path );

NSAffineTransformStruct AffineTransformStruct( NSAffineTransform *tx );

void AffineTransformSet( NSAffineTransform *tx );
void AffineTransformConcat( NSAffineTransform *tx );
