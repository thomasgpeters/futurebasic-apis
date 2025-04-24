/*
 Box.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

#pragma mark - subclass
@interface BoxSC : NSBox
@end

@interface NSBox (Additions)
@property (nonatomic,retain) NSNumber *tagNumber;
- (NSInteger)tag;
- (void)setTag:(NSInteger)tag;
@end

#pragma mark - functions
// Class
Class BoxClass( void );

NSBox *BoxWithTag( NSInteger tag );
BOOL BoxExists( NSInteger tag );

// Configure
CGRect BoxBorderRect( NSInteger tag );
NSBoxType BoxType( NSInteger tag );
void BoxSetType( NSInteger tag, NSBoxType type );
NSBorderType BoxBorderType( NSInteger tag );
void BoxSetBorderType( NSInteger tag, NSBorderType type );
BOOL BoxIsTransparent( NSInteger tag );
void BoxSetTransparent( NSInteger tag, BOOL flag );
CFStringRef BoxTitle( NSInteger tag );
void BoxSetTitle( NSInteger tag, CFStringRef title );
CFTypeRef BoxTitleFont( NSInteger tag );
void BoxSetTitleFont( NSInteger tag, CFTypeRef inFont );
NSTitlePosition BoxTitlePosition( NSInteger tag );
void BoxSetTitlePosition( NSInteger tag, NSTitlePosition position );
CGRect BoxTitleRect( NSInteger tag );

// Customize
NSColor *BoxBorderColor( NSInteger tag );
void BoxSetBorderColor( NSInteger tag, NSColor *col );
NSColor *BoxFillColor( NSInteger tag );
void BoxSetFillColor( NSInteger tag, NSColor *col );
CGFloat BoxBorderWidth( NSInteger tag );
void BoxSetBorderWidth( NSInteger tag, CGFloat width );
CGFloat BoxCornerRadius( NSInteger tag );
void BoxSetCornerRadius( NSInteger tag, CGFloat radius );

// Content
NSView *BoxContentView( NSInteger tag );
void BoxSetContentView( NSInteger tag, NSView *aView );
CGSize BoxContentViewMargins( NSInteger tag );
void BoxSetContentViewMargins( NSInteger tag, CGSize size );

// Sizing
void BoxSetFrameFromContentFrame( NSInteger tag, CGRect contentFrame );
void BoxSizeToFit( NSInteger tag );

// custom
void BoxSetTitleFontWithName( NSInteger tag, CFStringRef inName, CGFloat size );

// Init
NSBox *BoxInit( NSInteger inTag, CGRect inRect );

// statement
void CUI_Box( NSInteger inTag, CFStringRef inTitle, CGRect inRect, NSInteger inType, NSInteger inWndTag );

