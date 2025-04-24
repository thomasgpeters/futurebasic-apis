/*
 StringDrawing.m

 Bernie Wylde
 */

#import "StringDrawing.h"


/*
 StringDrawingContext
*/

// Class
Class StringDrawingContextClass( void )
{ return [NSStringDrawingContext class]; }

// Scale factors
CGFloat StringDrawingContextMinimumScaleFactor( NSStringDrawingContext *ref )
{ return [ref minimumScaleFactor]; }

void StringDrawingContextSetMinimumScaleFactor( NSStringDrawingContext *ref, CGFloat factor )
{ [ref setMinimumScaleFactor:factor]; }

CGFloat StringDrawingContextActualScaleFactor( NSStringDrawingContext *ref )
{ return [ref actualScaleFactor]; }

// Bounds
CGRect StringDrawingContextTotalBounds( NSStringDrawingContext *ref )
{ return NSRectToCGRect([ref totalBounds]); }

