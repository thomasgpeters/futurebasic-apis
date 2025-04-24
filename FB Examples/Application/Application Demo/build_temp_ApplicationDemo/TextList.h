/*
 TextList.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class TextListClass( void );

// Create
NSTextList *TextListWithMarkerFormat( CFStringRef format, NSUInteger options );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
API_AVAILABLE(macos(13.0))
NSTextList *TextListWithCoder( NSCoder *coder );
API_AVAILABLE(macos(13.0))
NSTextList *TextListWithStartingItemNumber( CFStringRef format, NSUInteger options, NSInteger startingItemNumber );
#endif// 130000

// Markers
CFStringRef TextListMarkerFormat( NSTextList *ref );
CFStringRef TextListMarkerForItemNumber( NSTextList *ref, NSInteger itemNum );

// Options
NSUInteger TextListOptions( NSTextList *ref );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
API_AVAILABLE(macos(13.0))
BOOL TextListIsOrdered( NSTextList *ref );
#endif// 130000

// Item numbering
NSInteger TextListStartingItemNumber( NSTextList *ref );

