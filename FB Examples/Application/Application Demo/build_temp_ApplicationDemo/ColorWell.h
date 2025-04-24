/*
 ColorWell.h

 Bernie Wylde
 */


#import "CocoaUI.h"

#import "View.h"
#import "Window.h"


#pragma mark - pulldown target
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
API_AVAILABLE(macos(13.0))
@interface CUI_ColorWellPulldownTarget : NSObject
@end
API_AVAILABLE(macos(13.0))
CUI_ColorWellPulldownTarget *CUI_ColorWellPulldownTargetObj( void );
#endif// 130000


#pragma mark - subclass
@interface ColorWellSC : NSColorWell
@end

// dialog events
enum {
    colorWellPulldown = 5900
};

// Class
Class ColorWellClass( void );

NSColorWell *ColorWellWithTag( NSInteger tag );
BOOL ColorWellExists( NSInteger tag );

NSColor *ColorWellColor( NSInteger tag );
void ColorWellSetColor( NSInteger tag, NSColor *col );
void ColorWellTakeColorFrom( NSInteger tag, NSInteger senderTag );

void ColorWellActivate( NSInteger tag, BOOL exclusive );
BOOL ColorWellIsActive( NSInteger tag );
void ColorWellDeactivate( NSInteger tag );

BOOL ColorWellIsBordered( NSInteger tag );
void ColorWellSetBordered( NSInteger tag, BOOL flag );

void ColorWellDrawWellInside( NSInteger tag, CGRect insideRect );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
// Style
API_AVAILABLE(macos(13.0))
NSColorWellStyle ColorWellStyle( NSInteger tag );
API_AVAILABLE(macos(13.0))
void ColorWellSetStyle( NSInteger tag, NSColorWellStyle style );

// Image
API_AVAILABLE(macos(13.0))
NSImage *ColorWellImage( NSInteger tag );
API_AVAILABLE(macos(13.0))
//void ColorWellSetImage( NSInteger tag, NSImage *image );
void ColorWellSetImage( NSInteger tag, CFTypeRef inImage );

// Pulldown action
API_AVAILABLE(macos(13.0))
void ColorWellEnablePulldownAction( NSInteger tag, BOOL flag );
#endif// 130000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
BOOL ColorWellSupportsAlpha( NSInteger tag );
API_AVAILABLE(macos(14.0))
void ColorWellSetSupportsAlpha( NSInteger tag, BOOL flag );
#endif// 140000


// Init
NSColorWell *ColorWellInit( NSInteger inTag, CGRect inRect );

// statement
void CUI_ColorWell( NSInteger inTag, NSInteger inEnabled, long inColor, CGRect inRect, NSInteger __attribute__ ((__unused__)) inStyle, NSInteger inWndTag );

