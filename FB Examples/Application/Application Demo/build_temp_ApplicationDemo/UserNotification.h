/*
 UserNotification.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class UserNotificationClass( void );

// - init -
NSUserNotification *UserNotificationInit( void );

// - dislay info -
CFStringRef UserNotificationTitle( NSUserNotification *ref );
void UserNotificationSetTitle( NSUserNotification *ref, CFStringRef title );
CFStringRef UserNotificationSubtitle( NSUserNotification *ref );
void UserNotificationSetSubtitle( NSUserNotification *ref, CFStringRef subtitle );
CFStringRef UserNotificationInformativeText( NSUserNotification *ref );
void UserNotificationSetInformativeText( NSUserNotification *ref, CFStringRef infoText );
NSImage *UserNotificationContentImage( NSUserNotification *ref );
void UserNotificationSetContentImage( NSUserNotification *ref, NSImage *image );
CFStringRef UserNotificationIdentifier( NSUserNotification *ref );
void UserNotificationSetIdentifier( NSUserNotification *ref, CFStringRef identifier );
CFAttributedStringRef UserNotificationResponse( NSUserNotification *ref );
CFStringRef UserNotificationResponsePlaceholder( NSUserNotification *ref );

// - displayed buttons -
BOOL UserNotificationHasActionButton( NSUserNotification *ref );
void UserNotificationSetHasActionButton( NSUserNotification *ref, BOOL flag );
CFStringRef UserNotificationActionButtonTitle( NSUserNotification *ref );
void UserNotificationSetActionButtonTitle( NSUserNotification *ref, CFStringRef title );
CFStringRef UserNotificationOtherButtonTitle( NSUserNotification *ref );
void UserNotificationSetOtherButtonTitle( NSUserNotification *ref, CFStringRef title );
BOOL UserNotificationHasReplyButton( NSUserNotification *ref );
void UserNotificationSetHasReplyButton( NSUserNotification *ref, BOOL flag );

// - delivery timing -
CFDateRef UserNotificationDeliveryDate( NSUserNotification *ref );
void UserNotificationSetDeliveryDate( NSUserNotification *ref, CFDateRef dt );
CFDateRef UserNotificationActualDeliveryDate( NSUserNotification *ref );
NSDateComponents *UserNotificationDeliveryRepeatInterval( NSUserNotification *ref );
void UserNotificationSetDeliveryRepeatInterval( NSUserNotification *ref, NSDateComponents *components );
CFTimeZoneRef UserNotificationDeliveryTimeZone( NSUserNotification *ref );
void UserNotificationSetDeliveryTimeZone( NSUserNotification *ref, CFTimeZoneRef zone );

// - delivery info -
BOOL UserNotificationIsPresented( NSUserNotification *ref );
BOOL UserNotificationIsRemote( NSUserNotification *ref );
CFStringRef UserNotificationSoundName( NSUserNotification *ref );
void UserNotificationSetSoundName( NSUserNotification *ref, CFStringRef name );

// - activation method -
NSUserNotificationActivationType UserNotificationActivationType( NSUserNotification *ref );
NSUserNotificationAction *UserNotificationAdditionalActivationAction( NSUserNotification *ref );
CFArrayRef UserNotificationAdditionalActions( NSUserNotification *ref );
void UserNotificationSetAdditionalActions( NSUserNotification *ref, CFArrayRef actions );

// - user info -
CFDictionaryRef UserNotificationUserInfo( NSUserNotification *ref );
void UserNotificationSetUserInfo( NSUserNotification *ref, CFDictionaryRef userInfo );

// - convenience -
NSUserNotification *UserNotificationWithTitle( CFStringRef title, CFStringRef subtitle,  CFStringRef infoText, CFStringRef sndName );


#pragma mark - usernotificationaction


// - create -
NSUserNotificationAction *UserNotificationActionInit( CFStringRef identifier, CFStringRef title );

// - identifier and title -
CFStringRef UserNotificationActionIdentifier( NSUserNotificationAction *ref );
CFStringRef UserNotificationActionTitle( NSUserNotificationAction *ref );


#pragma mark - usernotificationcenter

// - default user notification center -
NSUserNotificationCenter *UserNotificationCenterDefault( void );

// - queue -
void UserNotificationCenterScheduleNotification( NSUserNotification *ref );
CFArrayRef UserNotificationCenterScheduledNotifications( void );
void UserNotificationCenterRemoveScheduledNotification( NSUserNotification *ref );

// - deliver -
void UserNotificationCenterDeliverNotification( NSUserNotification *ref );
CFArrayRef UserNotificationCenterDeliveredNotifications( void );
void UserNotificationCenterRemoveDeliveredNotification( NSUserNotification *ref );
void UserNotificationCenterRemoveAllDeliveredNotifications( void );

// - delegate -

// - convenience -
void UserNotificationCenterScheduleNotificationWithTitle( CFStringRef title, CFStringRef subtitle,  CFStringRef infoText, CFStringRef sndName );
void UserNotificationCenterDeliverNotificationWithTitle( CFStringRef title, CFStringRef subtitle,  CFStringRef infoText, CFStringRef sndName );

