/*
 BitmapImageRep.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

// Class
Class BitmapImageRepClass( void );

// - create -
NSBitmapImageRep *BitmapImageRepWithData( CFDataRef dta );

CFArrayRef BitmapImageRepsWithData( CFDataRef dta );
void BitmapImageRepColorizeByMapping( NSBitmapImageRep *rep, CGFloat midPt, NSColor *midPtCol, NSColor *shadowCol, NSColor *lightCol );

NSBitmapImageRep *BitmapImageRepWithBitmapDataPlanes( unsigned char **planes, NSInteger wide, NSInteger high, NSInteger bps, NSInteger spp, BOOL hasAlpha, BOOL isPlanar, CFStringRef csName, NSInteger rBytes, NSInteger pBits );
NSBitmapImageRep *BitmapImageRepWithCGImage( CGImageRef ref );
NSBitmapImageRep *BitmapImageRepWithCIImage( CIImage *ref );
NSBitmapImageRep *BitmapImageRepForIncrementalLoad( void );

// - image info -
NSBitmapFormat BitmapImageRepFormat( NSBitmapImageRep *ref );
NSInteger BitmapImageRepBitsPerPixel( NSBitmapImageRep *ref );
NSInteger BitmapImageRepBytesPerPlane( NSBitmapImageRep *ref );
NSInteger BitmapImageRepBytesPerRow( NSBitmapImageRep *ref );
BOOL BitmapImageRepIsPlanar( NSBitmapImageRep *ref );
NSInteger BitmapImageRepNumberOfPlanes( NSBitmapImageRep *ref );
NSInteger BitmapImageRepSamplesPerPixel( NSBitmapImageRep *ref );

// - image data -
void *BitmapImageRepBitmapData( NSBitmapImageRep *rep );

// - image representation -
CFDataRef BitmapImageRepTIFFRepresentationOfImageReps( CFArrayRef imageReps );
CFDataRef BitmapImageRepTIFFRepresentationOfImageRepsUsingCompression( CFArrayRef imageReps, NSTIFFCompression compression, float factor );
CFDataRef BitmapImageRepTIFFRepresentation( NSBitmapImageRep *rep );
CFDataRef BitmapImageRepTIFFRepresentationUsingCompression( NSBitmapImageRep *rep, NSTIFFCompression compression, float factor );
CFDataRef BitmapImageRepTIFFRepresentationOfImageRepsUsingType( CFArrayRef imageReps, NSBitmapImageFileType type, CFDictionaryRef properties );
CFDataRef BitmapImageRepRepresentationUsingType( NSBitmapImageRep *rep, NSBitmapImageFileType type, CFDictionaryRef properties );

// - compression -
void BitmapImageRepGetTIFFCompressionTypes( const NSTIFFCompression **list, NSInteger *count );
CFStringRef BitmapImageRepLocalizedNameForTIFFCompressionType( NSTIFFCompression compression );
BOOL BitmapImageRepCanBeCompressed( NSBitmapImageRep *rep, NSTIFFCompression compression );
void BitmapImageRepSetCompression( NSBitmapImageRep *rep, NSTIFFCompression compression, float factor );
void BitmapImageRepGetCompression( NSBitmapImageRep *rep, NSTIFFCompression *compression, float *factor );
void BitmapImageRepSetPropertyValue( NSBitmapImageRep *rep, CFStringRef property, CFTypeRef value );
CFTypeRef BitmapImageRepValueForProperty( NSBitmapImageRep *rep, CFStringRef property );

// - load image incrementally -
NSInteger BitmapImageRepIncrementalLoadFromData( NSBitmapImageRep *rep, CFDataRef dta, BOOL complete );

// - pixel values -
void BitmapImageRepSetColor( NSBitmapImageRep *rep, NSColor *col, NSInteger x, NSInteger y );
NSColor *BitmapImageRepColor( NSBitmapImageRep *rep, NSInteger x, NSInteger y );
void BitmapImageRepSetPixel( NSBitmapImageRep *rep, NSUInteger *p, NSInteger x, NSInteger y );
void BitmapImageRepGetPixel( NSBitmapImageRep *rep, NSUInteger *p, NSInteger x, NSInteger y );

// - CGImage -
CGImageRef BitmapImageRepCGImage( NSBitmapImageRep *rep );

// - color spaces -
NSBitmapImageRep *BitmapImageRepByConvertingToColorSpace( NSBitmapImageRep *rep, NSColorSpace *cs, NSColorRenderingIntent intent );
NSBitmapImageRep *BitmapImageRepByRetaggingWithColorSpace( NSBitmapImageRep *rep, NSColorSpace *cs );
NSColorSpace *BitmapImageRepColorSpace( NSBitmapImageRep *rep );
