/*
 ProcessInfo.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef void (*CUI_ProcessInfoPerformActivityCallbackType)(void*);

// Class
Class ProcessInfoClass( void );

// - get process info agent
NSProcessInfo *ProcessInfoInit( void );

// - accessing process info -
CFArrayRef ProcessInfoArguments( void );
CFDictionaryRef ProcessInfoEnvironment( void );
CFStringRef ProcessInfoGloballyUniqueString( void );
int ProcessInfoProcessIdentifier( void );
CFStringRef ProcessInfoProcessName( void );

// - user info -
CFStringRef ProcessInfoUserName( void );
CFStringRef ProcessInfoFullUserName( void );

// - sudden app termination -
void ProcessInfoDisableSuddenTermination( void );
void ProcessInfoEnableSuddenTermination( void );

// - control auto termination
void ProcessInfoDisableAutomaticTermination( CFStringRef reason );
void ProcessInfoEnableAutomaticTermination( CFStringRef reason );
BOOL ProcessInfoAutomaticTerminationSupportEnabled( void );

// - host info -
CFStringRef ProcessInfoHostName( void );
CFStringRef ProcessInfoOperatingSystemVersionString( void );
NSOperatingSystemVersion ProcessInfoOperatingSystemVersion( void );
BOOL ProcessInfoIsOperatingSystemAtLeastVersion( NSOperatingSystemVersion version);

// - computer info -
NSUInteger ProcessInfoProcessorCount( void );
NSUInteger ProcessInfoActiveProcessorCount( void );
unsigned long long ProcessInfoPhysicalMemory( void );
CFTimeInterval ProcessInfoSystemUptime( void );

// - activities -
void *ProcessInfoBeginActivity( NSActivityOptions options, CFStringRef reason );
void ProcessInfoEndActivity( void *obj );
void ProcessInfoPerformActivity( NSActivityOptions options, CFStringRef reason, CUI_ProcessInfoPerformActivityCallbackType callback, void *userData );

// - thermal state -
NSProcessInfoThermalState ProcessInfoThermalState( void );

// Power state
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
BOOL ProcessInfoIsLowPowerModeEnabled( void );
#endif// 120000

// Platform
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
BOOL ProcessInfoIsMacCatalystApp( void );
#endif// 101500
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
BOOL ProcessInfoIsiOSAppOnMac( void );
#endif// 110000

