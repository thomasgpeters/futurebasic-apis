/*
 KeyedArchiver.m

 Bernie Wylde
 */

#import "KeyedArchiver.h"

// Class
Class KeyedArchiverClass( void )
{ return [NSKeyedArchiver class]; }

// Archiving
CFDataRef KeyedArchiverArchivedDataWithRootObject( CFTypeRef obj )
{ return (__bridge CFDataRef)[NSKeyedArchiver archivedDataWithRootObject:(__bridge id)obj]; }

BOOL KeyedArchiverArchiveRootObjectToURL( CFTypeRef obj, CFURLRef url )
{ return [NSKeyedArchiver archiveRootObject:(__bridge id)obj toFile:[(__bridge NSURL *)url path]]; }

void KeyedArchiverFinishEncoding( NSKeyedArchiver *ref )
{ [ref finishEncoding]; }

NSPropertyListFormat KeyedArchiverOutputFormat( NSKeyedArchiver *ref )
{ return [ref outputFormat]; }

void KeyedArchiverSetOutputFormat( NSKeyedArchiver *ref, NSPropertyListFormat format )
{ [ref setOutputFormat:format]; }

BOOL KeyedArchiverRequiresSecureCoding( NSKeyedArchiver *ref )
{ return [ref requiresSecureCoding]; }

void KeyedArchiverSetRequiresSecureCoding( NSKeyedArchiver *ref, BOOL flag )
{ [ref setRequiresSecureCoding:flag]; }

// Encoding
void KeyedArchiverEncodeBool( NSKeyedArchiver *ref, BOOL value, CFStringRef key )
{ [ref encodeBool:value forKey:(__bridge NSString *)key]; }

void KeyedArchiverEncodeBytes( NSKeyedArchiver *ref, void *bytes, NSUInteger length, CFStringRef key )
{ [ref encodeBytes:bytes length:length forKey:(__bridge NSString *)key]; }

void KeyedArchiverEncodeConditionalObject( NSKeyedArchiver *ref, CFTypeRef obj, CFStringRef key )
{ [ref encodeConditionalObject:(__bridge id)obj forKey:(__bridge NSString *)key]; }

void KeyedArchiverEncodeDouble( NSKeyedArchiver *ref, double value, CFStringRef key )
{ [ref encodeDouble:value forKey:(__bridge NSString *)key]; }

void KeyedArchiverEncodeFloat( NSKeyedArchiver *ref, float value, CFStringRef key )
{ [ref encodeFloat:value forKey:(__bridge NSString *)key]; }

void KeyedArchiverEncodeInt32( NSKeyedArchiver *ref, SInt32 value, CFStringRef key )
{ [ref encodeInt32:value forKey:(__bridge NSString *)key]; }

void KeyedArchiverEncodeInt64( NSKeyedArchiver *ref, SInt64 value, CFStringRef key )
{ [ref encodeInt64:value forKey:(__bridge NSString *)key]; }

void KeyedArchiverEncodeObject( NSKeyedArchiver *ref, CFTypeRef obj, CFStringRef key )
{ [ref encodeObject:(__bridge id)obj forKey:(__bridge NSString *)key]; }

// Classes and class names
void KeyedArchiverSetClassNameForClass( CFStringRef codedName, Class forClass )
{ [NSKeyedArchiver setClassName:(__bridge NSString *)codedName forClass:forClass]; }

CFStringRef KeyedArchiverClassNameForClass( Class forClass )
{ return (__bridge CFStringRef)[NSKeyedArchiver classNameForClass:forClass]; }

void KeyedArchiverSetClassName( NSKeyedArchiver *ref, CFStringRef codedName, Class forClass )
{ [ref setClassName:(__bridge NSString *)codedName forClass:forClass]; }

CFStringRef KeyedArchiverClassName( NSKeyedArchiver *ref, Class forClass )
{ return (__bridge CFStringRef)[ref classNameForClass:forClass]; }

// Initializers
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
NSKeyedArchiver *KeyedArchiverRequiringSecureCoding( BOOL flag )
{
#if __has_feature(objc_arc)
    return [[NSKeyedArchiver alloc] initRequiringSecureCoding:flag];
#else
    return [[[NSKeyedArchiver alloc] initRequiringSecureCoding:flag] autorelease];
#endif
}
#endif

// Instance properties
CFDataRef KeyedArchiverEncodedData( NSKeyedArchiver *ref )
{ return (__bridge CFDataRef)[ref encodedData]; }

// Type methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
CFDataRef KeyedArchiverArchivedDataRequiringSecureCoding( CFTypeRef obj, BOOL secureCoding, NSError **err )
{ return (__bridge CFDataRef)[NSKeyedArchiver archivedDataWithRootObject:(__bridge id)obj requiringSecureCoding:secureCoding error:err]; }
#endif



/*
 KeyedUnarchiver
 */

// Unarchiving
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
CFTypeRef KeyedUnarchiverUnarchivedObjectOfClass( Class class, CFDataRef fromData, NSError **err )
{ return (__bridge CFTypeRef)[NSKeyedUnarchiver unarchivedObjectOfClass:class fromData:(__bridge NSData *)fromData error:err]; }

CFTypeRef KeyedUnarchiverUnarchivedObjectOfClasses( CFSetRef classes, CFDataRef fromData, NSError **err )
{ return (__bridge CFTypeRef)[NSKeyedUnarchiver unarchivedObjectOfClasses:(__bridge NSSet *)classes fromData:(__bridge NSData *)fromData error:err]; }
#endif

CFTypeRef KeyedUnarchiverUnarchiveObjectWithData( CFDataRef dta )
{ return (__bridge CFTypeRef)[NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)dta]; }

CFTypeRef KeyedUnarchiverUnarchiveObjectWithURL( CFURLRef url )
{ return (__bridge CFTypeRef)[NSKeyedUnarchiver unarchiveObjectWithFile:[(__bridge NSURL *)url path]]; }

BOOL KeyedUnarchiverRequiresSecureCoding( NSKeyedUnarchiver *ref )
{ return [ref requiresSecureCoding]; }

void KeyedUnarchiverSetRequiresSecureCoding( NSKeyedUnarchiver *ref, BOOL flag )
{ [ref setRequiresSecureCoding:flag]; }

// Decoding
BOOL KeyedUnarchiverContainsValue( NSKeyedUnarchiver *ref, CFStringRef key )
{ return [ref containsValueForKey:(__bridge NSString *)key]; }

BOOL KeyedUnarchiverDecodeBool( NSKeyedUnarchiver *ref, CFStringRef key )
{ return [ref decodeBoolForKey:(__bridge NSString *)key]; }

const uint8_t *KeyedUnarchiverDecodeBytes( NSKeyedUnarchiver *ref, CFStringRef key, NSUInteger *returnedLength )
{ return [ref decodeBytesForKey:(__bridge NSString *)key returnedLength:returnedLength]; }

double KeyedUnarchiverDecodeDouble( NSKeyedUnarchiver *ref, CFStringRef key )
{ return [ref decodeDoubleForKey:(__bridge NSString *)key]; }

float KeyedUnarchiverDecodeFloat( NSKeyedUnarchiver *ref, CFStringRef key )
{ return [ref decodeFloatForKey:(__bridge NSString *)key]; }

SInt32 KeyedUnarchiverDecodeInt32( NSKeyedUnarchiver *ref, CFStringRef key )
{ return [ref decodeInt32ForKey:(__bridge NSString *)key]; }

SInt64 KeyedUnarchiverDecodeInt64( NSKeyedUnarchiver *ref, CFStringRef key )
{ return [ref decodeInt64ForKey:(__bridge NSString *)key]; }

CFTypeRef KeyedUnarchiverDecodeObject( NSKeyedUnarchiver *ref, CFStringRef key )
{ return (__bridge CFTypeRef)[ref decodeObjectForKey:(__bridge NSString *)key]; }

void KeyedUnarchiverFinishDecoding( NSKeyedUnarchiver *ref )
{ [ref finishDecoding]; }

// Classes
void KeyedUnarchiverSetClassForClassName( Class class, CFStringRef codedName )
{ [NSKeyedUnarchiver setClass:class forClassName:(__bridge NSString *)codedName]; }

Class KeyedUnarchiverClassForClassName( CFStringRef codedName )
{ return [NSKeyedUnarchiver classForClassName:(__bridge NSString *)codedName]; }

void KeyedUnarchiverSetClass( NSKeyedUnarchiver *ref, Class class, CFStringRef codedName )
{ [ref setClass:class forClassName:(__bridge NSString *)codedName]; }

Class KeyedUnarchiverClass( NSKeyedUnarchiver *ref, CFStringRef codedName )
{ return [ref classForClassName:(__bridge NSString *)codedName]; }

// Initializers
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
NSKeyedUnarchiver *KeyedUnarchiverForReadingFromData( CFDataRef dta, NSError **err )
{
#if __has_feature(objc_arc)
    return [[NSKeyedUnarchiver alloc] initForReadingFromData:(__bridge NSData *)dta error:err];
#else
    return [[[NSKeyedUnarchiver alloc] initForReadingFromData:(__bridge NSData *)dta error:err] autorelease];
#endif
}
#endif

// Instance properties
NSUInteger KeyedUnarchiverDecodingFailurePolicy( NSKeyedUnarchiver *ref )
{ return [ref decodingFailurePolicy]; }

void KeyedUnarchiverSetDecodingFailurePolicy( NSKeyedUnarchiver *ref, NSUInteger policy )
{ [ref setDecodingFailurePolicy:policy]; }

// Type methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
CFArrayRef KeyedUnarchiverUnarchivedArrayOfObjectsOfClass( Class class, CFDataRef fromData, NSError **err )
{ return (__bridge CFArrayRef)[NSKeyedUnarchiver unarchivedArrayOfObjectsOfClass:class fromData:(__bridge NSData *)fromData error:err]; }

CFArrayRef KeyedUnarchiverUnarchivedArrayOfObjectsOfClasses( CFSetRef classes, CFDataRef fromData, NSError **err )
{ return (__bridge CFArrayRef)[NSKeyedUnarchiver unarchivedArrayOfObjectsOfClasses:(__bridge NSSet *)classes fromData:(__bridge NSData *)fromData error:err]; }

CFDictionaryRef KeyedUnarchiverUnarchivedDictionaryWithKeysOfClass( Class keyClass, Class objClass, CFDataRef fromData, NSError **err )
{ return (__bridge CFDictionaryRef)[NSKeyedUnarchiver unarchivedDictionaryWithKeysOfClass:keyClass objectsOfClass:objClass fromData:(__bridge NSData *)fromData error:err]; }

CFDictionaryRef KeyedUnarchiverUnarchivedDictionaryWithKeysOfClasses( CFSetRef keyClasses, CFSetRef valueClasses, CFDataRef fromData, NSError **err )
{ return (__bridge CFDictionaryRef)[NSKeyedUnarchiver unarchivedDictionaryWithKeysOfClasses:(__bridge NSSet *)keyClasses objectsOfClasses:(__bridge NSSet *)valueClasses fromData:(__bridge NSData *)fromData error:err]; }
#endif// 110000
