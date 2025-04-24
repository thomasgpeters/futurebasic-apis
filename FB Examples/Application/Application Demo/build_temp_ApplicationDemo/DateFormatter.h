/*
 DateFormatter.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class DateFormatterClass( void );

// - init -
NSDateFormatter *DateFormatterInit( void );
NSDateFormatter *DateFormatterWithFormat( CFStringRef format );

// - converting objects -
CFDateRef DateFormatterDateFromString( NSDateFormatter *ref, CFStringRef string );
CFStringRef DateFormatterStringFromDate( NSDateFormatter *ref, CFDateRef dt );
CFStringRef DateFormatterLocalizedStringFromDate( CFDateRef dt, NSDateFormatterStyle dateStyle, NSDateFormatterStyle timeStyle );
BOOL DateFormatterGetObjectValueForString( NSDateFormatter *ref, CFTypeRef *obj, CFStringRef string, CFRange *inOutRange, NSError **err );

// - format and style
NSDateFormatterStyle DateFormatterDateStyle( NSDateFormatter *ref );
void DateFormatterSetDateStyle( NSDateFormatter *ref, NSDateFormatterStyle style );
NSDateFormatterStyle DateFormatterTimeStyle( NSDateFormatter *ref );
void DateFormatterSetTimeStyle( NSDateFormatter *ref, NSDateFormatterStyle style );
CFStringRef DateFormatterDateFormat( NSDateFormatter *ref );
void DateFormatterSetDateFormat( NSDateFormatter *ref, CFStringRef format );

void DateFormatterSetLocalizedDateFormatFromTemplate( NSDateFormatter *ref, CFStringRef template );

CFStringRef DateFormatterDateFormatFromTemplate( CFStringRef template, NSUInteger options, CFLocaleRef locale );

NSFormattingContext DateFormatterFormattingContext( NSDateFormatter *ref );
void DateFormatterSetFormattingContext( NSDateFormatter *ref, NSFormattingContext ctx );

// - attributes -
CFCalendarRef DateFormatterCalendar( NSDateFormatter *ref );
void DateFormatterSetCalendar( NSDateFormatter *ref, CFCalendarRef cal );
CFDateRef DateFormatterDefaultDate( NSDateFormatter *ref );
void DateFormatterSetDefaultDate( NSDateFormatter *ref, CFDateRef dt );
CFLocaleRef DateFormatterLocale( NSDateFormatter *ref );
void DateFormatterSetLocale( NSDateFormatter *ref, CFLocaleRef locale );
CFTimeZoneRef DateFormatterTimeZone( NSDateFormatter *ref );
void DateFormatterSetTimeZone( NSDateFormatter *ref, CFTimeZoneRef zone );
CFDateRef DateFormatterTwoDigitStartDate( NSDateFormatter *ref );
void DateFormatterSetTwoDigitStartDate( NSDateFormatter *ref, CFDateRef dt );
CFDateRef DateFormatterGregorianStartDate( NSDateFormatter *ref );
void DateFormatterSetGregorianStartDate( NSDateFormatter *ref, CFDateRef dt );

// - behavior -
NSDateFormatterBehavior DateFormatterBehavior( NSDateFormatter *ref );
void DateFormatterSetBehavior( NSDateFormatter *ref, NSDateFormatterBehavior behavior );
NSDateFormatterBehavior DateFormatterDefaultBehavior( void );
void DateFormatterSetDefaultBehavior( NSDateFormatterBehavior behavior );

// - natural language -
BOOL DateFormatterIsLenient( NSDateFormatter *ref );
void DateFormatterSetLenient( NSDateFormatter *ref, BOOL flag );
BOOL DateFormatterDoesRelativeDateFormatting( NSDateFormatter *ref );
void DateFormatterSetDoesRelativeDateFormatting( NSDateFormatter *ref, BOOL flag );

// - am and pm symbols -
CFStringRef DateFormatterAMSymbol( NSDateFormatter *ref );
void DateFormatterSetAMSymbol( NSDateFormatter *ref, CFStringRef symbol );
CFStringRef DateFormatterPMSymbol( NSDateFormatter *ref );
void DateFormatterSetPMSymbol( NSDateFormatter *ref, CFStringRef symbol );

// - weekday symbols -
CFArrayRef DateFormatterWeekdaySymbols( NSDateFormatter *ref );
void DateFormatterSetWeekdaySymbols( NSDateFormatter *ref, CFArrayRef symbols );
CFArrayRef DateFormatterShortWeekdaySymbols( NSDateFormatter *ref );
void DateFormatterSetShortWeekdaySymbols( NSDateFormatter *ref, CFArrayRef symbols );
CFArrayRef DateFormatterVeryShortWeekdaySymbols( NSDateFormatter *ref );
void DateFormatterSetVeryShortWeekdaySymbols( NSDateFormatter *ref, CFArrayRef symbols );
CFArrayRef DateFormatterStandaloneWeekdaySymbols( NSDateFormatter *ref );
void DateFormatterSetStandaloneWeekdaySymbols( NSDateFormatter *ref, CFArrayRef symbols );
CFArrayRef DateFormatterShortStandaloneWeekdaySymbols( NSDateFormatter *ref );
void DateFormatterSetShortStandaloneWeekdaySymbols( NSDateFormatter *ref, CFArrayRef symbols );
CFArrayRef DateFormatterVeryShortStandaloneWeekdaySymbols( NSDateFormatter *ref );
void DateFormatterSetVeryShortStandaloneWeekdaySymbols( NSDateFormatter *ref, CFArrayRef symbols );

// - month symbols -
CFArrayRef DateFormatterMonthSymbols( NSDateFormatter *ref );
void DateFormatterSetMonthSymbols( NSDateFormatter *ref, CFArrayRef symbols );
CFArrayRef DateFormatterShortMonthSymbols( NSDateFormatter *ref );
void DateFormatterSetShortMonthSymbols( NSDateFormatter *ref, CFArrayRef symbols );
CFArrayRef DateFormatterVeryShortMonthSymbols( NSDateFormatter *ref );
void DateFormatterSetVeryShortMonthSymbols( NSDateFormatter *ref, CFArrayRef symbols );
CFArrayRef DateFormatterStandaloneMonthSymbols( NSDateFormatter *ref );
void DateFormatterSetStandaloneMonthSymbols( NSDateFormatter *ref, CFArrayRef symbols );
CFArrayRef DateFormatterShortStandaloneMonthSymbols( NSDateFormatter *ref );
void DateFormatterSetShortStandaloneMonthSymbols( NSDateFormatter *ref, CFArrayRef symbols );
CFArrayRef DateFormatterVeryShortStandaloneMonthSymbols( NSDateFormatter *ref );
void DateFormatterSetVeryShortStandaloneMonthSymbols( NSDateFormatter *ref, CFArrayRef symbols );

// - quarter symbols -
CFArrayRef DateFormatterQuarterSymbols( NSDateFormatter *ref );
void DateFormatterSetQuarterSymbols( NSDateFormatter *ref, CFArrayRef symbols );
CFArrayRef DateFormatterShortQuarterSymbols( NSDateFormatter *ref );
void DateFormatterSetShortQuarterSymbols( NSDateFormatter *ref, CFArrayRef symbols );
CFArrayRef DateFormatterStandaloneQuarterSymbols( NSDateFormatter *ref );
void DateFormatterSetStandaloneQuarterSymbols( NSDateFormatter *ref, CFArrayRef symbols );
CFArrayRef DateFormatterShortStandaloneQuarterSymbols( NSDateFormatter *ref );
void DateFormatterSetShortStandaloneQuarterSymbols( NSDateFormatter *ref, CFArrayRef symbols );

// - era symbols -
CFArrayRef DateFormatterEraSymbols( NSDateFormatter *ref );
void DateFormatterSetEraSymbols( NSDateFormatter *ref, CFArrayRef symbols );
CFArrayRef DateFormatterLongEraSymbols( NSDateFormatter *ref );
void DateFormatterSetLongEraSymbols( NSDateFormatter *ref, CFArrayRef symbols );

