/*
 RelativeDateTimeFormatter.h

 Bernie Wylde
 */


#import "CocoaUI.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500

// Class
API_AVAILABLE(macos(10.15))
Class RelativeDateTimeFormatterClass( void );

// Create
API_AVAILABLE(macos(10.15))
NSRelativeDateTimeFormatter *RelativeDateTimeFormatterInit( void );

// Instance properties
API_AVAILABLE(macos(10.15))
CFCalendarRef RelativeDateTimeFormatterCalendar( NSRelativeDateTimeFormatter *ref );
API_AVAILABLE(macos(10.15))
void RelativeDateTimeFormatterSetCalendar( NSRelativeDateTimeFormatter *ref, CFCalendarRef cal );
API_AVAILABLE(macos(10.15))
NSRelativeDateTimeFormatterStyle RelativeDateTimeFormatterStyle( NSRelativeDateTimeFormatter *ref );
API_AVAILABLE(macos(10.15))
void RelativeDateTimeFormatterSetStyle( NSRelativeDateTimeFormatter *ref, NSRelativeDateTimeFormatterStyle style );
API_AVAILABLE(macos(10.15))
NSFormattingContext RelativeDateTimeFormatterFormattingContext( NSRelativeDateTimeFormatter *ref );
API_AVAILABLE(macos(10.15))
void RelativeDateTimeFormatterSetFormattingContext( NSRelativeDateTimeFormatter *ref, NSFormattingContext context );
API_AVAILABLE(macos(10.15))
CFLocaleRef RelativeDateTimeFormatterLocale( NSRelativeDateTimeFormatter *ref );
API_AVAILABLE(macos(10.15))
void RelativeDateTimeFormatterSetLocale( NSRelativeDateTimeFormatter *ref, CFLocaleRef locale );
API_AVAILABLE(macos(10.15))
NSRelativeDateTimeFormatterUnitsStyle RelativeDateTimeFormatterUnitsStyle( NSRelativeDateTimeFormatter *ref );
API_AVAILABLE(macos(10.15))
void RelativeDateTimeFormatterSetUnitsStyle( NSRelativeDateTimeFormatter *ref, NSRelativeDateTimeFormatterUnitsStyle style );

// Instance methods
API_AVAILABLE(macos(10.15))
CFStringRef RelativeDateTimeFormatterLocalizedStringForDate( NSRelativeDateTimeFormatter *ref, CFDateRef dt, CFDateRef referenceDate );
API_AVAILABLE(macos(10.15))
CFStringRef RelativeDateTimeFormatterLocalizedStringFromDateComponents( NSRelativeDateTimeFormatter *ref, NSDateComponents *components );
API_AVAILABLE(macos(10.15))
CFStringRef RelativeDateTimeFormatterLocalizedStringFromTimeInterval( NSRelativeDateTimeFormatter *ref, CFTimeInterval ti );
API_AVAILABLE(macos(10.15))
CFStringRef RelativeDateTimeFormatterStringForObjectValue( NSRelativeDateTimeFormatter *ref, CFTypeRef obj );

#endif// 101500
