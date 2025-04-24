/*
 GraphicsContext.m

 Bernie Wylde
 */

#import "GraphicsContext.h"

// Class
Class GraphicsContextClass( void )
{ return [NSGraphicsContext class]; }

// Create
NSGraphicsContext *GraphicsContextWithAttributes( CFDictionaryRef attributes )
{ return [NSGraphicsContext graphicsContextWithAttributes:(__bridge NSDictionary *)attributes]; }

NSGraphicsContext *GraphicsContextWithBitmapImageRep( NSBitmapImageRep *rep )
{ return [NSGraphicsContext graphicsContextWithBitmapImageRep:rep]; }

NSGraphicsContext *GraphicsContextWithCGContext( CGContextRef cgCtx, BOOL flipped )
{ return [NSGraphicsContext graphicsContextWithCGContext:cgCtx flipped:flipped]; }

NSGraphicsContext *GraphicsContextWithWindow( NSWindow *window )
{ return [NSGraphicsContext graphicsContextWithWindow:window]; }

// Manage current context
NSGraphicsContext *GraphicsContextCurrentContext( void )
{ return [NSGraphicsContext currentContext]; }

void GraphicsContextSetCurrentContext( NSGraphicsContext *ref )
{ [NSGraphicsContext setCurrentContext:ref]; }

CGContextRef GraphicsContextCurrentCGContext( void )
{ return [[NSGraphicsContext currentContext] CGContext]; }

CGContextRef GraphicsContextCGContext( NSGraphicsContext *ref )
{ return [ref CGContext]; }

// Graphics state
void GraphicsContextSaveGraphicsState( void )
{ [NSGraphicsContext saveGraphicsState]; }

void GraphicsContextRestoreGraphicsState( void )
{ [NSGraphicsContext restoreGraphicsState]; }

// Testing drawing destination
BOOL GraphicsContextCurrentContextDrawingToScreen( void )
{ return [NSGraphicsContext currentContextDrawingToScreen]; }

BOOL GraphicsContextDrawingToScreen( NSGraphicsContext *ref )
{ return [ref isDrawingToScreen]; }

// Context info
CFDictionaryRef GraphicsContextAttributes( NSGraphicsContext *ref )
{ return (__bridge CFDictionaryRef)[ref attributes]; }

BOOL GraphicsContextIsFlipped( NSGraphicsContext *ref )
{ return [ref isFlipped]; }

// Flushing
void GraphicsContextFlushGraphics( NSGraphicsContext *ref )
{ [ref flushGraphics]; }

// Rendering options
NSCompositingOperation GraphicsContextCompositingOperation( NSGraphicsContext *ref )
{ return [ref compositingOperation]; }

void GraphicsContextSetCompositingOperation( NSGraphicsContext *ref, NSCompositingOperation operation )
{ [ref setCompositingOperation:operation]; }

NSImageInterpolation GraphicsContextImageInterpolation( NSGraphicsContext *ref )
{ return [ref imageInterpolation]; }

void GraphicsContextSetImageInterpolation( NSGraphicsContext *ref, NSImageInterpolation interpolation )
{ [ref setImageInterpolation:interpolation]; }

BOOL GraphicsContextShouldAntialias( NSGraphicsContext *ref )
{ return [ref shouldAntialias]; }

void GraphicsContextSetShouldAntialias( NSGraphicsContext *ref, BOOL flag )
{ [ref setShouldAntialias:flag]; }

CGPoint GraphicsContextPatternPhase( NSGraphicsContext *ref )
{ return NSPointToCGPoint([ref patternPhase]); }

void GraphicsContextSetPatternPhase( NSGraphicsContext *ref, CGPoint phase )
{ [ref setPatternPhase:NSPointFromCGPoint(phase)]; }

// CIContext
CIContext *GraphicsContextCIContext( NSGraphicsContext *ref )
{ return [ref CIContext]; }

// Color rendering intent
NSColorRenderingIntent GraphicsContextColorRenderingIntent( NSGraphicsContext *ref )
{ return [ref colorRenderingIntent]; }

void GraphicsContextSetColorRenderingIntent( NSGraphicsContext *ref, NSColorRenderingIntent intent )
{ [ref setColorRenderingIntent:intent]; }

