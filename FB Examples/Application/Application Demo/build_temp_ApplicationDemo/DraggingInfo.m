/*
 DraggingInfo.m

 Bernie Wylde
 */

#import "DraggingInfo.h"

// Dragging session info
NSPasteboard *DraggingInfoPasteboard( id<NSDraggingInfo> ref )
{ return [ref draggingPasteboard]; }

NSInteger DraggingInfoSequenceNumber( id<NSDraggingInfo> ref )
{ return [ref draggingSequenceNumber]; }

CFTypeRef DraggingInfoSource( id<NSDraggingInfo> ref )
{ return (__bridge CFTypeRef)[ref draggingSource]; }

NSDragOperation DraggingInfoSourceOperationMask( id<NSDraggingInfo> ref )
{ return [ref draggingSourceOperationMask]; }

CGPoint DraggingInfoLocation( id<NSDraggingInfo> ref )
{ return NSPointToCGPoint([ref draggingLocation]); }

NSInteger DraggingInfoDestinationWindow( id<NSDraggingInfo> ref )
{ return [[ref draggingDestinationWindow] tag]; }

NSInteger DraggingInfoNumberOfValidItemsForDrop( id<NSDraggingInfo> ref )
{ return [ref numberOfValidItemsForDrop]; }

// Image info
CGPoint DraggingInfoImageLocation( id<NSDraggingInfo> ref )
{ return NSPointToCGPoint([ref draggedImageLocation]); }

// Sliding the image
void DraggingInfoSlideImageTo( id<NSDraggingInfo> ref, CGPoint screenPt )
{ [ref slideDraggedImageTo:NSPointFromCGPoint(screenPt)]; }

BOOL DraggingInfoAnimatesToDestination( id<NSDraggingInfo> ref )
{ return [ref animatesToDestination]; }

void DraggingInfoSetAnimatesToDestination( id<NSDraggingInfo> ref, BOOL flag )
{ [ref setAnimatesToDestination:flag]; }

NSDraggingFormation DraggingInfoFormation( id<NSDraggingInfo> ref )
{ return [ref draggingFormation]; }

// Enumerate
void DraggingInfoEnumerateItems( id<NSDraggingInfo> ref, NSDraggingItemEnumerationOptions options, NSInteger forViewTag, CFArrayRef classes, CFDictionaryRef searchOptions, CUI_DraggingInfoEnumerateItemsCallbackType callback, void *userData )
{
    NSView *forView = CUI_ViewWithTag( forViewTag );
    [ref enumerateDraggingItemsWithOptions:options forView:forView classes:(__bridge NSArray *)classes searchOptions:(__bridge NSDictionary *)searchOptions usingBlock:^(NSDraggingItem *draggingItem, NSInteger idx, BOOL *stop) {
        (*callback)( draggingItem, idx, stop, userData );
    }];
}

// Spring-loading support
NSSpringLoadingHighlight DraggingInfoSpringLoadingHighlight( id<NSDraggingInfo> ref )
{ return [ref springLoadingHighlight]; }

void DraggingInfoResetSpringLoading( id<NSDraggingInfo> ref )
{ [ref resetSpringLoading]; }
