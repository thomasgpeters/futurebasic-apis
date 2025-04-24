/*
 BitmapImageRep.m
 
 Bernie Wylde
 */

#import "BitmapImageRep.h"

// Class
Class BitmapImageRepClass( void )
{ return [NSBitmapImageRep class]; }

// - create -
NSBitmapImageRep *BitmapImageRepWithData( CFDataRef dta )
{ return [NSBitmapImageRep imageRepWithData:(__bridge NSData *)dta]; }

CFArrayRef BitmapImageRepsWithData( CFDataRef dta )
{ return (__bridge CFArrayRef)[NSBitmapImageRep imageRepsWithData:(__bridge NSData *)dta]; }

//void BitmapImageRepColorizeByMapping( NSBitmapImageRep *rep, CGFloat midPt, NSColor *midPtCol, NSColor *shadowCol, NSColor *lightCol )
//{ [rep colorizeByMappingGray:midPt toColor:midPtCol blackMapping:shadowCol whiteMapping:lightCol]; }

void BitmapImageRepColorizeByMapping( NSBitmapImageRep *rep, CGFloat midPt, NSColor *midPtCol, NSColor *shadowCol, NSColor *lightCol )
{ [rep colorizeByMappingGray:midPt toColor:midPtCol blackMapping:shadowCol whiteMapping:lightCol]; }

NSBitmapImageRep *BitmapImageRepWithBitmapDataPlanes( unsigned char **planes, NSInteger wide, NSInteger high, NSInteger bps, NSInteger spp, BOOL hasAlpha, BOOL isPlanar, CFStringRef csName, NSInteger rBytes, NSInteger pBits )
{
#if __has_feature(objc_arc)
    return [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:planes pixelsWide:wide pixelsHigh:high bitsPerSample:bps samplesPerPixel:spp hasAlpha:hasAlpha isPlanar:isPlanar colorSpaceName:(__bridge NSString *)csName bytesPerRow:rBytes bitsPerPixel:pBits];
#else
    return [[[NSBitmapImageRep alloc] initWithBitmapDataPlanes:planes pixelsWide:wide pixelsHigh:high bitsPerSample:bps samplesPerPixel:spp hasAlpha:hasAlpha isPlanar:isPlanar colorSpaceName:(__bridge NSString *)csName bytesPerRow:rBytes bitsPerPixel:pBits] autorelease];
#endif
}

NSBitmapImageRep *BitmapImageRepWithCGImage( CGImageRef ref )
{
#if __has_feature(objc_arc)
    return [[NSBitmapImageRep alloc] initWithCGImage:ref];
#else
    return [[[NSBitmapImageRep alloc] initWithCGImage:ref] autorelease];
#endif
}

NSBitmapImageRep *BitmapImageRepWithCIImage( CIImage *ref )
{
#if __has_feature(objc_arc)
    return [[NSBitmapImageRep alloc] initWithCIImage:ref];
#else
    return [[[NSBitmapImageRep alloc] initWithCIImage:ref] autorelease];
#endif
}

NSBitmapImageRep *BitmapImageRepForIncrementalLoad( void )
{
#if __has_feature(objc_arc)
    return [[NSBitmapImageRep alloc] initForIncrementalLoad];
#else
    return [[[NSBitmapImageRep alloc] initForIncrementalLoad] autorelease];
#endif
}

// - image info -
NSBitmapFormat BitmapImageRepFormat( NSBitmapImageRep *ref )
{ return [ref bitmapFormat]; }

NSInteger BitmapImageRepBitsPerPixel( NSBitmapImageRep *ref )
{ return [ref bitsPerPixel]; }

NSInteger BitmapImageRepBytesPerPlane( NSBitmapImageRep *ref )
{ return [ref bytesPerPlane]; }

NSInteger BitmapImageRepBytesPerRow( NSBitmapImageRep *ref )
{ return [ref bytesPerRow]; }

BOOL BitmapImageRepIsPlanar( NSBitmapImageRep *ref )
{ return [ref isPlanar]; }

NSInteger BitmapImageRepNumberOfPlanes( NSBitmapImageRep *ref )
{ return [ref numberOfPlanes]; }

NSInteger BitmapImageRepSamplesPerPixel( NSBitmapImageRep *ref )
{ return [ref samplesPerPixel]; }

// - image data -
void *BitmapImageRepBitmapData( NSBitmapImageRep *rep )
{ return [rep bitmapData]; }

// - image representation -
CFDataRef BitmapImageRepTIFFRepresentationOfImageReps( CFArrayRef imageReps )
{ return (__bridge CFDataRef)[NSBitmapImageRep TIFFRepresentationOfImageRepsInArray:(__bridge NSArray *)imageReps]; }

CFDataRef BitmapImageRepTIFFRepresentationOfImageRepsUsingCompression( CFArrayRef imageReps, NSTIFFCompression compression, float factor )
{ return (__bridge CFDataRef)[NSBitmapImageRep TIFFRepresentationOfImageRepsInArray:(__bridge NSArray *)imageReps usingCompression:compression factor:factor]; }

CFDataRef BitmapImageRepTIFFRepresentation( NSBitmapImageRep *rep )
{ return (__bridge CFDataRef)[rep TIFFRepresentation]; }

CFDataRef BitmapImageRepTIFFRepresentationUsingCompression( NSBitmapImageRep *rep, NSTIFFCompression compression, float factor )
{ return (__bridge CFDataRef)[rep TIFFRepresentationUsingCompression:compression factor:factor]; }

CFDataRef BitmapImageRepTIFFRepresentationOfImageRepsUsingType( CFArrayRef imageReps, NSBitmapImageFileType type, CFDictionaryRef properties )
{ return (__bridge CFDataRef)[NSBitmapImageRep representationOfImageRepsInArray:(__bridge NSArray *)imageReps usingType:type properties:(__bridge NSDictionary *)properties]; }

CFDataRef BitmapImageRepRepresentationUsingType( NSBitmapImageRep *rep, NSBitmapImageFileType type, CFDictionaryRef properties )
{ return (__bridge CFDataRef)[rep representationUsingType:type properties:(__bridge NSDictionary *)properties]; }

// - compression -
void BitmapImageRepGetTIFFCompressionTypes( const NSTIFFCompression **list, NSInteger *count )
{ [NSBitmapImageRep getTIFFCompressionTypes:list count:count]; }

CFStringRef BitmapImageRepLocalizedNameForTIFFCompressionType( NSTIFFCompression compression )
{ return (__bridge CFStringRef)[NSBitmapImageRep localizedNameForTIFFCompressionType:compression]; }

BOOL BitmapImageRepCanBeCompressed( NSBitmapImageRep *rep, NSTIFFCompression compression )
{ return [rep canBeCompressedUsing:compression]; }

void BitmapImageRepSetCompression( NSBitmapImageRep *rep, NSTIFFCompression compression, float factor )
{ [rep setCompression:compression factor:factor]; }

void BitmapImageRepGetCompression( NSBitmapImageRep *rep, NSTIFFCompression *compression, float *factor )
{ [rep getCompression:compression factor:factor]; }

void BitmapImageRepSetPropertyValue( NSBitmapImageRep *rep, CFStringRef property, CFTypeRef value )
{ [rep setProperty:(__bridge NSString *)property withValue:(__bridge id)value]; }

CFTypeRef BitmapImageRepValueForProperty( NSBitmapImageRep *rep, CFStringRef property )
{ return (__bridge CFTypeRef)[rep valueForProperty:(__bridge NSString *)property]; }

// - load image incrementally -
NSInteger BitmapImageRepIncrementalLoadFromData( NSBitmapImageRep *rep, CFDataRef dta, BOOL complete )
{ return [rep incrementalLoadFromData:(__bridge NSData *)dta complete:complete]; }

// - pixel values -
void BitmapImageRepSetColor( NSBitmapImageRep *rep, NSColor *col, NSInteger x, NSInteger y )
{ [rep setColor:col atX:x y:y]; }

NSColor *BitmapImageRepColor( NSBitmapImageRep *rep, NSInteger x, NSInteger y )
{ return [rep colorAtX:x y:y]; }

void BitmapImageRepSetPixel( NSBitmapImageRep *rep, NSUInteger *p, NSInteger x, NSInteger y )
{ [rep setPixel:p atX:x y:y]; }

void BitmapImageRepGetPixel( NSBitmapImageRep *rep, NSUInteger *p, NSInteger x, NSInteger y )
{ [rep getPixel:p atX:x y:y]; }

// - CGImage -
CGImageRef BitmapImageRepCGImage( NSBitmapImageRep *rep )
{ return [rep CGImage]; }

// - color spaces -
NSBitmapImageRep *BitmapImageRepByConvertingToColorSpace( NSBitmapImageRep *rep, NSColorSpace *cs, NSColorRenderingIntent intent )
{ return [rep bitmapImageRepByConvertingToColorSpace:cs renderingIntent:intent]; }

NSBitmapImageRep *BitmapImageRepByRetaggingWithColorSpace( NSBitmapImageRep *rep, NSColorSpace *cs )
{ return [rep bitmapImageRepByRetaggingWithColorSpace:cs]; }

NSColorSpace *BitmapImageRepColorSpace( NSBitmapImageRep *rep )
{ return [rep colorSpace]; }
