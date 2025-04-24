/*
 UserActivity.h

 Bernie Wylde
 */

#import "CocoaUI.h"

typedef void (*CUI_UserActivityContinuationStreamsCompletionHandlerType)(NSUserActivity*,NSInputStream*,NSOutputStream*,NSError*,void*);

// Delegate
typedef void (*CUI_UserActivityDelegateCallbackType)(NSUserActivity*,NSInteger,void*);

@interface CUI_UserActivityDelegate : NSObject <NSUserActivityDelegate>
@property (nonatomic,assign) CUI_UserActivityDelegateCallbackType callback;
@property (nonatomic,assign) void *userData;
@property (nonatomic,retain) NSInputStream *inputStream;
@property (nonatomic,retain) NSOutputStream *outputStream;
@end

enum {
    userActivityDidReceiveInputOutputStream,
    userActivityWasContinued,
    userActivityWillSave
};

NSInputStream *UserActivityDelegateInputStream( NSUserActivity *ref );
NSOutputStream *UserActivityDelegateOutputStream( NSUserActivity *ref );

// Class
Class UserActivityClass( void );

// Create
NSUserActivity *UserActivityWithType( CFStringRef type );

// Info
CFStringRef UserActivityType( NSUserActivity *ref );
CFStringRef UserActivityTitle( NSUserActivity *ref );
void UserActivitySetTitle( NSUserActivity *ref, CFStringRef title );

CFSetRef UserActivityRequiredUserInfoKeys( NSUserActivity *ref );
void UserActivitySetRequiredUserInfoKeys( NSUserActivity *ref, CFSetRef keys );

CFDictionaryRef UserActivityUserInfo( NSUserActivity *ref );
void UserActivitySetUserInfo( NSUserActivity *ref, CFDictionaryRef info );
void UserActivityAddUserInfoEntriesFromDictionary( NSUserActivity *ref, CFDictionaryRef otherDictionary );
BOOL UserActivityNeedsSave( NSUserActivity *ref );
void UserActivitySetNeedsSave( NSUserActivity *ref, BOOL flag );
//CSSearchableItemAttributeSetRef UserActivityContentAttributeSet( NSUserActivity *ref );
//void UserActivitySetContentAttributeSet( NSUserActivity *ref, CSSearchableItemAttributeSetRef attrSet );

CFSetRef UserActivityKeywords( NSUserActivity *ref );
void UserActivitySetKeywords( NSUserActivity *ref, CFSetRef keywords );

// Eligibility
BOOL UserActivityIsEligibleForHandoff( NSUserActivity *ref );
void UserActivitySetEligibleForHandoff( NSUserActivity *ref, BOOL flag );
BOOL UserActivityIsEligibleForSearch( NSUserActivity *ref );
void UserActivitySetEligibleForSearch( NSUserActivity *ref, BOOL flag );
BOOL UserActivityIsEligibleForPublicIndexing( NSUserActivity *ref );
void UserActivitySetEligibleForPublicIndexing( NSUserActivity *ref, BOOL flag );
CFDateRef UserActivityExpirationDate( NSUserActivity *ref );
void UserActivitySetExpirationDate( NSUserActivity *ref, CFDateRef dt );

// Registering and invalidating
void UserActivityBecomeCurrent( NSUserActivity *ref );
void UserActivityResignCurrent( NSUserActivity *ref );
void UserActivityInvalidate( NSUserActivity *ref );

// Delegate
void UserActivitySetDelegateCallback( NSUserActivity *ref, CUI_UserActivityDelegateCallbackType callback, void *userData );

// Web browsing
CFURLRef UserActivityWebpageURL( NSUserActivity *ref );
void UserActivitySetWebpageURL( NSUserActivity *ref, CFURLRef url );

// Streams
BOOL UserActivitySupportsContinuationStreams( NSUserActivity *ref );
void UserActivitySetSupportsContinuationStreams( NSUserActivity *ref, BOOL flag );
void UserActivityGetContinuationStreamsWithCompletionHandler( NSUserActivity *ref, CUI_UserActivityContinuationStreamsCompletionHandlerType handler, void *userData );

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101304
API_AVAILABLE(macos(10.13.4))
CIBarcodeDescriptor *UserActivityDetectedBarcodeDescriptor( NSUserActivity *ref );
#endif// 101304

CFURLRef UserActivityReferrerURL( NSUserActivity *ref );
void UserActivitySetReferrerURL( NSUserActivity *ref, CFURLRef url );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
CFStringRef UserActivityTargetContentIdentifier( NSUserActivity *ref );
API_AVAILABLE(macos(10.15))
void UserActivitySetTargetContentIdentifier( NSUserActivity *ref, CFStringRef identifier );
#endif// 101500


#pragma mark - UserActivityRestoring
// Restore app state
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
void UserActivityRestoringRestoreUserActivityState( id<NSUserActivityRestoring> ref, NSUserActivity *userActivity );
#endif// 101400

