/*
 Range.m

 Bernie Wylde
 */

#import "Range.h"

CFRange MakeRange( NSUInteger location, NSUInteger length )
{ return NSRangeToCFRange(NSMakeRange(location,length)); }

CFRange RangeMake( NSUInteger location, NSUInteger length )
{ return NSRangeToCFRange(NSMakeRange(location,length)); }

NSUInteger MaxRange( CFRange range )
{ return NSMaxRange(NSRangeFromCFRange(range)); }

NSUInteger RangeMax( CFRange range )
{ return NSMaxRange(NSRangeFromCFRange(range)); }

BOOL LocationInRange( CFRange range, NSUInteger location )
{ return NSLocationInRange(location,NSRangeFromCFRange(range)); }

BOOL RangeLocation( CFRange range, NSUInteger location )
{ return NSLocationInRange(location,NSRangeFromCFRange(range)); }

BOOL EqualRanges( CFRange range1, CFRange range2 )
{ return NSEqualRanges(NSRangeFromCFRange(range1),NSRangeFromCFRange(range2)); }

BOOL RangeEqual( CFRange range1, CFRange range2 )
{ return NSEqualRanges(NSRangeFromCFRange(range1),NSRangeFromCFRange(range2)); }

CFRange UnionRange( CFRange range1, CFRange range2 )
{ return NSRangeToCFRange(NSUnionRange(NSRangeFromCFRange(range1),NSRangeFromCFRange(range2))); }

CFRange RangeUnion( CFRange range1, CFRange range2 )
{ return NSRangeToCFRange(NSUnionRange(NSRangeFromCFRange(range1),NSRangeFromCFRange(range2))); }

CFRange IntersectionRange( CFRange range1, CFRange range2 )
{ return NSRangeToCFRange(NSIntersectionRange(NSRangeFromCFRange(range1),NSRangeFromCFRange(range2))); }

CFRange RangeIntersection( CFRange range1, CFRange range2 )
{ return NSRangeToCFRange(NSIntersectionRange(NSRangeFromCFRange(range1),NSRangeFromCFRange(range2))); }

CFRange RangeFromString( CFStringRef string )
{ return NSRangeToCFRange(NSRangeFromString((__bridge NSString *)string)); }

CFStringRef StringFromRange( CFRange range )
{ return (__bridge CFStringRef)NSStringFromRange(NSRangeFromCFRange(range)); }

CFStringRef RangeToString( CFRange range )
{ return (__bridge CFStringRef)NSStringFromRange(NSRangeFromCFRange(range)); }


#pragma mark - Value additions
NSValue *ValueWithRange( CFRange range )
{ return [NSValue valueWithRange:NSRangeFromCFRange(range)]; }

CFRange ValueRange( NSValue *ref )
{ return NSRangeToCFRange([ref rangeValue]); }

