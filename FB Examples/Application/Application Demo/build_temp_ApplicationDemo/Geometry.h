/*
 Geometry.h

 Bernie Wylde
 */


#import "CocoaUI.h"

CFStringRef StringFromPoint( CGPoint pt );
CFStringRef StringFromSize( CGSize size );
CFStringRef StringFromRect( CGRect rect );
CGPoint PointFromString( CFStringRef string );
CGSize SizeFromString( CFStringRef string );
CGRect RectFromString( CFStringRef string );


#pragma mark - Value additions
NSValue *ValueWithPoint( CGPoint pt );
CGPoint ValuePoint( NSValue *ref );

NSValue *ValueWithSize( CGSize size );
CGSize ValueSize( NSValue *ref );

NSValue *ValueWithRect( CGRect r );
CGRect ValueRect( NSValue *ref );

NSValue *ValueWithEdgeInsets( NSEdgeInsets insets );
NSEdgeInsets ValueEdgeInsets( NSValue *ref );
