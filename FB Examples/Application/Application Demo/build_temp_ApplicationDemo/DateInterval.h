/*
 DateInterval.h

 Bernie Wylde
 */


#import "CocoaUI.h"


// Class
Class DateIntervalClass( void );

// - create -
NSDateInterval *DateIntervalInit( void );
NSDateInterval *DateIntervalWithStartDateDuration( CFDateRef dt, CFTimeInterval ti );
NSDateInterval *DateIntervalWithStartDateEndDate( CFDateRef startDate, CFDateRef endDate );
// NSDateInterval *DateIntervalWithCoder( NSCoder *coder );

// - start/end date and duration
CFDateRef DateIntervalStartDate( NSDateInterval *ref );
CFDateRef DateIntervalEndDate( NSDateInterval *ref );
CFTimeInterval DateIntervalDuration( NSDateInterval *ref );

// - compare date intervals -
NSComparisonResult DateIntervalCompare( NSDateInterval *ref1, NSDateInterval *ref2 );
BOOL DateIntervalIsEqual( NSDateInterval *ref1, NSDateInterval *ref2 );

// - determine intersections -
BOOL DateIntervalIntersectsDateInterval( NSDateInterval *ref1, NSDateInterval *ref2 );
NSDateInterval *DateIntervalIntersectionWithDateInterval( NSDateInterval *ref1, NSDateInterval *ref2 );

// - determine if date occurs in date interval -
BOOL DateIntervalContainsDate( NSDateInterval *ref, CFDateRef dt );
