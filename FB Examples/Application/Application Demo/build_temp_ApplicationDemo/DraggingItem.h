/*
 DraggingItem.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef BOOL (*CUI_DraggingItemImageComponentsProviderCallbackType)(NSDraggingItem*,void *);

// Class
Class DraggingItemClass( void );

// Init
NSDraggingItem *DraggingItemWithPasteboardWriter( id<NSPasteboardWriting> pbWriter );

// Frame
void DraggingItemSetFrame( NSDraggingItem *ref, CGRect r, CFTypeRef contents );
CGRect DraggingItemFrame( NSDraggingItem *ref );

// Image components
CFArrayRef DraggingItemImageComponents( NSDraggingItem *ref );
//CFArrayRef DraggingItemImageComponentsProvider( NSDraggingItem *ref, CUI_DraggingItemImageComponentsProviderCallbackType callback, void *userData );
CFTypeRef DraggingItemItem( NSDraggingItem *ref );
