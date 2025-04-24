/*
 Browser.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

#import "View.h"

#pragma mark - subclass
@interface BrowserSC : NSBrowser
@end

@interface CUI_BrowserDelegate : NSObject <NSBrowserDelegate> {
}
- (void)doubleAction:(id)sender;
@end

CUI_BrowserDelegate *CUI_BrowserDelegateObj( void );

// Class
Class BrowserClass( void );

NSBrowser *BrowserWithTag( NSInteger tag );
BOOL BrowserExists( NSInteger tag );

// Configure
BOOL BrowserReusesColumns( NSInteger tag );
void BrowserSetReusesColumns( NSInteger tag, BOOL flag );
NSInteger BrowserMaxVisibleColumns( NSInteger tag );
void BrowserSetMaxVisibleColumns( NSInteger tag, NSInteger cols );
BOOL BrowserAutohidesScroller( NSInteger tag );
void BrowserSetAutohidesScroller( NSInteger tag, BOOL flag );
NSColor *BrowserBackgroundColor( NSInteger tag );
void BrowserSetBackgroundColor( NSInteger tag, NSColor *col );
CGFloat BrowserMinColumnWidth( NSInteger tag );
void BrowserSetMinColumnWidth( NSInteger tag, CGFloat wdth );
BOOL BrowserSeparatesColumns( NSInteger tag );
void BrowserSetSeparatesColumns( NSInteger tag, BOOL flag );
BOOL BrowserTakesTitleFromPreviousColumn( NSInteger tag );
void BrowserSetTakesTitleFromPreviousColumn( NSInteger tag, BOOL flag );
void BrowserTile( NSInteger tag );

// Info
BOOL BrowserIsOpaque( NSInteger tag );

// Component types
void BrowserSetCellClass( NSInteger tag, Class cellClass );
CFTypeRef BrowserCellPrototype( NSInteger tag );
void BrowserSetCellPrototype( NSInteger tag, CFTypeRef prototype );

// Selection behavior
BOOL BrowserAllowsBranchSelection( NSInteger tag );
void BrowserSetAllowsBranchSelection( NSInteger tag, BOOL flag );
BOOL BrowserAllowsEmptySelection( NSInteger tag );
void BrowserSetAllowsEmptySelection( NSInteger tag, BOOL flag );
BOOL BrowserAllowsMultipleSelection( NSInteger tag );
void BrowserSetAllowsMultipleSelection( NSInteger tag, BOOL flag );
NSIndexSet *BrowserSelectedRowIndexes( NSInteger tag, NSInteger column );
void BrowserSelectRowIndexes( NSInteger tag, NSInteger column, NSIndexSet *indexes );
BOOL BrowserAllowsTypeSelect( NSInteger tag );
void BrowserSetAllowsTypeSelect( NSInteger tag, BOOL flag );

// Managing selection
CFTypeRef BrowserSelectedCell( NSInteger tag );
CFTypeRef BrowserSelectedCellInColumn( NSInteger tag, NSInteger column );
CFArrayRef BrowserSelectedCells( NSInteger tag );
void BrowserSelectAll( NSInteger tag );
NSInteger BrowserSelectedRow( NSInteger tag, NSInteger column );
void BrowserSelectRow( NSInteger tag, NSInteger row, NSInteger column );
NSIndexPath *BrowserSelectionIndexPath( NSInteger tag );
void BrowserSetSelectionIndexPath( NSInteger tag, NSIndexPath *indexPath );
CFArrayRef BrowserSelectionIndexPaths( NSInteger tag );
void BrowserSetSelectionIndexPaths( NSInteger tag, CFArrayRef indexPaths );

// Components
CFTypeRef BrowserLoadedCell( NSInteger tag, NSInteger row, NSInteger column );
void BrowserEditItemAtIndexPath( NSInteger tag, NSIndexPath *indexPath, NSEvent *ev, BOOL select );
CFTypeRef BrowserItemAtIndexPath( NSInteger tag, NSIndexPath *indexPath );
CFTypeRef BrowserItemAtRow( NSInteger tag, NSInteger row, NSInteger column );
NSIndexPath *BrowserIndexPath( NSInteger tag, NSInteger column );
BOOL BrowserIsLeafItem( NSInteger tag, CFTypeRef item );
CFTypeRef BrowserParentForItemsInColumn( NSInteger tag, NSInteger column );

// Path
CFStringRef BrowserPath( NSInteger tag );
void BrowserSetPath( NSInteger tag, CFStringRef path );
CFStringRef BrowserPathToColumn( NSInteger tag, NSInteger column );
CFStringRef BrowserPathSeparator( NSInteger tag );
void BrowserSetPathSeparator( NSInteger tag, CFStringRef separator );

// Columns
void BrowserAddColumn( NSInteger tag );
NSInteger BrowserSelectedColumn( NSInteger tag );
NSInteger BrowserLastColumn( NSInteger tag );
NSInteger BrowserFirstVisibleColumn( NSInteger tag );
NSInteger BrowserNumberOfVisibleColumns( NSInteger tag );
NSInteger BrowserLastVisibleColumn( NSInteger tag );
void BrowserValidateVisibleColumns( NSInteger tag );
BOOL BrowserIsLoaded( NSInteger tag );
void BrowserLoadColumnZero( NSInteger tag );
void BrowserReloadColumn( NSInteger tag, NSInteger column );

// Column titles
CFStringRef BrowserTitleOfColumn( NSInteger tag, NSInteger column );
void BrowserSetTitleOfColumn( NSInteger tag, NSInteger column, CFStringRef title );
BOOL BrowserIsTitled( NSInteger tag );
void BrowserSetTitled( NSInteger tag, BOOL flag );
void BrowserDrawTitleOfColumnInRect( NSInteger tag, NSInteger column, CGRect r );
CGFloat BrowserTitleHeight( NSInteger tag );
CGRect BrowserTitleFrameOfColumn( NSInteger tag, NSInteger column );

// Updating
void BrowserNoteHeightOfRowsWithIndexesChanged( NSInteger tag, NSIndexSet *rowIndexes, NSInteger column );
void BrowserReloadData( NSInteger tag, NSIndexSet *rowIndexes, NSInteger column );

// Scrolling
BOOL BrowserHasHorizontalScroller( NSInteger tag );
void BrowserSetHasHorizontalScroller( NSInteger tag, BOOL flag );
void BrowserScrollColumnToVisible( NSInteger tag, NSInteger column );
void BrowserScrollColumnsLeft( NSInteger tag, NSInteger shiftAmount );
void BrowserScrollColumnsRight( NSInteger tag, NSInteger shiftAmount );
void BrowserScrollRowToVisible( NSInteger tag, NSInteger row, NSInteger column );

// Dragging
NSDragOperation BrowserDraggingSourceOperationMask( NSInteger tag, BOOL localDestination );
void BrowserSetDraggingSourceOperationMask( NSInteger tag, NSDragOperation mask, BOOL isLocal );
BOOL BrowserCanDragRows( NSInteger tag, NSIndexSet *rowIndexes, NSInteger column, NSEvent *evnt );
NSImage *BrowserDraggingImage( NSInteger tag, NSIndexSet *rowIndexes, NSInteger column, NSEvent *evnt, CGPoint *offset );
CFArrayRef BrowserNamesOfPromisedFilesDroppedAtDestination( NSInteger tag, CFURLRef dropDestination );

// Column frames
CGRect BrowserFrameOfColumn( NSInteger tag, NSInteger column );
CGRect BrowserFrameOfInsideOfColumn( NSInteger tag, NSInteger column );

// Row frames
CGRect BrowserFrameOfRow( NSInteger tag, NSInteger row, NSInteger column );
BOOL BrowserGetRowColumnForPoint( NSInteger tag, NSInteger *row, NSInteger *column, CGPoint pt );

// Actions
SEL BrowserDoubleAction( NSInteger tag );
void BrowserSetDoubleAction( NSInteger tag, SEL selector );
BOOL BrowserSendsActionOnArrowKeys( NSInteger tag );
void BrowserSetSendsActionOnArrowKeys( NSInteger tag, BOOL flag );
BOOL BrowserSendAction( NSInteger tag );

// Mouse-click events
void BrowserDoClick( NSInteger tag );
void BrowserDoDoubleClick( NSInteger tag );
NSInteger BrowserClickedColumn( NSInteger tag );
NSInteger BrowserClickedRow( NSInteger tag );

// Sizing
void BrowserRemoveSavedColumnsWithAutosaveName( CFStringRef name );
CFStringRef BrowserColumnsAutosaveName( NSInteger tag );
void BrowserSetColumnsAutosaveName( NSInteger tag, CFStringRef name );
CGFloat BrowserColumnContentWidthForColumnWidth( NSInteger tag, CGFloat columnWidth );
CGFloat BrowserColumnWidthForColumnContentWidth( NSInteger tag, CGFloat contentWidth );
NSBrowserColumnResizingType BrowserColumnResizingType( NSInteger tag );
void BrowserSetColumnResizingType( NSInteger tag, NSBrowserColumnResizingType type );
BOOL BrowserPrefersAllColumnUserResizing( NSInteger tag );
void BrowserSetPrefersAllColumnUserResizing( NSInteger tag, BOOL flag );
CGFloat BrowserWidthOfColumn( NSInteger tag, NSInteger column );
void BrowserSetWidthOfColumn( NSInteger tag, NSInteger column, CGFloat wdth );
CGFloat BrowserDefaultColumnWidth( NSInteger tag );
void BrowserSetDefaultColumnWidth( NSInteger tag, CGFloat wdth );
CGFloat BrowserRowHeight( NSInteger tag );
void BrowserSetRowHeight( NSInteger tag, CGFloat height );
