/*
 TimeZone.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class TimeZoneClass( void );

// System time zones
CFTimeZoneRef TimeZoneLocal( void );
CFTimeZoneRef TimeZoneSystem( void );
void TimeZoneResetSystem( void );
CFTimeZoneRef TimeZoneDefault( void );
void TimeZoneSetDefault( CFTimeZoneRef timeZone );

// Create
CFTimeZoneRef TimeZoneWithName( CFStringRef name );
CFTimeZoneRef TimeZoneWithNameAndData( CFStringRef name, CFDataRef dta );
CFTimeZoneRef TimeZoneWithAbbreviation( CFStringRef abbreviation );
CFTimeZoneRef TimeZoneForSecondsFromGMT( NSInteger seconds );
CFArrayRef TimeZoneKnownNames( void );
CFDictionaryRef TimeZoneAbbreviationDictionary( void );

// Info
CFStringRef TimeZoneName( CFTimeZoneRef ref );
CFStringRef TimeZoneAbbreviation( CFTimeZoneRef ref );
CFStringRef TimeZoneAbbreviationForDate( CFTimeZoneRef ref, CFDateRef dt );
NSInteger TimeZoneSecondsFromGMT( CFTimeZoneRef ref );
NSInteger TimeZoneSecondsFromGMTForDate( CFTimeZoneRef ref, CFDateRef dt );
CFDataRef TimeZoneData( CFTimeZoneRef ref );
CFStringRef TimeZoneDataVersion( void );

// Daylight savings
BOOL TimeZoneIsDaylightSavingTime( CFTimeZoneRef ref );
BOOL TimeZoneIsDaylightSavingTimeForDate( CFTimeZoneRef ref, CFDateRef dt );
CFTimeInterval TimeZoneDaylightSavingTimeOffset( CFTimeZoneRef ref );
CFTimeInterval TimeZoneDaylightSavingTimeOffsetForDate( CFTimeZoneRef ref, CFDateRef dt );
CFDateRef TimeZoneNextDaylightSavingTimeTransition( CFTimeZoneRef ref );
CFDateRef TimeZoneNextDaylightSavingTimeTransitionAfterDate( CFTimeZoneRef ref, CFDateRef dt );

// Compare
BOOL TimeZoneIsEqual( CFTimeZoneRef ref, CFTimeZoneRef otherZone );

// Describe
CFStringRef TimeZoneLocalizedName( CFTimeZoneRef ref, NSTimeZoneNameStyle nameStyle, CFLocaleRef locale );
CFStringRef TimeZoneDescription( CFTimeZoneRef ref );

