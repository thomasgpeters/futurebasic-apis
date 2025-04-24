/*
 QLPreviewItem.h

 Bernie Wylde
 */

#import "CocoaUI.h"

// URL
CFURLRef QLPreviewItemURL( id<QLPreviewItem> ref );

// Display
CFStringRef QLPreviewItemTitle( id<QLPreviewItem> ref );
CFTypeRef QLPreviewItemDisplayState( id<QLPreviewItem> ref );

