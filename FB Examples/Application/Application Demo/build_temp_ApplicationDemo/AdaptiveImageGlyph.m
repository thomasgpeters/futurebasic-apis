/*
 AdaptiveImageGlyph.m
 
 Bernie Wylde
 */

#import "AdaptiveImageGlyph.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000

// Class
Class AdaptiveImageGlyphClass( void )
{ return [NSAdaptiveImageGlyph class]; }

// Create
NSAdaptiveImageGlyph *AdaptiveImageGlyphWithImageContent( CFDataRef imageContent )
{
    NSAdaptiveImageGlyph *g = [[NSAdaptiveImageGlyph alloc] initWithImageContent:(__bridge NSData *)imageContent];
#if !__has_feature(objc_arc)
    [ g autorelease];
#endif
    return g;
}

NSAdaptiveImageGlyph *AdaptiveImageGlyphWithCoder( NSCoder *coder )
{
    NSAdaptiveImageGlyph *g = [[NSAdaptiveImageGlyph alloc] initWithCoder:coder];
#if !__has_feature(objc_arc)
    [ g autorelease];
#endif
    return g;
}

// Image data
CFDataRef AdaptiveImageGlyphImageContent( NSAdaptiveImageGlyph *ref )
{ return (__bridge CFDataRef)[ref imageContent]; }

// Content metadata
CFStringRef AdaptiveImageGlyphContentIdentifier( NSAdaptiveImageGlyph *ref )
{ return (__bridge CFStringRef)[ref contentIdentifier]; }

CFStringRef AdaptiveImageGlyphContentDescription( NSAdaptiveImageGlyph *ref )
{ return (__bridge CFStringRef)[ref contentDescription]; }

UTType *AdaptiveImageGlyphContentType( void )
{ return [NSAdaptiveImageGlyph contentType]; }

#endif // 150000

