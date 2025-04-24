/*
 GlyphGenerator.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class GlyphGeneratorClass( void );

// Obtaining
NSGlyphGenerator *GlyphGeneratorShared( void );

// Generating glyphs
void GlyphGeneratorGenerateGlyphsForGlyphStorage( NSGlyphGenerator *ref, id<NSGlyphStorage> storage, NSUInteger desiredNumberOfCharacters, NSUInteger *glyphIndex, NSUInteger *characterIndex );



/*
 GlyphStorage.incl
 */

// TextStorage
CFAttributedStringRef GlyphStorageAttributedString( id<NSGlyphStorage> ref );

// Display options
NSUInteger GlyphStorageLayoutOptions( id<NSGlyphStorage> ref );

// Cache
void GlyphStorageInsertGlyphs( id<NSGlyphStorage> ref, NSGlyph *glyphs, NSUInteger length, NSUInteger glyphIndex, NSUInteger charIndex );
void GlyphStorageSetIntAttribute( id<NSGlyphStorage> ref, NSInteger attributeTag, NSInteger value, NSUInteger glyphIndex );


