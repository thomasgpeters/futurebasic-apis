/*
 Graphics.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef void (*CUI_AnimationEffectCallbackType)(void *);

@interface CUI_AnimationEffectDelegate : NSObject
@property (nonatomic,assign) CUI_AnimationEffectCallbackType callback;
@end

// Rectangles
void nsFrameRect( CGRect r );
void nsFrameRectWithWidth( CGRect r, CGFloat frameWidth );
void nsFrameRectWithWidthUsingOperation( CGRect r, CGFloat frameWidth, NSCompositingOperation operation );
void nsEraseRect( CGRect r );
void nsRectFill( CGRect r );
void nsRectFillUsingOperation( CGRect r, NSCompositingOperation operation );
void nsRectFillList( CGRect *rects, NSInteger count );
void nsRectFillListUsingOperation( CGRect *rects, NSInteger count, NSCompositingOperation op );
void nsRectFillListWithColors( CGRect *rects, NSColor **cols, NSInteger count );
void nsRectFillListWithColorsUsingOperation( CGRect *rects, NSColor **cols, NSInteger count, NSCompositingOperation op );
void nsRectFillListWithGrays( CGRect *rects, CGFloat *grays, NSInteger count );
void nsDrawTiledRects( CGRect boundsRect, CGRect clipRect, NSRectEdge *sides, CGFloat *grays, NSInteger count );
void nsDrawGroove( CGRect rect, CGRect clipRect );

// Bezels
void nsDrawDarkBezel( CGRect rect, CGRect clipRect );
void nsDrawGrayBezel( CGRect rect, CGRect clipRect );
void nsDrawLightBezel( CGRect rect, CGRect clipRect );
void nsDrawWhiteBezel( CGRect rect, CGRect clipRect );

// Backgrounds
void nsDrawButton( CGRect rect, CGRect clipRect );
void nsDrawWindowBackground( CGRect rect );

// Clipping rects
void nsRectClip( CGRect rect );
void nsRectClipList( CGRect *rects, NSInteger count );

// Window depth
NSWindowDepth nsBestDepth( CFStringRef colorSpaceName, NSInteger bps, NSInteger bpp, BOOL planar, BOOL *exactMatch );
CFStringRef nsColorSpaceFromDepth( NSWindowDepth depth );
NSInteger nsNumberOfColorComponents( CFStringRef colorSpaceName );

// System animations
void nsShowAnimationEffect( NSAnimationEffect animationEffect, CGPoint centerLocation, CGSize size, CUI_AnimationEffectCallbackType didEndCallback, void *contextInfo );

