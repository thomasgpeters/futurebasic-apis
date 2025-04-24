/*
 QLPreviewView.h

 Bernie Wylde
 */

#import "CocoaUI.h"

// Init
QLPreviewView *QLPreviewViewWithFrame( CGRect r );
QLPreviewView *QLPreviewViewWithFrameAndStyle( CGRect r, QLPreviewViewStyle theStyle );

// Display
id<QLPreviewItem> QLPreviewViewPreviewItem( QLPreviewView *ref );
void QLPreviewViewSetPreviewItem( QLPreviewView *ref, id<QLPreviewItem> item );
void QLPreviewViewRefreshPreviewItem( QLPreviewView *ref );
CFTypeRef QLPreviewViewDisplayState( QLPreviewView *ref );
void QLPreviewViewSetDisplayState( QLPreviewView *ref, CFTypeRef state );
BOOL QLPreviewViewAutostarts( QLPreviewView *ref );
void QLPreviewViewSetAutostarts( QLPreviewView *ref, BOOL flag );

// Close
BOOL QLPreviewViewShouldCloseWithWindow( QLPreviewView *ref );
void QLPreviewViewSetShouldCloseWithWindow( QLPreviewView *ref, BOOL flag );
void QLPreviewViewClose( QLPreviewView *ref );
