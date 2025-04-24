/*
  CAMediaTimingFunction.h

  Bernie Wylde 20180828
*/

#import "CocoaUI.h"

// Create
CAMediaTimingFunction *CAMediaTimingFunctionWithName( CFStringRef name );
CAMediaTimingFunction *CAMediaTimingFunctionWithControlPoints( float c1x, float c1y, float c2x, float c2y );

// Control points
void CAMediaTimingFunctionGetControlPointAtIndex( CAMediaTimingFunction *ref, long index, float *pt );
