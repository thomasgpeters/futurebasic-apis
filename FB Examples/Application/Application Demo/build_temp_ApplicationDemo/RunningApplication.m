/*
 RunningApplication.m

 Bernie Wylde
 */

#import "RunningApplication.h"

// Class
Class RunningApplicationClass( void )
{ return [NSRunningApplication class]; }

NSRunningApplication *RunningApplicationWithProcessIdentifier( pid_t pid )
{ return [NSRunningApplication runningApplicationWithProcessIdentifier:pid]; }

CFArrayRef RunningApplicationsWithBundleIdentifier( CFStringRef identifier )
{ return (__bridge CFArrayRef)[NSRunningApplication runningApplicationsWithBundleIdentifier:(__bridge NSString *)identifier]; }

NSRunningApplication *RunningApplicationCurrentApplication( void )
{ return [NSRunningApplication currentApplication]; }

BOOL RunningApplicationIsActive( NSRunningApplication *ref )
{ return [ref isActive]; }

BOOL RunningApplicationActivate( NSRunningApplication *ref, NSApplicationActivationOptions options )
{ return [ref activateWithOptions:options]; }

NSApplicationActivationPolicy RunningApplicationActivationPolicy( NSRunningApplication *ref )
{ return [ref activationPolicy]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
BOOL RunningApplicationActivateFromApplication( NSRunningApplication *ref, NSRunningApplication *otherApp, NSApplicationActivationOptions options )
{ return [ref activateFromApplication:otherApp options:options]; }
#endif// 140000

BOOL RunningApplicationHide( NSRunningApplication *ref )
{ return [ref hide]; }

BOOL RunningApplicationUnhide( NSRunningApplication *ref )
{ return [ref unhide]; }

BOOL RunningApplicationIsHidden( NSRunningApplication *ref )
{ return [ref isHidden]; }

CFStringRef RunningApplicationLocalizedName( NSRunningApplication *ref )
{ return (__bridge CFStringRef)[ref localizedName]; }

NSImage *RunningApplicationIcon( NSRunningApplication *ref )
{ return [ref icon]; }

CFStringRef RunningApplicationBundleIdentifier( NSRunningApplication *ref )
{ return (__bridge CFStringRef)[ref bundleIdentifier]; }

CFURLRef RunningApplicationBundleURL( NSRunningApplication *ref )
{ return (__bridge CFURLRef)[ref bundleURL]; }

NSInteger RunningApplicationExecutableArchitecture( NSRunningApplication *ref )
{ return [ref executableArchitecture]; }

CFURLRef RunningApplicationExecutableURL( NSRunningApplication *ref )
{ return (__bridge CFURLRef)[ref executableURL]; }

CFDateRef RunningApplicationLaunchDate( NSRunningApplication *ref )
{ return (__bridge CFDateRef)[ref launchDate]; }

BOOL RunningApplicationIsFinishedLaunching( NSRunningApplication *ref )
{ return [ref isFinishedLaunching]; }

pid_t RunningApplicationProcessIdentifier( NSRunningApplication *ref )
{ return [ref processIdentifier]; }

BOOL RunningApplicationOwnsMenuBar( NSRunningApplication *ref )
{ return [ref ownsMenuBar]; }

BOOL RunningApplicationForceTerminate( NSRunningApplication *ref )
{ return [ref forceTerminate]; }

BOOL RunningApplicationTerminate( NSRunningApplication *ref )
{ return [ref terminate]; }

BOOL RunningApplicationIsTerminated( NSRunningApplication *ref )
{ return [ref isTerminated]; }

void RunningApplicationTerminateAutomaticallyTerminableApplications( void )
{ [NSRunningApplication terminateAutomaticallyTerminableApplications]; }

