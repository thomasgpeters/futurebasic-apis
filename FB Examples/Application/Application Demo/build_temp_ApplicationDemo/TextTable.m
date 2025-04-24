/*
 TextTable.m

 Bernie Wylde
 */

#import "TextTable.h"

// Class
Class TextTableClass( void )
{ return [NSTextTable class]; }

NSTextTable *TextTableInit( void )
{
#if __has_feature(objc_arc)
    return [[NSTextTable alloc] init];
#else
    return [[[NSTextTable alloc] init] autorelease];
#endif
}

NSUInteger TextTableNumberOfColumns( NSTextTable *ref )
{ return [ref numberOfColumns]; }

void TextTableSetNumberOfColumns( NSTextTable *ref, NSUInteger cols )
{ [ref setNumberOfColumns:cols]; }

NSTextTableLayoutAlgorithm TextTableLayoutAlgorithm( NSTextTable *ref )
{ return [ref layoutAlgorithm]; }

void TextTableSetLayoutAlgorithm( NSTextTable *ref, NSTextTableLayoutAlgorithm algorithm )
{ [ref setLayoutAlgorithm:algorithm]; }

BOOL TextTableCollapsesBorders( NSTextTable *ref )
{ return [ref collapsesBorders]; }

void TextTableSetCollapsesBorders( NSTextTable *ref, BOOL flag )
{ [ref setCollapsesBorders:flag]; }

BOOL TextTableHidesEmptyCells( NSTextTable *ref )
{ return [ref hidesEmptyCells]; }

void TextTableSetHidesEmptyCells( NSTextTable *ref, BOOL flag )
{ [ref setHidesEmptyCells:flag]; }

CGRect TextTableRectForBlock( NSTextTable *ref, NSTextTableBlock *block, CGPoint startingPt, CGRect inRect, NSTextContainer *textContainer, CFRange charRange )
{ return NSRectToCGRect([ref rectForBlock:block layoutAtPoint:NSPointFromCGPoint(startingPt) inRect:NSRectFromCGRect(inRect) textContainer:textContainer characterRange:NSRangeFromCFRange(charRange)]); }

CGRect TextTableBoundsRectForBlock( NSTextTable *ref, NSTextTableBlock *block, CGRect contentRect, CGRect inRect, NSTextContainer *textContainer, CFRange charRange )
{ return NSRectToCGRect([ref boundsRectForBlock:block contentRect:NSRectFromCGRect(contentRect) inRect:NSRectFromCGRect(inRect) textContainer:textContainer characterRange:NSRangeFromCFRange(charRange)]); }

void TextTableDrawBackgroundForBlock( NSTextTable *ref, NSTextTableBlock *block, CGRect frame, NSView *controlView, CFRange charRange, NSLayoutManager *layoutManager )
{ [ref drawBackgroundForBlock:block withFrame:NSRectFromCGRect(frame) inView:controlView characterRange:NSRangeFromCFRange(charRange) layoutManager:layoutManager]; }


/*
 TextTableBlock
 */
// Create
NSTextTableBlock *TextTableBlockWithTable( NSTextTable *table, NSInteger startingRow, NSInteger rowSpan, NSInteger startingColumn, NSInteger columnSpan )
{
#if __has_feature(objc_arc)
    return [[NSTextTableBlock alloc] initWithTable:table startingRow:startingRow rowSpan:rowSpan startingColumn:startingColumn columnSpan:columnSpan];
#else
    return [[[NSTextTableBlock alloc] initWithTable:table startingRow:startingRow rowSpan:rowSpan startingColumn:startingColumn columnSpan:columnSpan] autorelease];
#endif
}

// Table
NSTextTable *TextTableBlockTable( NSTextTableBlock *ref )
{ return [ref table]; }

// Info
NSInteger TextTableBlockStartingRow( NSTextTableBlock *ref )
{ return [ref startingRow]; }

NSInteger TextTableBlockRowSpan( NSTextTableBlock *ref )
{ return [ref rowSpan]; }

NSInteger TextTableBlockStartingColumn( NSTextTableBlock *ref )
{ return [ref startingColumn]; }

NSInteger TextTableBlockColumnSpan( NSTextTableBlock *ref )
{ return [ref columnSpan]; }



/*
 TextBlock
 */
// Create
NSTextBlock *TextBlockInit( void )
{
#if __has_feature(objc_arc)
    return [[NSTextBlock alloc] init];
#else
    return [[[NSTextBlock alloc] init] autorelease];
#endif
}

// Dimensions
void TextBlockSetValue( NSTextBlock *ref, CGFloat value, NSTextBlockValueType type, NSTextBlockDimension dimension )
{ [ref setValue:value type:type forDimension:dimension]; }

CGFloat TextBlockValueForDimension( NSTextBlock *ref, NSTextBlockDimension dimension )
{ return [ref valueForDimension:dimension]; }

NSTextBlockValueType TextBlockValueTypeForDimension( NSTextBlock *ref, NSTextBlockDimension dimension )
{ return [ref valueTypeForDimension:dimension]; }

CGFloat TextBlockContentWidth( NSTextBlock *ref )
{ return [ref contentWidth]; }

NSTextBlockValueType TextBlockContentWidthValueType( NSTextBlock *ref )
{ return [ref contentWidthValueType]; }

// Margins, borders and padding
void TextBlockSetWidthEdge( NSTextBlock *ref, CGFloat value, NSTextBlockValueType type, NSTextBlockLayer layer, CGRectEdge edge )
{ [ref setWidth:value type:type forLayer:layer edge:(NSRectEdge)edge]; }

void TextBlockSetWidth( NSTextBlock *ref, CGFloat value, NSTextBlockValueType type, NSTextBlockLayer layer )
{ [ref setWidth:value type:type forLayer:layer]; }

CGFloat TextBlockWidthForLayer( NSTextBlock *ref, NSTextBlockLayer layer, CGRectEdge edge )
{ return [ref widthForLayer:layer edge:(NSRectEdge)edge]; }

NSTextBlockValueType TextBlockWidthValueTypeForLayer( NSTextBlock *ref, NSTextBlockLayer layer, CGRectEdge edge )
{ return [ref widthValueTypeForLayer:layer edge:(NSRectEdge)edge]; }

// Alignment
NSTextBlockVerticalAlignment TextBlockVerticalAlignment( NSTextBlock *ref )
{ return [ref verticalAlignment]; }

void TextBlockSetVerticalAlignment( NSTextBlock *ref, NSTextBlockVerticalAlignment alignment )
{ [ref setVerticalAlignment:alignment]; }

// Color
NSColor *TextBlockBackgroundColor( NSTextBlock *ref )
{ return [ref backgroundColor]; }

void TextBlockSetBackgroundColor( NSTextBlock *ref, NSColor *col )
{ [ref setBackgroundColor:col]; }

void TextBlockSetBorderColorForEdge( NSTextBlock *ref, NSColor *col, CGRectEdge edge )
{ [ref setBorderColor:col forEdge:(NSRectEdge)edge]; }

void TextBlockSetBorderColor( NSTextBlock *ref, NSColor *col )
{ [ref setBorderColor:col]; }

NSColor *TextBlockBorderColorForEdge( NSTextBlock *ref, CGRectEdge edge )
{ return [ref borderColorForEdge:(NSRectEdge)edge]; }

// Size and position
CGRect TextBlockRectForLayoutAtPoint( NSTextBlock *ref, CGPoint pt, CGRect inRect, NSTextContainer *textContainer, CFRange charRange )
{ return NSRectToCGRect([ref rectForLayoutAtPoint:NSPointFromCGPoint(pt) inRect:NSRectFromCGRect(inRect) textContainer:textContainer characterRange:NSRangeFromCFRange(charRange)]); }

CGRect TextBlockBoundsRectForContentRect( NSTextBlock *ref, CGRect contentRect, CGRect inRect, NSTextContainer *textContainer, CFRange charRange )
{ return NSRectToCGRect([ref boundsRectForContentRect:NSRectFromCGRect(contentRect) inRect:NSRectFromCGRect(inRect) textContainer:textContainer characterRange:NSRangeFromCFRange(charRange)]); }

// Drawing
void TextBlockDrawBackgroundWithFrame( NSTextBlock *ref, CGRect frame, NSView *controlView, CFRange charRange, NSLayoutManager *layoutManager )
{ [ref drawBackgroundWithFrame:NSRectFromCGRect(frame) inView:controlView characterRange:NSRangeFromCFRange(charRange) layoutManager:layoutManager]; }

// Instance methods
void TextBlockSetContentWidth( NSTextBlock *ref, CGFloat width, NSTextBlockValueType type )
{ [ref setContentWidth:width type:type]; }

