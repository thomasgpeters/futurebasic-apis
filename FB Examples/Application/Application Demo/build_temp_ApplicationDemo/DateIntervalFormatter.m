/*
 DateIntervalFormatter.m

 Bernie Wylde
 */

#import "DateIntervalFormatter.h"


// Class
Class DateIntervalFormatterClass( void )
{ return [NSDateIntervalFormatter class]; }

// - init -
NSDateIntervalFormatter *DateIntervalFormatterInit( void )
{
#if __has_feature(objc_arc)
    return [[NSDateIntervalFormatter alloc] init];
#else
    return [[[NSDateIntervalFormatter alloc] init] autorelease];
#endif
}

// - formatting -
CFStringRef DateIntervalFormatterStringFromDate( NSDateIntervalFormatter *ref, CFDateRef fromDate, CFDateRef toDate )
{ return (__bridge CFStringRef)[ref stringFromDate:(__bridge NSDate *)fromDate toDate:(__bridge NSDate *)toDate]; }

// - configure -
NSDateIntervalFormatterStyle DateIntervalFormatterDateStyle( NSDateIntervalFormatter *ref )
{ return [ref dateStyle]; }

void DateIntervalFormatterSetDateStyle( NSDateIntervalFormatter *ref, NSDateIntervalFormatterStyle style )
{ [ref setDateStyle:style]; }

NSDateIntervalFormatterStyle DateIntervalFormatterTimeStyle( NSDateIntervalFormatter *ref )
{ return [ref timeStyle]; }

void DateIntervalFormatterSetTimeStyle( NSDateIntervalFormatter *ref, NSDateIntervalFormatterStyle style )
{ [ref setTimeStyle:style]; }

CFStringRef DateIntervalFormatterDateTemplate( NSDateIntervalFormatter *ref )
{ return (__bridge CFStringRef)[ref dateTemplate]; }

void DateIntervalFormatterSetDateTemplate( NSDateIntervalFormatter *ref, CFStringRef template )
{ [ref setDateTemplate:(__bridge NSString *)template]; }

CFCalendarRef DateIntervalFormatterCalendar( NSDateIntervalFormatter *ref )
{ return (__bridge CFCalendarRef)[ref calendar]; }

void DateIntervalFormatterSetCalendar( NSDateIntervalFormatter *ref, CFCalendarRef cal )
{ [ref setCalendar:(__bridge NSCalendar *)cal]; }

CFLocaleRef DateIntervalFormatterLocale( NSDateIntervalFormatter *ref )
{ return (__bridge CFLocaleRef)[ref locale]; }

void DateIntervalFormatterSetLocale( NSDateIntervalFormatter *ref, CFLocaleRef locale )
{ [ref setLocale:(__bridge NSLocale *)locale]; }

CFTimeZoneRef DateIntervalFormatterTimeZone( NSDateIntervalFormatter *ref )
{ return (__bridge CFTimeZoneRef)[ref timeZone]; }

void DateIntervalFormatterSetTimeZone( NSDateIntervalFormatter *ref, CFTimeZoneRef tz )
{ [ref setTimeZone:(__bridge NSTimeZone *)tz]; }

// - instance -
CFStringRef DateIntervalFormatterStringFromDateInterval( NSDateIntervalFormatter *ref, NSDateInterval *di )
{ return (__bridge CFStringRef)[ref stringFromDateInterval:di]; }


