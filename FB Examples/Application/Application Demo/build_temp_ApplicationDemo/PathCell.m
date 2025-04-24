/*
 PathCell.m

 Bernie Wylde
 */

#import "PathCell.h"

// Class
Class PathCellClass( void )
{ return [NSPathCell class]; }

// Control style
void PathCellSetControlSize( NSPathCell *ref, NSControlSize size )
{ [ref setControlSize:size]; }

// Object value
void PathCellSetObjectValue( NSPathCell *ref, CFTypeRef obj )
{ [ref setObjectValue:(__bridge id)obj]; }
