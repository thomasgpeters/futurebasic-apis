/*
 QLPreviewingController.h

 Bernie Wylde
 */

#import "CocoaUI.h"


typedef void (*CUI_QLPreviewingControllerPreparePreviewOfFileCompletionHandlerType)(id<QLPreviewingController>,NSError*,void*);
typedef void (*CUI_QLPreviewingControllerPreparePreviewOfSearchableItemCompletionHandlerType)(id<QLPreviewingController>,NSError*,void*);
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
typedef void (*CUI_QLPreviewingControllerProvidePreviewForFileRequestCompletionHandlerType)(id<QLPreviewingController>,QLPreviewReply*,NSError*,void*);
#endif// 120000


// Create preview
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
void QLPreviewingControllerPreparePreviewOfFileAtURL( id<QLPreviewingController> ref, CFURLRef url, CUI_QLPreviewingControllerPreparePreviewOfFileCompletionHandlerType completionHandler, void *userData );
#endif// 101500
void QLPreviewingControllerPreparePreviewOfSearchableItemWithIdentifier( id<QLPreviewingController> ref, CFStringRef identifier, CFStringRef queryString, CUI_QLPreviewingControllerPreparePreviewOfSearchableItemCompletionHandlerType completionHandler, void *userData );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
void QLPreviewingControllerProvidePreviewForFileRequest( id<QLPreviewingController> ref, QLFilePreviewRequest *fileRequest, CUI_QLPreviewingControllerProvidePreviewForFileRequestCompletionHandlerType completionHandler, void *userData );
#endif// 120000

