/*
 Calendar.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

typedef void (*CUI_CalendarEnumerateDatesCallbackType)(CFCalendarRef,CFDateRef,BOOL,BOOL*,void*);

// Class
Class CalendarClass( void );

// - create -
CFCalendarRef CalendarWithIdentifier( CFStringRef identifier );

// - user's calendar -
CFCalendarRef CalendarCurrent( void );
CFCalendarRef CalendarAutoupdatingCurrent( void );

// - components -
BOOL CalendarDateMatches( CFCalendarRef cal, CFDateRef dt, NSDateComponents *comps );
NSInteger CalendarComponentFromDate( CFCalendarRef cal, NSUInteger unit, CFDateRef dt );
NSDateComponents *CalendarComponentsFromDate( CFCalendarRef cal, NSUInteger unitFlags, CFDateRef dt );
NSDateComponents *CalendarComponentsFromDateToDate( CFCalendarRef cal, NSUInteger unitFlags, CFDateRef fromDate, CFDateRef toDate, NSUInteger options );
NSDateComponents *CalendarComponentsFromDateComponentsToDateComponents( CFCalendarRef cal, NSUInteger unitFlags, NSDateComponents *fromComps, NSDateComponents *toComps, NSCalendarOptions options );
NSDateComponents *CalendarComponentsInTimeZoneFromDate( CFCalendarRef cal, CFTimeZoneRef zone, CFDateRef dt );
void CalendarGetEraYearMonthDayFromDate( CFCalendarRef cal, NSInteger *era, NSInteger *year, NSInteger *month, NSInteger *day, CFDateRef dt );
void CalendarGetEraYearForWeekOfYear( CFCalendarRef cal, NSInteger *era, NSInteger *year, NSInteger *weekOfYear, NSInteger *weekday, CFDateRef dt );
void CalendarGetHourMinuteSecondNanosecondFromDate( CFCalendarRef cal, NSInteger *hour, NSInteger *min, NSInteger *second, NSInteger *nanosecond, CFDateRef dt );

// - info -
CFStringRef CalendarIdentifier( CFCalendarRef cal );
NSUInteger CalendarFirstWeekday( CFCalendarRef cal );
void CalendarSetFirstWeekday( CFCalendarRef ref, NSUInteger weekday );
CFLocaleRef CalendarLocale( CFCalendarRef cal );
void CalendarSetLocale( CFCalendarRef ref, CFLocaleRef locale );
CFTimeZoneRef CalendarTimeZone( CFCalendarRef cal );
void CalendarSetTimeZone( CFCalendarRef ref, CFTimeZoneRef tz );
CFRange CalendarMaximumRangeOfUnit( CFCalendarRef cal, NSCalendarUnit unit );
CFRange CalendarMinimumRangeOfUnit( CFCalendarRef cal, NSCalendarUnit unit );
NSUInteger CalendarMinimumDaysInFirstWeek( CFCalendarRef cal );
void CalendarSetMinimumDaysInFirstWeek( CFCalendarRef ref, NSUInteger days );
NSUInteger CalendarOrdinalityOfUnitInUnit( CFCalendarRef cal, NSUInteger ofUnit, NSUInteger inUnit, CFDateRef dt );
CFRange CalendarRangeOfUnitInUnit( CFCalendarRef cal, NSUInteger ofUnit, NSUInteger inUnit, CFDateRef dt );
BOOL CalendarRangeOfUnit( CFCalendarRef cal, NSUInteger unit, CFDateRef *startDate, CFTimeInterval *interval, CFDateRef forDate );
BOOL CalendarRangeOfWeekend( CFCalendarRef cal, CFDateRef *startDate, CFTimeInterval *interval, CFDateRef containingDate );

// - scanning dates -
CFDateRef CalendarStartOfDayForDate( CFCalendarRef cal, CFDateRef dt );
void CalendarEnumerateDates( CFCalendarRef cal, CFDateRef startDate, NSDateComponents *matchingComponents, NSUInteger options, CUI_CalendarEnumerateDatesCallbackType callback, void *userData );
CFDateRef CalendarNextDateAfterDateMatchingComponents( CFCalendarRef cal, CFDateRef dt, NSDateComponents *comps, NSCalendarOptions options );
CFDateRef CalendarNextDateAfterDateMatchingHourMinuteSeconds( CFCalendarRef cal, CFDateRef dt, NSInteger hour, NSInteger minute, NSInteger second, NSCalendarOptions options );
CFDateRef CalendarNextDateAfterDateMatchingUnit( CFCalendarRef cal, CFDateRef dt, NSUInteger unit, NSInteger value, NSCalendarOptions options );

// - calculating dates -
CFDateRef CalendarDateFromComponents( CFCalendarRef cal, NSDateComponents *comps );
CFDateRef CalendarDateByAddingComponents( CFCalendarRef cal, NSDateComponents *comps, CFDateRef dt, NSUInteger options );
CFDateRef CalendarDateByAddingUnit( CFCalendarRef cal, NSUInteger unit, NSInteger value, CFDateRef dt, NSCalendarOptions options );
CFDateRef CalendarDateBySettingHourMinuteSecond( CFCalendarRef cal, NSInteger hour, NSInteger minute, NSInteger second, CFDateRef dt, NSCalendarOptions options );
CFDateRef CalendarDateBySettingUnit( CFCalendarRef cal, NSUInteger unit, NSInteger value, CFDateRef dt, NSCalendarOptions options );
CFDateRef CalendarDateWithEra( CFCalendarRef cal, NSInteger era, NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minute, NSInteger second, NSInteger nanosecond );
CFDateRef CalendarDateWithEraYearForWeekOfYear( CFCalendarRef cal, NSInteger era, NSInteger year, NSInteger week, NSInteger weekday, NSInteger hour, NSInteger minute, NSInteger second, NSInteger nanosecond );
BOOL CalendarNextWeekendStartDate( CFCalendarRef cal, CFDateRef *dt, CFTimeInterval *interval, NSCalendarOptions options, CFDateRef afterDate );

// - comparing dates -
NSComparisonResult CalendarCompareDateToDate( CFCalendarRef cal, CFDateRef dt1, CFDateRef dt2, NSCalendarUnit unit );
BOOL CalendarIsDateEqualToDate( CFCalendarRef cal, CFDateRef dt1, CFDateRef dt2, NSCalendarUnit unit );
BOOL CalendarIsDateInSameDayAsDate( CFCalendarRef cal, CFDateRef dt1, CFDateRef dt2 );
BOOL CalendarIsDateInToday( CFCalendarRef cal, CFDateRef dt );
BOOL CalendarIsDateInTomorrow( CFCalendarRef cal, CFDateRef dt );
BOOL CalendarIsDateInWeekend( CFCalendarRef cal, CFDateRef dt );
BOOL CalendarIsDateInYesterday( CFCalendarRef cal, CFDateRef dt );

// - am and pm symbols
CFStringRef CalendarAMSymbol( CFCalendarRef cal );
CFStringRef CalendarPMSymbol( CFCalendarRef cal );

// - weekday symbols -
CFArrayRef CalendarWeekdaySymbols( CFCalendarRef cal );
CFArrayRef CalendarShortWeekdaySymbols( CFCalendarRef cal );
CFArrayRef CalendarVeryShortWeekdaySymbols( CFCalendarRef cal );
CFArrayRef CalendarStandaloneWeekdaySymbols( CFCalendarRef cal );
CFArrayRef CalendarShortStandaloneWeekdaySymbols( CFCalendarRef cal );
CFArrayRef CalendarVeryShortStandaloneWeekdaySymbols( CFCalendarRef cal );

// - month symbols -
CFArrayRef CalendarMonthSymbols( CFCalendarRef cal );
CFArrayRef CalendarShortMonthSymbols( CFCalendarRef cal );
CFArrayRef CalendarVeryShortMonthSymbols( CFCalendarRef cal );
CFArrayRef CalendarStandaloneMonthSymbols( CFCalendarRef cal );
CFArrayRef CalendarShortStandaloneMonthSymbols( CFCalendarRef cal );
CFArrayRef CalendarVeryShortStandaloneMonthSymbols( CFCalendarRef cal );

// - quarter symbols -
CFArrayRef CalendarQuarterSymbols( CFCalendarRef cal );
CFArrayRef CalendarShortQuarterSymbols( CFCalendarRef cal );
CFArrayRef CalendarStandaloneQuarterSymbols( CFCalendarRef cal );
CFArrayRef CalendarShortStandaloneQuarterSymbols( CFCalendarRef cal );

// - era symbols -
CFArrayRef CalendarEraSymbols( CFCalendarRef cal );
CFArrayRef CalendarLongEraSymbols( CFCalendarRef cal );


#pragma mark - date components

// - init -
NSDateComponents *DateComponentsInit( void );

// - calendar and time zone -
CFCalendarRef DateComponentsCalendar( NSDateComponents *ref );
void DateComponentsSetCalendar( NSDateComponents *ref, CFCalendarRef cal );
CFTimeZoneRef DateComponentsTimeZone( NSDateComponents *ref );
void DateComponentsSetTimeZone( NSDateComponents *ref, CFTimeZoneRef tz );

// - validate date -
BOOL DateComponentsIsValidDate( NSDateComponents *ref );
BOOL DateComponentsIsValidDateInCalendar( NSDateComponents *ref, CFCalendarRef cal );
CFDateRef DateComponentsDate( NSDateComponents *ref );

// - years and months -
NSInteger DateComponentsEra( NSDateComponents *ref );
void DateComponentsSetEra( NSDateComponents *ref, NSInteger era );
NSInteger DateComponentsYear( NSDateComponents *ref );
void DateComponentsSetYear( NSDateComponents *ref, NSInteger year );
NSInteger DateComponentsYearForWeekOfYear( NSDateComponents *ref );
void DateComponentsSetYearForWeekOfYear( NSDateComponents *ref, NSInteger year );
NSInteger DateComponentsQuarter( NSDateComponents *ref );
void DateComponentsSetQuarter( NSDateComponents *ref, NSInteger quarter );
NSInteger DateComponentsMonth( NSDateComponents *ref );
void DateComponentsSetMonth( NSDateComponents *ref, NSInteger month );
BOOL DateComponentsIsLeapMonth( NSDateComponents *ref );
void DateComponentsSetLeapMonth( NSDateComponents *ref, BOOL flag );

// - weeks and days -
NSInteger DateComponentsWeekday( NSDateComponents *ref );
void DateComponentsSetWeekday( NSDateComponents *ref, NSInteger day );
NSInteger DateComponentsWeekdayOrdinal( NSDateComponents *ref );
void DateComponentsSetWeekdayOrdinal( NSDateComponents *ref, NSInteger day );
NSInteger DateComponentsWeekOfMonth( NSDateComponents *ref );
void DateComponentsSetWeekOfMonth( NSDateComponents *ref, NSInteger week );
NSInteger DateComponentsWeekOfYear( NSDateComponents *ref );
void DateComponentsSetWeekOfYear( NSDateComponents *ref, NSInteger week );
NSInteger DateComponentsDay( NSDateComponents *ref );
void DateComponentsSetDay( NSDateComponents *ref, NSInteger day );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
API_AVAILABLE(macos(15.0))
NSInteger DateComponentsDayOfYear( DateComponentsRef ref );
API_AVAILABLE(macos(15.0))
void DateComponentsSetDayOfYear( DateComponentsRef ref, NSInteger value );
#endif // 150000

// - hours and seconds -
NSInteger DateComponentsHour( NSDateComponents *ref );
void DateComponentsSetHour( NSDateComponents *ref, NSInteger hour );
NSInteger DateComponentsMinute( NSDateComponents *ref );
void DateComponentsSetMinute( NSDateComponents *ref, NSInteger minute );
NSInteger DateComponentsSecond( NSDateComponents *ref );
void DateComponentsSetSecond( NSDateComponents *ref, NSInteger second );
NSInteger DateComponentsNanosecond( NSDateComponents *ref );
void DateComponentsSetNanosecond( NSDateComponents *ref, NSInteger nanosecond );

// - components as calendrical units -
NSInteger DateComponentsValueForComponent( NSDateComponents *ref, NSCalendarUnit unit );
void DateComponentsSetValueForComponent( NSDateComponents *ref, NSInteger value, NSCalendarUnit unit );

