/*
 CALayer.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

// dialog events
enum {
    caLayerDisplay = 2500,
    caLayerDraw,
    caLayerWillDraw,
    caLayerLayoutSublayers,
    caLayerAction
};

@interface CUI_CALayerDelegate : NSObject <CALayerDelegate>
@end
CUI_CALayerDelegate *CUI_CALayerDelegateObj( void );

// - create -
CALayer *CALayerInit( void );

// Related layer objects
CALayer *CALayerPresentationLayer( CALayer *ref );
CALayer *CALayerModelLayer( CALayer *ref );

// - delegate -
id<CALayerDelegate> CALayerDelegate( CALayer *layer );
void CALayerInstallDelegate( CALayer *layer );

// - content -
void *CALayerContents( CALayer *layer );
void CALayerSetContents( CALayer *layer, void *contents );
CGRect CALayerContentsRect( CALayer *layer );
void CALayerSetContentsRect( CALayer *layer, CGRect r );
CGRect CALayerContentsCenter( CALayer *layer );
void CALayerSetContentsCenter( CALayer *layer, CGRect r );
void CALayerDisplay( CALayer *ref );
void CALayerDrawInContext( CALayer *ref, CGContextRef ctx );

// - appearance -
CFStringRef caLayerContentsGravity( CALayer *layer );
void CALayerSetContentsGravity( CALayer *layer, CFStringRef gravity );

float CALayerOpacity( CALayer *layer );
void CALayerSetOpacity( CALayer *layer, float opacity );
BOOL CALayerIsHidden( CALayer *layer );
void CALayerSetHidden( CALayer *layer, BOOL flag );

BOOL CALayerMasksToBounds( CALayer *layer );
void CALayerSetMasksToBounds( CALayer *layer, BOOL flag );
CALayer *CALayerMask( CALayer *layer );
void CALayerSetMask( CALayer *layer, CALayer *mask );
BOOL CALayerIsDoubleSided( CALayer *layer );
void CALayerSetDoubleSided( CALayer *layer, BOOL flag );

CGFloat CALayerCornerRadius( CALayer *layer );
void CALayerSetCornerRadius( CALayer *layer, CGFloat radius );

CACornerMask CALayerMaskedCorners( CALayer *layer );
void CALayerSetMaskedCorners( CALayer *layer, CACornerMask mask );

CGFloat CALayerBorderWidth( CALayer *layer );
void CALayerSetBorderWidth( CALayer *layer, CGFloat width );

NSColor *CALayerBorderColor( CALayer *layer );
void CALayerSetBorderColor( CALayer *layer, NSColor *col );

NSColor *CALayerBackgroundColor( CALayer *layer );
void CALayerSetBackgroundColor( CALayer *layer, NSColor *col );

float CALayerShadowOpacity( CALayer *layer );
void CALayerSetShadowOpacity( CALayer *layer, float opacity );
CGFloat CALayerShadowRadius( CALayer *layer );
void CALayerSetShadowRadius( CALayer *layer, CGFloat radius );
CGSize CALayerShadowOffset( CALayer *layer );
void CALayerSetShadowOffset( CALayer *layer, CGSize offset );

NSColor *CALayerShadowColor( CALayer *layer );
void CALayerSetShadowColor( CALayer *layer, NSColor *col );

CGPathRef CALayerShadowPath( CALayer *layer );
NSBezierPath *CALayerShadowBezierPath( CALayer *layer );
void CALayerSetShadowPath( CALayer *layer, CFTypeRef path );
CFDictionaryRef CALayerStyle( CALayer *layer );
void CALayerSetStyle( CALayer *layer, CFDictionaryRef style );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
BOOL CALayerAllowsEdgeAntialiasing( CALayer *ref );
API_AVAILABLE(macos(10.14))
void CALayerSetAllowsEdgeAntialiasing( CALayer *ref, BOOL flag );
API_AVAILABLE(macos(10.14))
BOOL CALayerAllowsGroupOpacity( CALayer *ref );
API_AVAILABLE(macos(10.14))
void CALayerSetAllowsGroupOpacity( CALayer *ref, BOOL flag );
#endif// 101400

// Filters
CFArrayRef CALayerFilters( CALayer *ref );
void CALayerSetFilters( CALayer *ref, CFArrayRef filters );
CFTypeRef CALayerCompositingFilter( CALayer *ref );
void CALayerSetCompositingFilter( CALayer *ref, CFTypeRef filter );
CFArrayRef CALayerBackgroundFilters( CALayer *ref );
void CALayerSetBackgroundFilters( CALayer *ref, CFArrayRef filters );
CFStringRef CALayerMinificationFilter( CALayer *ref );
void CALayerSetMinificationFilter( CALayer *ref, CFStringRef filter );
float CALayerMinificationFilterBias( CALayer *ref );
void CALayerSetMinificationFilterBias( CALayer *ref, float bias );
CFStringRef CALayerMagnificationFilter( CALayer *ref );
void CALayerSetMagnificationFilter( CALayer *ref, CFStringRef filter );

// - rendering behavior -
BOOL CALayerIsOpaque( CALayer *layer );
void CALayerSetOpaque( CALayer *layer, BOOL flag );
CAEdgeAntialiasingMask CALayerEdgeAntialisingMask( CALayer *ref );
void CALayerSetEdgeAntialisingMask( CALayer *ref, CAEdgeAntialiasingMask mask );
BOOL CALayerContentsAreFlipped( CALayer *layer );
BOOL CALayerDrawsAsynchronously( CALayer *layer );
void CALayerSetDrawsAsynchronously( CALayer *layer, BOOL flag );
BOOL CALayerShouldRasterize( CALayer *layer );
void CALayerSetShouldRasterize( CALayer *layer, BOOL flag );
CGFloat CALayerRasterizationScale( CALayer *layer );
void CALayerSetRasterizationScale( CALayer *layer, CGFloat scale );
CFStringRef caLayerContentsFormat( CALayer *layer );
void CALayerSetContentsFormat( CALayer *layer, CFStringRef format );
void CALayerRenderInContext( CALayer *layer, CGContextRef ctx );

// - geometry -
CGRect CALayerFrame( CALayer *layer );
void CALayerSetFrame( CALayer *layer, CGRect frame );
CGRect CALayerBounds( CALayer *layer );
void CALayerSetBounds( CALayer *layer, CGRect bounds );
CGPoint CALayerPosition( CALayer *layer );
void CALayerSetPosition( CALayer *layer, CGPoint pt );
CGFloat CALayerZPosition( CALayer *layer );
void CALayerSetZPosition( CALayer *layer, CGFloat position );
CGFloat CALayerAnchorPointZ( CALayer *layer );
void CALayerSetAnchorPointZ( CALayer *layer, CGFloat position );
CGPoint CALayerAnchorPoint( CALayer *layer );
void CALayerSetAnchorPoint( CALayer *layer, CGPoint pt );
CGFloat CALayerContentsScale( CALayer *layer );
void CALayerSetContentsScale( CALayer *layer, CGFloat scale );

// - transform -
CATransform3D CALayerTransform( CALayer *layer );
void CALayerSetTransform( CALayer *layer, CATransform3D t );
CATransform3D CALayerSublayerTransform( CALayer *layer );
void CALayerSetSublayerTransform( CALayer *layer, CATransform3D t );
CGAffineTransform CALayerAffineTransform( CALayer *layer );
void CALayerSetAffineTransform( CALayer *layer, CGAffineTransform t );

// - hierarchy -
CFArrayRef CALayerSublayers( CALayer *layer );
void CALayerSetSublayers( CALayer *layer, CFArrayRef sublayers );
CALayer *CALayerSuperlayer( CALayer *layer );
void CALayerAddSublayer( CALayer *layer, CALayer *sublayer );
void CALayerRemoveFromSuperlayer( CALayer *layer );
void CALayerInsertSublayer( CALayer *layer, CALayer *otherLayer, unsigned int index );
void CALayerInsertSublayerBelow( CALayer *layer, CALayer *subLayer, CALayer *sibling );
void CALayerInsertSublayerAbove( CALayer *layer, CALayer *subLayer, CALayer *sibling );
void CALayerReplaceSublayer( CALayer *layer, CALayer *subLayer, CALayer *otherLayer );

// - display -
void CALayerSetNeedsDisplay( CALayer *layer );
void CALayerSetNeedsDisplayInRect( CALayer *ref, CGRect r );
BOOL CALayerNeedsDisplay( CALayer *ref );

// Animations
void CALayerAddAnimation( CALayer *layer, CAAnimation *anim, CFStringRef key );
CAAnimation *CALayerAnimation( CALayer *layer, CFStringRef key );
void CALayerRemoveAllAnimations( CALayer *layer );
void CALayerRemoveAnimation( CALayer *layer, CFStringRef key );
CFArrayRef CALayerAnimationKeys( CALayer *layer );

// - resizing and layout -
unsigned int CALayerAutoresizingMask( CALayer *layer );
void CALayerSetAutoresizingMask( CALayer *layer, unsigned int mask );

// - constraints -

// - actions -

// - mapping between coordinate and time spaces -

// - hit testing -
CALayer *CALayerHitTest( CALayer *layer, CGPoint pt );
BOOL CALayerContainsPoint( CALayer *layer, CGPoint pt );

// - scrolling -
CGRect CALayerVisibleRect( CALayer *layer );
void CALayerScrollPoint( CALayer *layer, CGPoint pt );
void CALayerScrollRectToVisible( CALayer *layer, CGRect r );

// - identifying -
CFStringRef CALayerName( CALayer *layer );
void CALayerSetName( CALayer *layer, CFStringRef name );

// - key-value coding extensions -

// - initializers -


// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
CALayerCornerCurve caLayerCornerCurve( CALayer *ref );
API_AVAILABLE(macos(10.15))
void CALayerSetCornerCurve( CALayer *ref, CALayerCornerCurve curve );
#endif// 101500
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
BOOL CALayerWantsExtendedDynamicRangeContent( CALayer *ref );
API_AVAILABLE(macos(14.0))
void CALayerSetWantsExtendedDynamicRangeContent( CALayer *ref, BOOL flag );
#endif// 140000
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
CAToneMapMode CALayerToneMapMode( CALayer *ref );
void CALayerSetToneMapMode( CALayer *ref, CAToneMapMode mode );
#endif// 150000

// Type methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
CGFloat CALayerCornerCurveExpansionFactor( CALayerCornerCurve curve );
#endif// 101500

