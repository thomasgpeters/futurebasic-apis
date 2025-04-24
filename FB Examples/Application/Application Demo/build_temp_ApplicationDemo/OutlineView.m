/*
 OutlineView.m

 Bernie Wylde
 */

#import "OutlineView.h"

#pragma mark - OutlineItem
@implementation OutlineItem

- (id)initWithString:(NSString *)inString image:(NSImage *)inImage isGroup:(BOOL)inIsGroup {
    if ( (self = [super init]) ) {
        self.string = [inString copy];
        self.image = [inImage copy];
        self.isGroup = inIsGroup;
        self.children = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (id)initWithAttributedString:(NSAttributedString *)inAString image:(NSImage *)inImage isGroup:(BOOL)inIsGroup {
    if ( (self = [super init]) ) {
        self.string = [[inAString string] copy];
        self.aString = [inAString copy];
        self.image = [inImage copy];
        self.isGroup = inIsGroup;
        self.children = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (id)initWithColumns:(NSDictionary *)inColumns isGroup:(BOOL)inIsGroup {
    if ( (self = [super init]) ) {
        self.columns = [inColumns copy];
        self.isGroup = inIsGroup;
        self.children = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.string release];
    [self.aString release];
    [self.image release];
    [self.children release];
    [self.columns release];
    [self.attributes release];
    [super dealloc];
}
#endif

@end

// Class
Class OutlineViewClass( void )
{ return [NSOutlineView class]; }

// Create
OutlineItem *OutlineItemWithString( CFStringRef string, NSImage *image, BOOL isGroup )
{
#if __has_feature(objc_arc)
    return [[OutlineItem alloc] initWithString:(__bridge NSString *)string image:image isGroup:isGroup];
#else
    return [[[OutlineItem alloc] initWithString:(__bridge NSString *)string image:image isGroup:isGroup] autorelease];
#endif
}

OutlineItem *OutlineItemWithAttributedString( CFAttributedStringRef aString, NSImage *image, BOOL isGroup )
{
#if __has_feature(objc_arc)
    return [[OutlineItem alloc] initWithAttributedString:(__bridge NSAttributedString *)aString image:image isGroup:isGroup];
#else
    return [[[OutlineItem alloc] initWithAttributedString:(__bridge NSAttributedString *)aString image:image isGroup:isGroup] autorelease];
#endif
}

OutlineItem *OutlineItemWithColumns( CFDictionaryRef columns, BOOL isGroup )
{
#if __has_feature(objc_arc)
    return [[OutlineItem alloc] initWithColumns:(__bridge NSDictionary *)columns isGroup:isGroup];
#else
    return [[[OutlineItem alloc] initWithColumns:(__bridge NSDictionary *)columns isGroup:isGroup] autorelease];
#endif
}

// Info
CFStringRef OutlineItemString( OutlineItemRef item )
{ return (__bridge CFStringRef)[item string]; }

NSImage *OutlineItemImage( OutlineItemRef item )
{ return [item image]; }

BOOL OutlineItemIsGroup( OutlineItemRef item )
{ return [item isGroup]; }

CFMutableArrayRef OutlineItemChildren( OutlineItemRef item )
{ return (__bridge CFMutableArrayRef)[item children]; }

CFDictionaryRef OutlineItemColumns( OutlineItemRef item )
{ return (__bridge CFDictionaryRef)[item columns]; }

// Add
OutlineItem *OutlineItemAddChildWithString( OutlineItemRef parItem, CFStringRef string, NSImage *image, BOOL isGroup )
{
    OutlineItem *childItem = OutlineItemWithString( string, image, isGroup );
    [[parItem children] addObject:childItem];
    return childItem;
}

OutlineItem *OutlineItemAddChildWithAttributedString( OutlineItemRef parItem, CFAttributedStringRef aString, NSImage *image, BOOL isGroup )
{
    OutlineItem *childItem = OutlineItemWithAttributedString( aString, image, isGroup );
    [[parItem children] addObject:childItem];
    return childItem;
}

void OutlineItemAddChild( OutlineItemRef parItem, OutlineItemRef childItem )
{ [[parItem children] addObject:childItem]; }

void OutlineItemAddChildColumns( OutlineItemRef parItem, CFDictionaryRef columns, BOOL isGroup )
{
    OutlineItem *childItem = OutlineItemWithColumns( columns, isGroup );
    [[parItem children] addObject:childItem];
}

// Insert
OutlineItemRef OutlineItemInsertChildWithString( OutlineItemRef parItem, CFStringRef string, NSImage *image, BOOL isGroup, NSUInteger index )
{
    OutlineItem *childItem = OutlineItemWithString( string, image, isGroup );
    [[parItem children] insertObject:childItem atIndex:index];
    return childItem;
}

void OutlineItemInsertChild( OutlineItemRef parItem, OutlineItemRef childItem, NSUInteger index )
{ [[parItem children] insertObject:childItem atIndex:index]; }

void OutlineItemInsertChildColumns( OutlineItemRef parItem, CFDictionaryRef columns, BOOL isGroup, NSUInteger index )
{
    OutlineItem *childItem = OutlineItemWithColumns( columns, isGroup );
    [[parItem children] insertObject:childItem atIndex:index];
}

// Remove
void OutlineItemRemoveChildAtIndex( OutlineItemRef parItem, NSUInteger index )
{ [[parItem children] removeObjectAtIndex:index]; }

void OutlineItemRemoveChild( OutlineItemRef parItem, OutlineItemRef childItem )
{ [[parItem children] removeObject:childItem]; }




#pragma mark - outlineview
@implementation OutlineViewSC

//- (void)mouseExited:(NSEvent *)event {
//    CUI_ViewSubclassMouseExited( self );
//}

- (void)resetCursorRects {
    CUI_ViewSubclassResetCursorRects( self );
}

@end

@implementation CUI_OutlineViewDelegate

- (id)init {
    if ( (self = [super init]) ) {
        self.tableData = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.table release];
    [self.tableData release];
    [self.draggedItem release];
    [super dealloc];
}
#endif

- (void)outlineView:(NSOutlineView *)ov forwardEvent:(NSInteger)event object:(id)obj {
    if ( [ov cuiOutlineViewCallback] ) {
        CUI_OutlineViewCallbackType callback = [ov cuiOutlineViewCallback];
        (*callback)([ov tag],event);
    } else {
        CallUserDefinedOnDialogFunction( event, [ov tag], [ov wndTag], (__bridge CFTypeRef)obj );
    }
}


// delegate methods
- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    
    NSString *identifier = [tableColumn identifier];
    NSTableCellView *cellView = [outlineView makeViewWithIdentifier:identifier owner:self];
    
    if ( item ) {
        if ( cellView ) {
            if ( cellView.textField ) {
                if ( [cellView.textField isEditable] ) {
                    [cellView.textField setDelegate:self];
                }
            }
            
            NSString *string = [item string];
            NSAttributedString *aString = [item aString];
            NSImage *image = [item image];
            
            NSDictionary *columns = [item columns];
            if ( columns ) {
                OutlineItem *colItem = [columns objectForKey:identifier];
                string = [colItem string];
                image = [colItem image];
            }
            
            if ( cellView.textField ) {
                if ( aString ) {
                    cellView.textField.attributedStringValue = aString;
                } else {
                    if ( !string ) string = @" ";
                    cellView.textField.stringValue = string;
                }
            }
            if ( image ) cellView.imageView.image = image;
        }
    }
    
    return cellView;
}


- (void)outlineViewSelectionDidChange:(NSNotification *)notification {
    CUI_OutputWindowSetTag( [notification.object wndTag] );
    [self outlineView:notification.object forwardEvent:outlineViewSelectionDidChange object:nil];
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
/* Optional - Column Visibility User Control. Return YES for any column whose visibility is meant to be user-controllable. Implementing this method enables outline view to provide a menu or equivalent UI that allows users to hide or show columns. Any column that is meant to be user-controllable in this way should have a non-empty `.title` property.
 Note: setting the `.menu` property on outlineView's `.headerView` will take precedence over this built-in mechanism.
 */
- (BOOL)outlineView:(NSOutlineView *)outlineView userCanChangeVisibilityOfTableColumn:(NSTableColumn *)column API_AVAILABLE(macos(14.0)) {
    DialogEventSetBool(YES);
    DialogEventSetTableColumn( column );
    [self outlineView:outlineView forwardEvent:outlineViewUserCanChangeVisibilityOfTableColumn object:nil];
    return DialogEventBool();
}

/* Optional - Column Visibility User Control. Called when the user alters the visibility of one or more columns via the `tableView:userCanChangeVisibilityOfTableColumn:` UI affordance.
 */
- (void)outlineView:(NSOutlineView *)outlineView userDidChangeVisibilityOfTableColumns:(NSArray <NSTableColumn *> *)columns API_AVAILABLE(macos(14.0)) {
    DialogEventSetNSArray( columns );
    [self outlineView:outlineView forwardEvent:outlineViewUserDidChangeVisibilityOfTableColumns object:nil];
}
#endif// 140000

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldExpandItem:(id)item {
    DialogEventSetBool(YES);
    [self outlineView:outlineView forwardEvent:outlineViewShouldExpandItem object:item];
    return DialogEventBool();
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldCollapseItem:(id)item {
    DialogEventSetBool(YES);
    [self outlineView:outlineView forwardEvent:outlineViewShouldCollapseItem object:item];
    return DialogEventBool();
}

- (void)outlineViewItemDidExpand:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    [self outlineView:notification.object forwardEvent:outlineViewItemDidExpand object:[userInfo objectForKey:@"NSObject"]];
}

- (void)outlineViewItemDidCollapse:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    [self outlineView:notification.object forwardEvent:outlineViewItemDidCollapse object:[userInfo objectForKey:@"NSObject"]];
}


//- (NSString *)outlineView:(NSOutlineView *)outlineView toolTipForCell:(NSCell *)cell rect:(NSRectPointer)rect tableColumn:(NSTableColumn *)tableColumn item:(id)item mouseLocation:(NSPoint)mouseLocation {
//    DialogEventSetNSString(nil);
//    
//    return DialogEventNSString();
//}


// data source methods
- (BOOL)outlineView:(NSOutlineView *)outlineView acceptDrop:(id<NSDraggingInfo>)info item:(id)item childIndex:(NSInteger)index {
    DialogEventSetBool(YES);
    DialogEventSetLong(index);
    
    if ( self.draggedItem == nil ) {    // Finder drop
        NSPasteboard *pb = info.draggingPasteboard;
        NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:NSPasteboardURLReadingFileURLsOnlyKey];
        NSArray *urls = [pb readObjectsForClasses:[NSArray arrayWithObject:[NSURL class]] options:options];
        DialogEventSetNSArray( urls );
        DialogEventSetNSURL( [urls objectAtIndex:0] );
        
        [self outlineView:outlineView forwardEvent:outlineViewAcceptDrop object:item];

    } else {    // drag within outline view
        
        DialogEventSetNSArray( nil );
        DialogEventSetNSURL( nil );

        OutlineItem *srcItem = self.draggedItem;
        OutlineItem *destItem = item;
        
        NSInteger oldIndex = [outlineView childIndexForItem:srcItem];

        NSInteger newIndex = index;
        NSInteger destGroupIndex = [self.tableData indexOfObject:destItem];
        
        BOOL srcItemIsGroup = [srcItem isGroup];
        BOOL destItemIsGroup = [destItem isGroup];
        
        if ( srcItemIsGroup && destItemIsGroup ) {
            
            [outlineView moveItemAtIndex:oldIndex inParent:nil toIndex:destGroupIndex inParent:nil];
            
            if ( destGroupIndex < oldIndex ) {
                [self.tableData insertObject:srcItem atIndex:destGroupIndex];
                [self.tableData removeObjectAtIndex:oldIndex+1];
            } else {
                [self.tableData insertObject:srcItem atIndex:destGroupIndex+1];
                [self.tableData removeObjectAtIndex:oldIndex];
            }
            return YES;
        }
        
        if ( srcItemIsGroup ) {
            [outlineView moveItemAtIndex:oldIndex inParent:nil toIndex:newIndex inParent:nil];
            
            if ( newIndex < oldIndex ) {
                [self.tableData insertObject:srcItem atIndex:newIndex];
                [self.tableData removeObjectAtIndex:oldIndex+1];
            } else {
                [self.tableData insertObject:srcItem atIndex:newIndex];
                [self.tableData removeObjectAtIndex:oldIndex];
            }
            return YES;
        } else {
            
            if ( destGroupIndex != NSNotFound ) {
                
                OutlineItem *srcGroupItem = [outlineView parentForItem:srcItem];
                NSInteger srcGroupIndex = [self.tableData indexOfObject:srcGroupItem];
                
                NSMutableArray *srcChildren = [srcGroupItem children];
                NSMutableArray *destChildren = [destItem children];
                
                if ( newIndex < 0 ) newIndex = 0;
                
                if ( srcGroupIndex == destGroupIndex ) {
                    if ( newIndex != oldIndex ) {
                        if ( newIndex < oldIndex ) {
                            [outlineView moveItemAtIndex:oldIndex inParent:srcGroupItem toIndex:newIndex inParent:srcGroupItem];
                            [srcChildren insertObject:srcItem atIndex:newIndex];
                            [srcChildren removeObjectAtIndex:oldIndex+1];
                        } else {
                            [outlineView moveItemAtIndex:oldIndex inParent:srcGroupItem toIndex:newIndex-1 inParent:srcGroupItem];
                            [srcChildren insertObject:srcItem atIndex:newIndex];
                            [srcChildren removeObjectAtIndex:oldIndex];
                        }
                    }
                } else {
                    [outlineView moveItemAtIndex:oldIndex inParent:srcGroupItem toIndex:newIndex inParent:destItem];
                    [destChildren insertObject:srcItem atIndex:newIndex];
                    [srcChildren removeObject:srcItem];
                }
                
            } else {
                
                OutlineItem *srcGroupItem = [outlineView parentForItem:srcItem];
                OutlineItem *destGroupItem = [outlineView parentForItem:destItem];
                
                NSInteger srcGroupIndex = [self.tableData indexOfObject:[outlineView parentForItem:srcItem]];
                destGroupIndex = [self.tableData indexOfObject:[outlineView parentForItem:destItem]];
                
                NSMutableArray *srcChildren = [srcGroupItem children];
                NSMutableArray *destChildren = [destGroupItem children];
                
                if ( newIndex < 0 ) {
                    newIndex = [destChildren indexOfObject:destItem];
                }
                
                if ( srcGroupIndex == destGroupIndex ) {
                    [outlineView moveItemAtIndex:oldIndex inParent:srcGroupItem toIndex:newIndex inParent:destGroupItem];
                    if ( newIndex != oldIndex ) {
                        if ( newIndex < oldIndex ) {
                            [srcChildren insertObject:srcItem atIndex:newIndex];
                            [srcChildren removeObjectAtIndex:oldIndex+1];
                        } else {
                            [srcChildren insertObject:srcItem atIndex:newIndex+1];
                            [srcChildren removeObjectAtIndex:oldIndex];
                        }
                    }
                } else {
                    [outlineView moveItemAtIndex:oldIndex inParent:srcGroupItem toIndex:newIndex inParent:destGroupItem];
                    [destChildren insertObject:srcItem atIndex:newIndex];
                    [srcChildren removeObject:srcItem];
                }
                
            }
        }
    }
    
    //[self outlineView:outlineView forwardEvent:outlineViewAcceptDrop object:item];

    return YES;//DialogEventBool();
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    return !item ? [self.tableData objectAtIndex:index] : [[item children] objectAtIndex:index];
}

- (void)outlineView:(NSOutlineView *)outlineView draggingSession:(NSDraggingSession *)session endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation {
    [outlineView reloadData];

    //[self outlineView:outlineView forwardEvent:outlineViewDraggingSessionEnded object:session];

    self.draggedItem = nil;
}

- (void)outlineView:(NSOutlineView *)outlineView draggingSession:(NSDraggingSession *)session willBeginAtPoint:(NSPoint)screenPoint forItems:(NSArray *)draggedItems {
    self.draggedItem = [draggedItems objectAtIndex:0];
    [session.draggingPasteboard setData:nil forType:OUTLINEVIEW_REORDER_PASTEBOARD_TYPE];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
    return [item isGroup];
}

//- (id)outlineView:(NSOutlineView *)outlineView itemForPersistentObject:(id)object {
//    return [NSKeyedUnarchiver unarchiveObjectWithData:object];
//}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    return !item ? [self.tableData count] : [[item children] count];
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
- (NSTintConfiguration *)outlineView:(NSOutlineView *)outlineView tintConfigurationForItem:(id)item API_AVAILABLE(macos(11.0)) {
    //if (@available(macOS 11.0, *)) {
        DialogEventSetTintConfiguration( [NSTintConfiguration defaultTintConfiguration] );
        [self outlineView:outlineView forwardEvent:outlineViewTintConfigurationForItem object:item];
        return DialogEventTintConfiguration();
    //}
    //return nil;
}
#endif// 110000

- (id<NSPasteboardWriting>)outlineView:(NSOutlineView *)outlineView pasteboardWriterForItem:(id)item {
    NSPasteboardItem *pbItem = [[NSPasteboardItem alloc] init];
    [pbItem setDataProvider:self forTypes:[NSArray arrayWithObjects:OUTLINEVIEW_REORDER_PASTEBOARD_TYPE,nil]];
    return pbItem;
}

//- (id)outlineView:(NSOutlineView *)outlineView persistentObjectForItem:(id)item {
//    return [NSKeyedArchiver archivedDataWithRootObject:item];
//}

//- (void)outlineView:(NSOutlineView *)outlineView sortDescriptorsDidChange:(NSArray<NSSortDescriptor *> *)oldDescriptors {
//
//}

//- (void)outlineView:(NSOutlineView *)outlineView updateDraggingItemsForDrag:(id<NSDraggingInfo>)draggingInfo {
//
//}

- (NSDragOperation)outlineView:(NSOutlineView *)outlineView validateDrop:(id<NSDraggingInfo>)info proposedItem:(id)item proposedChildIndex:(NSInteger)index {
    DialogEventSetLong(NSDragOperationLink);

    //[self outlineView:outlineView forwardEvent:outlineViewValidateDrop object:info];

    return DialogEventLong();
}

//- (BOOL)outlineView:(NSOutlineView *)outlineView writeItems:(NSArray *)items toPasteboard:(NSPasteboard *)pasteboard {
//    return YES;
//}

- (void)pasteboard:(NSPasteboard *)pasteboard item:(NSPasteboardItem *)item provideDataForType:(NSString *)type {
}



// action methods
- (void)doubleAction:(id)sender {
    CUI_OutputWindowSetTag( [sender wndTag] );
    [self outlineView:sender forwardEvent:outlineViewDoubleAction object:nil];
}

- (void)singleAction:(id)sender {
    CUI_OutputWindowSetTag( [sender wndTag] );
    [self outlineView:sender forwardEvent:1 object:nil];
}

// text field delegate methods
- (void)controlTextDidEndEditing:(NSNotification *)notification {
    NSTextField *textField = [notification object];
    NSInteger row = [self.table rowForView:textField];
    if ( row != -1 ) {
        NSString *string = [textField stringValue];
        if ( string ) {
            OutlineItem *rowObj = [self.table itemAtRow:row];
#if __has_feature(objc_arc)
            if ( rowObj ) [rowObj setString:string];
#else
            if ( rowObj ) [rowObj setString:[string retain]];
#endif
        }
        [self.table reloadData];
    }
}
@end


@implementation NSOutlineView (Additions)
@dynamic callbackValue;

- (CUI_OutlineViewCallbackType)cuiOutlineViewCallback {
    return (CUI_OutlineViewCallbackType)[(NSValue *)objc_getAssociatedObject(self, @selector(callbackValue)) pointerValue];
}

- (void)setCuiOutlineViewCallback:(CUI_OutlineViewCallbackType)callback {
    objc_setAssociatedObject(self, @selector(callbackValue), [NSValue valueWithPointer:(void *)callback], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end


NSOutlineView *OutlineViewWithTag( NSInteger tag )
{
    NSOutlineView *ov = (NSOutlineView *)CUI_ViewWithTag( tag );
    if ( ov ) {
        if ( [ov isKindOfClass:[NSOutlineView class]] ) return ov;
    }
    CUI_ShowAlert( NSWarningAlertStyle, @"Error.", [NSString stringWithFormat:@"Can't find outlineview with tag: %ld.",(long)tag] );
    return nil;
}

BOOL OutlineViewExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSOutlineView class] ); }


// Data source
CFTypeRef OutlineViewDataSource( NSInteger tag )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) return (__bridge CFTypeRef)[ov dataSource];
    return nil;
}

void OutlineViewSetDataSource( NSInteger tag, CFTypeRef ref )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) [ov setDataSource:(__bridge id)ref];
}

BOOL OutlineViewStronglyReferencesItems( NSInteger tag )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) return [ov stronglyReferencesItems];
    return YES;
}

void OutlineViewSetStronglyReferencesItems( NSInteger tag, BOOL flag )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) [ov setStronglyReferencesItems:flag];
}

// -- expandability --
BOOL OutlineViewIsItemExpandable( NSInteger tag, OutlineItemRef item )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) return [ov isExpandable:item];
    return NO;
}

BOOL OutlineViewIsItemExpanded( NSInteger tag, OutlineItemRef item )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) return [ov isItemExpanded:item];
    return NO;
}

// -- expand/collapse --
void OutlineViewExpandItem( NSInteger tag, OutlineItemRef item )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) [ov expandItem:item];
}

void OutlineViewExpandItemAndChildren( NSInteger tag, OutlineItemRef item, BOOL expandChildren )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) [ov expandItem:item expandChildren:expandChildren];
}

void OutlineViewCollapseItem( NSInteger tag, OutlineItemRef item )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) [ov collapseItem:item];
}

void OutlineViewCollapseItemAndChildren( NSInteger tag, OutlineItemRef item, BOOL collapseChildren )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) [ov collapseItem:item collapseChildren:collapseChildren];
}

// -- redisplay --
void OutlineViewReloadItem( NSInteger tag, OutlineItemRef item )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) [ov reloadItem:item];
}

void OutlineViewReloadItemAndChildren( NSInteger tag, OutlineItemRef item, BOOL reloadChildren )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) [ov reloadItem:item reloadChildren:reloadChildren];
}

// -- convert between items and rows --
OutlineItemRef OutlineViewItemAtRow( NSInteger tag, NSInteger row )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) return [ov itemAtRow:row];
    return nil;
}

NSInteger OutlineViewRowForItem( NSInteger tag, OutlineItemRef item )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) return [ov rowForItem:item];
    return -1;
}

// Outline column
NSTableColumn *OutlineViewOutlineTableColumn( NSInteger tag )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) return [ov outlineTableColumn];
    return nil;
}

void OutlineViewSetOutlineTableColumn( NSInteger tag, NSTableColumn *columnRef )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) [ov setOutlineTableColumn:columnRef];
}

BOOL OutlineViewAutoresizesOutlineColumn( NSInteger tag )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) return [ov autoresizesOutlineColumn];
    return NO;
}

void OutlineViewSetAutoresizesOutlineColumn( NSInteger tag, BOOL flag )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) [ov setAutoresizesOutlineColumn:flag];
}

// -- indentation --
NSInteger OutlineViewLevelForItem( NSInteger tag, OutlineItemRef item )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) return [ov levelForItem:item];
    return -1;
}

NSInteger OutlineViewLevelForRow( NSInteger tag, NSInteger row )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) return [ov levelForRow:row];
    return -1;
}

CGFloat OutlineViewIndentationPerLevel( NSInteger tag )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) return [ov indentationPerLevel];
    return 0.0;
}

void OutlineViewSetIndentationPerLevel( NSInteger tag, CGFloat indent )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) [ov setIndentationPerLevel:indent];
}

BOOL OutlineViewIndentationMarkerFollowsCell( NSInteger tag )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) return [ov indentationMarkerFollowsCell];
    return NO;
}

void OutlineViewSetIndentationMarkerFollowsCell( NSInteger tag, BOOL flag )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) [ov setIndentationMarkerFollowsCell:flag];
}

// Persistence
BOOL OutlineViewAutosaveExpandedItems( NSInteger tag )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) return [ov autosaveExpandedItems];
    return NO;
}

void OutlineViewSetAutosaveExpandedItems( NSInteger tag, BOOL flag )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) [ov setAutosaveExpandedItems:flag];
}

// Drag drop
void OutlineViewSetDropItem( NSInteger tag, OutlineItemRef item, NSInteger dropChildIndex )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) [ov setDropItem:item dropChildIndex:dropChildIndex];
}

// -- persistence --

// -- drag drop --

// -- get related items --
OutlineItemRef OutlineViewParentForItem( NSInteger tag, OutlineItemRef item )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) return [ov parentForItem:item];
    return nil;
}

NSInteger OutlineViewChildIndexForItem( NSInteger tag, OutlineItemRef item )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) return [ov childIndexForItem:item];
    return 0;
}

OutlineItemRef OutlineViewChildOfItem( NSInteger tag, NSInteger index, OutlineItemRef item )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) return [ov child:index ofItem:item];
    return nil;
}

NSInteger OutlineViewNumberOfChildrenOfItem( NSInteger tag, OutlineItemRef item )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) return [ov numberOfChildrenOfItem:item];
    return 0;
}

// -- cell frame --

// Delegate
CFTypeRef OutlineViewDelegate( NSInteger tag )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) return (__bridge CFTypeRef)[ov delegate];
    return nil;
}

void OutlineViewSetDelegate( NSInteger tag, CFTypeRef ref )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) [ov setDelegate:(__bridge id)ref];
}

// -- manipulate items --

// User interface layout direction
NSUserInterfaceLayoutDirection OutlineViewUserInterfaceLayoutDirection( NSInteger tag )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) return [ov userInterfaceLayoutDirection];
    return 0;
}

void OutlineViewSetUserInterfaceLayoutDirection( NSInteger tag, NSUserInterfaceLayoutDirection direction )
{
    NSOutlineView *ov = OutlineViewWithTag( tag );
    if ( ov ) [ov setUserInterfaceLayoutDirection:direction];
}

// Custom
CFMutableArrayRef OutlineViewData( NSInteger tag )
{
    NSOutlineView *outlineView = OutlineViewWithTag( tag );
    if ( outlineView ) {
        if ( [outlineView isKindOfClass:[NSOutlineView class]] ) {
            CUI_OutlineViewDelegate *delegate = (CUI_OutlineViewDelegate *)[outlineView delegate];
            return (__bridge CFMutableArrayRef)delegate.tableData;
        }
    }
    return nil;
}

void OutlineViewSetData( NSInteger tag, CFMutableArrayRef array )
{
    NSOutlineView *outlineView = OutlineViewWithTag( tag );
    if ( outlineView ) {
        if ( [outlineView isKindOfClass:[NSOutlineView class]] ) {
            CUI_OutlineViewDelegate *delegate = (CUI_OutlineViewDelegate *)[outlineView delegate];
#if __has_feature(objc_arc)
            [delegate setTableData:(__bridge NSMutableArray *)array];
#else
            NSArray *oldArray = [delegate tableData];
            if ( oldArray ) [oldArray release];
            [delegate setTableData:[(__bridge NSMutableArray *)array retain]];
#endif
            [outlineView reloadData];
        }
    }
}

void OutlineViewReloadData( NSInteger tag )
{
    NSOutlineView *outlineView = OutlineViewWithTag( tag );
    if ( outlineView ) [outlineView reloadData];
}

