/*
 Range.h

 Bernie Wylde
 */

#import "CocoaUI.h"

CFRange MakeRange( NSUInteger location, NSUInteger length );
CFRange RangeMake( NSUInteger location, NSUInteger length );
NSUInteger MaxRange( CFRange range );
NSUInteger RangeMax( CFRange range );
BOOL LocationInRange( CFRange range, NSUInteger location );
BOOL RangeLocation( CFRange range, NSUInteger location );
BOOL EqualRanges( CFRange range1, CFRange range2 );
BOOL RangeEqual( CFRange range1, CFRange range2 );
CFRange UnionRange( CFRange range1, CFRange range2 );
CFRange RangeUnion( CFRange range1, CFRange range2 );
CFRange IntersectionRange( CFRange range1, CFRange range2 );
CFRange RangeIntersection( CFRange range1, CFRange range2 );
CFRange RangeFromString( CFStringRef string );
CFStringRef StringFromRange( CFRange range );
CFStringRef RangeToString( CFRange range );


#pragma mark - Value additions
NSValue *ValueWithRange( CFRange range );
CFRange ValueRange( NSValue *ref );

