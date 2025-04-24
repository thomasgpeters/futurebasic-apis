/*
 ExtensionContext.m

 Bernie Wylde
 */

#import "ExtensionContext.h"

// Handling requests
void ExtensionContextCancelRequest( NSExtensionContext *ref, NSError *err )
{ [ref cancelRequestWithError:err]; }

void ExtensionContextCompleteRequest( NSExtensionContext *ref, CFArrayRef returningItems, CUI_ExtensionContextCompleteRequestCompletionHandlerType completionHandler, void *userData )
{
    [ref completeRequestReturningItems:(__bridge NSArray *)returningItems completionHandler:^(BOOL expired) {
        (*completionHandler)(ref,expired,userData);
    }];
}

// Opening URLs
void ExtensionContextOpenURL( NSExtensionContext *ref, CFURLRef url, CUI_ExtensionContextOpenURLCompletionHandlerType completionHandler, void *userData )
{
    [ref openURL:(__bridge NSURL *)url completionHandler:^(BOOL success) {
        (*completionHandler)(ref,success,userData);
    }];
}

// Storing items
CFArrayRef ExtensionContextInputItems( NSExtensionContext *ref )
{ return (__bridge CFArrayRef)[ref inputItems]; }

// Media playback
//#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
//void ExtensionContextMediaPlayingStarted( NSExtensionContext *ref )
//{ [ref mediaPlayingStarted]; }

//void ExtensionContextMediaPlayingPaused( NSExtensionContext *ref )
//{ [ref mediaPlayingPaused]; }
//#endif// 110000

// Instance properties
//#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
//CFArrayRef ExtensionContextNotificationActions( NSExtensionContext *ref )
//{ return (__bridge CFArrayRef)[ref notificationActions]; }
//#endif// 110000


