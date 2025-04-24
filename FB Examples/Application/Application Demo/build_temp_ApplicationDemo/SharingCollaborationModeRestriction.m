/*
 SharingCollaborationModeRestriction.m

 Bernie Wylde
 */

#import "SharingCollaborationModeRestriction.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000

// Instance properties
CFStringRef SharingCollaborationModeRestrictionAlertDismissButtonTitle( NSSharingCollaborationModeRestriction *ref )
{ return (__bridge CFStringRef)[ref alertDismissButtonTitle]; }

CFStringRef SharingCollaborationModeRestrictionAlertMessage( NSSharingCollaborationModeRestriction *ref )
{ return (__bridge CFStringRef)[ref alertMessage]; }

CFURLRef SharingCollaborationModeRestrictionAlertRecoverySuggestionButtonLaunchURL( NSSharingCollaborationModeRestriction *ref )
{ return (__bridge CFURLRef)[ref alertRecoverySuggestionButtonLaunchURL]; }

CFStringRef SharingCollaborationModeRestrictionAlertRecoverySuggestionButtonTitle( NSSharingCollaborationModeRestriction *ref )
{ return (__bridge CFStringRef)[ref alertRecoverySuggestionButtonTitle]; }

CFStringRef SharingCollaborationModeRestrictionAlertTitle( NSSharingCollaborationModeRestriction *ref )
{ return (__bridge CFStringRef)[ref alertTitle]; }

NSSharingCollaborationMode SharingCollaborationModeRestrictionDisabledMode( NSSharingCollaborationModeRestriction *ref )
{ return [ref disabledMode]; }

// Instance methods
NSSharingCollaborationModeRestriction *SharingCollaborationModeRestrictionWithDisabledMode( NSSharingCollaborationMode disabledMode )
{ return [[[NSSharingCollaborationModeRestriction alloc] initWithDisabledMode:disabledMode] autorelease]; }

NSSharingCollaborationModeRestriction *SharingCollaborationModeRestrictionWithAlertTitle( NSSharingCollaborationMode disabledMode, CFStringRef alertTitle, CFStringRef alertMessage )
{ return [[[NSSharingCollaborationModeRestriction alloc] initWithDisabledMode:disabledMode alertTitle:(__bridge NSString *)alertTitle alertMessage:(__bridge NSString *)alertMessage] autorelease]; }

NSSharingCollaborationModeRestriction *SharingCollaborationModeRestrictionWithAlertDismissButtonTitle( NSSharingCollaborationMode disabledMode, CFStringRef alertTitle, CFStringRef alertMessage, CFStringRef dismissBtnTitle )
{ return [[[NSSharingCollaborationModeRestriction alloc] initWithDisabledMode:disabledMode alertTitle:(__bridge NSString *)alertTitle alertMessage:(__bridge NSString *)alertMessage alertDismissButtonTitle:(__bridge NSString *)dismissBtnTitle] autorelease]; }
NSSharingCollaborationModeRestriction *SharingCollaborationModeRestrictionWithRecoverySuggestionButtonLaunchURL( NSSharingCollaborationMode disabledMode, CFStringRef alertTitle, CFStringRef alertMessage, CFStringRef dismissBtnTitle, CFStringRef recoverySuggestionBtnTitle, CFURLRef recoverySuggestionBtnLaunchURL )
{ return [[[NSSharingCollaborationModeRestriction alloc] initWithDisabledMode:disabledMode alertTitle:(__bridge NSString *)alertTitle alertMessage:(__bridge NSString *)alertMessage alertDismissButtonTitle:(__bridge NSString *)dismissBtnTitle alertRecoverySuggestionButtonTitle:(__bridge NSString *)recoverySuggestionBtnTitle alertRecoverySuggestionButtonLaunchURL:(__bridge NSURL *)recoverySuggestionBtnLaunchURL] autorelease]; }

#endif // 150000

