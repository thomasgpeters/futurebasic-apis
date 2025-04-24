/*
 DraggingSession.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "View.h"

typedef void (*CUI_DraggingSessionEnumerateItemsCallbackType)(NSDraggingSession*,NSDraggingItem*,NSInteger,BOOL*,void*);

// Class
Class DraggingSessionClass( void );

// Pasteboard
NSPasteboard *DraggingSessionPasteboard( NSDraggingSession *ref );

// Visual representation
BOOL DraggingSessionAnimatesToStartingPositionOnCancelOrFail( NSDraggingSession *ref );
void DraggingSessionSetAnimatesToStartingPositionOnCancelOrFail( NSDraggingSession *ref, BOOL flag );
NSDraggingFormation DraggingSessionFormation( NSDraggingSession *ref );
void DraggingSessionSetFormation( NSDraggingSession *ref, NSDraggingFormation formation );

// Identify
NSInteger DraggingSessionSequenceNumber( NSDraggingSession *ref );

// Enumerate items
void DraggingSessionEnumerateItems( NSDraggingSession *ref, NSDraggingItemEnumerationOptions options, NSInteger forViewTag, CFArrayRef classes, CFDictionaryRef searchOptions, CUI_DraggingSessionEnumerateItemsCallbackType callback, void *userData );

// Location
CGPoint DraggingSessionLocation( NSDraggingSession *ref );

// Item location
NSInteger DraggingSessionLeaderIndex( NSDraggingSession *ref );
void DraggingSessionSetLeaderIndex( NSDraggingSession *ref, NSInteger index );
