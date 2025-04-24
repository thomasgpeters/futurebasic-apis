/*
 Notification.m

 Bernie Wylde
 */

#import "Notification.h"

// Class
Class NotificationClass( void )
{ return [NSNotification class]; }

// - create -
NSNotification *NotificationWithName( CFStringRef name, CFTypeRef object, CFDictionaryRef userInfo )
{ return [NSNotification notificationWithName:(__bridge NSString *)name object:(__bridge id)object userInfo:(__bridge NSDictionary *)userInfo]; }

// - info -
CFStringRef NotificationName( NSNotification *ref )
{ return (__bridge CFStringRef)[ref name]; }

CFTypeRef NotificationObject( NSNotification *ref )
{ return (__bridge CFTypeRef)[ref object]; }

CFDictionaryRef NotificationUserInfo( NSNotification *ref )
{ return (__bridge CFDictionaryRef)[ref userInfo]; }



/*
 NotificationCenter.m
 */
static NSMutableArray *sCUI_NotificationCenters;

@implementation CUI_NotificationCenter : NSObject

- (id)initWithCallback:(CUI_NotificationCenterCallbackType)cb name:(NSString *)nm {
    if ( (self = [super init]) ) {
        self.callback = cb;
        self.name = nm;
    }
    return self;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.name release];
    [super dealloc];
}
#endif

- (void)didReceiveNotification:(NSNotification *)notification {
    if ( self.callback ) (*self.callback)(notification);
}
@end

// -- private --
NSMutableArray *CUI_NotificationCenters( void )
{
    if ( !sCUI_NotificationCenters ) sCUI_NotificationCenters = [[NSMutableArray alloc] initWithCapacity:0];
    return sCUI_NotificationCenters;
}

// -- public --

// - default center -
NSNotificationCenter *NotificationCenterDefault( void )
{ return [NSNotificationCenter defaultCenter]; }

// - adding and removing observers -
void NotificationCenterAddObserver( CUI_NotificationCenterCallbackType callback, CFStringRef name, CFTypeRef object )
{
    NSMutableArray *centers = CUI_NotificationCenters();
    CUI_NotificationCenter *center = [[CUI_NotificationCenter alloc] initWithCallback:callback name:(__bridge NSString *)name];
    [centers addObject:center];
    [[NSNotificationCenter defaultCenter] addObserver:center selector:@selector(didReceiveNotification:) name:(__bridge NSString *)name object:(__bridge id)object];
}

void NotificationCenterRemoveObserver( CUI_NotificationCenterCallbackType callback, CFStringRef name )
{
    NSMutableArray *centers = CUI_NotificationCenters();
    for ( CUI_NotificationCenter *center in centers ) {
        if ( (center.callback == callback) && ([[center name] isEqualToString:(__bridge NSString *)name]) ) {
            [[NSNotificationCenter defaultCenter] removeObserver:center name:(__bridge NSString *)name object:nil];
            [centers removeObject:center];
            break;
        }
    }
}

// - post notification -
void NotificationCenterPostNotification( NSNotification *note )
{ [[NSNotificationCenter defaultCenter] postNotification:note]; }

void NotificationCenterPostNotificationName( CFStringRef name, CFTypeRef object, CFDictionaryRef userInfo )
{ [[NSNotificationCenter defaultCenter] postNotificationName:(__bridge NSString *)name object:(__bridge id)object userInfo:(__bridge NSDictionary *)userInfo]; }


