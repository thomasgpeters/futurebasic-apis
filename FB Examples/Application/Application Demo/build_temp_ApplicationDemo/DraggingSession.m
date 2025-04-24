/*
 DraggingSession.m

 Bernie Wylde
 */

#import "DraggingSession.h"

// Class
Class DraggingSessionClass( void )
{ return [NSDraggingSession class]; }

// Pasteboard
NSPasteboard *DraggingSessionPasteboard( NSDraggingSession *ref )
{ return [ref draggingPasteboard]; }

// Visual representation
BOOL DraggingSessionAnimatesToStartingPositionOnCancelOrFail( NSDraggingSession *ref )
{ return [ref animatesToStartingPositionsOnCancelOrFail]; }

void DraggingSessionSetAnimatesToStartingPositionOnCancelOrFail( NSDraggingSession *ref, BOOL flag )
{ [ref setAnimatesToStartingPositionsOnCancelOrFail:flag]; }

NSDraggingFormation DraggingSessionFormation( NSDraggingSession *ref )
{ return [ref draggingFormation]; }

void DraggingSessionSetFormation( NSDraggingSession *ref, NSDraggingFormation formation )
{ [ref setDraggingFormation:formation]; }

// Identify
NSInteger DraggingSessionSequenceNumber( NSDraggingSession *ref )
{ return [ref draggingSequenceNumber]; }

// Enumerate items
void DraggingSessionEnumerateItems( NSDraggingSession *ref, NSDraggingItemEnumerationOptions options, NSInteger forViewTag, CFArrayRef classes, CFDictionaryRef searchOptions, CUI_DraggingSessionEnumerateItemsCallbackType callback, void *userData )
{
    NSView *view = CUI_ViewWithTag( forViewTag );
    if ( view ) {
        [ref enumerateDraggingItemsWithOptions:options forView:view classes:(__bridge NSArray *)classes searchOptions:(__bridge NSDictionary *)searchOptions usingBlock:^(NSDraggingItem *draggingItem, NSInteger idx, BOOL *stop) {
            (*callback)(ref,draggingItem,idx,stop,userData);
        }];
    }
}

// Location
CGPoint DraggingSessionLocation( NSDraggingSession *ref )
{ return NSPointToCGPoint([ref draggingLocation]); }

// Item location
NSInteger DraggingSessionLeaderIndex( NSDraggingSession *ref )
{ return [ref draggingLeaderIndex]; }

void DraggingSessionSetLeaderIndex( NSDraggingSession *ref, NSInteger index )
{ [ref setDraggingLeaderIndex:index]; }

