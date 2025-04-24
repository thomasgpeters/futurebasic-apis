/*
 QLPreviewingController.m

 Bernie Wylde
 */

#import "QLPreviewingController.h"


// Create preview
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
void QLPreviewingControllerPreparePreviewOfFileAtURL( id<QLPreviewingController> ref, CFURLRef url, CUI_QLPreviewingControllerPreparePreviewOfFileCompletionHandlerType completionHandler, void *userData )
{
    [ref preparePreviewOfFileAtURL:(__bridge NSURL *)url completionHandler:^(NSError *error) {
        (*completionHandler)(ref,error,userData);
    }];
}
#endif// 101500

void QLPreviewingControllerPreparePreviewOfSearchableItemWithIdentifier( id<QLPreviewingController> ref, CFStringRef identifier, CFStringRef queryString, CUI_QLPreviewingControllerPreparePreviewOfSearchableItemCompletionHandlerType completionHandler, void *userData )
{
    [ref preparePreviewOfSearchableItemWithIdentifier:(__bridge NSString *)identifier queryString:(__bridge NSString *)queryString completionHandler:^(NSError *error) {
        (*completionHandler)(ref,error,userData);
    }];
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
void QLPreviewingControllerProvidePreviewForFileRequest( id<QLPreviewingController> ref, QLFilePreviewRequest *fileRequest, CUI_QLPreviewingControllerProvidePreviewForFileRequestCompletionHandlerType completionHandler, void *userData )
{
    [ref providePreviewForFileRequest:fileRequest completionHandler:^( QLPreviewReply *reply, NSError *error ) {
        if ( completionHandler ) (*completionHandler)( ref, reply, error, userData );
    }];
}
#endif// 120000


