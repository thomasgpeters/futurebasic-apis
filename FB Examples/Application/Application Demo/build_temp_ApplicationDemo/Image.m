/*
 Image.m

 Bernie Wylde
 */

#import "Image.h"

// Class
Class ImageClass( void )
{ return [NSImage class]; }

// Images by name
NSImage *ImageNamed( CFStringRef name )
{ return CUI_ImageResource( (__bridge NSString *)name ); }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
NSImage *ImageWithSystemSymbolName( CFStringRef symbolName, CFStringRef accessibilityDescription )
{ return [NSImage imageWithSystemSymbolName:(__bridge NSString *)symbolName accessibilityDescription:(__bridge NSString *)accessibilityDescription]; }
#endif// 110000

void ImageSetName( NSImage *ref, CFStringRef name )
{ [ref setName:(__bridge NSString *)name]; }

CFStringRef ImageName( NSImage *ref )
{ return (__bridge CFStringRef)[ref name]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
NSImage *ImageWithSystemSymbolNameVariableValue( CFStringRef name, double value, CFStringRef accessibilityDescription )
{ return [NSImage imageWithSystemSymbolName:(__bridge NSString *)name variableValue:value accessibilityDescription:(__bridge NSString *)accessibilityDescription]; }

NSImage *ImageWithSymbolName( CFStringRef name, double value )
{ return [NSImage imageWithSymbolName:(__bridge NSString *)name variableValue:value]; }
#endif// 130000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
NSImage *ImageWithLocale( NSImage *ref, CFLocaleRef locale )
{ return [ref imageWithLocale:(__bridge NSLocale *)locale]; }

CFLocaleRef ImageLocale( NSImage *ref )
{ return (__bridge CFLocaleRef)[ref locale]; }
#endif// 140000

// Dynamically drawn image
NSImage *ImageWithDrawingHandler( CGSize size, BOOL flipped, CUI_ImageDrawingHandlerType handler, void *userData )
{
    NSImage *image = [NSImage imageWithSize:NSSizeFromCGSize(size) flipped:flipped drawingHandler:^BOOL(NSRect rect) {
        if ( handler ) return (*handler)( NSRectToCGRect(rect), userData );
        return NO;
    }];
    return image;
}

// Image from resource file
NSImage *ImageByReferencingURL( CFURLRef url )
{
#if __has_feature(objc_arc)
    return [[NSImage alloc] initByReferencingURL:(__bridge NSURL *)url];
#else
    return [[[NSImage alloc] initByReferencingURL:(__bridge NSURL *)url] autorelease];
#endif
}

NSImage *ImageWithContentsOfURL( CFURLRef url )
{
#if __has_feature(objc_arc)
    return [[NSImage alloc] initWithContentsOfURL:(__bridge NSURL *)url];
#else
    return [[[NSImage alloc] initWithContentsOfURL:(__bridge NSURL *)url] autorelease];
#endif
}

// create from existing data
NSImage *ImageWithData( CFDataRef dta )
{
#if __has_feature(objc_arc)
    return [[NSImage alloc] initWithData:(__bridge NSData *)dta];
#else
    return [[[NSImage alloc] initWithData:(__bridge NSData *)dta] autorelease];
#endif
}

NSImage *ImageWithDataIgnoringOrientation( CFDataRef dta )
{
#if __has_feature(objc_arc)
    return [[NSImage alloc] initWithDataIgnoringOrientation:(__bridge NSData *)dta];
#else
    return [[[NSImage alloc] initWithDataIgnoringOrientation:(__bridge NSData *)dta] autorelease];
#endif
}

NSImage *ImageWithCGImage( CGImageRef image, CGSize size )
{
#if __has_feature(objc_arc)
    return [[NSImage alloc] initWithCGImage:image size:NSSizeFromCGSize(size)];
#else
    return [[[NSImage alloc] initWithCGImage:image size:NSSizeFromCGSize(size)] autorelease];
#endif
}

NSImage *ImageWithPasteboard( NSPasteboard *pb )
{
#if __has_feature(objc_arc)
    return [[NSImage alloc] initWithPasteboard:pb];
#else
    return [[[NSImage alloc] initWithPasteboard:pb] autorelease];
#endif
}

// Create empty image
NSImage *ImageWithSize( CGSize size )
{
#if __has_feature(objc_arc)
    return [[NSImage alloc] initWithSize:NSSizeFromCGSize(size)];
#else
    return [[[NSImage alloc] initWithSize:NSSizeFromCGSize(size)] autorelease];
#endif
}

// Attributes
CGSize ImageSize( NSImage *ref )
{ return NSSizeToCGSize( [ref size] ); }

void ImageSetSize( NSImage *ref, CGSize size )
{ [ref setSize:NSSizeFromCGSize( size )]; }

void ImageSetTemplate( NSImage *ref, BOOL flag )
{ [ref setTemplate:flag]; }

BOOL ImageIsTemplate( NSImage *ref )
{ return [ref isTemplate]; }

// Determine supported image types
BOOL ImageCanInitWithPasteboard( NSPasteboard *pb )
{ return [NSImage canInitWithPasteboard:pb]; }

CFArrayRef ImageTypes( void )
{ return (__bridge CFArrayRef)[NSImage imageTypes]; }

CFArrayRef ImageUnfilteredTypes( void )
{ return (__bridge CFArrayRef)[NSImage imageUnfilteredTypes]; }

// Image representation
void ImageAddRepresentation( NSImage *ref, NSImageRep *rep )
{ [ref addRepresentation:rep]; }

void ImageAddRepresentations( NSImage *ref, CFArrayRef reps )
{ [ref addRepresentations:(__bridge NSArray *)reps]; }

CFArrayRef ImageRepresentations( NSImage *ref )
{ return (__bridge CFArrayRef)[ref representations]; }

void ImageRemoveRepresentation( NSImage *ref, NSImageRep *rep )
{ [ref removeRepresentation:rep]; }

NSImageRep *ImageBestRepresentationForRect( NSImage *ref, CGRect r, NSGraphicsContext *ctx, CFDictionaryRef hints )
{ return [ref bestRepresentationForRect:NSRectFromCGRect(r) context:ctx hints:(__bridge NSDictionary *)hints]; }

// Image representation selection criteria
BOOL ImagePrefersColorMatch( NSImage *ref )
{ return [ref prefersColorMatch]; }

void ImageSetPrefersColorMatch( NSImage *ref, BOOL flag )
{ [ref setPrefersColorMatch:flag]; }

BOOL ImageUsesEPSOnResolutionMismatch( NSImage *ref )
{ return [ref usesEPSOnResolutionMismatch]; }

void ImageSetUsesEPSOnResolutionMismatch( NSImage *ref, BOOL flag )
{ [ref setUsesEPSOnResolutionMismatch:flag]; }

BOOL ImageMatchesOnMultipleResolution( NSImage *ref )
{ return [ref matchesOnMultipleResolution]; }

void ImageSetMatchesOnMultipleResolution( NSImage *ref, BOOL flag )
{ [ref setMatchesOnMultipleResolution:flag]; }

// Drawing
void ImageDrawInRect( NSImage *ref, CGRect rect )
{ [ref drawInRect:NSRectFromCGRect( rect )]; }

void ImageDrawAtPoint( NSImage *ref, CGPoint pt, CGRect fromRect, NSCompositingOperation operation, CGFloat fraction )
{ [ref drawAtPoint:NSPointFromCGPoint( pt ) fromRect:NSRectFromCGRect( fromRect ) operation:operation fraction:fraction]; }

void ImageDrawInRectFromRect( NSImage *ref, CGRect rect, CGRect fromRect, NSCompositingOperation op, CGFloat fraction )
{ [ref drawInRect:NSRectFromCGRect( rect ) fromRect:NSRectFromCGRect(fromRect) operation:op fraction:fraction]; }

void ImageDrawInRectFromRectRespectFlipped( NSImage *ref, CGRect rect, CGRect fromRect, NSCompositingOperation op, CGFloat fraction, BOOL respectFlipped, CFDictionaryRef hints )
{ [ref drawInRect:NSRectFromCGRect( rect ) fromRect:NSRectFromCGRect(fromRect) operation:op fraction:fraction respectFlipped:respectFlipped hints:(__bridge NSDictionary *)hints]; }

BOOL ImageDrawRepresentationInRect( NSImage *ref, NSImageRep *rep, CGRect rect )
{ return [ref drawRepresentation:rep inRect:NSRectFromCGRect( rect )]; }

// Drawing options
BOOL ImageIsValid( NSImage *ref )
{ return [ref isValid]; }

NSColor *ImageBackgroundColor( NSImage *ref )
{ return [ref backgroundColor]; }

void ImageSetBackgroundColor( NSImage *ref, NSColor *col )
{ [ref setBackgroundColor:col]; }

NSEdgeInsets ImageCapInsets( NSImage *ref )
{ return [ref capInsets]; }

void ImageSetCapInsets( NSImage *ref, NSEdgeInsets insets )
{ [ref setCapInsets:insets]; }

NSImageResizingMode ImageResizingMode( NSImage *ref )
{ return [ref resizingMode]; }

void ImageSetResizingMode( NSImage *ref, NSImageResizingMode mode )
{ [ref setResizingMode:mode]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
NSImage *ImageWithSymbolConfiguration( NSImage *ref, NSImageSymbolConfiguration *configuration )
{ return [ref imageWithSymbolConfiguration:configuration]; }
#endif// 110000

// Focus
void ImageLockFocus( NSImage *ref )
{ [ref lockFocus]; }

void ImageLockFocusFlipped( NSImage *ref, BOOL flag )
{ [ref lockFocusFlipped:flag]; }

void ImageUnlockFocus( NSImage *ref )
{ [ref unlockFocus]; }

// Alignment
CGRect ImageAlignmentRect( NSImage *ref )
{ return NSRectToCGRect( [ref alignmentRect] ); }

void ImageSetAlignmentRect( NSImage *ref, CGRect rect )
{ [ref setAlignmentRect:NSRectFromCGRect( rect )]; }

// Caching options
NSImageCacheMode ImageCacheMode( NSImage *ref )
{ return [ref cacheMode]; }

void ImageSetCacheMode( NSImage *ref, NSImageCacheMode mode )
{ [ref setCacheMode:mode]; }

void ImageRecache( NSImage *ref )
{ [ref recache]; }

// TIFF
CFDataRef ImageTIFFRepresentation( NSImage *ref )
{ return (__bridge CFDataRef)[ref TIFFRepresentation]; }

CFDataRef ImageTIFFRepresentationUsingCompression( NSImage *ref, NSTIFFCompression compression, float factor )
{ return (__bridge CFDataRef)[ref TIFFRepresentationUsingCompression:compression factor:factor]; }

// CGImage
CGImageRef ImageCGImageForProposedRect( NSImage *ref, CGRect *rect, NSGraphicsContext *context, CFDictionaryRef hints )
{ return [ref CGImageForProposedRect:(NSRect *)rect context:context hints:(__bridge NSDictionary *)hints]; }

// Incremental loads
void ImageCancelIncrementalLoad( NSImage *ref )
{ [ref cancelIncrementalLoad]; }

// Hit testing
BOOL ImageHitTestRect( NSImage *ref, CGRect testRectDestSpace, CGRect imageRectDestSpace, NSGraphicsContext *ctx, CFDictionaryRef hints, BOOL flipped )
{ return [ref hitTestRect:NSRectFromCGRect(testRectDestSpace) withImageDestinationRect:NSRectFromCGRect(imageRectDestSpace) context:ctx hints:(__bridge NSDictionary *)hints flipped:flipped]; }

// Image accessibility
CFStringRef ImageAccessibilityDescription( NSImage *ref )
{ return (__bridge CFStringRef)[ref accessibilityDescription]; }

void ImageSetAccessibilityDescription( NSImage *ref, CFStringRef description )
{ [ref setAccessibilityDescription:(__bridge NSString *)description]; }

// Core animation
CFTypeRef ImageLayerContentsForContentsScale( NSImage *ref, CGFloat scale )
{ return (__bridge CFTypeRef)[ref layerContentsForContentsScale:scale]; }

CGFloat ImageRecommendedLayerContentsScale( NSImage *ref, CGFloat preferredScale )
{ return [ref recommendedLayerContentsScale:preferredScale]; }

// Axis matching
BOOL ImageMatchesOnlyOnBestFittingAxis( NSImage *ref )
{ return [ref matchesOnlyOnBestFittingAxis]; }

void ImageSetMatchesOnlyOnBestFittingAxis( NSImage *ref, BOOL flag )
{ [ref setMatchesOnlyOnBestFittingAxis:flag]; }

// Convenience
BOOL ImageWriteToURL( NSImage *ref, CFURLRef url, NSBitmapImageFileType fileType, BOOL sameResolution )
{
    CGImageRef cgImage = [ref CGImageForProposedRect:nil context:nil hints:nil];
    if ( cgImage ) {
#if __has_feature(objc_arc)
        NSBitmapImageRep *rep = [[NSBitmapImageRep alloc] initWithCGImage:cgImage];
#else
        NSBitmapImageRep *rep = [[[NSBitmapImageRep alloc] initWithCGImage:cgImage] autorelease];
#endif
        if ( rep ) {
            if ( sameResolution ) [rep setSize:[ref size]];
            NSData *data = [rep representationUsingType:fileType properties:@{}];
            if ( data ) {
                return [data writeToURL:(__bridge NSURL *)url options:NSDataWritingAtomic error:nil];
            }
        }
    }
    return NO;
}

/*
  ImageSymbolConfiguration
*/
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
NSImageSymbolConfiguration *ImageSymbolConfigurationWithPointSize( CGFloat pointSize, NSFontWeight weight )
{ return [NSImageSymbolConfiguration configurationWithPointSize:pointSize weight:weight]; }

NSImageSymbolConfiguration *ImageSymbolConfigurationWithPointSizeAndScale( CGFloat pointSize, NSFontWeight weight, NSImageSymbolScale scale )
{ return [NSImageSymbolConfiguration configurationWithPointSize:pointSize weight:weight scale:scale]; }

NSImageSymbolConfiguration *ImageSymbolConfigurationWithTextStyle( NSFontTextStyle style )
{ return [NSImageSymbolConfiguration configurationWithTextStyle:style]; }

NSImageSymbolConfiguration *ImageSymbolConfigurationWithTextStyleAndScale( NSFontTextStyle style, NSImageSymbolScale scale )
{ return [NSImageSymbolConfiguration configurationWithTextStyle:style scale:scale]; }

NSImageSymbolConfiguration *ImageSymbolConfigurationWithScale( NSImageSymbolScale scale )
{ return [NSImageSymbolConfiguration configurationWithScale:scale]; }
#endif// 110000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
NSImageSymbolConfiguration *ImageSymbolConfigurationWithHierarchicalColor( NSColor *hierarchicalColor )
{ return [NSImageSymbolConfiguration configurationWithHierarchicalColor:hierarchicalColor]; }

NSImageSymbolConfiguration *ImageSymbolConfigurationWithPaletteColors( CFArrayRef paletteColors )
{ return [NSImageSymbolConfiguration configurationWithPaletteColors:(__bridge NSArray *)paletteColors]; }

NSImageSymbolConfiguration *ImageSymbolConfigurationPreferringMulticolor( void )
{ return [NSImageSymbolConfiguration configurationPreferringMulticolor]; }

NSImageSymbolConfiguration *ImageSymbolConfigurationByApplyingConfiguration( NSImageSymbolConfiguration *ref, NSImageSymbolConfiguration *configuration )
{ return [ref configurationByApplyingConfiguration:configuration]; }
#endif// 120000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
NSImageSymbolConfiguration *ImageSymbolConfigurationPreferringMonochrome( void )
{ return [NSImageSymbolConfiguration configurationPreferringMonochrome]; }
#endif// 130000
