/*
 CAGradientLayer.m
 
 Bernie Wylde
 */

#import "CAGradientLayer.h"

// - init -
CAGradientLayer *CAGradientLayerInit( void )
{ return [CAGradientLayer layer]; }

// - style -
CFArrayRef CAGradientLayerColors( CAGradientLayer *layer )
{
    NSArray *cgColors = [layer colors];
    NSMutableArray *nsColors = [NSMutableArray arrayWithCapacity:0];
    for ( NSUInteger index = 0; index < [cgColors count]; index++ ) {
        CGColorRef col = (__bridge CGColorRef)[cgColors objectAtIndex:index];
        [nsColors addObject:[NSColor colorWithCGColor:col]];
    }
    return (__bridge CFArrayRef)nsColors;
}

void CAGradientLayerSetColors( CAGradientLayer *layer, CFArrayRef cols )
{
    NSMutableArray *cgColors = [NSMutableArray arrayWithCapacity:0];
    for ( NSColor *col in (__bridge NSArray *)cols ) {
        [cgColors addObject:(id)[col CGColor]];
    }
    [layer setColors:(NSArray *)cgColors];
}

CFArrayRef CAGradientLayerLocations( CAGradientLayer *layer )
{ return (__bridge CFArrayRef)[layer locations]; }

void CAGradientLayerSetLocations( CAGradientLayer *layer, CFArrayRef locations )
{ [layer setLocations:(__bridge NSArray *)locations]; }

CGPoint CAGradientEndPoint( CAGradientLayer *layer )
{ return [layer endPoint]; }

void CAGradientLayerSetEndPoint( CAGradientLayer *layer, CGPoint pt )
{ [layer setEndPoint:pt]; }

CGPoint CAGradientStartPoint( CAGradientLayer *layer )
{ return [layer startPoint]; }

void CAGradientLayerSetStartPoint( CAGradientLayer *layer, CGPoint pt )
{ [layer setStartPoint:pt]; }

CFStringRef CAGradientType( CAGradientLayer *layer )
{ return (__bridge CFStringRef)[layer type]; }

void CAGradientLayerSetType( CAGradientLayer *layer, CFStringRef type )
{ [layer setType:(__bridge NSString *)type]; }

// - convenience -
//CAGradientLayer *CAGradientLayerWithStartEndColors( CGRect r, NSColor *startColor, CGPoint startPt, NSColor *endColor, CGPoint endPt )
//{
//    CAGradientLayer *layer = [CAGradientLayer layer];
//    [layer setFrame:r];
//    NSMutableArray *cgColors = [NSMutableArray arrayWithCapacity:2];
//    [cgColors addObject:(id)[startColor CGColor]];
//    [cgColors addObject:(id)[endColor CGColor]];
//    [layer setColors:cgColors];
//    [layer setStartPoint:startPt];
//    [layer setEndPoint:endPt];
//    return layer;
//}

CAGradientLayer *CAGradientLayerWithStartEndColors( CGRect r, NSColor *startColor, CGPoint startPt, NSColor *endColor, CGPoint endPt )
{
    CAGradientLayer *layer = [CAGradientLayer layer];
    [layer setFrame:r];
    NSArray *cgColors = @[(id)[startColor CGColor],(id)[endColor CGColor]];
    [layer setColors:cgColors];
    [layer setStartPoint:startPt];
    [layer setEndPoint:endPt];
    return layer;
}
