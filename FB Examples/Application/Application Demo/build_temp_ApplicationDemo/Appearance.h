/*
 Appearance.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"


typedef void (*CUI_AppearancePerformAsCurrentDrawingCallbackType)(NSAppearance*,void*);

// Class
Class AppearanceClass( void );

// Name
CFStringRef AppearanceName( NSAppearance *ref );

// Appearance
NSAppearance *AppearanceNamed( CFStringRef name );

// Most appropriate appearance
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
CFStringRef AppearanceBestMatchFromAppearancesWithNames( NSAppearance *ref, CFArrayRef names );
#endif

// Current appearance
NSAppearance *AppearanceCurrent( void );
void AppearanceSetCurrent( NSAppearance *ref );

// Vibrancy
BOOL AppearanceAllowsVibrancy( NSAppearance *ref );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
// Type properties
API_AVAILABLE(macos(11.0))
NSAppearance *AppearanceCurrentDrawing( void );

// Instance methods
API_AVAILABLE(macos(11.0))
void AppearancePerformAsCurrentDrawing( NSAppearance *ref, CUI_AppearancePerformAsCurrentDrawingCallbackType callback, void *userData );
#endif// 110000

// Convenience
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
BOOL AppearanceIsDarkMode( void );
#endif// 101400


