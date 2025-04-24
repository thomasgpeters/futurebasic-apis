/*
 CATextLayer.h

 Bernie Wylde
 */

#import "CocoaUI.h"

// - init -
CATextLayer *CATextLayerInit( void );

// - get/set -
CFTypeRef CATextLayerString( CATextLayer *layer );
void CATextLayerSetString( CATextLayer *layer, CFTypeRef string );

// - properties -
CFTypeRef CATextLayerFont( CATextLayer *layer );
void CATextLayerSetFont( CATextLayer *layer, CFTypeRef font );
CGFloat CATextLayerFontSize( CATextLayer *layer );
void CATextLayerSetFontSize( CATextLayer *layer, CGFloat size );
NSColor *CATextLayerForegroundColor( CATextLayer *layer );
void CATextLayerSetForegroundColor( CATextLayer *layer, NSColor *col );

// - alignment/truncation
BOOL CATextLayerIsWrapped( CATextLayer *layer );
void CATextLayerSetWrapped( CATextLayer *layer, BOOL flag );
CFStringRef caTextLayerAlignmentMode( CATextLayer *layer );
void CATextLayerSetAlignmentMode( CATextLayer *layer, CFStringRef alignment );
CFStringRef caTextLayerTruncationMode( CATextLayer *layer );
void CATextLayerSetTruncationMode( CATextLayer *layer, CFStringRef truncation );

// - instance properties -
BOOL CATextLayerAllowsFontSubpixelQuantization( CATextLayer *layer );
void CATextLayerSetAllowsFontSubpixelQuantization( CATextLayer *layer, BOOL flag );

