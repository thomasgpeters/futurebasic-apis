/*
 ByteCountFormatter.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED > 1080

// Class
Class ByteCountFormatterClass( void );

// - create -
NSByteCountFormatter *ByteCountFormatterInit( void );

// - string from byte count -
CFStringRef ByteCountFormatterStringFromByteCount( SInt64 byteCount, NSByteCountFormatterCountStyle style );

// - formatting styles -
NSFormattingContext ByteCountFormatterFormattingContext( NSByteCountFormatter *ref );
void ByteCountFormatterSetFormattingContext( NSByteCountFormatter *ref, NSFormattingContext ctx );
NSByteCountFormatterCountStyle ByteCountFormatterCountStyle( NSByteCountFormatter *ref );
void ByteCountFormatterSetCountStyle( NSByteCountFormatter *ref, NSByteCountFormatterCountStyle style );
BOOL ByteCountFormatterAllowsNonnumericFormatting( NSByteCountFormatter *ref );
void ByteCountFormatterSetAllowsNonnumericFormatting( NSByteCountFormatter *ref, BOOL flag );
BOOL ByteCountFormatterIncludesActualByteCount( NSByteCountFormatter *ref );
void ByteCountFormatterSetIncludesActualByteCount( NSByteCountFormatter *ref, BOOL flag );
BOOL ByteCountFormatterIsAdaptive( NSByteCountFormatter *ref );
void ByteCountFormatterSetAdaptive( NSByteCountFormatter *ref, BOOL flag );
NSByteCountFormatterUnits ByteCountFormatterAllowedUnits( NSByteCountFormatter *ref );
void ByteCountFormatterSetAllowedUnits( NSByteCountFormatter *ref, NSByteCountFormatterUnits units );
BOOL ByteCountFormatterIncludesCount( NSByteCountFormatter *ref );
void ByteCountFormatterSetIncludesCount( NSByteCountFormatter *ref, BOOL flag );
BOOL ByteCountFormatterZeroPadsFractionDigits( NSByteCountFormatter *ref );
void ByteCountFormatterSetZeroPadsFractionDigits( NSByteCountFormatter *ref, BOOL flag );

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
CFStringRef ByteCountFormatterStringForObjectValue( NSByteCountFormatter *ref, CFTypeRef obj );
API_AVAILABLE(macos(10.15))
CFStringRef ByteCountFormatterStringFromMeasurement( NSByteCountFormatter *ref, NSMeasurement *measurement );

// Type methods
API_AVAILABLE(macos(10.15))
CFStringRef ByteCountFormatterStringFromMeasurementCountStyle( NSMeasurement *measurement, NSByteCountFormatterCountStyle countStyle );

#endif// 101500

#endif// 1080

