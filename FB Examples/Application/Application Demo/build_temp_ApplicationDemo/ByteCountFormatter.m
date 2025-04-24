/*
 ByteCountFormatter.M
 
 Bernie Wylde
 */

#import "ByteCountFormatter.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED > 1080

// Class
Class ByteCountFormatterClass( void )
{ return [NSByteCountFormatter class]; }

// - create -
NSByteCountFormatter *ByteCountFormatterInit( void )
{
#if __has_feature(objc_arc)
    return [[NSByteCountFormatter alloc] init];
#else
    return [[[NSByteCountFormatter alloc] init] autorelease];
#endif
}

// - string from byte count -
CFStringRef ByteCountFormatterStringFromByteCount( SInt64 byteCount, NSByteCountFormatterCountStyle style )
{ return (__bridge CFStringRef)[NSByteCountFormatter stringFromByteCount:byteCount countStyle:style]; }

// - formatting styles -
NSFormattingContext ByteCountFormatterFormattingContext( NSByteCountFormatter *ref )
{ return [ref formattingContext]; }

void ByteCountFormatterSetFormattingContext( NSByteCountFormatter *ref, NSFormattingContext ctx )
{ [ref setFormattingContext:ctx]; }

NSByteCountFormatterCountStyle ByteCountFormatterCountStyle( NSByteCountFormatter *ref )
{ return [ref countStyle]; }

void ByteCountFormatterSetCountStyle( NSByteCountFormatter *ref, NSByteCountFormatterCountStyle style )
{ [ref setCountStyle:style]; }

BOOL ByteCountFormatterAllowsNonnumericFormatting( NSByteCountFormatter *ref )
{ return [ref allowsNonnumericFormatting]; }

void ByteCountFormatterSetAllowsNonnumericFormatting( NSByteCountFormatter *ref, BOOL flag )
{ [ref setAllowsNonnumericFormatting:flag]; }

BOOL ByteCountFormatterIncludesActualByteCount( NSByteCountFormatter *ref )
{ return [ref includesActualByteCount]; }

void ByteCountFormatterSetIncludesActualByteCount( NSByteCountFormatter *ref, BOOL flag )
{ [ref setIncludesActualByteCount:flag]; }

BOOL ByteCountFormatterIsAdaptive( NSByteCountFormatter *ref )
{ return [ref isAdaptive]; }

void ByteCountFormatterSetAdaptive( NSByteCountFormatter *ref, BOOL flag )
{ [ref setAdaptive:flag]; }

NSByteCountFormatterUnits ByteCountFormatterAllowedUnits( NSByteCountFormatter *ref )
{ return [ref allowedUnits]; }

void ByteCountFormatterSetAllowedUnits( NSByteCountFormatter *ref, NSByteCountFormatterUnits units )
{ [ref setAllowedUnits:units]; }

BOOL ByteCountFormatterIncludesCount( NSByteCountFormatter *ref )
{ return [ref includesCount]; }

void ByteCountFormatterSetIncludesCount( NSByteCountFormatter *ref, BOOL flag )
{ [ref setIncludesCount:flag]; }

BOOL ByteCountFormatterZeroPadsFractionDigits( NSByteCountFormatter *ref )
{ return [ref zeroPadsFractionDigits]; }

void ByteCountFormatterSetZeroPadsFractionDigits( NSByteCountFormatter *ref, BOOL flag )
{ [ref setZeroPadsFractionDigits:flag]; }

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
CFStringRef ByteCountFormatterStringForObjectValue( NSByteCountFormatter *ref, CFTypeRef obj )
{ return (__bridge CFStringRef)[ref stringForObjectValue:(__bridge id)obj]; }

CFStringRef ByteCountFormatterStringFromMeasurement( NSByteCountFormatter *ref, NSMeasurement *measurement )
{ return (__bridge CFStringRef)[ref stringFromMeasurement:measurement]; }

// Type methods
CFStringRef ByteCountFormatterStringFromMeasurementCountStyle( NSMeasurement *measurement, NSByteCountFormatterCountStyle countStyle )
{ return (__bridge CFStringRef)[NSByteCountFormatter stringFromMeasurement:measurement countStyle:countStyle]; }
#endif// 101500

#endif// 1080

