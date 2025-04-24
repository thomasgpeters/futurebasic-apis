/*
 Notification.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class NotificationClass( void );

// - create -
NSNotification *NotificationWithName( CFStringRef name, CFTypeRef object, CFDictionaryRef userInfo );

// - info -
CFStringRef NotificationName( NSNotification *ref );
CFTypeRef NotificationObject( NSNotification *ref );
CFDictionaryRef NotificationUserInfo( NSNotification *ref );



/*
 NotificationCenter.h
 */
typedef void (*CUI_NotificationCenterCallbackType)(NSNotification *);

@interface CUI_NotificationCenter : NSObject
@property (nonatomic,assign) CUI_NotificationCenterCallbackType callback;
@property (nonatomic,retain) NSString *name;

- (id)initWithCallback:(CUI_NotificationCenterCallbackType)cb name:(NSString *)nm;

@end

NSMutableArray *CUI_NotificationCenters( void );

// - default center -
NSNotificationCenter *NotificationCenterDefault( void );

// - add and remove observers -
void NotificationCenterAddObserver( CUI_NotificationCenterCallbackType callback, CFStringRef name, CFTypeRef object );
void NotificationCenterRemoveObserver( CUI_NotificationCenterCallbackType callback, CFStringRef name );

// - post notification -
void NotificationCenterPostNotification( NSNotification *note );
void NotificationCenterPostNotificationName( CFStringRef name, CFTypeRef object, CFDictionaryRef userInfo );

