/*
 Calendar.m
 
 Bernie Wylde
 */

#import "Calendar.h"

// Class
Class CalendarClass( void )
{ return [NSCalendar class]; }

// - create -
CFCalendarRef CalendarWithIdentifier( CFStringRef identifier )
{
#if __has_feature(objc_arc)
    return (__bridge CFCalendarRef)[[NSCalendar alloc] initWithCalendarIdentifier:(__bridge NSString *)identifier];
#else
    return (__bridge CFCalendarRef)[[[NSCalendar alloc] initWithCalendarIdentifier:(__bridge NSString *)identifier] autorelease];
#endif
}

// - user's calendar -
CFCalendarRef CalendarCurrent( void )
{ return (__bridge CFCalendarRef)[NSCalendar currentCalendar]; }

CFCalendarRef CalendarAutoupdatingCurrent( void )
{ return (__bridge CFCalendarRef)[NSCalendar autoupdatingCurrentCalendar]; }

// - components -
BOOL CalendarDateMatches( CFCalendarRef cal, CFDateRef dt, NSDateComponents *comps )
{ return [(__bridge NSCalendar *)cal date:(__bridge NSDate *)dt matchesComponents:comps]; }

NSInteger CalendarComponentFromDate( CFCalendarRef cal, NSUInteger unit, CFDateRef dt )
{ return [(__bridge NSCalendar *)cal component:unit fromDate:(__bridge NSDate *)dt]; }

NSDateComponents *CalendarComponentsFromDate( CFCalendarRef cal, NSUInteger unitFlags, CFDateRef dt )
{ return [(__bridge NSCalendar *)cal components:unitFlags fromDate:(__bridge NSDate *)dt]; }

NSDateComponents *CalendarComponentsFromDateToDate( CFCalendarRef cal, NSUInteger unitFlags, CFDateRef fromDate, CFDateRef toDate, NSUInteger options )
{ return [(__bridge NSCalendar *)cal components:unitFlags fromDate:(__bridge NSDate *)fromDate toDate:(__bridge NSDate *)toDate options:options]; }

NSDateComponents *CalendarComponentsFromDateComponentsToDateComponents( CFCalendarRef cal, NSUInteger unitFlags, NSDateComponents *fromComps, NSDateComponents *toComps, NSCalendarOptions options )
{ return [(__bridge NSCalendar *)cal components:unitFlags fromDateComponents:fromComps toDateComponents:toComps options:options]; }

NSDateComponents *CalendarComponentsInTimeZoneFromDate( CFCalendarRef cal, CFTimeZoneRef zone, CFDateRef dt )
{ return [(__bridge NSCalendar *)cal componentsInTimeZone:(__bridge NSTimeZone *)zone fromDate:(__bridge NSDate *)dt]; }

void CalendarGetEraYearMonthDayFromDate( CFCalendarRef cal, NSInteger *era, NSInteger *year, NSInteger *month, NSInteger *day, CFDateRef dt )
{ [(__bridge NSCalendar *)cal getEra:era year:year month:month day:day fromDate:(__bridge NSDate *)dt]; }

void CalendarGetEraYearForWeekOfYear( CFCalendarRef cal, NSInteger *era, NSInteger *year, NSInteger *weekOfYear, NSInteger *weekday, CFDateRef dt )
{ [(__bridge NSCalendar *)cal getEra:era yearForWeekOfYear:year weekOfYear:weekOfYear weekday:weekday fromDate:(__bridge NSDate *)dt]; }

void CalendarGetHourMinuteSecondNanosecondFromDate( CFCalendarRef cal, NSInteger *hour, NSInteger *min, NSInteger *second, NSInteger *nanosecond, CFDateRef dt )
{ [(__bridge NSCalendar *)cal getHour:hour minute:min second:second nanosecond:nanosecond fromDate:(__bridge NSDate *)dt]; }

// - info -
CFStringRef CalendarIdentifier( CFCalendarRef cal )
{ return (__bridge CFStringRef)[(__bridge NSCalendar *)cal calendarIdentifier]; }

NSUInteger CalendarFirstWeekday( CFCalendarRef cal )
{ return [(__bridge NSCalendar *)cal firstWeekday]; }

void CalendarSetFirstWeekday( CFCalendarRef ref, NSUInteger weekday )
{ [(__bridge NSCalendar *)ref setFirstWeekday:weekday]; }

CFLocaleRef CalendarLocale( CFCalendarRef cal )
{ return (__bridge CFLocaleRef)[(__bridge NSCalendar *)cal locale]; }

void CalendarSetLocale( CFCalendarRef ref, CFLocaleRef locale )
{ [(__bridge NSCalendar *)ref setLocale:(__bridge NSLocale *)locale]; }

CFTimeZoneRef CalendarTimeZone( CFCalendarRef cal )
{ return (__bridge CFTimeZoneRef)[(__bridge NSCalendar *)cal timeZone]; }

void CalendarSetTimeZone( CFCalendarRef ref, CFTimeZoneRef tz )
{ [(__bridge NSCalendar *)ref setTimeZone:(__bridge NSTimeZone *)tz]; }

CFRange CalendarMaximumRangeOfUnit( CFCalendarRef cal, NSCalendarUnit unit )
{
    NSRange range = [(__bridge NSCalendar *)cal maximumRangeOfUnit:unit];
    return NSRangeToCFRange( range );
}

CFRange CalendarMinimumRangeOfUnit( CFCalendarRef cal, NSCalendarUnit unit )
{
    NSRange range = [(__bridge NSCalendar *)cal minimumRangeOfUnit:unit];
    return NSRangeToCFRange( range );
}

NSUInteger CalendarMinimumDaysInFirstWeek( CFCalendarRef cal )
{ return [(__bridge NSCalendar *)cal minimumDaysInFirstWeek]; }

void CalendarSetMinimumDaysInFirstWeek( CFCalendarRef ref, NSUInteger days )
{ [(__bridge NSCalendar *)ref setMinimumDaysInFirstWeek:days]; }

NSUInteger CalendarOrdinalityOfUnitInUnit( CFCalendarRef cal, NSUInteger ofUnit, NSUInteger inUnit, CFDateRef dt )
{ return [(__bridge NSCalendar *)cal ordinalityOfUnit:ofUnit inUnit:inUnit forDate:(__bridge NSDate *)dt]; }

CFRange CalendarRangeOfUnitInUnit( CFCalendarRef cal, NSUInteger ofUnit, NSUInteger inUnit, CFDateRef dt )
{
    NSRange range = [(__bridge NSCalendar *)cal rangeOfUnit:ofUnit inUnit:inUnit forDate:(__bridge NSDate *)dt];
    return NSRangeToCFRange( range );
}

BOOL CalendarRangeOfUnit( CFCalendarRef cal, NSUInteger unit, CFDateRef *startDate, CFTimeInterval *interval, CFDateRef forDate )
{
    NSDate *tempStartDate = nil;
    BOOL flag = [(__bridge NSCalendar *)cal rangeOfUnit:unit startDate:&tempStartDate interval:interval forDate:(__bridge NSDate *)forDate];
    if ( startDate ) *startDate = (__bridge CFDateRef)tempStartDate;
    return flag;
}

BOOL CalendarRangeOfWeekend( CFCalendarRef cal, CFDateRef *startDate, CFTimeInterval *interval, CFDateRef containingDate )
{
    NSDate *tempStartDate = nil;
    BOOL flag = [(__bridge NSCalendar *)cal rangeOfWeekendStartDate:&tempStartDate interval:interval containingDate:(__bridge NSDate *)containingDate];
    if ( startDate ) *startDate = (__bridge CFDateRef)tempStartDate;
    return flag;
}

// - scanning dates -
CFDateRef CalendarStartOfDayForDate( CFCalendarRef cal, CFDateRef dt )
{ return (__bridge CFDateRef)[(__bridge NSCalendar *)cal startOfDayForDate:(__bridge NSDate *)dt]; }

void CalendarEnumerateDates( CFCalendarRef cal, CFDateRef startDate, NSDateComponents *matchingComponents, NSUInteger options, CUI_CalendarEnumerateDatesCallbackType callback, void *userData )
{
    [(__bridge NSCalendar *)cal enumerateDatesStartingAfterDate:(__bridge NSDate *)startDate matchingComponents:matchingComponents options:options usingBlock:^(NSDate *date, BOOL exactMatch, BOOL *stop) {
        (*callback)(cal,(__bridge CFDateRef)date,exactMatch,stop,userData);
    }];
}

CFDateRef CalendarNextDateAfterDateMatchingComponents( CFCalendarRef cal, CFDateRef dt, NSDateComponents *comps, NSCalendarOptions options )
{ return (__bridge CFDateRef)[(__bridge NSCalendar *)cal nextDateAfterDate:(__bridge NSDate *)dt matchingComponents:comps options:options]; }

CFDateRef CalendarNextDateAfterDateMatchingHourMinuteSeconds( CFCalendarRef cal, CFDateRef dt, NSInteger hour, NSInteger minute, NSInteger second, NSCalendarOptions options )
{ return (__bridge CFDateRef)[(__bridge NSCalendar *)cal nextDateAfterDate:(__bridge NSDate *)dt matchingHour:hour minute:minute second:second options:options]; }

CFDateRef CalendarNextDateAfterDateMatchingUnit( CFCalendarRef cal, CFDateRef dt, NSUInteger unit, NSInteger value, NSCalendarOptions options )
{ return (__bridge CFDateRef)[(__bridge NSCalendar *)cal nextDateAfterDate:(__bridge NSDate *)dt matchingUnit:unit value:value options:options]; }

// - calculating dates -
CFDateRef CalendarDateFromComponents( CFCalendarRef cal, NSDateComponents *comps )
{ return (__bridge CFDateRef)[(__bridge NSCalendar *)cal dateFromComponents:comps]; }

CFDateRef CalendarDateByAddingComponents( CFCalendarRef cal, NSDateComponents *comps, CFDateRef dt, NSUInteger options )
{ return (__bridge CFDateRef)[(__bridge NSCalendar *)cal dateByAddingComponents:comps toDate:(__bridge NSDate *)dt options:options]; }

CFDateRef CalendarDateByAddingUnit( CFCalendarRef cal, NSUInteger unit, NSInteger value, CFDateRef dt, NSCalendarOptions options )
{ return (__bridge CFDateRef)[(__bridge NSCalendar *)cal dateByAddingUnit:unit value:value toDate:(__bridge NSDate *)dt options:options]; }

CFDateRef CalendarDateBySettingHourMinuteSecond( CFCalendarRef cal, NSInteger hour, NSInteger minute, NSInteger second, CFDateRef dt, NSCalendarOptions options )
{ return (__bridge CFDateRef)[(__bridge NSCalendar *)cal dateBySettingHour:hour minute:minute second:second ofDate:(__bridge NSDate *)dt options:options]; }

CFDateRef CalendarDateBySettingUnit( CFCalendarRef cal, NSUInteger unit, NSInteger value, CFDateRef dt, NSCalendarOptions options )
{ return (__bridge CFDateRef)[(__bridge NSCalendar *)cal dateBySettingUnit:unit value:value ofDate:(__bridge NSDate *)dt options:options]; }

CFDateRef CalendarDateWithEra( CFCalendarRef cal, NSInteger era, NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minute, NSInteger second, NSInteger nanosecond )
{ return (__bridge CFDateRef)[(__bridge NSCalendar *)cal dateWithEra:era year:year month:month day:day hour:hour minute:minute second:second nanosecond:nanosecond]; }

CFDateRef CalendarDateWithEraYearForWeekOfYear( CFCalendarRef cal, NSInteger era, NSInteger year, NSInteger week, NSInteger weekday, NSInteger hour, NSInteger minute, NSInteger second, NSInteger nanosecond )
{ return (__bridge CFDateRef)[(__bridge NSCalendar *)cal dateWithEra:era yearForWeekOfYear:year weekOfYear:week weekday:weekday hour:hour minute:minute second:second nanosecond:nanosecond]; }

BOOL CalendarNextWeekendStartDate( CFCalendarRef cal, CFDateRef *dt, CFTimeInterval *interval, NSCalendarOptions options, CFDateRef afterDate )
{
    NSDate *tempDt = nil;
    BOOL flag = [(__bridge NSCalendar *)cal nextWeekendStartDate:&tempDt interval:interval options:options afterDate:(__bridge NSDate *)afterDate];
    if ( dt ) *dt = (__bridge CFDateRef)tempDt;
    return flag;
}

// - comparing dates -
NSComparisonResult CalendarCompareDateToDate( CFCalendarRef cal, CFDateRef dt1, CFDateRef dt2, NSCalendarUnit unit )
{ return [(__bridge NSCalendar *)cal compareDate:(__bridge NSDate *)dt1 toDate:(__bridge NSDate *)dt2 toUnitGranularity:unit]; }

BOOL CalendarIsDateEqualToDate( CFCalendarRef cal, CFDateRef dt1, CFDateRef dt2, NSCalendarUnit unit )
{ return [(__bridge NSCalendar *)cal isDate:(__bridge NSDate *)dt1 equalToDate:(__bridge NSDate *)dt2 toUnitGranularity:unit]; }

BOOL CalendarIsDateInSameDayAsDate( CFCalendarRef cal, CFDateRef dt1, CFDateRef dt2 )
{ return [(__bridge NSCalendar *)cal isDate:(__bridge NSDate *)dt1 inSameDayAsDate:(__bridge NSDate *)dt2]; }

BOOL CalendarIsDateInToday( CFCalendarRef cal, CFDateRef dt )
{ return [(__bridge NSCalendar *)cal isDateInToday:(__bridge NSDate *)dt]; }

BOOL CalendarIsDateInTomorrow( CFCalendarRef cal, CFDateRef dt )
{ return [(__bridge NSCalendar *)cal isDateInTomorrow:(__bridge NSDate *)dt]; }

BOOL CalendarIsDateInWeekend( CFCalendarRef cal, CFDateRef dt )
{ return [(__bridge NSCalendar *)cal isDateInWeekend:(__bridge NSDate *)dt]; }

BOOL CalendarIsDateInYesterday( CFCalendarRef cal, CFDateRef dt )
{ return [(__bridge NSCalendar *)cal isDateInYesterday:(__bridge NSDate *)dt]; }

// - am and pm symbols
CFStringRef CalendarAMSymbol( CFCalendarRef cal )
{ return (__bridge CFStringRef)[(__bridge NSCalendar *)cal AMSymbol]; }

CFStringRef CalendarPMSymbol( CFCalendarRef cal )
{ return (__bridge CFStringRef)[(__bridge NSCalendar *)cal PMSymbol]; }

// - weekday symbols -
CFArrayRef CalendarWeekdaySymbols( CFCalendarRef cal )
{ return (__bridge CFArrayRef)[(__bridge NSCalendar *)cal weekdaySymbols]; }

CFArrayRef CalendarShortWeekdaySymbols( CFCalendarRef cal )
{ return (__bridge CFArrayRef)[(__bridge NSCalendar *)cal shortWeekdaySymbols]; }

CFArrayRef CalendarVeryShortWeekdaySymbols( CFCalendarRef cal )
{ return (__bridge CFArrayRef)[(__bridge NSCalendar *)cal veryShortWeekdaySymbols]; }

CFArrayRef CalendarStandaloneWeekdaySymbols( CFCalendarRef cal )
{ return (__bridge CFArrayRef)[(__bridge NSCalendar *)cal standaloneWeekdaySymbols]; }

CFArrayRef CalendarShortStandaloneWeekdaySymbols( CFCalendarRef cal )
{ return (__bridge CFArrayRef)[(__bridge NSCalendar *)cal shortStandaloneWeekdaySymbols]; }

CFArrayRef CalendarVeryShortStandaloneWeekdaySymbols( CFCalendarRef cal )
{ return (__bridge CFArrayRef)[(__bridge NSCalendar *)cal veryShortStandaloneWeekdaySymbols]; }

// - month symbols -
CFArrayRef CalendarMonthSymbols( CFCalendarRef cal )
{ return (__bridge CFArrayRef)[(__bridge NSCalendar *)cal monthSymbols]; }

CFArrayRef CalendarShortMonthSymbols( CFCalendarRef cal )
{ return (__bridge CFArrayRef)[(__bridge NSCalendar *)cal shortMonthSymbols]; }

CFArrayRef CalendarVeryShortMonthSymbols( CFCalendarRef cal )
{ return (__bridge CFArrayRef)[(__bridge NSCalendar *)cal veryShortMonthSymbols]; }

CFArrayRef CalendarStandaloneMonthSymbols( CFCalendarRef cal )
{ return (__bridge CFArrayRef)[(__bridge NSCalendar *)cal standaloneMonthSymbols]; }

CFArrayRef CalendarShortStandaloneMonthSymbols( CFCalendarRef cal )
{ return (__bridge CFArrayRef)[(__bridge NSCalendar *)cal shortStandaloneMonthSymbols]; }

CFArrayRef CalendarVeryShortStandaloneMonthSymbols( CFCalendarRef cal )
{ return (__bridge CFArrayRef)[(__bridge NSCalendar *)cal veryShortStandaloneMonthSymbols]; }

// - quarter symbols -
CFArrayRef CalendarQuarterSymbols( CFCalendarRef cal )
{ return (__bridge CFArrayRef)[(__bridge NSCalendar *)cal quarterSymbols]; }

CFArrayRef CalendarShortQuarterSymbols( CFCalendarRef cal )
{ return (__bridge CFArrayRef)[(__bridge NSCalendar *)cal shortQuarterSymbols]; }

CFArrayRef CalendarStandaloneQuarterSymbols( CFCalendarRef cal )
{ return (__bridge CFArrayRef)[(__bridge NSCalendar *)cal standaloneQuarterSymbols]; }

CFArrayRef CalendarShortStandaloneQuarterSymbols( CFCalendarRef cal )
{ return (__bridge CFArrayRef)[(__bridge NSCalendar *)cal shortStandaloneQuarterSymbols]; }

// - era symbols -
CFArrayRef CalendarEraSymbols( CFCalendarRef cal )
{ return (__bridge CFArrayRef)[(__bridge NSCalendar *)cal eraSymbols]; }

CFArrayRef CalendarLongEraSymbols( CFCalendarRef cal )
{ return (__bridge CFArrayRef)[(__bridge NSCalendar *)cal longEraSymbols]; }


#pragma mark - date components

// - init -
NSDateComponents *DateComponentsInit( void )
{
#if __has_feature(objc_arc)
    return [[NSDateComponents alloc] init];
#else
    return [[[NSDateComponents alloc] init] autorelease];
#endif
}

// - calendar and time zone -
CFCalendarRef DateComponentsCalendar( NSDateComponents *ref )
{ return (__bridge CFCalendarRef)[ref calendar]; }

void DateComponentsSetCalendar( NSDateComponents *ref, CFCalendarRef cal )
{ [ref setCalendar:(__bridge NSCalendar *)cal]; }

CFTimeZoneRef DateComponentsTimeZone( NSDateComponents *ref )
{ return (__bridge CFTimeZoneRef)[ref timeZone]; }

void DateComponentsSetTimeZone( NSDateComponents *ref, CFTimeZoneRef tz )
{ [ref setTimeZone:(__bridge NSTimeZone *)tz]; }

// - validate date -
BOOL DateComponentsIsValidDate( NSDateComponents *ref )
{ return [ref isValidDate]; }

BOOL DateComponentsIsValidDateInCalendar( NSDateComponents *ref, CFCalendarRef cal )
{ return [ref isValidDateInCalendar:(__bridge NSCalendar *)cal]; }

CFDateRef DateComponentsDate( NSDateComponents *ref )
{ return (__bridge CFDateRef)[ref date]; }

// - years and months -
NSInteger DateComponentsEra( NSDateComponents *ref )
{ return [ref era]; }

void DateComponentsSetEra( NSDateComponents *ref, NSInteger era )
{ [ref setEra:era]; }

NSInteger DateComponentsYear( NSDateComponents *ref )
{ return [ref year]; }

void DateComponentsSetYear( NSDateComponents *ref, NSInteger year )
{ [ref setYear:year]; }

NSInteger DateComponentsYearForWeekOfYear( NSDateComponents *ref )
{ return [ref yearForWeekOfYear]; }

void DateComponentsSetYearForWeekOfYear( NSDateComponents *ref, NSInteger year )
{ [ref setYearForWeekOfYear:year]; }

NSInteger DateComponentsQuarter( NSDateComponents *ref )
{ return [ref quarter]; }

void DateComponentsSetQuarter( NSDateComponents *ref, NSInteger quarter )
{ [ref setQuarter:quarter]; }

NSInteger DateComponentsMonth( NSDateComponents *ref )
{ return [ref month]; }

void DateComponentsSetMonth( NSDateComponents *ref, NSInteger month )
{ [ref setMonth:month]; }

BOOL DateComponentsIsLeapMonth( NSDateComponents *ref )
{ return [ref isLeapMonth]; }

void DateComponentsSetLeapMonth( NSDateComponents *ref, BOOL flag )
{ [ref setLeapMonth:flag]; }

// - weeks and days -
NSInteger DateComponentsWeekday( NSDateComponents *ref )
{ return [ref weekday]; }

void DateComponentsSetWeekday( NSDateComponents *ref, NSInteger day )
{ [ref setWeekday:day]; }

NSInteger DateComponentsWeekdayOrdinal( NSDateComponents *ref )
{ return [ref weekdayOrdinal]; }

void DateComponentsSetWeekdayOrdinal( NSDateComponents *ref, NSInteger day )
{ [ref setWeekdayOrdinal:day]; }

NSInteger DateComponentsWeekOfMonth( NSDateComponents *ref )
{ return [ref weekOfMonth]; }

void DateComponentsSetWeekOfMonth( NSDateComponents *ref, NSInteger week )
{ [ref setWeekOfMonth:week]; }

NSInteger DateComponentsWeekOfYear( NSDateComponents *ref )
{ return [ref weekOfYear]; }

void DateComponentsSetWeekOfYear( NSDateComponents *ref, NSInteger week )
{ [ref setWeekOfYear:week]; }

NSInteger DateComponentsDay( NSDateComponents *ref )
{ return [ref day]; }

void DateComponentsSetDay( NSDateComponents *ref, NSInteger day )
{ [ref setDay:day]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
NSInteger DateComponentsDayOfYear( DateComponentsRef ref )
{ return [ref dayOfYear]; }

void DateComponentsSetDayOfYear( DateComponentsRef ref, NSInteger value )
{ [ref setDayOfYear:value]; }
#endif // 150000

// - hours and seconds -
NSInteger DateComponentsHour( NSDateComponents *ref )
{ return [ref hour]; }

void DateComponentsSetHour( NSDateComponents *ref, NSInteger hour )
{ [ref setHour:hour]; }

NSInteger DateComponentsMinute( NSDateComponents *ref )
{ return [ref minute]; }

void DateComponentsSetMinute( NSDateComponents *ref, NSInteger minute )
{ [ref setMinute:minute]; }

NSInteger DateComponentsSecond( NSDateComponents *ref )
{ return [ref second]; }

void DateComponentsSetSecond( NSDateComponents *ref, NSInteger second )
{ [ref setSecond:second]; }

NSInteger DateComponentsNanosecond( NSDateComponents *ref )
{ return [ref nanosecond]; }

void DateComponentsSetNanosecond( NSDateComponents *ref, NSInteger nanosecond )
{ [ref setNanosecond:nanosecond]; }

// - components as calendrical units -
NSInteger DateComponentsValueForComponent( NSDateComponents *ref, NSCalendarUnit unit )
{ return [ref valueForComponent:unit]; }

void DateComponentsSetValueForComponent( NSDateComponents *ref, NSInteger value, NSCalendarUnit unit )
{ [ref setValue:value forComponent:unit]; }

