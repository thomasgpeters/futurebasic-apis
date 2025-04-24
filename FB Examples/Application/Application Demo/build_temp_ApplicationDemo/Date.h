/*
 Date.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class DateClass( void );

// - init -
CFDateRef DateInit( void );
CFDateRef DateWithTimeIntervalSinceNow( CFTimeInterval ti );
CFDateRef DateWithTimeIntervalSinceDate( CFTimeInterval ti, CFDateRef date );
CFDateRef DateWithTimeIntervalSinceReferenceDate( CFTimeInterval ti );
CFDateRef DateWithTimeIntervalSince1970( CFTimeInterval ti );

// - temporal boundaries -
CFDateRef DateDistantFuture( void );
CFDateRef DateDistantPast( void );

// Current date
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
CFDateRef DateNow( void );
#endif

// - comparing -
BOOL DateIsEqual( CFDateRef ref1, CFDateRef ref2 );
CFDateRef DateEarlierDate( CFDateRef ref1, CFDateRef ref2 );
CFDateRef DateLaterDate( CFDateRef ref1, CFDateRef ref2 );
NSComparisonResult DateCompare( CFDateRef ref1, CFDateRef ref2 );

// - get time intervals -
CFTimeInterval DateTimeIntervalSinceDate( CFDateRef ref1, CFDateRef ref2 );
CFTimeInterval DateTimeIntervalSinceNow( CFDateRef ref );
CFTimeInterval DateTimeIntervalSinceReferenceDate( CFDateRef ref );
CFTimeInterval DateTimeIntervalSince1970( CFDateRef ref );

// - add time intervals -
CFDateRef DateByAddingTimeInterval( CFDateRef ref, CFTimeInterval ti );

// - description -
CFStringRef DateDescription( CFDateRef ref );
CFStringRef DateDescriptionWithLocale( CFDateRef ref, CFLocaleRef locale );

// Custom
//CFStringRef DateStringWithFormat( CFStringRef format );
CFStringRef DateStringWithFormat( CFDateRef dt, CFStringRef format );

