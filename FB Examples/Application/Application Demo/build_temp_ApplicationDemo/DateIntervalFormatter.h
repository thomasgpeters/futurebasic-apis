/*
 DateIntervalFormatter.h

 Bernie Wylde
 */


#import "CocoaUI.h"


// Class
Class DateIntervalFormatterClass( void );

// - init -
NSDateIntervalFormatter *DateIntervalFormatterInit( void );

// - formatting -
CFStringRef DateIntervalFormatterStringFromDate( NSDateIntervalFormatter *ref, CFDateRef fromDate, CFDateRef toDate );

// - configure -
NSDateIntervalFormatterStyle DateIntervalFormatterDateStyle( NSDateIntervalFormatter *ref );
void DateIntervalFormatterSetDateStyle( NSDateIntervalFormatter *ref, NSDateIntervalFormatterStyle style );
NSDateIntervalFormatterStyle DateIntervalFormatterTimeStyle( NSDateIntervalFormatter *ref );
void DateIntervalFormatterSetTimeStyle( NSDateIntervalFormatter *ref, NSDateIntervalFormatterStyle style );
CFStringRef DateIntervalFormatterDateTemplate( NSDateIntervalFormatter *ref );
void DateIntervalFormatterSetDateTemplate( NSDateIntervalFormatter *ref, CFStringRef template );
CFCalendarRef DateIntervalFormatterCalendar( NSDateIntervalFormatter *ref );
void DateIntervalFormatterSetCalendar( NSDateIntervalFormatter *ref, CFCalendarRef cal );
CFLocaleRef DateIntervalFormatterLocale( NSDateIntervalFormatter *ref );
void DateIntervalFormatterSetLocale( NSDateIntervalFormatter *ref, CFLocaleRef locale );
CFTimeZoneRef DateIntervalFormatterTimeZone( NSDateIntervalFormatter *ref );
void DateIntervalFormatterSetTimeZone( NSDateIntervalFormatter *ref, CFTimeZoneRef tz );

// - instance -
CFStringRef DateIntervalFormatterStringFromDateInterval( NSDateIntervalFormatter *ref, NSDateInterval *di );


