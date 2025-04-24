/*
 OutlineView.h

 Bernie Wylde
 */



//#import "DialogEvent.h"
//#import "Window.h"

#define OUTLINEVIEW_REORDER_PASTEBOARD_TYPE @"com.fb.outlineview.reorder.item"

#pragma mark - outlineitem
@interface OutlineItem : NSObject

@property (nonatomic,retain) NSString *string;
@property (nonatomic,retain) NSAttributedString *aString;
@property (nonatomic,retain) NSImage *image;
@property (nonatomic,assign) BOOL isGroup;
@property (nonatomic,retain) NSMutableArray *children;
@property (nonatomic,retain) NSDictionary *columns;
@property (nonatomic,retain) NSMutableDictionary *attributes;

- (id)initWithString:(NSString *)inString image:(NSImage *)inImage isGroup:(BOOL)inIsGroup;
- (id)initWithAttributedString:(NSAttributedString *)inAString image:(NSImage *)inImage isGroup:(BOOL)inIsGroup;
- (id)initWithColumns:(NSDictionary *)inColumns isGroup:(BOOL)inIsGroup;
@end

// Class
Class OutlineViewClass( void );

// Create
OutlineItem *OutlineItemWithString( CFStringRef string, NSImage *image, BOOL isGroup );
OutlineItem *OutlineItemWithAttributedString( CFAttributedStringRef aString, NSImage *image, BOOL isGroup );

OutlineItem *OutlineItemWithColumns( CFDictionaryRef columns, BOOL isGroup );

// Info
CFStringRef OutlineItemString( OutlineItemRef item );
NSImage *OutlineItemImage( OutlineItemRef item );
BOOL OutlineItemIsGroup( OutlineItemRef item );
CFMutableArrayRef OutlineItemChildren( OutlineItemRef item );
CFDictionaryRef OutlineItemColumns( OutlineItemRef item );

// Add
OutlineItem *OutlineItemAddChildWithString( OutlineItemRef parItem, CFStringRef string, NSImage *image, BOOL isGroup );
OutlineItem *OutlineItemAddChildWithAttributedString( OutlineItemRef parItem, CFAttributedStringRef aString, NSImage *image, BOOL isGroup );
void OutlineItemAddChild( OutlineItemRef parItem, OutlineItemRef childItem );
void OutlineItemAddChildColumns( OutlineItemRef parItem, CFDictionaryRef columns, BOOL isGroup );

// Insert
OutlineItemRef OutlineItemInsertChildWithString( OutlineItemRef parItem, CFStringRef string, NSImage *image, BOOL isGroup, NSUInteger index );
void OutlineItemInsertChild( OutlineItemRef parItem, OutlineItemRef childItem, NSUInteger index );
void OutlineItemInsertChildColumns( OutlineItemRef parItem, CFDictionaryRef columns, BOOL isGroup, NSUInteger index );

// Remove
void OutlineItemRemoveChildAtIndex( OutlineItemRef parItem, NSUInteger index );
void OutlineItemRemoveChild( OutlineItemRef parItem, OutlineItemRef childItem );



#pragma mark - outlineview
@interface OutlineViewSC : NSOutlineView
@end

typedef void (*CUI_OutlineViewCallbackType)(NSInteger,NSInteger);

@interface NSOutlineView (Additions)
@property (nonatomic,retain) NSValue *callbackValue;
- (CUI_OutlineViewCallbackType)cuiOutlineViewCallback;
- (void)setCuiOutlineViewCallback:(CUI_OutlineViewCallbackType)cb;
@end


/*
 dialog events
 */
enum {
    // delegate
    outlineViewShouldExpandItem = 3900,
    outlineViewShouldCollapseItem,
    outlineViewTypeSelectStringForTableColumn,
    outlineViewNextTypeSelectMatchFromItem,
    outlineViewShouldTypeSelectForEvent,
    outlineViewToolTipForCell,
    outlineViewShouldSelectTableColumn,
    outlineViewShouldSelectItem,
    outlineViewSelectionIndexesForProposedSelection,
    outlineViewSelectionShouldChange,
    outlineViewSelectionIsChanging,
    outlineViewSelectionDidChange,
    outlineViewWillDisplayCell,
    outlineViewWillDisplayOutlineCell,
    outlineViewDataCellForTableColumn,
    outlineViewShouldShowOutlineCellForItem,
    outlineViewShouldShowCellExpansionForTableColumn,
    outlineViewShouldReorderColumn,
    outlineViewColumnDidMove,
    outlineViewColumnDidResize,
    outlineViewItemWillExpand,
    outlineViewItemDidExpand,
    outlineViewItemWillCollapse,
    outlineViewItemDidCollapse,
    outlineViewShouldEditTableColumn,
    outlineViewMouseDownInHeaderOfTableColumn,
    outlineViewDidClickTableColumn,
    outlineViewDidDragTableColumn,
    outlineViewHeightOfRowByItem,
    outlineViewTintConfigurationForItem,
    outlineViewSizeToFitWidthOfColumn,
    outlineViewShouldTrackCell,
    outlineViewIsGroupItem,
    outlineViewDidAddRowView,
    outlineViewDidRemoveRowView,
    outlineViewRowViewForItem,
    outlineViewViewForTableColumn,
    outlineViewUserCanChangeVisibilityOfTableColumn,
    outlineViewUserDidChangeVisibilityOfTableColumns,

    // data source
    outlineViewAcceptDrop,
    outlineViewChildOfItem,
    outlineViewDraggingSessionEnded,
    outlineViewDraggingSessionWillBegin,
    outlineViewIsItemExpandable,
    outlineViewItemForPersistentObject,
    outlineViewNumberOfChildrenOfItem,
    outlineViewObjectValueForTableColumn,
    outlineViewPasteboardWriterForItem,
    outlineViewPersistentObjectForItem,
    outlineViewSetObjectValueForTableColumn,
    outlineViewSortDescriptorsDidChange,
    outlineViewUpdateDraggingItemsForDrag,
    outlineViewValidateDrop,
    outlineViewWriteItemsToPasteboard,
    
    // other actions
    outlineViewDoubleAction = tableViewDoubleAction
};


@interface CUI_OutlineViewDelegate : NSObject <NSOutlineViewDelegate,NSOutlineViewDataSource,NSTextFieldDelegate,NSPasteboardItemDataProvider> {
//    NSOutlineView *table;
//    NSMutableArray *tableData;
//    OutlineItem *draggedItem;
}
@property (nonatomic,retain) NSOutlineView *table;
@property (nonatomic,retain) NSMutableArray *tableData;
@property (nonatomic,retain) OutlineItem *draggedItem;

- (void)doubleAction:(id)sender;
- (void)singleAction:(id)sender;
@end

NSOutlineView *OutlineViewWithTag( NSInteger tag );
BOOL OutlineViewExists( NSInteger tag );

// Data source
CFTypeRef OutlineViewDataSource( NSInteger tag );
void OutlineViewSetDataSource( NSInteger tag, CFTypeRef ref );
BOOL OutlineViewStronglyReferencesItems( NSInteger tag );
void OutlineViewSetStronglyReferencesItems( NSInteger tag, BOOL flag );

// -- expandability --
BOOL OutlineViewIsItemExpandable( NSInteger tag, OutlineItemRef item );
BOOL OutlineViewIsItemExpanded( NSInteger tag, OutlineItemRef item );

// -- expand/collapse --
void OutlineViewExpandItem( NSInteger tag, OutlineItemRef item );
void OutlineViewExpandItemAndChildren( NSInteger tag, OutlineItemRef item, BOOL expandChildren );
void OutlineViewCollapseItem( NSInteger tag, OutlineItemRef item );
void OutlineViewCollapseItemAndChildren( NSInteger tag, OutlineItemRef item, BOOL collapseChildren );

// -- redisplay --
void OutlineViewReloadItem( NSInteger tag, OutlineItemRef item );
void OutlineViewReloadItemAndChildren( NSInteger tag, OutlineItemRef item, BOOL reloadChildren );

// -- convert between items and rows --
OutlineItemRef OutlineViewItemAtRow( NSInteger tag, NSInteger row );
NSInteger OutlineViewRowForItem( NSInteger tag, OutlineItemRef item );

// Outline column
NSTableColumn *OutlineViewOutlineTableColumn( NSInteger tag );
void OutlineViewSetOutlineTableColumn( NSInteger tag, NSTableColumn *columnRef );
BOOL OutlineViewAutoresizesOutlineColumn( NSInteger tag );
void OutlineViewSetAutoresizesOutlineColumn( NSInteger tag, BOOL flag );

// -- indentation --
NSInteger OutlineViewLevelForItem( NSInteger tag, OutlineItemRef item );
NSInteger OutlineViewLevelForRow( NSInteger tag, NSInteger row );
CGFloat OutlineViewIndentationPerLevel( NSInteger tag );
void OutlineViewSetIndentationPerLevel( NSInteger tag, CGFloat indent );
BOOL OutlineViewIndentationMarkerFollowsCell( NSInteger tag );
void OutlineViewSetIndentationMarkerFollowsCell( NSInteger tag, BOOL flag );

// Persistence
BOOL OutlineViewAutosaveExpandedItems( NSInteger tag );
void OutlineViewSetAutosaveExpandedItems( NSInteger tag, BOOL flag );

// Drag drop
void OutlineViewSetDropItem( NSInteger tag, OutlineItemRef item, NSInteger dropChildIndex );

// -- get related items --
OutlineItemRef OutlineViewParentForItem( NSInteger tag, OutlineItemRef item );

NSInteger OutlineViewChildIndexForItem( NSInteger tag, OutlineItemRef item );

OutlineItemRef OutlineViewChildOfItem( NSInteger tag, NSInteger index, OutlineItemRef item );
NSInteger OutlineViewNumberOfChildrenOfItem( NSInteger tag, OutlineItemRef item );

// -- cell frame --

// Delegate
CFTypeRef OutlineViewDelegate( NSInteger tag );
void OutlineViewSetDelegate( NSInteger tag, CFTypeRef ref );

// -- manipulate items --

// User interface layout direction
NSUserInterfaceLayoutDirection OutlineViewUserInterfaceLayoutDirection( NSInteger tag );
void OutlineViewSetUserInterfaceLayoutDirection( NSInteger tag, NSUserInterfaceLayoutDirection direction );

// Custom
CFMutableArrayRef OutlineViewData( NSInteger tag );
void OutlineViewSetData( NSInteger tag, CFMutableArrayRef array );
void OutlineViewReloadData( NSInteger tag );

