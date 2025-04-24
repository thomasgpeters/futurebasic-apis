/*
 Gradient.m

 Bernie Wylde
 */

#import "Gradient.h"

// Class
Class GradientClass( void )
{ return [NSGradient class]; }

// Init
NSGradient *GradientWithStartEndColors( NSColor *startColor, NSColor *endColor )
{
#if __has_feature(objc_arc)
    return [[NSGradient alloc] initWithStartingColor:startColor endingColor:endColor];
#else
    return [[[NSGradient alloc] initWithStartingColor:startColor endingColor:endColor] autorelease];
#endif
}

NSGradient *GradientWithColors( CFArrayRef colors )
{
#if __has_feature(objc_arc)
    return [[NSGradient alloc] initWithColors:(__bridge NSArray *)colors];
#else
    return [[[NSGradient alloc] initWithColors:(__bridge NSArray *)colors] autorelease];
#endif
}

NSGradient *GradientWithColorsAndLocations( NSColor *firstColor, ... )
{
    va_list ap;
    va_start(ap,firstColor);

    NSMutableArray *colors = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *locations = [NSMutableArray arrayWithCapacity:0];
    NSColor *color = firstColor;
    while ( color ) {
        [colors addObject:color];
        double location = va_arg( ap, double );
        [locations addObject:[NSNumber numberWithDouble:location]];
        color = va_arg( ap, id );
    }

    va_end(ap);

    NSUInteger count = [locations count];
    if ( count == 0 ) return nil;
//    double locs[count];
    
    double *locs = malloc(count * sizeof(double));
    if ( !locs ) return nil;
    
    NSUInteger index = 0;
    for ( NSNumber *number in locations ) {
        locs[index] = [number doubleValue];
        index++;
    }
    
#if __has_feature(objc_arc)
    NSGradient *gradient = [[NSGradient alloc] initWithColors:colors atLocations:(CGFloat *)locs colorSpace:[NSColorSpace genericRGBColorSpace]];
#else
    NSGradient *gradient =  [[[NSGradient alloc] initWithColors:colors atLocations:(CGFloat *)locs colorSpace:[NSColorSpace genericRGBColorSpace]] autorelease];
#endif
    
    free(locs);
    
    return gradient;
}

NSGradient *GradientWithColorsAtLocations( CFArrayRef colors, CGFloat *locations, NSColorSpace *cs )
{
#if __has_feature(objc_arc)
    return [[NSGradient alloc] initWithColors:(__bridge NSArray *)colors atLocations:locations colorSpace:cs];
#else
    return [[[NSGradient alloc] initWithColors:(__bridge NSArray *)colors atLocations:locations colorSpace:cs] autorelease];
#endif
}

// Primitive
void GradientDrawFromPoint( NSGradient *ref, CGPoint pt1, CGPoint pt2, NSGradientDrawingOptions options )
{ [ref drawFromPoint:NSPointFromCGPoint(pt1) toPoint:NSPointFromCGPoint(pt2) options:options]; }

void GradientDrawFromCenter( NSGradient *ref, CGPoint startCenter, CGFloat startRadius, CGPoint endCenter, CGFloat endRadius, NSGradientDrawingOptions options )
{ [ref drawFromCenter:NSPointFromCGPoint(startCenter) radius:startRadius toCenter:NSPointFromCGPoint(endCenter) radius:endRadius options:options]; }

// Linear
void GradientDrawInRect( NSGradient *ref, CGRect rect, CGFloat angle )
{ [ref drawInRect:NSRectFromCGRect(rect) angle:angle]; }

void GradientDrawInBezierPath( NSGradient *ref, NSBezierPath *path, CGFloat angle )
{ [ref drawInBezierPath:path angle:angle]; }

// Radial
void GradientDrawInRectRelativeCenterPosition( NSGradient *ref, CGRect rect, CGPoint position )
{ [ref drawInRect:NSRectFromCGRect(rect) relativeCenterPosition:NSPointFromCGPoint(position)]; }

void GradientDrawInBezierPathRelativeCenterPosition( NSGradient *ref, NSBezierPath *path, CGPoint position )
{ [ref drawInBezierPath:path relativeCenterPosition:NSPointFromCGPoint(position)]; }

// Properties
NSColorSpace *GradientColorSpace( NSGradient *ref )
{ return [ref colorSpace]; }

NSInteger GradientNumberOfColorStops( NSGradient *ref )
{ return [ref numberOfColorStops]; }

void GradientGetColor( NSGradient *ref, NSColor **col, CGFloat *location, NSInteger index )
{ [ref getColor:col location:location atIndex:index]; }

NSColor *GradientInterpolatedColorAtLocation( NSGradient *ref, CGFloat location )
{ return [ref interpolatedColorAtLocation:location]; }

// Convenience
void GradientDrawFromPointWithStartEndColors( CGPoint pt1, CGPoint pt2, NSColor *startColor, NSColor *endColor, NSGradientDrawingOptions options )
{
#if __has_feature(objc_arc)
    NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:startColor endingColor:endColor];
#else
    NSGradient *gradient = [[[NSGradient alloc] initWithStartingColor:startColor endingColor:endColor] autorelease];
#endif
    [gradient drawFromPoint:NSPointFromCGPoint(pt1) toPoint:NSPointFromCGPoint(pt2) options:options];
}

void GradientDrawFromCenterWithStartEndColors( CGPoint startCenter, CGFloat startRadius, CGPoint endCenter, CGFloat endRadius, NSColor *startColor, NSColor *endColor, NSGradientDrawingOptions options )
{
#if __has_feature(objc_arc)
    NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:startColor endingColor:endColor];
#else
    NSGradient *gradient = [[[NSGradient alloc] initWithStartingColor:startColor endingColor:endColor] autorelease];
#endif
    [gradient drawFromCenter:NSPointFromCGPoint(startCenter) radius:startRadius toCenter:NSPointFromCGPoint(endCenter) radius:endRadius options:options];
}

void GradientDrawInRectWithStartEndColors( CGRect rect, CGFloat angle, NSColor *startColor, NSColor *endColor )
{
#if __has_feature(objc_arc)
    NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:startColor endingColor:endColor];
#else
    NSGradient *gradient = [[[NSGradient alloc] initWithStartingColor:startColor endingColor:endColor] autorelease];
#endif
    [gradient drawInRect:NSRectFromCGRect(rect) angle:angle];
}

void GradientDrawInBezierPathWithStartEndColors( NSBezierPath *path, CGFloat angle, NSColor *startColor, NSColor *endColor )
{
#if __has_feature(objc_arc)
    NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:startColor endingColor:endColor];
#else
    NSGradient *gradient = [[[NSGradient alloc] initWithStartingColor:startColor endingColor:endColor] autorelease];
#endif
    [gradient drawInBezierPath:path angle:angle];
}

void GradientDrawInRectRelativeCenterPositionWithStartEndColors( CGRect rect, CGPoint position, NSColor *startColor, NSColor *endColor )
{
#if __has_feature(objc_arc)
    NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:startColor endingColor:endColor];
#else
    NSGradient *gradient = [[[NSGradient alloc] initWithStartingColor:startColor endingColor:endColor] autorelease];
#endif
    [gradient drawInRect:NSRectFromCGRect(rect) relativeCenterPosition:NSPointFromCGPoint(position)];
}

void GradientDrawInBezierPathRelativeCenterPositionWithStartEndColors( NSBezierPath *path, CGPoint position, NSColor *startColor, NSColor *endColor )
{
#if __has_feature(objc_arc)
    NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:startColor endingColor:endColor];
#else
    NSGradient *gradient = [[[NSGradient alloc] initWithStartingColor:startColor endingColor:endColor] autorelease];
#endif
    [gradient drawInBezierPath:path relativeCenterPosition:NSPointFromCGPoint(position)];
}

