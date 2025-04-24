/*
 Graphics.m

 Bernie Wylde
 */

#import "Graphics.h"

@implementation CUI_AnimationEffectDelegate

- (void)animationEffectDidEnd:(void *)contextInfo {
    if ( self.callback ) (*self.callback)(contextInfo);
}
@end

// Rectangles
void nsFrameRect( CGRect r )
{ NSFrameRect( NSRectFromCGRect(r)); }

void nsFrameRectWithWidth( CGRect r, CGFloat frameWidth )
{ NSFrameRectWithWidth( NSRectFromCGRect(r), frameWidth ); }

void nsFrameRectWithWidthUsingOperation( CGRect r, CGFloat frameWidth, NSCompositingOperation operation )
{ NSFrameRectWithWidthUsingOperation( NSRectFromCGRect(r), frameWidth, operation ); }

void nsEraseRect( CGRect r )
{ NSEraseRect( NSRectFromCGRect(r)); }

void nsRectFill( CGRect r )
{ NSRectFill( NSRectFromCGRect(r)); }

void nsRectFillUsingOperation( CGRect r, NSCompositingOperation operation )
{ NSRectFillUsingOperation( NSRectFromCGRect(r), operation ); }

void nsRectFillList( CGRect *rects, NSInteger count )
{ NSRectFillList( (NSRect *)rects, count ); }

void nsRectFillListUsingOperation( CGRect *rects, NSInteger count, NSCompositingOperation op )
{ NSRectFillListUsingOperation( (NSRect *)rects, count, op ); }

void nsRectFillListWithColors( CGRect *rects, NSColor **cols, NSInteger count )
{ NSRectFillListWithColors( (NSRect *)rects, cols, count ); }

void nsRectFillListWithColorsUsingOperation( CGRect *rects, NSColor **cols, NSInteger count, NSCompositingOperation op )
{ NSRectFillListWithColorsUsingOperation( (NSRect *)rects, cols, count, op ); }

void nsRectFillListWithGrays( CGRect *rects, CGFloat *grays, NSInteger count )
{ NSRectFillListWithGrays( (NSRect *)rects, grays, count ); }

void nsDrawTiledRects( CGRect boundsRect, CGRect clipRect, NSRectEdge *sides, CGFloat *grays, NSInteger count )
{
    NSDrawTiledRects( NSRectFromCGRect(boundsRect), NSRectFromCGRect(clipRect), sides, grays, count );
    
}

void nsDrawGroove( CGRect rect, CGRect clipRect )
{ NSDrawGroove( NSRectFromCGRect(rect), NSRectFromCGRect(clipRect) ); }

// Bezels
void nsDrawDarkBezel( CGRect rect, CGRect clipRect )
{ NSDrawDarkBezel( NSRectFromCGRect(rect), NSRectFromCGRect(clipRect) ); }

void nsDrawGrayBezel( CGRect rect, CGRect clipRect )
{ NSDrawGrayBezel( NSRectFromCGRect(rect), NSRectFromCGRect(clipRect) ); }

void nsDrawLightBezel( CGRect rect, CGRect clipRect )
{ NSDrawLightBezel( NSRectFromCGRect(rect), NSRectFromCGRect(clipRect) ); }

void nsDrawWhiteBezel( CGRect rect, CGRect clipRect )
{ NSDrawWhiteBezel( NSRectFromCGRect(rect), NSRectFromCGRect(clipRect) ); }

// Backgrounds
void nsDrawButton( CGRect rect, CGRect clipRect )
{ NSDrawButton( NSRectFromCGRect(rect), NSRectFromCGRect(clipRect) ); }

void nsDrawWindowBackground( CGRect rect )
{ NSDrawWindowBackground( NSRectFromCGRect(rect) ); }

// Clipping rects
void nsRectClip( CGRect rect )
{ NSRectClip( NSRectFromCGRect(rect) ); }

void nsRectClipList( CGRect *rects, NSInteger count )
{ NSRectClipList( (NSRect *)rects, count ); }

// Window depth
NSWindowDepth nsBestDepth( CFStringRef colorSpaceName, NSInteger bps, NSInteger bpp, BOOL planar, BOOL *exactMatch )
{ return NSBestDepth( (__bridge NSString *)colorSpaceName, bps, bpp, planar, (BOOL *)exactMatch); }

CFStringRef nsColorSpaceFromDepth( NSWindowDepth depth )
{ return (__bridge CFStringRef)NSColorSpaceFromDepth( depth ); }

NSInteger nsNumberOfColorComponents( CFStringRef colorSpaceName )
{ return NSNumberOfColorComponents( (__bridge NSString *)colorSpaceName ); }

void nsShowAnimationEffect( NSAnimationEffect animationEffect, CGPoint centerLocation, CGSize size, CUI_AnimationEffectCallbackType didEndCallback, void *contextInfo )
{
    CUI_AnimationEffectDelegate *delegate = nil;
    if ( didEndCallback )  {
        delegate = [[CUI_AnimationEffectDelegate alloc] init];
        [delegate setCallback:didEndCallback];
    }
    NSShowAnimationEffect( animationEffect, NSPointFromCGPoint(centerLocation), NSSizeFromCGSize(size), delegate, @selector(animationEffectDidEnd:), contextInfo );
}

