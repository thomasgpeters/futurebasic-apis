/*
 TextInsertionIndicator.h

 Bernie Wylde
 */

#import "CocoaUI.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000

API_AVAILABLE(macos(14.0))
@interface TextInsertionIndicatorSC : NSTextInsertionIndicator
@end

// Class
API_AVAILABLE(macos(14.0))
Class TextInsertionIndicatorClass( void );

API_AVAILABLE(macos(14.0))
NSTextInsertionIndicator *TextInsertionIndicatorWithTag( NSInteger tag );
API_AVAILABLE(macos(14.0))
BOOL TextInsertionIndicatorExists( NSInteger tag );

// Configure
API_AVAILABLE(macos(14.0))
NSTextInsertionIndicatorDisplayMode TextInsertionIndicatorDisplayMode( NSInteger tag );
API_AVAILABLE(macos(14.0))
void TextInsertionIndicatorSetDisplayMode( NSInteger tag, NSTextInsertionIndicatorDisplayMode displayMode );
API_AVAILABLE(macos(14.0))
NSTextInsertionIndicatorAutomaticModeOptions TextInsertionIndicatorAutomaticModeOptions( NSInteger tag );
API_AVAILABLE(macos(14.0))
void TextInsertionIndicatorSetAutomaticModeOptions( NSInteger tag, NSTextInsertionIndicatorAutomaticModeOptions options );
API_AVAILABLE(macos(14.0))
NSColor *TextInsertionIndicatorColor( NSInteger tag );
API_AVAILABLE(macos(14.0))
void TextInsertionIndicatorSetColor( NSInteger tag, NSColor *col );

// Init
API_AVAILABLE(macos(14.0))
NSTextInsertionIndicator *TextInsertionIndicatorInit( NSInteger inTag, CGRect inRect );

// Statement

API_AVAILABLE(macos(14.0))
void CUI_TextInsertionIndicator( NSInteger inTag, CGRect inRect, long inColor, NSInteger inDisplayMode, NSInteger inAutoModeOptions, NSInteger inWndTag );

#endif// 140000

