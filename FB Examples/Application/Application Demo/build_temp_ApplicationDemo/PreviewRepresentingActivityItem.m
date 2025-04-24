/*
 PreviewRepresentingActivityItem.m

 Bernie Wylde
 */

#import "PreviewRepresentingActivityItem.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000

// Create
NSPreviewRepresentingActivityItem *PreviewRepresentingActivityItemWithImage( id item, CFStringRef title, NSImage *image, NSImage *icon )
{ return [[[NSPreviewRepresentingActivityItem alloc] initWithItem:item title:(__bridge NSString *)title image:image icon:icon] autorelease]; }

NSPreviewRepresentingActivityItem *PreviewRepresentingActivityItemWithImageProvider( id item, CFStringRef title, NSItemProvider *imageProvider, NSItemProvider *iconProvider )
{ return [[[NSPreviewRepresentingActivityItem alloc] initWithItem:item title:(__bridge NSString *)title imageProvider:imageProvider iconProvider:iconProvider] autorelease]; }


#pragma mark - NSPreviewRepresentableActivityItem
// Item to share
id PreviewRepresentableActivityItemItem( id<NSPreviewRepresentableActivityItem> ref )
{ return [ref item]; }

// Item metadata
CFStringRef PreviewRepresentableActivityItemTitle( id<NSPreviewRepresentableActivityItem> ref )
{ return (__bridge CFStringRef)[ref title]; }

NSItemProvider *PreviewRepresentableActivityItemImageProvider( id<NSPreviewRepresentableActivityItem> ref )
{ return [ref imageProvider]; }

NSItemProvider *PreviewRepresentableActivityItemIconProvider( id<NSPreviewRepresentableActivityItem> ref )
{ return [ref iconProvider]; }

#endif // 130000
