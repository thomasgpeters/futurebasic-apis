/*
 ImageRep.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class ImageRepClass( void );

// - create -
CFArrayRef ImageRepImageRepsWithPasteboard( NSPasteboard *pasteboard );
CFArrayRef ImageRepImageRepsWithContentsOfURL( CFURLRef url );
NSImageRep *ImageRepWithPasteboard( NSPasteboard *pasteboard );
NSImageRep *ImageRepWithContentsOfURL( CFURLRef url );
NSImageRep *ImageRepWithCoder( NSCoder *coder );

// - image types -
BOOL ImageRepCanInitWithData( CFDataRef dta );
BOOL ImageRepCanInitWithPasteboard( NSPasteboard *pasteboard );
CFArrayRef ImageRepImageTypes( void );
CFArrayRef ImageRepImageUnfilteredTypes( void );

// - image size -
CGSize ImageRepSize( NSImageRep *ref );
void ImageRepSetSize( ImageRepRef ref, CGSize size );

// - representation info -
NSInteger ImageRepBitsPerSample( NSImageRep *ref );
CFStringRef ImageRepColorSpaceName( NSImageRep *ref );
BOOL ImageRepHasAlpha( NSImageRep *ref );
BOOL ImageRepIsOpaque( NSImageRep *ref );
NSInteger ImageRepPixelsHigh( NSImageRep *ref );
NSInteger ImageRepPixelsWide( NSImageRep *ref );
NSImageLayoutDirection ImageRepLayoutDirection( NSImageRep *ref );
void ImageRepSetLayoutDirection( NSImageRep *ref, NSImageLayoutDirection direction );

// - CGImage -
CGImageRef ImageRepCGImageForProposedRect( NSImageRep *ref, CGRect *r, NSGraphicsContext *context, CFDictionaryRef hints );

// - drawing -
BOOL ImageRepDraw( NSImageRep *ref );
BOOL ImageRepDrawAtPoint( NSImageRep *ref, CGPoint pt );
BOOL ImageRepDrawInRect( NSImageRep *ref, CGRect r );
BOOL ImageRepDrawInRectFromRect( NSImageRep *ref, CGRect r, CGRect fromRect, NSCompositingOperation operation, CGFloat fraction, BOOL respectFlipped, CFDictionaryRef hints );

// - subclasses -

