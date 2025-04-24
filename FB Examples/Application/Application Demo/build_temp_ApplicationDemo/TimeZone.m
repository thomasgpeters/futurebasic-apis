/*
 TimeZone.m

 Bernie Wylde
 */

#import "TimeZone.h"

// Class
Class TimeZoneClass( void )
{ return [NSTimeZone class]; }

// System time zones
CFTimeZoneRef TimeZoneLocal( void )
{ return (__bridge CFTimeZoneRef)[NSTimeZone localTimeZone]; }

CFTimeZoneRef TimeZoneSystem( void )
{ return (__bridge CFTimeZoneRef)[NSTimeZone systemTimeZone]; }

void TimeZoneResetSystem( void )
{ [NSTimeZone resetSystemTimeZone]; }

CFTimeZoneRef TimeZoneDefault( void )
{ return (__bridge CFTimeZoneRef)[NSTimeZone defaultTimeZone]; }

void TimeZoneSetDefault( CFTimeZoneRef timeZone )
{ [NSTimeZone setDefaultTimeZone:(__bridge NSTimeZone *)timeZone]; }

// Create
CFTimeZoneRef TimeZoneWithName( CFStringRef name )
{ return (__bridge CFTimeZoneRef)[NSTimeZone timeZoneWithName:(__bridge NSString *)name]; }

CFTimeZoneRef TimeZoneWithNameAndData( CFStringRef name, CFDataRef dta )
{ return (__bridge CFTimeZoneRef)[NSTimeZone timeZoneWithName:(__bridge NSString *)name data:(__bridge NSData *)dta]; }

CFTimeZoneRef TimeZoneWithAbbreviation( CFStringRef abbreviation )
{ return (__bridge CFTimeZoneRef)[NSTimeZone timeZoneWithAbbreviation:(__bridge NSString *)abbreviation]; }

CFTimeZoneRef TimeZoneForSecondsFromGMT( NSInteger seconds )
{ return (__bridge CFTimeZoneRef)[NSTimeZone timeZoneForSecondsFromGMT:seconds]; }

CFArrayRef TimeZoneKnownNames( void )
{ return (__bridge CFArrayRef)[NSTimeZone knownTimeZoneNames]; }

CFDictionaryRef TimeZoneAbbreviationDictionary( void )
{ return (__bridge CFDictionaryRef)[NSTimeZone abbreviationDictionary]; }

// Info
CFStringRef TimeZoneName( CFTimeZoneRef ref )
{ return (__bridge CFStringRef)[(__bridge NSTimeZone *)ref name]; }

CFStringRef TimeZoneAbbreviation( CFTimeZoneRef ref )
{ return (__bridge CFStringRef)[(__bridge NSTimeZone *)ref abbreviation]; }

CFStringRef TimeZoneAbbreviationForDate( CFTimeZoneRef ref, CFDateRef dt )
{ return (__bridge CFStringRef)[(__bridge NSTimeZone *)ref abbreviationForDate:(__bridge NSDate *)dt]; }

NSInteger TimeZoneSecondsFromGMT( CFTimeZoneRef ref )
{ return [(__bridge NSTimeZone *)ref secondsFromGMT]; }

NSInteger TimeZoneSecondsFromGMTForDate( CFTimeZoneRef ref, CFDateRef dt )
{ return [(__bridge NSTimeZone *)ref secondsFromGMTForDate:(__bridge NSDate *)dt]; }

CFDataRef TimeZoneData( CFTimeZoneRef ref )
{ return (__bridge CFDataRef)[(__bridge NSTimeZone *)ref data]; }

CFStringRef TimeZoneDataVersion( void )
{ return (__bridge CFStringRef)[NSTimeZone timeZoneDataVersion]; }

// Daylight savings
BOOL TimeZoneIsDaylightSavingTime( CFTimeZoneRef ref )
{ return [(__bridge NSTimeZone *)ref isDaylightSavingTime]; }

BOOL TimeZoneIsDaylightSavingTimeForDate( CFTimeZoneRef ref, CFDateRef dt )
{ return [(__bridge NSTimeZone *)ref isDaylightSavingTimeForDate:(__bridge NSDate *)dt]; }

CFTimeInterval TimeZoneDaylightSavingTimeOffset( CFTimeZoneRef ref )
{ return [(__bridge NSTimeZone *)ref daylightSavingTimeOffset]; }

CFTimeInterval TimeZoneDaylightSavingTimeOffsetForDate( CFTimeZoneRef ref, CFDateRef dt )
{ return [(__bridge NSTimeZone *)ref daylightSavingTimeOffsetForDate:(__bridge NSDate *)dt]; }

CFDateRef TimeZoneNextDaylightSavingTimeTransition( CFTimeZoneRef ref )
{ return (__bridge CFDateRef)[(__bridge NSTimeZone *)ref nextDaylightSavingTimeTransition]; }

CFDateRef TimeZoneNextDaylightSavingTimeTransitionAfterDate( CFTimeZoneRef ref, CFDateRef dt )
{ return (__bridge CFDateRef)[(__bridge NSTimeZone *)ref nextDaylightSavingTimeTransitionAfterDate:(__bridge NSDate *)dt]; }

// Compare
BOOL TimeZoneIsEqual( CFTimeZoneRef ref, CFTimeZoneRef otherZone )
{ return [(__bridge NSTimeZone *)ref isEqualToTimeZone:(__bridge NSTimeZone *)otherZone]; }

// Describe
CFStringRef TimeZoneLocalizedName( CFTimeZoneRef ref, NSTimeZoneNameStyle nameStyle, CFLocaleRef locale )
{ return (__bridge CFStringRef)[(__bridge NSTimeZone *)ref localizedName:nameStyle locale:(__bridge NSLocale *)locale]; }

CFStringRef TimeZoneDescription( CFTimeZoneRef ref )
{ return (__bridge CFStringRef)[(__bridge NSTimeZone *)ref description]; }

