/*
 TextContent.h

 Bernie Wylde
 */

#import "CocoaUI.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000

API_AVAILABLE(macos(11.0))
CFStringRef TextContentType( id<NSTextContent> ref );
API_AVAILABLE(macos(11.0))
void TextContentSetType( id<NSTextContent> ref, CFStringRef type );

#endif

