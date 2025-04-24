/*
 TableView.m
 
 Bernie Wylde
 */

#import "TableView.h"

@implementation TableViewSC

/*
 drawRect: causes a cosmetic problem when resizing table columns
 Same in an Xcode project so not a CocoaUI bug
 20200723
 */
//- (void)drawRect:(NSRect)dirtyRect {
//    CUI_ViewSubclassDrawRect( self, dirtyRect );
//    if ( !DialogEventBool() ) [super drawRect:dirtyRect];
//}

- (BOOL)acceptsFirstResponder {
    DialogEventSetBool(YES);
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


@implementation CUI_TableViewDelegate

- (id)init {
    if ( (self = [super init]) ) {
        self.tableData = [[NSMutableArray alloc] initWithCapacity:0];
        self.dragSourceIndex = -1;
        self.dropOperation = NSNotFound;
    }
    return self;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.table release];
    [self.tableData release];
    [self.currentlyDraggedObjects release];
    [self.eventColumnIdentifier release];
    [self.eventCellView release];
    [self.eventCellIdentifier release];
    [self.eventCellString release];
    [self.eventCellImage release];
    [super dealloc];
}
#endif

- (void)tableView:(NSTableView *)tableView forwardEvent:(NSInteger)event object:(id)obj {
    CUI_OutputWindowSetTag( [tableView wndTag] );
    if ( [tableView delegateCallback] ) {
        CUI_TableViewDelegateCallbackType callback = [tableView delegateCallback];
        (*callback)([tableView tag],event);
    } else {
        CallUserDefinedOnDialogFunction( event, [tableView tag], [tableView wndTag], (__bridge CFTypeRef)obj );
    }
}

//- (void)moveItemAtIndex:(NSInteger)srcIndex toIndex:(NSInteger)destIndex {  // rewrite 20200523
//    if ( srcIndex < destIndex ) destIndex--;
//    [table moveRowAtIndex:srcIndex toIndex:destIndex];
//    id obj = [[tableData objectAtIndex:srcIndex] retain];
//    [tableData removeObjectAtIndex:srcIndex];
//    [tableData insertObject:obj atIndex:destIndex];
//    [obj release];
//}

#pragma mark - tableview delegate
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *identifier = [tableColumn identifier];
        
    self.eventRow = row;
    self.eventColumn = [self.table columnWithIdentifier:identifier];
    self.eventColumnIdentifier = identifier;
    
    self.eventCellView = nil;
    self.eventCellIdentifier = identifier;
    self.eventCellString = nil;
    self.eventCellImage = nil;
    
    // will this be a new cellView?
    BOOL newCellView = ( [tableView viewAtColumn:[tableView columnWithIdentifier:identifier] row:row makeIfNecessary:NO] == nil );
    
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];

    self.eventCellView = cellView;
    
    // === 20200430 ===
    if ( [tableView delegateCallback] ) { // delegate callback - probably never used
        [self tableView:tableView forwardEvent:tableViewView object:nil];
    }
    // === 20200430 ===
    
    
    
    // === 20200501 ===
    if ( [tableView customCellCallback] ) {
        NSArray *identifiers = [tableView customCellIdentifiers];
        if ( [identifiers containsObject:identifier] ) {
            
            CUI_TableCustomCellCallbackType callback = [tableView customCellCallback];
            void *userData = [tableView customCellUserData];
            
            for ( NSView *subview in [cellView subviews] ) {
                (*callback)([tableView tag],(__bridge CFStringRef)identifier,row,(__bridge CFTypeRef)subview,userData);
            }
            
            if ( newCellView ) {    // only call CUI_NibViewSetup on newly created cellView
                
                CUI_NibViewSetup( [[tableView window] tag], cellView );
                
            }
            
            return cellView;
        }
    }
    // === 20200501 ===
    
    
    if ( !cellView ) {
        cellView = [[NSTableCellView alloc] init];
        CGFloat rowHeight = [tableView rowHeight];
        CGFloat colWidth = [tableColumn width];
#if __has_feature(objc_arc)
        NSTextField *textField = [[NSTextField alloc] initWithFrame:NSMakeRect(0,0,colWidth,rowHeight)];
#else
        NSTextField *textField = [[[NSTextField alloc] initWithFrame:NSMakeRect(0,0,colWidth,rowHeight)] autorelease];
#endif
        [textField setDrawsBackground:NO];
        [textField setBezeled:NO];
        [cellView addSubview:textField];
        cellView.textField = textField;
    }
    
    if ( cellView.textField ) {
        if ( [cellView.textField isEditable] ) {
            [cellView.textField setDelegate:self];
        }
    }
    
    NSObject *rowObj = [self.tableData objectAtIndex:row];
    if ( [rowObj isKindOfClass:[NSAttributedString class]] ) {
        if ( cellView.textField ) [cellView.textField setAttributedStringValue:(NSAttributedString *)rowObj];           // single column attributed string
    } else if ( [rowObj isKindOfClass:[NSString class]] ) {              // single-column plain text
        if ( cellView.textField ) [cellView.textField setStringValue:(NSString *)rowObj];
    } else if ( [rowObj isKindOfClass:[NSImage class]] ) {               // single-column image
        if ( cellView.imageView ) [cellView.imageView setImage:(NSImage *)rowObj];
    } else if ( [rowObj isKindOfClass:[NSNumber class]] ) {              // single-column number        // 20200521
        if ( cellView.textField ) [cellView.textField setStringValue:[(NSNumber *)rowObj stringValue]];
    } else if ( [rowObj isKindOfClass:[NSDictionary class]] ) {         // multi-column or single-column
        NSObject *colObj = [(NSDictionary *)rowObj objectForKey:identifier];
        if ( colObj ) {
            if ( [colObj isKindOfClass:[NSAttributedString class]] ) {      // attributed string
                if ( cellView.textField ) [cellView.textField setAttributedStringValue:(NSAttributedString *)colObj];
            } else if ( [colObj isKindOfClass:[NSString class]] ) {         // plain text
                if ( cellView.textField ) [cellView.textField setStringValue:(NSString *)colObj];
            } else if ( [colObj isKindOfClass:[NSImage class]] ) {          // image
                if ( cellView.imageView ) [cellView.imageView setImage:(NSImage *)colObj];
            } else if ( [colObj isKindOfClass:[NSNumber class]] ) {         // number                   // 20200521
                if ( cellView.textField ) [cellView.textField setStringValue:[(NSNumber *)colObj stringValue]];
            } else if ( [colObj isKindOfClass:[NSDictionary class]] ) {     // dictionary
                NSArray *allValues = [(NSDictionary *)colObj allValues];
                for ( NSObject *obj in allValues ) {
                    if ( [obj isKindOfClass:[NSString class]] ) {
                        if ( cellView.textField ) [cellView.textField setStringValue:(NSString *)obj];
                    } else if ( [obj isKindOfClass:[NSImage class]] ) {
                        if ( cellView.imageView ) [cellView.imageView setImage:(NSImage *)obj];
                    } else if ( [obj isKindOfClass:[NSNumber class]] ) {                                // 20200521
                        if ( cellView.textField ) [cellView.textField setStringValue:[(NSNumber *)obj stringValue]];
                    }
                }
            }
        } else {
            NSArray *allValues = [(NSDictionary *)rowObj allValues];
            for ( NSObject *obj in allValues ) {
                if ( [obj isKindOfClass:[NSString class]] ) {
                    if ( cellView.textField ) [cellView.textField setStringValue:(NSString *)obj];
                } else if ( [obj isKindOfClass:[NSImage class]] ) {
                    if ( cellView.imageView ) [cellView.imageView setImage:(NSImage *)obj];
                } else if ( [obj isKindOfClass:[NSNumber class]] ) {                                    // 20200521
                    if ( cellView.textField ) [cellView.textField setStringValue:[(NSNumber *)obj stringValue]];
                }
            }
        }
    }
    return cellView;
}

- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row {
    DialogEventSetLong(row);
    DialogEventSetView(nil);
    [self tableView:tableView forwardEvent:tableViewRowView object:nil];
    return (NSTableRowView *)DialogEventView();
}

- (void)tableView:(NSTableView *)tableView didAddRowView:(NSTableRowView *)rowView forRow:(NSInteger)row {
    // === 20230411 ===
    NSColor *color = [NSColor controlTextColor];// default color
    if ( self.textColor ) color = self.textColor;
    NSUInteger columnCount = [tableView numberOfColumns];
    for ( NSUInteger index = 0; index < columnCount; index++ ) {
        NSTableCellView *cellView = [tableView viewAtColumn:index row:row makeIfNecessary:NO];
        [[cellView textField] setTextColor:color];
    }
    // === 20230411 ===

    DialogEventSetLong(row);
    DialogEventSetView(rowView);
    [self tableView:tableView forwardEvent:tableViewDidAddRowView object:rowView];
}

- (void)tableView:(NSTableView *)tableView didRemoveRowView:(NSTableRowView *)rowView forRow:(NSInteger)row {
    DialogEventSetLong(row);
    DialogEventSetView(rowView);
    [self tableView:tableView forwardEvent:tableViewDidRemoveRowView object:rowView];
}

- (BOOL)tableView:(NSTableView *)tableView isGroupRow:(NSInteger)row {
    DialogEventSetBool(NO);
    DialogEventSetLong(row);
    [self tableView:tableView forwardEvent:tableViewIsGroupRow object:nil];
    return DialogEventBool();
}

//- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
//    DialogEventSetCell( cell );
//    DialogEventSetLong(row);
//    [self tableView:tableView forwardEvent:tableViewWillDisplayCell object:tableColumn];
//}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    self.eventHeightOfRow = [tableView rowHeight];
    [self tableView:tableView forwardEvent:tableViewHeightOfRow object:nil];
    return self.eventHeightOfRow;
}

//- (CGFloat)tableView:(NSTableView *)tableView sizeToFitWidthOfColumn:(NSInteger)column {
//[self tableView:tableView forwardEvent:tableViewSizeToFitWidthOfColumn object:nil];
//    return 0.0;
//}

- (BOOL)selectionShouldChangeInTableView:(NSTableView *)tableView {
    DialogEventSetBool(YES);
    [self tableView:tableView forwardEvent:tableViewSelectionShouldChange object:nil];
    return DialogEventBool();
}

- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row {
    DialogEventSetLong(row);
    DialogEventSetBool(YES);
    [self tableView:tableView forwardEvent:tableViewShouldSelectRow object:nil];
    return DialogEventBool();
}

//- (NSIndexSet *)tableView:(NSTableView *)tableView selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes {
//[self tableView:tableView forwardEvent:tableViewSelectionIndexes object:nil];
//    return nil;
//}

- (BOOL)tableView:(NSTableView *)tableView shouldSelectTableColumn:(NSTableColumn *)tableColumn {
    DialogEventSetBool(YES);
    [self tableView:tableView forwardEvent:tableViewShouldSelectTableColumn object:tableColumn];
    return DialogEventBool();
}

- (void)tableViewSelectionIsChanging:(NSNotification *)notification {
    [self tableView:notification.object forwardEvent:tableViewSelectionIsChanging object:notification];
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    [self tableView:notification.object forwardEvent:tableViewSelectionDidChange object:notification];
}

- (BOOL)tableView:(NSTableView *)tableView shouldTypeSelectForEvent:(NSEvent *)event withCurrentSearchString:(NSString *)searchString {
    [self tableView:tableView forwardEvent:tableViewShouldTypeSelect object:nil];
    return YES;
}

//- (NSString *)tableView:(NSTableView *)tableView typeSelectStringForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
//[self tableView:tableView forwardEvent:tableViewTypeSelectString object:nil];
//    return nil;
//}

//- (NSInteger)tableView:(NSTableView *)tableView nextTypeSelectMatchFromRow:(NSInteger)startRow toRow:(NSInteger)endRow forString:(NSString *)searchString {
//[self tableView:tableView forwardEvent:tableViewNextTypeSelectMatch object:nil];
//    return -1;
//}

- (BOOL)tableView:(NSTableView *)tableView shouldReorderColumn:(NSInteger)columnIndex toColumn:(NSInteger)newColumnIndex {
    [self tableView:tableView forwardEvent:tableViewShouldReorderColumn object:nil];
    return YES;
}

- (void)tableView:(NSTableView *)tableView didDragTableColumn:(NSTableColumn *)tableColumn {
    [self tableView:tableView forwardEvent:tableViewDidDragTableColumn object:tableColumn];
}

- (void)tableViewColumnDidMove:(NSNotification *)notification {
    [self tableView:notification.object forwardEvent:tableViewColumnDidMove object:notification];
}

- (void)tableViewColumnDidResize:(NSNotification *)notification {
    [self tableView:notification.object forwardEvent:tableViewColumnDidResize object:notification];
}

- (void)tableView:(NSTableView *)tableView didClickTableColumn:(NSTableColumn *)tableColumn {
    [self tableView:tableView forwardEvent:tableViewDidClickTableColumn object:tableColumn];
}

- (void)tableView:(NSTableView *)tableView mouseDownInHeaderOfTableColumn:(NSTableColumn *)tableColumn {
    DialogEventSetTableColumn( tableColumn );
    [self tableView:tableView forwardEvent:tableViewMouseDownInHeader object:tableColumn];
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
/* Optional - Column Visibility User Control. Return YES for any column whose visibility is meant to be user-controllable. Implementing this method enables table view to provide a menu or equivalent UI that allows users to hide or show table columns. Any column that is meant to be user-controllable in this way should have a non-empty `.title` property.
 Note: setting the `.menu` property on tableView's `.headerView` will take precedence over this built-in mechanism.
 */
- (BOOL)tableView:(NSTableView *)tableView userCanChangeVisibilityOfTableColumn:(NSTableColumn *)column API_AVAILABLE(macos(14.0)) {
    DialogEventSetBool(YES);
    DialogEventSetTableColumn( column );
    [self tableView:tableView forwardEvent:tableViewUserCanChangeVisibilityOfTableColumn object:nil];
    return DialogEventBool();
}

/* Optional - Column Visibility User Control. Called when the user alters the visibility of one or more columns via the `tableView:userCanChangeVisibilityOfTableColumn:` UI affordance.
 */
- (void)tableView:(NSTableView *)tableView userDidChangeVisibilityOfTableColumns:(NSArray <NSTableColumn *> *)columns API_AVAILABLE(macos(14.0)) {
    DialogEventSetNSArray( columns );
    [self tableView:tableView forwardEvent:tableViewUserDidChangeVisibilityOfTableColumns object:columns];
}
#endif// 140000

//- (NSArray<NSTableViewRowAction *> *)tableView:(NSTableView *)tableView rowActionsForRow:(NSInteger)row edge:(NSTableRowActionEdge)edge {
//[self tableView:tableView forwardEvent:tableViewRowActions object:nil];
//    return nil;
//}

- (void)doubleAction:(id)sender {
    [self tableView:sender forwardEvent:tableViewDoubleAction object:nil];
}

- (void)singleAction:(id)sender {
    [self tableView:sender forwardEvent:1 object:nil];// 1 = _btnClick
}

- (void)controlTextDidEndEditing:(NSNotification *)notification {
    NSTextField *textField = [notification object];
    NSInteger row = [self.table rowForView:textField];
    NSInteger col = [self.table columnForView:textField];
    NSTableColumn *column = [[self.table tableColumns] objectAtIndex:col];
    NSString *identifier = [column identifier];
    NSString *string = [textField stringValue];
    
    self.eventRow = row;
    self.eventColumn = col;
    self.eventColumnIdentifier = identifier;
    self.eventCellString = string;
    
    NSObject *rowObj = [self.tableData objectAtIndex:row];
    if ( [rowObj isKindOfClass:[NSAttributedString class]] ) {  // single column attributed string
        if ( [string length] == 0 ) string = @ " ";
        [(NSMutableAttributedString *)rowObj replaceCharactersInRange:NSMakeRange(0,[(NSAttributedString *)rowObj length]) withString:string];
    } else if ( [rowObj isKindOfClass:[NSString class]] ) {     // single column plain text
        [self.tableData replaceObjectAtIndex:row withObject:string];
    } else if ( [rowObj isKindOfClass:[NSNumber class]] ) {     // single column number
#if __has_feature(objc_arc)
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
#else
        NSNumberFormatter *formatter = [[[NSNumberFormatter alloc] init] autorelease];
#endif
        NSNumber *number = [formatter numberFromString:string];
        [self.tableData replaceObjectAtIndex:row withObject:number];
    } else if ( [rowObj isKindOfClass:[NSMutableDictionary class]] ) { // dictionary - single or multi column
        NSObject *colObj = [(NSMutableDictionary *)rowObj objectForKey:identifier];
        if ( colObj ) {
            if ( [colObj isKindOfClass:[NSAttributedString class]] ) {  // attributed string
                if ( [string length] == 0 ) string = @ " ";
                [(NSMutableAttributedString *)colObj replaceCharactersInRange:NSMakeRange(0,[(NSAttributedString *)colObj length]) withString:string];
            } else if ( [colObj isKindOfClass:[NSString class]] ) {     // plain text
                [(NSMutableDictionary *)rowObj setObject:string forKey:identifier];
            } else if ( [colObj isKindOfClass:[NSNumber class]] ) {     // number
#if __has_feature(objc_arc)
                NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
#else
                NSNumberFormatter *formatter = [[[NSNumberFormatter alloc] init] autorelease];
#endif
                NSNumber *number = [formatter numberFromString:string];
                [(NSMutableDictionary *)rowObj setObject:number forKey:identifier];
            }
        }
    } else {
        // not a valid row obj type (probably due to CFDictionaryRef instead of CFMutableDictionaryRef)
        [self.table reloadData];
    }
    
    // send dialog event
    [self tableView:self.table forwardEvent:tableViewCellTextDidEndEditing object:nil];
}

#pragma mark - tableview data source
- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
    self.eventNumberOfRows = -1;
    [self tableView:aTableView forwardEvent:tableViewNumberOfRows object:nil];
    if ( self.eventNumberOfRows != -1 ) return self.eventNumberOfRows;
    return [self.tableData count];
}


- (id<NSPasteboardWriting>)tableView:(NSTableView *)tableView pasteboardWriterForRow:(NSInteger)row {// 20200225
    NSPasteboardItem *item = [[NSPasteboardItem alloc] init];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[self.tableData objectAtIndex:row]];
    [item setData:data forType:TABLEVIEW_REORDER_PASTEBOARD_TYPE];
    return item;
}

//- (BOOL)tableView:(NSTableView *)tableView writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard *)pboard {
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:rowIndexes];
//    [pboard declareTypes:[NSArray arrayWithObject:TABLEVIEW_REORDER_PASTEBOARD_TYPE] owner:self];
//    [pboard setData:data forType:TABLEVIEW_REORDER_PASTEBOARD_TYPE];
//    dragSourceIndex = [rowIndexes firstIndex];
//    return YES;
//}

- (void)tableView:(NSTableView *)tableView draggingSession:(NSDraggingSession *)session willBeginAtPoint:(NSPoint)screenPoint forRowIndexes:(NSIndexSet *)rowIndexes {
    NSUInteger length = ( [rowIndexes lastIndex] + 1 ) - [rowIndexes firstIndex];
    self.objectRange = NSMakeRange( [rowIndexes firstIndex], length );
    self.currentlyDraggedObjects = [self.tableData objectsAtIndexes:rowIndexes];
}

- (NSDragOperation)tableView:(NSTableView *)tableView validateDrop:(id<NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)proposedDropOperation {
    if ( self.dropOperation != NSNotFound ) {
        if ( self.dropOperation != (NSInteger)proposedDropOperation ) return NSDragOperationNone;
    }
    self.eventDropOperation = proposedDropOperation;

    if ( [info draggingSource] == tableView ) { // internal drag drop
        if ( [info draggingSourceOperationMask] == NSDragOperationCopy ) {
            info.animatesToDestination = YES;
            if ( self.allowsDragCopy ) {
                DialogEventSetLong(NSDragOperationCopy);
            } else {
                DialogEventSetLong(NSDragOperationNone);
            }
        } else {
            DialogEventSetLong(NSDragOperationMove);
        }
        [self tableView:tableView forwardEvent:tableViewValidateDrop object:info];
        return DialogEventLong();
    } else {                // Finder drop
        DialogEventSetLong(NSDragOperationCopy);
        [self tableView:tableView forwardEvent:tableViewValidateDrop object:info];
        return DialogEventLong();
    }
    return NSDragOperationNone;
}

- (void)performInsertWithDragInfo:(id<NSDraggingInfo>)info row:(NSInteger)row {// 20200523
    NSArray *classes = @[[NSPasteboardItem class]];
    __block NSInteger insertionIndex = row;
    [info enumerateDraggingItemsWithOptions:0 forView:self.table classes:classes searchOptions:@{} usingBlock:^(NSDraggingItem *draggingItem, __attribute__ ((unused)) NSInteger idx, __attribute__ ((unused)) BOOL *stop) {
        id entity = draggingItem.item;
        NSData *data = [(NSPasteboardItem *)entity dataForType:TABLEVIEW_REORDER_PASTEBOARD_TYPE];
        id obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [self.tableData insertObject:obj atIndex:insertionIndex];
        [self.table insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:insertionIndex] withAnimation:NSTableViewAnimationEffectGap];
        draggingItem.draggingFrame = [self.table frameOfCellAtColumn:0 row:insertionIndex];
        insertionIndex++;
    }];
}

- (void)performDragReorderWithDragInfo:(id<NSDraggingInfo>)info row:(NSInteger)row {// 20200523
    NSArray *classes = @[[NSPasteboardItem class]];
    [info enumerateDraggingItemsWithOptions:0 forView:self.table classes:classes searchOptions:@{} usingBlock:^(__attribute__ ((unused)) NSDraggingItem *draggingItem, NSInteger idx, __attribute__ ((unused)) BOOL *stop) {
        NSInteger newIndex = row + idx;
        id entity = [self.currentlyDraggedObjects objectAtIndex:idx];
        NSInteger oldIndex = [self.tableData indexOfObjectIdenticalTo:entity];
        if ( oldIndex < newIndex ) {
            newIndex -= (idx+1);
        }
        [self.tableData removeObjectAtIndex:oldIndex];
        [self.tableData insertObject:entity atIndex:newIndex];
        [self.table moveRowAtIndex:oldIndex toIndex:newIndex];
    }];
}

- (BOOL)tableView:(NSTableView *)tableView acceptDrop:(id<NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)aDropOperation {
    DialogEventSetBool(YES);
    DialogEventSetLong(row);
    if ( self.currentlyDraggedObjects == nil || [info draggingSourceOperationMask] == NSDragOperationCopy ) {  // Finder drop or internal copy
        if ( self.currentlyDraggedObjects ) {    // internal copy
            [self performInsertWithDragInfo:info row:row];// 20200523
        } else {            // finder
            NSPasteboard *pb = info.draggingPasteboard;
            NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:NSPasteboardURLReadingFileURLsOnlyKey];
            NSArray *urls = [pb readObjectsForClasses:[NSArray arrayWithObject:[NSURL class]] options:options];
            DialogEventSetNSArray(urls);
            DialogEventSetNSURL([urls objectAtIndex:0]);
            [self tableView:tableView forwardEvent:tableViewAcceptDrop object:info];
        }

    } else {                        // item move
        if ( (NSInteger)self.objectRange.location > row || (NSInteger)(self.objectRange.location+self.objectRange.length) < row ) {
            [tableView beginUpdates];// 20200523
            [self performDragReorderWithDragInfo:info row:row];// 20200523
            [tableView endUpdates];// 20200523
        } else {
            return NO;
        }
        //[self moveItemAtIndex:dragSourceIndex toIndex:row];
    }
    return YES;//DialogEventBool();
}

- (void)tableView:(NSTableView *)tableView draggingSession:(NSDraggingSession *)session endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation {
    DialogEventSetNSPoint( screenPoint );
    [self tableView:tableView forwardEvent:tableViewDraggingSessionEnded object:session];
    self.dragSourceIndex = -1;
    self.objectRange = NSMakeRange(0,0);// 20200523
    self.currentlyDraggedObjects = nil;// 20200523
}

- (void)tableView:(NSTableView *)tableView sortDescriptorsDidChange:(NSArray *)oldDescriptors {
    [self.tableData sortUsingDescriptors:[tableView sortDescriptors]];
    [tableView reloadData];
}
@end


@implementation NSTableView (Additions)

// delegate callback
@dynamic delegateCallbackValue;

- (CUI_TableViewDelegateCallbackType)delegateCallback {
    return (CUI_TableViewDelegateCallbackType)[objc_getAssociatedObject(self, @selector(delegateCallbackValue)) pointerValue];
}

- (void)setDelegateCallback:(CUI_TableViewDelegateCallbackType)callback {
    objc_setAssociatedObject(self, @selector(delegateCallbackValue), [NSValue valueWithPointer:(void *)callback], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// custom view callback
@dynamic customCellCallbackValue;

- (CUI_TableCustomCellCallbackType)customCellCallback {
    return (CUI_TableCustomCellCallbackType)[objc_getAssociatedObject(self, @selector(customCellCallbackValue)) pointerValue];
}

- (void)setCustomCellCallback:(CUI_TableCustomCellCallbackType)callback {
    objc_setAssociatedObject(self, @selector(customCellCallbackValue), [NSValue valueWithPointer:(void *)callback], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@dynamic customCellUserDataValue;

- (void *)customCellUserData {
    return [objc_getAssociatedObject(self, @selector(customCellUserDataValue)) pointerValue];
}

- (void)setCustomCellUserData:(void *)userData {
    objc_setAssociatedObject(self, @selector(customCellUserDataValue), [NSValue valueWithPointer:userData], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@dynamic customCellIdentifiersArray;

- (NSArray *)customCellIdentifiers {
    return objc_getAssociatedObject(self, @selector(customCellIdentifiersArray));
}

- (void)setCustomCellIdentifiers:(NSArray *)identifiers {
    objc_setAssociatedObject(self, @selector(customCellIdentifiersArray), identifiers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

CUI_TableViewDelegate *CUI_TableViewDelegateObj( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        CUI_TableViewDelegate *delegate = (CUI_TableViewDelegate *)[tableView delegate];
        if ( !delegate ) {
            delegate = [[CUI_TableViewDelegate alloc] init];
            [tableView setDelegate:delegate];
            [delegate setTable:tableView];
            [tableView setDataSource:delegate];
            [tableView setTarget:delegate];
            [tableView setAction:@selector(singleAction:)];
            [tableView setDoubleAction:@selector(doubleAction:)];
        }
        return delegate;
    }
    return nil;
}



// dialog events
void TableViewEventSetNumberOfRows( NSInteger tag, NSInteger value )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        CUI_TableViewDelegate *delegate = (CUI_TableViewDelegate *)[tableView delegate];
        [delegate setEventNumberOfRows:value];
    }
}

CFStringRef TableViewEventColumnIdentifier( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        CUI_TableViewDelegate *delegate = (CUI_TableViewDelegate *)[tableView delegate];
        return (__bridge CFStringRef)[delegate eventColumnIdentifier];
    }
    return nil;
}

NSTableCellView *TableViewEventCellView( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        CUI_TableViewDelegate *delegate = (CUI_TableViewDelegate *)[tableView delegate];
        return [delegate eventCellView];
    }
    return nil;
}

void TableViewEventSetCellView( NSInteger tag, NSTableCellView *aView )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        CUI_TableViewDelegate *delegate = (CUI_TableViewDelegate *)[tableView delegate];
        [delegate setEventCellView:aView];
    }
}

CFStringRef TableViewEventCellIdentifier( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        CUI_TableViewDelegate *delegate = (CUI_TableViewDelegate *)[tableView delegate];
        return (__bridge CFStringRef)[delegate eventCellIdentifier];
    }
    return nil;
}

NSInteger TableViewEventRow( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        CUI_TableViewDelegate *delegate = (CUI_TableViewDelegate *)[tableView delegate];
        return [delegate eventRow];
    }
    return -1;
}

NSInteger TableViewEventColumn( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        CUI_TableViewDelegate *delegate = (CUI_TableViewDelegate *)[tableView delegate];
        return [delegate eventColumn];
    }
    return -1;
}

CFStringRef TableViewEventCellString( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        CUI_TableViewDelegate *delegate = (CUI_TableViewDelegate *)[tableView delegate];
        return (__bridge CFStringRef)[delegate eventCellString];
    }
    return nil;
}

void TableViewEventSetCellString( NSInteger tag, CFStringRef string )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        CUI_TableViewDelegate *delegate = (CUI_TableViewDelegate *)[tableView delegate];
#if __has_feature(objc_arc)
        [delegate setEventCellString:(__bridge NSString *)string];
#else
        [delegate setEventCellString:[(__bridge NSString *)string retain]];
#endif
    }
}

void TableViewEventSetCellImage( NSInteger tag, NSImage *image )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        CUI_TableViewDelegate *delegate = (CUI_TableViewDelegate *)[tableView delegate];
#if __has_feature(objc_arc)
        [delegate setEventCellImage:image];
#else
        [delegate setEventCellImage:[image retain]];
#endif
    }
}

CGFloat TableViewEventHeightOfRow( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        CUI_TableViewDelegate *delegate = (CUI_TableViewDelegate *)[tableView delegate];
        return [delegate eventHeightOfRow];
    }
    return 0.0;
}

void TableViewEventSetHeightOfRow( NSInteger tag, CGFloat height )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        CUI_TableViewDelegate *delegate = (CUI_TableViewDelegate *)[tableView delegate];
        [delegate setEventHeightOfRow:height];
    }
}

NSTableViewDropOperation TableViewEventDropOperation( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        CUI_TableViewDelegate *delegate = (CUI_TableViewDelegate *)[tableView delegate];
        return [delegate eventDropOperation];
    }
    return 0;
}

void TableViewEventSetDropOperation( NSInteger tag, NSTableViewDropOperation operation )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        CUI_TableViewDelegate *delegate = (CUI_TableViewDelegate *)[tableView delegate];
        [delegate setEventDropOperation:operation];
    }
}




// main functions

// Class
Class TableViewClass( void )
{ return [NSTableView class]; }

NSTableView *TableViewWithTag( NSInteger tag )
{ return (NSTableView *)CUI_ValidateViewKindOfClass( tag, [NSTableView class] ); }

BOOL TableViewExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSTableView class] ); }

// Data source
BOOL TableViewUsesStaticContents( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView usesStaticContents];
    return NO;
}

void TableViewSetUsesStaticContents( NSInteger tag, BOOL flag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setUsesStaticContents:flag];
}

void TableViewSetData( NSInteger tag, CFMutableArrayRef array )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        if ( [tableView isKindOfClass:[NSOutlineView class]] ) {
            CUI_OutlineViewDelegate *delegate = (CUI_OutlineViewDelegate *)[tableView delegate];
#if !__has_feature(objc_arc)
            NSArray *oldArray = [delegate tableData];
            if ( oldArray ) [oldArray release];
#endif
#if __has_feature(objc_arc)
            [delegate setTableData:(__bridge NSMutableArray *)array];
#else
            [delegate setTableData:[(__bridge NSMutableArray *)array retain]];
#endif
            [tableView reloadData];
        } else {
            CUI_TableViewDelegate *delegate = (CUI_TableViewDelegate *)[tableView delegate];
#if !__has_feature(objc_arc)
            NSArray *oldArray = [delegate tableData];
            if ( oldArray ) [oldArray release];
#endif
#if __has_feature(objc_arc)
            [delegate setTableData:(__bridge NSMutableArray *)array];
#else
            [delegate setTableData:[(__bridge NSMutableArray *)array retain]];// retain added 20171211
#endif
            [tableView reloadData];
        }
    }
}

CFMutableArrayRef TableViewData( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        if ( [tableView isKindOfClass:[NSOutlineView class]] ) {
            CUI_OutlineViewDelegate *delegate = (CUI_OutlineViewDelegate *)[tableView delegate];
            return (__bridge CFMutableArrayRef)delegate.tableData;
        } else {
            //CUI_TableViewDelegate *delegate = (CUI_TableViewDelegate *)[tableView delegate];
            CUI_TableViewDelegate *delegate = CUI_TableViewDelegateObj(tag);
            return (__bridge CFMutableArrayRef)delegate.tableData;
        }
    }
    return nil;
}

void TableViewReloadData( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView reloadData];
}

void TableViewReloadDataForRowsColumns( NSInteger tag, NSIndexSet *rows, NSIndexSet *columns )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView reloadDataForRowIndexes:rows columnIndexes:columns];
}

// Create views
NSTableCellView *TableViewMakeViewWithIdentifier( NSInteger tag, CFStringRef identifier )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        CUI_TableViewDelegate *delegate = (CUI_TableViewDelegate *)[tableView delegate];
        return [tableView makeViewWithIdentifier:(__bridge NSString *)identifier owner:delegate];
    }
    return nil;
}

NSTableRowView *TableViewRowViewAtRow( NSInteger tag, NSInteger row, BOOL makeIfNecessary )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        return [tableView rowViewAtRow:row makeIfNecessary:makeIfNecessary];
    }
    return nil;
}

NSView *TableViewViewAtColumnRow( NSInteger tag, NSInteger column, NSInteger row, BOOL makeIfNecessary )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        return [tableView viewAtColumn:column row:row makeIfNecessary:makeIfNecessary];
    }
    return nil;
}

// Update
void TableViewBeginUpdates( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView beginUpdates];
}

void TableViewEndUpdates( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView endUpdates];
}

void TableViewMoveRow( NSInteger tag, NSInteger atIndex, NSInteger toIndex )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView moveRowAtIndex:atIndex toIndex:toIndex];
}

void TableViewInsertRows( NSInteger tag, NSIndexSet *indexes, NSTableViewAnimationOptions animation )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView insertRowsAtIndexes:indexes withAnimation:animation];
}

void TableViewRemoveRows( NSInteger tag, NSIndexSet *indexes, NSTableViewAnimationOptions animation )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView removeRowsAtIndexes:indexes withAnimation:animation];
}

NSInteger TableViewRowForView( NSInteger tag, NSView *aView )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView rowForView:aView];
    return -1;
}

NSInteger TableViewColumnForView( NSInteger tag, NSView *aView )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView columnForView:aView];
    return -1;
}

// Target-action
NSInteger TableViewClickedColumn( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView clickedColumn];
    return 0;
}

NSInteger TableViewClickedRow( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView clickedRow];
    return 0;
}

// Behavior
BOOL TableViewAllowsColumnReordering( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView allowsColumnReordering];
    return NO;
}

void TableViewSetAllowsColumnReordering( NSInteger tag, BOOL flag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setAllowsColumnReordering:flag];
}

BOOL TableViewAllowsColumnResizing( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView allowsColumnResizing];
    return NO;
}

void TableViewSetAllowsColumnResizing( NSInteger tag, BOOL flag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setAllowsColumnResizing:flag];
}

BOOL TableViewAllowsMultipleSelection( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView allowsMultipleSelection];
    return NO;
}

void TableViewSetAllowsMultipleSelection( NSInteger tag, BOOL flag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setAllowsMultipleSelection:flag];
}

BOOL TableViewAllowsEmptySelection( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView allowsEmptySelection];
    return NO;
}

void TableViewSetAllowsEmptySelection( NSInteger tag, BOOL flag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setAllowsEmptySelection:flag];
}

BOOL TableViewAllowsColumnSelection( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView allowsColumnSelection];
    return NO;
}

void TableViewSetAllowsColumnSelection( NSInteger tag, BOOL flag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setAllowsColumnSelection:flag];
}

BOOL TableViewUsesAutomaticRowHeights( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView usesAutomaticRowHeights];
    return NO;
}

void TableViewSetUsesAutomaticRowHeights( NSInteger tag, BOOL flag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setUsesAutomaticRowHeights:flag];
}

// Display attributes
CGSize TableViewIntercellSpacing( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return NSSizeToCGSize([tableView intercellSpacing]);
    return CGSizeZero;
}

void TableViewSetIntercellSpacing( NSInteger tag, CGSize spacing )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setIntercellSpacing:NSSizeFromCGSize(spacing)];
}

CGFloat TableViewRowHeight( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView rowHeight];
    return 0.0;
}

void TableViewSetRowHeight( NSInteger tag, CGFloat height )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setRowHeight:height];
}

NSColor *TableViewBackgroundColor( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView backgroundColor];
    return nil;
}

void TableViewSetBackgroundColor( NSInteger tag, NSColor *col )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setBackgroundColor:col];
}

BOOL TableViewUsesAlternatingRowBackgroundColors( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView usesAlternatingRowBackgroundColors];
    return NO;
}

void TableViewSetUsesAlternatingRowBackgroundColors( NSInteger tag, BOOL flag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setUsesAlternatingRowBackgroundColors:flag];
}

NSTableViewSelectionHighlightStyle TableViewSelectionHighlightStyle( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView selectionHighlightStyle];
    return 0;
}

void TableViewSetSelectionHighlightStyle( NSInteger tag, NSTableViewSelectionHighlightStyle style )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setSelectionHighlightStyle:style];
}

NSColor *TableViewGridColor( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView gridColor];
    return nil;
}

void TableViewSetGridColor( NSInteger tag, NSColor *col )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setGridColor:col];
}

NSTableViewGridLineStyle TableViewGridStyleMask( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView gridStyleMask];
    return 0;
}

void TableViewSetGridStyleMask( NSInteger tag, NSTableViewGridLineStyle style )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setGridStyleMask:style];
}

NSImage *TableViewIndicatorImageInTableColumn( NSInteger tag, NSTableColumn *columnRef )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView indicatorImageInTableColumn:columnRef];
    return nil;
}

void TableViewSetIndicatorImageInTableColumn( NSInteger tag, NSImage *image, NSTableColumn *columnRef )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setIndicatorImage:image inTableColumn:columnRef];
}

// Row size styles
NSTableViewRowSizeStyle TableViewEffectiveRowSizeStyle( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView effectiveRowSizeStyle];
    return 0;
}

NSTableViewRowSizeStyle TableViewRowSizeStyle( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView rowSizeStyle];
    return 0;
}

void TableViewSetRowSizeStyle( NSInteger tag, NSTableViewRowSizeStyle style )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setRowSizeStyle:style];
}

// Column management
void TableViewAddTableColumn( NSInteger tag, NSTableColumn *columnRef )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView addTableColumn:columnRef];
}

void TableViewRemoveTableColumn( NSInteger tag, NSTableColumn *columnRef )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView removeTableColumn:columnRef];
}

void TableViewMoveColumn( NSInteger tag, NSInteger atIndex, NSInteger toIndex )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView moveColumn:atIndex toColumn:toIndex];
}

CFArrayRef TableViewTableColumns( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return (__bridge CFArrayRef)[tableView tableColumns];
    return nil;
}

NSInteger TableViewColumnWithIdentifier( NSInteger tag, CFStringRef identifier )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView columnWithIdentifier:(__bridge NSString *)identifier];
    return -1;
}

NSTableColumn *TableViewTableColumnWithIdentifier( NSInteger tag, CFStringRef identifier )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView tableColumnWithIdentifier:(__bridge NSString *)identifier];
    return nil;
}

// Selecting columns and rows
void TableViewSelectColumns( NSInteger tag, NSIndexSet *columnIndexes, BOOL extendSelection )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView selectColumnIndexes:columnIndexes byExtendingSelection:extendSelection];
}

NSInteger TableViewSelectedColumn( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView selectedColumn];
    return -1;
}

NSIndexSet *TableViewSelectedColumns( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView selectedColumnIndexes];
    return nil;
}

void TableViewDeselectColumn( NSInteger tag, NSInteger columnIndex )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView deselectColumn:columnIndex];
}

NSInteger TableViewNumberOfSelectedColumns( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView numberOfSelectedColumns];
    return 0;
}

BOOL TableViewIsColumnSelected( NSInteger tag, NSInteger columnIndex )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView isColumnSelected:columnIndex];
    return NO;
}

void TableViewSelectRows( NSInteger tag, NSIndexSet *rowIndexes, BOOL extendSelection )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView selectRowIndexes:rowIndexes byExtendingSelection:extendSelection];
}

void TableViewSelectRow( NSInteger tag, NSInteger row )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        [tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:row] byExtendingSelection:NO];
    }
}

NSInteger TableViewSelectedRow( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView selectedRow];
    return -1;
}


NSIndexSet *TableViewSelectedRowIndexes( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        return [tableView selectedRowIndexes];
        //        NSIndexSet *set = [tableView selectedRowIndexes];
        //        if ( set ) {
        //            NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        //            [set enumerateIndexesUsingBlock:^(NSUInteger index, BOOL *stop) {
        //                [array addObject:[NSNumber numberWithInteger:index]];
        //            }];
        //            return (__bridge CFArrayRef)array;
        //        }
    }
    return nil;
}

void TableViewDeselectRow( NSInteger tag, NSInteger row )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView deselectRow:row];
}

NSInteger TableViewNumberOfSelectedRows( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView numberOfSelectedRows];
    return 0;
}

BOOL TableViewIsRowSelected( NSInteger tag, NSInteger row )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView isRowSelected:row];
    return false;
}

void TableViewSelectAll( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView selectAll:nil];
}

void TableViewDeselectAll( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView deselectAll:nil];
}

// Enumerating rows
void TableViewEnumerateAvailableRowViews( NSInteger tag, CUI_TableViewEnumerateAvailableRowViewsCallbackType callback, void *userData )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        [tableView enumerateAvailableRowViewsUsingBlock:^(NSTableRowView *rowView, NSInteger row) {
            (*callback)( tag, rowView, row, userData );
        }];
    }
}

// Type select
BOOL TableViewAllowsTypeSelect( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView allowsTypeSelect];
    return NO;
}

void TableViewSetAllowsTypeSelect( NSInteger tag, BOOL flag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setAllowsTypeSelect:flag];
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
NSTableViewStyle TableViewStyle( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView style];
    return 0;
}

void TableViewSetStyle( NSInteger tag, NSTableViewStyle style )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setStyle:style];
}

NSTableViewStyle TableViewEffectiveStyle( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView effectiveStyle];
    return 0;
}
#endif// 110000

// Dimensions
NSInteger TableViewNumberOfColumns( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView numberOfColumns];
    return 0;
}

// Floating rows
BOOL TableViewFloatsGroupRows( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView floatsGroupRows];
    return NO;
}

void TableViewSetFloatsGroupRows( NSInteger tag, BOOL flag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setFloatsGroupRows:flag];
}

// Editing cells
void TableViewEditColumnRow( NSInteger tag, NSInteger columnIndex, NSInteger row, BOOL selectFlag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView editColumn:columnIndex row:row withEvent:nil select:selectFlag];
}

// Auxiliary views
NSTableHeaderView *TableViewHeaderView( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView headerView];
    return nil;
}

void TableViewSetHeaderView( NSInteger tag, NSTableHeaderView *headerView )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setHeaderView:headerView];
}

NSView *TableViewCornerView( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView cornerView];
    return nil;
}

void TableViewSetCornerView( NSInteger tag, NSView *cornerView )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setCornerView:cornerView];
}

// Layout support
NSUserInterfaceLayoutDirection TableViewUserInterfaceLayoutDirection( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView userInterfaceLayoutDirection];
    return 0;
}

void TableViewSetUserInterfaceLayoutDirection( NSInteger tag, NSUserInterfaceLayoutDirection direction )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setUserInterfaceLayoutDirection:direction];
}

CGRect TableViewRectOfColumn( NSInteger tag, NSInteger col )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return NSRectToCGRect([tableView rectOfColumn:col]);
    return CGRectZero;
}

CGRect TableViewRectOfRow( NSInteger tag, NSInteger row )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return NSRectToCGRect([tableView rectOfRow:row]);
    return CGRectZero;
}

CFRange TableViewRowsInRect( NSInteger tag, CGRect r )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return NSRangeToCFRange([tableView rowsInRect:NSRectFromCGRect(r)]);
    return CFRangeMake(NSNotFound,0);
}

NSIndexSet *TableViewColumnIndexesInRect( NSInteger tag, CGRect r )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView columnIndexesInRect:NSRectFromCGRect(r)];
    return nil;
}

NSInteger TableViewColumnAtPoint( NSInteger tag, CGPoint pt )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView columnAtPoint:NSPointFromCGPoint(pt)];
    return -1;
}

NSInteger TableViewRowAtPoint( NSInteger tag, CGPoint pt )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView rowAtPoint:NSPointFromCGPoint(pt)];
    return -1;
}

CGRect TableViewFrameOfCell( NSInteger tag, NSInteger col, NSInteger row )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return NSRectToCGRect([tableView frameOfCellAtColumn:col row:row]);
    return CGRectZero;
}

NSTableViewColumnAutoresizingStyle TableViewColumnAutoresizingStyle( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView columnAutoresizingStyle];
    return 0;
}

void TableViewSetColumnAutoresizingStyle( NSInteger tag, NSTableViewColumnAutoresizingStyle style )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setColumnAutoresizingStyle:style];
}

void TableViewSizeLastColumnToFit( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView sizeLastColumnToFit];
}

void TableViewTile( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView tile];
}
void TableViewSizeToFit( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView sizeToFit];
}
void TableViewNoteHeightOfRowsWithIndexesChanged( NSInteger tag, NSIndexSet *indexSet )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView noteHeightOfRowsWithIndexesChanged:indexSet];
}

// Scrolling
void TableViewScrollRowToVisible( NSInteger tag, NSInteger row )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView scrollRowToVisible:row];
}

void TableViewScrollColumnToVisible( NSInteger tag, NSInteger col )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView scrollColumnToVisible:col];
}

// Column state persistence
BOOL TableViewAutosaveColumns( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView autosaveTableColumns];
    return NO;
}

void TableViewSetAutosaveColumns( NSInteger tag, BOOL flag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setAutosaveTableColumns:flag];
}

CFStringRef TableViewAutosaveName( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return (__bridge CFStringRef)[tableView autosaveName];
    return nil;
}

void TableViewSetAutosaveName( NSInteger tag, CFStringRef name )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setAutosaveName:(__bridge NSString *)name];
}

// Highlightable column headers
NSTableColumn *TableViewHighlightedTableColumn( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView highlightedTableColumn];
    return nil;
}

void TableViewSetHighlightedTableColumn( NSInteger tag, NSTableColumn *columnRef )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setHighlightedTableColumn:columnRef];
}

// Dragging
BOOL TableViewCanDragRows( NSInteger tag, NSIndexSet *rowIndexes, CGPoint atPoint )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView canDragRowsWithIndexes:rowIndexes atPoint:NSPointFromCGPoint(atPoint)];
    return NO;
}

void TableViewSetDraggingSourceOperationMask( NSInteger tag, NSDragOperation operation, BOOL forLocal )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setDraggingSourceOperationMask:operation forLocal:forLocal];
}

BOOL TableViewVerticalMotionCanBeginDrag( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView verticalMotionCanBeginDrag];
    return NO;
}

void TableViewSetVerticalMotionCanBeginDrag( NSInteger tag, BOOL flag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setVerticalMotionCanBeginDrag:flag];
}

NSTableViewDraggingDestinationFeedbackStyle TableViewDraggingDestinationFeedbackStyle( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView draggingDestinationFeedbackStyle];
    return 0;
}

void TableViewSetDraggingDestinationFeedbackStyle( NSInteger tag, NSTableViewDraggingDestinationFeedbackStyle style )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setDraggingDestinationFeedbackStyle:style];
}

void TableViewSetDropRow( NSInteger tag, NSInteger row, NSTableViewDropOperation operation )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setDropRow:row dropOperation:operation];
}

// Sorting
CFArrayRef TableViewSortDescriptors( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return (__bridge CFArrayRef)[tableView sortDescriptors];
    return nil;
}

void TableViewSetSortDescriptors( NSInteger tag, CFArrayRef descriptors )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setSortDescriptors:(__bridge NSArray *)descriptors];
}

// Row actions
BOOL TableViewRowActionsVisible( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView rowActionsVisible];
    return NO;
}

void TableViewSetRowActionsVisible( NSInteger tag, BOOL flag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setRowActionsVisible:flag];
}

// Hiding and showing rows
void TableViewHideRow( NSInteger tag, NSInteger rowIndex, NSTableViewAnimationOptions animation )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView hideRowsAtIndexes:[NSIndexSet indexSetWithIndex:rowIndex] withAnimation:animation];
}

void TableViewHideRows( NSInteger tag, NSIndexSet *indexes, NSTableViewAnimationOptions animation )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView hideRowsAtIndexes:indexes withAnimation:animation];
}

void TableViewUnhideRow( NSInteger tag, NSInteger rowIndex, NSTableViewAnimationOptions animation )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView unhideRowsAtIndexes:[NSIndexSet indexSetWithIndex:rowIndex] withAnimation:animation];
}

void TableViewUnhideRows( NSInteger tag, NSIndexSet *indexes, NSTableViewAnimationOptions animation )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView unhideRowsAtIndexes:indexes withAnimation:animation];
}

NSIndexSet *TableViewHiddenRowIndexes( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return [tableView hiddenRowIndexes];
    return [NSIndexSet indexSet];
}



// custom
void *TableViewView( NSInteger tag, NSInteger row, NSInteger col )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) return (__bridge void*)[tableView viewAtColumn:col row:row makeIfNecessary:YES];
    return nil;
}

void TableViewSetDelegateCallback( NSInteger tag, CUI_TableViewDelegateCallbackType callback )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) [tableView setDelegateCallback:callback];
}

void TableViewSetCustomCellCallback( NSInteger tag, CFTypeRef identifiers, CUI_TableCustomCellCallbackType callback, void *userData )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        [tableView setCustomCellCallback:callback];
        [tableView setCustomCellUserData:userData];
        if ( identifiers ) {
            NSArray *array = nil;
            if ( [(__bridge NSObject *)identifiers isKindOfClass:[NSString class]] ) {
                //array = @[((__bridge NSString *)identifiers)];
                array = [(__bridge NSString *)identifiers componentsSeparatedByString:@";"];
            } else if ( [(__bridge NSObject *)identifiers isKindOfClass:[NSArray class]] ) {
                array = (__bridge NSArray *)identifiers;
            }
            if ( array ) [tableView setCustomCellIdentifiers:array];
        }
    }
}

void TableViewCellMakeFirstResponder( NSInteger tag, NSInteger row, NSInteger col )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        NSTableCellView *view = [tableView viewAtColumn:col row:row makeIfNecessary:YES];
        [[view window] makeFirstResponder:[view textField]];
    }
}

void TableViewSetHeaderFont( NSInteger tag, NSFont *font )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        NSArray *columns = [tableView tableColumns];
        for ( NSTableColumn *column in columns ) {
            TableHeaderCellSC *cell = [column headerCell];
            if ( ![cell isKindOfClass:[TableHeaderCellSC class]] ) {
                NSString *title = [column title];
#if __has_feature(objc_arc)
                cell = [[TableHeaderCellSC alloc] init];
#else
                cell = [[[TableHeaderCellSC alloc] init] autorelease];
#endif
                [column setHeaderCell:cell];
                [column setTitle:title];
            }
            [cell setColumnIdentifier:[column identifier]];
            [cell setFontProp:font];
        }
    }
}

void TableViewSetHeaderTextColor( NSInteger tag, NSColor *textColor )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        NSArray *columns = [tableView tableColumns];
        for ( NSTableColumn *column in columns ) {
            TableHeaderCellSC *cell = [column headerCell];
            if ( ![cell isKindOfClass:[TableHeaderCellSC class]] ) {
                NSString *title = [column title];
#if __has_feature(objc_arc)
                cell = [[TableHeaderCellSC alloc] init];
#else
                cell = [[[TableHeaderCellSC alloc] init] autorelease];
#endif
                [column setHeaderCell:cell];
                [column setTitle:title];
            }
            [cell setColumnIdentifier:[column identifier]];
            [cell setTextColorProp:textColor];
        }
    }
}

void TableViewSetColumnHeaderFont( NSInteger tag, CFStringRef columnIdentifier, NSFont *font )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        NSTableColumn *column = [tableView tableColumnWithIdentifier:(__bridge NSString *)columnIdentifier];
        if ( column ) {
            TableHeaderCellSC *cell = [column headerCell];
            if ( ![cell isKindOfClass:[TableHeaderCellSC class]] ) {
                NSString *title = [column title];
#if __has_feature(objc_arc)
                cell = [[TableHeaderCellSC alloc] init];
#else
                cell = [[[TableHeaderCellSC alloc] init] autorelease];
#endif
                [column setHeaderCell:cell];
                [column setTitle:title];
            }
            [cell setColumnIdentifier:[column identifier]];
            [cell setFontProp:font];
        }
    }
}

void TableViewSetColumnHeaderTextColor( NSInteger tag, CFStringRef columnIdentifier, NSColor *textColor )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        NSTableColumn *column = [tableView tableColumnWithIdentifier:(__bridge NSString *)columnIdentifier];
        if ( column ) {
            TableHeaderCellSC *cell = [column headerCell];
            if ( ![cell isKindOfClass:[TableHeaderCellSC class]] ) {
                NSString *title = [column title];
#if __has_feature(objc_arc)
                cell = [[TableHeaderCellSC alloc] init];
#else
                cell = [[[TableHeaderCellSC alloc] init] autorelease];
#endif
                [column setHeaderCell:cell];
                [column setTitle:title];
            }
            [cell setColumnIdentifier:[column identifier]];
            [cell setTextColorProp:textColor];
        }
    }
}

NSColor *TableViewTextColor( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        CUI_TableViewDelegate *delegate = (CUI_TableViewDelegate *)[tableView delegate];
        return [delegate textColor];
    }
    return nil;
}

void TableViewSetTextColor( NSInteger tag, NSColor *txtColor )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        CUI_TableViewDelegate *delegate = (CUI_TableViewDelegate *)[tableView delegate];
        [delegate setTextColor:txtColor];
    }
}

NSTableViewDropOperation TableViewDropOperation( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        CUI_TableViewDelegate *delegate = (CUI_TableViewDelegate *)[tableView delegate];
        return [delegate dropOperation];
    }
    return 0;
}

void TableViewSetDropOperation( NSInteger tag, NSTableViewDropOperation dropOperation )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        CUI_TableViewDelegate *delegate = (CUI_TableViewDelegate *)[tableView delegate];
        [delegate setDropOperation:dropOperation];
    }
}

BOOL TableViewAllowsDragCopy( NSInteger tag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        CUI_TableViewDelegate *delegate = (CUI_TableViewDelegate *)[tableView delegate];
        return [delegate allowsDragCopy];
    }
    return NO;
}

void TableViewSetAllowsDragCopy( NSInteger tag, BOOL flag )
{
    NSTableView *tableView = TableViewWithTag( tag );
    if ( tableView ) {
        CUI_TableViewDelegate *delegate = (CUI_TableViewDelegate *)[tableView delegate];
        [delegate setAllowsDragCopy:flag];
    }
}


// Init
NSTableView *TableViewInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) rect = NSMakeRect( 20, 20, 240, 135 );
    
    // subclass
    BOOL subclass = CUI_IsSubclassFlag();
    
    // init
    NSTableView *view;
#if __has_feature(objc_arc)
    if ( subclass ) {
        view = [[TableViewSC alloc] initWithFrame:rect];
    } else {
        view = [[NSTableView alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        view = [[[TableViewSC alloc] initWithFrame:rect] autorelease];
    } else {
        view = [[[NSTableView alloc] initWithFrame:rect] autorelease];
    }
#endif
    
//#if !__has_feature(objc_arc)
//    [view autorelease];
//#endif
    
    // tag
    [view setTag:inTag];
    
    return view;
}


// Statement
void CUI_TableView( NSInteger inTag, NSInteger inEnabled, CGRect inRect, CFTypeRef inColumnIdentifiers, NSInteger inScrollTag, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSTableView *tableView = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !tableView ) {
            tableView = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( tableView ) {    // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);
            
            // make sure it's same view class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, tableView, [NSTableView class] ) ) {
                return;
            }
            
            // enabled
            if ( inEnabled != kFBParamMissing ) [tableView setEnabled:(BOOL)inEnabled];
            
            // rect
            if ( !NSIsEmptyRect( rect ) ) [tableView setFrame:rect];
            
        } else {            // create
            NSScrollView *scrollView = nil;
            if ( inScrollTag ) {
                scrollView = CUI_ViewSubviewWithTag( contentView, inScrollTag );
                if ( !scrollView ) {
                    scrollView = TitlebarAccessoryViewWithTag( inTag );
                }
            }
            
            // rect
            if ( NSIsEmptyRect( rect ) ) {
                if ( scrollView ) {
                    NSSize size = [scrollView contentSize];
                    rect = NSMakeRect( 0, 0, size.width, size.height );
                } else {
                    rect = NSMakeRect( 20, 20, 240, 135 );
                }
            }
            
            // init
            tableView = TableViewInit( inTag, NSRectToCGRect(rect) );
            
            // enabled
            if ( inEnabled != kFBParamMissing ) [tableView setEnabled:(BOOL)inEnabled];
            
            // autoresizing
            [tableView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
            
            // columnIdentifiers
            if ( inColumnIdentifiers ) {
                NSArray *identifiers = nil;
                if ( CFGetTypeID(inColumnIdentifiers) == CFStringGetTypeID() ) {
                    identifiers = [(__bridge NSString *)inColumnIdentifiers componentsSeparatedByString:@";"];
                } else if ( CFGetTypeID(inColumnIdentifiers) == CFArrayGetTypeID() ) {
                    identifiers = (__bridge NSArray *)inColumnIdentifiers;
                }
                if ( identifiers ) {
                    for ( NSString *identifier in identifiers ) {
#if __has_feature(objc_arc)
                        NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:identifier];
#else
                        NSTableColumn *column = [[[NSTableColumn alloc] initWithIdentifier:identifier] autorelease];
#endif
                        [column setTitle:identifier];
                        [tableView addTableColumn:column];
                        [column sizeToFit];
                    }
                }
            }
            
            // delegate & data source
            //CUI_TableViewDelegate *delegate = [[CUI_TableViewDelegate alloc] init];
            CUI_TableViewDelegate *delegate = CUI_TableViewDelegateObj(inTag);
            [tableView setDelegate:delegate];
            [delegate setTable:tableView];
            [tableView setDataSource:delegate];
            [tableView setTarget:delegate];
            [tableView setAction:@selector(singleAction:)];
            [tableView setDoubleAction:@selector(doubleAction:)];
            
            // add to superview
            if ( scrollView ) {
                [scrollView setDocumentView:tableView];
            } else {
                [contentView addSubview:tableView];
            }
            
            // wndTag
            [tableView setWndTag:inWndTag];
        }
        [tableView setHidden:!show];
    } else {
        CUI_ShowAlert( NSWarningAlertStyle, @"Window error.", [NSString stringWithFormat:@"Window %ld does not exist.",(long)inWndTag] );
    }
}

