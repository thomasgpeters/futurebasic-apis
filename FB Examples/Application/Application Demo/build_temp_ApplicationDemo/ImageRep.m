/*
 ImageRep.m

 Bernie Wylde
 */

#import "ImageRep.h"

// Class
Class ImageRepClass( void )
{ return [NSImageRep class]; }

// - create -
CFArrayRef ImageRepImageRepsWithPasteboard( NSPasteboard *pasteboard )
{ return (__bridge CFArrayRef)[NSImageRep imageRepsWithPasteboard:pasteboard]; }

CFArrayRef ImageRepImageRepsWithContentsOfURL( CFURLRef url )
{ return (__bridge CFArrayRef)[NSImageRep imageRepsWithContentsOfURL:(__bridge NSURL *)url]; }

NSImageRep *ImageRepWithPasteboard( NSPasteboard *pasteboard )
{ return [NSImageRep imageRepWithPasteboard:pasteboard]; }

NSImageRep *ImageRepWithContentsOfURL( CFURLRef url )
{ return [NSImageRep imageRepWithContentsOfURL:(__bridge NSURL *)url]; }

NSImageRep *ImageRepWithCoder( NSCoder *coder )
{
#if __has_feature(objc_arc)
    return [[NSImageRep alloc] initWithCoder:coder];
#else
    return [[[NSImageRep alloc] initWithCoder:coder] autorelease];
#endif
}

// - image types -
BOOL ImageRepCanInitWithData( CFDataRef dta )
{ return [NSImageRep canInitWithData:(__bridge NSData *)dta]; }

BOOL ImageRepCanInitWithPasteboard( NSPasteboard *pasteboard )
{ return [NSImageRep canInitWithPasteboard:pasteboard]; }

CFArrayRef ImageRepImageTypes( void )
{ return (__bridge CFArrayRef)[NSImageRep imageTypes]; }

CFArrayRef ImageRepImageUnfilteredTypes( void )
{ return (__bridge CFArrayRef)[NSImageRep imageUnfilteredTypes]; }

// - image size -
CGSize ImageRepSize( NSImageRep *ref )
{ return NSSizeToCGSize([ref size]); }

void ImageRepSetSize( ImageRepRef ref, CGSize size )
{ [ref setSize:NSSizeFromCGSize(size)]; }

// - representation info -
NSInteger ImageRepBitsPerSample( NSImageRep *ref )
{ return [ref bitsPerSample]; }

CFStringRef ImageRepColorSpaceName( NSImageRep *ref )
{ return (__bridge CFStringRef)[ref colorSpaceName]; }

BOOL ImageRepHasAlpha( NSImageRep *ref )
{ return [ref hasAlpha]; }

BOOL ImageRepIsOpaque( NSImageRep *ref )
{ return [ref isOpaque]; }

NSInteger ImageRepPixelsHigh( NSImageRep *ref )
{ return [ref pixelsHigh]; }

NSInteger ImageRepPixelsWide( NSImageRep *ref )
{ return [ref pixelsWide]; }

NSImageLayoutDirection ImageRepLayoutDirection( NSImageRep *ref )
{ return [ref layoutDirection];}

void ImageRepSetLayoutDirection( NSImageRep *ref, NSImageLayoutDirection direction )
{ [ref setLayoutDirection:direction]; }

// - CGImage -
CGImageRef ImageRepCGImageForProposedRect( NSImageRep *ref, CGRect *r, NSGraphicsContext *context, CFDictionaryRef hints )
{ return [ref CGImageForProposedRect:(NSRect *)r context:context hints:(__bridge NSDictionary *)hints]; }

// - drawing -
BOOL ImageRepDraw( NSImageRep *ref )
{ return [ref draw]; }

BOOL ImageRepDrawAtPoint( NSImageRep *ref, CGPoint pt )
{ return [ref drawAtPoint:NSPointFromCGPoint(pt)]; }

BOOL ImageRepDrawInRect( NSImageRep *ref, CGRect r )
{ return [ref drawInRect:NSRectFromCGRect(r)]; }

BOOL ImageRepDrawInRectFromRect( NSImageRep *ref, CGRect r, CGRect fromRect, NSCompositingOperation operation, CGFloat fraction, BOOL respectFlipped, CFDictionaryRef hints )
{ return [ref drawInRect:NSRectFromCGRect(r) fromRect:NSRectFromCGRect(fromRect) operation:operation fraction:fraction respectFlipped:respectFlipped hints:(__bridge NSDictionary *)hints]; }

// - subclasses -

