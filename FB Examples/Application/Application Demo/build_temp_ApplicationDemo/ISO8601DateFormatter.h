/*
 ISO8601DateFormatter.h

 Bernie Wylde
 */

#import "CocoaUI.h"


// Class
Class ISO8601DateFormatterClass( void );

// Init
NSISO8601DateFormatter *ISO8601DateFormatterInit( void );

// Format options
NSISO8601DateFormatOptions ISO8601DateFormatterFormatOptions( NSISO8601DateFormatter *ref );
void ISO8601DateFormatterSetFormatOptions( NSISO8601DateFormatter *ref, NSISO8601DateFormatOptions options );
CFTimeZoneRef ISO8601DateFormatterTimeZone( NSISO8601DateFormatter *ref );
void ISO8601DateFormatterSetTimeZone( NSISO8601DateFormatter *ref, CFTimeZoneRef timeZone );

// Convert
CFStringRef ISO8601DateFormatterStringFromDate( NSISO8601DateFormatter *ref, CFDateRef dt );
CFDateRef ISO8601DateFormatterDateFromString( NSISO8601DateFormatter *ref, CFStringRef string );
CFStringRef ISO8601DateFormatterStringFromDateFormatOptions( CFDateRef dt, CFTimeZoneRef timeZone, NSISO8601DateFormatOptions options );

