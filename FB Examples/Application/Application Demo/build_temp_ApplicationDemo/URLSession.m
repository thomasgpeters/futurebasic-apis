/*
 URLSession.m

 Bernie Wylde
 */

#import "URLSession.h"

@implementation CUI_URLSessionDelegate
#pragma mark - NSURLSessionDelegate
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error {
    CallUserDefinedOnDialogFunction( URLSessionDidBecomeInvalid, 0, 0, (__bridge CFTypeRef)session );
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    CallUserDefinedOnDialogFunction( URLSessionDidFinishEvents, 0, 0, (__bridge CFTypeRef)session );
}

//- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler {
//    CallUserDefinedOnDialogFunction( URLSessionDidReceiveChallenge, session, 0, error );
//}

#pragma mark - NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    DialogEventSetNSURL( location );
    CallUserDefinedOnDialogFunction( URLSessionDownloadTaskDidFinishDownloading, 0, 0, (__bridge CFTypeRef)session );
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    CallUserDefinedOnDialogFunction( URLSessionDownloadTaskDidResume, 0, 0, (__bridge CFTypeRef)session );
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    CallUserDefinedOnDialogFunction( URLSessionDownloadTaskDidWriteData, 0, 0, (__bridge CFTypeRef)session );
}

#pragma mark - NSURLSessionTaskDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    DialogEventSetURLSessionTask( task );
    DialogEventSetError( error );
    CallUserDefinedOnDialogFunction( URLSessionTaskDidComplete, 0, 0, (__bridge CFTypeRef)session );
}

//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest *))completionHandler {
//
//}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    CallUserDefinedOnDialogFunction( URLSessionTaskDidSendBodyData, 0, 0, (__bridge CFTypeRef)session );
}

//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task needNewBodyStream:(void (^)(NSInputStream *bodyStream))completionHandler {
//
//}

//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler {
//    
//}

//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willBeginDelayedRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLSessionDelayedRequestDisposition disposition, NSURLRequest *newRequest))completionHandler {
//
//}

- (void)URLSession:(NSURLSession *)session taskIsWaitingForConnectivity:(NSURLSessionTask *)task {
    CallUserDefinedOnDialogFunction( URLSessionTaskIsWaitingForConnectivity, 0, 0, (__bridge CFTypeRef)session );
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didFinishCollectingMetrics:(NSURLSessionTaskMetrics *)metrics {
    CallUserDefinedOnDialogFunction( URLSessionTaskDidFinishCollectingMetrics, 0, 0, (__bridge CFTypeRef)session );
}

// NSURLSessionDataDelegate
//- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
//
//}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask {

}

//- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didBecomeStreamTask:(NSURLSessionStreamTask *)streamTask {
//    
//}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    DialogEventSetURLSessionDataTask( dataTask );
    DialogEventSetData( data );
    CallUserDefinedOnDialogFunction( URLSessionDataTaskDidReceiveData, 0, 0, (__bridge CFTypeRef)session );
}

//- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask willCacheResponse:(NSCachedURLResponse *)proposedResponse completionHandler:(void (^)(NSCachedURLResponse *cachedResponse))completionHandler {
//
//}

// NSURLSessionStreamDelegate
- (void)URLSession:(NSURLSession *)session betterRouteDiscoveredForStreamTask:(NSURLSessionStreamTask *)streamTask {
    CallUserDefinedOnDialogFunction( URLSessionStreamTaskBetterRouteDiscovered, 0, 0, (__bridge CFTypeRef)session );
}

- (void)URLSession:(NSURLSession *)session streamTask:(NSURLSessionStreamTask *)streamTask didBecomeInputStream:(NSInputStream *)inputStream outputStream:(NSOutputStream *)outputStream {
    CallUserDefinedOnDialogFunction( URLSessionStreamTaskDidBecomeInputStream, 0, 0, (__bridge CFTypeRef)session );
}

- (void)URLSession:(NSURLSession *)session readClosedForStreamTask:(NSURLSessionStreamTask *)streamTask {
    CallUserDefinedOnDialogFunction( URLSessionStreamTaskReadClosed, 0, 0, (__bridge CFTypeRef)session );
}

- (void)URLSession:(NSURLSession *)session writeClosedForStreamTask:(NSURLSessionStreamTask *)streamTask {
    CallUserDefinedOnDialogFunction( URLSessionStreamTaskWriteClosed, 0, 0, (__bridge CFTypeRef)session );
}
@end

// - Private -
CUI_URLSessionDelegate *CUI_URLSessionDelegateObj( void )
{
    static CUI_URLSessionDelegate *sCUI_URLSessionDelegate = nil;
    if ( !sCUI_URLSessionDelegate ) sCUI_URLSessionDelegate = [[CUI_URLSessionDelegate alloc] init];
    return sCUI_URLSessionDelegate;
}

// Class
Class URLSessionClass( void )
{ return [NSURLSession class]; }

// Create
NSURLSession *URLSessionWithConfiguration( NSURLSessionConfiguration *config )
{ return [NSURLSession sessionWithConfiguration:config]; }

NSURLSession *URLSessionWithDelegateQueue( NSURLSessionConfiguration *config, NSOperationQueue *queue )
{ return [NSURLSession sessionWithConfiguration:config delegate:CUI_URLSessionDelegateObj() delegateQueue:queue]; }

NSURLSession *URLSessionSharedSession( void )
{ return [NSURLSession sharedSession]; }

// Configure
NSURLSessionConfiguration *URLSessionConfiguration( NSURLSession *ref )
{ return [ref configuration]; }

NSOperationQueue *URLSessionDelegateQueue( NSURLSession *ref )
{ return [ref delegateQueue]; }

CFStringRef URLSessionDescription( NSURLSession *ref )
{ return (__bridge CFStringRef)[ref sessionDescription]; }

// Add data tasks
NSURLSessionDataTask *URLSessionDataTaskWithURL( NSURLSession *ref, CFURLRef url )
{ return [ref dataTaskWithURL:(__bridge NSURL *)url]; }

NSURLSessionDataTask *URLSessionDataTaskWithURLCompletionHandler( NSURLSession *ref, CFURLRef url, CUI_URLSessionDataTaskCompletionHandlerType handlerAddress, void *userData )
{
    return [ref dataTaskWithURL:(__bridge NSURL *)url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        (*handlerAddress)( ref, (__bridge CFDataRef)data, response, error, userData );
    }];
}

NSURLSessionDataTask *URLSessionDataTaskWithRequest( NSURLSession *ref, NSURLRequest *request )
{ return [ref dataTaskWithRequest:request]; }

NSURLSessionDataTask *URLSessionDataTaskWithRequestCompletionHandler( NSURLSession *ref, NSURLRequest *request, CUI_URLSessionDataTaskCompletionHandlerType handlerAddress, void *userData )
{
    return [ref dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        (*handlerAddress)( ref, (__bridge CFDataRef)data, response, error, userData );
    }];
}

// Add download tasks
NSURLSessionDownloadTask *URLSessionDownloadTaskWithURL( NSURLSession *ref, CFURLRef url )
{ return [ref downloadTaskWithURL:(__bridge NSURL *)url]; }

NSURLSessionDownloadTask *URLSessionDownloadTaskWithURLCompletionHandler( NSURLSession *ref, CFURLRef url, CUI_URLSessionDownloadTaskCompletionHandlerType handlerAddress, void *userData )
{
    return [ref downloadTaskWithURL:(__bridge NSURL *)url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        (*handlerAddress)( ref, (__bridge CFURLRef)location, response, error, userData );
    }];
}

NSURLSessionDownloadTask *URLSessionDownloadTaskWithRequest( NSURLSession *ref, NSURLRequest *request )
{ return [ref downloadTaskWithRequest:request]; }

NSURLSessionDownloadTask *URLSessionDownloadTaskWithRequestCompletionHandler( NSURLSession *ref, NSURLRequest *request, CUI_URLSessionDownloadTaskCompletionHandlerType handlerAddress, void *userData )
{
    return [ref downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        (*handlerAddress)( ref, (__bridge CFURLRef)location, response, error, userData );
    }];
}

NSURLSessionDownloadTask *URLSessionDownloadTaskWithResumeData( NSURLSession *ref, CFDataRef dta )
{ return [ref downloadTaskWithResumeData:(__bridge NSData *)dta]; }

NSURLSessionDownloadTask *URLSessionDownloadTaskWithResumeDataCompletionHandler( NSURLSession *ref, CFDataRef dta, CUI_URLSessionDownloadTaskCompletionHandlerType handlerAddress, void *userData )
{
    return [ref downloadTaskWithResumeData:(__bridge NSData *)dta completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        (*handlerAddress)( ref, (__bridge CFURLRef)location, response, error, userData );
    }];
}

// Add upload tasks
NSURLSessionUploadTask *URLSessionUploadTaskWithRequestFromData( NSURLSession *ref, NSURLRequest *request, CFDataRef dta )
{ return [ref uploadTaskWithRequest:request fromData:(__bridge NSData *)dta]; }

NSURLSessionUploadTask *URLSessionUploadTaskWithRequestFromDataCompletionHandler( NSURLSession *ref, NSURLRequest *request, CFDataRef dta, CUI_URLSessionUploadTaskCompletionHandlerType handlerAddress, void *userData )
{
    return [ref uploadTaskWithRequest:request fromData:(__bridge NSData *)dta completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        (*handlerAddress)( ref, (__bridge CFDataRef)data, response, error, userData );
    }];
}

NSURLSessionUploadTask *URLSessionUploadTaskWithRequestFromFile( NSURLSession *ref, NSURLRequest *request, CFURLRef url )
{ return [ref uploadTaskWithRequest:request fromFile:(__bridge NSURL *)url]; }

NSURLSessionUploadTask *URLSessionUploadTaskWithRequestFromFileCompletionHandler( NSURLSession *ref, NSURLRequest *request, CFURLRef url, CUI_URLSessionUploadTaskCompletionHandlerType handlerAddress, void *userData )
{
    return [ref uploadTaskWithRequest:request fromFile:(__bridge NSURL *)url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        (*handlerAddress)( ref, (__bridge CFDataRef)data, response, error, userData );
    }];
}

NSURLSessionUploadTask *URLSessionUploadTaskWithStreamedRequest( NSURLSession *ref, NSURLRequest *request )
{ return [ref uploadTaskWithStreamedRequest:request]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
NSURLSessionUploadTask *URLSessionUploadTaskWithResumeData( NSURLSession *ref, CFDataRef resumeData )
{ return [ref uploadTaskWithResumeData:(__bridge NSData *)resumeData]; }

NSURLSessionUploadTask *URLSessionUploadTaskWithCompletionHandler( NSURLSession *ref, CFDataRef resumeData, CUI_URLSessionUploadTaskDataWithCompletionHandlerType completionHandler, void *userData )
{
    return [ref uploadTaskWithResumeData:(__bridge NSData *)resumeData completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
        if ( completionHandler ) (*completionHandler)(ref,(__bridge CFDataRef)data,response,error,userData);
    }];
}
#endif// 140000

// Add stream tasks
NSURLSessionStreamTask *URLSessionStreamTaskWithHostName( NSURLSession *ref, CFStringRef hostName, NSInteger port )
{ return [ref streamTaskWithHostName:(__bridge NSString *)hostName port:port]; }

NSURLSessionStreamTask *URLSessionStreamTaskWithNetService( NSURLSession *ref, NSNetService *service )
{ return [ref streamTaskWithNetService:service]; }

// Managing session
void URLSessionFinishTasksAndInvalidate( NSURLSession *ref )
{ [ref finishTasksAndInvalidate]; }

void URLSessionFlushWithCompletionHandler( NSURLSession *ref, CUI_URLSessionFlushCompletionHandlerType handlerAddress, void *userData )
{
    [ref flushWithCompletionHandler:^(void) {
        (*handlerAddress)( ref, userData );
    }];
}

void URLSessionGetTasksWithCompletionHandler( NSURLSession *ref, CUI_URLSessionGetTasksCompletionHandlerType handlerAddress, void *userData )
{
    [ref getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        (*handlerAddress)( ref, (__bridge CFArrayRef)dataTasks, (__bridge CFArrayRef)uploadTasks, (__bridge CFArrayRef)downloadTasks, userData );
    }];
}

void URLSessionGetAllTasksWithCompletionHandler( NSURLSession *ref, CUI_URLSessionGetAllTasksCompletionHandlerType handlerAddress, void *userData )
{
    [ref getAllTasksWithCompletionHandler:^(NSArray *tasks) {
        (*handlerAddress)( ref, (__bridge CFArrayRef)tasks, userData );
    }];
}

void URLSessionInvalidateAndCancel( NSURLSession *ref )
{ [ref invalidateAndCancel]; }

void URLSessionResetWithCompletionHandler( NSURLSession *ref, CUI_URLSessionResetCompletionHandlerType handlerAddress, void *userData )
{
    [ref resetWithCompletionHandler:^(void) {
        (*handlerAddress)( ref, userData );
    }];
}


/*
 URLSessionConfiguration
 */
// Create
NSURLSessionConfiguration *URLSessionConfigurationDefault( void )
{ return [NSURLSessionConfiguration defaultSessionConfiguration]; }

NSURLSessionConfiguration *URLSessionConfigurationEphemeral( void )
{ return [NSURLSessionConfiguration ephemeralSessionConfiguration]; }

NSURLSessionConfiguration *URLSessionConfigurationBackground( CFStringRef identifier )
{ return [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:(__bridge NSString *)identifier]; }

// General properties
CFStringRef URLSessionConfigurationIdentifier( NSURLSessionConfiguration *ref )
{ return (__bridge CFStringRef)[ref identifier]; }

CFDictionaryRef URLSessionConfigurationHTTPAdditionalHeaders( NSURLSessionConfiguration *ref )
{ return (__bridge CFDictionaryRef)[ref HTTPAdditionalHeaders]; }

void URLSessionConfigurationSetHTTPAdditionalHeaders( NSURLSessionConfiguration *ref, CFDictionaryRef headers )
{ [ref setHTTPAdditionalHeaders:(__bridge NSDictionary *)headers]; }

NSURLRequestNetworkServiceType URLSessionConfigurationNetworkServiceType( NSURLSessionConfiguration *ref )
{ return [ref networkServiceType]; }

void URLSessionConfigurationSetNetworkServiceType( NSURLSessionConfiguration *ref, NSURLRequestNetworkServiceType type )
{ [ref setNetworkServiceType:type]; }

BOOL URLSessionConfigurationAllowsCellularAccess( NSURLSessionConfiguration *ref )
{ return [ref allowsCellularAccess]; }

void URLSessionConfigurationSetAllowsCellularAccess( NSURLSessionConfiguration *ref, BOOL flag )
{ [ref setAllowsCellularAccess:flag]; }

CFTimeInterval URLSessionConfigurationTimeoutIntervalForRequest( NSURLSessionConfiguration *ref )
{ return [ref timeoutIntervalForRequest]; }

void URLSessionConfigurationSetTimeoutIntervalForRequest( NSURLSessionConfiguration *ref, CFTimeInterval ti )
{ [ref setTimeoutIntervalForRequest:ti]; }

CFTimeInterval URLSessionConfigurationTimeoutIntervalForResource( NSURLSessionConfiguration *ref )
{ return [ref timeoutIntervalForResource]; }

void URLSessionConfigurationSetTimeoutIntervalForResource( NSURLSessionConfiguration *ref, CFTimeInterval ti )
{ [ref setTimeoutIntervalForResource:ti]; }

CFStringRef URLSessionConfigurationSharedContainerIdentifier( NSURLSessionConfiguration *ref )
{ return (__bridge CFStringRef)[ref sharedContainerIdentifier]; }

void URLSessionConfigurationSetSharedContainerIdentifier( NSURLSessionConfiguration *ref, CFStringRef identifier )
{ [ref setSharedContainerIdentifier:(__bridge NSString *)identifier]; }

BOOL URLSessionConfigurationWaitsForConnectivity( NSURLSessionConfiguration *ref )
{ return [ref waitsForConnectivity]; }

void URLSessionConfigurationSetWaitsForConnectivity( NSURLSessionConfiguration *ref, BOOL flag )
{ [ref setWaitsForConnectivity:flag]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
BOOL URLSessionConfigurationSessionSendsLaunchEvents( NSURLSessionConfiguration *ref )
{ return [ref sessionSendsLaunchEvents]; }

void URLSessionConfigurationSetSessionSendsLaunchEvents( NSURLSessionConfiguration *ref, BOOL flag )
{ [ref setSessionSendsLaunchEvents:flag]; }
#endif// 110000

// Cookie policies
NSHTTPCookieAcceptPolicy URLSessionConfigurationHTTPCookieAcceptPolicy( NSURLSessionConfiguration *ref )
{ return [ref HTTPCookieAcceptPolicy]; }

void URLSessionConfigurationSetHTTPCookieAcceptPolicy( NSURLSessionConfiguration *ref, NSHTTPCookieAcceptPolicy policy )
{ [ref setHTTPCookieAcceptPolicy:policy]; }

BOOL URLSessionConfigurationHTTPShouldSetCookies( NSURLSessionConfiguration *ref )
{ return [ref HTTPShouldSetCookies]; }

void URLSessionConfigurationSetHTTPShouldSetCookies( NSURLSessionConfiguration *ref, BOOL flag )
{ [ref setHTTPShouldSetCookies:flag]; }

NSHTTPCookieStorage *URLSessionConfigurationHTTPCookieStorage( NSURLSessionConfiguration *ref )
{ return [ref HTTPCookieStorage]; }

void URLSessionConfigurationSetHTTPCookieStorage( NSURLSessionConfiguration *ref, NSHTTPCookieStorage *storage )
{ [ref setHTTPCookieStorage:storage]; }

// Security policies
SSLProtocol URLSessionConfigurationTLSMaximumSupportedProtocol( NSURLSessionConfiguration *ref )
{ return [ref TLSMaximumSupportedProtocol]; }

void URLSessionConfigurationSetTLSMaximumSupportedProtocol( NSURLSessionConfiguration *ref, SSLProtocol protocol )
{ [ref setTLSMaximumSupportedProtocol:protocol]; }

SSLProtocol URLSessionConfigurationTLSMinimumSupportedProtocol( NSURLSessionConfiguration *ref )
{ return [ref TLSMinimumSupportedProtocol]; }

void URLSessionConfigurationSetTLSMinimumSupportedProtocol( NSURLSessionConfiguration *ref, SSLProtocol protocol )
{ [ref setTLSMinimumSupportedProtocol:protocol]; }

NSURLCredentialStorage *URLSessionConfigurationURLCredentialStorage( NSURLSessionConfiguration *ref )
{ return [ref URLCredentialStorage]; }

void URLSessionConfigurationSetURLCredentialStorage( NSURLSessionConfiguration *ref, NSURLCredentialStorage *storage )
{ [ref setURLCredentialStorage:storage]; }

// Caching policies
NSURLCache *URLSessionConfigurationURLCache( NSURLSessionConfiguration *ref )
{ return [ref URLCache]; }

void URLSessionConfigurationSetURLCache( NSURLSessionConfiguration *ref, NSURLCache *cache )
{ [ref setURLCache:cache]; }

NSURLRequestCachePolicy URLSessionConfigurationRequestCachePolicy( NSURLSessionConfiguration *ref )
{ return [ref requestCachePolicy]; }

void URLSessionConfigurationSetRequestCachePolicy( NSURLSessionConfiguration *ref, NSURLRequestCachePolicy policy )
{ [ref setRequestCachePolicy:policy]; }

// Background transfers
BOOL URLSessionConfigurationIsDiscretionary( NSURLSessionConfiguration *ref )
{ return [ref isDiscretionary]; }

void URLSessionConfigurationSetDiscretionary( NSURLSessionConfiguration *ref, BOOL flag )
{ [ref setDiscretionary:flag]; }

BOOL URLSessionConfigurationShouldUseExtendedBackgroundIdleMode( NSURLSessionConfiguration *ref )
{ return [ref shouldUseExtendedBackgroundIdleMode]; }

void URLSessionConfigurationSetShouldUseExtendedBackgroundIdleMode( NSURLSessionConfiguration *ref, BOOL flag )
{ [ref setShouldUseExtendedBackgroundIdleMode:flag]; }

// Custom protocols
CFArrayRef URLSessionConfigurationProtocoClasses( NSURLSessionConfiguration *ref )
{ return (__bridge CFArrayRef)[ref protocolClasses]; }

void URLSessionConfigurationSetProtocoClasses( NSURLSessionConfiguration *ref, CFArrayRef classes )
{ [ref setProtocolClasses:(__bridge NSArray *)classes]; }

// HTTP policy and proxy properties
NSInteger URLSessionConfigurationHTTPMaximumConnectionsPerHost( NSURLSessionConfiguration *ref )
{ return [ref HTTPMaximumConnectionsPerHost]; }

void URLSessionConfigurationSetHTTPMaximumConnectionsPerHost( NSURLSessionConfiguration *ref, NSInteger connections )
{ [ref setHTTPMaximumConnectionsPerHost:connections]; }

BOOL URLSessionConfigurationHTTPShouldUsePipelining( NSURLSessionConfiguration *ref )
{ return [ref HTTPShouldUsePipelining]; }

void URLSessionConfigurationSetHTTPShouldUsePipelining( NSURLSessionConfiguration *ref, BOOL flag )
{ [ref setHTTPShouldUsePipelining:flag]; }

CFDictionaryRef URLSessionConfigurationConnectionProxyDictionary( NSURLSessionConfiguration *ref )
{ return (__bridge CFDictionaryRef)[ref connectionProxyDictionary]; }

void URLSessionConfigurationSetConnectionProxyDictionary( NSURLSessionConfiguration *ref, CFDictionaryRef proxy )
{ [ref setConnectionProxyDictionary:(__bridge NSDictionary *)proxy]; }


/*
 URLSessionTask
 */
// Task state
void URLSessionTaskCancel( NSURLSessionTask *ref )
{ [ref cancel]; }

void URLSessionTaskResume( NSURLSessionTask *ref )
{ [ref resume]; }

void URLSessionTaskSuspend( NSURLSessionTask *ref )
{ [ref suspend]; }

NSURLSessionTaskState URLSessionTaskState( NSURLSessionTask *ref )
{ return [ref state]; }

float URLSessionTaskPriority( NSURLSessionTask *ref )
{ return [ref priority]; }

void URLSessionTaskSetPriority( NSURLSessionTask *ref, float priority )
{ [ref setPriority:priority]; }

// Task progress
NSProgress *URLSessionTaskProgress( NSURLSessionTask *ref )
{ return [ref progress]; }

SInt64 URLSessionTaskCountOfBytesExpectedToReceive( NSURLSessionTask *ref )
{ return [ref countOfBytesExpectedToReceive]; }

SInt64 URLSessionTaskCountOfBytesReceived( NSURLSessionTask *ref )
{ return [ref countOfBytesReceived]; }

SInt64 URLSessionTaskCountOfBytesExpectedToSend( NSURLSessionTask *ref )
{ return [ref countOfBytesExpectedToSend]; }

SInt64 URLSessionTaskCountOfBytesSent( NSURLSessionTask *ref )
{ return [ref countOfBytesSent]; }

// General task info
NSURLRequest *URLSessionTaskCurrentRequest( NSURLSessionTask *ref )
{ return [ref currentRequest]; }

NSURLRequest *URLSessionTaskOriginalRequest( NSURLSessionTask *ref )
{ return [ref originalRequest]; }

NSURLResponse *URLSessionTaskResponse( NSURLSessionTask *ref )
{ return [ref response]; }

CFStringRef URLSessionTaskDescription( NSURLSessionTask *ref )
{ return (__bridge CFStringRef)[ref taskDescription]; }

void URLSessionTaskSetDescription( NSURLSessionTask *ref, CFStringRef description )
{ [ref setTaskDescription:(__bridge NSString *)description]; }

NSUInteger URLSessionTaskIdentifier( NSURLSessionTask *ref )
{ return [ref taskIdentifier]; }

NSError *URLSessionTaskError( NSURLSessionTask *ref )
{ return [ref error]; }

// Behavior
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110300
BOOL URLSessionTaskPrefersIncrementalDelivery( NSURLSessionTask *ref )
{ return [ref prefersIncrementalDelivery]; }
#endif

// Scheduling tasks
SInt64 URLSessionTaskCountOfBytesClientExpectsToReceive( NSURLSessionTask *ref )
{ return [ref countOfBytesClientExpectsToReceive]; }

SInt64 URLSessionTaskCountOfBytesClientExpectsToSend( NSURLSessionTask *ref )
{ return [ref countOfBytesClientExpectsToSend]; }

CFDateRef URLSessionTaskEarliestBeginDate( NSURLSessionTask *ref )
{ return (__bridge CFDateRef)[ref earliestBeginDate]; }

/*
 URLSessionDataTask
 */


/*
 URLSessionDownloadTask
 */
// Cancel download
void URLSessionDownloadTaskCancelByProducingResumeData( NSURLSessionDownloadTask *ref, CUI_URLSessionDownloadTaskCancelCompletionHandlerType handlerAddress, void *userData )
{
    [ref cancelByProducingResumeData:^(NSData *resumeData) {
        (*handlerAddress)( ref, (__bridge CFDataRef)resumeData, userData );
    }];
}


#pragma mark - URLSessionUploadTask
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000

// Instance methods
void URLSessionUploadTaskCancelByProducingResumeData( NSURLSessionUploadTask *ref, CUI_URLSessionUploadTaskCancelByProducingResumeDataCompletionHandlerType completionHandler, void *userData )
{
    [ref cancelByProducingResumeData:^(NSData *resumeData) {
        if ( completionHandler ) (*completionHandler)(ref,(__bridge CFDataRef)resumeData,userData);
    }];
}
#endif// 140000



/*
 URLSessionStreamTask
 */
// Reading and writing
void URLSessionStreamTaskReadData( NSURLSessionStreamTask *ref, NSUInteger minLength, NSUInteger maxLength, CFTimeInterval timeout, CUI_URLSessionStreamTaskReadCompletionHandlerType handlerAddress, void *userData )
{
    [ref readDataOfMinLength:minLength maxLength:maxLength timeout:timeout completionHandler:^(NSData *data, BOOL atEOF, NSError *error) {
        (*handlerAddress)( ref, (__bridge CFDataRef)data, atEOF, error, userData );
    }];
}

void URLSessionStreamTaskWriteData( NSURLSessionStreamTask *ref, CFDataRef dta, CFTimeInterval timeout, CUI_URLSessionStreamTaskWriteCompletionHandlerType handlerAddress, void *userData )
{
    [ref writeData:(__bridge NSData *)dta timeout:timeout completionHandler:^(NSError *error) {
        (*handlerAddress)( ref, error, userData );
    }];
}

// Capture streams
void URLSessionStreamCaptureStreams( NSURLSessionStreamTask *ref )
{ [ref captureStreams]; }

void URLSessionStreamCloseWrite( NSURLSessionStreamTask *ref )
{ [ref closeWrite]; }

// Secure connections
void URLSessionStreamStartSecureConnection( NSURLSessionStreamTask *ref )
{ [ref startSecureConnection]; }

void URLSessionStreamStopSecureConnection( NSURLSessionStreamTask *ref )
{ [ref stopSecureConnection]; }


