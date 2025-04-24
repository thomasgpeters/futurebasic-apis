/*
 QLFilePreviewRequest.h

 Bernie Wylde
 */

#import "CocoaUI.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000

// Inspect
API_AVAILABLE(macos(12.0))
CFURLRef QLFilePreviewRequestFileURL( QLFilePreviewRequest *ref );

#endif// 120000
