/*
 GraphicsContext.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class GraphicsContextClass( void );

// Create
NSGraphicsContext *GraphicsContextWithAttributes( CFDictionaryRef attributes );
NSGraphicsContext *GraphicsContextWithBitmapImageRep( NSBitmapImageRep *rep );
NSGraphicsContext *GraphicsContextWithCGContext( CGContextRef cgCtx, BOOL flipped );
NSGraphicsContext *GraphicsContextWithWindow( NSWindow *window );

// Manage current context
NSGraphicsContext *GraphicsContextCurrentContext( void );
void GraphicsContextSetCurrentContext( NSGraphicsContext *ref );
CGContextRef GraphicsContextCurrentCGContext( void );
CGContextRef GraphicsContextCGContext( NSGraphicsContext *ref );

// Graphics state
void GraphicsContextSaveGraphicsState( void );
void GraphicsContextRestoreGraphicsState( void );

// Testing drawing destination
BOOL GraphicsContextCurrentContextDrawingToScreen( void );
BOOL GraphicsContextDrawingToScreen( NSGraphicsContext *ref );

// Context info
CFDictionaryRef GraphicsContextAttributes( NSGraphicsContext *ref );
BOOL GraphicsContextIsFlipped( NSGraphicsContext *ref );

// Flushing
void GraphicsContextFlushGraphics( NSGraphicsContext *ref );

// Rendering options
NSCompositingOperation GraphicsContextCompositingOperation( NSGraphicsContext *ref );
void GraphicsContextSetCompositingOperation( NSGraphicsContext *ref, NSCompositingOperation operation );
NSImageInterpolation GraphicsContextImageInterpolation( NSGraphicsContext *ref );
void GraphicsContextSetImageInterpolation( NSGraphicsContext *ref, NSImageInterpolation interpolation );
BOOL GraphicsContextShouldAntialias( NSGraphicsContext *ref );
void GraphicsContextSetShouldAntialias( NSGraphicsContext *ref, BOOL flag );
CGPoint GraphicsContextPatternPhase( NSGraphicsContext *ref );
void GraphicsContextSetPatternPhase( NSGraphicsContext *ref, CGPoint phase );

// CIContext
CIContext *GraphicsContextCIContext( NSGraphicsContext *ref );

// Color rendering intent
NSColorRenderingIntent GraphicsContextColorRenderingIntent( NSGraphicsContext *ref );
void GraphicsContextSetColorRenderingIntent( NSGraphicsContext *ref, NSColorRenderingIntent intent );


