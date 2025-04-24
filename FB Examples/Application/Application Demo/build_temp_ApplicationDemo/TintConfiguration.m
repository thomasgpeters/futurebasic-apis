/*
 TintConfiguration.m

 Bernie Wylde
 */

#import "TintConfiguration.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000

// Class
Class TintConfigurationClass( void )
{ return [NSTintConfiguration class]; }

// Init
NSTintConfiguration *TintConfigurationWithFixedColor( NSColor *col )
{ return [NSTintConfiguration tintConfigurationWithFixedColor:col]; }

NSTintConfiguration *TintConfigurationWithPreferredColor( NSColor *col )
{ return [NSTintConfiguration tintConfigurationWithPreferredColor:col]; }

// App appearance
BOOL TintConfigurationAdaptsToUserAccentColor( NSTintConfiguration *ref )
{ return [ref adaptsToUserAccentColor]; }

// Tint color
NSTintConfiguration *TintConfigurationDefault( void )
{ return [NSTintConfiguration defaultTintConfiguration]; }

NSTintConfiguration *TintConfigurationMonochrome( void )
{ return [NSTintConfiguration monochromeTintConfiguration]; }

NSColor *TintConfigurationBaseTintColor( NSTintConfiguration *ref )
{ return [ref baseTintColor]; }

NSColor *TintConfigurationEquivalentContentTintColor( NSTintConfiguration *ref )
{ return [ref equivalentContentTintColor]; }

#endif// 110000
