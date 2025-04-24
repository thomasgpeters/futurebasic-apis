/*
 Screen.h

 Bernie Wylde
 */

#import "CocoaUI.h"

// Class
Class ScreenClass( void );

NSScreen *ScreenMainScreen( void );
NSScreen *ScreenDeepestScreen( void );
CFArrayRef ScreenScreens( void );

NSWindowDepth ScreenDepth( NSScreen *ref );
CGRect ScreenFrame( NSScreen *ref );
// supportedWindowDepths
CFDictionaryRef ScreenDeviceDescription( NSScreen *ref );
//CFArrayRef ScreenSupportedWindowDepths( ScreenRef ref );
CGRect ScreenVisibleFrame( NSScreen *ref );
NSColorSpace *ScreenColorSpace( NSScreen *ref );

BOOL ScreenCanRepresentDisplayGamut( NSScreen *ref, NSInteger gamut );

BOOL ScreenScreensHaveSeparateSpaces( void );

CGRect ScreenBackingAlignedRect( NSScreen *ref, CGRect rect, NSAlignmentOptions options );
CGFloat ScreenBackingScaleFactor( NSScreen *ref );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
CFStringRef ScreenLocalizedName( NSScreen *ref );
#endif// 101500

CGRect ScreenConvertRectFromBacking( NSScreen *ref, CGRect rect );
CGRect ScreenConvertRectToBacking( NSScreen *ref, CGRect rect );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
NSEdgeInsets ScreenSafeAreaInsets( NSScreen *ref );
API_AVAILABLE(macos(12.0))
CGRect ScreenAuxiliaryTopLeftArea( NSScreen *ref );
API_AVAILABLE(macos(12.0))
CGRect ScreenAuxiliaryTopRightArea( NSScreen *ref );
#endif// 120000

CGFloat ScreenMaximumExtendedDynamicRangeColorComponentValue( NSScreen *ref );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
CGFloat ScreenMaximumPotentialExtendedDynamicRangeColorComponentValue( NSScreen *ref );
API_AVAILABLE(macos(10.15))
CGFloat ScreenMaximumReferenceExtendedDynamicRangeColorComponentValue( NSScreen *ref );
#endif// 101500

// Variable rate refresh
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
NSInteger ScreenMaximumFramesPerSecond( NSScreen *ref );
API_AVAILABLE(macos(12.0))
CFTimeInterval ScreenMinimumRefreshInterval( NSScreen *ref );
API_AVAILABLE(macos(12.0))
CFTimeInterval ScreenMaximumRefreshInterval( NSScreen *ref );
API_AVAILABLE(macos(12.0))
CFTimeInterval ScreenDisplayUpdateGranularity( NSScreen *ref );
API_AVAILABLE(macos(12.0))
CFTimeInterval ScreenLastDisplayUpdateTimestamp( NSScreen *ref );
#endif// 120000

// DisplayLink
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
CADisplayLink *ScreenDisplayLinkWithTarget( NSScreen *ref, id target, CFStringRef selector );
#endif// 140000

// -- convenience --
CGRect ScreenMainFrame( void );

