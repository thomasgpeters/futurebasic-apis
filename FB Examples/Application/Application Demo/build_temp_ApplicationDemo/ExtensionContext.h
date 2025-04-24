/*
 ExtensionContext.h

 Bernie Wylde
 */

#import "CocoaUI.h"


typedef void (*CUI_ExtensionContextCompleteRequestCompletionHandlerType)(NSExtensionContext*,BOOL,void*);
typedef void (*CUI_ExtensionContextOpenURLCompletionHandlerType)(NSExtensionContext*,BOOL,void*);

// Handling requests
void ExtensionContextCancelRequest( NSExtensionContext *ref, NSError *err );
void ExtensionContextCompleteRequest( NSExtensionContext *ref, CFArrayRef returningItems, CUI_ExtensionContextCompleteRequestCompletionHandlerType completionHandler, void *userData );

// Opening URLs
void ExtensionContextOpenURL( NSExtensionContext *ref, CFURLRef url, CUI_ExtensionContextOpenURLCompletionHandlerType completionHandler, void *userData );

// Storing items
CFArrayRef ExtensionContextInputItems( NSExtensionContext *ref );

// Media playback
//#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
//void ExtensionContextMediaPlayingStarted( NSExtensionContext *ref );
//void ExtensionContextMediaPlayingPaused( NSExtensionContext *ref );
//#endif// 110000

// Instance properties
//#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
//CFArrayRef ExtensionContextNotificationActions( NSExtensionContext *ref );
//#endif// 110000


