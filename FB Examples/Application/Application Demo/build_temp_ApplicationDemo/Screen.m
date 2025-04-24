/*
 Screen.m

 Bernie Wylde
 */

#import "Screen.h"

// Class
Class ScreenClass( void )
{ return [NSScreen class]; }

NSScreen *ScreenMainScreen( void )
{ return [NSScreen mainScreen]; }

NSScreen *ScreenDeepestScreen( void )
{ return [NSScreen deepestScreen]; }

CFArrayRef ScreenScreens( void )
{ return (__bridge CFArrayRef)[NSScreen screens]; }

NSWindowDepth ScreenDepth( NSScreen *ref )
{ return [ref depth]; }

CGRect ScreenFrame( NSScreen *ref )
{ return NSRectToCGRect([ref frame]); }

// supportedWindowDepths

CFDictionaryRef ScreenDeviceDescription( NSScreen *ref )
{ return (__bridge CFDictionaryRef)[ref deviceDescription]; }

//CFArrayRef ScreenSupportedWindowDepths( ScreenRef ref )
//{
//    const NSWindowDepth *depths = [ref supportedWindowDepths];
//    size_t size = malloc_size((void *)depths);
//    
//    // ...
//    
//    return nil;
//}

CGRect ScreenVisibleFrame( NSScreen *ref )
{ return NSRectToCGRect([ref visibleFrame]); }

NSColorSpace *ScreenColorSpace( NSScreen *ref )
{ return [ref colorSpace]; }

BOOL ScreenCanRepresentDisplayGamut( NSScreen *ref, NSInteger gamut )
{ return [ref canRepresentDisplayGamut:gamut]; }

BOOL ScreenScreensHaveSeparateSpaces( void )
{ return [NSScreen screensHaveSeparateSpaces]; }

CGRect ScreenBackingAlignedRect( NSScreen *ref, CGRect rect, NSAlignmentOptions options )
{ return NSRectToCGRect([ref backingAlignedRect:NSRectFromCGRect(rect) options:options]); }

CGFloat ScreenBackingScaleFactor( NSScreen *ref )
{ return [ref backingScaleFactor]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
CFStringRef ScreenLocalizedName( NSScreen *ref )
{ return (__bridge CFStringRef)[ref localizedName]; }
#endif// 101500

CGRect ScreenConvertRectFromBacking( NSScreen *ref, CGRect rect )
{ return NSRectToCGRect([ref convertRectFromBacking:NSRectFromCGRect(rect)]); }

CGRect ScreenConvertRectToBacking( NSScreen *ref, CGRect rect )
{ return NSRectToCGRect([ref convertRectToBacking:NSRectFromCGRect(rect)]); }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
NSEdgeInsets ScreenSafeAreaInsets( NSScreen *ref )
{ return [ref safeAreaInsets]; }

CGRect ScreenAuxiliaryTopLeftArea( NSScreen *ref )
{ return NSRectToCGRect([ref auxiliaryTopLeftArea]); }

CGRect ScreenAuxiliaryTopRightArea( NSScreen *ref )
{ return NSRectToCGRect([ref auxiliaryTopRightArea]); }
#endif// 120000

CGFloat ScreenMaximumExtendedDynamicRangeColorComponentValue( NSScreen *ref )
{ return [ref maximumExtendedDynamicRangeColorComponentValue]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
CGFloat ScreenMaximumPotentialExtendedDynamicRangeColorComponentValue( NSScreen *ref )
{ return [ref maximumPotentialExtendedDynamicRangeColorComponentValue]; }

CGFloat ScreenMaximumReferenceExtendedDynamicRangeColorComponentValue( NSScreen *ref )
{ return [ref maximumReferenceExtendedDynamicRangeColorComponentValue]; }
#endif// 101500

// Variable rate refresh
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
NSInteger ScreenMaximumFramesPerSecond( NSScreen *ref )
{ return [ref maximumFramesPerSecond]; }

CFTimeInterval ScreenMinimumRefreshInterval( NSScreen *ref )
{ return [ref minimumRefreshInterval]; }

CFTimeInterval ScreenMaximumRefreshInterval( NSScreen *ref )
{ return [ref maximumRefreshInterval]; }

CFTimeInterval ScreenDisplayUpdateGranularity( NSScreen *ref )
{ return [ref displayUpdateGranularity]; }

CFTimeInterval ScreenLastDisplayUpdateTimestamp( NSScreen *ref )
{ return [ref lastDisplayUpdateTimestamp]; }
#endif// 120000

// DisplayLink
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
CADisplayLink *ScreenDisplayLinkWithTarget( NSScreen *ref, id target, CFStringRef selector )
{ return [ref displayLinkWithTarget:target selector:NSSelectorFromString((__bridge NSString *)selector)]; }
#endif// 140000

// -- convenience --
CGRect ScreenMainFrame( void )
{ return NSRectToCGRect([[NSScreen mainScreen] frame]); }

