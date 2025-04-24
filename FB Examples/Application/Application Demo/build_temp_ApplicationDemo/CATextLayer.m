/*
 CATextLayer.m

 Bernie Wylde
 */

#import "CATextLayer.h"

// - init -
CATextLayer *CATextLayerInit( void )
{ return [CATextLayer layer]; }

// - get/set -
CFTypeRef CATextLayerString( CATextLayer *layer )
{ return (__bridge CFTypeRef)[layer string]; }

void CATextLayerSetString( CATextLayer *layer, CFTypeRef string )
{ [layer setString:(__bridge id)string]; }

// - properties -
CFTypeRef CATextLayerFont( CATextLayer *layer )
{ return [layer font]; }

void CATextLayerSetFont( CATextLayer *layer, CFTypeRef font )
{ [layer setFont:font]; }

CGFloat CATextLayerFontSize( CATextLayer *layer )
{ return [layer fontSize]; }

void CATextLayerSetFontSize( CATextLayer *layer, CGFloat size )
{ [layer setFontSize:size]; }

NSColor *CATextLayerForegroundColor( CATextLayer *layer )
{ return [NSColor colorWithCGColor:[layer foregroundColor]]; }

void CATextLayerSetForegroundColor( CATextLayer *layer, NSColor *col )
{ [layer setForegroundColor:[col CGColor]]; }

// - alignment/truncation
BOOL CATextLayerIsWrapped( CATextLayer *layer )
{ return [layer isWrapped]; }

void CATextLayerSetWrapped( CATextLayer *layer, BOOL flag )
{ [layer setWrapped:flag]; }

CFStringRef caTextLayerAlignmentMode( CATextLayer *layer )
{ return (__bridge CFStringRef)[layer alignmentMode]; }

void CATextLayerSetAlignmentMode( CATextLayer *layer, CFStringRef alignment )
{ [layer setAlignmentMode:(__bridge NSString *)alignment]; }

CFStringRef caTextLayerTruncationMode( CATextLayer *layer )
{ return (__bridge CFStringRef)[layer truncationMode]; }

void CATextLayerSetTruncationMode( CATextLayer *layer, CFStringRef truncation )
{ [layer setTruncationMode:(__bridge NSString *)truncation]; }

// - instance properties -
BOOL CATextLayerAllowsFontSubpixelQuantization( CATextLayer *layer )
{ return [layer allowsFontSubpixelQuantization]; }

void CATextLayerSetAllowsFontSubpixelQuantization( CATextLayer *layer, BOOL flag )
{ [layer setAllowsFontSubpixelQuantization:flag]; }

