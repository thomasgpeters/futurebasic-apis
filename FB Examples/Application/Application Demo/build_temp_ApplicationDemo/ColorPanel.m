/*
 ColorPanel.m

 Bernie Wylde
 */

#import "ColorPanel.h"

static CUI_ColorPanelTarget *sCUI_ColorPanelTarget;

@implementation CUI_ColorPanelTarget

- (id)initWithCallback:(CUI_ColorPanelCallbackType)cb userData:(void *)ud {
    if ( (self = [super init]) ) {
        self.callback = cb;
        self.userData = ud;
    }
    return self;
}

- (void)action:(id)sender {
    if ( self.callback ) {
        (*self.callback)([sender color],self.userData);
    } else {
        NSColor *col = [[NSColorPanel sharedColorPanel] color];
        DialogEventSetColor( col );
        CallUserDefinedOnDialogFunction( colorPanelChangeColor, 0, 0, (__bridge CFTypeRef)col );
    }
}
@end


void CUI_ColorPanelSetTarget( void )
{
    if ( !sCUI_ColorPanelTarget ) {
        sCUI_ColorPanelTarget = [[CUI_ColorPanelTarget alloc] init];
        NSColorPanel *cp = [NSColorPanel sharedColorPanel];
        [cp setTarget:sCUI_ColorPanelTarget];
        [cp setAction:@selector(action:)];
    }
}

// Class
Class ColorPanelClass( void )
{ return [NSColorPanel class]; }

// - shared color panel -
NSColorPanel *ColorPanelShared( void )
{ return [NSColorPanel sharedColorPanel]; }

// - configure -
NSView *ColorPanelAccessoryView( void )
{ return [[NSColorPanel sharedColorPanel] accessoryView]; }

void ColorPanelSetAccessoryView( NSView *ref )
{ [[NSColorPanel sharedColorPanel] setAccessoryView:ref]; }

BOOL ColorPanelIsContinuous( void )
{ return [[NSColorPanel sharedColorPanel] isContinuous]; }

void ColorPanelSetContinuous( BOOL flag )
{
    [[NSColorPanel sharedColorPanel] setContinuous:flag];
    CUI_ColorPanelSetTarget();
}

NSColorPanelMode ColorPanelMode( void )
{ return [[NSColorPanel sharedColorPanel] mode]; }

void ColorPanelSetMode( NSColorPanelMode mode )
{
    [[NSColorPanel sharedColorPanel] setMode:mode];
    CUI_ColorPanelSetTarget();
}

void ColorPanelSetActionCallback( CUI_ColorPanelCallbackType callback, void *userData )
{
#if __has_feature(objc_arc)
    CUI_ColorPanelTarget *target = [[CUI_ColorPanelTarget alloc] initWithCallback:callback userData:userData];
#else
    CUI_ColorPanelTarget *target = [[[CUI_ColorPanelTarget alloc] initWithCallback:callback userData:userData] autorelease];
#endif
    [[NSColorPanel sharedColorPanel] setTarget:target];
    [[NSColorPanel sharedColorPanel] setAction:@selector(action:)];
}

BOOL ColorPanelShowsAlpha( void )
{ return [[NSColorPanel sharedColorPanel] showsAlpha]; }

void ColorPanelSetShowsAlpha( BOOL flag )
{
    [[NSColorPanel sharedColorPanel] setShowsAlpha:flag];
    CUI_ColorPanelSetTarget();
}

// Color lists
void ColorPanelAttachColorList( NSColorList *cl )
{ [[NSColorPanel sharedColorPanel] attachColorList:cl]; }

void ColorPanelDetachColorList( NSColorList *cl )
{ [[NSColorPanel sharedColorPanel] detachColorList:cl]; }

// - picker modes
void ColorPanelSetPickerMode( NSInteger mode )
{
    [NSColorPanel setPickerMode:mode];
    CUI_ColorPanelSetTarget();
}

void ColorPanelSetPickerMask( NSColorPanelOptions mask )
{
    [NSColorPanel setPickerMask:mask];
    CUI_ColorPanelSetTarget();
}

// - setting color -
NSColor *ColorPanelColor( void )
{ return [[NSColorPanel sharedColorPanel] color]; }

void ColorPanelSetColor( NSColor *col )
{
    [[NSColorPanel sharedColorPanel] setColor:col];
    CUI_ColorPanelSetTarget();
}

BOOL ColorPanelDragColor( NSColor *col, NSEvent *event, NSInteger fromView )
{
    NSView *view = CUI_ViewWithTag( fromView );
    if ( view ) return [NSColorPanel dragColor:col withEvent:event fromView:view];
    return NO;
}

// - color info -
CGFloat ColorPanelAlpha( void )
{ return [[NSColorPanel sharedColorPanel] alpha]; }


#pragma mark - Convenience
void ColorPanelShow( void )
{
    [[NSColorPanel sharedColorPanel] makeKeyAndOrderFront:nil];
    CUI_ColorPanelSetTarget();
}

void ColorPanelClose( void )
{
    if ( [[NSColorPanel sharedColorPanel] isVisible] ) {
        [[NSColorPanel sharedColorPanel] orderOut:nil];
    }
}

BOOL ColorPanelIsVisible( void )
{ return [[NSColorPanel sharedColorPanel] isVisible]; }

