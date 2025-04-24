/*
 VisualEffectView.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "DialogEvent.h"
//#import "View.h"
//#import "Window.h"


@interface VisualEffectViewSC : NSVisualEffectView
@end

// Class
Class VisualEffectViewClass( void );

NSVisualEffectView *VisualEffectViewWithTag( NSInteger tag );
BOOL VisualEffectViewExists( NSInteger tag );

// Functions
NSVisualEffectMaterial VisualEffectViewMaterial( NSInteger tag );
void VisualEffectViewSetMaterial( NSInteger tag, NSVisualEffectMaterial material );
NSBackgroundStyle VisualEffectViewInteriorBackgroundStyle( NSInteger tag );
NSVisualEffectBlendingMode VisualEffectViewBlendingMode( NSInteger tag );
void VisualEffectViewSetBlendingMode( NSInteger tag, NSVisualEffectBlendingMode mode );
NSVisualEffectState VisualEffectViewState( NSInteger tag );
void VisualEffectViewSetState( NSInteger tag, NSVisualEffectState state );
NSImage *VisualEffectViewMaskImage( NSInteger tag );
void VisualEffectViewSetMaskImage( NSInteger tag, NSImage *image );

BOOL VisualEffectViewIsEmphasized( NSInteger tag );
void VisualEffectViewSetEmphasized( NSInteger tag, BOOL flag );


// Init
NSVisualEffectView *VisualEffectViewInit( NSInteger inTag, CGRect inRect );

// Statement
void CUI_VisualEffectView( NSInteger inTag, CGRect inRect, NSInteger inMaterial, NSInteger inMode, NSInteger inState, void *inImage, NSInteger inEmphasized, NSInteger inWndTag );


