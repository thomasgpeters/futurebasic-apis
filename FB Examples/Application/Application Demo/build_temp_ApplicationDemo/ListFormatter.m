/*
 ListFormatter.m

 Bernie Wylde
 */

#import "ListFormatter.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500

// Class
Class ListFormatterClass( void )
{ return [NSListFormatter class]; }

// Create
NSListFormatter *ListFormatterInit( void )
{
#if __has_feature(objc_arc)
    return [[NSListFormatter alloc] init];
#else
    return [[[NSListFormatter alloc] init] autorelease];
#endif
}

// Instance properties
NSFormatter *ListFormatterItemFormatter( NSListFormatter *ref )
{ return [ref itemFormatter]; }

void ListFormatterSetItemFormatter( NSListFormatter *ref, NSFormatter *formatter )
{ [ref setItemFormatter:formatter]; }

CFLocaleRef ListFormatterLocale( NSListFormatter *ref )
{ return (__bridge CFLocaleRef)[ref locale]; }

void ListFormatterSetLocale( NSListFormatter *ref, CFLocaleRef locale )
{ [ref setLocale:(__bridge NSLocale *)locale]; }

// Instance methods
CFStringRef ListFormatterStringForObjectValue( NSListFormatter *ref, CFTypeRef obj )
{ return (__bridge CFStringRef)[ref stringForObjectValue:(__bridge id)obj]; }

CFStringRef ListFormatterStringFromItems( NSListFormatter *ref, CFArrayRef items )
{ return (__bridge CFStringRef)[ref stringFromItems:(__bridge NSArray *)items]; }

// Type methods
CFStringRef ListFormatterLocalizedStringByJoiningStrings( CFArrayRef strings )
{ return (__bridge CFStringRef)[NSListFormatter localizedStringByJoiningStrings:(__bridge NSArray *)strings]; }

#endif// 101500
