/*
 GridView.m

 Bernie Wylde
 */

#import "GridView.h"


#pragma mark - subclass
@implementation GridViewSC
- (void)drawRect:(NSRect)dirtyRect {
    CUI_ViewSubclassDrawRect( self, dirtyRect );
    if ( !DialogEventBool() ) [super drawRect:dirtyRect];
}

- (BOOL)acceptsFirstResponder {
    DialogEventSetBool(NO);
    CUI_ViewSubclassAcceptsFirstResponder( self );
    return DialogEventBool();
}

- (void)mouseDown:(NSEvent *)event {
    CUI_ViewSubclassMouseDown( self, event );
    if ( !DialogEventBool() ) [super mouseDown:event];
}

- (void)mouseUp:(NSEvent *)event {
    CUI_ViewSubclassMouseUp( self, event );
}

- (void)mouseEntered:(NSEvent *)event {
    CUI_ViewSubclassMouseEntered( self, event );
}

- (void)mouseExited:(NSEvent *)event {
    CUI_ViewSubclassMouseExited( self, event );
}

- (void)mouseDragged:(NSEvent *)event {
    CUI_ViewSubclassMouseDragged( self, event );
}

- (void)mouseMoved:(NSEvent *)event {
    CUI_ViewSubclassMouseMoved( self, event );
}

- (void)rightMouseDown:(NSEvent *)event {
    CUI_ViewSubclassRightMouseDown( self, event );
    if ( !DialogEventBool() ) [super rightMouseDown:event];
}

- (void)rightMouseUp:(NSEvent *)event {
    CUI_ViewSubclassRightMouseUp( self, event );
}

- (void)rightMouseDragged:(NSEvent *)event {
    CUI_ViewSubclassRightMouseDragged( self, event );
}

- (void)keyDown:(NSEvent *)event {
    CUI_ViewSubclassKeyDown( self, event );
    if ( !DialogEventBool() ) [super keyDown:event];
}

- (void)keyUp:(NSEvent *)event {
    CUI_ViewSubclassKeyUp( self, event );
}

- (void)flagsChanged:(NSEvent *)event {
    CUI_ViewSubclassFlagsChanged( self, event );
}

- (void)resetCursorRects {
    CUI_ViewSubclassResetCursorRects( self );
}

//- (void)updateTrackingAreas {
//    CUI_ViewSubclassUpdateTrackingAreas( self );
//    [super updateTrackingAreas];
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    CUI_ViewSubclassAwakeFromNib(self);
}

#pragma mark - menu
- (NSMenu *)menuForEvent:(NSEvent*)theEvent {
    CUI_ViewSubclassMenuForEvent( self, theEvent );
    return DialogEventNSMenu();
}
@end


@implementation NSGridView (Additions)
@dynamic tagNumber;
- (NSInteger)tag {
    return [objc_getAssociatedObject(self, @selector(tagNumber)) integerValue];
}
- (void)setTag:(NSInteger)tag {
    objc_setAssociatedObject(self, @selector(tagNumber), [NSNumber numberWithInteger:tag], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

// Class
Class GridViewClass( void )
{ return [NSGridView class]; }

NSGridView *GridViewWithTag( NSInteger tag )
{ return (NSGridView *)CUI_ValidateViewKindOfClass( tag, [NSGridView class] ); }

BOOL GridViewExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSGridView class] ); }

// Info
NSInteger GridViewNumberOfRows( NSInteger tag )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) return [view numberOfRows];
    return 0;
}

NSInteger GridViewNumberOfColumns( NSInteger tag )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) return [view numberOfColumns];
    return 0;
}

NSInteger GridViewIndexOfColumn( NSInteger tag, NSGridColumn *column )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) return [view indexOfColumn:column];
    return 0;
}

NSGridRow *GridViewRowAtIndex( NSInteger tag, NSInteger index )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) return [view rowAtIndex:index];
    return nil;
}

NSGridColumn *GridViewColumnAtIndex( NSInteger tag, NSInteger index )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) return [view columnAtIndex:index];
    return nil;
}

NSInteger GridViewIndexOfRow( NSInteger tag, NSGridRow *row )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) return [view indexOfRow:row];
    return 0;
}

// Add, remove, move rows
NSGridRow *GridViewAddRowWithViews( NSInteger tag, CFArrayRef views )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) return [view addRowWithViews:(__bridge NSArray *)views];
    return nil;
}

NSGridRow *GridViewInsertRowWithViews( NSInteger tag, NSInteger index, CFArrayRef views )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) return [view insertRowAtIndex:index withViews:(__bridge NSArray *)views];
    return nil;
}

void GridViewRemoveRow( NSInteger tag, NSInteger index )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) [view removeRowAtIndex:index];
}

void GridViewMoveRow( NSInteger tag, NSInteger fromIndex, NSInteger toIndex )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) [view moveRowAtIndex:fromIndex toIndex:toIndex];
}

// Add, remove, move columns
NSGridColumn *GridViewAddColumnWithViews( NSInteger tag, CFArrayRef views )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) return [view addColumnWithViews:(__bridge NSArray *)views];
    return nil;
}

NSGridColumn *GridViewInsertColumnWithViews( NSInteger tag, NSInteger index, CFArrayRef views )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) return [view insertColumnAtIndex:index withViews:(__bridge NSArray *)views];
    return nil;
}

void GridViewRemoveColumn( NSInteger tag, NSInteger index )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) [view removeColumnAtIndex:index];
}

void GridViewMoveColumn( NSInteger tag, NSInteger fromIndex, NSInteger toIndex )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) [view moveColumnAtIndex:fromIndex toIndex:toIndex];
}

// Spacing and alignment
CGFloat GridViewColumnSpacing( NSInteger tag )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) return [view columnSpacing];
    return 0.0;
}

void GridViewSetColumnSpacing( NSInteger tag, CGFloat spacing )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) [view setColumnSpacing:spacing];
}

CGFloat GridViewRowSpacing( NSInteger tag )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) return [view rowSpacing];
    return 0.0;
}

void GridViewSetRowSpacing( NSInteger tag, CGFloat spacing )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) [view setRowSpacing:spacing];
}

NSGridRowAlignment GridViewRowAlignment( NSInteger tag )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) return [view rowAlignment];
    return 0;
}

void GridViewSetRowAlignment( NSInteger tag, NSGridRowAlignment alignment )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) [view setRowAlignment:alignment];
}

NSGridCellPlacement GridViewXPlacement( NSInteger tag )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) return [view xPlacement];
    return 0;
}

void GridViewSetXPlacement( NSInteger tag, NSGridCellPlacement placement )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) [view setXPlacement:placement];
}

NSGridCellPlacement GridViewYPlacement( NSInteger tag )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) return [view yPlacement];
    return 0;
}

void GridViewSetYPlacement( NSInteger tag, NSGridCellPlacement placement )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) [view setYPlacement:placement];
}

// Create and merge cells
NSGridCell *GridViewCellAtColumnRow( NSInteger tag, NSInteger colIndex, NSInteger rowIndex )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) return [view cellAtColumnIndex:colIndex rowIndex:rowIndex];
    return nil;
}

NSGridCell *GridViewCellForView( NSInteger tag, NSInteger vwTag )
{
    NSGridView *gridView = GridViewWithTag( tag );
    if ( gridView ) {
        NSView *view = ViewWithTag( vwTag );
        if ( view ) {
            return [gridView cellForView:view];
        }
    }
    return nil;
}

void GridViewMergeCells( NSInteger tag, CFRange horizontalRange, CFRange verticalRange )
{
    NSGridView *view = GridViewWithTag( tag );
    if ( view ) [view mergeCellsInHorizontalRange:NSRangeFromCFRange(horizontalRange) verticalRange:NSRangeFromCFRange(verticalRange)];
}


/*
 GridCell
 */
// Containers
NSGridColumn *GridCellColumn( NSGridCell *ref )
{ return [ref column]; }

NSGridRow *GridCellRow( NSGridCell *ref )
{ return [ref row]; }

NSView *GridCellContentView( NSGridCell *ref )
{ return [ref contentView]; }

void GridCellSetContentView( NSGridCell *ref, NSView *aView )
{ [ref setContentView:aView]; }

NSView *GridCellEmptyContentView( void )
{ return [NSGridCell emptyContentView]; }

// Formatting
CFArrayRef GridCellCustomPlacementConstraints( NSGridCell *ref )
{ return (__bridge CFArrayRef)[ref customPlacementConstraints]; }

void GridCellSetCustomPlacementConstraints( NSGridCell *ref, CFArrayRef constraints )
{ [ref setCustomPlacementConstraints:(__bridge NSArray *)constraints]; }

NSGridRowAlignment GridCellRowAlignment( NSGridCell *ref )
{ return [ref rowAlignment]; }

void GridCellSetRowAlignment( NSGridCell *ref, NSGridRowAlignment alignment )
{ [ref setRowAlignment:alignment]; }

NSGridCellPlacement GridCellXPlacement( NSGridCell *ref )
{ return [ref xPlacement]; }

void GridCellSetXPlacement( NSGridCell *ref, NSGridCellPlacement placement )
{ [ref setXPlacement:placement]; }

NSGridCellPlacement GridCellYPlacement( NSGridCell *ref )
{ return [ref yPlacement]; }

void GridCellSetYPlacement( NSGridCell *ref, NSGridCellPlacement placement )
{ [ref setYPlacement:placement]; }


/*
 GridColumn
 */
// Instance properties
NSGridView *GridColumnGridView( NSGridColumn *ref )
{ return [ref gridView]; }

BOOL GridColumnIsHidden( NSGridColumn *ref )
{ return [ref isHidden]; }

void GridColumnSetHidden( NSGridColumn *ref, BOOL flag )
{ [ref setHidden:flag]; }

CGFloat GridColumnLeadingPadding( NSGridColumn *ref )
{ return [ref leadingPadding]; }

void GridColumnSetLeadingPadding( NSGridColumn *ref, CGFloat padding )
{ [ref setLeadingPadding:padding]; }

NSInteger GridColumnNumberOfCells( NSGridColumn *ref )
{ return [ref numberOfCells]; }

CGFloat GridColumnTrailingPadding( NSGridColumn *ref )
{ return [ref trailingPadding]; }

void GridColumnSetTrailingPadding( NSGridColumn *ref, CGFloat padding )
{ [ref setTrailingPadding:padding]; }

CGFloat GridColumnWidth( NSGridColumn *ref )
{ return [ref width]; }

void GridColumnSetWidth( NSGridColumn *ref, CGFloat width )
{ [ref setWidth:width]; }

NSGridCellPlacement GridColumnXPlacement( NSGridColumn *ref )
{ return [ref xPlacement]; }

void GridColumnSetXPlacement( NSGridColumn *ref, NSGridCellPlacement placement )
{ [ref setXPlacement:placement]; }

// Instance methods
NSGridCell *GridColumnCellAtIndex( NSGridColumn *ref, NSInteger index )
{ return [ref cellAtIndex:index]; }

void GridColumnMergeCells( NSGridColumn *ref, CFRange range )
{ [ref mergeCellsInRange:NSRangeFromCFRange(range)]; }


/*
 GridRow
 */
// Details
NSInteger GridRowNumberOfCells( NSGridRow *ref )
{ return [ref numberOfCells]; }

BOOL GridRowIsHidden( NSGridRow *ref )
{ return [ref isHidden]; }

void GridRowSetHidden( NSGridRow *ref, BOOL flag )
{ [ref setHidden:flag]; }

// Formatting
CGFloat GridRowTopPadding( NSGridRow *ref )
{ return [ref topPadding]; }

void GridRowSetTopPadding( NSGridRow *ref, CGFloat padding )
{ [ref setTopPadding:padding]; }

CGFloat GridRowBottomPadding( NSGridRow *ref )
{ return [ref bottomPadding]; }

void GridRowSetBottomPadding( NSGridRow *ref, CGFloat padding )
{ [ref setBottomPadding:padding]; }

CGFloat GridRowHeight( NSGridRow *ref )
{ return [ref height]; }

void GridRowSetHeight( NSGridRow *ref, CGFloat height )
{ [ref setHeight:height]; }

NSGridCellPlacement GridRowYPlacement( NSGridRow *ref )
{ return [ref yPlacement]; }

void GridRowSetYPlacement( NSGridRow *ref, NSGridCellPlacement placement )
{ [ref setYPlacement:placement]; }

// Grid view
NSGridView *GridRowGridView( NSGridRow *ref )
{ return [ref gridView]; }

// Cells
NSGridCell *GridRowCellAtIndex( NSGridRow *ref, NSInteger index )
{ return [ref cellAtIndex:index]; }

// Merge
void GridRowMergeCells( NSGridRow *ref, CFRange range )
{ [ref mergeCellsInRange:NSRangeFromCFRange(range)]; }



// Init
NSGridView *GridViewInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) {
        rect = NSMakeRect( 20, 20, 206, 102 );
    }

    // subclass
    BOOL subclass = CUI_IsSubclassFlag();
    
    // init
    NSGridView *view;
#if __has_feature(objc_arc)
    if ( subclass ) {
        view = [[GridViewSC alloc] initWithFrame:rect];
    } else {
        view = [[NSGridView alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        view = [[[GridViewSC alloc] initWithFrame:rect] autorelease];
    } else {
        view = [[[NSGridView alloc] initWithFrame:rect] autorelease];
    }
#endif
    
    // tag
    [view setTag:inTag];
    
    return view;
}


/*
 gridview statement
 */
void CUI_GridView( NSInteger inTag, CGRect inRect, NSInteger inNumColumns, NSInteger inNumRows, CFTypeRef inViews, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSGridView *view = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !view ) {
            view = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( view ) {   // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            // make sure it's correct class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, view, [NSGridView class] ) ) {
                return;
            }

            // origin
            if ( !NSIsEmptyRect( rect ) ) [view setFrame:rect];
            
        } else {    // create
            // subclass
            BOOL subclass = CUI_IsSubclassFlag();

            // origin
            if ( NSIsEmptyRect( rect ) ) {
                rect = NSMakeRect( 20, 20, 206, 102 );
            }
            
            // views
            NSArray *views = (__bridge NSArray *)inViews;
            
            // init
            if ( subclass ) {
                if ( inNumColumns > 0 && inNumRows > 0 ) {
                    view = [GridViewSC gridViewWithNumberOfColumns:inNumColumns rows:inNumRows];
                } else if ( views ) {
                    NSMutableArray *rows = [NSMutableArray arrayWithCapacity:0];
                    for ( NSArray *rowTags in views ) {
                        NSMutableArray *columns = [NSMutableArray arrayWithCapacity:0];
                        for ( NSNumber *tagNumber in rowTags ) {
                            NSInteger tag = [tagNumber integerValue];
                            NSView *view = CUI_ViewWithTag( tag );
                            [columns addObject:view];
                        }
                        [rows addObject:columns];
                    }
                    view = [GridViewSC gridViewWithViews:rows];
                } else {
#if __has_feature(objc_arc)
                    view = [[GridViewSC alloc] initWithFrame:rect];
#else
                    view = [[[GridViewSC alloc] initWithFrame:rect] autorelease];
#endif
                }
            } else {
                if ( inNumColumns > 0 && inNumRows > 0 ) {
                    view = [NSGridView gridViewWithNumberOfColumns:inNumColumns rows:inNumRows];
                } else if ( views ) {
                    NSMutableArray *rows = [NSMutableArray arrayWithCapacity:0];
                    for ( NSArray *rowTags in views ) {
                        NSMutableArray *columns = [NSMutableArray arrayWithCapacity:0];
                        for ( NSNumber *tagNumber in rowTags ) {
                            NSInteger tag = [tagNumber integerValue];
                            NSView *view;
                            if ( tag == 0 ) {
                                view = [NSGridCell emptyContentView];
                            } else {
                                view = CUI_ViewWithTag( tag );
                            }
                            [columns addObject:view];
                        }
                        [rows addObject:columns];
                    }
                    
                    view = [NSGridView gridViewWithViews:rows];

                } else {
#if __has_feature(objc_arc)
                    view = [[NSGridView alloc] initWithFrame:rect];
#else
                    view = [[[NSGridView alloc] initWithFrame:rect] autorelease];
#endif
                }
            }
            
            // rect
            [view setFrame:rect];

            // default autoresizing
            [view setAutoresizingMask:NSViewMinYMargin];
            
            // tag
            [view setTag: inTag];
            
            // wndTag
            [view setWndTag:inWndTag];
            
            // add to window
            [contentView addSubview:view];
        }
        
        [view setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
}



