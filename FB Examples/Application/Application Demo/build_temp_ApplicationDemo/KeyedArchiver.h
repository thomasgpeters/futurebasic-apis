/*
 KeyedArchiver.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class KeyedArchiverClass( void );

// Archiving
CFDataRef KeyedArchiverArchivedDataWithRootObject( CFTypeRef obj );
BOOL KeyedArchiverArchiveRootObjectToURL( CFTypeRef obj, CFURLRef url );
void KeyedArchiverFinishEncoding( NSKeyedArchiver *ref );
NSPropertyListFormat KeyedArchiverOutputFormat( NSKeyedArchiver *ref );
void KeyedArchiverSetOutputFormat( NSKeyedArchiver *ref, NSPropertyListFormat format );
BOOL KeyedArchiverRequiresSecureCoding( NSKeyedArchiver *ref );
void KeyedArchiverSetRequiresSecureCoding( NSKeyedArchiver *ref, BOOL flag );

// Encoding
void KeyedArchiverEncodeBool( NSKeyedArchiver *ref, BOOL value, CFStringRef key );
void KeyedArchiverEncodeBytes( NSKeyedArchiver *ref, void *bytes, NSUInteger length, CFStringRef key );
void KeyedArchiverEncodeConditionalObject( NSKeyedArchiver *ref, CFTypeRef obj, CFStringRef key );
void KeyedArchiverEncodeDouble( NSKeyedArchiver *ref, double value, CFStringRef key );
void KeyedArchiverEncodeFloat( NSKeyedArchiver *ref, float value, CFStringRef key );
void KeyedArchiverEncodeInt32( NSKeyedArchiver *ref, SInt32 value, CFStringRef key );
void KeyedArchiverEncodeInt64( NSKeyedArchiver *ref, SInt64 value, CFStringRef key );
void KeyedArchiverEncodeObject( NSKeyedArchiver *ref, CFTypeRef obj, CFStringRef key );

// Classes and class names
void KeyedArchiverSetClassNameForClass( CFStringRef codedName, Class forClass );
CFStringRef KeyedArchiverClassNameForClass( Class forClass );
void KeyedArchiverSetClassName( NSKeyedArchiver *ref, CFStringRef codedName, Class forClass );
CFStringRef KeyedArchiverClassName( NSKeyedArchiver *ref, Class forClass );

// Initializers
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
NSKeyedArchiver *KeyedArchiverRequiringSecureCoding( BOOL flag );
#endif

// Instance properties
CFDataRef KeyedArchiverEncodedData( NSKeyedArchiver *ref );

// Type methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
CFDataRef KeyedArchiverArchivedDataRequiringSecureCoding( CFTypeRef obj, BOOL secureCoding, NSError **err );
#endif




/*
 KeyedUnarchiver
 */

// Unarchiving
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
CFTypeRef KeyedUnarchiverUnarchivedObjectOfClass( Class class, CFDataRef fromData, NSError **err );
API_AVAILABLE(macos(10.14))
CFTypeRef KeyedUnarchiverUnarchivedObjectOfClasses( CFSetRef classes, CFDataRef fromData, NSError **err );
API_AVAILABLE(macos(10.14))
#endif// 101400
CFTypeRef KeyedUnarchiverUnarchiveObjectWithData( CFDataRef dta );
CFTypeRef KeyedUnarchiverUnarchiveObjectWithURL( CFURLRef url );
BOOL KeyedUnarchiverRequiresSecureCoding( NSKeyedUnarchiver *ref );
void KeyedUnarchiverSetRequiresSecureCoding( NSKeyedUnarchiver *ref, BOOL flag );

// Decoding
BOOL KeyedUnarchiverContainsValue( NSKeyedUnarchiver *ref, CFStringRef key );
BOOL KeyedUnarchiverDecodeBool( NSKeyedUnarchiver *ref, CFStringRef key );
const uint8_t *KeyedUnarchiverDecodeBytes( NSKeyedUnarchiver *ref, CFStringRef key, NSUInteger *returnedLength );
double KeyedUnarchiverDecodeDouble( NSKeyedUnarchiver *ref, CFStringRef key );
float KeyedUnarchiverDecodeFloat( NSKeyedUnarchiver *ref, CFStringRef key );
SInt32 KeyedUnarchiverDecodeInt32( NSKeyedUnarchiver *ref, CFStringRef key );
SInt64 KeyedUnarchiverDecodeInt64( NSKeyedUnarchiver *ref, CFStringRef key );
CFTypeRef KeyedUnarchiverDecodeObject( NSKeyedUnarchiver *ref, CFStringRef key );
void KeyedUnarchiverFinishDecoding( NSKeyedUnarchiver *ref );

// Classes
void KeyedUnarchiverSetClassForClassName( Class class, CFStringRef codedName );
Class KeyedUnarchiverClassForClassName( CFStringRef codedName );
void KeyedUnarchiverSetClass( NSKeyedUnarchiver *ref, Class class, CFStringRef codedName );
Class KeyedUnarchiverClass( NSKeyedUnarchiver *ref, CFStringRef codedName );

// Initializers
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
NSKeyedUnarchiver *KeyedUnarchiverForReadingFromData( CFDataRef dta, NSError **err );
#endif// 101400

// Instance properties
NSUInteger KeyedUnarchiverDecodingFailurePolicy( NSKeyedUnarchiver *ref );
void KeyedUnarchiverSetDecodingFailurePolicy( NSKeyedUnarchiver *ref, NSUInteger policy );

// Type methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
CFArrayRef KeyedUnarchiverUnarchivedArrayOfObjectsOfClass( Class class, CFDataRef fromData, NSError **err );
API_AVAILABLE(macos(11.0))
CFArrayRef KeyedUnarchiverUnarchivedArrayOfObjectsOfClasses( CFSetRef classes, CFDataRef fromData, NSError **err );
API_AVAILABLE(macos(11.0))
CFDictionaryRef KeyedUnarchiverUnarchivedDictionaryWithKeysOfClass( Class keyClass, Class objClass, CFDataRef fromData, NSError **err );
API_AVAILABLE(macos(11.0))
CFDictionaryRef KeyedUnarchiverUnarchivedDictionaryWithKeysOfClasses( CFSetRef keyClasses, CFSetRef valueClasses, CFDataRef fromData, NSError **err );
#endif// 110000
