/*
 TableHeaderView.m

 Bernie Wylde
 */

#import "TableHeaderView.h"

// Class
Class TableHeaderViewClass( void )
{ return [NSTableHeaderView class]; }

// Table view
NSTableView *TableHeaderViewTableView( NSTableHeaderView *ref )
{ return [ref tableView]; }

void TableHeaderViewSetTableView( NSTableHeaderView *ref, NSTableView *tableVw )
{ [ref setTableView:tableVw]; }

// Altered columns
NSInteger TableHeaderViewDraggedColumn( NSTableHeaderView *ref )
{ return [ref draggedColumn]; }

CGFloat TableHeaderViewDraggedDistance( NSTableHeaderView *ref )
{ return [ref draggedDistance]; }

NSInteger TableHeaderViewResizedColumn( NSTableHeaderView *ref )
{ return [ref resizedColumn]; }

// Utility methods
NSInteger TableHeaderViewColumnAtPoint( NSTableHeaderView *ref, CGPoint pt )
{ return [ref columnAtPoint:NSPointFromCGPoint(pt)]; }

CGRect TableHeaderViewHeaderRectOfColumn( NSTableHeaderView *ref, NSInteger col )
{ return NSRectToCGRect([ref headerRectOfColumn:col]); }

