/*
 Date.m

 Bernie Wylde
 */

#import "Date.h"

// Class
Class DateClass( void )
{ return [NSDate class]; }

// - init -
CFDateRef DateInit( void )
{ return (__bridge CFDateRef)[NSDate date]; }

CFDateRef DateWithTimeIntervalSinceNow( CFTimeInterval ti )
{ return (__bridge CFDateRef)[NSDate dateWithTimeIntervalSinceNow:ti]; }

CFDateRef DateWithTimeIntervalSinceDate( CFTimeInterval ti, CFDateRef date )
{ return (__bridge CFDateRef)[NSDate dateWithTimeInterval:ti sinceDate:(__bridge NSDate *)date]; }

CFDateRef DateWithTimeIntervalSinceReferenceDate( CFTimeInterval ti )
{ return (__bridge CFDateRef)[NSDate dateWithTimeIntervalSinceReferenceDate:ti]; }

CFDateRef DateWithTimeIntervalSince1970( CFTimeInterval ti )
{ return (__bridge CFDateRef)[NSDate dateWithTimeIntervalSince1970:ti]; }

// - temporal boundaries -
CFDateRef DateDistantFuture( void )
{ return (__bridge CFDateRef)[NSDate distantFuture]; }

CFDateRef DateDistantPast( void )
{ return (__bridge CFDateRef)[NSDate distantPast]; }

// Current date
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
CFDateRef DateNow( void )
{ return (__bridge CFDateRef)[NSDate now]; }
#endif

// - comparing -
BOOL DateIsEqual( CFDateRef ref1, CFDateRef ref2 )
{ return [(__bridge NSDate *)ref1 isEqualToDate:(__bridge NSDate *)ref2]; }

CFDateRef DateEarlierDate( CFDateRef ref1, CFDateRef ref2 )
{ return (__bridge CFDateRef)[(__bridge NSDate *)ref1 earlierDate:(__bridge NSDate *)ref2]; }

CFDateRef DateLaterDate( CFDateRef ref1, CFDateRef ref2 )
{ return (__bridge CFDateRef)[(__bridge NSDate *)ref1 laterDate:(__bridge NSDate *)ref2]; }

NSComparisonResult DateCompare( CFDateRef ref1, CFDateRef ref2 )
{ return [(__bridge NSDate *)ref1 compare:(__bridge NSDate *)ref2]; }

// - get time intervals -
CFTimeInterval DateTimeIntervalSinceDate( CFDateRef ref1, CFDateRef ref2 )
{ return [(__bridge NSDate *)ref1 timeIntervalSinceDate:(__bridge NSDate *)ref2]; }

CFTimeInterval DateTimeIntervalSinceNow( CFDateRef ref )
{ return [(__bridge NSDate *)ref timeIntervalSinceNow]; }

CFTimeInterval DateTimeIntervalSinceReferenceDate( CFDateRef ref )
{ return [(__bridge NSDate *)ref timeIntervalSinceReferenceDate]; }

CFTimeInterval DateTimeIntervalSince1970( CFDateRef ref )
{ return [(__bridge NSDate *)ref timeIntervalSince1970]; }

// - add time intervals -
CFDateRef DateByAddingTimeInterval( CFDateRef ref, CFTimeInterval ti )
{ return (__bridge CFDateRef)[(__bridge NSDate *)ref dateByAddingTimeInterval:ti]; }

// - description -
CFStringRef DateDescription( CFDateRef ref )
{ return (__bridge CFStringRef)[(__bridge NSDate *)ref description]; }

CFStringRef DateDescriptionWithLocale( CFDateRef ref, CFLocaleRef locale )
{ return (__bridge CFStringRef)[(__bridge NSDate *)ref descriptionWithLocale:(__bridge NSLocale *)locale]; }

// Custom
//CFStringRef DateStringWithFormat( CFStringRef format )
//{
//    NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
//    if ( format ) {
//        [df setDateFormat:(__bridge NSString *)format];
//    } else {
//        [df setDateStyle:NSDateFormatterShortStyle];
//    }
//    return (__bridge CFStringRef)[df stringFromDate:[NSDate date]];
//}

CFStringRef DateStringWithFormat( CFDateRef dt, CFStringRef format )
{
#if __has_feature(objc_arc)
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
#else
    NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
#endif
    NSDate *date = (__bridge NSDate *)dt;
    if ( !date ) date = [NSDate date];
    if ( format ) {
        [df setDateFormat:(__bridge NSString *)format];
    } else {
        [df setDateStyle:NSDateFormatterShortStyle];
    }
    return (__bridge CFStringRef)[df stringFromDate:date];
}

