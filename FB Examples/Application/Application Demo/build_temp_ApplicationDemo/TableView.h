/*
 TableView.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "DialogEvent.h"
//#import "Nib.h"
//#import "View.h"
//#import "Window.h"

#define TABLEVIEW_REORDER_PASTEBOARD_TYPE @"com.fb.tableview.reorder.item"

@interface TableViewSC : NSTableView
@end

// dialog events
enum {
    // delegate
    tableViewView = 1600,
    tableViewRowView,
    
    tableViewDidAddRowView,
    tableViewDidRemoveRowView,
    
    tableViewIsGroupRow,
    
    //tableViewWillDisplayCell,
    
    tableViewHeightOfRow,
    tableViewSizeToFitWidthOfColumn,
    
    tableViewSelectionShouldChange,
    tableViewShouldSelectRow,
    tableViewSelectionIndexes,
    tableViewShouldSelectTableColumn,
    tableViewSelectionIsChanging,
    tableViewSelectionDidChange,
    tableViewShouldTypeSelect,
    tableViewTypeSelectString,
    tableViewNextTypeSelectMatch,
    
    tableViewShouldReorderColumn,
    tableViewDidDragTableColumn,
    tableViewColumnDidMove,
    tableViewColumnDidResize,
    
    tableViewDidClickTableColumn,
    tableViewMouseDownInHeader,
    
    tableViewRowActions,
    
    tableViewUserCanChangeVisibilityOfTableColumn,
    tableViewUserDidChangeVisibilityOfTableColumns,
    
    // data source
    tableViewNumberOfRows,
    tableViewPasteboardWriterForRow,
    tableViewAcceptDrop,
    tableViewValidateDrop,
    tableViewWriteRows,
    tableViewDraggingSessionWillBegin,
    tableViewUpdateDraggingItems,
    tableViewDraggingSessionEnded,
    tableViewSortDescriptorsDidChange,
    
    // other actions
    tableViewDoubleAction,
    
    // special events
    tableViewCellTextDidChange,
    tableViewCellTextDidEndEditing
};


@interface CUI_TableViewDelegate : NSObject <NSTableViewDelegate,NSTableViewDataSource,NSTextFieldDelegate>

@property (nonatomic,retain) NSTableView *table;
@property (nonatomic,retain) NSMutableArray *tableData;
@property (nonatomic,assign) NSInteger dragSourceIndex;

@property (nonatomic,assign) NSRange objectRange;// 20200523
@property (nonatomic,retain) NSArray *currentlyDraggedObjects;// 20200523
//@property (nonatomic,assign) NSTableViewDropOperation dropOperation;// 20200526
@property (nonatomic,assign) NSInteger dropOperation;// 20200526// changed to NSInteger to silence clang warning 20210628
@property (nonatomic,assign) BOOL allowsDragCopy;// 20200523

@property (nonatomic,retain) NSColor *textColor;// 20230411

// dialog event values
@property (nonatomic,assign) NSInteger eventNumberOfRows;

@property (nonatomic,assign) NSInteger eventRow;
@property (nonatomic,assign) NSInteger eventColumn;
@property (nonatomic,retain) NSString *eventColumnIdentifier;

@property (nonatomic,retain) NSTableCellView *eventCellView;
@property (nonatomic,retain) NSString *eventCellIdentifier;
@property (nonatomic,retain) NSString *eventCellString;
@property (nonatomic,retain) NSImage *eventCellImage;

@property (nonatomic,assign) CGFloat eventHeightOfRow;

@property (nonatomic,assign) NSTableViewDropOperation eventDropOperation;

- (void)doubleAction:(id)sender;
@end


// params: ( event, tag )
typedef void (*CUI_TableViewDelegateCallbackType)(NSInteger,NSInteger);

// params: ( tag, identifier, row, customViewRef, userData )
typedef void (*CUI_TableCustomCellCallbackType)(NSInteger,CFStringRef,NSInteger,CFTypeRef,void*);

// enumerate callback
typedef void (*CUI_TableViewEnumerateAvailableRowViewsCallbackType)(NSInteger,NSTableRowView *,NSInteger,void*);


CUI_TableViewDelegate *CUI_TableViewDelegateObj( NSInteger tag );

// dialog events
void TableViewEventSetNumberOfRows( NSInteger tag, NSInteger value );

NSInteger TableViewEventRow( NSInteger tag );
NSInteger TableViewEventColumn( NSInteger tag );
CFStringRef TableViewEventColumnIdentifier( NSInteger tag );

NSTableCellView *TableViewEventCellView( NSInteger tag );
void TableViewEventSetCellView( NSInteger tag, NSTableCellView *aView );
CFStringRef TableViewEventCellIdentifier( NSInteger tag );
CFStringRef TableViewEventCellString( NSInteger tag );
void TableViewEventSetCellString( NSInteger tag, CFStringRef string );
NSImage *TableViewEventCellImage( NSInteger tag );
void TableViewEventSetCellImage( NSInteger tag, NSImage *image );

CGFloat TableViewEventHeightOfRow( NSInteger tag );
void TableViewEventSetHeightOfRow( NSInteger tag, CGFloat height );

NSTableViewDropOperation TableViewEventDropOperation( NSInteger tag );
void TableViewEventSetDropOperation( NSInteger tag, NSTableViewDropOperation operation );

@interface NSTableView (Additions)

// delegate callback
@property (nonatomic,retain) NSValue *delegateCallbackValue;
- (CUI_TableViewDelegateCallbackType)delegateCallback;
- (void)setDelegateCallback:(CUI_TableViewDelegateCallbackType)cb;

// custom view callback
@property (nonatomic,retain) NSValue *customCellCallbackValue;
- (CUI_TableCustomCellCallbackType)customCellCallback;
- (void)setCustomCellCallback:(CUI_TableCustomCellCallbackType)cb;

@property (nonatomic,retain) NSValue *customCellUserDataValue;
- (void *)customCellUserData;
- (void)setCustomCellUserData:(void *)userData;

@property (nonatomic,retain) NSArray *customCellIdentifiersArray;
- (NSArray *)customCellIdentifiers;
- (void)setCustomCellIdentifiers:(NSArray *)identifiers;

@end

// Class
Class TableViewClass( void );

NSTableView *TableViewWithTag( NSInteger tag );
BOOL TableViewExists( NSInteger tag );

// Data source
BOOL TableViewUsesStaticContents( NSInteger tag );
void TableViewSetUsesStaticContents( NSInteger tag, BOOL flag );
void TableViewSetData( NSInteger tag, CFMutableArrayRef array );
CFMutableArrayRef TableViewData( NSInteger tag );
void TableViewReloadData( NSInteger tag );
void TableViewReloadDataForRowsColumns( NSInteger tag, NSIndexSet *rows, NSIndexSet *columns );

// Create views
NSTableCellView *TableViewMakeViewWithIdentifier( NSInteger tag, CFStringRef identifier );
NSTableRowView *TableViewRowViewAtRow( NSInteger tag, NSInteger row, BOOL makeIfNecessary );
NSView *TableViewViewAtColumnRow( NSInteger tag, NSInteger column, NSInteger row, BOOL makeIfNecessary );

// Update
void TableViewBeginUpdates( NSInteger tag );
void TableViewEndUpdates( NSInteger tag );
void TableViewMoveRow( NSInteger tag, NSInteger atIndex, NSInteger toIndex );
void TableViewInsertRows( NSInteger tag, NSIndexSet *indexes, NSTableViewAnimationOptions animation );
void TableViewRemoveRows( NSInteger tag, NSIndexSet *indexes, NSTableViewAnimationOptions animation );
NSInteger TableViewRowForView( NSInteger tag, NSView *aView );
NSInteger TableViewColumnForView( NSInteger tag, NSView *aView );

// Target-action
NSInteger TableViewClickedColumn( NSInteger tag );
NSInteger TableViewClickedRow( NSInteger tag );

// Behavior
BOOL TableViewAllowsColumnReordering( NSInteger tag );
void TableViewSetAllowsColumnReordering( NSInteger tag, BOOL flag );
BOOL TableViewAllowsColumnResizing( NSInteger tag );
void TableViewSetAllowsColumnResizing( NSInteger tag, BOOL flag );
BOOL TableViewAllowsMultipleSelection( NSInteger tag );
void TableViewSetAllowsMultipleSelection( NSInteger tag, BOOL flag );
BOOL TableViewAllowsEmptySelection( NSInteger tag );
void TableViewSetAllowsEmptySelection( NSInteger tag, BOOL flag );
BOOL TableViewAllowsColumnSelection( NSInteger tag );
void TableViewSetAllowsColumnSelection( NSInteger tag, BOOL flag );
BOOL TableViewUsesAutomaticRowHeights( NSInteger tag );
void TableViewSetUsesAutomaticRowHeights( NSInteger tag, BOOL flag );

// Display attributes
CGSize TableViewIntercellSpacing( NSInteger tag );
void TableViewSetIntercellSpacing( NSInteger tag, CGSize spacing );
CGFloat TableViewRowHeight( NSInteger tag );
void TableViewSetRowHeight( NSInteger tag, CGFloat height );
NSColor *TableViewBackgroundColor( NSInteger tag );
void TableViewSetBackgroundColor( NSInteger tag, NSColor *col );
BOOL TableViewUsesAlternatingRowBackgroundColors( NSInteger tag );
void TableViewSetUsesAlternatingRowBackgroundColors( NSInteger tag, BOOL flag );
NSTableViewSelectionHighlightStyle TableViewSelectionHighlightStyle( NSInteger tag );
void TableViewSetSelectionHighlightStyle( NSInteger tag, NSTableViewSelectionHighlightStyle style );
NSColor *TableViewGridColor( NSInteger tag );
void TableViewSetGridColor( NSInteger tag, NSColor *col );
NSTableViewGridLineStyle TableViewGridStyleMask( NSInteger tag );
void TableViewSetGridStyleMask( NSInteger tag, NSTableViewGridLineStyle style );
NSImage *TableViewIndicatorImageInTableColumn( NSInteger tag, NSTableColumn *columnRef );
void TableViewSetIndicatorImageInTableColumn( NSInteger tag, NSImage *image, NSTableColumn *columnRef );

// Row size styles
NSTableViewRowSizeStyle TableViewEffectiveRowSizeStyle( NSInteger tag );
NSTableViewRowSizeStyle TableViewRowSizeStyle( NSInteger tag );
void TableViewSetRowSizeStyle( NSInteger tag, NSTableViewRowSizeStyle style );

// Column management
void TableViewAddTableColumn( NSInteger tag, NSTableColumn *columnRef );
void TableViewRemoveTableColumn( NSInteger tag, NSTableColumn *columnRef );
void TableViewMoveColumn( NSInteger tag, NSInteger atIndex, NSInteger toIndex );
CFArrayRef TableViewTableColumns( NSInteger tag );
NSInteger TableViewColumnWithIdentifier( NSInteger tag, CFStringRef identifier );
NSInteger TableViewColumnWithIdentifier( NSInteger tag, CFStringRef identifier );
NSTableColumn *TableViewTableColumnWithIdentifier( NSInteger tag, CFStringRef identifier );

// Selecting columns and rows
void TableViewSelectColumns( NSInteger tag, NSIndexSet *columnIndexes, BOOL extendSelection );
NSInteger TableViewSelectedColumn( NSInteger tag );
NSIndexSet *TableViewSelectedColumns( NSInteger tag );
void TableViewDeselectColumn( NSInteger tag, NSInteger columnIndex );
NSInteger TableViewNumberOfSelectedColumns( NSInteger tag );
BOOL TableViewIsColumnSelected( NSInteger tag, NSInteger columnIndex );
void TableViewSelectRows( NSInteger tag, NSIndexSet *rowIndexes, BOOL extendSelection );
void TableViewSelectRow( NSInteger tag, NSInteger row );
NSInteger TableViewSelectedRow( NSInteger tag );
NSIndexSet *TableViewSelectedRowIndexes( NSInteger tag );
void TableViewDeselectRow( NSInteger tag, NSInteger row );
NSInteger TableViewNumberOfSelectedRows( NSInteger tag );
BOOL TableViewIsRowSelected( NSInteger tag, NSInteger row );
void TableViewSelectAll( NSInteger tag );
void TableViewDeselectAll( NSInteger tag );

// Enumerating rows
void TableViewEnumerateAvailableRowViews( NSInteger tag, CUI_TableViewEnumerateAvailableRowViewsCallbackType callback, void *userData );

// Type select
BOOL TableViewAllowsTypeSelect( NSInteger tag );
void TableViewSetAllowsTypeSelect( NSInteger tag, BOOL flag );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
NSTableViewStyle TableViewStyle( NSInteger tag );
API_AVAILABLE(macos(11.0))
void TableViewSetStyle( NSInteger tag, NSTableViewStyle style );
API_AVAILABLE(macos(11.0))
NSTableViewStyle TableViewEffectiveStyle( NSInteger tag );
#endif// 110000

// Dimensions
NSInteger TableViewNumberOfColumns( NSInteger tag );

// Floating rows
BOOL TableViewFloatsGroupRows( NSInteger tag );
void TableViewSetFloatsGroupRows( NSInteger tag, BOOL flag );

// Editing cells
void TableViewEditColumnRow( NSInteger tag, NSInteger columnIndex, NSInteger row, BOOL selectFlag );

// Auxiliary views
NSTableHeaderView *TableViewHeaderView( NSInteger tag );
void TableViewSetHeaderView( NSInteger tag, NSTableHeaderView *headerView );
NSView *TableViewCornerView( NSInteger tag );
void TableViewSetCornerView( NSInteger tag, NSView *cornerView );

// Layout support
NSUserInterfaceLayoutDirection TableViewUserInterfaceLayoutDirection( NSInteger tag );
void TableViewSetUserInterfaceLayoutDirection( NSInteger tag, NSUserInterfaceLayoutDirection direction );
CGRect TableViewRectOfColumn( NSInteger tag, NSInteger col );
CGRect TableViewRectOfRow( NSInteger tag, NSInteger row );
CFRange TableViewRowsInRect( NSInteger tag, CGRect r );
NSIndexSet *TableViewColumnIndexesInRect( NSInteger tag, CGRect r );
NSInteger TableViewColumnAtPoint( NSInteger tag, CGPoint pt );
NSInteger TableViewRowAtPoint( NSInteger tag, CGPoint pt );
CGRect TableViewFrameOfCell( NSInteger tag, NSInteger col, NSInteger row );
NSTableViewColumnAutoresizingStyle TableViewColumnAutoresizingStyle( NSInteger tag );
void TableViewSetColumnAutoresizingStyle( NSInteger tag, NSTableViewColumnAutoresizingStyle style );
void TableViewSizeLastColumnToFit( NSInteger tag );
void TableViewTile( NSInteger tag );
void TableViewSizeToFit( NSInteger tag );
void TableViewNoteHeightOfRowsWithIndexesChanged( NSInteger tag, NSIndexSet *indexSet );

// Scrolling
void TableViewScrollRowToVisible( NSInteger tag, NSInteger row );
void TableViewScrollColumnToVisible( NSInteger tag, NSInteger col );

// Column state persistence
BOOL TableViewAutosaveColumns( NSInteger tag );
void TableViewSetAutosaveColumns( NSInteger tag, BOOL flag );
CFStringRef TableViewAutosaveName( NSInteger tag );
void TableViewSetAutosaveName( NSInteger tag, CFStringRef name );

// Highlightable column headers
NSTableColumn *TableViewHighlightedTableColumn( NSInteger tag );
void TableViewSetHighlightedTableColumn( NSInteger tag, NSTableColumn *columnRef );

// Dragging
BOOL TableViewCanDragRows( NSInteger tag, NSIndexSet *rowIndexes, CGPoint atPoint );
void TableViewSetDraggingSourceOperationMask( NSInteger tag, NSDragOperation operation, BOOL forLocal );
BOOL TableViewVerticalMotionCanBeginDrag( NSInteger tag );
void TableViewSetVerticalMotionCanBeginDrag( NSInteger tag, BOOL flag );
NSTableViewDraggingDestinationFeedbackStyle TableViewDraggingDestinationFeedbackStyle( NSInteger tag );
void TableViewSetDraggingDestinationFeedbackStyle( NSInteger tag, NSTableViewDraggingDestinationFeedbackStyle style );
void TableViewSetDropRow( NSInteger tag, NSInteger row, NSTableViewDropOperation operation );

// Sorting
CFArrayRef TableViewSortDescriptors( NSInteger tag );
void TableViewSetSortDescriptors( NSInteger tag, CFArrayRef descriptors );

// Row actions
BOOL TableViewRowActionsVisible( NSInteger tag );
void TableViewSetRowActionsVisible( NSInteger tag, BOOL flag );

// Hiding and showing rows
void TableViewHideRow( NSInteger tag, NSInteger rowIndex, NSTableViewAnimationOptions animation );
void TableViewHideRows( NSInteger tag, NSIndexSet *indexes, NSTableViewAnimationOptions animation );
void TableViewUnhideRow( NSInteger tag, NSInteger rowIndex, NSTableViewAnimationOptions animation );
void TableViewUnhideRows( NSInteger tag, NSIndexSet *indexes, NSTableViewAnimationOptions animation );
NSIndexSet *TableViewHiddenRowIndexes( NSInteger tag );

// Convenience
void *TableViewView( NSInteger tag, NSInteger row, NSInteger col );
void TableViewSetDelegateCallback( NSInteger tag, CUI_TableViewDelegateCallbackType callback );
void TableViewSetCustomCellCallback( NSInteger tag, CFTypeRef identifiers, CUI_TableCustomCellCallbackType callback, void *userData );
void TableViewCellMakeFirstResponder( NSInteger tag, NSInteger row, NSInteger col );

void TableViewSetHeaderFont( NSInteger tag, NSFont *font );
void TableViewSetHeaderTextColor( NSInteger tag, NSColor *textColor );
void TableViewSetColumnHeaderFont( NSInteger tag, CFStringRef columnIdentifier, NSFont *font );
void TableViewSetColumnHeaderTextColor( NSInteger tag, CFStringRef columnIdentifier, NSColor *textColor );

NSColor *TableViewTextColor( NSInteger tag );
void TableViewSetTextColor( NSInteger tag, NSColor *txtColor );

NSTableViewDropOperation TableViewDropOperation( NSInteger tag );
void TableViewSetDropOperation( NSInteger tag, NSTableViewDropOperation dropOperation );

BOOL TableViewAllowsDragCopy( NSInteger tag );
void TableViewSetAllowsDragCopy( NSInteger tag, BOOL flag );


// Init
NSTableView *TableViewInit( NSInteger inTag, CGRect inRect );

// Statement
void CUI_TableView( NSInteger inTag, NSInteger inEnabled, CGRect inRect, CFTypeRef inColumnIdentifiers, NSInteger inScrollTag, NSInteger inWndTag );
