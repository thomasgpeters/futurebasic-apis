/*
 Color.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef NSColor *(*CUI_ColorWithNameDynamicProviderType)(CFStringRef,NSAppearance*,void*);


// Class
Class ColorClass( void );

// UI element
// - Label

// - Text
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
NSColor *ColorPlaceholderText( void );
#endif

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
NSColor *ColorUnemphasizedSelectedText( void );
API_AVAILABLE(macos(10.14))
NSColor *ColorUnemphasizedSelectedTextBackground( void );
#endif

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
NSColor *ColorTextInsertionPoint( void );
#endif// 140000

// - Content
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
NSColor *ColorLink( void );
#endif

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
NSColor *ColorSeparator( void );
API_AVAILABLE(macos(10.14))
NSColor *ColorSelectedContentBackground( void );
API_AVAILABLE(macos(10.14))
NSColor *ColorUnemphasizedSelectedContentBackground( void );
#endif

// Table
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
CFArrayRef ColorAlternatingContentBackgrounds( void );
#endif

// - Control
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
NSColor *ColorControlAccent( void );
#endif

// - Highlights and shadows
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
NSColor *ColorFindHighlight( void );
#endif


// Creation
// - Asset catalogs
NSColor *ColorNamed( CFStringRef name );
NSColor *ColorNamedBundle( CFStringRef name, NSBundle *bundle );

NSColor *ColorWithCatalogName( CFStringRef catalogName, CFStringRef colorName );


// - Arbitrary color space
NSColor *ColorWithColorSpace( NSColorSpace *cs, const CGFloat *components, NSInteger count );


// Appearance
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
NSColor *ColorWithSystemEffect( NSColor *col, NSColorSystemEffect effect );
#endif

// Transforming
NSColor *ColorUsingColorSpace( NSColor *col,  NSColorSpace *cs );
NSColor *ColorBlendedWithFractionOfColor( NSColor *col1, CGFloat fraction, NSColor *col2 );
NSColor *ColorHighlightWithLevel( NSColor *col, CGFloat value );
NSColor *ColorShadowWithLevel( NSColor *col, CGFloat value );


// Alpha support
BOOL ColorIgnoresAlpha( void );

// Copy paste color info
NSColor *ColorFromPasteboard( NSPasteboard *pb );
void ColorWriteToPastebord( NSColor *col, NSPasteboard *pb );

// Color space
NSColorType ColorType( NSColor *col );
NSColor *ColorUsingType( NSColor *col, NSColorType type );

NSColorSpace *ColorColorSpace( NSColor *col );

// Drawing
void ColorDrawSwatchInRect( NSColor *col, CGRect r );


// system
NSColor *ColorAlternateSelectedControl( void );
NSColor *ColorAlternateSelectedControlText( void );
NSColor *ColorForControlTint( NSControlTint tint );
NSColor *ColorControlBackground( void );
NSColor *ColorControl( void );
CFArrayRef ColorControlAlternatingRowBackground( void );
NSColor *ColorControlHighlight( void );
NSColor *ColorControlShadow( void );
NSColor *ColorControlDarkShadow( void );
NSColor *ColorControlText( void );
NSControlTint ColorCurrentControlTint( void );
NSColor *ColorDisabledControlText( void );
NSColor *ColorGrid( void );
NSColor *ColorHeader( void );
NSColor *ColorHeaderText( void );
NSColor *ColorHighlight( void );
NSColor *ColorKeyboardFocusIndicator( void );
NSColor *ColorKnob( void );
NSColor *ColorScrollBar( void );

NSColor *ColorScrubberTexturedBackground( void );

NSColor *ColorSecondarySelectedControl( void );
NSColor *ColorSelectedControl( void );
NSColor *ColorSelectedControlText( void );
NSColor *ColorSelectedMenuItem( void );
NSColor *ColorSelectedMenuItemText( void );
NSColor *ColorSelectedTextBackground( void );
NSColor *ColorSelectedText( void );
NSColor *ColorSelectedKnob( void );
NSColor *ColorShadow( void );

NSColor *ColorSystemBlue( void );
NSColor *ColorSystemBrown( void );
NSColor *ColorSystemGray( void );
NSColor *ColorSystemGreen( void );
NSColor *ColorSystemOrange( void );
NSColor *ColorSystemPink( void );
NSColor *ColorSystemPurple( void );
NSColor *ColorSystemRed( void );
NSColor *ColorSystemYellow( void );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
NSColor *ColorSystemIndigo( void );
API_AVAILABLE(macos(10.15))
NSColor *ColorSystemTeal( void );
#endif// 101500

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
NSColor *ColorSystemMint( void );
API_AVAILABLE(macos(12.0))
NSColor *ColorSystemCyan( void );
#endif// 120000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
NSColor *ColorSystemFill( void );
API_AVAILABLE(macos(14.0))
NSColor *ColorSecondarySystemFill( void );
API_AVAILABLE(macos(14.0))
NSColor *ColorTertiarySystemFill( void );
API_AVAILABLE(macos(14.0))
NSColor *ColorQuaternarySystemFill( void );
API_AVAILABLE(macos(14.0))
NSColor *ColorQuinarySystemFill( void );
#endif// 140000

NSColor *ColorTextBackground( void );
NSColor *ColorText( void );
NSColor *ColorWindowBackground( void );
NSColor *ColorWindowFrame( void );
NSColor *ColorWindowFrameText( void );
NSColor *ColorUnderPageBackground( void );

NSColor *ColorLabel( void );
NSColor *ColorSecondaryLabel( void );
NSColor *ColorTertiaryLabel( void );
NSColor *ColorQuaternaryLabel( void );

NSColor *ColorBlack( void );
NSColor *ColorBlue( void );
NSColor *ColorBrown( void );
NSColor *ColorClear( void );
NSColor *ColorCyan( void );
NSColor *ColorDarkGray( void );
NSColor *ColorGray( void );
NSColor *ColorGreen( void );
NSColor *ColorLightGray( void );
NSColor *ColorMagenta( void );
NSColor *ColorOrange( void );
NSColor *ColorPurple( void );
NSColor *ColorRed( void );
NSColor *ColorWhite( void );
NSColor *ColorYellow( void );
NSColor *ColorWithCalibratedHSB( CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha );
NSColor *ColorWithDeviceHSB( CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha );
NSColor *ColorWithHSB( CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha );
NSColor *ColorWithSRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha );
NSColor *ColorWithDisplayP3( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha );
NSColor *ColorWithRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha );
NSColor *ColorWithCalibratedRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha );
NSColor *ColorWithDeviceRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha );
NSColor *ColorWithWhite( CGFloat white, CGFloat alpha );
NSColor *ColorWithCalibratedWhite( CGFloat white, CGFloat alpha );
NSColor *ColorWithDeviceWhite( CGFloat white, CGFloat alpha );
NSColor *ColorWithGenericGamma22White( CGFloat white, CGFloat alpha );
NSColor *ColorWithDeviceCMYK( CGFloat cyan, CGFloat magenta, CGFloat yellow, CGFloat black, CGFloat alpha );
NSColor *ColorWithCGColor( CGColorRef col );
CGColorRef ColorCGColor( NSColor *col );
NSColor *ColorWithCIColor( CIColor *col );
NSColor *ColorWithPatternImage( CFTypeRef inImage );
NSImage *ColorPatternImage( NSColor *col );
NSColor *ColorWithAlphaComponent( NSColor *col, CGFloat alpha );
void ColorGetCMYK( NSColor *col, CGFloat *c, CGFloat *m, CGFloat *y, CGFloat *k, CGFloat *a );
void ColorGetHSB( NSColor *col, CGFloat *h, CGFloat *s, CGFloat *b, CGFloat *a );
void ColorGetRGB( NSColor *col, CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a );
void ColorGetWhite( NSColor *col, CGFloat *w, CGFloat *a );
NSInteger ColorNumberOfComponents( NSColor *col );
void ColorGetComponents( NSColor *col, CGFloat *components );
CGFloat ColorAlphaComponent( NSColor *col );
CGFloat ColorWhiteComponent( NSColor *col );
CGFloat ColorRedComponent( NSColor *col );
CGFloat ColorGreenComponent( NSColor *col );
CGFloat ColorBlueComponent( NSColor *col );
CGFloat ColorCyanComponent( NSColor *col );
CGFloat ColorMagentaComponent( NSColor *col );
CGFloat ColorYellowComponent( NSColor *col );
CGFloat ColorBlackComponent( NSColor *col );
CGFloat ColorHueComponent( NSColor *col );
CGFloat ColorSaturationComponent( NSColor *col );
CGFloat ColorBrightnessComponent( NSColor *col );
CFStringRef ColorCatalogNameComponent( NSColor *col );
CFStringRef ColorLocalizedCatalogNameComponent( NSColor *col );
CFStringRef ColorNameComponent( NSColor *col );
CFStringRef ColorLocalizedNameComponent( NSColor *col );

// working with colorspace
CFStringRef ColorColorSpaceName( NSColor *col );

void ColorSet( NSColor *col );
void ColorSetFill( NSColor *col );
void ColorSetStroke( NSColor *col );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
NSColor *ColorWithName( CFStringRef name, CUI_ColorWithNameDynamicProviderType dynamicProvider, void *userData );
#endif// 101500

// convenience
// set
void ColorSetBlack( void );
void ColorSetBlue( void );
void ColorSetBrown( void );
void ColorSetClear( void );
void ColorSetCyan( void );
void ColorSetDarkGray( void );
void ColorSetGray( void );
void ColorSetGreen( void );
void ColorSetLightGray( void );
void ColorSetMagenta( void );
void ColorSetOrange( void );
void ColorSetPurple( void );
void ColorSetRed( void );
void ColorSetWhite( void );
void ColorSetYellow( void );
void ColorSetWithCalibratedHSB( CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha );
void ColorSetWithDeviceHSB( CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha );
void ColorSetWithHSB( CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha );
void ColorSetWithSRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha );

void ColorSetWithDisplayP3( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha );

void ColorSetWithRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha );

void ColorSetWithCalibratedRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha );
void ColorSetWithDeviceRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha );
void ColorSetWithWhite( CGFloat white, CGFloat alpha );
void ColorSetWithCalibratedWhite( CGFloat white, CGFloat alpha );
void ColorSetWithDeviceWhite( CGFloat white, CGFloat alpha );
void ColorSetWithGenericGamma22White( CGFloat white, CGFloat alpha );
void ColorSetWithDeviceCMYK( CGFloat cyan, CGFloat magenta, CGFloat yellow, CGFloat black, CGFloat alpha );


// setFill
void ColorSetFillBlack( void );
void ColorSetFillBlue( void );
void ColorSetFillBrown( void );
void ColorSetFillClear( void );
void ColorSetFillCyan( void );
void ColorSetFillDarkGray( void );
void ColorSetFillGray( void );
void ColorSetFillGreen( void );
void ColorSetFillLightGray( void );
void ColorSetFillMagenta( void );
void ColorSetFillOrange( void );
void ColorSetFillPurple( void );
void ColorSetFillRed( void );
void ColorSetFillWhite( void );
void ColorSetFillYellow( void );

void ColorSetFillWithCalibratedHSB( CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha );
void ColorSetFillWithDeviceHSB( CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha );
void ColorSetFillWithHSB( CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha );
void ColorSetFillWithSRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha );

void ColorSetFillWithDisplayP3( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha );

void ColorSetFillWithRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha );
void ColorSetFillWithCalibratedRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha );
void ColorSetFillWithDeviceRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha );
void ColorSetFillWithWhite( CGFloat white, CGFloat alpha );
void ColorSetFillWithCalibratedWhite( CGFloat white, CGFloat alpha );
void ColorSetFillWithDeviceWhite( CGFloat white, CGFloat alpha );
void ColorSetFillWithGenericGamma22White( CGFloat white, CGFloat alpha );
void ColorSetFillWithDeviceCMYK( CGFloat cyan, CGFloat magenta, CGFloat yellow, CGFloat black, CGFloat alpha );


// setStroke
void ColorSetStrokeBlack( void );
void ColorSetStrokeBlue( void );
void ColorSetStrokeBrown( void );
void ColorSetStrokeClear( void );
void ColorSetStrokeCyan( void );
void ColorSetStrokeDarkGray( void );
void ColorSetStrokeGray( void );
void ColorSetStrokeGreen( void );
void ColorSetStrokeLightGray( void );
void ColorSetStrokeMagenta( void );
void ColorSetStrokeOrange( void );
void ColorSetStrokePurple( void );
void ColorSetStrokeRed( void );
void ColorSetStrokeWhite( void );
void ColorSetStrokeYellow( void );

void ColorSetStrokeWithCalibratedHSB( CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha );
void ColorSetStrokeWithDeviceHSB( CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha );
void ColorSetStrokeWithHSB( CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha );
void ColorSetStrokeWithSRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha );

void ColorSetStrokeWithDisplayP3( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha );

void ColorSetStrokeWithRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha );
void ColorSetStrokeWithCalibratedRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha );
void ColorSetStrokeWithDeviceRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha );
void ColorSetStrokeWithWhite( CGFloat white, CGFloat alpha );
void ColorSetStrokeWithCalibratedWhite( CGFloat white, CGFloat alpha );
void ColorSetStrokeWithDeviceWhite( CGFloat white, CGFloat alpha );
void ColorSetStrokeWithGenericGamma22White( CGFloat white, CGFloat alpha );
void ColorSetStrokeWithDeviceCMYK( CGFloat cyan, CGFloat magenta, CGFloat yellow, CGFloat black, CGFloat alpha );

#pragma mark - color with constant
NSColor *ColorWithConstant( long col );

