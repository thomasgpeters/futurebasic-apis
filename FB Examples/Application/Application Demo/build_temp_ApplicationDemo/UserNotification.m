/*
 UserNotification.m

 Bernie Wylde
 */

#import "UserNotification.h"

// Class
Class UserNotificationClass( void )
{ return [NSUserNotification class]; }

// - init -
NSUserNotification *UserNotificationInit( void )
{
#if __has_feature(objc_arc)
    return [[NSUserNotification alloc] init];
#else
    return [[[NSUserNotification alloc] init] autorelease];
#endif
}

// - dislay info -
CFStringRef UserNotificationTitle( NSUserNotification *ref )
{ return (__bridge CFStringRef)[ref title]; }

void UserNotificationSetTitle( NSUserNotification *ref, CFStringRef title )
{ [ref setTitle:(__bridge NSString *)title]; }

CFStringRef UserNotificationSubtitle( NSUserNotification *ref )
{ return (__bridge CFStringRef)[ref subtitle]; }

void UserNotificationSetSubtitle( NSUserNotification *ref, CFStringRef subtitle )
{ [ref setSubtitle:(__bridge NSString *)subtitle]; }

CFStringRef UserNotificationInformativeText( NSUserNotification *ref )
{ return (__bridge CFStringRef)[ref informativeText]; }

void UserNotificationSetInformativeText( NSUserNotification *ref, CFStringRef infoText )
{ [ref setInformativeText:(__bridge NSString *)infoText]; }

NSImage *UserNotificationContentImage( NSUserNotification *ref )
{ return [ref contentImage]; }

void UserNotificationSetContentImage( NSUserNotification *ref, NSImage *image )
{ [ref setContentImage:image]; }

CFStringRef UserNotificationIdentifier( NSUserNotification *ref )
{ return (__bridge CFStringRef)[ref identifier]; }

void UserNotificationSetIdentifier( NSUserNotification *ref, CFStringRef identifier )
{ [ref setIdentifier:(__bridge NSString *)identifier]; }

CFAttributedStringRef UserNotificationResponse( NSUserNotification *ref )
{ return (__bridge CFAttributedStringRef)[ref response]; }

CFStringRef UserNotificationResponsePlaceholder( NSUserNotification *ref )
{ return (__bridge CFStringRef)[ref responsePlaceholder]; }

// - displayed buttons -
BOOL UserNotificationHasActionButton( NSUserNotification *ref )
{ return [ref hasActionButton]; }

void UserNotificationSetHasActionButton( NSUserNotification *ref, BOOL flag )
{ [ref setHasActionButton:flag]; }

CFStringRef UserNotificationActionButtonTitle( NSUserNotification *ref )
{ return (__bridge CFStringRef)[ref actionButtonTitle]; }

void UserNotificationSetActionButtonTitle( NSUserNotification *ref, CFStringRef title )
{ [ref setActionButtonTitle:(__bridge NSString *)title]; }

CFStringRef UserNotificationOtherButtonTitle( NSUserNotification *ref )
{ return (__bridge CFStringRef)[ref otherButtonTitle]; }

void UserNotificationSetOtherButtonTitle( NSUserNotification *ref, CFStringRef title )
{ [ref setOtherButtonTitle:(__bridge NSString *)title]; }

BOOL UserNotificationHasReplyButton( NSUserNotification *ref )
{ return [ref hasReplyButton]; }

void UserNotificationSetHasReplyButton( NSUserNotification *ref, BOOL flag )
{ [ref setHasReplyButton:flag]; }

// - delivery timing -
CFDateRef UserNotificationDeliveryDate( NSUserNotification *ref )
{ return (__bridge CFDateRef)[ref deliveryDate]; }

void UserNotificationSetDeliveryDate( NSUserNotification *ref, CFDateRef dt )
{ [ref setDeliveryDate:(__bridge NSDate *)dt]; }

CFDateRef UserNotificationActualDeliveryDate( NSUserNotification *ref )
{ return (__bridge CFDateRef)[ref actualDeliveryDate]; }

NSDateComponents *UserNotificationDeliveryRepeatInterval( NSUserNotification *ref )
{ return [ref deliveryRepeatInterval]; }

void UserNotificationSetDeliveryRepeatInterval( NSUserNotification *ref, NSDateComponents *components )
{ [ref setDeliveryRepeatInterval:components]; }

CFTimeZoneRef UserNotificationDeliveryTimeZone( NSUserNotification *ref )
{ return (__bridge CFTimeZoneRef)[ref deliveryTimeZone]; }

void UserNotificationSetDeliveryTimeZone( NSUserNotification *ref, CFTimeZoneRef zone )
{ [ref setDeliveryTimeZone:(__bridge NSTimeZone *)zone]; }

// - delivery info -
BOOL UserNotificationIsPresented( NSUserNotification *ref )
{ return [ref isPresented]; }

BOOL UserNotificationIsRemote( NSUserNotification *ref )
{ return [ref isRemote]; }

CFStringRef UserNotificationSoundName( NSUserNotification *ref )
{ return (__bridge CFStringRef)[ref soundName]; }

void UserNotificationSetSoundName( NSUserNotification *ref, CFStringRef name )
{ [ref setSoundName:(__bridge NSString *)name]; }

// - activation method -
NSUserNotificationActivationType UserNotificationActivationType( NSUserNotification *ref )
{ return [ref activationType]; }

NSUserNotificationAction *UserNotificationAdditionalActivationAction( NSUserNotification *ref )
{ return [ref additionalActivationAction]; }

CFArrayRef UserNotificationAdditionalActions( NSUserNotification *ref )
{ return (__bridge CFArrayRef)[ref additionalActions]; }

void UserNotificationSetAdditionalActions( NSUserNotification *ref, CFArrayRef actions )
{ [ref setAdditionalActions:(__bridge NSArray *)actions]; }

// - user info -
CFDictionaryRef UserNotificationUserInfo( NSUserNotification *ref )
{ return (__bridge CFDictionaryRef)[ref userInfo]; }

void UserNotificationSetUserInfo( NSUserNotification *ref, CFDictionaryRef userInfo )
{ [ref setUserInfo:(__bridge NSDictionary *)userInfo]; }

// - convenience -
NSUserNotification *UserNotificationWithTitle( CFStringRef title, CFStringRef subtitle,  CFStringRef infoText, CFStringRef sndName )
{
#if __has_feature(objc_arc)
    NSUserNotification *note = [[NSUserNotification alloc] init];
#else
    NSUserNotification *note = [[[NSUserNotification alloc] init] autorelease];
#endif
    if ( title ) [note setTitle:(__bridge NSString *)title];
    if ( subtitle ) [note setSubtitle:(__bridge NSString *)subtitle];
    if ( infoText ) [note setInformativeText:(__bridge NSString *)infoText];
    if ( sndName ) [note setSoundName:(__bridge NSString *)sndName];
    return note;
}


#pragma mark - usernotificationaction


// - create -
NSUserNotificationAction *UserNotificationActionInit( CFStringRef identifier, CFStringRef title )
{ return [NSUserNotificationAction actionWithIdentifier:(__bridge NSString *)identifier title:(__bridge NSString *)title]; }

// - identifier and title -
CFStringRef UserNotificationActionIdentifier( NSUserNotificationAction *ref )
{ return (__bridge CFStringRef)[ref identifier]; }

CFStringRef UserNotificationActionTitle( NSUserNotificationAction *ref )
{ return (__bridge CFStringRef)[ref title]; }



#pragma mark - usernotificationcenter

// - default user notification center -
NSUserNotificationCenter *UserNotificationCenterDefault( void )
{ return [NSUserNotificationCenter defaultUserNotificationCenter]; }

// - queue -
void UserNotificationCenterScheduleNotification( NSUserNotification *ref )
{ [[NSUserNotificationCenter defaultUserNotificationCenter] scheduleNotification:ref]; }

CFArrayRef UserNotificationCenterScheduledNotifications( void )
{ return (__bridge CFArrayRef)[[NSUserNotificationCenter defaultUserNotificationCenter] scheduledNotifications]; }

void UserNotificationCenterRemoveScheduledNotification( NSUserNotification *ref )
{ [[NSUserNotificationCenter defaultUserNotificationCenter] removeScheduledNotification:ref]; }

// - deliver -
void UserNotificationCenterDeliverNotification( NSUserNotification *ref )
{ [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:ref]; }

CFArrayRef UserNotificationCenterDeliveredNotifications( void )
{ return (__bridge CFArrayRef)[[NSUserNotificationCenter defaultUserNotificationCenter] deliveredNotifications]; }

void UserNotificationCenterRemoveDeliveredNotification( NSUserNotification *ref )
{ [[NSUserNotificationCenter defaultUserNotificationCenter] removeDeliveredNotification:ref]; }

void UserNotificationCenterRemoveAllDeliveredNotifications( void )
{ [[NSUserNotificationCenter defaultUserNotificationCenter] removeAllDeliveredNotifications]; }

// - delegate -

// - convenience -
void UserNotificationCenterScheduleNotificationWithTitle( CFStringRef title, CFStringRef subtitle,  CFStringRef infoText, CFStringRef sndName )
{
#if __has_feature(objc_arc)
    NSUserNotification *note = [[NSUserNotification alloc] init];
#else
    NSUserNotification *note = [[[NSUserNotification alloc] init] autorelease];
#endif
    if ( title ) [note setTitle:(__bridge NSString *)title];
    if ( subtitle ) [note setSubtitle:(__bridge NSString *)subtitle];
    if ( infoText ) [note setInformativeText:(__bridge NSString *)infoText];
    if ( sndName ) [note setSoundName:(__bridge NSString *)sndName];
    [[NSUserNotificationCenter defaultUserNotificationCenter] scheduleNotification:note];
}

void UserNotificationCenterDeliverNotificationWithTitle( CFStringRef title, CFStringRef subtitle,  CFStringRef infoText, CFStringRef sndName )
{
#if __has_feature(objc_arc)
    NSUserNotification *note = [[NSUserNotification alloc] init];
#else
    NSUserNotification *note = [[[NSUserNotification alloc] init] autorelease];
#endif
    if ( title ) [note setTitle:(__bridge NSString *)title];
    if ( subtitle ) [note setSubtitle:(__bridge NSString *)subtitle];
    if ( infoText ) [note setInformativeText:(__bridge NSString *)infoText];
    if ( sndName ) [note setSoundName:(__bridge NSString *)sndName];
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:note];
}

