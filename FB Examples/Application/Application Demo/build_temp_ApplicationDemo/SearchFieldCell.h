/*
 SearchFieldCell.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class SearchFieldCellClass( void );

// Managing buttons
NSButtonCell *SearchFieldCellSearchButtonCell( NSSearchFieldCell *ref );
void SearchFieldCellResetSearchButtonCell( NSSearchFieldCell *ref );
NSButtonCell *SearchFieldCellCancelButtonCell( NSSearchFieldCell *ref );
void SearchFieldCellResetCancelButtonCell( NSSearchFieldCell *ref );
