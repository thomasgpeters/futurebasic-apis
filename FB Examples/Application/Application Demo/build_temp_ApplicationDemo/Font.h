/*
 Font.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class FontClass( void );

// - arbitrary font -
NSFont *FontWithName( CFStringRef name, CGFloat size );
NSFont *FontWithDescriptor( NSFontDescriptor *descriptor, CGFloat size );
NSFont *FontWithDescriptorAndTextTransform( NSFontDescriptor *descriptor, NSAffineTransform *tx );
NSFont *FontWithNameAndMatrix( CFStringRef name, CGFloat *matrix );

// - user font -
NSFont *FontUserFontOfSize( CGFloat size );
NSFont *FontUserFixedPitchFontOfSize( CGFloat size );

// - system font -
NSFont *FontBoldSystemFontOfSize( CGFloat size );
NSFont *FontControlContentFontOfSize( CGFloat size );
NSFont *FontLabelFontOfSize( CGFloat size );
NSFont *FontMenuFontOfSize( CGFloat size );
NSFont *FontMenuBarFontOfSize( CGFloat size );
NSFont *FontMessageFontOfSize( CGFloat size );
NSFont *FontMonospacedDigitSystemFontOfSize( CGFloat size, CGFloat weight );
NSFont *FontPaletteFontOfSize( CGFloat size );
NSFont *FontSystemFontOfSize( CGFloat size );
NSFont *FontSystemFontOfSizeAndWeight( CGFloat size, CGFloat weight );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130300
API_AVAILABLE(macos(13.3))
NSFont *FontSystemFontOfSizeAndWidth( CGFloat size, CGFloat weight, NSFontWidth wdth );
#endif// 130300
NSFont *FontTitleBarFontOfSize( CGFloat size );
NSFont *FontToolTipsFontOfSize( CGFloat size );

// - draw -
void FontSet( NSFont *ref );
void FontSetInContext( NSFont *ref, NSGraphicsContext *context );

// - general information -
NSFontDescriptor *FontDescriptor( NSFont *ref );

// - metrics information -
CGFloat FontLabelFontSize( void );
CGFloat FontSmallSystemFontSize( void );
CGFloat FontSystemFontSize( void );
CGFloat FontSystemFontSizeForControlSize( NSControlSize size );

CGFloat FontAscender( NSFont *ref );
CGRect FontBoundingRectForFont( NSFont *ref );
CGFloat FontCapHeight( NSFont *ref );
CGFloat FontDescender( NSFont *ref );

CGFloat FontItalicAngle( NSFont *ref );

CGFloat FontLeading( NSFont *ref );

const CGFloat *FontMatrix( NSFont *ref );

CGFloat FontSize( NSFont *ref );

CGFloat FontUnderlinePosition( NSFont *ref );
CGFloat FontUnderlineThickness( NSFont *ref );

CGFloat FontXHeight( NSFont *ref );

// - font names -
CFStringRef FontDisplayName( NSFont *ref );
CFStringRef FontFamilyName( NSFont *ref );
CFStringRef FontName( NSFont *ref );

// - set user font -
void FontSetUserFont( NSFont *ref );

// Vertical fonts
BOOL FontIsVertical( NSFont *ref );
NSFont *FontVerticalFont( NSFont *ref );

// Type methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
NSFont *FontMonospacedSystemFontOfSize( CGFloat size, NSFontWeight weight );
#endif// 101500

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
// NSFont_TextStyles
API_AVAILABLE(macos(11.0))
NSFont *FontPreferredFontForTextStyle( NSFontTextStyle textStyle, CFDictionaryRef options );
#endif// 110000


// Convenience
NSFont *FontMiniSystemFont( void );
NSFont *FontSmallSystemFont( void );
NSFont *FontRegularSystemFont( void );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
NSFont *FontLargeSystemFont( void );
#endif// 110000
