/*
 ISO8601DateFormatter.m

 Bernie Wylde
 */

#import "ISO8601DateFormatter.h"


// Class
Class ISO8601DateFormatterClass( void )
{ return [NSISO8601DateFormatter class]; }

// Init
NSISO8601DateFormatter *ISO8601DateFormatterInit( void )
{
#if __has_feature(objc_arc)
    return [[NSISO8601DateFormatter alloc] init];
#else
    return [[[NSISO8601DateFormatter alloc] init] autorelease];
#endif
}

// Format options
NSISO8601DateFormatOptions ISO8601DateFormatterFormatOptions( NSISO8601DateFormatter *ref )
{ return [ref formatOptions]; }

void ISO8601DateFormatterSetFormatOptions( NSISO8601DateFormatter *ref, NSISO8601DateFormatOptions options )
{ [ref setFormatOptions:options]; }

CFTimeZoneRef ISO8601DateFormatterTimeZone( NSISO8601DateFormatter *ref )
{ return (__bridge CFTimeZoneRef)[ref timeZone]; }

void ISO8601DateFormatterSetTimeZone( NSISO8601DateFormatter *ref, CFTimeZoneRef timeZone )
{ [ref setTimeZone:(__bridge NSTimeZone *)timeZone]; }

// Convert
CFStringRef ISO8601DateFormatterStringFromDate( NSISO8601DateFormatter *ref, CFDateRef dt )
{ return (__bridge CFStringRef)[ref stringFromDate:(__bridge NSDate *)dt]; }

CFDateRef ISO8601DateFormatterDateFromString( NSISO8601DateFormatter *ref, CFStringRef string )
{ return (__bridge CFDateRef)[ref dateFromString:(__bridge NSString *)string]; }

CFStringRef ISO8601DateFormatterStringFromDateFormatOptions( CFDateRef dt, CFTimeZoneRef timeZone, NSISO8601DateFormatOptions options )
{ return (__bridge CFStringRef)[NSISO8601DateFormatter stringFromDate:(__bridge NSDate *)dt timeZone:(__bridge NSTimeZone *)timeZone formatOptions:options]; }

