/*
 AdaptiveImageGlyph.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000

// Class
API_AVAILABLE(macos(15.0))
Class AdaptiveImageGlyphClass( void );

// Create
API_AVAILABLE(macos(15.0))
NSAdaptiveImageGlyph *AdaptiveImageGlyphWithImageContent( CFDataRef imageContent );
API_AVAILABLE(macos(15.0))
NSAdaptiveImageGlyph *AdaptiveImageGlyphWithCoder( NSCoder *coder );

// Image data
API_AVAILABLE(macos(15.0))
CFDataRef AdaptiveImageGlyphImageContent( NSAdaptiveImageGlyph *ref );

// Content metadata
API_AVAILABLE(macos(15.0))
CFStringRef AdaptiveImageGlyphContentIdentifier( NSAdaptiveImageGlyph *ref );
API_AVAILABLE(macos(15.0))
CFStringRef AdaptiveImageGlyphContentDescription( NSAdaptiveImageGlyph *ref );
API_AVAILABLE(macos(15.0))
UTType *AdaptiveImageGlyphContentType( void );

#endif // 150000
