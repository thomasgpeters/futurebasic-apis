/*
  CAMediaTimingFunction.m

  Bernie Wylde 20180828
*/

#import "CAMediaTimingFunction.h"

// Create
CAMediaTimingFunction *CAMediaTimingFunctionWithName( CFStringRef name )
{ return [CAMediaTimingFunction functionWithName:(__bridge NSString *)name]; }

CAMediaTimingFunction *CAMediaTimingFunctionWithControlPoints( float c1x, float c1y, float c2x, float c2y )
{ return [CAMediaTimingFunction functionWithControlPoints:c1x :c1y :c2x :c2y]; }

// Control points
void CAMediaTimingFunctionGetControlPointAtIndex( CAMediaTimingFunction *ref, long index, float *pt )
{ [ref getControlPointAtIndex:index values:pt]; }

