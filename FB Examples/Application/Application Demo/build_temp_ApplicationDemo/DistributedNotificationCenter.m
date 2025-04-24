/*
 DistributedNotificationCenter.m

 Bernie Wylde
 */

#import "DistributedNotificationCenter.h"

static NSMutableArray *sCUI_DistributedNotificationCenters;

@implementation CUI_DistributedNotificationCenter : NSObject

- (id)initWithCallback:(CUI_DistributedNotificationCenterCallbackType)cb name:(NSString *)nm {
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
NSMutableArray *CUI_DistributedNotificationCenters( void )
{
    if ( !sCUI_DistributedNotificationCenters ) sCUI_DistributedNotificationCenters = [[NSMutableArray alloc] initWithCapacity:0];
    return sCUI_DistributedNotificationCenters;
}

// -- public --

// Class
Class DistributedNotificationCenterClass( void )
{ return [NSDistributedNotificationCenter class]; }

// - default center -
NSDistributedNotificationCenter *DistributedNotificationCenterDefaultCenter( void )
{ return [NSDistributedNotificationCenter defaultCenter]; }

NSDistributedNotificationCenter *DistributedNotificationCenterForType( CFStringRef type )
{ return [NSDistributedNotificationCenter notificationCenterForType:(__bridge NSString *)type]; }

// - observers -
void DistributedNotificationCenterAddObserver( CUI_DistributedNotificationCenterCallbackType callback, CFStringRef name, CFTypeRef object )
{
    NSMutableArray *centers = CUI_DistributedNotificationCenters();
    CUI_DistributedNotificationCenter *center = [[CUI_DistributedNotificationCenter alloc] initWithCallback:callback name:(__bridge NSString *)name];
    [centers addObject:center];
    [[NSDistributedNotificationCenter defaultCenter] addObserver:center selector:@selector(didReceiveNotification:) name:(__bridge NSString *)name object:(__bridge id)object];
}

void DistributedNotificationCenterAddObserverWithSuspensionBehavior( CUI_DistributedNotificationCenterCallbackType callback, CFStringRef name, CFTypeRef object, NSNotificationSuspensionBehavior behavior )
{
    NSMutableArray *centers = CUI_DistributedNotificationCenters();
    CUI_DistributedNotificationCenter *center = [[CUI_DistributedNotificationCenter alloc] initWithCallback:callback name:(__bridge NSString *)name];
    [centers addObject:center];
    [[NSDistributedNotificationCenter defaultCenter] addObserver:center selector:@selector(didReceiveNotification:) name:(__bridge NSString *)name object:(__bridge id)object suspensionBehavior:behavior];
}

void DistributedNotificationCenterRemoveObserver( CUI_DistributedNotificationCenterCallbackType callback, CFStringRef name )
{
    NSMutableArray *centers = CUI_DistributedNotificationCenters();
    for ( CUI_DistributedNotificationCenter *center in centers ) {
        if ( (center.callback == callback) && ([[center name] isEqualToString:(__bridge NSString *)name]) ) {
            [[NSDistributedNotificationCenter defaultCenter] removeObserver:center name:(__bridge NSString *)name object:nil];
            [centers removeObject:center];
            break;
        }
    }
}

// - notifications -
void DistributedNotificationCenterPostNotificationName( CFStringRef name, CFTypeRef object, CFDictionaryRef userInfo, NSUInteger options )
{ [[NSDistributedNotificationCenter defaultCenter] postNotificationName:(__bridge NSString *)name object:(__bridge id)object userInfo:(__bridge NSDictionary *)userInfo options:options]; }

// - suspend -
BOOL DistributedNotificationCenterSuspended( NSDistributedNotificationCenter *ref )
{ return [ref suspended]; }

void DistributedNotificationCenterSetSuspended( NSDistributedNotificationCenter *ref, BOOL flag )
{ [ref setSuspended:flag]; }


