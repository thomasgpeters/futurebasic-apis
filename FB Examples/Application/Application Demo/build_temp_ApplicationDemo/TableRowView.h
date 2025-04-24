/*
 TableRowView.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "DialogEvent.h"

// dialog events
enum {
    tableRowViewBackgroundColor = 3000,
    tableRowViewDrawBackgroundInRect,
    tableRowViewDrawDraggingDestinationFeedbackInRect,
    tableRowViewDrawSelectionInRect,
    tableRowViewDrawSeparatorInRect
};

@interface TableRowViewSC : NSTableRowView
@property (nonatomic,retain) NSColor *selectionColorProp;
@end


@interface NSTableRowView (Additions)
@property (nonatomic,retain) NSNumber *tagNumber;
- (NSInteger)tag;
- (void)setTag:(NSInteger)tag;
@end

// Class
Class TableRowViewClass( void );

// Init
NSTableRowView *TableRowViewInit( void );

// Display style
BOOL TableRowViewIsEmphasized( NSTableRowView *ref );
void TableRowViewSetEmphasized( NSTableRowView *ref, BOOL flag );
NSBackgroundStyle TableRowViewInteriorBackgroundStyle( NSTableRowView *ref );
BOOL TableRowViewIsFloating( NSTableRowView *ref );
void TableRowViewSetFloating( NSTableRowView *ref, BOOL flag );

// Row selection
BOOL TableRowViewIsSelected( NSTableRowView *ref );
void TableRowViewSetSelected( NSTableRowView *ref, BOOL flag );
NSTableViewSelectionHighlightStyle TableRowViewSelectionHighlightStyle( NSTableRowView *ref );
void TableRowViewSetSelectionHighlightStyle( NSTableRowView *ref, NSTableViewSelectionHighlightStyle style );

// Drag and drop

// Row grouping
BOOL TableRowViewIsGroupRowStyle( NSTableRowView *ref );
void TableRowViewSetGroupRowStyle( NSTableRowView *ref, BOOL flag );
NSInteger TableRowViewNumberOfColumns( NSTableRowView *ref );

// Overriding display characteristics
NSColor *TableRowViewBackgroundColor( NSTableRowView *ref );
void TableRowViewSetBackgroundColor( NSTableRowView *ref, NSColor *col );

// Row column view
CFTypeRef TableRowViewViewAtColumn( NSTableRowView *ref, NSInteger column );

// Instance properties
BOOL TableRowViewIsNextRowSelected( NSTableRowView *ref );
void TableRowViewSetNextRowSelected( NSTableRowView *ref, BOOL flag );
BOOL TableRowViewIsPreviousRowSelected( NSTableRowView *ref );
void TableRowViewSetPreviousRowSelected( NSTableRowView *ref, BOOL flag );

