/*
 TableRowView.m

 Bernie Wylde
 */

#import "TableRowView.h"

@implementation TableRowViewSC

#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.selectionColorProp release];
    [super dealloc];
}
#endif

- (void)forwardEvent:(NSInteger)event {
    CallUserDefinedOnDialogFunction( event, 0, 0, (__bridge CFTypeRef)self );
}

//- (NSColor *)backgroundColor {
//    DialogEventSetColor( [self backgroundColor] );
//    [self forwardEvent:tableRowViewBackgroundColor];
//    return DialogEventColor();
//}

//- (void)drawBackgroundInRect:(NSRect)dirtyRect {
//    DialogEventSetNSRect(dirtyRect);
//    [self forwardEvent:tableRowViewDrawBackgroundInRect];
//}

- (void)drawSelectionInRect:(NSRect)dirtyRect {
    DialogEventSetNSRect(dirtyRect);
    [self forwardEvent:tableRowViewDrawSelectionInRect];
}

- (void)drawSeparatorInRect:(NSRect)dirtyRect {
    DialogEventSetNSRect(dirtyRect);
    [self forwardEvent:tableRowViewDrawSeparatorInRect];
}
@end






@implementation NSTableRowView (Additions)
@dynamic tagNumber;
- (NSInteger)tag {
    return [objc_getAssociatedObject(self, @selector(tagNumber)) integerValue];
}
- (void)setTag:(NSInteger)tag {
    objc_setAssociatedObject(self, @selector(tagNumber), [NSNumber numberWithInteger:tag], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

// Class
Class TableRowViewClass( void )
{ return [NSTableRowView class]; }

// Init
NSTableRowView *TableRowViewInit( void )
{
#if __has_feature(objc_arc)
    return [[TableRowViewSC alloc] init];
#else
    return [[[TableRowViewSC alloc] init] autorelease];
#endif
}

// Display style
BOOL TableRowViewIsEmphasized( NSTableRowView *ref )
{ return [ref isEmphasized]; }

void TableRowViewSetEmphasized( NSTableRowView *ref, BOOL flag )
{ [ref setEmphasized:flag]; }

NSBackgroundStyle TableRowViewInteriorBackgroundStyle( NSTableRowView *ref )
{ return [ref interiorBackgroundStyle]; }

BOOL TableRowViewIsFloating( NSTableRowView *ref )
{ return [ref isFloating]; }

void TableRowViewSetFloating( NSTableRowView *ref, BOOL flag )
{ [ref setFloating:flag]; }

// Row selection
BOOL TableRowViewIsSelected( NSTableRowView *ref )
{ return [ref isSelected]; }

void TableRowViewSetSelected( NSTableRowView *ref, BOOL flag )
{ [ref setSelected:flag]; }

NSTableViewSelectionHighlightStyle TableRowViewSelectionHighlightStyle( NSTableRowView *ref )
{ return [ref selectionHighlightStyle]; }

void TableRowViewSetSelectionHighlightStyle( NSTableRowView *ref, NSTableViewSelectionHighlightStyle style )
{ [ref setSelectionHighlightStyle:style]; }

// Drag and drop

// Row grouping
BOOL TableRowViewIsGroupRowStyle( NSTableRowView *ref )
{ return [ref isGroupRowStyle]; }

void TableRowViewSetGroupRowStyle( NSTableRowView *ref, BOOL flag )
{ [ref setGroupRowStyle:flag]; }

NSInteger TableRowViewNumberOfColumns( NSTableRowView *ref )
{ return [ref numberOfColumns]; }

// Overriding display characteristics
NSColor *TableRowViewBackgroundColor( NSTableRowView *ref )
{ return [ref backgroundColor]; }

void TableRowViewSetBackgroundColor( NSTableRowView *ref, NSColor *col )
{ [ref setBackgroundColor:col]; }

// Row column view
CFTypeRef TableRowViewViewAtColumn( NSTableRowView *ref, NSInteger column )
{ return (__bridge CFTypeRef)[ref viewAtColumn:column]; }

// Instance properties
BOOL TableRowViewIsNextRowSelected( NSTableRowView *ref )
{ return [ref isNextRowSelected]; }

void TableRowViewSetNextRowSelected( NSTableRowView *ref, BOOL flag )
{ [ref setNextRowSelected:flag]; }

BOOL TableRowViewIsPreviousRowSelected( NSTableRowView *ref )
{ return [ref isPreviousRowSelected]; }

void TableRowViewSetPreviousRowSelected( NSTableRowView *ref, BOOL flag )
{ [ref setPreviousRowSelected:flag]; }


