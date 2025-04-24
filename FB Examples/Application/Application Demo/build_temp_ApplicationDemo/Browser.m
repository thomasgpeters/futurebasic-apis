/*
 Browser.m
 
 Bernie Wylde
 */

#import "Browser.h"

#pragma mark - subclass
@implementation BrowserSC

#pragma mark - menu
- (NSMenu *)menuForEvent:(NSEvent*)theEvent {
    CUI_ViewSubclassMenuForEvent( self, theEvent );
    return DialogEventNSMenu();
}
@end

@implementation CUI_BrowserDelegate

// browser info
- (BOOL)browser:(NSBrowser *)sender isColumnValid:(NSInteger)column {
    return YES;
}

- (NSInteger)browser:(NSBrowser *)sender numberOfRowsInColumn:(NSInteger)column {
    return 0;
}

- (NSInteger)browser:(NSBrowser *)browser numberOfChildrenOfItem:(id)item {
    return 0;
}

- (NSString *)browser:(NSBrowser *)sender titleOfColumn:(NSInteger)column {
    return nil;
}

// selection behavior
- (BOOL)browser:(NSBrowser *)browser shouldTypeSelectForEvent:(NSEvent *)event withCurrentSearchString:(NSString *)searchString {
    return YES;
}

- (NSString *)browser:(NSBrowser *)browser typeSelectStringForRow:(NSInteger)row inColumn:(NSInteger)column {
    return nil;
}

- (NSInteger)browser:(NSBrowser *)browser nextTypeSelectMatchFromRow:(NSInteger)startRow toRow:(NSInteger)endRow inColumn:(NSInteger)column forString:(NSString *)searchString {
    return 0;
}

// selection
- (BOOL)browser:(NSBrowser *)sender selectCellWithString:(NSString *)title inColumn:(NSInteger)column {
    return YES;
}

- (BOOL)browser:(NSBrowser *)sender selectRow:(NSInteger)row inColumn:(NSInteger)column {
    return YES;
}

- (NSIndexSet *)browser:(NSBrowser *)browser selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes inColumn:(NSInteger)column {
    return [NSIndexSet indexSetWithIndex:0];
}

// components
- (id)browser:(NSBrowser *)browser child:(NSInteger)index ofItem:(id)item {
    return nil;
}

- (BOOL)browser:(NSBrowser *)browser isLeafItem:(id)item {
    return YES;
}

- (BOOL)browser:(NSBrowser *)browser shouldEditItem:(id)item {
    return YES;
}

- (id)browser:(NSBrowser *)browser objectValueForItem:(id)item {
    return nil;
}

- (void)browser:(NSBrowser *)browser setObjectValue:(id)object forItem:(id)item {
}

- (id)rootItemForBrowser:(NSBrowser *)browser {
    return nil;
}

- (NSViewController *)browser:(NSBrowser *)browser previewViewControllerForLeafItem:(id)item {
    return nil;
}

- (NSViewController *)browser:(NSBrowser *)browser headerViewControllerForItem:(id)item {
    return nil;
}

// columns
- (void)browser:(NSBrowser *)sender createRowsForColumn:(NSInteger)column inMatrix:(NSMatrix *)matrix {
}

- (void)browser:(NSBrowser *)sender willDisplayCell:(id)cell atRow:(NSInteger)row column:(NSInteger)column {
}

- (void)browser:(NSBrowser *)browser didChangeLastColumn:(NSInteger)oldLastColumn toColumn:(NSInteger)column {
}

// scrolling
- (void)browserWillScroll:(NSBrowser *)sender {
}

- (void)browserDidScroll:(NSBrowser *)sender {
}

// dragging
- (BOOL)browser:(NSBrowser *)browser canDragRowsWithIndexes:(NSIndexSet *)rowIndexes inColumn:(NSInteger)column withEvent:(NSEvent *)event {
    return YES;
}

- (NSImage *)browser:(NSBrowser *)browser draggingImageForRowsWithIndexes:(NSIndexSet *)rowIndexes inColumn:(NSInteger)column withEvent:(NSEvent *)event offset:(NSPointPointer)dragImageOffset {
    return nil;
}

- (NSDragOperation)browser:(NSBrowser *)browser validateDrop:(id<NSDraggingInfo>)info proposedRow:(NSInteger *)row column:(NSInteger *)column dropOperation:(NSBrowserDropOperation *)dropOperation {
    return 0;
}

- (BOOL)browser:(NSBrowser *)browser acceptDrop:(id<NSDraggingInfo>)info atRow:(NSInteger)row column:(NSInteger)column dropOperation:(NSBrowserDropOperation)dropOperation {
    return YES;
}

- (BOOL)browser:(NSBrowser *)browser writeRowsWithIndexes:(NSIndexSet *)rowIndexes inColumn:(NSInteger)column toPasteboard:(NSPasteboard *)pasteboard {
    return YES;
}

// sizing
- (CGFloat)browser:(NSBrowser *)browser shouldSizeColumn:(NSInteger)columnIndex forUserResize:(BOOL)forUserResize toWidth:(CGFloat)suggestedWidth {
    return 0.0;
}

- (CGFloat)browser:(NSBrowser *)browser sizeToFitWidthOfColumn:(NSInteger)columnIndex {
    return 0.0;
}

- (void)browserColumnConfigurationDidChange:(NSNotification *)notification {
}

- (CGFloat)browser:(NSBrowser *)browser heightOfRow:(NSInteger)row inColumn:(NSInteger)columnIndex {
    return 0.0;
}

// cell content
- (BOOL)browser:(NSBrowser *)browser shouldShowCellExpansionForRow:(NSInteger)row column:(NSInteger)column {
    return YES;
}



// action
- (void)doubleAction:(id)sender {
}
@end

CUI_BrowserDelegate *CUI_BrowserDelegateObj( void )
{
    static CUI_BrowserDelegate *sCUI_BrowserDelegate = nil;
    if ( !sCUI_BrowserDelegate ) sCUI_BrowserDelegate = [[CUI_BrowserDelegate alloc] init];
    return sCUI_BrowserDelegate;
}

// Class
Class BrowserClass( void )
{ return [NSBrowser class]; }

NSBrowser *BrowserWithTag( NSInteger tag )
{ return (NSBrowser *)CUI_ValidateViewKindOfClass( tag, [NSBrowser class] ); }

BOOL BrowserExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSBrowser class] ); }


// Configure
BOOL BrowserReusesColumns( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b reusesColumns];
    return NO;
}

void BrowserSetReusesColumns( NSInteger tag, BOOL flag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setReusesColumns:flag];
}

NSInteger BrowserMaxVisibleColumns( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b maxVisibleColumns];
    return 0;
}

void BrowserSetMaxVisibleColumns( NSInteger tag, NSInteger cols )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setMaxVisibleColumns:cols];
}

BOOL BrowserAutohidesScroller( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b autohidesScroller];
    return NO;
}

void BrowserSetAutohidesScroller( NSInteger tag, BOOL flag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setAutohidesScroller:flag];
}

NSColor *BrowserBackgroundColor( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b backgroundColor];
    return nil;
}

void BrowserSetBackgroundColor( NSInteger tag, NSColor *col )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setBackgroundColor:col];
}

CGFloat BrowserMinColumnWidth( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b minColumnWidth];
    return 0.0;
}

void BrowserSetMinColumnWidth( NSInteger tag, CGFloat wdth )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setMinColumnWidth:wdth];
}

BOOL BrowserSeparatesColumns( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b separatesColumns];
    return NO;
}

void BrowserSetSeparatesColumns( NSInteger tag, BOOL flag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setSeparatesColumns:flag];
}

BOOL BrowserTakesTitleFromPreviousColumn( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b takesTitleFromPreviousColumn];
    return NO;
}

void BrowserSetTakesTitleFromPreviousColumn( NSInteger tag, BOOL flag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setTakesTitleFromPreviousColumn:flag];
}

void BrowserTile( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b tile];
}

// Info
BOOL BrowserIsOpaque( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b isOpaque];
    return NO;
}

// Component types
void BrowserSetCellClass( NSInteger tag, Class cellClass )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setCellClass:cellClass];
}

CFTypeRef BrowserCellPrototype( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return (__bridge CFTypeRef)[b cellPrototype];
    return nil;
}

void BrowserSetCellPrototype( NSInteger tag, CFTypeRef prototype )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setCellPrototype:(__bridge id)prototype];
}

// Selection behavior
BOOL BrowserAllowsBranchSelection( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b allowsBranchSelection];
    return NO;
}

void BrowserSetAllowsBranchSelection( NSInteger tag, BOOL flag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setAllowsBranchSelection:flag];
}

BOOL BrowserAllowsEmptySelection( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b allowsEmptySelection];
    return NO;
}

void BrowserSetAllowsEmptySelection( NSInteger tag, BOOL flag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setAllowsEmptySelection:flag];
}

BOOL BrowserAllowsMultipleSelection( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b allowsMultipleSelection];
    return NO;
}

void BrowserSetAllowsMultipleSelection( NSInteger tag, BOOL flag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setAllowsMultipleSelection:flag];
}

NSIndexSet *BrowserSelectedRowIndexes( NSInteger tag, NSInteger column )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b selectedRowIndexesInColumn:column];
    return nil;
}

void BrowserSelectRowIndexes( NSInteger tag, NSInteger column, NSIndexSet *indexes )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b selectRowIndexes:indexes inColumn:column];
}

BOOL BrowserAllowsTypeSelect( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b allowsTypeSelect];
    return NO;
}

void BrowserSetAllowsTypeSelect( NSInteger tag, BOOL flag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setAllowsTypeSelect:flag];
}

// Managing selection
CFTypeRef BrowserSelectedCell( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return (__bridge CFTypeRef)[b selectedCell];
    return nil;
}

CFTypeRef BrowserSelectedCellInColumn( NSInteger tag, NSInteger column )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return (__bridge CFTypeRef)[b selectedCellInColumn:column];
    return nil;
}

CFArrayRef BrowserSelectedCells( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return (__bridge CFArrayRef)[b selectedCells];
    return nil;
}

void BrowserSelectAll( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b selectAll:nil];
}

NSInteger BrowserSelectedRow( NSInteger tag, NSInteger column )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b selectedRowInColumn:column];
    return -1;
}

void BrowserSelectRow( NSInteger tag, NSInteger row, NSInteger column )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b selectRow:row inColumn:column];
}

NSIndexPath *BrowserSelectionIndexPath( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b selectionIndexPath];
    return nil;
}

void BrowserSetSelectionIndexPath( NSInteger tag, NSIndexPath *indexPath )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setSelectionIndexPath:indexPath];
}

CFArrayRef BrowserSelectionIndexPaths( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return (__bridge CFArrayRef)[b selectionIndexPaths];
    return nil;
}

void BrowserSetSelectionIndexPaths( NSInteger tag, CFArrayRef indexPaths )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setSelectionIndexPaths:(__bridge NSArray *)indexPaths];
}

// Components
CFTypeRef BrowserLoadedCell( NSInteger tag, NSInteger row, NSInteger column )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return (__bridge CFTypeRef)[b loadedCellAtRow:row column:column];
    return nil;
}

void BrowserEditItemAtIndexPath( NSInteger tag, NSIndexPath *indexPath, NSEvent *ev, BOOL select )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b editItemAtIndexPath:indexPath withEvent:ev select:select];
}

CFTypeRef BrowserItemAtIndexPath( NSInteger tag, NSIndexPath *indexPath )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return (__bridge CFTypeRef)[b itemAtIndexPath:indexPath];
    return nil;
}

CFTypeRef BrowserItemAtRow( NSInteger tag, NSInteger row, NSInteger column )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return (__bridge CFTypeRef)[b itemAtRow:row inColumn:column];
    return nil;
}

NSIndexPath *BrowserIndexPath( NSInteger tag, NSInteger column )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b indexPathForColumn:column];
    return nil;
}

BOOL BrowserIsLeafItem( NSInteger tag, CFTypeRef item )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b isLeafItem:(__bridge id)item];
    return NO;
}

CFTypeRef BrowserParentForItemsInColumn( NSInteger tag, NSInteger column )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return (__bridge CFTypeRef)[b parentForItemsInColumn:column];
    return nil;
}

// Path
CFStringRef BrowserPath( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return (__bridge CFStringRef)[b path];
    return nil;
}

void BrowserSetPath( NSInteger tag, CFStringRef path )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setPath:(__bridge NSString *)path];
}

CFStringRef BrowserPathToColumn( NSInteger tag, NSInteger column )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return (__bridge CFStringRef)[b pathToColumn:column];
    return nil;
}

CFStringRef BrowserPathSeparator( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return (__bridge CFStringRef)[b pathSeparator];
    return nil;
}

void BrowserSetPathSeparator( NSInteger tag, CFStringRef separator )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setPathSeparator:(__bridge NSString *)separator];
}

// Columns
void BrowserAddColumn( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b addColumn];
}

NSInteger BrowserSelectedColumn( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b selectedColumn];
    return -1;
}

NSInteger BrowserLastColumn( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b lastColumn];
    return -1;
}

NSInteger BrowserFirstVisibleColumn( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b firstVisibleColumn];
    return -1;
}

NSInteger BrowserNumberOfVisibleColumns( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b numberOfVisibleColumns];
    return 0;
}

NSInteger BrowserLastVisibleColumn( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b lastVisibleColumn];
    return -1;
}

void BrowserValidateVisibleColumns( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b validateVisibleColumns];
}

BOOL BrowserIsLoaded( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b isLoaded];
    return NO;
}

void BrowserLoadColumnZero( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b loadColumnZero];
}

void BrowserReloadColumn( NSInteger tag, NSInteger column )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b reloadColumn:column];
}

// Column titles
CFStringRef BrowserTitleOfColumn( NSInteger tag, NSInteger column )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return (__bridge CFStringRef)[b titleOfColumn:column];
    return nil;
}

void BrowserSetTitleOfColumn( NSInteger tag, NSInteger column, CFStringRef title )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setTitle:(__bridge NSString *)title ofColumn:column];
}

BOOL BrowserIsTitled( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b isTitled];
    return NO;
}

void BrowserSetTitled( NSInteger tag, BOOL flag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setTitled:flag];
}

void BrowserDrawTitleOfColumnInRect( NSInteger tag, NSInteger column, CGRect r )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b drawTitleOfColumn:column inRect:NSRectFromCGRect(r)];
}

CGFloat BrowserTitleHeight( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b titleHeight];
    return 0.0;
}

CGRect BrowserTitleFrameOfColumn( NSInteger tag, NSInteger column )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return NSRectToCGRect([b titleFrameOfColumn:column]);
    return CGRectZero;
}

// Updating
void BrowserNoteHeightOfRowsWithIndexesChanged( NSInteger tag, NSIndexSet *rowIndexes, NSInteger column )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b noteHeightOfRowsWithIndexesChanged:rowIndexes inColumn:column];
}

void BrowserReloadData( NSInteger tag, NSIndexSet *rowIndexes, NSInteger column )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b reloadDataForRowIndexes:rowIndexes inColumn:column];
}

// Scrolling
BOOL BrowserHasHorizontalScroller( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b hasHorizontalScroller];
    return NO;
}

void BrowserSetHasHorizontalScroller( NSInteger tag, BOOL flag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setHasHorizontalScroller:flag];
}

void BrowserScrollColumnToVisible( NSInteger tag, NSInteger column )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b scrollColumnToVisible:column];
}

void BrowserScrollColumnsLeft( NSInteger tag, NSInteger shiftAmount )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b scrollColumnsLeftBy:shiftAmount];
}

void BrowserScrollColumnsRight( NSInteger tag, NSInteger shiftAmount )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b scrollColumnsRightBy:shiftAmount];
}

void BrowserScrollRowToVisible( NSInteger tag, NSInteger row, NSInteger column )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b scrollRowToVisible:row inColumn:column];
}


// Dragging
NSDragOperation BrowserDraggingSourceOperationMask( NSInteger tag, BOOL localDestination )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b draggingSourceOperationMaskForLocal:localDestination];
    return 0;
}

void BrowserSetDraggingSourceOperationMask( NSInteger tag, NSDragOperation mask, BOOL isLocal )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setDraggingSourceOperationMask:mask forLocal:isLocal];
}

BOOL BrowserCanDragRows( NSInteger tag, NSIndexSet *rowIndexes, NSInteger column, NSEvent *evnt )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b canDragRowsWithIndexes:rowIndexes inColumn:column withEvent:evnt];
    return NO;
}

NSImage *BrowserDraggingImage( NSInteger tag, NSIndexSet *rowIndexes, NSInteger column, NSEvent *evnt, CGPoint *offset )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b draggingImageForRowsWithIndexes:rowIndexes inColumn:column withEvent:evnt offset:(NSPointPointer)offset];
    return nil;
}

CFArrayRef BrowserNamesOfPromisedFilesDroppedAtDestination( NSInteger tag, CFURLRef dropDestination )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return (__bridge CFArrayRef)[b namesOfPromisedFilesDroppedAtDestination:(__bridge NSURL *)dropDestination];
    return nil;
}

// Column frames
CGRect BrowserFrameOfColumn( NSInteger tag, NSInteger column )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return NSRectToCGRect([b frameOfColumn:column]);
    return CGRectZero;
}

CGRect BrowserFrameOfInsideOfColumn( NSInteger tag, NSInteger column )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return NSRectToCGRect([b frameOfInsideOfColumn:column]);
    return CGRectZero;
}

// Row frames
CGRect BrowserFrameOfRow( NSInteger tag, NSInteger row, NSInteger column )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return NSRectToCGRect([b frameOfRow:row inColumn:column]);
    return CGRectZero;
}

BOOL BrowserGetRowColumnForPoint( NSInteger tag, NSInteger *row, NSInteger *column, CGPoint pt )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b getRow:row column:column forPoint:NSPointFromCGPoint(pt)];
    return NO;
}

// Actions
SEL BrowserDoubleAction( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b doubleAction];
    return nil;
}

void BrowserSetDoubleAction( NSInteger tag, SEL selector )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setDoubleAction:selector];
}

BOOL BrowserSendsActionOnArrowKeys( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b sendsActionOnArrowKeys];
    return NO;
}

void BrowserSetSendsActionOnArrowKeys( NSInteger tag, BOOL flag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setSendsActionOnArrowKeys:flag];
}

BOOL BrowserSendAction( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b sendAction];
    return NO;
}

// Mouse-click events
void BrowserDoClick( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b doClick:nil];
}

void BrowserDoDoubleClick( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b doDoubleClick:nil];
}

NSInteger BrowserClickedColumn( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b clickedColumn];
    return -1;
}

NSInteger BrowserClickedRow( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b clickedRow];
    return -1;
}

// Sizing
void BrowserRemoveSavedColumnsWithAutosaveName( CFStringRef name )
{ [NSBrowser removeSavedColumnsWithAutosaveName:(__bridge NSString *)name]; }

CFStringRef BrowserColumnsAutosaveName( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return (__bridge CFStringRef)[b columnsAutosaveName];
    return nil;
}

void BrowserSetColumnsAutosaveName( NSInteger tag, CFStringRef name )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setColumnsAutosaveName:(__bridge NSString *)name];
}

CGFloat BrowserColumnContentWidthForColumnWidth( NSInteger tag, CGFloat columnWidth )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b columnContentWidthForColumnWidth:columnWidth];
    return 0.0;
}

CGFloat BrowserColumnWidthForColumnContentWidth( NSInteger tag, CGFloat contentWidth )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b columnWidthForColumnContentWidth:contentWidth];
    return 0.0;
}

NSBrowserColumnResizingType BrowserColumnResizingType( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b columnResizingType];
    return 0;
}

void BrowserSetColumnResizingType( NSInteger tag, NSBrowserColumnResizingType type )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setColumnResizingType:type];
}

BOOL BrowserPrefersAllColumnUserResizing( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b prefersAllColumnUserResizing];
    return NO;
}

void BrowserSetPrefersAllColumnUserResizing( NSInteger tag, BOOL flag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setPrefersAllColumnUserResizing:flag];
}

CGFloat BrowserWidthOfColumn( NSInteger tag, NSInteger column )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b widthOfColumn:column];
    return 0.0;
}

void BrowserSetWidthOfColumn( NSInteger tag, NSInteger column, CGFloat wdth )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setWidth:wdth ofColumn:column];
}

CGFloat BrowserDefaultColumnWidth( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b defaultColumnWidth];
    return 0.0;
}

void BrowserSetDefaultColumnWidth( NSInteger tag, CGFloat wdth )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setDefaultColumnWidth:wdth];
}

CGFloat BrowserRowHeight( NSInteger tag )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) return [b rowHeight];
    return 0.0;
}

void BrowserSetRowHeight( NSInteger tag, CGFloat height )
{
    NSBrowser *b = BrowserWithTag( tag );
    if ( b ) [b setRowHeight:height];
}

