/*
 StringDrawing.h

 Bernie Wylde
 */

#import "CocoaUI.h"


/*
 StringDrawingContext
*/

// Class
Class StringDrawingContextClass( void );

// Scale factors
CGFloat StringDrawingContextMinimumScaleFactor( NSStringDrawingContext *ref );
void StringDrawingContextSetMinimumScaleFactor( NSStringDrawingContext *ref, CGFloat factor );
CGFloat StringDrawingContextActualScaleFactor( NSStringDrawingContext *ref );

// Bounds
CGRect StringDrawingContextTotalBounds( NSStringDrawingContext *ref );

