/*
 TintConfiguration.h

 Bernie Wylde
 */

#import "CocoaUI.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000

// Class
API_AVAILABLE(macos(11.0))
Class TintConfigurationClass( void );

// Init
API_AVAILABLE(macos(11.0))
NSTintConfiguration *TintConfigurationWithFixedColor( NSColor *col );
API_AVAILABLE(macos(11.0))
NSTintConfiguration *TintConfigurationWithPreferredColor( NSColor *col );

// App appearance
API_AVAILABLE(macos(11.0))
BOOL TintConfigurationAdaptsToUserAccentColor( NSTintConfiguration *ref );

// Tint color
API_AVAILABLE(macos(11.0))
NSTintConfiguration *TintConfigurationDefault( void );
API_AVAILABLE(macos(11.0))
NSTintConfiguration *TintConfigurationMonochrome( void );
API_AVAILABLE(macos(11.0))
NSColor *TintConfigurationBaseTintColor( NSTintConfiguration *ref );
API_AVAILABLE(macos(11.0))
NSColor *TintConfigurationEquivalentContentTintColor( NSTintConfiguration *ref );

#endif// 110000
