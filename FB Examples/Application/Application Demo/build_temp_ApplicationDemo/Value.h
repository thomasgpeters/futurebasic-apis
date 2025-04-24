/*
 Value.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class ValueClass( void );

// Raw values
NSValue *ValueWithBytes( void *p, CFStringRef objCType );
CFStringRef ValueObjCType( NSValue *ref );

// Pointer and object
NSValue *ValueWithPointer( void *p );
void *ValuePointer( NSValue *ref );

NSValue *ValueWithNonretainedObject( CFTypeRef obj );
CFTypeRef ValueNonretainedObject( NSValue *ref );

// Compare
BOOL ValueIsEqual( NSValue *val1, NSValue *val2 );

// Instance methods
void ValueGetValue( NSValue *ref, void *value, NSUInteger size );


#pragma mark - number
// Class
Class NumberClass( void );

// Create
CFNumberRef NumberWithBool( BOOL value );
CFNumberRef NumberWithChar( char value );
CFNumberRef NumberWithDouble( double value );
CFNumberRef NumberWithFloat( float value );
CFNumberRef NumberWithInt( SInt32 value );
CFNumberRef NumberWithInteger( NSInteger value );
CFNumberRef NumberWithLong( long value );
CFNumberRef NumberWithLongLong( SInt64 value );
CFNumberRef NumberWithShort( short value );
CFNumberRef NumberWithUnsignedChar( unsigned char value );
CFNumberRef NumberWithUnsignedInt( SInt32 value );
CFNumberRef NumberWithUnsignedInteger( NSUInteger value );
CFNumberRef NumberWithUnsignedLong( unsigned long value );
CFNumberRef NumberWithUnsignedLongLong( unsigned long long value );
CFNumberRef NumberWithUnsignedShort( unsigned short value );

// Numberic values
BOOL NumberBoolValue( CFNumberRef ref );
char NumberCharValue( CFNumberRef ref );
NSDecimal NumberDecimalValue( CFNumberRef ref );
float NumberFloatValue( CFNumberRef ref );
double NumberDoubleValue( CFNumberRef ref );
SInt32 NumberIntValue( CFNumberRef ref );
NSInteger NumberIntegerValue( CFNumberRef ref );
long NumberLongValue( CFNumberRef ref );
SInt64 NumberLongLongValue( CFNumberRef ref );
short NumberShortValue( CFNumberRef ref );
unsigned char NumberUnsignedCharValue( CFNumberRef ref );
NSUInteger NumberUnsignedIntegerValue( CFNumberRef ref );
UInt32 NumberUnsignedIntValue( CFNumberRef ref );
unsigned long NumberUnsignedLongValue( CFNumberRef ref );
UInt64 NumberUnsignedLongLongValue( CFNumberRef ref );
unsigned short NumberUnsignedShortValue( CFNumberRef ref );

// - string representation -
CFStringRef NumberDescriptionWithLocale( CFNumberRef ref, CFLocaleRef locale );
CFStringRef NumberStringValue( CFNumberRef ref );

NSComparisonResult NumberCompare( CFNumberRef ref1, CFNumberRef ref2 );
BOOL NumberIsEqual( CFNumberRef ref1, CFNumberRef ref2 );

// Type information
CFStringRef NumberObjCType( CFNumberRef ref );

// Convenience
CFStringRef NumberOrdinalString( CFNumberRef ref );
CFStringRef NumberSpellOutString( CFNumberRef ref );
CFStringRef NumberCurrencyString( CFNumberRef ref );

CFStringRef BoolString( BOOL flag );
CFStringRef BooleanString( Boolean flag );

