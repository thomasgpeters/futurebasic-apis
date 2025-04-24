/*
 UserActivity.m

 Bernie Wylde
 */

#import "UserActivity.h"


@implementation CUI_UserActivityDelegate

#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.inputStream release];
    [self.outputStream release];
    [super dealloc];
}
#endif

- (void)userActivity:(NSUserActivity *)userActivity didReceiveInputStream:(NSInputStream *)ipStream outputStream:(NSOutputStream *)opStream {
    self.inputStream = ipStream;
    self.outputStream = opStream;
    (*self.callback)( userActivity, userActivityDidReceiveInputOutputStream, self.userData );
}

- (void)userActivityWasContinued:(NSUserActivity *)userActivity {
    (*self.callback)( userActivity, userActivityWasContinued, self.userData );
}

- (void)userActivityWillSave:(NSUserActivity *)userActivity {
    (*self.callback)( userActivity, userActivityWillSave, self.userData );
}
@end

NSInputStream *UserActivityDelegateInputStream( NSUserActivity *ref )
{ return [(CUI_UserActivityDelegate *)[ref delegate] inputStream]; }

NSOutputStream *UserActivityDelegateOutputStream( NSUserActivity *ref )
{ return [(CUI_UserActivityDelegate *)[ref delegate] outputStream]; }

// Class
Class UserActivityClass( void )
{ return [NSUserActivity class]; }

// Create
NSUserActivity *UserActivityWithType( CFStringRef type )
{
#if __has_feature(objc_arc)
    return [[NSUserActivity alloc] initWithActivityType:(__bridge NSString *)type];
#else
    return [[[NSUserActivity alloc] initWithActivityType:(__bridge NSString *)type] autorelease];
#endif
}

// Info
CFStringRef UserActivityType( NSUserActivity *ref )
{ return (__bridge CFStringRef)[ref activityType]; }

CFStringRef UserActivityTitle( NSUserActivity *ref )
{ return (__bridge CFStringRef)[ref title]; }

void UserActivitySetTitle( NSUserActivity *ref, CFStringRef title )
{ [ref setTitle:(__bridge NSString *)title]; }

CFSetRef UserActivityRequiredUserInfoKeys( NSUserActivity *ref )
{ return (__bridge CFSetRef)[ref requiredUserInfoKeys]; }

void UserActivitySetRequiredUserInfoKeys( NSUserActivity *ref, CFSetRef keys )
{ [ref setRequiredUserInfoKeys:(__bridge NSSet *)keys]; }

CFDictionaryRef UserActivityUserInfo( NSUserActivity *ref )
{ return (__bridge CFDictionaryRef)[ref userInfo]; }

void UserActivitySetUserInfo( NSUserActivity *ref, CFDictionaryRef info )
{ [ref setUserInfo:(__bridge NSDictionary *)info]; }

void UserActivityAddUserInfoEntriesFromDictionary( NSUserActivity *ref, CFDictionaryRef otherDictionary )
{ [ref addUserInfoEntriesFromDictionary:(__bridge NSDictionary *)otherDictionary]; }

BOOL UserActivityNeedsSave( NSUserActivity *ref )
{ return [ref needsSave]; }

void UserActivitySetNeedsSave( NSUserActivity *ref, BOOL flag )
{ [ref setNeedsSave:flag]; }

//CSSearchableItemAttributeSetRef UserActivityContentAttributeSet( NSUserActivity *ref );
//void UserActivitySetContentAttributeSet( NSUserActivity *ref, CSSearchableItemAttributeSetRef attrSet );

CFSetRef UserActivityKeywords( NSUserActivity *ref )
{ return (__bridge CFSetRef)[ref keywords]; }

void UserActivitySetKeywords( NSUserActivity *ref, CFSetRef keywords )
{ [ref setKeywords:(__bridge NSSet *)keywords]; }

// Eligibility
BOOL UserActivityIsEligibleForHandoff( NSUserActivity *ref )
{ return [ref isEligibleForHandoff]; }

void UserActivitySetEligibleForHandoff( NSUserActivity *ref, BOOL flag )
{ [ref setEligibleForHandoff:flag]; }

BOOL UserActivityIsEligibleForSearch( NSUserActivity *ref )
{ return [ref isEligibleForSearch]; }

void UserActivitySetEligibleForSearch( NSUserActivity *ref, BOOL flag )
{ [ref setEligibleForSearch:flag]; }

BOOL UserActivityIsEligibleForPublicIndexing( NSUserActivity *ref )
{ return [ref isEligibleForPublicIndexing]; }

void UserActivitySetEligibleForPublicIndexing( NSUserActivity *ref, BOOL flag )
{ [ref setEligibleForPublicIndexing:flag]; }

CFDateRef UserActivityExpirationDate( NSUserActivity *ref )
{ return (__bridge CFDateRef)[ref expirationDate]; }

void UserActivitySetExpirationDate( NSUserActivity *ref, CFDateRef dt )
{ [ref setExpirationDate:(__bridge NSDate *)dt]; }

// Registering and invalidating
void UserActivityBecomeCurrent( NSUserActivity *ref )
{ [ref becomeCurrent]; }

void UserActivityResignCurrent( NSUserActivity *ref )
{ [ref resignCurrent]; }

void UserActivityInvalidate( NSUserActivity *ref )
{ [ref invalidate]; }

// Delegate
void UserActivitySetDelegateCallback( NSUserActivity *ref, CUI_UserActivityDelegateCallbackType callback, void *userData )
{
    CUI_UserActivityDelegate *delegate = [[CUI_UserActivityDelegate alloc] init];
    [delegate setCallback:callback];
    [delegate setUserData:userData];
    [ref setDelegate:delegate];
}

// Web browsing
CFURLRef UserActivityWebpageURL( NSUserActivity *ref )
{ return (__bridge CFURLRef)[ref webpageURL]; }

void UserActivitySetWebpageURL( NSUserActivity *ref, CFURLRef url )
{ [ref setWebpageURL:(__bridge NSURL *)url]; }

// Streams
BOOL UserActivitySupportsContinuationStreams( NSUserActivity *ref )
{ return [ref supportsContinuationStreams]; }

void UserActivitySetSupportsContinuationStreams( NSUserActivity *ref, BOOL flag )
{ [ref setSupportsContinuationStreams:flag]; }

void UserActivityGetContinuationStreamsWithCompletionHandler( NSUserActivity *ref, CUI_UserActivityContinuationStreamsCompletionHandlerType handler, void *userData )
{
    [ref getContinuationStreamsWithCompletionHandler:^(NSInputStream *inputStream, NSOutputStream *outputStream, NSError *error) {
        (*handler)(ref,inputStream,outputStream,error,userData);
    }];
}

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101304
CIBarcodeDescriptor *UserActivityDetectedBarcodeDescriptor( NSUserActivity *ref )
{ return [ref detectedBarcodeDescriptor]; }
#endif// 101304

CFURLRef UserActivityReferrerURL( NSUserActivity *ref )
{ return (__bridge CFURLRef)[ref referrerURL]; }

void UserActivitySetReferrerURL( NSUserActivity *ref, CFURLRef url )
{ [ref setReferrerURL:(__bridge NSURL *)url]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
CFStringRef UserActivityTargetContentIdentifier( NSUserActivity *ref )
{ return (__bridge CFStringRef)[ref targetContentIdentifier]; }

void UserActivitySetTargetContentIdentifier( NSUserActivity *ref, CFStringRef identifier )
{ [ref setTargetContentIdentifier:(__bridge NSString *)identifier]; }
#endif// 101500


#pragma mark - UserActivityRestoring
// Restore app state
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
void UserActivityRestoringRestoreUserActivityState( id<NSUserActivityRestoring> ref, NSUserActivity *userActivity )
{ [ref restoreUserActivityState:userActivity]; }
#endif// 101400

