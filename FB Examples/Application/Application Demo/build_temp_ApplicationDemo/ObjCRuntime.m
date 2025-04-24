/*
 ObjCRuntime.m

 Bernie Wylde
 */

#import "ObjCRuntime.h"

// private
//SEL CUI_FixSelector( CFTypeRef selector )
//{
//    if ( [(__bridge id)selector class] ) {
//        return NSSelectorFromString((__bridge NSString *)selector);
//    }
//    return (SEL)selector;
//}

// public
Class ClassFromString( CFStringRef string )
{ return NSClassFromString( (__bridge NSString *)string ); }

CFStringRef StringFromClass( Class class )
{ return (__bridge CFStringRef)NSStringFromClass( class ); }

SEL SelectorFromString( CFStringRef string )
{ return NSSelectorFromString( (__bridge NSString *)string ); }

CFStringRef StringFromSelector( SEL selector )
{ return (__bridge CFStringRef)NSStringFromSelector( selector ); }

