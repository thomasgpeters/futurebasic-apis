/*
 RelativeDateTimeFormatter.m

 Bernie Wylde
 */

#import "RelativeDateTimeFormatter.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500

// Class
Class RelativeDateTimeFormatterClass( void )
{ return [NSRelativeDateTimeFormatter class]; }

// Create
NSRelativeDateTimeFormatter *RelativeDateTimeFormatterInit( void )
{
#if __has_feature(objc_arc)
    return [[NSRelativeDateTimeFormatter alloc] init];
#else
    return [[[NSRelativeDateTimeFormatter alloc] init] autorelease];
#endif
}

// Instance properties
CFCalendarRef RelativeDateTimeFormatterCalendar( NSRelativeDateTimeFormatter *ref )
{ return (__bridge CFCalendarRef)[ref calendar]; }

void RelativeDateTimeFormatterSetCalendar( NSRelativeDateTimeFormatter *ref, CFCalendarRef cal )
{ [ref setCalendar:(__bridge NSCalendar *)cal]; }

NSRelativeDateTimeFormatterStyle RelativeDateTimeFormatterStyle( NSRelativeDateTimeFormatter *ref )
{ return [ref dateTimeStyle]; }

void RelativeDateTimeFormatterSetStyle( NSRelativeDateTimeFormatter *ref, NSRelativeDateTimeFormatterStyle style )
{ [ref setDateTimeStyle:style]; }

NSFormattingContext RelativeDateTimeFormatterFormattingContext( NSRelativeDateTimeFormatter *ref )
{ return [ref formattingContext]; }

void RelativeDateTimeFormatterSetFormattingContext( NSRelativeDateTimeFormatter *ref, NSFormattingContext context )
{ [ref setFormattingContext:context]; }

CFLocaleRef RelativeDateTimeFormatterLocale( NSRelativeDateTimeFormatter *ref )
{ return (__bridge CFLocaleRef)[ref locale]; }

void RelativeDateTimeFormatterSetLocale( NSRelativeDateTimeFormatter *ref, CFLocaleRef locale )
{ [ref setLocale:(__bridge NSLocale *)locale]; }

NSRelativeDateTimeFormatterUnitsStyle RelativeDateTimeFormatterUnitsStyle( NSRelativeDateTimeFormatter *ref )
{ return [ref unitsStyle]; }

void RelativeDateTimeFormatterSetUnitsStyle( NSRelativeDateTimeFormatter *ref, NSRelativeDateTimeFormatterUnitsStyle style )
{ [ref setUnitsStyle:style]; }

// Instance methods
CFStringRef RelativeDateTimeFormatterLocalizedStringForDate( NSRelativeDateTimeFormatter *ref, CFDateRef dt, CFDateRef referenceDate )
{ return (__bridge CFStringRef)[ref localizedStringForDate:(__bridge NSDate *)dt relativeToDate:(__bridge NSDate *)referenceDate]; }

CFStringRef RelativeDateTimeFormatterLocalizedStringFromDateComponents( NSRelativeDateTimeFormatter *ref, NSDateComponents *components )
{ return (__bridge CFStringRef)[ref localizedStringFromDateComponents:components]; }

CFStringRef RelativeDateTimeFormatterLocalizedStringFromTimeInterval( NSRelativeDateTimeFormatter *ref, CFTimeInterval ti )
{ return (__bridge CFStringRef)[ref localizedStringFromTimeInterval:ti]; }

CFStringRef RelativeDateTimeFormatterStringForObjectValue( NSRelativeDateTimeFormatter *ref, CFTypeRef obj )
{ return (__bridge CFStringRef)[ref stringForObjectValue:(__bridge id)obj]; }

#endif// 101500
