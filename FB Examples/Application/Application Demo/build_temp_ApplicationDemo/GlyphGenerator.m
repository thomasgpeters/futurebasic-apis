/*
 GlyphGenerator.m

 Bernie Wylde
 */

#import "GlyphGenerator.h"

// Class
Class GlyphGeneratorClass( void )
{ return [NSGlyphGenerator class]; }

// Obtaining
NSGlyphGenerator *GlyphGeneratorShared( void )
{ return [NSGlyphGenerator sharedGlyphGenerator]; }

// Generating glyphs
void GlyphGeneratorGenerateGlyphsForGlyphStorage( NSGlyphGenerator *ref, id<NSGlyphStorage> storage, NSUInteger desiredNumberOfCharacters, NSUInteger *glyphIndex, NSUInteger *characterIndex )
{ [ref generateGlyphsForGlyphStorage:storage desiredNumberOfCharacters:desiredNumberOfCharacters glyphIndex:glyphIndex characterIndex:characterIndex]; }



/*
 GlyphStorage.incl
 */
// TextStorage
CFAttributedStringRef GlyphStorageAttributedString( id<NSGlyphStorage> ref )
{ return (__bridge CFAttributedStringRef)[ref attributedString]; }

// Display options
NSUInteger GlyphStorageLayoutOptions( id<NSGlyphStorage> ref )
{ return [ref layoutOptions]; }

// Cache
void GlyphStorageInsertGlyphs( id<NSGlyphStorage> ref, NSGlyph *glyphs, NSUInteger length, NSUInteger glyphIndex, NSUInteger charIndex )
{ [ref insertGlyphs:glyphs length:length forStartingGlyphAtIndex:glyphIndex characterIndex:charIndex]; }

void GlyphStorageSetIntAttribute( id<NSGlyphStorage> ref, NSInteger attributeTag, NSInteger value, NSUInteger glyphIndex )
{ [ref setIntAttribute:attributeTag value:value forGlyphAtIndex:glyphIndex]; }

