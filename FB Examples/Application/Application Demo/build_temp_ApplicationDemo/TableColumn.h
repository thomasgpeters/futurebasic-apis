/*
 TableColumn.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class TableColumnClass( void );

// Create
NSTableColumn *TableColumnWithIdentifier( CFStringRef identifier );

// TableView
NSTableView *TableColumnTableView( NSTableColumn *ref );
void TableColumnSetTableView( NSTableColumn *ref, NSTableView *tv );

// Size
CGFloat TableColumnWidth( NSTableColumn *ref );
void TableColumnSetWidth( NSTableColumn *ref, CGFloat width );
CGFloat TableColumnMinWidth( NSTableColumn *ref );
void TableColumnSetMinWidth( NSTableColumn *ref, CGFloat width );
CGFloat TableColumnMaxWidth( NSTableColumn *ref );
void TableColumnSetMaxWidth( NSTableColumn *ref, CGFloat width );
NSUInteger TableColumnResizingMask( NSTableColumn *ref );
void TableColumnSetResizingMask( NSTableColumn *ref, NSUInteger mask );
void TableColumnSizeToFit(  NSTableColumn *ref );

// Header
CFStringRef TableColumnTitle( NSTableColumn *ref );
void TableColumnSetTitle( NSTableColumn *ref, CFStringRef title );
NSTableHeaderCell *TableColumnHeaderCell( NSTableColumn *ref );
void TableColumnSetHeaderCell( NSTableColumn *ref, NSTableHeaderCell *cell );

// Identifier
CFStringRef TableColumnIdentifier( NSTableColumn *ref );
void TableColumnSetIdentifier( NSTableColumn *ref, CFStringRef identifier );

// Sorting
NSSortDescriptor *TableColumnSortDescriptorPrototype( NSTableColumn *ref );
void TableColumnSetSortDescriptorPrototype( NSTableColumn *ref, NSSortDescriptor *sortDescriptor );

// Visibility
BOOL TableColumnIsHidden( NSTableColumn *ref );
void TableColumnSetHidden( NSTableColumn *ref, BOOL flag );

// Tooltip
CFStringRef TableColumnHeaderToolTip( NSTableColumn *ref );
void TableColumnSetHeaderToolTip( NSTableColumn *ref, CFStringRef tooltip );
