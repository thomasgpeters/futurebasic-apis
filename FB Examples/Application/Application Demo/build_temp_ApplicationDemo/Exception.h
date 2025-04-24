/*
 Exception.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class ExceptionClass( void );

// Create
NSException *ExceptionWithName( CFStringRef name, CFStringRef reason, CFDictionaryRef userInfo );
void ExceptionRaiseFormat( CFStringRef name, CFStringRef format, ... );
void ExceptionRaiseFormatArguments( CFStringRef name, CFStringRef format, va_list argList );
void ExceptionRaise( NSException *ref );

// Query
CFStringRef ExceptionName( NSException *ref );
CFStringRef ExceptionReason( NSException *ref );
CFDictionaryRef ExceptionUserInfo( NSException *ref );

// Stack frames
CFArrayRef ExceptionCallStackReturnAddresses( NSException *ref );
CFArrayRef ExceptionCallStackSymbols( NSException *ref );
