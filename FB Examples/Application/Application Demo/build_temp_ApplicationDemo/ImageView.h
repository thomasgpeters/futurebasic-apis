/*
 ImageView.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "DialogEvent.h"
//#import "Responder.h"
//#import "View.h"
//#import "Window.h"

@interface ImageViewSC : NSImageView
@end

// Class
Class ImageViewClass( void );

NSImageView *ImageViewWithTag( NSInteger tag );
BOOL ImageViewExists( NSInteger tag );

// - image -
NSImage *ImageViewImage( NSInteger tag );
void ImageViewSetImage( NSInteger tag, CFTypeRef inImage );
void ImageViewSetImageNamed( NSInteger tag, CFStringRef imageName );

// - visual characteristics -
NSImageFrameStyle ImageViewFrameStyle( NSInteger tag );
void ImageViewSetFrameStyle( NSInteger tag, NSImageFrameStyle style );
NSImageAlignment ImageViewAlignment( NSInteger tag );
void ImageViewSetAlignment( NSInteger tag, NSImageAlignment alignment );
NSImageScaling ImageViewScaling( NSInteger tag );
void ImageViewSetScaling( NSInteger tag, NSImageScaling scaling );
BOOL ImageViewAnimates( NSInteger tag );
void ImageViewSetAnimates( NSInteger tag, BOOL flag );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
NSImageSymbolConfiguration *ImageViewSymbolConfiguration( NSInteger tag );
API_AVAILABLE(macos(11.0))
void ImageViewSetSymbolConfiguration( NSInteger tag, NSImageSymbolConfiguration *config );
#endif// 110000

// - user events -
void ImageViewSetEditable( NSInteger tag, BOOL flag );
void ImageViewSetAllowsCutCopyPaste( NSInteger tag, BOOL flag );

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
NSColor *ImageViewContentTintColor( NSInteger tag );
API_AVAILABLE(macos(10.14))
void ImageViewSetContentTintColor( NSInteger tag, NSColor *col );
#endif// 101400

// Symbol effects
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
void ImageViewAddSymbolEffect( NSInteger tag, NSSymbolEffect *effect );
API_AVAILABLE(macos(14.0))
void ImageViewAddSymbolEffectWithOptions( NSInteger tag, NSSymbolEffect *effect, NSSymbolEffectOptions *options );
API_AVAILABLE(macos(14.0))
void ImageViewAddSymbolEffectAnimated( NSInteger tag, NSSymbolEffect *effect, NSSymbolEffectOptions *options, BOOL animated );
API_AVAILABLE(macos(14.0))
void ImageViewRemoveSymbolEffect( NSInteger tag, NSSymbolEffect *effect );
API_AVAILABLE(macos(14.0))
void ImageViewRemoveSymbolEffectWithOptions( NSInteger tag, NSSymbolEffect *effect, NSSymbolEffectOptions *options );
API_AVAILABLE(macos(14.0))
void ImageViewRemoveSymbolEffectAnimated( NSInteger tag, NSSymbolEffect *effect, NSSymbolEffectOptions *options, BOOL animated );
API_AVAILABLE(macos(14.0))
void ImageViewRemoveAllSymbolEffects( NSInteger tag );
API_AVAILABLE(macos(14.0))
void ImageViewRemoveAllSymbolEffectsWithOptions( NSInteger tag, NSSymbolEffectOptions *options );
API_AVAILABLE(macos(14.0))
void ImageViewRemoveAllSymbolEffectsAnimated( NSInteger tag, NSSymbolEffectOptions *options, BOOL animated );
API_AVAILABLE(macos(14.0))
void ImageViewSetSymbolImage( NSInteger tag, NSImage *image, NSSymbolContentTransition *transition );
API_AVAILABLE(macos(14.0))
void ImageViewSetSymbolImageWithOptions( NSInteger tag, NSImage *image, NSSymbolContentTransition *transition, NSSymbolEffectOptions *options );
#endif// 140000

// Init
NSImageView *ImageViewInit( NSInteger inTag, CGRect inRect );

// Statement
void CUI_ImageView( NSInteger inTag, NSInteger inEnabled, void *inImage, CGRect inRect, NSInteger inScaling, NSInteger inAlignment, NSInteger inFrameStyle, NSInteger inWndTag );

