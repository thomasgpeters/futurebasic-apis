/*
 Geometry.m

 Bernie Wylde
 */

#import "Geometry.h"

CFStringRef StringFromPoint( CGPoint pt )
{ return (__bridge CFStringRef)NSStringFromPoint( NSPointFromCGPoint(pt)); }

CFStringRef StringFromSize( CGSize size )
{ return (__bridge CFStringRef)NSStringFromSize( NSSizeFromCGSize(size)); }

CFStringRef StringFromRect( CGRect rect )
{ return (__bridge CFStringRef)NSStringFromRect( NSRectFromCGRect(rect)); }

CGPoint PointFromString( CFStringRef string )
{ return NSPointToCGPoint(NSPointFromString((__bridge NSString *)string)); }

CGSize SizeFromString( CFStringRef string )
{ return NSSizeToCGSize(NSSizeFromString((__bridge NSString *)string)); }

CGRect RectFromString( CFStringRef string )
{ return NSRectToCGRect(NSRectFromString((__bridge NSString *)string)); }


#pragma mark - Value additions
NSValue *ValueWithPoint( CGPoint pt )
{ return [NSValue valueWithPoint:NSPointFromCGPoint(pt)]; }

CGPoint ValuePoint( NSValue *ref )
{ return NSPointToCGPoint([ref pointValue]); }

NSValue *ValueWithSize( CGSize size )
{ return [NSValue valueWithSize:NSSizeFromCGSize(size)]; }

CGSize ValueSize( NSValue *ref )
{ return NSSizeToCGSize([ref sizeValue]); }

NSValue *ValueWithRect( CGRect r )
{ return [NSValue valueWithRect:NSRectFromCGRect(r)]; }

CGRect ValueRect( NSValue *ref )
{ return NSRectToCGRect([ref rectValue]); }

NSValue *ValueWithEdgeInsets( NSEdgeInsets insets )
{ return [NSValue valueWithEdgeInsets:insets]; }

NSEdgeInsets ValueEdgeInsets( NSValue *ref )
{ return [ref edgeInsetsValue]; }
