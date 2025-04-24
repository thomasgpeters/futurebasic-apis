/*
 Coder.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class CoderClass( void );

// Inspect
BOOL CoderAllowsKeyedCoding( NSCoder *ref );
BOOL CoderContainsValueForKey( NSCoder *ref, CFStringRef key );
NSDecodingFailurePolicy CoderDecodingFailurePolicy( NSCoder *ref );

// Encode general data
void CoderEncodeArrayOfObjCType( NSCoder *ref, CFStringRef type, NSUInteger count, void *array );
void CoderEncodeBoolForKey( NSCoder *ref, BOOL value, CFStringRef key );
void CoderEncodeBycopyObject( NSCoder *ref, CFTypeRef obj );
void CoderEncodeByrefObject( NSCoder *ref, CFTypeRef obj );
void CoderEncodeBytes( NSCoder *ref, void *byteAddress, NSUInteger length );
void CoderEncodeBytesForKey( NSCoder *ref, void *byteAddress, NSUInteger length, CFStringRef key );
void CoderEncodeConditionalObject( NSCoder *ref, CFTypeRef obj );
void CoderEncodeConditionalObjectForKey( NSCoder *ref, CFTypeRef obj, CFStringRef key );
void CoderEncodeDataObject( NSCoder *ref, CFDataRef dta );
void CoderEncodeDoubleForKey( NSCoder *ref, double value, CFStringRef key );
void CoderEncodeFloatForKey( NSCoder *ref, float value, CFStringRef key );
void CoderEncodeIntForKey( NSCoder *ref, SInt32 value, CFStringRef key );
void CoderEncodeIntegerForKey( NSCoder *ref, NSInteger value, CFStringRef key );
void CoderEncodeInt32ForKey( NSCoder *ref, SInt32 value, CFStringRef key );
void CoderEncodeInt64ForKey( NSCoder *ref, SInt64 value, CFStringRef key );
void CoderEncodeObject( NSCoder *ref, CFTypeRef obj );
void CoderEncodeObjectForKey( NSCoder *ref, CFTypeRef obj, CFStringRef key );
void CoderEncodePoint( NSCoder *ref, CGPoint pt );
void CoderEncodePointForKey( NSCoder *ref, CGPoint pt, CFStringRef key );
void CoderEncodePropertyList( NSCoder *ref, CFTypeRef propertyList );
void CoderEncodeRect( NSCoder *ref, CGRect r );
void CoderEncodeRectForKey( NSCoder *ref, CGRect r, CFStringRef key );
void CoderEncodeRootObject( NSCoder *ref, CFTypeRef rootObject );
void CoderEncodeSize( NSCoder *ref, CGSize size );
void CoderEncodeSizeForKey( NSCoder *ref, CGSize size, CFStringRef key );
void CoderEncodeValueOfObjCType( NSCoder *ref, CFStringRef type, void *address );
void CoderEncodeValuesOfObjCTypes( NSCoder *ref, CFStringRef type, ... );

// Encode core media time structures
//void CoderEncodeCMTime( NSCoder *ref, CMTime time, CFStringRef key );
//void CoderEncodeCMTimeRange( NSCoder *ref, CMTimeRange range, CFStringRef key );
//void CoderEncodeCMTimeMapping( NSCoder *ref, CMTimeMapping mapping, CFStringRef key );

// Secure coding
BOOL CoderRequiresSecureCoding( NSCoder *ref );
CFSetRef CoderAllowedClasses( NSCoder *ref );

// Decode general data
CFTypeRef CoderDecodeObjectOfClass( NSCoder *ref, Class class, CFStringRef key );

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
CFArrayRef CoderDecodeArrayOfObjectsOfClass( NSCoder *ref, Class class, CFStringRef key );
API_AVAILABLE(macos(11.0))
CFArrayRef CoderDecodeArrayOfObjectsOfClasses( NSCoder *ref, CFSetRef classes, CFStringRef key );
API_AVAILABLE(macos(11.0))
CFDictionaryRef CoderDecodeDictionaryWithKeysOfObjectsOfClass( NSCoder *ref, Class keyClass, Class objClass, CFStringRef key );
API_AVAILABLE(macos(11.0))
CFDictionaryRef CoderDecodeDictionaryWithKeysOfObjectsOfClasses( NSCoder *ref, CFSetRef keyClasses, CFSetRef objClasses, CFStringRef key );
#endif// 110000
