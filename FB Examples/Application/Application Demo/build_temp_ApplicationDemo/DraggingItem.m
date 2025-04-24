/*
 DraggingItem.m

 Bernie Wylde
 */

#import "DraggingItem.h"

// Class
Class DraggingItemClass( void )
{ return [NSDraggingItem class]; }

// Init
NSDraggingItem *DraggingItemWithPasteboardWriter( id<NSPasteboardWriting> pbWriter )
{
#if __has_feature(objc_arc)
    return [[NSDraggingItem alloc] initWithPasteboardWriter:pbWriter];
#else
    return [[[NSDraggingItem alloc] initWithPasteboardWriter:pbWriter] autorelease];
#endif
}

// Frame
void DraggingItemSetFrame( NSDraggingItem *ref, CGRect r, CFTypeRef contents )
{ [ref setDraggingFrame:NSRectFromCGRect(r) contents:(__bridge id)contents]; }

CGRect DraggingItemFrame( NSDraggingItem *ref )
{ return NSRectToCGRect([ref draggingFrame]); }

// Image components
CFArrayRef DraggingItemImageComponents( NSDraggingItem *ref )
{ return (__bridge CFArrayRef)[ref imageComponents]; }

//CFArrayRef DraggingItemImageComponentsProvider( NSDraggingItem *ref, CUI_DraggingItemImageComponentsProviderCallbackType callback, void *userData );

CFTypeRef DraggingItemItem( NSDraggingItem *ref )
{ return (__bridge CFTypeRef)[ref item]; }
