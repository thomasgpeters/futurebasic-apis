/*
 URLSession.h

 Bernie Wylde
 */

#import "CocoaUI.h"

typedef void (*CUI_URLSessionDataTaskCompletionHandlerType)(NSURLSession*,CFDataRef,NSURLResponse*,NSError*,void*);
typedef void (*CUI_URLSessionDownloadTaskCompletionHandlerType)(NSURLSession*,CFURLRef,NSURLResponse*,NSError*,void*);
typedef void (*CUI_URLSessionUploadTaskCompletionHandlerType)(NSURLSession*,CFDataRef,NSURLResponse*,NSError*,void*);
typedef void (*CUI_URLSessionFlushCompletionHandlerType)(NSURLSession*,void*);
typedef void (*CUI_URLSessionGetTasksCompletionHandlerType)(NSURLSession*,CFArrayRef,CFArrayRef,CFArrayRef,void*);
typedef void (*CUI_URLSessionGetAllTasksCompletionHandlerType)(NSURLSession*,CFArrayRef,void*);
typedef void (*CUI_URLSessionResetCompletionHandlerType)(NSURLSession*,void*);
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
typedef void (*CUI_URLSessionUploadTaskDataWithCompletionHandlerType)(NSURLSession*,CFDataRef,NSURLResponse*,NSError*,void*);
#endif// 140000

// dialog events
enum {
    // NSURLSessionDelegate
    URLSessionDidBecomeInvalid = 3600,
    URLSessionDidFinishEvents,
    URLSessionDidReceiveChallenge,
    URLSessionDidFinishEventsForBackgroundURLSession,
    
    // NSURLSessionDownloadDelegate
    URLSessionDownloadTaskDidFinishDownloading,
    URLSessionDownloadTaskDidResume,
    URLSessionDownloadTaskDidWriteData,

    // NSURLSessionTaskDelegate
    URLSessionTaskDidComplete,
    URLSessionTaskWillPerformHTTPRedirection,
    URLSessionTaskDidSendBodyData,
    URLSessionTaskNeedNewBodyStream,
    URLSessionTaskDidReceiveChallenge,
    URLSessionTaskWillBeginDelayedRequest,
    URLSessionTaskIsWaitingForConnectivity,
    URLSessionTaskDidFinishCollectingMetrics,
    
    // NSURLSessionDataDelegate
    URLSessionDataTaskDidReceiveResponse,
    URLSessionDataTaskDidBecomeDownloadTask,
    URLSessionDataTaskDidBecomeStreamTask,
    URLSessionDataTaskDidReceiveData,
    URLSessionDataTaskWillCacheResponse,
    
    // NSURLSessionStreamDelegate
    URLSessionStreamTaskBetterRouteDiscovered,
    URLSessionStreamTaskDidBecomeInputStream,
    URLSessionStreamTaskReadClosed,
    URLSessionStreamTaskWriteClosed
};

@interface CUI_URLSessionDelegate : NSObject <NSURLSessionDelegate,NSURLSessionDownloadDelegate,NSURLSessionTaskDelegate,NSURLSessionDataDelegate,NSURLSessionStreamDelegate>
@end

// - Private -
CUI_URLSessionDelegate *CUI_URLSessionDelegateObj( void );

// - Public -
// Class
Class URLSessionClass( void );

// Create
NSURLSession *URLSessionWithConfiguration( NSURLSessionConfiguration *config );
NSURLSession *URLSessionWithDelegateQueue( NSURLSessionConfiguration *config, NSOperationQueue *queue );
NSURLSession *URLSessionSharedSession( void );

// Configure
NSURLSessionConfiguration *URLSessionConfiguration( NSURLSession *ref );
NSOperationQueue *URLSessionDelegateQueue( NSURLSession *ref );
CFStringRef URLSessionDescription( NSURLSession *ref );

// Add data tasks
NSURLSessionDataTask *URLSessionDataTaskWithURL( NSURLSession *ref, CFURLRef url );
NSURLSessionDataTask *URLSessionDataTaskWithURLCompletionHandler( NSURLSession *ref, CFURLRef url, CUI_URLSessionDataTaskCompletionHandlerType handlerAddress, void *userData );
NSURLSessionDataTask *URLSessionDataTaskWithRequest( NSURLSession *ref, NSURLRequest *request );
NSURLSessionDataTask *URLSessionDataTaskWithRequestCompletionHandler( NSURLSession *ref, NSURLRequest *request, CUI_URLSessionDataTaskCompletionHandlerType handlerAddress, void *userData );

// Add download tasks
NSURLSessionDownloadTask *URLSessionDownloadTaskWithURL( NSURLSession *ref, CFURLRef url );
NSURLSessionDownloadTask *URLSessionDownloadTaskWithURLCompletionHandler( NSURLSession *ref, CFURLRef url, CUI_URLSessionDownloadTaskCompletionHandlerType handlerAddress, void *userData );
NSURLSessionDownloadTask *URLSessionDownloadTaskWithRequest( NSURLSession *ref, NSURLRequest *request );
NSURLSessionDownloadTask *URLSessionDownloadTaskWithRequestCompletionHandler( NSURLSession *ref, NSURLRequest *request, CUI_URLSessionDownloadTaskCompletionHandlerType handlerAddress, void *userData );
NSURLSessionDownloadTask *URLSessionDownloadTaskWithResumeData( NSURLSession *ref, CFDataRef dta );
NSURLSessionDownloadTask *URLSessionDownloadTaskWithResumeDataCompletionHandler( NSURLSession *ref, CFDataRef dta, CUI_URLSessionDownloadTaskCompletionHandlerType handlerAddress, void *userData );

// Add upload tasks
NSURLSessionUploadTask *URLSessionUploadTaskWithRequestFromData( NSURLSession *ref, NSURLRequest *request, CFDataRef dta );
NSURLSessionUploadTask *URLSessionUploadTaskWithRequestFromDataCompletionHandler( NSURLSession *ref, NSURLRequest *request, CFDataRef dta, CUI_URLSessionUploadTaskCompletionHandlerType handlerAddress, void *userData );
NSURLSessionUploadTask *URLSessionUploadTaskWithRequestFromFile( NSURLSession *ref, NSURLRequest *request, CFURLRef url );
NSURLSessionUploadTask *URLSessionUploadTaskWithRequestFromFileCompletionHandler( NSURLSession *ref, NSURLRequest *request, CFURLRef url, CUI_URLSessionUploadTaskCompletionHandlerType handlerAddress, void *userData );
NSURLSessionUploadTask *URLSessionUploadTaskWithStreamedRequest( NSURLSession *ref, NSURLRequest *request );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
NSURLSessionUploadTask *URLSessionUploadTaskWithResumeData( NSURLSession *ref, CFDataRef resumeData );
API_AVAILABLE(macos(14.0))
NSURLSessionUploadTask *URLSessionUploadTaskWithCompletionHandler( NSURLSession *ref, CFDataRef resumeData, CUI_URLSessionUploadTaskDataWithCompletionHandlerType completionHandler, void *userData );
#endif// 140000

// Add stream tasks
NSURLSessionStreamTask *URLSessionStreamTaskWithHostName( NSURLSession *ref, CFStringRef hostName, NSInteger port );
NSURLSessionStreamTask *URLSessionStreamTaskWithNetService( NSURLSession *ref, NSNetService *service );

// Managing session
void URLSessionFinishTasksAndInvalidate( NSURLSession *ref );
void URLSessionFlushWithCompletionHandler( NSURLSession *ref, CUI_URLSessionFlushCompletionHandlerType handlerAddress, void *userData );
void URLSessionGetTasksWithCompletionHandler( NSURLSession *ref, CUI_URLSessionGetTasksCompletionHandlerType handlerAddress, void *userData );
void URLSessionGetAllTasksWithCompletionHandler( NSURLSession *ref, CUI_URLSessionGetAllTasksCompletionHandlerType handlerAddress, void *userData );
void URLSessionInvalidateAndCancel( NSURLSession *ref );
void URLSessionResetWithCompletionHandler( NSURLSession *ref, CUI_URLSessionResetCompletionHandlerType handlerAddress, void *userData );


/*
 URLSessionConfiguration
 */
// Create
NSURLSessionConfiguration *URLSessionConfigurationDefault( void );
NSURLSessionConfiguration *URLSessionConfigurationEphemeral( void );
NSURLSessionConfiguration *URLSessionConfigurationBackground( CFStringRef identifier );

// General properties
CFStringRef URLSessionConfigurationIdentifier( NSURLSessionConfiguration *ref );
CFDictionaryRef URLSessionConfigurationHTTPAdditionalHeaders( NSURLSessionConfiguration *ref );
void URLSessionConfigurationSetHTTPAdditionalHeaders( NSURLSessionConfiguration *ref, CFDictionaryRef headers );
NSURLRequestNetworkServiceType URLSessionConfigurationNetworkServiceType( NSURLSessionConfiguration *ref );
void URLSessionConfigurationSetNetworkServiceType( NSURLSessionConfiguration *ref, NSURLRequestNetworkServiceType type );
BOOL URLSessionConfigurationAllowsCellularAccess( NSURLSessionConfiguration *ref );
void URLSessionConfigurationSetAllowsCellularAccess( NSURLSessionConfiguration *ref, BOOL flag );
CFTimeInterval URLSessionConfigurationTimeoutIntervalForRequest( NSURLSessionConfiguration *ref );
void URLSessionConfigurationSetTimeoutIntervalForRequest( NSURLSessionConfiguration *ref, CFTimeInterval ti );
CFTimeInterval URLSessionConfigurationTimeoutIntervalForResource( NSURLSessionConfiguration *ref );
void URLSessionConfigurationSetTimeoutIntervalForResource( NSURLSessionConfiguration *ref, CFTimeInterval ti );
CFStringRef URLSessionConfigurationSharedContainerIdentifier( NSURLSessionConfiguration *ref );
void URLSessionConfigurationSetSharedContainerIdentifier( NSURLSessionConfiguration *ref, CFStringRef identifier );
BOOL URLSessionConfigurationWaitsForConnectivity( NSURLSessionConfiguration *ref );
void URLSessionConfigurationSetWaitsForConnectivity( NSURLSessionConfiguration *ref, BOOL flag );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
BOOL URLSessionConfigurationSessionSendsLaunchEvents( NSURLSessionConfiguration *ref );
API_AVAILABLE(macos(11.0))
void URLSessionConfigurationSetSessionSendsLaunchEvents( NSURLSessionConfiguration *ref, BOOL flag );
#endif// 110000

// Cookie policies
NSHTTPCookieAcceptPolicy URLSessionConfigurationHTTPCookieAcceptPolicy( NSURLSessionConfiguration *ref );
void URLSessionConfigurationSetHTTPCookieAcceptPolicy( NSURLSessionConfiguration *ref, NSHTTPCookieAcceptPolicy policy );
BOOL URLSessionConfigurationHTTPShouldSetCookies( NSURLSessionConfiguration *ref );
void URLSessionConfigurationSetHTTPShouldSetCookies( NSURLSessionConfiguration *ref, BOOL flag );
NSHTTPCookieStorage *URLSessionConfigurationHTTPCookieStorage( NSURLSessionConfiguration *ref );
void URLSessionConfigurationSetHTTPCookieStorage( NSURLSessionConfiguration *ref, NSHTTPCookieStorage *storage );

// Security policies
SSLProtocol URLSessionConfigurationTLSMaximumSupportedProtocol( NSURLSessionConfiguration *ref );
void URLSessionConfigurationSetTLSMaximumSupportedProtocol( NSURLSessionConfiguration *ref, SSLProtocol protocol );
SSLProtocol URLSessionConfigurationTLSMinimumSupportedProtocol( NSURLSessionConfiguration *ref );
void URLSessionConfigurationSetTLSMinimumSupportedProtocol( NSURLSessionConfiguration *ref, SSLProtocol protocol );
NSURLCredentialStorage *URLSessionConfigurationURLCredentialStorage( NSURLSessionConfiguration *ref );
void URLSessionConfigurationSetURLCredentialStorage( NSURLSessionConfiguration *ref, NSURLCredentialStorage *storage );

// Caching policies
NSURLCache *URLSessionConfigurationURLCache( NSURLSessionConfiguration *ref );
void URLSessionConfigurationSetURLCache( NSURLSessionConfiguration *ref, NSURLCache *cache );
NSURLRequestCachePolicy URLSessionConfigurationRequestCachePolicy( NSURLSessionConfiguration *ref );
void URLSessionConfigurationSetRequestCachePolicy( NSURLSessionConfiguration *ref, NSURLRequestCachePolicy policy );

// Background transfers
BOOL URLSessionConfigurationIsDiscretionary( NSURLSessionConfiguration *ref );
void URLSessionConfigurationSetDiscretionary( NSURLSessionConfiguration *ref, BOOL flag );
BOOL URLSessionConfigurationShouldUseExtendedBackgroundIdleMode( NSURLSessionConfiguration *ref );
void URLSessionConfigurationSetShouldUseExtendedBackgroundIdleMode( NSURLSessionConfiguration *ref, BOOL flag );

// Custom protocols
CFArrayRef URLSessionConfigurationProtocoClasses( NSURLSessionConfiguration *ref );
void URLSessionConfigurationSetProtocoClasses( NSURLSessionConfiguration *ref, CFArrayRef classes );

// HTTP policy and proxy properties
NSInteger URLSessionConfigurationHTTPMaximumConnectionsPerHost( NSURLSessionConfiguration *ref );
void URLSessionConfigurationSetHTTPMaximumConnectionsPerHost( NSURLSessionConfiguration *ref, NSInteger connections );
BOOL URLSessionConfigurationHTTPShouldUsePipelining( NSURLSessionConfiguration *ref );
void URLSessionConfigurationSetHTTPShouldUsePipelining( NSURLSessionConfiguration *ref, BOOL flag );
CFDictionaryRef URLSessionConfigurationConnectionProxyDictionary( NSURLSessionConfiguration *ref );
void URLSessionConfigurationSetConnectionProxyDictionary( NSURLSessionConfiguration *ref, CFDictionaryRef proxy );

/*
 URLSessionTask
 */
// Task state
void URLSessionTaskCancel( NSURLSessionTask *ref );
void URLSessionTaskResume( NSURLSessionTask *ref );
void URLSessionTaskSuspend( NSURLSessionTask *ref );
NSURLSessionTaskState URLSessionTaskState( NSURLSessionTask *ref );
float URLSessionTaskPriority( NSURLSessionTask *ref );
void URLSessionTaskSetPriority( NSURLSessionTask *ref, float priority );

// Task progress
NSProgress *URLSessionTaskProgress( NSURLSessionTask *ref );
SInt64 URLSessionTaskCountOfBytesExpectedToReceive( NSURLSessionTask *ref );
SInt64 URLSessionTaskCountOfBytesReceived( NSURLSessionTask *ref );
SInt64 URLSessionTaskCountOfBytesExpectedToSend( NSURLSessionTask *ref );
SInt64 URLSessionTaskCountOfBytesSent( NSURLSessionTask *ref );

// General task info
NSURLRequest *URLSessionTaskCurrentRequest( NSURLSessionTask *ref );
NSURLRequest *URLSessionTaskOriginalRequest( NSURLSessionTask *ref );
NSURLResponse *URLSessionTaskResponse( NSURLSessionTask *ref );
CFStringRef URLSessionTaskDescription( NSURLSessionTask *ref );
void URLSessionTaskSetDescription( NSURLSessionTask *ref, CFStringRef description );
NSUInteger URLSessionTaskIdentifier( NSURLSessionTask *ref );
NSError *URLSessionTaskError( NSURLSessionTask *ref );

// Behavior
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110300
API_AVAILABLE(macos(11.3))
BOOL URLSessionTaskPrefersIncrementalDelivery( NSURLSessionTask *ref );
#endif

// Scheduling tasks
SInt64 URLSessionTaskCountOfBytesClientExpectsToReceive( NSURLSessionTask *ref );
SInt64 URLSessionTaskCountOfBytesClientExpectsToSend( NSURLSessionTask *ref );
CFDateRef URLSessionTaskEarliestBeginDate( NSURLSessionTask *ref );

/*
 URLSessionDataTask
 */


/*
 URLSessionDownloadTask
 */
typedef void (*CUI_URLSessionDownloadTaskCancelCompletionHandlerType)(NSURLSessionDownloadTask*,CFDataRef,void*);

// Cancel download
void URLSessionDownloadTaskCancelByProducingResumeData( NSURLSessionDownloadTask *ref, CUI_URLSessionDownloadTaskCancelCompletionHandlerType handlerAddress, void *userData );


#pragma mark - URLSessionUploadTask
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
typedef void (*CUI_URLSessionUploadTaskCancelByProducingResumeDataCompletionHandlerType)(NSURLSessionUploadTask*,CFDataRef,void*);

// Instance methods
API_AVAILABLE(macos(14.0))
void URLSessionUploadTaskCancelByProducingResumeData( NSURLSessionUploadTask *ref, CUI_URLSessionUploadTaskCancelByProducingResumeDataCompletionHandlerType completionHandler, void *userData );
#endif// 140000


#pragma mark - URLSessionStreamTask
typedef void (*CUI_URLSessionStreamTaskReadCompletionHandlerType)(NSURLSessionStreamTask*,CFDataRef,BOOL,NSError*,void*);
typedef void (*CUI_URLSessionStreamTaskWriteCompletionHandlerType)(NSURLSessionStreamTask*,NSError*,void*);

// Reading and writing
void URLSessionStreamTaskReadData( NSURLSessionStreamTask *ref, NSUInteger minLength, NSUInteger maxLength, CFTimeInterval timeout, CUI_URLSessionStreamTaskReadCompletionHandlerType handlerAddress, void *userData );
void URLSessionStreamTaskWriteData( NSURLSessionStreamTask *ref, CFDataRef dta, CFTimeInterval timeout, CUI_URLSessionStreamTaskWriteCompletionHandlerType handlerAddress, void *userData );

// Capture streams
void URLSessionStreamCaptureStreams( NSURLSessionStreamTask *ref );
void URLSessionStreamCloseWrite( NSURLSessionStreamTask *ref );

// Secure connections
void URLSessionStreamStartSecureConnection( NSURLSessionStreamTask *ref );
void URLSessionStreamStopSecureConnection( NSURLSessionStreamTask *ref );



