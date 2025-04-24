/*
 DistributedNotificationCenter.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef void (*CUI_DistributedNotificationCenterCallbackType)(NSNotification *);

@interface CUI_DistributedNotificationCenter : NSObject
@property (nonatomic,assign) CUI_DistributedNotificationCenterCallbackType callback;
@property (nonatomic,retain) NSString *name;

- (id)initWithCallback:(CUI_DistributedNotificationCenterCallbackType)cb name:(NSString *)nm;
@end

NSMutableArray *CUI_DistributedNotificationCenters( void );

// Class
Class DistributedNotificationCenterClass( void );

// - default center -
NSDistributedNotificationCenter *DistributedNotificationCenterDefaultCenter( void );
NSDistributedNotificationCenter *DistributedNotificationCenterForType( CFStringRef type );

// - observers -
void DistributedNotificationCenterAddObserver( CUI_DistributedNotificationCenterCallbackType callback, CFStringRef name, CFTypeRef object );
void DistributedNotificationCenterAddObserverWithSuspensionBehavior( CUI_DistributedNotificationCenterCallbackType callback, CFStringRef name, CFTypeRef object, NSNotificationSuspensionBehavior behavior );
void DistributedNotificationCenterRemoveObserver( CUI_DistributedNotificationCenterCallbackType callback, CFStringRef name );

// - notifications -
void DistributedNotificationCenterPostNotificationName( CFStringRef name, CFTypeRef object, CFDictionaryRef userInfo, NSUInteger options );

// - suspend -
BOOL DistributedNotificationCenterSuspended( NSDistributedNotificationCenter *ref );
void DistributedNotificationCenterSetSuspended( NSDistributedNotificationCenter *ref, BOOL flag );

