/*
 CAScrollLayer.h

 Bernie Wylde
 */

#import "CocoaUI.h"

// - init -
CAScrollLayer *CAScrollLayerInit( void );

// - constraints -
CFStringRef caScrollLayerScrollMode( CAScrollLayer *layer );
void CAScrollLayerSetScrollMode( CAScrollLayer *layer, CFStringRef scrollMode );

// - scrolling -
void CAScrollLayerScrollToPoint( CAScrollLayer *layer, CGPoint pt );
void CAScrollLayerScrollToRect( CAScrollLayer *layer, CGRect r );

