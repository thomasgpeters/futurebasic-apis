/*
 ProcessInfo.m

 Bernie Wylde
 */

#import "ProcessInfo.h"

// Class
Class ProcessInfoClass( void )
{ return [NSProcessInfo class]; }

// - get process info agent
NSProcessInfo *ProcessInfoInit( void )
{ return [NSProcessInfo processInfo]; }

// - accessing process info -
CFArrayRef ProcessInfoArguments( void )
{ return (__bridge CFArrayRef)[[NSProcessInfo processInfo] arguments]; }

CFDictionaryRef ProcessInfoEnvironment( void )
{ return (__bridge CFDictionaryRef)[[NSProcessInfo processInfo] environment]; }

CFStringRef ProcessInfoGloballyUniqueString( void )
{ return (__bridge CFStringRef)[[NSProcessInfo processInfo] globallyUniqueString]; }

int ProcessInfoProcessIdentifier( void )
{ return [[NSProcessInfo processInfo] processIdentifier]; }

CFStringRef ProcessInfoProcessName( void )
{ return (__bridge CFStringRef)[[NSProcessInfo processInfo] processName]; }

// - user info -
CFStringRef ProcessInfoUserName( void )
{ return (__bridge CFStringRef)[[NSProcessInfo processInfo] userName]; }

CFStringRef ProcessInfoFullUserName( void )
{ return (__bridge CFStringRef)[[NSProcessInfo processInfo] fullUserName]; }

// - sudden app termination -
void ProcessInfoDisableSuddenTermination( void )
{ [[NSProcessInfo processInfo] disableSuddenTermination]; }

void ProcessInfoEnableSuddenTermination( void )
{ [[NSProcessInfo processInfo] enableSuddenTermination]; }

// - control auto termination
void ProcessInfoDisableAutomaticTermination( CFStringRef reason )
{ [[NSProcessInfo processInfo] disableAutomaticTermination:(__bridge NSString *)reason]; }

void ProcessInfoEnableAutomaticTermination( CFStringRef reason )
{ [[NSProcessInfo processInfo] enableAutomaticTermination:(__bridge NSString *)reason]; }

BOOL ProcessInfoAutomaticTerminationSupportEnabled( void )
{ return [[NSProcessInfo processInfo] automaticTerminationSupportEnabled]; }

// - host info -
CFStringRef ProcessInfoHostName( void )
{ return (__bridge CFStringRef)[[NSProcessInfo processInfo] hostName]; }

CFStringRef ProcessInfoOperatingSystemVersionString( void )
{ return (__bridge CFStringRef)[[NSProcessInfo processInfo] operatingSystemVersionString]; }

NSOperatingSystemVersion ProcessInfoOperatingSystemVersion( void )
{ return [[NSProcessInfo processInfo] operatingSystemVersion]; }

BOOL ProcessInfoIsOperatingSystemAtLeastVersion( NSOperatingSystemVersion version)
{ return [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:version]; }

// - computer info -
NSUInteger ProcessInfoProcessorCount( void )
{ return [[NSProcessInfo processInfo] processorCount]; }

NSUInteger ProcessInfoActiveProcessorCount( void )
{ return [[NSProcessInfo processInfo] activeProcessorCount]; }

unsigned long long ProcessInfoPhysicalMemory( void )
{ return [[NSProcessInfo processInfo] physicalMemory]; }

CFTimeInterval ProcessInfoSystemUptime( void )
{ return [[NSProcessInfo processInfo] systemUptime]; }

// - activities -
void *ProcessInfoBeginActivity( NSActivityOptions options, CFStringRef reason )
{ return (__bridge void *)[[NSProcessInfo processInfo] beginActivityWithOptions:options reason:(__bridge NSString *)reason]; }

void ProcessInfoEndActivity( void *obj )
{ [[NSProcessInfo processInfo] endActivity:(__bridge id)obj]; }

void ProcessInfoPerformActivity( NSActivityOptions options, CFStringRef reason, CUI_ProcessInfoPerformActivityCallbackType callback, void *userData )
{
    [[NSProcessInfo processInfo] performActivityWithOptions:options reason:(__bridge NSString *)reason usingBlock:^(void) {
        (*callback)(userData);
    }];
}

// - thermal state -
NSProcessInfoThermalState ProcessInfoThermalState( void )
{ return [[NSProcessInfo processInfo] thermalState]; }

// Power state
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
BOOL ProcessInfoIsLowPowerModeEnabled( void )
{ return [[NSProcessInfo processInfo] isLowPowerModeEnabled]; }
#endif// 120000

// Platform
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
BOOL ProcessInfoIsMacCatalystApp( void )
{ return [[NSProcessInfo processInfo] isMacCatalystApp]; }
#endif// 101500

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
BOOL ProcessInfoIsiOSAppOnMac( void )
{ return [[NSProcessInfo processInfo] isiOSAppOnMac]; }
#endif// 110000
