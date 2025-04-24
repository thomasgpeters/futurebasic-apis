/*
 GridView.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "DialogEvent.h"
//#import "View.h"
//#import "Window.h"


#pragma mark - subclass
@interface GridViewSC : NSGridView
@end

@interface NSGridView (Additions)
@property (nonatomic,retain) NSNumber *tagNumber;
- (NSInteger)tag;
- (void)setTag:(NSInteger)tag;
@end

// Class
Class GridViewClass( void );

NSGridView *GridViewWithTag( NSInteger tag );
BOOL GridViewExists( NSInteger tag );

// Info
NSInteger GridViewNumberOfRows( NSInteger tag );
NSInteger GridViewNumberOfColumns( NSInteger tag );
NSInteger GridViewIndexOfColumn( NSInteger tag, NSGridColumn *column );
NSGridRow *GridViewRowAtIndex( NSInteger tag, NSInteger index );
NSGridColumn *GridViewColumnAtIndex( NSInteger tag, NSInteger index );
NSInteger GridViewIndexOfRow( NSInteger tag, NSGridRow *row );

// Add, remove, move rows
NSGridRow *GridViewAddRowWithViews( NSInteger tag, CFArrayRef views );
NSGridRow *GridViewInsertRowWithViews( NSInteger tag, NSInteger index, CFArrayRef views );
void GridViewRemoveRow( NSInteger tag, NSInteger index );
void GridViewMoveRow( NSInteger tag, NSInteger fromIndex, NSInteger toIndex );

// Add, remove, move columns
NSGridColumn *GridViewAddColumnWithViews( NSInteger tag, CFArrayRef views );
NSGridColumn *GridViewInsertColumnWithViews( NSInteger tag, NSInteger index, CFArrayRef views );
void GridViewRemoveColumn( NSInteger tag, NSInteger index );
void GridViewMoveColumn( NSInteger tag, NSInteger fromIndex, NSInteger toIndex );

// Spacing and alignment
CGFloat GridViewColumnSpacing( NSInteger tag );
void GridViewSetColumnSpacing( NSInteger tag, CGFloat spacing );
CGFloat GridViewRowSpacing( NSInteger tag );
void GridViewSetRowSpacing( NSInteger tag, CGFloat spacing );
NSGridRowAlignment GridViewRowAlignment( NSInteger tag );
void GridViewSetRowAlignment( NSInteger tag, NSGridRowAlignment alignment );
NSGridCellPlacement GridViewXPlacement( NSInteger tag );
void GridViewSetXPlacement( NSInteger tag, NSGridCellPlacement placement );
NSGridCellPlacement GridViewYPlacement( NSInteger tag );
void GridViewSetYPlacement( NSInteger tag, NSGridCellPlacement placement );

// Create and merge cells
NSGridCell *GridViewCellAtColumnRow( NSInteger tag, NSInteger colIndex, NSInteger rowIndex );
NSGridCell *GridViewCellForView( NSInteger tag, NSInteger vwTag );
void GridViewMergeCells( NSInteger tag, CFRange horizontalRange, CFRange verticalRange );

/*
 GridCell
 */
// Containers
NSGridColumn *GridCellColumn( NSGridCell *ref );
NSGridRow *GridCellRow( NSGridCell *ref );
NSView *GridCellContentView( NSGridCell *ref );
void GridCellSetContentView( NSGridCell *ref, NSView *aView );
NSView *GridCellEmptyContentView( void );

// Formatting
CFArrayRef GridCellCustomPlacementConstraints( NSGridCell *ref );
void GridCellSetCustomPlacementConstraints( NSGridCell *ref, CFArrayRef constraints );
NSGridRowAlignment GridCellRowAlignment( NSGridCell *ref );
void GridCellSetRowAlignment( NSGridCell *ref, NSGridRowAlignment alignment );
NSGridCellPlacement GridCellXPlacement( NSGridCell *ref );
void GridCellSetXPlacement( NSGridCell *ref, NSGridCellPlacement placement );
NSGridCellPlacement GridCellYPlacement( NSGridCell *ref );
void GridCellSetYPlacement( NSGridCell *ref, NSGridCellPlacement placement );

/*
 GridColumn
 */
// Instance properties
NSGridView *GridColumnGridView( NSGridColumn *ref );
BOOL GridColumnIsHidden( NSGridColumn *ref );
void GridColumnSetHidden( NSGridColumn *ref, BOOL flag );
CGFloat GridColumnLeadingPadding( NSGridColumn *ref );
void GridColumnSetLeadingPadding( NSGridColumn *ref, CGFloat padding );
NSInteger GridColumnNumberOfCells( NSGridColumn *ref );
CGFloat GridColumnTrailingPadding( NSGridColumn *ref );
void GridColumnSetTrailingPadding( NSGridColumn *ref, CGFloat padding );
CGFloat GridColumnWidth( NSGridColumn *ref );
void GridColumnSetWidth( NSGridColumn *ref, CGFloat width );
NSGridCellPlacement GridColumnXPlacement( NSGridColumn *ref );
void GridColumnSetXPlacement( NSGridColumn *ref, NSGridCellPlacement placement );

// Instance methods
NSGridCell *GridColumnCellAtIndex( NSGridColumn *ref, NSInteger index );
void GridColumnMergeCells( NSGridColumn *ref, CFRange range );

/*
 GridRow
 */
// Details
NSInteger GridRowNumberOfCells( NSGridRow *ref );
BOOL GridRowIsHidden( NSGridRow *ref );
void GridRowSetHidden( NSGridRow *ref, BOOL flag );

// Formatting
CGFloat GridRowTopPadding( NSGridRow *ref );
void GridRowSetTopPadding( NSGridRow *ref, CGFloat padding );
CGFloat GridRowBottomPadding( NSGridRow *ref );
void GridRowSetBottomPadding( NSGridRow *ref, CGFloat padding );
CGFloat GridRowHeight( NSGridRow *ref );
void GridRowSetHeight( NSGridRow *ref, CGFloat height );
NSGridCellPlacement GridRowYPlacement( NSGridRow *ref );
void GridRowSetYPlacement( NSGridRow *ref, NSGridCellPlacement placement );

// Grid view
NSGridView *GridRowGridView( NSGridRow *ref );

// Cells
NSGridCell *GridRowCellAtIndex( NSGridRow *ref, NSInteger index );

// Merge
void GridRowMergeCells( NSGridRow *ref, CFRange range );


// Init
NSGridView *GridViewInit( NSInteger inTag, CGRect inRect );

// gridview statement
void CUI_GridView( NSInteger inTag, CGRect inRect, NSInteger inNumColumns, NSInteger inNumRows, CFTypeRef inViews, NSInteger inWndTag );

