/*
 CALayer.m
 
 Bernie Wylde
 */

#import "CALayer.h"

#pragma mark - private
@implementation CUI_CALayerDelegate

//- (void)displayLayer:(CALayer *)layer {
//    CallUserDefinedOnDialogFunction( caLayerDisplay, 0, 0, layer );
//}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    DialogEventSetCGContext( ctx );
    CallUserDefinedOnDialogFunction( caLayerDraw, 0, 0, layer );
}

- (void)layerWillDraw:(CALayer *)layer {
    CallUserDefinedOnDialogFunction( caLayerWillDraw, 0, 0, layer );
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    CallUserDefinedOnDialogFunction( caLayerLayoutSublayers, 0, 0, layer );
}

- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
    DialogEventSetNSString( event );
    DialogEventSetCAAction( nil );
    CallUserDefinedOnDialogFunction( caLayerAction, 0, 0, layer );
    return DialogEventCAAction();
}
@end

CUI_CALayerDelegate *CUI_CALayerDelegateObj( void )
{
    static CUI_CALayerDelegate *sCUI_CALayerDelegate = nil;
    if ( !sCUI_CALayerDelegate ) sCUI_CALayerDelegate = [[CUI_CALayerDelegate alloc] init];
    return sCUI_CALayerDelegate;
}

#pragma mark - public
// - create -
CALayer *CALayerInit( void )
{ return [CALayer layer]; }

// Related layer objects
CALayer *CALayerPresentationLayer( CALayer *ref )
{ return [ref presentationLayer]; }

CALayer *CALayerModelLayer( CALayer *ref )
{ return [ref modelLayer]; }

// - delegate -
id<CALayerDelegate> CALayerDelegate( CALayer *layer )
{ return [layer delegate]; }

void CALayerInstallDelegate( CALayer *layer )
{
    CUI_CALayerDelegate *delegate = CUI_CALayerDelegateObj();
    [layer setDelegate:delegate];
}

// - content -
void *CALayerContents( CALayer *layer )
{ return (__bridge void *)[layer contents]; }

void CALayerSetContents( CALayer *layer, void *contents )
{ [layer setContents:(__bridge id)contents]; }

CGRect CALayerContentsRect( CALayer *layer )
{ return [layer contentsRect]; }

void CALayerSetContentsRect( CALayer *layer, CGRect r )
{ [layer setContentsRect:r]; }

CGRect CALayerContentsCenter( CALayer *layer )
{ return [layer contentsCenter]; }

void CALayerSetContentsCenter( CALayer *layer, CGRect r )
{ [layer setContentsCenter:r]; }

void CALayerDisplay( CALayer *ref )
{ [ref display]; }

void CALayerDrawInContext( CALayer *ref, CGContextRef ctx )
{ [ref drawInContext:ctx]; }

// - appearance -
CFStringRef caLayerContentsGravity( CALayer *layer )
{ return (__bridge CFStringRef)[layer contentsGravity]; }

void CALayerSetContentsGravity( CALayer *layer, CFStringRef gravity )
{ [layer setContentsGravity:(__bridge NSString *)gravity]; }

float CALayerOpacity( CALayer *layer )
{ return [layer opacity]; }

void CALayerSetOpacity( CALayer *layer, float opacity )
{ [layer setOpacity:opacity]; }

BOOL CALayerIsHidden( CALayer *layer )
{ return [layer isHidden]; }

void CALayerSetHidden( CALayer *layer, BOOL flag )
{ [layer setHidden:flag]; }

BOOL CALayerMasksToBounds( CALayer *layer )
{ return [layer masksToBounds]; }

void CALayerSetMasksToBounds( CALayer *layer, BOOL flag )
{ [layer setMasksToBounds:flag]; }

CALayer *CALayerMask( CALayer *layer )
{ return [layer mask]; }

void CALayerSetMask( CALayer *layer, CALayer *mask )
{ [layer setMask:mask]; }

BOOL CALayerIsDoubleSided( CALayer *layer )
{ return [layer isDoubleSided]; }

void CALayerSetDoubleSided( CALayer *layer, BOOL flag )
{ [layer setDoubleSided:flag]; }

NSColor *CALayerBorderColor( CALayer *layer )
{ return [NSColor colorWithCGColor:[layer borderColor]]; }

void CALayerSetBorderColor( CALayer *layer, NSColor *col )
{ [layer setBorderColor:[col CGColor]]; }

NSColor *CALayerBackgroundColor( CALayer *layer )
{ return [NSColor colorWithCGColor:[layer backgroundColor]]; }

void CALayerSetBackgroundColor( CALayer *layer, NSColor *col )
{ [layer setBackgroundColor:[col CGColor]]; }

CGFloat CALayerCornerRadius( CALayer *layer )
{ return [layer cornerRadius]; }

void CALayerSetCornerRadius( CALayer *layer, CGFloat radius )
{ [layer setCornerRadius:radius]; }

CACornerMask CALayerMaskedCorners( CALayer *layer )
{ return [layer maskedCorners]; }

void CALayerSetMaskedCorners( CALayer *layer, CACornerMask mask )
{ [layer setMaskedCorners:mask]; }

CGFloat CALayerBorderWidth( CALayer *layer )
{ return [layer borderWidth]; }

void CALayerSetBorderWidth( CALayer *layer, CGFloat width )
{ [layer setBorderWidth:width]; }

float CALayerShadowOpacity( CALayer *layer )
{ return [layer shadowOpacity]; }

void CALayerSetShadowOpacity( CALayer *layer, float opacity )
{ [layer setShadowOpacity:opacity]; }

CGFloat CALayerShadowRadius( CALayer *layer )
{ return [layer shadowRadius]; }

void CALayerSetShadowRadius( CALayer *layer, CGFloat radius )
{ [layer setShadowRadius:radius]; }

CGSize CALayerShadowOffset( CALayer *layer )
{ return [layer shadowOffset]; }

void CALayerSetShadowOffset( CALayer *layer, CGSize offset )
{ [layer setShadowOffset:offset]; }

NSColor *CALayerShadowColor( CALayer *layer )
{ return [NSColor colorWithCGColor:[layer shadowColor]]; }

void CALayerSetShadowColor( CALayer *layer, NSColor *col )
{ [layer setShadowColor:[col CGColor]]; }

CGPathRef CALayerShadowPath( CALayer *layer )
{ return [layer shadowPath]; }

NSBezierPath *CALayerShadowBezierPath( CALayer *layer )
{
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
    if ( @available( macOS 14.0, * ) ) {
        return [NSBezierPath bezierPathWithCGPath:[layer shadowPath]];
    } else {
        return CUI_BezierPathWithCGPath( [layer shadowPath] );
    }
#else// 140000
    return CUI_BezierPathWithCGPath( [layer shadowPath] );
#endif// 140000
}

void CALayerSetShadowPath( CALayer *layer, CFTypeRef path )
{
    if ( [(__bridge id)path isKindOfClass:[NSBezierPath class]] ) {
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
        if ( @available( macOS 14.0, * ) ) {
            [layer setShadowPath:[(__bridge NSBezierPath *)path CGPath]];
        } else {
            CGPathRef cgPath = CUI_BezierPathCGPath( (__bridge NSBezierPath *)path );
            if ( cgPath ) [layer setShadowPath:cgPath];
        }
#else
        CGPathRef cgPath = CUI_BezierPathCGPath( (__bridge NSBezierPath *)path );
        if ( cgPath ) [layer setShadowPath:cgPath];
#endif// 140000
    } else {
        if ( CFGetTypeID(path) == CGPathGetTypeID() ) {
            [layer setShadowPath:path];
        }
    }
}

CFDictionaryRef CALayerStyle( CALayer *layer )
{ return (__bridge CFDictionaryRef)[layer style]; }

void CALayerSetStyle( CALayer *layer, CFDictionaryRef style )
{ [layer setStyle:(__bridge NSDictionary *)style]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
BOOL CALayerAllowsEdgeAntialiasing( CALayer *ref )
{ return [ref allowsEdgeAntialiasing]; }

void CALayerSetAllowsEdgeAntialiasing( CALayer *ref, BOOL flag )
{ [ref setAllowsEdgeAntialiasing:flag]; }

BOOL CALayerAllowsGroupOpacity( CALayer *ref )
{ return [ref allowsGroupOpacity]; }

void CALayerSetAllowsGroupOpacity( CALayer *ref, BOOL flag )
{ [ref setAllowsGroupOpacity:flag]; }
#endif// 101400

// Filters
CFArrayRef CALayerFilters( CALayer *ref )
{ return (__bridge CFArrayRef)[ref filters]; }

void CALayerSetFilters( CALayer *ref, CFArrayRef filters )
{ [ref setFilters:(__bridge NSArray *)filters]; }

CFTypeRef CALayerCompositingFilter( CALayer *ref )
{ return (__bridge CFTypeRef)[ref compositingFilter]; }

void CALayerSetCompositingFilter( CALayer *ref, CFTypeRef filter )
{ [ref setCompositingFilter:(__bridge id)filter]; }

CFArrayRef CALayerBackgroundFilters( CALayer *ref )
{ return (__bridge CFArrayRef)[ref backgroundFilters]; }

void CALayerSetBackgroundFilters( CALayer *ref, CFArrayRef filters )
{ [ref setBackgroundFilters:(__bridge NSArray *)filters]; }

CFStringRef CALayerMinificationFilter( CALayer *ref )
{ return (__bridge CFStringRef)[ref minificationFilter]; }

void CALayerSetMinificationFilter( CALayer *ref, CFStringRef filter )
{ [ref setMinificationFilter:(__bridge NSString *)filter]; }

float CALayerMinificationFilterBias( CALayer *ref )
{ return [ref minificationFilterBias]; }

void CALayerSetMinificationFilterBias( CALayer *ref, float bias )
{ [ref setMinificationFilterBias:bias]; }

CFStringRef CALayerMagnificationFilter( CALayer *ref )
{ return (__bridge CFStringRef)[ref magnificationFilter]; }

void CALayerSetMagnificationFilter( CALayer *ref, CFStringRef filter )
{ [ref setMagnificationFilter:(__bridge NSString *)filter]; }

// - rendering behavior -
BOOL CALayerIsOpaque( CALayer *layer )
{ return [layer isOpaque]; }

void CALayerSetOpaque( CALayer *layer, BOOL flag )
{ [layer setOpaque:flag]; }

CAEdgeAntialiasingMask CALayerEdgeAntialisingMask( CALayer *ref )
{ return [ref edgeAntialiasingMask]; }

void CALayerSetEdgeAntialisingMask( CALayer *ref, CAEdgeAntialiasingMask mask )
{ [ref setEdgeAntialiasingMask:mask]; }

BOOL CALayerContentsAreFlipped( CALayer *layer )
{ return [layer contentsAreFlipped]; }

BOOL CALayerDrawsAsynchronously( CALayer *layer )
{ return [layer drawsAsynchronously]; }

void CALayerSetDrawsAsynchronously( CALayer *layer, BOOL flag )
{ [layer setDrawsAsynchronously:flag]; }

BOOL CALayerShouldRasterize( CALayer *layer )
{ return [layer shouldRasterize]; }

void CALayerSetShouldRasterize( CALayer *layer, BOOL flag )
{ [layer setShouldRasterize:flag]; }

CGFloat CALayerRasterizationScale( CALayer *layer )
{ return [layer rasterizationScale]; }

void CALayerSetRasterizationScale( CALayer *layer, CGFloat scale )
{ [layer setRasterizationScale:scale]; }

CFStringRef caLayerContentsFormat( CALayer *layer )
{ return (__bridge CFStringRef)[layer contentsFormat]; }

void CALayerSetContentsFormat( CALayer *layer, CFStringRef format )
{ [layer setContentsFormat:(__bridge NSString *)format]; }

void CALayerRenderInContext( CALayer *layer, CGContextRef ctx )
{ [layer renderInContext:ctx]; }

// - geometry -
CGRect CALayerFrame( CALayer *layer )
{ return [layer frame]; }

void CALayerSetFrame( CALayer *layer, CGRect frame )
{ [layer setFrame:frame]; }

CGRect CALayerBounds( CALayer *layer )
{ return [layer bounds]; }

void CALayerSetBounds( CALayer *layer, CGRect bounds )
{ [layer setBounds:bounds]; }

CGPoint CALayerPosition( CALayer *layer )
{ return [layer position]; }

void CALayerSetPosition( CALayer *layer, CGPoint pt )
{ [layer setPosition:pt]; }

CGFloat CALayerZPosition( CALayer *layer )
{ return [layer zPosition]; }

void CALayerSetZPosition( CALayer *layer, CGFloat position )
{ [layer setZPosition:position]; }

CGFloat CALayerAnchorPointZ( CALayer *layer )
{ return [layer anchorPointZ]; }

void CALayerSetAnchorPointZ( CALayer *layer, CGFloat position )
{ [layer setAnchorPointZ:position]; }

CGPoint CALayerAnchorPoint( CALayer *layer )
{ return [layer anchorPoint]; }

void CALayerSetAnchorPoint( CALayer *layer, CGPoint pt )
{ [layer setAnchorPoint:pt]; }

CGFloat CALayerContentsScale( CALayer *layer )
{ return [layer contentsScale]; }

void CALayerSetContentsScale( CALayer *layer, CGFloat scale )
{ [layer setContentsScale:scale]; }

// - transform -
CATransform3D CALayerTransform( CALayer *layer )
{ return [layer transform]; }

void CALayerSetTransform( CALayer *layer, CATransform3D t )
{ [layer setTransform:t]; }

CATransform3D CALayerSublayerTransform( CALayer *layer )
{ return [layer sublayerTransform]; }

void CALayerSetSublayerTransform( CALayer *layer, CATransform3D t )
{ [layer setSublayerTransform:t]; }

CGAffineTransform CALayerAffineTransform( CALayer *layer )
{ return [layer affineTransform]; }

void CALayerSetAffineTransform( CALayer *layer, CGAffineTransform t )
{ [layer setAffineTransform:t]; }

// - hierarchy -
CFArrayRef CALayerSublayers( CALayer *layer )
{ return (__bridge CFArrayRef)[layer sublayers]; }

void CALayerSetSublayers( CALayer *layer, CFArrayRef sublayers )
{ [layer setSublayers:(__bridge NSArray *)sublayers]; }

CALayer *CALayerSuperlayer( CALayer *layer )
{ return [layer superlayer]; }

void CALayerAddSublayer( CALayer *layer, CALayer *sublayer )
{ [layer addSublayer:sublayer]; }

void CALayerRemoveFromSuperlayer( CALayer *layer )
{ [layer removeFromSuperlayer]; }

void CALayerInsertSublayer( CALayer *layer, CALayer *otherLayer, unsigned int index )
{ [layer insertSublayer:otherLayer atIndex:index]; }

void CALayerInsertSublayerBelow( CALayer *layer, CALayer *subLayer, CALayer *sibling )
{ [layer insertSublayer:subLayer below:sibling]; }

void CALayerInsertSublayerAbove( CALayer *layer, CALayer *subLayer, CALayer *sibling )
{ [layer insertSublayer:subLayer above:sibling]; }

void CALayerReplaceSublayer( CALayer *layer, CALayer *subLayer, CALayer *otherLayer )
{ [layer replaceSublayer:subLayer with:otherLayer]; }

// - display -
void CALayerSetNeedsDisplay( CALayer *layer )
{ [layer setNeedsDisplay]; }

void CALayerSetNeedsDisplayInRect( CALayer *ref, CGRect r )
{ [ref setNeedsDisplayInRect:r]; }

BOOL CALayerNeedsDisplay( CALayer *ref )
{ return [ref needsDisplay]; }

// Animations
void CALayerAddAnimation( CALayer *layer, CAAnimation *anim, CFStringRef key )
{ [layer addAnimation:anim forKey:(__bridge NSString *)key]; }

CAAnimation *CALayerAnimation( CALayer *layer, CFStringRef key )
{ return [layer animationForKey:(__bridge NSString *)key]; }

void CALayerRemoveAllAnimations( CALayer *layer )
{ [layer removeAllAnimations]; }

void CALayerRemoveAnimation( CALayer *layer, CFStringRef key )
{ [layer removeAnimationForKey:(__bridge NSString *)key]; }

CFArrayRef CALayerAnimationKeys( CALayer *layer )
{ return (__bridge CFArrayRef)[layer animationKeys]; }

// - resizing and layout -
unsigned int CALayerAutoresizingMask( CALayer *layer )
{ return [layer autoresizingMask]; }

void CALayerSetAutoresizingMask( CALayer *layer, unsigned int mask )
{ [layer setAutoresizingMask:mask]; }

// - constraints -

// - actions -

// - mapping between coordinate and time spaces -

// - hit testing -
CALayer *CALayerHitTest( CALayer *layer, CGPoint pt )
{ return [layer hitTest:pt]; }

BOOL CALayerContainsPoint( CALayer *layer, CGPoint pt )
{ return [layer containsPoint:pt]; }

// - scrolling -
CGRect CALayerVisibleRect( CALayer *layer )
{ return [layer visibleRect]; }

void CALayerScrollPoint( CALayer *layer, CGPoint pt )
{ [layer scrollPoint:pt]; }

void CALayerScrollRectToVisible( CALayer *layer, CGRect r )
{ [layer scrollRectToVisible:r]; }

// - identifying -
CFStringRef CALayerName( CALayer *layer )
{ return (__bridge CFStringRef)[layer name]; }

void CALayerSetName( CALayer *layer, CFStringRef name )
{ [layer setName:(__bridge NSString *)name]; }

// - key-value coding extensions -

// - initializers -

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
CALayerCornerCurve caLayerCornerCurve( CALayer *ref )
{ return [ref cornerCurve]; }

void CALayerSetCornerCurve( CALayer *ref, CALayerCornerCurve curve )
{ [ref setCornerCurve:curve]; }
#endif// 101500

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
BOOL CALayerWantsExtendedDynamicRangeContent( CALayer *ref )
{ return [ref wantsExtendedDynamicRangeContent]; }

void CALayerSetWantsExtendedDynamicRangeContent( CALayer *ref, BOOL flag )
{ [ref setWantsExtendedDynamicRangeContent:flag]; }
#endif// 140000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
CAToneMapMode CALayerToneMapMode( CALayer *ref )
{ return [ref toneMapMode]; }

void CALayerSetToneMapMode( CALayer *ref, CAToneMapMode mode )
{ [ref setToneMapMode:mode]; }
#endif// 150000

// Type methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
CGFloat CALayerCornerCurveExpansionFactor( CALayerCornerCurve curve )
{ return [CALayer cornerCurveExpansionFactor:curve]; }
#endif// 101500


