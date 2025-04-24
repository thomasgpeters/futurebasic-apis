/*
 Exception.m

 Bernie Wylde
 */

#import "Exception.h"

// Class
Class ExceptionClass( void )
{ return [NSException class]; }

// Create
NSException *ExceptionWithName( CFStringRef name, CFStringRef reason, CFDictionaryRef userInfo )
{ return [NSException exceptionWithName:(__bridge NSString *)name reason:(__bridge NSString *)reason userInfo:(__bridge NSDictionary *)userInfo]; }

void ExceptionRaiseFormat( CFStringRef name, CFStringRef format, ... )
{
    va_list ap;
    va_start( ap, format );
    [NSException raise:(__bridge NSString *)name format:(__bridge NSString *)format arguments:ap];
    va_end( ap );
}

void ExceptionRaiseFormatArguments( CFStringRef name, CFStringRef format, va_list argList )
{ [NSException raise:(__bridge NSString *)name format:(__bridge NSString *)format arguments:argList]; }

void ExceptionRaise( NSException *ref )
{ [ref raise]; }
    
// Query
CFStringRef ExceptionName( NSException *ref )
{ return (__bridge CFStringRef)[ref name]; }

CFStringRef ExceptionReason( NSException *ref )
{ return (__bridge CFStringRef)[ref reason]; }

CFDictionaryRef ExceptionUserInfo( NSException *ref )
{ return (__bridge CFDictionaryRef)[ref userInfo]; }

// Stack frames
CFArrayRef ExceptionCallStackReturnAddresses( NSException *ref )
{ return (__bridge CFArrayRef)[ref callStackReturnAddresses]; }

CFArrayRef ExceptionCallStackSymbols( NSException *ref )
{ return (__bridge CFArrayRef)[ref callStackSymbols]; }

