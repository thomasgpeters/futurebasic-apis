/*
 TableColumn.m

 Bernie Wylde
 */

#import "TableColumn.h"

// Class
Class TableColumnClass( void )
{ return [NSTableColumn class]; }

// Create
NSTableColumn *TableColumnWithIdentifier( CFStringRef identifier )
{
#if __has_feature(objc_arc)
    return [[NSTableColumn alloc] initWithIdentifier:(__bridge NSString *)identifier];
#else
    return [[[NSTableColumn alloc] initWithIdentifier:(__bridge NSString *)identifier] autorelease];
#endif
}

// TableView
NSTableView *TableColumnTableView( NSTableColumn *ref )
{ return [ref tableView]; }

void TableColumnSetTableView( NSTableColumn *ref, NSTableView *tv )
{ [ref setTableView:tv]; }

// Size
CGFloat TableColumnWidth( NSTableColumn *ref )
{ return [ref width]; }

void TableColumnSetWidth( NSTableColumn *ref, CGFloat width )
{ [ref setWidth:width]; }

CGFloat TableColumnMinWidth( NSTableColumn *ref )
{ return [ref minWidth]; }

void TableColumnSetMinWidth( NSTableColumn *ref, CGFloat width )
{ [ref setMinWidth:width]; }

CGFloat TableColumnMaxWidth( NSTableColumn *ref )
{ return [ref maxWidth]; }

void TableColumnSetMaxWidth( NSTableColumn *ref, CGFloat width )
{ [ref setMaxWidth:width]; }

NSUInteger TableColumnResizingMask( NSTableColumn *ref )
{ return [ref resizingMask]; }

void TableColumnSetResizingMask( NSTableColumn *ref, NSUInteger mask )
{ [ref setResizingMask:mask]; }

void TableColumnSizeToFit(  NSTableColumn *ref )
{ [ref sizeToFit]; }

// Header
CFStringRef TableColumnTitle( NSTableColumn *ref )
{ return (__bridge CFStringRef)[ref title]; }

void TableColumnSetTitle( NSTableColumn *ref, CFStringRef title )
{ [ref setTitle:(__bridge NSString *)title]; }

NSTableHeaderCell *TableColumnHeaderCell( NSTableColumn *ref )
{ return [ref headerCell]; }

void TableColumnSetHeaderCell( NSTableColumn *ref, NSTableHeaderCell *cell )
{
    if ( [cell isKindOfClass:[TableHeaderCellSC class]] ) {// 20210204
        [(TableHeaderCellSC *)cell setColumnIdentifier:[ref identifier]];
    }
    [ref setHeaderCell:cell];
}

// Identifier
CFStringRef TableColumnIdentifier( NSTableColumn *ref )
{ return (__bridge CFStringRef)[ref identifier]; }

void TableColumnSetIdentifier( NSTableColumn *ref, CFStringRef identifier )
{ [ref setIdentifier:(__bridge NSString *)identifier]; }

// Sorting
NSSortDescriptor *TableColumnSortDescriptorPrototype( NSTableColumn *ref )
{ return [ref sortDescriptorPrototype]; }

void TableColumnSetSortDescriptorPrototype( NSTableColumn *ref, NSSortDescriptor *sortDescriptor )
{ [ref setSortDescriptorPrototype:sortDescriptor]; }

// Visibility
BOOL TableColumnIsHidden( NSTableColumn *ref )
{ return [ref isHidden]; }

void TableColumnSetHidden( NSTableColumn *ref, BOOL flag )
{ [ref setHidden:flag]; }

// Tooltip
CFStringRef TableColumnHeaderToolTip( NSTableColumn *ref )
{ return (__bridge CFStringRef)[ref headerToolTip]; }

void TableColumnSetHeaderToolTip( NSTableColumn *ref, CFStringRef tooltip )
{ [ref setHeaderToolTip:(__bridge NSString *)tooltip]; }

