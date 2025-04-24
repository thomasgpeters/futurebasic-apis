/*
 DraggingInfo.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "View.h"

typedef void (*CUI_DraggingInfoEnumerateItemsCallbackType)(NSDraggingItem*,NSInteger,BOOL*,void*);

// Dragging session info
NSPasteboard *DraggingInfoPasteboard( id<NSDraggingInfo> ref );
NSInteger DraggingInfoSequenceNumber( id<NSDraggingInfo> ref );
CFTypeRef DraggingInfoSource( id<NSDraggingInfo> ref );
NSDragOperation DraggingInfoSourceOperationMask( id<NSDraggingInfo> ref );
CGPoint DraggingInfoLocation( id<NSDraggingInfo> ref );
NSInteger DraggingInfoDestinationWindow( id<NSDraggingInfo> ref );
NSInteger DraggingInfoNumberOfValidItemsForDrop( id<NSDraggingInfo> ref );

// Image info
CGPoint DraggingInfoImageLocation( id<NSDraggingInfo> ref );

// Sliding the image
void DraggingInfoSlideImageTo( id<NSDraggingInfo> ref, CGPoint screenPt );
BOOL DraggingInfoAnimatesToDestination( id<NSDraggingInfo> ref );
void DraggingInfoSetAnimatesToDestination( id<NSDraggingInfo> ref, BOOL flag );
NSDraggingFormation DraggingInfoFormation( id<NSDraggingInfo> ref );

// Enumerate
void DraggingInfoEnumerateItems( id<NSDraggingInfo> ref, NSDraggingItemEnumerationOptions options, NSInteger forViewTag, CFArrayRef classes, CFDictionaryRef searchOptions, CUI_DraggingInfoEnumerateItemsCallbackType callback, void *userData );

// Spring-loading support
NSSpringLoadingHighlight DraggingInfoSpringLoadingHighlight( id<NSDraggingInfo> ref );
void DraggingInfoResetSpringLoading( id<NSDraggingInfo> ref );
