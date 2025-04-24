/*
 TableHeaderView.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class TableHeaderViewClass( void );

// Table view
NSTableView *TableHeaderViewTableView( NSTableHeaderView *ref );
void TableHeaderViewSetTableView( NSTableHeaderView *ref, NSTableView *tableVw );

// Altered columns
NSInteger TableHeaderViewDraggedColumn( NSTableHeaderView *ref );
CGFloat TableHeaderViewDraggedDistance( NSTableHeaderView *ref );
NSInteger TableHeaderViewResizedColumn( NSTableHeaderView *ref );

// Utility methods
NSInteger TableHeaderViewColumnAtPoint( NSTableHeaderView *ref, CGPoint pt );
CGRect TableHeaderViewHeaderRectOfColumn( NSTableHeaderView *ref, NSInteger col );
