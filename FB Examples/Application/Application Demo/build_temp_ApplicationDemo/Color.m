/*
 Color.m

 Bernie Wylde
 */

#import "Color.h"

// Class
Class ColorClass( void )
{ return [NSColor class]; }

// UI element
// - Label

// - Text
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
NSColor *ColorPlaceholderText( void )
{ return [NSColor placeholderTextColor]; }
#endif

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
NSColor *ColorUnemphasizedSelectedText( void )
{ return [NSColor unemphasizedSelectedTextColor]; }

NSColor *ColorUnemphasizedSelectedTextBackground( void )
{ return [NSColor unemphasizedSelectedTextBackgroundColor]; }
#endif

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
NSColor *ColorTextInsertionPoint( void )
{ return [NSColor textInsertionPointColor]; }
#endif// 140000

// - Content
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
NSColor *ColorLink( void )
{ return [NSColor linkColor]; }
#endif

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
NSColor *ColorSeparator( void )
{ return [NSColor separatorColor]; }

NSColor *ColorSelectedContentBackground( void )
{ return [NSColor selectedContentBackgroundColor]; }

NSColor *ColorUnemphasizedSelectedContentBackground( void )
{ return [NSColor unemphasizedSelectedContentBackgroundColor]; }
#endif

// Table
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
CFArrayRef ColorAlternatingContentBackgrounds( void )
{ return (__bridge CFArrayRef)[NSColor alternatingContentBackgroundColors]; }
#endif

// - Control
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
NSColor *ColorControlAccent( void )
{ return [NSColor controlAccentColor]; }
#endif

// - Highlights and shadows
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
NSColor *ColorFindHighlight( void )
{ return [NSColor findHighlightColor]; }
#endif



// Creation
// - Asset catalogs
NSColor *ColorNamed( CFStringRef name )
{ return [NSColor colorNamed:(__bridge NSString *)name]; }

NSColor *ColorNamedBundle( CFStringRef name, NSBundle *bundle )
{ return [NSColor colorNamed:(__bridge NSString *)name bundle:bundle]; }

NSColor *ColorWithCatalogName( CFStringRef catalogName, CFStringRef colorName )
{ return [NSColor colorWithCatalogName:(__bridge NSString *)catalogName colorName:(__bridge NSString *)colorName]; }


// - Arbitrary color space
NSColor *ColorWithColorSpace( NSColorSpace *cs, const CGFloat *components, NSInteger count )
{ return [NSColor colorWithColorSpace:cs components:components count:count]; }


// Appearance
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
NSColor *ColorWithSystemEffect( NSColor *col, NSColorSystemEffect effect )
{ return [col colorWithSystemEffect:effect]; }
#endif

// Transforming
NSColor *ColorUsingColorSpace( NSColor *col,  NSColorSpace *cs )
{ return [col colorUsingColorSpace:cs]; }

NSColor *ColorBlendedWithFractionOfColor( NSColor *col1, CGFloat fraction, NSColor *col2 )
{ return [col1 blendedColorWithFraction:fraction ofColor:col2]; }

NSColor *ColorHighlightWithLevel( NSColor *col, CGFloat value )
{ return [col highlightWithLevel:value]; }

NSColor *ColorShadowWithLevel( NSColor *col, CGFloat value )
{ return [col shadowWithLevel:value]; }


// Alpha support
BOOL ColorIgnoresAlpha( void )
{ return [NSColor ignoresAlpha]; }


// Copy paste color info
NSColor *ColorFromPasteboard( NSPasteboard *pb )
{ return [NSColor colorFromPasteboard:pb]; }

void ColorWriteToPastebord( NSColor *col, NSPasteboard *pb )
{ [col writeToPasteboard:pb]; }



// Color space
NSColorType ColorType( NSColor *col )
{ return [col type]; }

NSColor *ColorUsingType( NSColor *col, NSColorType type )
{ return [col colorUsingType:type]; }

NSColorSpace *ColorColorSpace( NSColor *col )
{ return [col colorSpace]; }


// Drawing
void ColorDrawSwatchInRect( NSColor *col, CGRect r )
{ [col drawSwatchInRect:NSRectFromCGRect(r)]; }


// system
NSColor *ColorAlternateSelectedControl( void )
{ return [NSColor alternateSelectedControlColor]; }

NSColor *ColorAlternateSelectedControlText( void )
{ return [NSColor alternateSelectedControlTextColor]; }

NSColor *ColorForControlTint( NSControlTint tint )
{ return [NSColor colorForControlTint:tint]; }

NSColor *ColorControlBackground( void )
{ return [NSColor controlBackgroundColor]; }

NSColor *ColorControl( void )
{ return [NSColor controlColor]; }

CFArrayRef ColorControlAlternatingRowBackground( void )
{ return (__bridge CFArrayRef)[NSColor controlAlternatingRowBackgroundColors]; }

NSColor *ColorControlHighlight( void )
{ return [NSColor controlHighlightColor]; }

NSColor *ColorControlShadow( void )
{ return [NSColor controlShadowColor]; }

NSColor *ColorControlDarkShadow( void )
{ return [NSColor controlDarkShadowColor]; }

NSColor *ColorControlText( void )
{ return [NSColor controlTextColor]; }

NSControlTint ColorCurrentControlTint( void )
{ return [NSColor currentControlTint]; }

NSColor *ColorDisabledControlText( void )
{ return [NSColor disabledControlTextColor]; }

NSColor *ColorGrid( void )
{ return [NSColor gridColor]; }

NSColor *ColorHeader( void )
{ return [NSColor headerColor]; }

NSColor *ColorHeaderText( void )
{ return [NSColor headerTextColor]; }

NSColor *ColorHighlight( void )
{ return [NSColor highlightColor]; }

NSColor *ColorKeyboardFocusIndicator( void )
{ return [NSColor keyboardFocusIndicatorColor]; }

NSColor *ColorKnob( void )
{ return [NSColor knobColor]; }

NSColor *ColorScrollBar( void )
{ return [NSColor scrollBarColor]; }

NSColor *ColorScrubberTexturedBackground( void )
{ return [NSColor scrubberTexturedBackgroundColor]; }

NSColor *ColorSecondarySelectedControl( void )
{ return [NSColor secondarySelectedControlColor]; }

NSColor *ColorSelectedControl( void )
{ return [NSColor selectedControlColor]; }

NSColor *ColorSelectedControlText( void )
{ return [NSColor selectedControlTextColor]; }

NSColor *ColorSelectedMenuItem( void )
{ return [NSColor selectedMenuItemColor]; }

NSColor *ColorSelectedMenuItemText( void )
{ return [NSColor selectedMenuItemTextColor]; }

NSColor *ColorSelectedTextBackground( void )
{ return [NSColor selectedTextBackgroundColor]; }

NSColor *ColorSelectedText( void )
{ return [NSColor selectedTextColor]; }

NSColor *ColorSelectedKnob( void )
{ return [NSColor selectedKnobColor]; }

NSColor *ColorShadow( void )
{ return [NSColor shadowColor]; }

NSColor *ColorSystemBlue( void )
{ return [NSColor systemBlueColor]; }

NSColor *ColorSystemBrown( void )
{ return [NSColor systemBrownColor]; }

NSColor *ColorSystemGray( void )
{ return [NSColor systemGrayColor]; }

NSColor *ColorSystemGreen( void )
{ return [NSColor systemGreenColor]; }

NSColor *ColorSystemOrange( void )
{ return [NSColor systemOrangeColor]; }

NSColor *ColorSystemPink( void )
{ return [NSColor systemPinkColor]; }

NSColor *ColorSystemPurple( void )
{ return [NSColor systemPurpleColor]; }

NSColor *ColorSystemRed( void )
{ return [NSColor systemRedColor]; }

NSColor *ColorSystemYellow( void )
{ return [NSColor systemYellowColor]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
NSColor *ColorSystemIndigo( void )
{ return [NSColor systemIndigoColor]; }

NSColor *ColorSystemTeal( void )
{ return [NSColor systemTealColor]; }
#endif// 101500

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
NSColor *ColorSystemMint( void )
{ return [NSColor systemMintColor]; }

NSColor *ColorSystemCyan( void )
{ return [NSColor systemCyanColor]; }
#endif// 120000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
NSColor *ColorSystemFill( void )
{ return [NSColor systemFillColor]; }

NSColor *ColorSecondarySystemFill( void )
{ return [NSColor secondarySystemFillColor]; }

NSColor *ColorTertiarySystemFill( void )
{ return [NSColor tertiarySystemFillColor]; }

NSColor *ColorQuaternarySystemFill( void )
{ return [NSColor quaternarySystemFillColor]; }

NSColor *ColorQuinarySystemFill( void )
{ return [NSColor quinarySystemFillColor]; }
#endif// 140000

NSColor *ColorTextBackground( void )
{ return [NSColor textBackgroundColor]; }

NSColor *ColorText( void )
{ return [NSColor textColor]; }

NSColor *ColorWindowBackground( void )
{ return [NSColor windowBackgroundColor]; }

NSColor *ColorWindowFrame( void )
{ return [NSColor windowFrameColor]; }

NSColor *ColorWindowFrameText( void )
{ return [NSColor windowFrameTextColor]; }

NSColor *ColorUnderPageBackground( void )
{ return [NSColor underPageBackgroundColor]; }

NSColor *ColorLabel( void )
{ return [NSColor labelColor]; }

NSColor *ColorSecondaryLabel( void )
{ return [NSColor secondaryLabelColor]; }

NSColor *ColorTertiaryLabel( void )
{ return [NSColor tertiaryLabelColor]; }

NSColor *ColorQuaternaryLabel( void )
{ return [NSColor quaternaryLabelColor]; }

NSColor *ColorBlack( void )
{ return [NSColor blackColor]; }

NSColor *ColorBlue( void )
{ return [NSColor blueColor]; }

NSColor *ColorBrown( void )
{ return [NSColor brownColor]; }

NSColor *ColorClear( void )
{ return [NSColor clearColor]; }

NSColor *ColorCyan( void )
{ return [NSColor cyanColor]; }

NSColor *ColorDarkGray( void )
{ return [NSColor darkGrayColor]; }

NSColor *ColorGray( void )
{ return [NSColor grayColor]; }

NSColor *ColorGreen( void )
{ return [NSColor greenColor]; }

NSColor *ColorLightGray( void )
{ return [NSColor lightGrayColor]; }

NSColor *ColorMagenta( void )
{ return [NSColor magentaColor]; }

NSColor *ColorOrange( void )
{ return [NSColor orangeColor]; }

NSColor *ColorPurple( void )
{ return [NSColor purpleColor]; }

NSColor *ColorRed( void )
{ return [NSColor redColor]; }

NSColor *ColorWhite( void )
{ return [NSColor whiteColor]; }

NSColor *ColorYellow( void )
{ return [NSColor yellowColor]; }

NSColor *ColorWithCalibratedHSB( CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha )
{ return [NSColor colorWithCalibratedHue:hue saturation:saturation brightness:brightness alpha:alpha]; }

NSColor *ColorWithDeviceHSB( CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha )
{ return [NSColor colorWithDeviceHue:hue saturation:saturation brightness:brightness alpha:alpha]; }

NSColor *ColorWithHSB( CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha )
{ return [NSColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha]; }

NSColor *ColorWithSRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha )
{ return [NSColor colorWithSRGBRed:red green:green blue:blue alpha:alpha]; }

NSColor *ColorWithDisplayP3( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha )
{ return [NSColor colorWithDisplayP3Red:red green:green blue:blue alpha:alpha]; }

NSColor *ColorWithRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha )
{ return [NSColor colorWithRed:red green:green blue:blue alpha:alpha]; }

NSColor *ColorWithCalibratedRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha )
{ return [NSColor colorWithCalibratedRed:red green:green blue:blue alpha:alpha]; }

NSColor *ColorWithDeviceRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha )
{ return [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha]; }

NSColor *ColorWithWhite( CGFloat white, CGFloat alpha )
{ return [NSColor colorWithWhite:white alpha:alpha]; }

NSColor *ColorWithCalibratedWhite( CGFloat white, CGFloat alpha )
{ return [NSColor colorWithCalibratedWhite:white alpha:alpha]; }

NSColor *ColorWithDeviceWhite( CGFloat white, CGFloat alpha )
{ return [NSColor colorWithDeviceWhite:white alpha:alpha]; }

NSColor *ColorWithGenericGamma22White( CGFloat white, CGFloat alpha )
{ return [NSColor colorWithGenericGamma22White:white alpha:alpha]; }

NSColor *ColorWithDeviceCMYK( CGFloat cyan, CGFloat magenta, CGFloat yellow, CGFloat black, CGFloat alpha )
{ return [NSColor colorWithDeviceCyan:cyan magenta:magenta yellow:yellow black:black alpha:alpha]; }

NSColor *ColorWithCGColor( CGColorRef col )
{ return [NSColor colorWithCGColor:col]; }

CGColorRef ColorCGColor( NSColor *col )
{ return [col CGColor]; }

NSColor *ColorWithCIColor( CIColor *col )
{ return [NSColor colorWithCIColor:col]; }

NSColor *ColorWithPatternImage( CFTypeRef inImage )
{
    NSImage *image = CUI_FixImageValue( inImage );
    if ( image ) return [NSColor colorWithPatternImage:image];
    return nil;
}

NSImage *ColorPatternImage( NSColor *col )
{ return [col patternImage]; }


NSColor *ColorWithAlphaComponent( NSColor *col, CGFloat alpha )
{ return [col colorWithAlphaComponent:alpha]; }


void ColorGetCMYK( NSColor *col, CGFloat *c, CGFloat *m, CGFloat *y, CGFloat *k, CGFloat *a )
{ [col getCyan:c magenta:m yellow:y black:k alpha:a]; }

void ColorGetHSB( NSColor *col, CGFloat *h, CGFloat *s, CGFloat *b, CGFloat *a )
{ [col getHue:h saturation:s brightness:b alpha:a]; }

void ColorGetRGB( NSColor *col, CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a )
{ [col getRed:r green:g blue:b alpha:a]; }

void ColorGetWhite( NSColor *col, CGFloat *w, CGFloat *a )
{ [col getWhite:w alpha:a]; }

NSInteger ColorNumberOfComponents( NSColor *col )
{ return [col numberOfComponents]; }

void ColorGetComponents( NSColor *col, CGFloat *components )
{ [col getComponents:components]; }


CGFloat ColorAlphaComponent( NSColor *col )
{ return [col alphaComponent]; }

CGFloat ColorWhiteComponent( NSColor *col )
{ return [col whiteComponent]; }

CGFloat ColorRedComponent( NSColor *col )
{ return [col redComponent]; }

CGFloat ColorGreenComponent( NSColor *col )
{ return [col greenComponent]; }

CGFloat ColorBlueComponent( NSColor *col )
{ return [col blueComponent]; }

CGFloat ColorCyanComponent( NSColor *col )
{ return [col cyanComponent]; }

CGFloat ColorMagentaComponent( NSColor *col )
{ return [col magentaComponent]; }

CGFloat ColorYellowComponent( NSColor *col )
{ return [col yellowComponent]; }

CGFloat ColorBlackComponent( NSColor *col )
{ return [col blackComponent]; }

CGFloat ColorHueComponent( NSColor *col )
{ return [col hueComponent]; }

CGFloat ColorSaturationComponent( NSColor *col )
{ return [col saturationComponent]; }

CGFloat ColorBrightnessComponent( NSColor *col )
{ return [col brightnessComponent]; }

CFStringRef ColorCatalogNameComponent( NSColor *col )
{ return (__bridge CFStringRef)[col catalogNameComponent]; }

CFStringRef ColorLocalizedCatalogNameComponent( NSColor *col )
{ return (__bridge CFStringRef)[col localizedCatalogNameComponent]; }

CFStringRef ColorNameComponent( NSColor *col )
{ return (__bridge CFStringRef)[col colorNameComponent]; }

CFStringRef ColorLocalizedNameComponent( NSColor *col )
{ return (__bridge CFStringRef)[col localizedColorNameComponent]; }

// working with colorspace
CFStringRef ColorColorSpaceName( NSColor *col )
{ return (__bridge CFStringRef)[col colorSpaceName]; }



void ColorSet( NSColor *col )
{ [col set]; }

void ColorSetFill( NSColor *col )
{ [col setFill]; }

void ColorSetStroke( NSColor *col )
{ [col setStroke]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
NSColor *ColorWithName( CFStringRef name, CUI_ColorWithNameDynamicProviderType dynamicProvider, void *userData )
{
    return [NSColor colorWithName:(__bridge NSString *)name dynamicProvider:^NSColor *(NSAppearance *appearance) {
            return (*dynamicProvider)(name,appearance,userData);
        }];
}
#endif// 101500

// convenience
// set
void ColorSetBlack( void )
{ [[NSColor blackColor] set]; }

void ColorSetBlue( void )
{ [[NSColor blueColor] set]; }

void ColorSetBrown( void )
{ [[NSColor brownColor] set]; }

void ColorSetClear( void )
{ [[NSColor clearColor] set]; }

void ColorSetCyan( void )
{ [[NSColor cyanColor] set]; }

void ColorSetDarkGray( void )
{ [[NSColor darkGrayColor] set]; }

void ColorSetGray( void )
{ [[NSColor grayColor] set]; }

void ColorSetGreen( void )
{ [[NSColor greenColor] set]; }

void ColorSetLightGray( void )
{ [[NSColor lightGrayColor] set]; }

void ColorSetMagenta( void )
{ [[NSColor magentaColor] set]; }

void ColorSetOrange( void )
{ [[NSColor orangeColor] set]; }

void ColorSetPurple( void )
{ [[NSColor purpleColor] set]; }

void ColorSetRed( void )
{ [[NSColor redColor] set]; }

void ColorSetWhite( void )
{ [[NSColor whiteColor] set]; }

void ColorSetYellow( void )
{ [[NSColor yellowColor] set]; }

void ColorSetWithCalibratedHSB( CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha )
{ [[NSColor colorWithCalibratedHue:hue saturation:saturation brightness:brightness alpha:alpha] set]; }

void ColorSetWithDeviceHSB( CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha )
{ [[NSColor colorWithDeviceHue:hue saturation:saturation brightness:brightness alpha:alpha] set]; }

void ColorSetWithHSB( CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha )
{ [[NSColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha] set]; }

void ColorSetWithSRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha )
{ [[NSColor colorWithSRGBRed:red green:green blue:blue alpha:alpha] set]; }

void ColorSetWithDisplayP3( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha )
{ [[NSColor colorWithDisplayP3Red:red green:green blue:blue alpha:alpha] set]; }

void ColorSetWithRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha )
{ [[NSColor colorWithRed:red green:green blue:blue alpha:alpha] set]; }

void ColorSetWithCalibratedRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha )
{ [[NSColor colorWithCalibratedRed:red green:green blue:blue alpha:alpha] set]; }

void ColorSetWithDeviceRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha )
{ [[NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha] set]; }

void ColorSetWithWhite( CGFloat white, CGFloat alpha )
{ [[NSColor colorWithWhite:white alpha:alpha] set]; }

void ColorSetWithCalibratedWhite( CGFloat white, CGFloat alpha )
{ [[NSColor colorWithCalibratedWhite:white alpha:alpha] set]; }

void ColorSetWithDeviceWhite( CGFloat white, CGFloat alpha )
{ [[NSColor colorWithDeviceWhite:white alpha:alpha] set]; }

void ColorSetWithGenericGamma22White( CGFloat white, CGFloat alpha )
{ [[NSColor colorWithGenericGamma22White:white alpha:alpha] set]; }

void ColorSetWithDeviceCMYK( CGFloat cyan, CGFloat magenta, CGFloat yellow, CGFloat black, CGFloat alpha )
{ [[NSColor colorWithDeviceCyan:cyan magenta:magenta yellow:yellow black:black alpha:alpha] set]; }


// setFill
void ColorSetFillBlack( void )
{ [[NSColor blackColor] setFill]; }

void ColorSetFillBlue( void )
{ [[NSColor blueColor] setFill]; }

void ColorSetFillBrown( void )
{ [[NSColor brownColor] setFill]; }

void ColorSetFillClear( void )
{ [[NSColor clearColor] setFill]; }

void ColorSetFillCyan( void )
{ [[NSColor cyanColor] setFill]; }

void ColorSetFillDarkGray( void )
{ [[NSColor darkGrayColor] setFill]; }

void ColorSetFillGray( void )
{ [[NSColor grayColor] setFill]; }

void ColorSetFillGreen( void )
{ [[NSColor greenColor] setFill]; }

void ColorSetFillLightGray( void )
{ [[NSColor lightGrayColor] setFill]; }

void ColorSetFillMagenta( void )
{ [[NSColor magentaColor] setFill]; }

void ColorSetFillOrange( void )
{ [[NSColor orangeColor] setFill]; }

void ColorSetFillPurple( void )
{ [[NSColor purpleColor] setFill]; }

void ColorSetFillRed( void )
{ [[NSColor redColor] setFill]; }

void ColorSetFillWhite( void )
{ [[NSColor whiteColor] setFill]; }

void ColorSetFillYellow( void )
{ [[NSColor yellowColor] setFill]; }

void ColorSetFillWithCalibratedHSB( CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha )
{ [[NSColor colorWithCalibratedHue:hue saturation:saturation brightness:brightness alpha:alpha] setFill]; }

void ColorSetFillWithDeviceHSB( CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha )
{ [[NSColor colorWithDeviceHue:hue saturation:saturation brightness:brightness alpha:alpha] setFill]; }

void ColorSetFillWithHSB( CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha )
{ [[NSColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha] setFill]; }

void ColorSetFillWithSRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha )
{ [[NSColor colorWithSRGBRed:red green:green blue:blue alpha:alpha] setFill]; }

void ColorSetFillWithDisplayP3( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha )
{ [[NSColor colorWithDisplayP3Red:red green:green blue:blue alpha:alpha] setFill]; }

void ColorSetFillWithRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha )
{ [[NSColor colorWithRed:red green:green blue:blue alpha:alpha] setFill]; }

void ColorSetFillWithCalibratedRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha )
{ [[NSColor colorWithCalibratedRed:red green:green blue:blue alpha:alpha] setFill]; }

void ColorSetFillWithDeviceRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha )
{ [[NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha] setFill]; }

void ColorSetFillWithWhite( CGFloat white, CGFloat alpha )
{ [[NSColor colorWithWhite:white alpha:alpha] setFill]; }

void ColorSetFillWithCalibratedWhite( CGFloat white, CGFloat alpha )
{ [[NSColor colorWithCalibratedWhite:white alpha:alpha] setFill]; }

void ColorSetFillWithDeviceWhite( CGFloat white, CGFloat alpha )
{ [[NSColor colorWithDeviceWhite:white alpha:alpha] setFill]; }

void ColorSetFillWithGenericGamma22White( CGFloat white, CGFloat alpha )
{ [[NSColor colorWithGenericGamma22White:white alpha:alpha] setFill]; }

void ColorSetFillWithDeviceCMYK( CGFloat cyan, CGFloat magenta, CGFloat yellow, CGFloat black, CGFloat alpha )
{ [[NSColor colorWithDeviceCyan:cyan magenta:magenta yellow:yellow black:black alpha:alpha] setFill]; }


// setStroke
void ColorSetStrokeBlack( void )
{ [[NSColor blackColor] setStroke]; }

void ColorSetStrokeBlue( void )
{ [[NSColor blueColor] setStroke]; }

void ColorSetStrokeBrown( void )
{ [[NSColor brownColor] setStroke]; }

void ColorSetStrokeClear( void )
{ [[NSColor clearColor] setStroke]; }

void ColorSetStrokeCyan( void )
{ [[NSColor cyanColor] setStroke]; }

void ColorSetStrokeDarkGray( void )
{ [[NSColor darkGrayColor] setStroke]; }

void ColorSetStrokeGray( void )
{ [[NSColor grayColor] setStroke]; }

void ColorSetStrokeGreen( void )
{ [[NSColor greenColor] setStroke]; }

void ColorSetStrokeLightGray( void )
{ [[NSColor lightGrayColor] setStroke]; }

void ColorSetStrokeMagenta( void )
{ [[NSColor magentaColor] setStroke]; }

void ColorSetStrokeOrange( void )
{ [[NSColor orangeColor] setStroke]; }

void ColorSetStrokePurple( void )
{ [[NSColor purpleColor] setStroke]; }

void ColorSetStrokeRed( void )
{ [[NSColor redColor] setStroke]; }

void ColorSetStrokeWhite( void )
{ [[NSColor whiteColor] setStroke]; }

void ColorSetStrokeYellow( void )
{ [[NSColor yellowColor] setStroke]; }

void ColorSetStrokeWithCalibratedHSB( CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha )
{ [[NSColor colorWithCalibratedHue:hue saturation:saturation brightness:brightness alpha:alpha] setStroke]; }

void ColorSetStrokeWithDeviceHSB( CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha )
{ [[NSColor colorWithDeviceHue:hue saturation:saturation brightness:brightness alpha:alpha] setStroke]; }

void ColorSetStrokeWithHSB( CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha )
{ [[NSColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha] setStroke]; }

void ColorSetStrokeWithSRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha )
{ [[NSColor colorWithSRGBRed:red green:green blue:blue alpha:alpha] setStroke]; }

void ColorSetStrokeWithDisplayP3( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha )
{ [[NSColor colorWithDisplayP3Red:red green:green blue:blue alpha:alpha] setStroke]; }

void ColorSetStrokeWithRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha )
{ [[NSColor colorWithRed:red green:green blue:blue alpha:alpha] setStroke]; }

void ColorSetStrokeWithCalibratedRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha )
{ [[NSColor colorWithCalibratedRed:red green:green blue:blue alpha:alpha] setStroke]; }

void ColorSetStrokeWithDeviceRGB( CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha )
{ [[NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha] setStroke]; }

void ColorSetStrokeWithWhite( CGFloat white, CGFloat alpha )
{ [[NSColor colorWithWhite:white alpha:alpha] setStroke]; }

void ColorSetStrokeWithCalibratedWhite( CGFloat white, CGFloat alpha )
{ [[NSColor colorWithCalibratedWhite:white alpha:alpha] setStroke]; }

void ColorSetStrokeWithDeviceWhite( CGFloat white, CGFloat alpha )
{ [[NSColor colorWithDeviceWhite:white alpha:alpha] setStroke]; }

void ColorSetStrokeWithGenericGamma22White( CGFloat white, CGFloat alpha )
{ [[NSColor colorWithGenericGamma22White:white alpha:alpha] setStroke]; }

void ColorSetStrokeWithDeviceCMYK( CGFloat cyan, CGFloat magenta, CGFloat yellow, CGFloat black, CGFloat alpha )
{ [[NSColor colorWithDeviceCyan:cyan magenta:magenta yellow:yellow black:black alpha:alpha] setStroke]; }

#pragma mark - color with constant
NSColor *ColorWithConstant( long col )
{ return CUI_FixColor( col ); }

