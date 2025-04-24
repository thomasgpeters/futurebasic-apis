/*
 TextList.m

 Bernie Wylde
 */

#import "TextList.h"

// Class
Class TextListClass( void )
{ return [NSTextList class]; }

// Create
NSTextList *TextListWithMarkerFormat( CFStringRef format, NSUInteger options )
{
#if __has_feature(objc_arc)
    return [[NSTextList alloc] initWithMarkerFormat:(__bridge NSString *)format options:options];
#else
    return [[[NSTextList alloc] initWithMarkerFormat:(__bridge NSString *)format options:options] autorelease];
#endif
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
NSTextList *TextListWithCoder( NSCoder *coder )
{
#if __has_feature(objc_arc)
    return [[NSTextList alloc] initWithCoder:coder];
#else
    return [[[NSTextList alloc] initWithCoder:coder] autorelease];
#endif
}

NSTextList *TextListWithStartingItemNumber( CFStringRef format, NSUInteger options, NSInteger startingItemNumber )
{
#if __has_feature(objc_arc)
    return [[NSTextList alloc] initWithMarkerFormat:(__bridge NSString *)format options:options startingItemNumber:startingItemNumber];
#else
    return [[[NSTextList alloc] initWithMarkerFormat:(__bridge NSString *)format options:options startingItemNumber:startingItemNumber] autorelease];
#endif
}
#endif// 130000

// Markers
CFStringRef TextListMarkerFormat( NSTextList *ref )
{ return (__bridge CFStringRef)[ref markerFormat]; }

CFStringRef TextListMarkerForItemNumber( NSTextList *ref, NSInteger itemNum )
{ return (__bridge CFStringRef)[ref markerForItemNumber:itemNum]; }

// Options
NSUInteger TextListOptions( NSTextList *ref )
{ return [ref listOptions]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
BOOL TextListIsOrdered( NSTextList *ref )
{ return [ref isOrdered]; }
#endif// 130000

// Item numbering
NSInteger TextListStartingItemNumber( NSTextList *ref )
{ return [ref startingItemNumber]; }

