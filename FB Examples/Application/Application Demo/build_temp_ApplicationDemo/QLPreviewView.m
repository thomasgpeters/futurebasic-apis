/*
 QLPreviewView.m

 Bernie Wylde
 */

#import "QLPreviewView.h"

// Init
QLPreviewView *QLPreviewViewWithFrame( CGRect r )
{
#if __has_feature(objc_arc)
    return [[QLPreviewView alloc] initWithFrame:r];
#else
    return [[[QLPreviewView alloc] initWithFrame:r] autorelease];
#endif
}

QLPreviewView *QLPreviewViewWithFrameAndStyle( CGRect r, QLPreviewViewStyle theStyle )
{
#if __has_feature(objc_arc)
    return [[QLPreviewView alloc] initWithFrame:r style:theStyle];
#else
    return [[[QLPreviewView alloc] initWithFrame:r style:theStyle] autorelease];
#endif
}

// Display
id<QLPreviewItem> QLPreviewViewPreviewItem( QLPreviewView *ref )
{ return [ref previewItem]; }

void QLPreviewViewSetPreviewItem( QLPreviewView *ref, id<QLPreviewItem> item )
{ [ref setPreviewItem:item]; }

void QLPreviewViewRefreshPreviewItem( QLPreviewView *ref )
{ [ref refreshPreviewItem]; }

CFTypeRef QLPreviewViewDisplayState( QLPreviewView *ref )
{ return (__bridge CFTypeRef)[ref displayState]; }

void QLPreviewViewSetDisplayState( QLPreviewView *ref, CFTypeRef state )
{ [ref setDisplayState:(__bridge id)state]; }

BOOL QLPreviewViewAutostarts( QLPreviewView *ref )
{ return [ref autostarts]; }

void QLPreviewViewSetAutostarts( QLPreviewView *ref, BOOL flag )
{ [ref setAutostarts:flag]; }

// Close
BOOL QLPreviewViewShouldCloseWithWindow( QLPreviewView *ref )
{ return [ref shouldCloseWithWindow]; }

void QLPreviewViewSetShouldCloseWithWindow( QLPreviewView *ref, BOOL flag )
{ [ref setShouldCloseWithWindow:flag]; }

void QLPreviewViewClose( QLPreviewView *ref )
{ [ref close]; }

