/*
 ColorSampler.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "DialogEvent.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500

// dialog events
enum {
    colorSamplerSelectedColor = 4600
};

// Class
API_AVAILABLE(macos(10.15))
Class ColorSamplerClass( void );

API_AVAILABLE(macos(10.15))
void ColorSamplerShow( void );

#endif  // 101500
