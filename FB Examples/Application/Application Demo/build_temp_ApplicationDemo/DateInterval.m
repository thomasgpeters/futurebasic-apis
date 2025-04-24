/*
 DateInterval.m

 Bernie Wylde
 */

#import "DateInterval.h"


// Class
Class DateIntervalClass( void )
{ return [NSDateInterval class]; }

// - create -
NSDateInterval *DateIntervalInit( void )
{
#if __has_feature(objc_arc)
    return [[NSDateInterval alloc] init];
#else
    return [[[NSDateInterval alloc] init] autorelease];
#endif
}

NSDateInterval *DateIntervalWithStartDateDuration( CFDateRef dt, CFTimeInterval ti )
{
#if __has_feature(objc_arc)
    return [[NSDateInterval alloc] initWithStartDate:(__bridge NSDate *)dt duration:ti];
#else
    return [[[NSDateInterval alloc] initWithStartDate:(__bridge NSDate *)dt duration:ti] autorelease];
#endif
}

NSDateInterval *DateIntervalWithStartDateEndDate( CFDateRef startDate, CFDateRef endDate )
{
#if __has_feature(objc_arc)
    return [[NSDateInterval alloc] initWithStartDate:(__bridge NSDate *)startDate endDate:(__bridge NSDate *)endDate];
#else
    return [[[NSDateInterval alloc] initWithStartDate:(__bridge NSDate *)startDate endDate:(__bridge NSDate *)endDate] autorelease];
#endif
}

// NSDateInterval *DateIntervalWithCoder( NSCoder *coder )
//{ return [[[NSDateInterval alloc] initWithCoder:coder] autorelease]; }

// - start/end date and duration
CFDateRef DateIntervalStartDate( NSDateInterval *ref )
{ return (__bridge CFDateRef)[ref startDate]; }

CFDateRef DateIntervalEndDate( NSDateInterval *ref )
{ return (__bridge CFDateRef)[ref endDate]; }

CFTimeInterval DateIntervalDuration( NSDateInterval *ref )
{ return [ref duration]; }

// - compare date intervals -
NSComparisonResult DateIntervalCompare( NSDateInterval *ref1, NSDateInterval *ref2 )
{ return [ref1 compare:ref2]; }

BOOL DateIntervalIsEqual( NSDateInterval *ref1, NSDateInterval *ref2 )
{ return [ref1 isEqualTo:ref2]; }

// - determine intersections -
BOOL DateIntervalIntersectsDateInterval( NSDateInterval *ref1, NSDateInterval *ref2 )
{ return [ref1 intersectsDateInterval:ref2]; }

NSDateInterval *DateIntervalIntersectionWithDateInterval( NSDateInterval *ref1, NSDateInterval *ref2 )
{ return [ref1 intersectionWithDateInterval:ref2]; }

// - determine if date occurs in date interval -
BOOL DateIntervalContainsDate( NSDateInterval *ref, CFDateRef dt )
{ return [ref containsDate:(__bridge NSDate *)dt]; }

