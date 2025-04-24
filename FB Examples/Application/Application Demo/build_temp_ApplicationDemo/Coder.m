/*
 Coder.m

 Bernie Wylde
 */

#import "Coder.h"

// Class
Class CoderClass( void )
{ return [NSCoder class]; }

// Inspect
BOOL CoderAllowsKeyedCoding( NSCoder *ref )
{ return [ref allowsKeyedCoding]; }

BOOL CoderContainsValueForKey( NSCoder *ref, CFStringRef key )
{ return [ref containsValueForKey:(__bridge NSString *)key]; }

NSDecodingFailurePolicy CoderDecodingFailurePolicy( NSCoder *ref )
{ return [ref decodingFailurePolicy]; }

// Encode general data
void CoderEncodeArrayOfObjCType( NSCoder *ref, CFStringRef type, NSUInteger count, void *array )
{ [ref encodeArrayOfObjCType:[(__bridge NSString *)type UTF8String] count:count at:array]; }

void CoderEncodeBoolForKey( NSCoder *ref, BOOL value, CFStringRef key )
{ [ref encodeBool:value forKey:(__bridge NSString *)key]; }

void CoderEncodeBycopyObject( NSCoder *ref, CFTypeRef obj )
{ [ref encodeBycopyObject:(__bridge id)obj]; }

void CoderEncodeByrefObject( NSCoder *ref, CFTypeRef obj )
{ [ref encodeByrefObject:(__bridge id)obj]; }

void CoderEncodeBytes( NSCoder *ref, void *byteAddress, NSUInteger length )
{ [ref encodeBytes:byteAddress length:length]; }

void CoderEncodeBytesForKey( NSCoder *ref, void *byteAddress, NSUInteger length, CFStringRef key )
{ [ref encodeBytes:byteAddress length:length forKey:(__bridge NSString *)key]; }

void CoderEncodeConditionalObject( NSCoder *ref, CFTypeRef obj )
{ [ref encodeConditionalObject:(__bridge id)obj]; }

void CoderEncodeConditionalObjectForKey( NSCoder *ref, CFTypeRef obj, CFStringRef key )
{ [ref encodeConditionalObject:(__bridge id)obj forKey:(__bridge NSString *)key]; }

void CoderEncodeDataObject( NSCoder *ref, CFDataRef dta )
{ [ref encodeDataObject:(__bridge id)dta]; }

void CoderEncodeDoubleForKey( NSCoder *ref, double value, CFStringRef key )
{ [ref encodeDouble:value forKey:(__bridge NSString *)key]; }

void CoderEncodeFloatForKey( NSCoder *ref, float value, CFStringRef key )
{ [ref encodeFloat:value forKey:(__bridge NSString *)key]; }

void CoderEncodeIntForKey( NSCoder *ref, SInt32 value, CFStringRef key )
{ [ref encodeInt:value forKey:(__bridge NSString *)key]; }

void CoderEncodeIntegerForKey( NSCoder *ref, NSInteger value, CFStringRef key )
{ [ref encodeInteger:value forKey:(__bridge NSString *)key]; }

void CoderEncodeInt32ForKey( NSCoder *ref, SInt32 value, CFStringRef key )
{ [ref encodeInt32:value forKey:(__bridge NSString *)key]; }

void CoderEncodeInt64ForKey( NSCoder *ref, SInt64 value, CFStringRef key )
{ [ref encodeInt64:value forKey:(__bridge NSString *)key]; }

void CoderEncodeObject( NSCoder *ref, CFTypeRef obj )
{ [ref encodeObject:(__bridge id)obj]; }

void CoderEncodeObjectForKey( NSCoder *ref, CFTypeRef obj, CFStringRef key )
{ [ref encodeObject:(__bridge id)obj forKey:(__bridge NSString *)key]; }

void CoderEncodePoint( NSCoder *ref, CGPoint pt )
{ [ref encodePoint:NSPointFromCGPoint(pt)]; }

void CoderEncodePointForKey( NSCoder *ref, CGPoint pt, CFStringRef key )
{ [ref encodePoint:NSPointFromCGPoint(pt) forKey:(__bridge NSString *)key]; }

void CoderEncodePropertyList( NSCoder *ref, CFTypeRef propertyList )
{ [ref encodePropertyList:(__bridge id)propertyList]; }

void CoderEncodeRect( NSCoder *ref, CGRect r )
{ [ref encodeRect:NSRectFromCGRect(r)]; }

void CoderEncodeRectForKey( NSCoder *ref, CGRect r, CFStringRef key )
{ [ref encodeRect:NSRectFromCGRect(r) forKey:(__bridge NSString *)key]; }

void CoderEncodeRootObject( NSCoder *ref, CFTypeRef rootObject )
{ [ref encodeRootObject:(__bridge id)rootObject]; }

void CoderEncodeSize( NSCoder *ref, CGSize size )
{ [ref encodeSize:NSSizeFromCGSize(size)]; }

void CoderEncodeSizeForKey( NSCoder *ref, CGSize size, CFStringRef key )
{ [ref encodeSize:NSSizeFromCGSize(size) forKey:(__bridge NSString *)key]; }

void CoderEncodeValueOfObjCType( NSCoder *ref, CFStringRef type, void *address )
{ [ref encodeValueOfObjCType:[(__bridge NSString *)type UTF8String] at:address]; }

void CoderEncodeValuesOfObjCTypes( NSCoder *ref, CFStringRef type, ... )
{
    va_list ap;
    va_start( ap, type );
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    while ( type ) {
        [array addObject:(__bridge NSString *)type];
        type = (__bridge CFStringRef)(va_arg( ap, id ));
    }
    
    va_end(ap);

    NSUInteger count = [array count];
    if ( count ) {
        const char *types[count];
        NSUInteger index = 0;
        for ( NSString *type in array ) {
            types[index] = (const char *)[type UTF8String];
        }
        [ref encodeValuesOfObjCTypes:(const char *)types];
    }
}

// Encode core media time structures
//void CoderEncodeCMTime( NSCoder *ref, CMTime time, CFStringRef key )
//{ [ref encodeCMTime:time forKey:(__bridge NSString *)key]; }
//
//void CoderEncodeCMTimeRange( NSCoder *ref, CMTimeRange range, CFStringRef key )
//{ [ref encodeCMTimeRange:range forKey:(__bridge NSString *)key]; }
//
//void CoderEncodeCMTimeMapping( NSCoder *ref, CMTimeMapping mapping, CFStringRef key )
//{ [ref encodeCMTimeMapping:mapping forKey:(__bridge NSString *)key]; }

// Secure coding
BOOL CoderRequiresSecureCoding( NSCoder *ref )
{ return [ref requiresSecureCoding]; }

CFSetRef CoderAllowedClasses( NSCoder *ref )
{ return (__bridge CFSetRef)[ref allowedClasses]; }

// Decode general data
CFTypeRef CoderDecodeObjectOfClass( NSCoder *ref, Class class, CFStringRef key )
{ return (__bridge CFTypeRef)[ref decodeObjectOfClass:class forKey:(__bridge NSString *)key]; }

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
CFArrayRef CoderDecodeArrayOfObjectsOfClass( NSCoder *ref, Class class, CFStringRef key )
{ return (__bridge CFArrayRef)[ref decodeArrayOfObjectsOfClass:class forKey:(__bridge NSString *)key]; }

CFArrayRef CoderDecodeArrayOfObjectsOfClasses( NSCoder *ref, CFSetRef classes, CFStringRef key )
{ return (__bridge CFArrayRef)[ref decodeArrayOfObjectsOfClasses:(__bridge NSSet *)classes forKey:(__bridge NSString *)key]; }

CFDictionaryRef CoderDecodeDictionaryWithKeysOfObjectsOfClass( NSCoder *ref, Class keyClass, Class objClass, CFStringRef key )
{ return (__bridge CFDictionaryRef)[ref decodeDictionaryWithKeysOfClass:keyClass objectsOfClass:objClass forKey:(__bridge NSString *)key]; }

CFDictionaryRef CoderDecodeDictionaryWithKeysOfObjectsOfClasses( NSCoder *ref, CFSetRef keyClasses, CFSetRef objClasses, CFStringRef key )
{ return (__bridge CFDictionaryRef)[ref decodeDictionaryWithKeysOfClasses:(__bridge NSSet *)keyClasses objectsOfClasses:(__bridge NSSet *)objClasses forKey:(__bridge NSString *)key]; }
#endif// 110000
