/*
 PreviewRepresentingActivityItem.h

 Bernie Wylde
 */

#import "CocoaUI.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000

// Create
API_AVAILABLE(macos(13.0))
NSPreviewRepresentingActivityItem *PreviewRepresentingActivityItemWithImage( id item, CFStringRef title, NSImage *image, NSImage *icon );
API_AVAILABLE(macos(13.0))
NSPreviewRepresentingActivityItem *PreviewRepresentingActivityItemWithImageProvider( id item, CFStringRef title, NSItemProvider *imageProvider, NSItemProvider *iconProvider );


#pragma mark - NSPreviewRepresentableActivityItem
// Item to share
id PreviewRepresentableActivityItemItem( id<NSPreviewRepresentableActivityItem> ref );

// Item metadata
CFStringRef PreviewRepresentableActivityItemTitle( id<NSPreviewRepresentableActivityItem> ref );
NSItemProvider *PreviewRepresentableActivityItemImageProvider( id<NSPreviewRepresentableActivityItem> ref );
NSItemProvider *PreviewRepresentableActivityItemIconProvider( id<NSPreviewRepresentableActivityItem> ref );

#endif // 130000
