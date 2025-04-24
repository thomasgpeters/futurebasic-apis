/*
 Cell.h

 Bernie Wylde
 */

#import "CocoaUI.h"

@interface CellSC : NSCell
@end

@interface CUI_CellEvent : NSObject
@property (nonatomic,retain) NSFont *fontObj;
@end

// dialog events
enum {
    cellFont = 4200
};

CUI_CellEvent *CUI_CellEventObj( void );

NSFont *CellEventFont( void );
void CellEventSetFont( NSFont *font );

// Class
Class CellClass( void );

// Init
NSCell *CellWithImage( NSImage *image );
NSCell *CellWithText( CFStringRef text );

// Values
CFTypeRef CellObjectValue( NSCell *ref );
void CellSetObjectValue( NSCell *ref, CFTypeRef obj );
BOOL CellHasValidObjectValue( NSCell *ref );
SInt32 CellIntValue( NSCell *ref );
void CellSetIntValue( NSCell *ref, SInt32 value );
NSInteger CellIntegerValue( NSCell *ref );
void CellSetIntegerValue( NSCell *ref, NSInteger value );
CFStringRef CellStringValue( NSCell *ref );
void CellSetStringValue( NSCell *ref, CFStringRef string );
double CellDoubleValue( NSCell *ref );
void CellSetDoubleValue( NSCell *ref, double value );
float CellFloatValue( NSCell *ref );
void CellSetFloatValue( NSCell *ref, float value );

// Attributes
NSInteger CellAttribute( NSCell *ref, NSCellAttribute parameter );
void CellSetAttribute( NSCell *ref, NSCellAttribute parameter, NSInteger value );
NSCellType CellType( NSCell *ref );
void CellSetType( NSCell *ref, NSCellType type );
BOOL CellIsEnabled( NSCell *ref );
void CellSetEnabled( NSCell *ref, BOOL flag );
BOOL CellAllowsUndo( NSCell *ref );
void CellSetAllowsUndo( NSCell *ref, BOOL flag );

// Display attributes
BOOL CellIsBezeled( NSCell *ref );
void CellSetBezeled( NSCell *ref, BOOL flag );
BOOL CellIsBordered( NSCell *ref );
void CellSetBordered( NSCell *ref, BOOL flag );
BOOL CellIsOpaque( NSCell *ref );
NSBackgroundStyle CellBackgroundStyle( NSCell *ref );
void CellSetBackgroundStyle( NSCell *ref, NSBackgroundStyle style );
NSBackgroundStyle CellInteriorBackgroundStyle( NSCell *ref );

// State
BOOL CellAllowsMixedState( NSCell *ref );
void CellSetAllowsMixedState( NSCell *ref, BOOL flag );
NSInteger CellNextState( NSCell *ref );
void CellSetNextState( NSCell *ref );
NSInteger CellState( NSCell *ref );

// Textual attributes
BOOL CellIsEditable( NSCell *ref );
void CellSetEditable( NSCell *ref, BOOL flag );
BOOL CellIsSelectable( NSCell *ref );
void CellSetSelectable( NSCell *ref, BOOL flag );
BOOL CellIsScrollable( NSCell *ref );
void CellSetScrollable( NSCell *ref, BOOL flag );
NSTextAlignment CellAlignment( NSCell *ref );
void CellSetAlignment( NSCell *ref, NSTextAlignment alignment );
NSFont *CellFont( NSCell *ref );
void CellSetFont( NSCell *ref, NSFont *font );
NSLineBreakMode CellLineBreakMode( NSCell *ref );
void CellSetLineBreakMode( NSCell *ref, NSLineBreakMode mode );
BOOL CellTruncatesLastVisibleLine( NSCell *ref );
void CellSetTruncatesLastVisibleLine( NSCell *ref, BOOL flag );
BOOL CellWraps( NSCell *ref );
void CellSetWraps( NSCell *ref, BOOL flag );
NSWritingDirection CellBaseWritingDirection( NSCell *ref );
void CellSetBaseWritingDirection( NSCell *ref, NSWritingDirection direction );
CFAttributedStringRef CellAttributedStringValue( NSCell *ref );
void CellSetAttributedStringValue( NSCell *ref, CFAttributedStringRef aString );
BOOL CellAllowsEditingTextAttributes( NSCell *ref );
void CellSetAllowsEditingTextAttributes( NSCell *ref, BOOL flag );
BOOL CellImportsGraphics( NSCell *ref );
void CellSetImportsGraphics( NSCell *ref, BOOL flag );
NSText *CellSetUpFieldEditorAttributes( NSCell *ref, NSText *textObj );
CFStringRef CellTitle( NSCell *ref );
void CellSetTitle( NSCell *ref, CFStringRef title );

// Target and action
SEL CellAction( NSCell *ref );
void CellSetAction( NSCell *ref, SEL action );
CFTypeRef CellTarget( NSCell *ref );
void CellSetTarget( NSCell *ref, CFTypeRef target );
BOOL CellIsContinuous( NSCell *ref );
void CellSetContinuous( NSCell *ref, BOOL flag );
NSInteger CellSendActionOn( NSCell *ref, NSEventMask mask );

// Image
NSImage *CellImage( NSCell *ref );
void CellSetImage( NSCell *ref, CFTypeRef inImage );

// Tag
NSInteger CellTag( NSCell *ref );
void CellSetTag( NSCell *ref, NSInteger tag );

// Formatter
NSFormatter *CellFormatter( NSCell *ref );
void CellSetFormatter( NSCell *ref, NSFormatter *formatter );

// Menus
NSMenu *CellDefaultMenu( void );
NSMenu *CellMenu( NSCell *ref );
void CellSetMenu( NSCell *ref, NSMenu *m );
NSMenu *CellMenuForEvent( NSCell *ref, NSEvent *event, CGRect cellFrame, NSView *aView );

// Compare
NSComparisonResult CellCompare( NSCell *ref, NSCell *otherCell );

// Keyboard events
BOOL CellAcceptsFirstResponder( NSCell *ref );
BOOL CellShowsFirstResponder( NSCell *ref );
BOOL CellRefusesFirstResponder( NSCell *ref );
void CellPerformClick( NSCell *ref );

// Deriving values
void CellTakeObjectValueFrom( NSCell *ref, CFTypeRef sender );
void CellTakeIntegerValueFrom( NSCell *ref, CFTypeRef sender );
void CellTakeIntValueFrom( NSCell *ref, CFTypeRef sender );
void CellTakeStringValueFrom( NSCell *ref, CFTypeRef sender );
void CellTakeDoubleValueFrom( NSCell *ref, CFTypeRef sender );
void CellTakeFloatValueFrom( NSCell *ref, CFTypeRef sender );

// Represented object
CFTypeRef CellRepresentedObject( NSCell *ref );
void CellSetRepresentedObject( NSCell *ref, CFTypeRef obj );

// Track mouse
NSInteger CellMouseDownFlags( NSCell *ref );
BOOL CellPrefersTrackingUntilMouseUp( void );
void CellGetPeriodicDelay( NSCell *ref, float *delayValue, float *interval );

// Hit test
NSUInteger CellHitTestForEvent( NSCell *ref, NSEvent *event, CGRect cellFrame, NSView *controlView );

// Keyboard alternatives
CFStringRef CellKeyEquivalent( NSCell *ref );

// Focus ring
NSFocusRingType CellDefaultFocusRingType( void );
NSFocusRingType CellFocusRingType( NSCell *ref );
void CellSetFocusRingType( NSCell *ref, NSFocusRingType type );

// Cell size
CGSize CellSize( NSCell *ref );
CGSize CellSizeForBounds( NSCell *ref, CGRect bounds );
CGRect CellDrawingRectForBounds( NSCell *ref, CGRect bounds );
CGRect CellImageRectForBounds( NSCell *ref, CGRect bounds );
CGRect CellTitleRectForBounds( NSCell *ref, CGRect bounds );
NSControlSize CellControlSize( NSCell *ref );
void CellSetControlSize( NSCell *ref, NSControlSize size );

// Highlighting
NSColor *CellHighlightColor( NSCell *ref, CGRect frame, NSView *controlView );
NSView *CellControlView( NSCell *ref );
void CellSetControlView( NSCell *ref, NSView *aView );
void CellHighlight( NSCell *ref, BOOL flag, CGRect frame, NSView *controlView );
BOOL CellIsHighlighted( NSCell *ref );

// Editing and selecting text
BOOL CellSendsActionOnEditing( NSCell *ref );
void CellSetSendsActionOnEditing( NSCell *ref, BOOL flag );
void CellEndEditing( NSCell *ref, NSText *textObj );
BOOL CellUsesSingleLineMode( NSCell *ref );
void CellSetUsesSingleLineMode( NSCell *ref, BOOL flag );

// Expansion frames
CGRect CellExpansionFrame( NSCell *ref, CGRect frame, NSView *controlView );
void CellDrawWithExpansionFrame( NSCell *ref, CGRect frame, NSView *controlView );

// Layout direction
NSUserInterfaceLayoutDirection CellUserInterfaceLayoutDirection( NSCell *ref );
void CellSetUserInterfaceLayoutDirection( NSCell *ref, NSUserInterfaceLayoutDirection direction );

// Multipart images
void nsDrawThreePartImage( CGRect frame, NSImage *startCap, NSImage *centerFill, NSImage *endCap, BOOL vertical, NSCompositingOperation op, CGFloat alphaFraction, BOOL flipped );
void nsDrawNinePartImage( CGRect frame, NSImage *tl, NSImage *t, NSImage *tr, NSImage *l, NSImage *c, NSImage *r, NSImage *bl, NSImage *b, NSImage *br, NSCompositingOperation op, CGFloat alphaFraction, BOOL flipped );
