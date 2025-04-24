/*
 SearchFieldCell.m

 Bernie Wylde
 */

#import "SearchFieldCell.h"

// Class
Class SearchFieldCellClass( void )
{ return [NSSearchFieldCell class]; }

// Managing buttons
NSButtonCell *SearchFieldCellSearchButtonCell( NSSearchFieldCell *ref )
{ return [ref searchButtonCell]; }

void SearchFieldCellResetSearchButtonCell( NSSearchFieldCell *ref )
{ [ref resetSearchButtonCell]; }

NSButtonCell *SearchFieldCellCancelButtonCell( NSSearchFieldCell *ref )
{ return [ref cancelButtonCell]; }

void SearchFieldCellResetCancelButtonCell( NSSearchFieldCell *ref )
{ [ref resetCancelButtonCell]; }

