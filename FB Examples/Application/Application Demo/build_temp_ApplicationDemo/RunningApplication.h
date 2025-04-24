/*
 RunningApplication.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class RunningApplicationClass( void );

NSRunningApplication *RunningApplicationWithProcessIdentifier( pid_t pid );
CFArrayRef RunningApplicationsWithBundleIdentifier( CFStringRef identifier );
NSRunningApplication *RunningApplicationCurrentApplication( void );
BOOL RunningApplicationIsActive( NSRunningApplication *ref );
BOOL RunningApplicationActivate( NSRunningApplication *ref, NSApplicationActivationOptions options );
NSApplicationActivationPolicy RunningApplicationActivationPolicy( NSRunningApplication *ref );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
BOOL RunningApplicationActivateFromApplication( NSRunningApplication *ref, NSRunningApplication *otherApp, NSApplicationActivationOptions options );
#endif// 140000

BOOL RunningApplicationHide( NSRunningApplication *ref );
BOOL RunningApplicationUnhide( NSRunningApplication *ref );
BOOL RunningApplicationIsHidden( NSRunningApplication *ref );

CFStringRef RunningApplicationLocalizedName( NSRunningApplication *ref );
NSImage *RunningApplicationIcon( NSRunningApplication *ref );
CFStringRef RunningApplicationBundleIdentifier( NSRunningApplication *ref );
CFURLRef RunningApplicationBundleURL( NSRunningApplication *ref );
NSInteger RunningApplicationExecutableArchitecture( NSRunningApplication *ref );
CFURLRef RunningApplicationExecutableURL( NSRunningApplication *ref );
CFDateRef RunningApplicationLaunchDate( NSRunningApplication *ref );
BOOL RunningApplicationIsFinishedLaunching( NSRunningApplication *ref );
pid_t RunningApplicationProcessIdentifier( NSRunningApplication *ref );
BOOL RunningApplicationOwnsMenuBar( NSRunningApplication *ref );
BOOL RunningApplicationForceTerminate( NSRunningApplication *ref );
BOOL RunningApplicationTerminate( NSRunningApplication *ref );
BOOL RunningApplicationIsTerminated( NSRunningApplication *ref );

void RunningApplicationTerminateAutomaticallyTerminableApplications( void );

