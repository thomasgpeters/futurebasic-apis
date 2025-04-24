/*
 QLPreviewItem.m

 Bernie Wylde
 */

#import "QLPreviewItem.h"

// URL
CFURLRef QLPreviewItemURL( id<QLPreviewItem> ref )
{ return (__bridge CFURLRef)[ref previewItemURL]; }

// Display
CFStringRef QLPreviewItemTitle( id<QLPreviewItem> ref )
{ return (__bridge CFStringRef)[ref previewItemTitle]; }

CFTypeRef QLPreviewItemDisplayState( id<QLPreviewItem> ref )
{ return (__bridge CFTypeRef)[ref previewItemDisplayState]; }

