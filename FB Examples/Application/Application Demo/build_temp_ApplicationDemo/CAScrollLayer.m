/*
 CAScrollLayer.m

 Bernie Wylde
 */

#import "CAScrollLayer.h"

// - init -
CAScrollLayer *CAScrollLayerInit( void )
{ return [CAScrollLayer layer]; }

// - constraints -
CFStringRef caScrollLayerScrollMode( CAScrollLayer *layer )
{ return (__bridge CFStringRef)[layer scrollMode]; }

void CAScrollLayerSetScrollMode( CAScrollLayer *layer, CFStringRef scrollMode )
{ [layer setScrollMode:(__bridge NSString *)scrollMode]; }

// - scrolling -
void CAScrollLayerScrollToPoint( CAScrollLayer *layer, CGPoint pt )
{ [layer scrollToPoint:pt]; }

void CAScrollLayerScrollToRect( CAScrollLayer *layer, CGRect r )
{ [layer scrollToRect:r]; }

