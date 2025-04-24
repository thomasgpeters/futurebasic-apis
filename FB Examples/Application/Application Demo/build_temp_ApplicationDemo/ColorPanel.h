/*
 ColorPanel.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "DialogEvent.h"
//#import "View.h"

// dialog events
enum {
    colorPanelChangeColor = 2600
};

typedef void (*CUI_ColorPanelCallbackType)(NSColor*,void*);

@interface CUI_ColorPanelTarget : NSObject
@property (nonatomic,assign) CUI_ColorPanelCallbackType callback;
@property (nonatomic,assign) void *userData;
@end

void CUI_ColorPanelSetTarget( void );

// Class
Class ColorPanelClass( void );

// - shared color panel
NSColorPanel *ColorPanelShared( void );

// - configure -
NSView *ColorPanelAccessoryView( void );
void ColorPanelSetAccessoryView( NSView *ref );
BOOL ColorPanelIsContinuous( void );
void ColorPanelSetContinuous( BOOL flag );
NSColorPanelMode ColorPanelMode( void );
void ColorPanelSetMode( NSColorPanelMode mode );
void ColorPanelSetActionCallback( CUI_ColorPanelCallbackType callback, void *userData );
BOOL ColorPanelShowsAlpha( void );
void ColorPanelSetShowsAlpha( BOOL flag );

// Color lists
void ColorPanelAttachColorList( NSColorList *cl );
void ColorPanelDetachColorList( NSColorList *cl );

// - picker modes
void ColorPanelSetPickerMode( NSInteger mode );
void ColorPanelSetPickerMask( NSColorPanelOptions mask );

// - setting color -
NSColor *ColorPanelColor( void );
void ColorPanelSetColor( NSColor *col );
BOOL ColorPanelDragColor( NSColor *col, NSEvent *event, NSInteger fromView );

// - color info -
CGFloat ColorPanelAlpha( void );

#pragma mark - Convenience
void ColorPanelShow( void );
void ColorPanelClose( void );
BOOL ColorPanelIsVisible( void );

