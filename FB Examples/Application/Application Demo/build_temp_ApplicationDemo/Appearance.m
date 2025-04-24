/*
 Appearance.m
 
 Bernie Wylde
 */

#import "Appearance.h"


// Class
Class AppearanceClass( void )
{ return [NSAppearance class]; }

// Name
CFStringRef AppearanceName( NSAppearance *ref )
{ return (__bridge CFStringRef)[ref name]; }

// Appearance
NSAppearance *AppearanceNamed( CFStringRef name )
{ return [NSAppearance appearanceNamed:(__bridge NSString *)name]; }

// Most appropriate appearance
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
CFStringRef AppearanceBestMatchFromAppearancesWithNames( NSAppearance *ref, CFArrayRef names )
{ return (__bridge CFStringRef)[ref bestMatchFromAppearancesWithNames:(__bridge NSArray *)names]; }
#endif

// Current appearance
NSAppearance *AppearanceCurrent( void )
{ return [NSAppearance currentAppearance]; }

void AppearanceSetCurrent( NSAppearance *ref )
{ [NSAppearance setCurrentAppearance:ref]; }

// Vibrancy
BOOL AppearanceAllowsVibrancy( NSAppearance *ref )
{ return [ref allowsVibrancy]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
// Type properties
NSAppearance *AppearanceCurrentDrawing( void )
{ return [NSAppearance currentDrawingAppearance]; }

// Instance methods
void AppearancePerformAsCurrentDrawing( NSAppearance *ref, CUI_AppearancePerformAsCurrentDrawingCallbackType callback, void *userData )
{
    [ref performAsCurrentDrawingAppearance:^( void ) {
        (*callback)(ref,userData);
    }];
}
#endif// 110000

// Convenience
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
BOOL AppearanceIsDarkMode( void )
{
    if ( @available(macOS 10.14,*) ) {
//        NSView *view = [[[NSView alloc] init] autorelease];
//        NSAppearance *appearance = [view effectiveAppearance];
//        NSString *name = [appearance bestMatchFromAppearancesWithNames:@[NSAppearanceNameAqua,NSAppearanceNameDarkAqua]];
//        return [name isEqualToString:NSAppearanceNameDarkAqua];
        NSString *interfaceStyle = [[NSUserDefaults standardUserDefaults] stringForKey:@"AppleInterfaceStyle"];
        if ( interfaceStyle ) return [interfaceStyle isEqualToString:@"Dark"];
    }
    return NO;
}
#endif// 101400


