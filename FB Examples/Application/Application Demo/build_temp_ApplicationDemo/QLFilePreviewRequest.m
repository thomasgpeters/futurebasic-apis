/*
 QLFilePreviewRequest.m

 Bernie Wylde
 */

#import "QLFilePreviewRequest.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000

// Inspect
CFURLRef QLFilePreviewRequestFileURL( QLFilePreviewRequest *ref )
{ return (__bridge CFURLRef)[ref fileURL]; }

#endif// 120000

