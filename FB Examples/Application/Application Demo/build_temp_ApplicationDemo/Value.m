/*
 Value.m

 Bernie Wylde
 */

#import "Value.h"

// Class
Class ValueClass( void )
{ return [NSValue class]; }

// Raw values
NSValue *ValueWithBytes( void *p, CFStringRef objCType )
{ return [NSValue valueWithBytes:p objCType:[(__bridge NSString *)objCType UTF8String]]; }

CFStringRef ValueObjCType( NSValue *ref )
{ return (__bridge CFStringRef)[NSString stringWithUTF8String:[ref objCType]]; }

// Pointer and object
NSValue *ValueWithPointer( void *p )
{ return [NSValue valueWithPointer:p]; }

void *ValuePointer( NSValue *ref )
{ return [ref pointerValue]; }

NSValue *ValueWithNonretainedObject( CFTypeRef obj )
{ return [NSValue valueWithNonretainedObject:(__bridge id)obj]; }

CFTypeRef ValueNonretainedObject( NSValue *ref )
{ return (__bridge CFTypeRef)[ref nonretainedObjectValue]; }

// Compare
BOOL ValueIsEqual( NSValue *val1, NSValue *val2 )
{ return [val1 isEqualToValue:val2]; }

// Instance methods
void ValueGetValue( NSValue *ref, void *value, NSUInteger size )
{ [ref getValue:value size:size]; }


#pragma mark - number
// Class
Class NumberClass( void )
{ return [NSNumber class]; }

CFNumberRef NumberWithBool( BOOL value )
{ return (__bridge CFNumberRef)[NSNumber numberWithBool:value]; }

CFNumberRef NumberWithChar( char value )
{ return (__bridge CFNumberRef)[NSNumber numberWithChar:value]; }

CFNumberRef NumberWithInt( SInt32 value )
{ return (__bridge CFNumberRef)[NSNumber numberWithInt:value]; }

CFNumberRef NumberWithShort( short value )
{ return (__bridge CFNumberRef)[NSNumber numberWithShort:value]; }

CFNumberRef NumberWithInteger( NSInteger value )
{ return (__bridge CFNumberRef)[NSNumber numberWithInteger:value]; }

CFNumberRef NumberWithLong( long value )
{ return (__bridge CFNumberRef)[NSNumber numberWithInteger:value]; }

CFNumberRef NumberWithLongLong( SInt64 value )
{ return (__bridge CFNumberRef)[NSNumber numberWithLongLong:value]; }

CFNumberRef NumberWithUnsignedChar( unsigned char value )
{ return (__bridge CFNumberRef)[NSNumber numberWithUnsignedChar:value]; }

CFNumberRef NumberWithUnsignedInt( SInt32 value )
{ return (__bridge CFNumberRef)[NSNumber numberWithUnsignedInt:value]; }

CFNumberRef NumberWithUnsignedShort( unsigned short value )
{ return (__bridge CFNumberRef)[NSNumber numberWithUnsignedShort:value]; }

CFNumberRef NumberWithUnsignedInteger( NSUInteger value )
{ return (__bridge CFNumberRef)[NSNumber numberWithUnsignedInteger:value]; }

CFNumberRef NumberWithUnsignedLong( unsigned long value )
{ return (__bridge CFNumberRef)[NSNumber numberWithUnsignedInteger:value]; }

CFNumberRef NumberWithUnsignedLongLong( unsigned long long value )
{ return (__bridge CFNumberRef)[NSNumber numberWithUnsignedLongLong:value]; }

CFNumberRef NumberWithFloat( float value )
{ return (__bridge CFNumberRef)[NSNumber numberWithFloat:value]; }

CFNumberRef NumberWithDouble( double value )
{ return (__bridge CFNumberRef)[NSNumber numberWithDouble:value]; }

BOOL NumberBoolValue( CFNumberRef ref )
{ return [(__bridge NSNumber *)ref boolValue]; }

char NumberCharValue( CFNumberRef ref )
{ return [(__bridge NSNumber *)ref charValue]; }

NSDecimal NumberDecimalValue( CFNumberRef ref )
{ return [(__bridge NSNumber *)ref decimalValue]; }

SInt32 NumberIntValue( CFNumberRef ref )
{ return [(__bridge NSNumber *)ref intValue]; }

short NumberShortValue( CFNumberRef ref )
{ return [(__bridge NSNumber *)ref shortValue]; }

long NumberLongValue( CFNumberRef ref )
{ return [(__bridge NSNumber *)ref intValue]; }

NSInteger NumberIntegerValue( CFNumberRef ref )
{ return [(__bridge NSNumber *)ref integerValue]; }

SInt64 NumberLongLongValue( CFNumberRef ref )
{ return [(__bridge NSNumber *)ref longLongValue]; }

unsigned char NumberUnsignedCharValue( CFNumberRef ref )
{ return [(__bridge NSNumber *)ref unsignedCharValue]; }

UInt32 NumberUnsignedIntValue( CFNumberRef ref )
{ return [(__bridge NSNumber *)ref unsignedIntValue]; }

unsigned short NumberUnsignedShortValue( CFNumberRef ref )
{ return [(__bridge NSNumber *)ref unsignedShortValue]; }

NSUInteger NumberUnsignedIntegerValue( CFNumberRef ref )
{ return [(__bridge NSNumber *)ref unsignedIntegerValue]; }

unsigned long NumberUnsignedLongValue( CFNumberRef ref )
{ return [(__bridge NSNumber *)ref unsignedLongValue]; }

UInt64 NumberUnsignedLongLongValue( CFNumberRef ref )
{ return [(__bridge NSNumber *)ref unsignedLongLongValue]; }

float NumberFloatValue( CFNumberRef ref )
{ return [(__bridge NSNumber *)ref floatValue]; }

double NumberDoubleValue( CFNumberRef ref )
{ return [(__bridge NSNumber *)ref doubleValue]; }

// - string representation -
CFStringRef NumberDescriptionWithLocale( CFNumberRef ref, CFLocaleRef locale )
{ return (__bridge CFStringRef)[(__bridge NSNumber *)ref descriptionWithLocale:(__bridge NSLocale *)locale]; }

CFStringRef NumberStringValue( CFNumberRef ref )
{ return (__bridge CFStringRef)[(__bridge NSNumber *)ref stringValue]; }

NSComparisonResult NumberCompare( CFNumberRef ref1, CFNumberRef ref2 )
{ return [(__bridge NSNumber *)ref1 compare:(__bridge NSNumber *)ref2]; }

BOOL NumberIsEqual( CFNumberRef ref1, CFNumberRef ref2 )
{ return [(__bridge NSNumber *)ref1 isEqualToNumber:(__bridge NSNumber *)ref2]; }

// Type information
CFStringRef NumberObjCType( CFNumberRef ref )
{ return (__bridge CFStringRef)[NSString stringWithCString:[(__bridge NSNumber *)ref objCType] encoding:NSUTF8StringEncoding]; }

// Convenience
CFStringRef NumberOrdinalString( CFNumberRef ref )
{
#if __has_feature(objc_arc)
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
#else
    NSNumberFormatter *formatter = [[[NSNumberFormatter alloc] init] autorelease];
#endif
    [formatter setNumberStyle:NSNumberFormatterOrdinalStyle];
    return (__bridge CFStringRef)[formatter stringFromNumber:(__bridge NSNumber *)ref];
}

CFStringRef NumberSpellOutString( CFNumberRef ref )
{
#if __has_feature(objc_arc)
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
#else
    NSNumberFormatter *formatter = [[[NSNumberFormatter alloc] init] autorelease];
#endif
    [formatter setNumberStyle:NSNumberFormatterSpellOutStyle];
    return (__bridge CFStringRef)[formatter stringFromNumber:(__bridge NSNumber *)ref];
}

CFStringRef NumberCurrencyString( CFNumberRef ref )
{
#if __has_feature(objc_arc)
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
#else
    NSNumberFormatter *formatter = [[[NSNumberFormatter alloc] init] autorelease];
#endif
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    return (__bridge CFStringRef)[formatter stringFromNumber:(__bridge NSNumber *)ref];
}


CFStringRef BoolString( BOOL flag )
{
    if ( flag ) return (__bridge CFStringRef)@"YES";
    return (__bridge CFStringRef)@"NO";
}

CFStringRef BooleanString( Boolean flag )
{
    if ( flag ) return (__bridge CFStringRef)@"true";
    return (__bridge CFStringRef)@"false";
}

