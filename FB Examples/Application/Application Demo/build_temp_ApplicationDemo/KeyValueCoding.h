/*
 KeyValueCoding.h

 Bernie Wylde
 */

#import "CocoaUI.h"

// Getting values
//CFTypeRef KeyValueCodingValueForKey( CFTypeRef obj, CFStringRef key );
//CFTypeRef KeyValueCodingValueForKeyPath( CFTypeRef obj, CFStringRef keyPath );
//CFDictionaryRef KeyValueCodingDictionaryWithValuesForKeys( CFTypeRef obj, CFArrayRef keys );
//CFTypeRef KeyValueCodingValueForUndefinedKey( CFTypeRef obj, CFStringRef key );
//CFMutableArrayRef KeyValueCodingMutableArrayValueForKey( CFTypeRef obj, CFStringRef key );
//CFMutableArrayRef KeyValueCodingMutableArrayValueForKeyPath( CFTypeRef obj, CFStringRef keyPath );
//CFMutableSetRef KeyValueCodingMutableSetValueForKey( CFTypeRef obj, CFStringRef key );
//CFMutableSetRef KeyValueCodingMutableSetValueForKeyPath( CFTypeRef obj, CFStringRef keyPath );
//OrderedSetRef KeyValueCodingMutableOrderedSetValueForKey( CFTypeRef obj, CFStringRef key );
//OrderedSetRef KeyValueCodingMutableOrderedSetValueForKeyPath( CFTypeRef obj, CFStringRef keyPath );

// Setting values
//void KeyValueCodingSetValueForKeyPath( CFTypeRef obj, CFTypeRef value, CFStringRef keyPath );
//void KeyValueCodingSetValuesForKeysWithDictionary( CFTypeRef obj, CFDictionaryRef keyedValues );
//void KeyValueCodingSetNilValueForKey( CFTypeRef obj, CFStringRef key );
//void KeyValueCodingSetValueForKey( CFTypeRef obj, CFTypeRef value, CFStringRef key );
//void KeyValueCodingSetValueForUndefinedKey( CFTypeRef obj, CFTypeRef value, CFStringRef key );

// Default behavior
//BOOL KeyValueCodingAccessInstanceVariablesDirectly( CFTypeRef obj );

// Validation
//BOOL KeyValueCodingValidateValueForKey( CFTypeRef obj, CFTypeRef *value, CFStringRef key, NSError **err );
//BOOL KeyValueCodingValidateValueForKeyPath( CFTypeRef obj, CFTypeRef *value, CFStringRef keyPath, NSError **err );



// Getting values
CFTypeRef ObjectValueForKey( CFTypeRef obj, CFStringRef key );
CFTypeRef ObjectValueForKeyPath( CFTypeRef obj, CFStringRef keyPath );
CFDictionaryRef ObjectDictionaryWithValuesForKeys( CFTypeRef obj, CFArrayRef keys );
CFTypeRef ObjectValueForUndefinedKey( CFTypeRef obj, CFStringRef key );
CFMutableArrayRef ObjectMutableArrayValueForKey( CFTypeRef obj, CFStringRef key );
CFMutableArrayRef ObjectMutableArrayValueForKeyPath( CFTypeRef obj, CFStringRef keyPath );
CFMutableSetRef ObjectMutableSetValueForKey( CFTypeRef obj, CFStringRef key );
CFMutableSetRef ObjectMutableSetValueForKeyPath( CFTypeRef obj, CFStringRef keyPath );
OrderedSetRef ObjectMutableOrderedSetValueForKey( CFTypeRef obj, CFStringRef key );
OrderedSetRef ObjectMutableOrderedSetValueForKeyPath( CFTypeRef obj, CFStringRef keyPath );

// Setting values
void ObjectSetValueForKeyPath( CFTypeRef obj, CFTypeRef value, CFStringRef keyPath );
void ObjectSetValuesForKeysWithDictionary( CFTypeRef obj, CFDictionaryRef keyedValues );
void ObjectSetNilValueForKey( CFTypeRef obj, CFStringRef key );
void ObjectSetValueForKey( CFTypeRef obj, CFTypeRef value, CFStringRef key );
void ObjectSetValueForUndefinedKey( CFTypeRef obj, CFTypeRef value, CFStringRef key );

// Default behavior
BOOL ObjectAccessInstanceVariablesDirectly( CFTypeRef obj );

// Validation
BOOL ObjectValidateValueForKey( CFTypeRef obj, CFTypeRef *value, CFStringRef key, NSError **err );
BOOL ObjectValidateValueForKeyPath( CFTypeRef obj, CFTypeRef *value, CFStringRef keyPath, NSError **err );
