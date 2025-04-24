/*
 Cell.m

 Bernie Wylde
 */

#import "Cell.h"

@implementation CellSC
- (NSFont *)font {
    CellEventSetFont( [self font] );
    CallUserDefinedOnDialogFunction( cellFont, 0, 0, (__bridge CFTypeRef)self );
    return CellEventFont();
}
@end


@implementation CUI_CellEvent
#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.fontObj release];
    [super dealloc];
}
#endif
@end

CUI_CellEvent *CUI_CellEventObj( void )
{
    static CUI_CellEvent *sCUI_CellEvent = nil;
    if ( !sCUI_CellEvent ) sCUI_CellEvent = [[CUI_CellEvent alloc] init];
    return sCUI_CellEvent;
}

NSFont *CellEventFont( void )
{
    CUI_CellEvent *obj = CUI_CellEventObj();
    return [obj fontObj];
}

void CellEventSetFont( NSFont *font )
{
    CUI_CellEvent *obj = CUI_CellEventObj();
    [obj setFontObj:font];
}

// Class
Class CellClass( void )
{ return [NSCell class]; }

// Init
NSCell *CellWithImage( NSImage *image )
{
#if __has_feature(objc_arc)
    return [[NSCell alloc] initImageCell:image];
#else
    return [[[NSCell alloc] initImageCell:image] autorelease];
#endif
}

NSCell *CellWithText( CFStringRef text )
{
#if __has_feature(objc_arc)
    return [[NSCell alloc] initTextCell:(__bridge NSString *)text];
#else
    return [[[NSCell alloc] initTextCell:(__bridge NSString *)text] autorelease];
#endif
}

// Values
CFTypeRef CellObjectValue( NSCell *ref )
{ return (__bridge CFTypeRef)[ref objectValue]; }

void CellSetObjectValue( NSCell *ref, CFTypeRef obj )
{ [ref setObjectValue:(__bridge id)obj]; }

BOOL CellHasValidObjectValue( NSCell *ref )
{ return [ref hasValidObjectValue]; }

SInt32 CellIntValue( NSCell *ref )
{ return [ref intValue]; }

void CellSetIntValue( NSCell *ref, SInt32 value )
{ [ref setIntValue:value]; }

NSInteger CellIntegerValue( NSCell *ref )
{ return [ref integerValue]; }

void CellSetIntegerValue( NSCell *ref, NSInteger value )
{ [ref setIntegerValue:value]; }

CFStringRef CellStringValue( NSCell *ref )
{ return (__bridge CFStringRef)[ref stringValue]; }

void CellSetStringValue( NSCell *ref, CFStringRef string )
{ [ref setStringValue:(__bridge NSString *)string]; }

double CellDoubleValue( NSCell *ref )
{ return [ref doubleValue]; }

void CellSetDoubleValue( NSCell *ref, double value )
{ [ref setDoubleValue:value]; }

float CellFloatValue( NSCell *ref )
{ return [ref floatValue]; }

void CellSetFloatValue( NSCell *ref, float value )
{ [ref setFloatValue:value]; }

// Attributes
NSInteger CellAttribute( NSCell *ref, NSCellAttribute parameter )
{ return [ref cellAttribute:parameter]; }

void CellSetAttribute( NSCell *ref, NSCellAttribute parameter, NSInteger value )
{ [ref setCellAttribute:parameter to:value]; }

NSCellType CellType( NSCell *ref )
{ return [ref type]; }

void CellSetType( NSCell *ref, NSCellType type )
{ [ref setType:type]; }

BOOL CellIsEnabled( NSCell *ref )
{ return [ref isEnabled]; }

void CellSetEnabled( NSCell *ref, BOOL flag )
{ [ref setEnabled:flag]; }

BOOL CellAllowsUndo( NSCell *ref )
{ return [ref allowsUndo]; }

void CellSetAllowsUndo( NSCell *ref, BOOL flag )
{ [ref setAllowsUndo:flag]; }

// Display attributes
BOOL CellIsBezeled( NSCell *ref )
{ return [ref isBezeled]; }

void CellSetBezeled( NSCell *ref, BOOL flag )
{ [ref setBezeled:flag]; }

BOOL CellIsBordered( NSCell *ref )
{ return [ref isBordered]; }

void CellSetBordered( NSCell *ref, BOOL flag )
{ [ref setBordered:flag]; }

BOOL CellIsOpaque( NSCell *ref )
{ return [ref isOpaque]; }

NSBackgroundStyle CellBackgroundStyle( NSCell *ref )
{ return [ref backgroundStyle]; }

void CellSetBackgroundStyle( NSCell *ref, NSBackgroundStyle style )
{ [ref setBackgroundStyle:style]; }

NSBackgroundStyle CellInteriorBackgroundStyle( NSCell *ref )
{ return [ref interiorBackgroundStyle]; }

// State
BOOL CellAllowsMixedState( NSCell *ref )
{ return [ref allowsMixedState]; }

void CellSetAllowsMixedState( NSCell *ref, BOOL flag )
{ [ref setAllowsMixedState:flag]; }

NSInteger CellNextState( NSCell *ref )
{ return [ref nextState]; }

void CellSetNextState( NSCell *ref )
{ [ref setNextState]; }

NSInteger CellState( NSCell *ref )
{ return [ref state]; }

// Textual attributes
BOOL CellIsEditable( NSCell *ref )
{ return [ref isEditable]; }

void CellSetEditable( NSCell *ref, BOOL flag )
{ [ref setEditable:flag]; }

BOOL CellIsSelectable( NSCell *ref )
{ return [ref isSelectable]; }

void CellSetSelectable( NSCell *ref, BOOL flag )
{ [ref setSelectable:flag]; }

BOOL CellIsScrollable( NSCell *ref )
{ return [ref isScrollable]; }

void CellSetScrollable( NSCell *ref, BOOL flag )
{ [ref setScrollable:flag]; }

NSTextAlignment CellAlignment( NSCell *ref )
{ return [ref alignment]; }

void CellSetAlignment( NSCell *ref, NSTextAlignment alignment )
{ [ref setAlignment:alignment]; }

NSFont *CellFont( NSCell *ref )
{ return [ref font]; }

void CellSetFont( NSCell *ref, NSFont *font )
{ [ref setFont:font]; }

NSLineBreakMode CellLineBreakMode( NSCell *ref )
{ return [ref lineBreakMode]; }

void CellSetLineBreakMode( NSCell *ref, NSLineBreakMode mode )
{ [ref setLineBreakMode:mode]; }

BOOL CellTruncatesLastVisibleLine( NSCell *ref )
{ return [ref truncatesLastVisibleLine]; }

void CellSetTruncatesLastVisibleLine( NSCell *ref, BOOL flag )
{ [ref setTruncatesLastVisibleLine:flag]; }

BOOL CellWraps( NSCell *ref )
{ return [ref wraps]; }

void CellSetWraps( NSCell *ref, BOOL flag )
{ [ref setWraps:flag]; }

NSWritingDirection CellBaseWritingDirection( NSCell *ref )
{ return [ref baseWritingDirection]; }

void CellSetBaseWritingDirection( NSCell *ref, NSWritingDirection direction )
{ [ref setBaseWritingDirection:direction]; }

CFAttributedStringRef CellAttributedStringValue( NSCell *ref )
{ return (__bridge CFAttributedStringRef)[ref attributedStringValue]; }

void CellSetAttributedStringValue( NSCell *ref, CFAttributedStringRef aString )
{ [ref setAttributedStringValue:(__bridge NSAttributedString *)aString]; }

BOOL CellAllowsEditingTextAttributes( NSCell *ref )
{ return [ref allowsEditingTextAttributes]; }

void CellSetAllowsEditingTextAttributes( NSCell *ref, BOOL flag )
{ [ref setAllowsEditingTextAttributes:flag]; }

BOOL CellImportsGraphics( NSCell *ref )
{ return [ref importsGraphics]; }

void CellSetImportsGraphics( NSCell *ref, BOOL flag )
{ [ref setImportsGraphics:flag]; }

NSText *CellSetUpFieldEditorAttributes( NSCell *ref, NSText *textObj )
{ return [ref setUpFieldEditorAttributes:textObj]; }

CFStringRef CellTitle( NSCell *ref )
{ return (__bridge CFStringRef)[ref title]; }

void CellSetTitle( NSCell *ref, CFStringRef title )
{ [ref setTitle:(__bridge NSString *)title]; }

// Target and action
SEL CellAction( NSCell *ref )
{ return [ref action]; }

void CellSetAction( NSCell *ref, SEL action )
{ [ref setAction:action]; }

CFTypeRef CellTarget( NSCell *ref )
{ return (__bridge CFTypeRef)[ref target]; }

void CellSetTarget( NSCell *ref, CFTypeRef target )
{ [ref setTarget:(__bridge id)target]; }

BOOL CellIsContinuous( NSCell *ref )
{ return [ref isContinuous]; }

void CellSetContinuous( NSCell *ref, BOOL flag )
{ [ref setContinuous:flag]; }

NSInteger CellSendActionOn( NSCell *ref, NSEventMask mask )
{ return [ref sendActionOn:mask]; }

// Image
NSImage *CellImage( NSCell *ref )
{ return [ref image]; }

void CellSetImage( NSCell *ref, CFTypeRef inImage )
{
    NSImage *image = CUI_FixImageValue( inImage );
    [ref setImage:image];
}

// Tag
NSInteger CellTag( NSCell *ref )
{ return [ref tag]; }

void CellSetTag( NSCell *ref, NSInteger tag )
{ [ref setTag:tag]; }

// Formatter
NSFormatter *CellFormatter( NSCell *ref )
{ return [ref formatter]; }

void CellSetFormatter( NSCell *ref, NSFormatter *formatter )
{ [ref setFormatter:formatter]; }

// Menus
NSMenu *CellDefaultMenu( void )
{ return [NSCell defaultMenu]; }

NSMenu *CellMenu( NSCell *ref )
{ return [ref menu]; }

void CellSetMenu( NSCell *ref, NSMenu *m )
{ [ref setMenu:m]; }

NSMenu *CellMenuForEvent( NSCell *ref, NSEvent *event, CGRect cellFrame, NSView *aView )
{ return [ref menuForEvent:event inRect:NSRectFromCGRect(cellFrame) ofView:aView]; }

// Compare
NSComparisonResult CellCompare( NSCell *ref, NSCell *otherCell )
{ return [ref compare:otherCell]; }

// Keyboard events
BOOL CellAcceptsFirstResponder( NSCell *ref )
{ return [ref acceptsFirstResponder]; }

BOOL CellShowsFirstResponder( NSCell *ref )
{ return [ref showsFirstResponder]; }

BOOL CellRefusesFirstResponder( NSCell *ref )
{ return [ref refusesFirstResponder]; }

void CellPerformClick( NSCell *ref )
{ [ref performClick:nil]; }

// Deriving values
void CellTakeObjectValueFrom( NSCell *ref, CFTypeRef sender )
{ [ref takeObjectValueFrom:(__bridge id)sender]; }

void CellTakeIntegerValueFrom( NSCell *ref, CFTypeRef sender )
{ [ref takeIntegerValueFrom:(__bridge id)sender]; }

void CellTakeIntValueFrom( NSCell *ref, CFTypeRef sender )
{ [ref takeIntValueFrom:(__bridge id)sender]; }

void CellTakeStringValueFrom( NSCell *ref, CFTypeRef sender )
{ [ref takeStringValueFrom:(__bridge id)sender]; }

void CellTakeDoubleValueFrom( NSCell *ref, CFTypeRef sender )
{ [ref takeDoubleValueFrom:(__bridge id)sender]; }

void CellTakeFloatValueFrom( NSCell *ref, CFTypeRef sender )
{ [ref takeFloatValueFrom:(__bridge id)sender]; }

// Represented object
CFTypeRef CellRepresentedObject( NSCell *ref )
{ return (__bridge CFTypeRef)[ref representedObject]; }

void CellSetRepresentedObject( NSCell *ref, CFTypeRef obj )
{ [ref setRepresentedObject:(__bridge id)obj]; }

// Track mouse
NSInteger CellMouseDownFlags( NSCell *ref )
{ return [ref mouseDownFlags]; }

BOOL CellPrefersTrackingUntilMouseUp( void )
{ return [NSCell prefersTrackingUntilMouseUp]; }

void CellGetPeriodicDelay( NSCell *ref, float *delayValue, float *interval )
{ [ref getPeriodicDelay:delayValue interval:interval]; }

// Hit test
NSUInteger CellHitTestForEvent( NSCell *ref, NSEvent *event, CGRect cellFrame, NSView *controlView )
{ return [ref hitTestForEvent:event inRect:NSRectFromCGRect(cellFrame) ofView:controlView]; }

// Keyboard alternatives
CFStringRef CellKeyEquivalent( NSCell *ref )
{ return (__bridge CFStringRef)[ref keyEquivalent]; }

// Focus ring
NSFocusRingType CellDefaultFocusRingType( void )
{ return [NSCell defaultFocusRingType]; }

NSFocusRingType CellFocusRingType( NSCell *ref )
{ return [ref focusRingType]; }

void CellSetFocusRingType( NSCell *ref, NSFocusRingType type )
{ [ref setFocusRingType:type]; }

// Cell size
CGSize CellSize( NSCell *ref )
{ return NSSizeToCGSize([ref cellSize]); }

CGSize CellSizeForBounds( NSCell *ref, CGRect bounds )
{ return NSSizeToCGSize([ref cellSizeForBounds:NSRectFromCGRect(bounds)]); }

CGRect CellDrawingRectForBounds( NSCell *ref, CGRect bounds )
{ return NSRectToCGRect([ref drawingRectForBounds:NSRectFromCGRect(bounds)]); }

CGRect CellImageRectForBounds( NSCell *ref, CGRect bounds )
{ return NSRectToCGRect([ref imageRectForBounds:NSRectFromCGRect(bounds)]); }

CGRect CellTitleRectForBounds( NSCell *ref, CGRect bounds )
{ return NSRectToCGRect([ref titleRectForBounds:NSRectFromCGRect(bounds)]); }

NSControlSize CellControlSize( NSCell *ref )
{ return [ref controlSize]; }

void CellSetControlSize( NSCell *ref, NSControlSize size )
{ [ref setControlSize:size]; }

// Highlighting
NSColor *CellHighlightColor( NSCell *ref, CGRect frame, NSView *controlView )
{ return [ref highlightColorWithFrame:NSRectFromCGRect(frame) inView:controlView]; }

NSView *CellControlView( NSCell *ref )
{ return [ref controlView]; }

void CellSetControlView( NSCell *ref, NSView *aView )
{ [ref setControlView:aView]; }

void CellHighlight( NSCell *ref, BOOL flag, CGRect frame, NSView *controlView )
{ [ref highlight:flag withFrame:NSRectFromCGRect(frame) inView:controlView]; }

BOOL CellIsHighlighted( NSCell *ref )
{ return [ref isHighlighted]; }

// Editing and selecting text
BOOL CellSendsActionOnEditing( NSCell *ref )
{ return [ref sendsActionOnEndEditing]; }

void CellSetSendsActionOnEditing( NSCell *ref, BOOL flag )
{ [ref setSendsActionOnEndEditing:flag]; }

void CellEndEditing( NSCell *ref, NSText *textObj )
{ [ref endEditing:textObj]; }

BOOL CellUsesSingleLineMode( NSCell *ref )
{ return [ref usesSingleLineMode]; }

void CellSetUsesSingleLineMode( NSCell *ref, BOOL flag )
{ [ref setUsesSingleLineMode:flag]; }

// Expansion frames
CGRect CellExpansionFrame( NSCell *ref, CGRect frame, NSView *controlView )
{ return NSRectToCGRect([ref expansionFrameWithFrame:NSRectFromCGRect(frame) inView:controlView]); }

void CellDrawWithExpansionFrame( NSCell *ref, CGRect frame, NSView *controlView )
{ [ref drawWithExpansionFrame:NSRectFromCGRect(frame) inView:controlView]; }

// Layout direction
NSUserInterfaceLayoutDirection CellUserInterfaceLayoutDirection( NSCell *ref )
{ return [ref userInterfaceLayoutDirection]; }

void CellSetUserInterfaceLayoutDirection( NSCell *ref, NSUserInterfaceLayoutDirection direction )
{ [ref setUserInterfaceLayoutDirection:direction]; }


// Multipart images
void nsDrawThreePartImage( CGRect frame, NSImage *startCap, NSImage *centerFill, NSImage *endCap, BOOL vertical, NSCompositingOperation op, CGFloat alphaFraction, BOOL flipped )
{ NSDrawThreePartImage( NSRectFromCGRect(frame), startCap, centerFill, endCap, vertical, op, alphaFraction, flipped ); }

void nsDrawNinePartImage( CGRect frame, NSImage *tl, NSImage *t, NSImage *tr, NSImage *l, NSImage *c, NSImage *r, NSImage *bl, NSImage *b, NSImage *br, NSCompositingOperation op, CGFloat alphaFraction, BOOL flipped )
{ NSDrawNinePartImage( NSRectFromCGRect(frame),tl, t, tr, l, c, r, bl, b, br, op, alphaFraction, flipped ); }
