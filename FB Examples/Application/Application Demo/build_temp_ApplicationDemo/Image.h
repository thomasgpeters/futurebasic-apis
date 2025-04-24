/*
 Image.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef BOOL (*CUI_ImageDrawingHandlerType)(CGRect,void*);

// Class
Class ImageClass( void );

// Images by name
NSImage *ImageNamed( CFStringRef name );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
NSImage *ImageWithSystemSymbolName( CFStringRef symbolName, CFStringRef accessibilityDescription );
#endif// 110000
void ImageSetName( NSImage *ref, CFStringRef name );
CFStringRef ImageName( NSImage *ref );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
API_AVAILABLE(macos(13.0))
NSImage *ImageWithSystemSymbolNameVariableValue( CFStringRef name, double value, CFStringRef accessibilityDescription );
API_AVAILABLE(macos(13.0))
NSImage *ImageWithSymbolName( CFStringRef name, double value );
#endif// 130000
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
NSImage *ImageWithLocale( NSImage *ref, CFLocaleRef locale );
API_AVAILABLE(macos(14.0))
CFLocaleRef ImageLocale( NSImage *ref );
#endif// 140000

// Dynamically drawn image
NSImage *ImageWithDrawingHandler( CGSize size, BOOL flipped, CUI_ImageDrawingHandlerType handler, void *userData );

// Image from resource file
NSImage *ImageByReferencingURL( CFURLRef url );
NSImage *ImageWithContentsOfURL( CFURLRef url );

// create from existing data
NSImage *ImageWithData( CFDataRef dta );
NSImage *ImageWithDataIgnoringOrientation( CFDataRef dta );
NSImage *ImageWithCGImage( CGImageRef image, CGSize size );
NSImage *ImageWithPasteboard( NSPasteboard *pb );

// Create empty image
NSImage *ImageWithSize( CGSize size );

// Attributes
CGSize ImageSize( NSImage *ref );
void ImageSetSize( NSImage *ref, CGSize size );
void ImageSetTemplate( NSImage *ref, BOOL flag );
BOOL ImageIsTemplate( NSImage *ref );

// Determine supported image types
BOOL ImageCanInitWithPasteboard( NSPasteboard *pb );
CFArrayRef ImageTypes( void );
CFArrayRef ImageUnfilteredTypes( void );

// Image representation
void ImageAddRepresentation( NSImage *ref, NSImageRep *rep );
void ImageAddRepresentations( NSImage *ref, CFArrayRef reps );
CFArrayRef ImageRepresentations( NSImage *ref );
void ImageRemoveRepresentation( NSImage *ref, NSImageRep *rep );
NSImageRep *ImageBestRepresentationForRect( NSImage *ref, CGRect r, NSGraphicsContext *ctx, CFDictionaryRef hints );

// Image representation selection criteria
BOOL ImagePrefersColorMatch( NSImage *ref );
void ImageSetPrefersColorMatch( NSImage *ref, BOOL flag );
BOOL ImageUsesEPSOnResolutionMismatch( NSImage *ref );
void ImageSetUsesEPSOnResolutionMismatch( NSImage *ref, BOOL flag );
BOOL ImageMatchesOnMultipleResolution( NSImage *ref );
void ImageSetMatchesOnMultipleResolution( NSImage *ref, BOOL flag );

// Drawing
void ImageDrawInRect( NSImage *ref, CGRect rect );
void ImageDrawAtPoint( NSImage *ref, CGPoint pt, CGRect fromRect, NSCompositingOperation operation, CGFloat fraction );
void ImageDrawInRectFromRect( NSImage *ref, CGRect rect, CGRect fromRect, NSCompositingOperation op, CGFloat fraction );
void ImageDrawInRectFromRectRespectFlipped( NSImage *ref, CGRect rect, CGRect fromRect, NSCompositingOperation op, CGFloat fraction, BOOL respectFlipped, CFDictionaryRef hints );
BOOL ImageDrawRepresentationInRect( NSImage *ref, NSImageRep *rep, CGRect rect );

// Drawing options
BOOL ImageIsValid( NSImage *ref );
NSColor *ImageBackgroundColor( NSImage *ref );
void ImageSetBackgroundColor( NSImage *ref, NSColor *col );
NSEdgeInsets ImageCapInsets( NSImage *ref );
void ImageSetCapInsets( NSImage *ref, NSEdgeInsets insets );
NSImageResizingMode ImageResizingMode( NSImage *ref );
void ImageSetResizingMode( NSImage *ref, NSImageResizingMode mode );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
NSImage *ImageWithSymbolConfiguration( NSImage *ref, NSImageSymbolConfiguration *configuration );
#endif// 110000

// Focus
void ImageLockFocus( NSImage *ref );
void ImageLockFocusFlipped( NSImage *ref, BOOL flag );
void ImageUnlockFocus( NSImage *ref );

// Alignment
CGRect ImageAlignmentRect( NSImage *ref );
void ImageSetAlignmentRect( NSImage *ref, CGRect rect );

// Caching options
NSImageCacheMode ImageCacheMode( NSImage *ref );
void ImageSetCacheMode( NSImage *ref, NSImageCacheMode mode );
void ImageRecache( NSImage *ref );

// TIFF
CFDataRef ImageTIFFRepresentation( NSImage *ref );
CFDataRef ImageTIFFRepresentationUsingCompression( NSImage *ref, NSTIFFCompression compression, float factor );

// CGImage
CGImageRef ImageCGImageForProposedRect( NSImage *ref, CGRect *rect, NSGraphicsContext *context, CFDictionaryRef hints );

// Incremental loads
void ImageCancelIncrementalLoad( NSImage *ref );

// Hit testing
BOOL ImageHitTestRect( NSImage *ref, CGRect testRectDestSpace, CGRect imageRectDestSpace, NSGraphicsContext *ctx, CFDictionaryRef hints, BOOL flipped );

// Image accessibility
CFStringRef ImageAccessibilityDescription( NSImage *ref );
void ImageSetAccessibilityDescription( NSImage *ref, CFStringRef description );

// Core animation
CFTypeRef ImageLayerContentsForContentsScale( NSImage *ref, CGFloat scale );
CGFloat ImageRecommendedLayerContentsScale( NSImage *ref, CGFloat preferredScale );

// Axis matching
BOOL ImageMatchesOnlyOnBestFittingAxis( NSImage *ref );
void ImageSetMatchesOnlyOnBestFittingAxis( NSImage *ref, BOOL flag );

// Convenience
BOOL ImageWriteToURL( NSImage *ref, CFURLRef url, NSBitmapImageFileType fileType, BOOL sameResolution );

/*
  ImageSymbolConfiguration
*/
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
NSImageSymbolConfiguration *ImageSymbolConfigurationWithPointSize( CGFloat pointSize, NSFontWeight weight );
API_AVAILABLE(macos(11.0))
NSImageSymbolConfiguration *ImageSymbolConfigurationWithPointSizeAndScale( CGFloat pointSize, NSFontWeight weight, NSImageSymbolScale scale );
API_AVAILABLE(macos(11.0))
NSImageSymbolConfiguration *ImageSymbolConfigurationWithTextStyle( NSFontTextStyle style );
API_AVAILABLE(macos(11.0))
NSImageSymbolConfiguration *ImageSymbolConfigurationWithTextStyleAndScale( NSFontTextStyle style, NSImageSymbolScale scale );
API_AVAILABLE(macos(11.0))
NSImageSymbolConfiguration *ImageSymbolConfigurationWithScale( NSImageSymbolScale scale );
#endif// 110000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
NSImageSymbolConfiguration *ImageSymbolConfigurationWithHierarchicalColor( NSColor *hierarchicalColor );
API_AVAILABLE(macos(12.0))
NSImageSymbolConfiguration *ImageSymbolConfigurationWithPaletteColors( CFArrayRef paletteColors );
API_AVAILABLE(macos(12.0))
NSImageSymbolConfiguration *ImageSymbolConfigurationPreferringMulticolor( void );
API_AVAILABLE(macos(12.0))
NSImageSymbolConfiguration *ImageSymbolConfigurationByApplyingConfiguration( NSImageSymbolConfiguration *ref, NSImageSymbolConfiguration *configuration );
#endif// 120000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
API_AVAILABLE(macos(13.0))
NSImageSymbolConfiguration *ImageSymbolConfigurationPreferringMonochrome( void );
#endif// 130000
