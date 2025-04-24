/*
 Font.m

 Bernie Wylde
 */

#import "Font.h"

Class FontClass( void )
{ return [NSFont class]; }

// - arbitrary font -
NSFont *FontWithName( CFStringRef name, CGFloat size )
{ return [NSFont fontWithName:(__bridge NSString *)name size:size]; }

NSFont *FontWithDescriptor( NSFontDescriptor *descriptor, CGFloat size )
{ return [NSFont fontWithDescriptor:descriptor size:size]; }

NSFont *FontWithDescriptorAndTextTransform( NSFontDescriptor *descriptor, NSAffineTransform *tx )
{ return [NSFont fontWithDescriptor:descriptor textTransform:tx]; }

NSFont *FontWithNameAndMatrix( CFStringRef name, CGFloat *matrix )
{ return [NSFont fontWithName:(__bridge NSString *)name matrix:matrix]; }

// - user font -
NSFont *FontUserFontOfSize( CGFloat size )
{ return [NSFont userFontOfSize:size]; }

NSFont *FontUserFixedPitchFontOfSize( CGFloat size )
{ return [NSFont userFixedPitchFontOfSize:size]; }

// - system font -
NSFont *FontBoldSystemFontOfSize( CGFloat size )
{ return [NSFont boldSystemFontOfSize:size]; }

NSFont *FontControlContentFontOfSize( CGFloat size )
{ return [NSFont controlContentFontOfSize:size]; }

NSFont *FontLabelFontOfSize( CGFloat size )
{ return [NSFont labelFontOfSize:size]; }

NSFont *FontMenuFontOfSize( CGFloat size )
{ return [NSFont menuFontOfSize:size]; }

NSFont *FontMenuBarFontOfSize( CGFloat size )
{ return [NSFont menuBarFontOfSize:size]; }

NSFont *FontMessageFontOfSize( CGFloat size )
{ return [NSFont messageFontOfSize:size]; }

NSFont *FontMonospacedDigitSystemFontOfSize( CGFloat size, CGFloat weight )
{ return [NSFont monospacedDigitSystemFontOfSize:size weight:weight]; }

NSFont *FontPaletteFontOfSize( CGFloat size )
{ return [NSFont paletteFontOfSize:size]; }

NSFont *FontSystemFontOfSize( CGFloat size )
{ return [NSFont systemFontOfSize:size]; }

NSFont *FontSystemFontOfSizeAndWeight( CGFloat size, CGFloat weight )
{ return [NSFont systemFontOfSize:size weight:weight]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130300
NSFont *FontSystemFontOfSizeAndWidth( CGFloat size, CGFloat weight, NSFontWidth wdth )
{ return [NSFont systemFontOfSize:size weight:weight width:wdth]; }
#endif// 130300

NSFont *FontTitleBarFontOfSize( CGFloat size )
{ return [NSFont titleBarFontOfSize:size]; }

NSFont *FontToolTipsFontOfSize( CGFloat size )
{ return [NSFont toolTipsFontOfSize:size]; }

// - draw -
void FontSet( NSFont *ref )
{ [ref set]; }

void FontSetInContext( NSFont *ref, NSGraphicsContext *context )
{ [ref setInContext:context]; }

// - general information -
NSFontDescriptor *FontDescriptor( NSFont *ref )
{ return [ref fontDescriptor]; }

// - metrics information -
CGFloat FontLabelFontSize( void )
{ return [NSFont labelFontSize]; }

CGFloat FontSmallSystemFontSize( void )
{ return [NSFont smallSystemFontSize]; }

CGFloat FontSystemFontSize( void )
{ return [NSFont systemFontSize]; }

CGFloat FontSystemFontSizeForControlSize( NSControlSize size )
{ return [NSFont systemFontSizeForControlSize:size]; }

CGFloat FontAscender( NSFont *ref )
{ return [ref ascender]; }

CGRect FontBoundingRectForFont( NSFont *ref )
{ return NSRectToCGRect([ref boundingRectForFont]); }

CGFloat FontCapHeight( NSFont *ref )
{ return [ref capHeight]; }

CGFloat FontDescender( NSFont *ref )
{ return [ref descender]; }

CGFloat FontItalicAngle( NSFont *ref )
{ return [ref italicAngle]; }

CGFloat FontLeading( NSFont *ref )
{ return [ref leading]; }

const CGFloat *FontMatrix( NSFont *ref )
{ return [ref matrix]; }

CGFloat FontSize( NSFont *ref )
{ return [ref pointSize]; }

CGFloat FontUnderlinePosition( NSFont *ref )
{ return [ref underlinePosition]; }

CGFloat FontUnderlineThickness( NSFont *ref )
{ return [ref underlineThickness]; }

CGFloat FontXHeight( NSFont *ref )
{ return [ref xHeight]; }

// - font names -
CFStringRef FontDisplayName( NSFont *ref )
{ return (__bridge CFStringRef)[ref displayName]; }

CFStringRef FontFamilyName( NSFont *ref )
{ return (__bridge CFStringRef)[ref familyName]; }

CFStringRef FontName( NSFont *ref )
{ return (__bridge CFStringRef)[ref fontName]; }

// - set user font -
void FontSetUserFont( NSFont *ref )
{ [NSFont setUserFont:ref]; }

// Vertical fonts
BOOL FontIsVertical( NSFont *ref )
{ return [ref isVertical]; }

NSFont *FontVerticalFont( NSFont *ref )
{ return [ref verticalFont]; }

// Type methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
NSFont *FontMonospacedSystemFontOfSize( CGFloat size, NSFontWeight weight )
{ return [NSFont monospacedSystemFontOfSize:size weight:weight]; }
#endif// 101500

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
// NSFont_TextStyles
NSFont *FontPreferredFontForTextStyle( NSFontTextStyle textStyle, CFDictionaryRef options )
{ return [NSFont preferredFontForTextStyle:textStyle options:(__bridge NSDictionary *)options]; }
#endif// 110000


// Convenience
NSFont *FontMiniSystemFont( void )
{ return [NSFont systemFontOfSize:[NSFont systemFontSizeForControlSize:NSMiniControlSize]]; }

NSFont *FontSmallSystemFont( void )
{ return [NSFont systemFontOfSize:[NSFont systemFontSizeForControlSize:NSSmallControlSize]]; }

NSFont *FontRegularSystemFont( void )
{ return [NSFont systemFontOfSize:[NSFont systemFontSizeForControlSize:NSRegularControlSize]]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
NSFont *FontLargeSystemFont( void )
{ return [NSFont systemFontOfSize:[NSFont systemFontSizeForControlSize:NSControlSizeLarge]]; }
#endif// 110000
