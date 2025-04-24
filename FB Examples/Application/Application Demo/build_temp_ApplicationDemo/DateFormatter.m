/*
 DateFormatter.m

 Bernie Wylde
 */

#import "DateFormatter.h"

// Class
Class DateFormatterClass( void )
{ return [NSDateFormatter class]; }

// - init -
NSDateFormatter *DateFormatterInit( void )
{
#if __has_feature(objc_arc)
    return [[NSDateFormatter alloc] init];
#else
    return [[[NSDateFormatter alloc] init] autorelease];
#endif
}

NSDateFormatter *DateFormatterWithFormat( CFStringRef format )
{
    NSDateFormatter *formatter = DateFormatterInit();
    [formatter setDateFormat:(__bridge NSString *)format];
    return formatter;
}

// - converting objects -
CFDateRef DateFormatterDateFromString( NSDateFormatter *ref, CFStringRef string )
{ return (__bridge CFDateRef)[ref dateFromString:(__bridge NSString *)string]; }

CFStringRef DateFormatterStringFromDate( NSDateFormatter *ref, CFDateRef dt )
{ return (__bridge CFStringRef)[ref stringFromDate:(__bridge NSDate *)dt]; }

CFStringRef DateFormatterLocalizedStringFromDate( CFDateRef dt, NSDateFormatterStyle dateStyle, NSDateFormatterStyle timeStyle )
{ return (__bridge CFStringRef)[NSDateFormatter localizedStringFromDate:(__bridge NSDate *)dt dateStyle:dateStyle timeStyle:timeStyle]; }

BOOL DateFormatterGetObjectValueForString( NSDateFormatter *ref, CFTypeRef *obj, CFStringRef string, CFRange *inOutRange, NSError **err )
{
    BOOL result;
    id tempObj = nil;
    NSRange range = NSMakeRange(inOutRange->location,inOutRange->length);
    result = [ref getObjectValue:&tempObj forString:(__bridge NSString *)string range:&range error:err];
    if ( obj ) *obj = (__bridge CFTypeRef)tempObj;
    inOutRange->location = range.location;
    inOutRange->length = range.length;
    return result;
}

// - format and style
NSDateFormatterStyle DateFormatterDateStyle( NSDateFormatter *ref )
{ return [ref dateStyle]; }

void DateFormatterSetDateStyle( NSDateFormatter *ref, NSDateFormatterStyle style )
{ [ref setDateStyle:style]; }

NSDateFormatterStyle DateFormatterTimeStyle( NSDateFormatter *ref )
{ return [ref timeStyle]; }

void DateFormatterSetTimeStyle( NSDateFormatter *ref, NSDateFormatterStyle style )
{ [ref setTimeStyle:style]; }

CFStringRef DateFormatterDateFormat( NSDateFormatter *ref )
{ return (__bridge CFStringRef)[ref dateFormat]; }

void DateFormatterSetDateFormat( NSDateFormatter *ref, CFStringRef format )
{ [ref setDateFormat:(__bridge NSString *)format]; }

void DateFormatterSetLocalizedDateFormatFromTemplate( NSDateFormatter *ref, CFStringRef template )
{ [ref setLocalizedDateFormatFromTemplate:(__bridge NSString *)template]; }

CFStringRef DateFormatterDateFormatFromTemplate( CFStringRef template, NSUInteger options, CFLocaleRef locale )
{ return (__bridge CFStringRef)[NSDateFormatter dateFormatFromTemplate:(__bridge NSString *)template options:options locale:(__bridge NSLocale *)locale]; }

NSFormattingContext DateFormatterFormattingContext( NSDateFormatter *ref )
{ return [ref formattingContext]; }

void DateFormatterSetFormattingContext( NSDateFormatter *ref, NSFormattingContext ctx )
{ [ref setFormattingContext:ctx]; }

// - attributes -
CFCalendarRef DateFormatterCalendar( NSDateFormatter *ref )
{ return (__bridge CFCalendarRef)[ref calendar]; }

void DateFormatterSetCalendar( NSDateFormatter *ref, CFCalendarRef cal )
{ [ref setCalendar:(__bridge NSCalendar *)cal]; }

CFDateRef DateFormatterDefaultDate( NSDateFormatter *ref )
{ return (__bridge CFDateRef)[ref defaultDate]; }

void DateFormatterSetDefaultDate( NSDateFormatter *ref, CFDateRef dt )
{ [ref setDefaultDate:(__bridge NSDate *)dt]; }

CFLocaleRef DateFormatterLocale( NSDateFormatter *ref )
{ return (__bridge CFLocaleRef)[ref locale]; }

void DateFormatterSetLocale( NSDateFormatter *ref, CFLocaleRef locale )
{ [ref setLocale:(__bridge NSLocale *)locale]; }

CFTimeZoneRef DateFormatterTimeZone( NSDateFormatter *ref )
{ return (__bridge CFTimeZoneRef)[ref timeZone]; }

void DateFormatterSetTimeZone( NSDateFormatter *ref, CFTimeZoneRef zone )
{ [ref setTimeZone:(__bridge NSTimeZone *)zone]; }

CFDateRef DateFormatterTwoDigitStartDate( NSDateFormatter *ref )
{ return (__bridge CFDateRef)[ref twoDigitStartDate]; }

void DateFormatterSetTwoDigitStartDate( NSDateFormatter *ref, CFDateRef dt )
{ [ref setTwoDigitStartDate:(__bridge NSDate *)dt]; }

CFDateRef DateFormatterGregorianStartDate( NSDateFormatter *ref )
{ return (__bridge CFDateRef)[ref gregorianStartDate]; }

void DateFormatterSetGregorianStartDate( NSDateFormatter *ref, CFDateRef dt )
{ [ref setGregorianStartDate:(__bridge NSDate *)dt]; }

// - behavior -
NSDateFormatterBehavior DateFormatterBehavior( NSDateFormatter *ref )
{ return [ref formatterBehavior]; }

void DateFormatterSetBehavior( NSDateFormatter *ref, NSDateFormatterBehavior behavior )
{ [ref setFormatterBehavior:behavior]; }

NSDateFormatterBehavior DateFormatterDefaultBehavior( void )
{ return [NSDateFormatter defaultFormatterBehavior]; }

void DateFormatterSetDefaultBehavior( NSDateFormatterBehavior behavior )
{ [NSDateFormatter setDefaultFormatterBehavior:behavior]; }

// - natural language -
BOOL DateFormatterIsLenient( NSDateFormatter *ref )
{ return [ref isLenient]; }

void DateFormatterSetLenient( NSDateFormatter *ref, BOOL flag )
{ [ref setLenient:flag]; }

BOOL DateFormatterDoesRelativeDateFormatting( NSDateFormatter *ref )
{ return [ref doesRelativeDateFormatting]; }

void DateFormatterSetDoesRelativeDateFormatting( NSDateFormatter *ref, BOOL flag )
{ [ref setDoesRelativeDateFormatting:flag]; }

// - am and pm symbols -
CFStringRef DateFormatterAMSymbol( NSDateFormatter *ref )
{ return (__bridge CFStringRef)[ref AMSymbol]; }

void DateFormatterSetAMSymbol( NSDateFormatter *ref, CFStringRef symbol )
{ [ref setAMSymbol:(__bridge NSString *)symbol]; }

CFStringRef DateFormatterPMSymbol( NSDateFormatter *ref )
{ return (__bridge CFStringRef)[ref PMSymbol]; }

void DateFormatterSetPMSymbol( NSDateFormatter *ref, CFStringRef symbol )
{ [ref setPMSymbol:(__bridge NSString *)symbol]; }

// - weekday symbols -
CFArrayRef DateFormatterWeekdaySymbols( NSDateFormatter *ref )
{ return (__bridge CFArrayRef)[ref weekdaySymbols]; }

void DateFormatterSetWeekdaySymbols( NSDateFormatter *ref, CFArrayRef symbols )
{ [ref setWeekdaySymbols:(__bridge NSArray *)symbols]; }

CFArrayRef DateFormatterShortWeekdaySymbols( NSDateFormatter *ref )
{ return (__bridge CFArrayRef)[ref shortWeekdaySymbols]; }

void DateFormatterSetShortWeekdaySymbols( NSDateFormatter *ref, CFArrayRef symbols )
{ [ref setShortWeekdaySymbols:(__bridge NSArray *)symbols]; }

CFArrayRef DateFormatterVeryShortWeekdaySymbols( NSDateFormatter *ref )
{ return (__bridge CFArrayRef)[ref veryShortWeekdaySymbols]; }

void DateFormatterSetVeryShortWeekdaySymbols( NSDateFormatter *ref, CFArrayRef symbols )
{ [ref setVeryShortWeekdaySymbols:(__bridge NSArray *)symbols]; }

CFArrayRef DateFormatterStandaloneWeekdaySymbols( NSDateFormatter *ref )
{ return (__bridge CFArrayRef)[ref standaloneWeekdaySymbols]; }

void DateFormatterSetStandaloneWeekdaySymbols( NSDateFormatter *ref, CFArrayRef symbols )
{ [ref setStandaloneWeekdaySymbols:(__bridge NSArray *)symbols]; }

CFArrayRef DateFormatterShortStandaloneWeekdaySymbols( NSDateFormatter *ref )
{ return (__bridge CFArrayRef)[ref shortStandaloneWeekdaySymbols]; }

void DateFormatterSetShortStandaloneWeekdaySymbols( NSDateFormatter *ref, CFArrayRef symbols )
{ [ref setShortStandaloneWeekdaySymbols:(__bridge NSArray *)symbols]; }

CFArrayRef DateFormatterVeryShortStandaloneWeekdaySymbols( NSDateFormatter *ref )
{ return (__bridge CFArrayRef)[ref veryShortStandaloneWeekdaySymbols]; }

void DateFormatterSetVeryShortStandaloneWeekdaySymbols( NSDateFormatter *ref, CFArrayRef symbols )
{ [ref setVeryShortStandaloneWeekdaySymbols:(__bridge NSArray *)symbols]; }

// - month symbols -
CFArrayRef DateFormatterMonthSymbols( NSDateFormatter *ref )
{ return (__bridge CFArrayRef)[ref monthSymbols]; }

void DateFormatterSetMonthSymbols( NSDateFormatter *ref, CFArrayRef symbols )
{ [ref setMonthSymbols:(__bridge NSArray *)symbols]; }

CFArrayRef DateFormatterShortMonthSymbols( NSDateFormatter *ref )
{ return (__bridge CFArrayRef)[ref shortMonthSymbols]; }

void DateFormatterSetShortMonthSymbols( NSDateFormatter *ref, CFArrayRef symbols )
{ [ref setShortMonthSymbols:(__bridge NSArray *)symbols]; }

CFArrayRef DateFormatterVeryShortMonthSymbols( NSDateFormatter *ref )
{ return (__bridge CFArrayRef)[ref veryShortMonthSymbols]; }

void DateFormatterSetVeryShortMonthSymbols( NSDateFormatter *ref, CFArrayRef symbols )
{ [ref setVeryShortMonthSymbols:(__bridge NSArray *)symbols]; }

CFArrayRef DateFormatterStandaloneMonthSymbols( NSDateFormatter *ref )
{ return (__bridge CFArrayRef)[ref standaloneMonthSymbols]; }

void DateFormatterSetStandaloneMonthSymbols( NSDateFormatter *ref, CFArrayRef symbols )
{ [ref setStandaloneMonthSymbols:(__bridge NSArray *)symbols]; }

CFArrayRef DateFormatterShortStandaloneMonthSymbols( NSDateFormatter *ref )
{ return (__bridge CFArrayRef)[ref shortStandaloneMonthSymbols]; }

void DateFormatterSetShortStandaloneMonthSymbols( NSDateFormatter *ref, CFArrayRef symbols )
{ [ref setShortStandaloneMonthSymbols:(__bridge NSArray *)symbols]; }

CFArrayRef DateFormatterVeryShortStandaloneMonthSymbols( NSDateFormatter *ref )
{ return (__bridge CFArrayRef)[ref veryShortStandaloneMonthSymbols]; }

void DateFormatterSetVeryShortStandaloneMonthSymbols( NSDateFormatter *ref, CFArrayRef symbols )
{ [ref setVeryShortStandaloneMonthSymbols:(__bridge NSArray *)symbols]; }

// - quarter symbols -
CFArrayRef DateFormatterQuarterSymbols( NSDateFormatter *ref )
{ return (__bridge CFArrayRef)[ref quarterSymbols]; }

void DateFormatterSetQuarterSymbols( NSDateFormatter *ref, CFArrayRef symbols )
{ [ref setQuarterSymbols:(__bridge NSArray *)symbols]; }

CFArrayRef DateFormatterShortQuarterSymbols( NSDateFormatter *ref )
{ return (__bridge CFArrayRef)[ref shortQuarterSymbols]; }

void DateFormatterSetShortQuarterSymbols( NSDateFormatter *ref, CFArrayRef symbols )
{ [ref setShortQuarterSymbols:(__bridge NSArray *)symbols]; }

CFArrayRef DateFormatterStandaloneQuarterSymbols( NSDateFormatter *ref )
{ return (__bridge CFArrayRef)[ref standaloneQuarterSymbols]; }

void DateFormatterSetStandaloneQuarterSymbols( NSDateFormatter *ref, CFArrayRef symbols )
{ [ref setStandaloneQuarterSymbols:(__bridge NSArray *)symbols]; }

CFArrayRef DateFormatterShortStandaloneQuarterSymbols( NSDateFormatter *ref )
{ return (__bridge CFArrayRef)[ref shortStandaloneQuarterSymbols]; }

void DateFormatterSetShortStandaloneQuarterSymbols( NSDateFormatter *ref, CFArrayRef symbols )
{ [ref setShortStandaloneQuarterSymbols:(__bridge NSArray *)symbols]; }

// - era symbols -
CFArrayRef DateFormatterEraSymbols( NSDateFormatter *ref )
{ return (__bridge CFArrayRef)[ref eraSymbols]; }

void DateFormatterSetEraSymbols( NSDateFormatter *ref, CFArrayRef symbols )
{ [ref setEraSymbols:(__bridge NSArray *)symbols]; }

CFArrayRef DateFormatterLongEraSymbols( NSDateFormatter *ref )
{ return (__bridge CFArrayRef)[ref longEraSymbols]; }

void DateFormatterSetLongEraSymbols( NSDateFormatter *ref, CFArrayRef symbols )
{ [ref setLongEraSymbols:(__bridge NSArray *)symbols]; }

