/*
 TextTable.h

 Bernie Wylde
 */

#import "CocoaUI.h"

// Class
Class TextTableClass( void );

NSTextTable *TextTableInit( void );

NSUInteger TextTableNumberOfColumns( NSTextTable *ref );
void TextTableSetNumberOfColumns( NSTextTable *ref, NSUInteger cols );

NSTextTableLayoutAlgorithm TextTableLayoutAlgorithm( NSTextTable *ref );
void TextTableSetLayoutAlgorithm( NSTextTable *ref, NSTextTableLayoutAlgorithm algorithm );

BOOL TextTableCollapsesBorders( NSTextTable *ref );
void TextTableSetCollapsesBorders( NSTextTable *ref, BOOL flag );

BOOL TextTableHidesEmptyCells( NSTextTable *ref );
void TextTableSetHidesEmptyCells( NSTextTable *ref, BOOL flag );

CGRect TextTableRectForBlock( NSTextTable *ref, NSTextTableBlock *block, CGPoint startingPt, CGRect inRect, NSTextContainer *textContainer, CFRange charRange );
CGRect TextTableBoundsRectForBlock( NSTextTable *ref, NSTextTableBlock *block, CGRect contentRect, CGRect inRect, NSTextContainer *textContainer, CFRange charRange );

void TextTableDrawBackgroundForBlock( NSTextTable *ref, NSTextTableBlock *block, CGRect frame, NSView *controlView, CFRange charRange, NSLayoutManager *layoutManager );


/*
 TextTableBlock
 */
// Create
NSTextTableBlock *TextTableBlockWithTable( NSTextTable *table, NSInteger startingRow, NSInteger rowSpan, NSInteger startingColumn, NSInteger columnSpan );

// Table
NSTextTable *TextTableBlockTable( NSTextTableBlock *ref );

// Info
NSInteger TextTableBlockStartingRow( NSTextTableBlock *ref );
NSInteger TextTableBlockRowSpan( NSTextTableBlock *ref );
NSInteger TextTableBlockStartingColumn( NSTextTableBlock *ref );
NSInteger TextTableBlockColumnSpan( NSTextTableBlock *ref );



/*
 TextBlock
 */
// Create
NSTextBlock *TextBlockInit( void );

// Dimensions
void TextBlockSetValue( NSTextBlock *ref, CGFloat value, NSTextBlockValueType type, NSTextBlockDimension dimension );
CGFloat TextBlockValueForDimension( NSTextBlock *ref, NSTextBlockDimension dimension );
NSTextBlockValueType TextBlockValueTypeForDimension( NSTextBlock *ref, NSTextBlockDimension dimension );
CGFloat TextBlockContentWidth( NSTextBlock *ref );
NSTextBlockValueType TextBlockContentWidthValueType( NSTextBlock *ref );

// Margins, borders and padding
void TextBlockSetWidthEdge( NSTextBlock *ref, CGFloat value, NSTextBlockValueType type, NSTextBlockLayer layer, CGRectEdge edge );
void TextBlockSetWidth( NSTextBlock *ref, CGFloat value, NSTextBlockValueType type, NSTextBlockLayer layer );
CGFloat TextBlockWidthForLayer( NSTextBlock *ref, NSTextBlockLayer layer, CGRectEdge edge );
NSTextBlockValueType TextBlockWidthValueTypeForLayer( NSTextBlock *ref, NSTextBlockLayer layer, CGRectEdge edge );

// Alignment
NSTextBlockVerticalAlignment TextBlockVerticalAlignment( NSTextBlock *ref );
void TextBlockSetVerticalAlignment( NSTextBlock *ref, NSTextBlockVerticalAlignment alignment );

// Color
NSColor *TextBlockBackgroundColor( NSTextBlock *ref );
void TextBlockSetBackgroundColor( NSTextBlock *ref, NSColor *col );
void TextBlockSetBorderColorForEdge( NSTextBlock *ref, NSColor *col, CGRectEdge edge );
void TextBlockSetBorderColor( NSTextBlock *ref, NSColor *col );
NSColor *TextBlockBorderColorForEdge( NSTextBlock *ref, CGRectEdge edge );

// Size and position
CGRect TextBlockRectForLayoutAtPoint( NSTextBlock *ref, CGPoint pt, CGRect inRect, NSTextContainer *textContainer, CFRange charRange );
CGRect TextBlockBoundsRectForContentRect( NSTextBlock *ref, CGRect contentRect, CGRect inRect, NSTextContainer *textContainer, CFRange charRange );

// Drawing
void TextBlockDrawBackgroundWithFrame( NSTextBlock *ref, CGRect frame, NSView *controlView, CFRange charRange, NSLayoutManager *layoutManager );

// Instance methods
void TextBlockSetContentWidth( NSTextBlock *ref, CGFloat width, NSTextBlockValueType type );

