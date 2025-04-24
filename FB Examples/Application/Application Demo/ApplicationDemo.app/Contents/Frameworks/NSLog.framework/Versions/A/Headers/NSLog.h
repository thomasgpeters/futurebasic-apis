//
//  NSLog.h
//  NSLog
//
//  Created by Bernie Wylde on 17/01/2021.
//

#import <Cocoa/Cocoa.h>

#define NSLogVers @"1.6.9"
#define _NSLOG 1

// set log window frame
void NSLogSetFrame( NSRect r );// 20221021

// set log window title
void NSLogSetTitle( NSString * _Nonnull title );

// background color
void NSLogSetBackgroundColor( NSColor * _Nullable color );

// setting font and text color
void NSLogSetFont( NSFont * _Nullable font );
void NSLogSetTextColor( NSColor * _Nullable color );

// attributes
void NSLogAddAttributes( NSDictionary *_Nullable attributes );
void NSLogSetTextAlignment( NSTextAlignment alignment );

// tab interval
void NSLogSetTabInterval( CGFloat interval );

// accessing the log string
NSString * _Nullable NSLogString( void );

// write to URL
BOOL NSLogWriteToURL( NSURL * _Nonnull url );

// scrolling
void NSLogScrollToTop( void );

// clearing the log
void NSLogClear( void );

// progress indicator
void NSLogProgressSetValue( double value );
void NSLogProgressStart( void );
void NSLogProgressStop( void );

// sending messages to the log
void NSLogAlertV( NSString * _Nonnull format, va_list ap );
void NSLogAlert( NSString * _Nonnull format, ... );
void NSLogV( NSString * _Nonnull format, va_list ap );
void NSLog( NSString * _Nonnull format, ... );
void NSLogPascal( Str255 _Nonnull string );

// hide/show
void NSLogHide( void );
void NSLogShow( void );

// functions with CF params for FB
void nsLogSetFrame( CGRect r );
void nsLogSetTitle( CFStringRef _Nonnull title );

// temporary attributes
void nsLogAddAttributes( CFDictionaryRef _Nullable attributes );

// accessing the log string
CFStringRef _Nullable nsLogString( void );

// write to URL
BOOL nsLogWriteToURL( CFURLRef _Nonnull url );

// sending messages to the log
void nsLogAlertV( CFStringRef _Nonnull format, va_list ap );
void nsLogAlert( CFStringRef _Nonnull format, ... );
void nsLogV( CFStringRef _Nonnull format, va_list ap );
void nsLog( CFStringRef _Nonnull format, ... );

