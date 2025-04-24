/*
 KeyValueCoding.m

 Bernie Wylde
 */

#import "KeyValueCoding.h"

// Getting values
//CFTypeRef KeyValueCodingValueForKey( CFTypeRef obj, CFStringRef key )
//{ return (__bridge CFTypeRef)[(__bridge id)obj valueForKey:(__bridge NSString *)key]; }
//
//CFTypeRef KeyValueCodingValueForKeyPath( CFTypeRef obj, CFStringRef keyPath )
//{ return (__bridge CFTypeRef)[(__bridge id)obj valueForKeyPath:(__bridge NSString *)keyPath]; }
//
//CFDictionaryRef KeyValueCodingDictionaryWithValuesForKeys( CFTypeRef obj, CFArrayRef keys )
//{ return (__bridge CFDictionaryRef)[(__bridge id)obj dictionaryWithValuesForKeys:(__bridge NSArray *)keys]; }
//
//CFTypeRef KeyValueCodingValueForUndefinedKey( CFTypeRef obj, CFStringRef key )
//{ return (__bridge CFTypeRef)[(__bridge id)obj valueForUndefinedKey:(__bridge NSString *)key]; }
//
//CFMutableArrayRef KeyValueCodingMutableArrayValueForKey( CFTypeRef obj, CFStringRef key )
//{ return (__bridge CFMutableArrayRef)[(__bridge id)obj mutableArrayValueForKey:(__bridge NSString *)key]; }
//
//CFMutableArrayRef KeyValueCodingMutableArrayValueForKeyPath( CFTypeRef obj, CFStringRef keyPath )
//{ return (__bridge CFMutableArrayRef)[(__bridge id)obj mutableArrayValueForKeyPath:(__bridge NSString *)keyPath]; }
//
//CFMutableSetRef KeyValueCodingMutableSetValueForKey( CFTypeRef obj, CFStringRef key )
//{ return (__bridge CFMutableSetRef)[(__bridge id)obj mutableSetValueForKey:(__bridge NSString *)key]; }
//
//CFMutableSetRef KeyValueCodingMutableSetValueForKeyPath( CFTypeRef obj, CFStringRef keyPath )
//{ return (__bridge CFMutableSetRef)[(__bridge id)obj mutableSetValueForKeyPath:(__bridge NSString *)keyPath]; }
//
//OrderedSetRef KeyValueCodingMutableOrderedSetValueForKey( CFTypeRef obj, CFStringRef key )
//{ return [(__bridge id)obj mutableOrderedSetValueForKey:(__bridge NSString *)key]; }
//
//OrderedSetRef KeyValueCodingMutableOrderedSetValueForKeyPath( CFTypeRef obj, CFStringRef keyPath )
//{ return [(__bridge id)obj mutableOrderedSetValueForKeyPath:(__bridge NSString *)keyPath]; }

// Setting values
//void KeyValueCodingSetValueForKeyPath( CFTypeRef obj, CFTypeRef value, CFStringRef keyPath )
//{ [(__bridge id)obj setValue:(__bridge id)value forKeyPath:(__bridge NSString *)keyPath]; }
//
//void KeyValueCodingSetValuesForKeysWithDictionary( CFTypeRef obj, CFDictionaryRef keyedValues )
//{ [(__bridge id)obj setValuesForKeysWithDictionary:(__bridge NSDictionary *)keyedValues]; }
//
//void KeyValueCodingSetNilValueForKey( CFTypeRef obj, CFStringRef key )
//{ [(__bridge id)obj setNilValueForKey:(__bridge NSString *)key]; }
//
//void KeyValueCodingSetValueForKey( CFTypeRef obj, CFTypeRef value, CFStringRef key )
//{ [(__bridge id)obj setValue:(__bridge id)value forKey:(__bridge NSString *)key]; }
//
//void KeyValueCodingSetValueForUndefinedKey( CFTypeRef obj, CFTypeRef value, CFStringRef key )
//{ [(__bridge id)obj setValue:(__bridge id)value forUndefinedKey:(__bridge NSString *)key]; }
//
//// Default behavior
//BOOL KeyValueCodingAccessInstanceVariablesDirectly( CFTypeRef obj )
//{ return [(__bridge id)obj accessInstanceVariablesDirectly]; }
//
//// Validation
//BOOL KeyValueCodingValidateValueForKey( CFTypeRef obj, CFTypeRef *value, CFStringRef key, NSError **err )
//{ return [(__bridge id)obj validateValue:(__bridge id*)value forKey:(__bridge NSString *)key error:err]; }
//
//BOOL KeyValueCodingValidateValueForKeyPath( CFTypeRef obj, CFTypeRef *value, CFStringRef keyPath, NSError **err )
//{ return [(__bridge id)obj validateValue:(__bridge id*)value forKeyPath:(__bridge NSString *)keyPath error:err]; }


#pragma mark - functions
// Getting values
CFTypeRef ObjectValueForKey( CFTypeRef obj, CFStringRef key )
{ return (__bridge CFTypeRef)[(__bridge id)obj valueForKey:(__bridge NSString *)key]; }

CFTypeRef ObjectValueForKeyPath( CFTypeRef ref, CFStringRef keyPath )
{ return (__bridge CFTypeRef)[(__bridge id)ref valueForKeyPath:(__bridge NSString *)keyPath]; }

CFDictionaryRef ObjectDictionaryWithValuesForKeys( CFTypeRef obj, CFArrayRef keys )
{ return (__bridge CFDictionaryRef)[(__bridge id)obj dictionaryWithValuesForKeys:(__bridge NSArray *)keys]; }

CFTypeRef ObjectValueForUndefinedKey( CFTypeRef obj, CFStringRef key )
{ return (__bridge CFTypeRef)[(__bridge id)obj valueForUndefinedKey:(__bridge NSString *)key]; }

CFMutableArrayRef ObjectMutableArrayValueForKey( CFTypeRef obj, CFStringRef key )
{ return (__bridge CFMutableArrayRef)[(__bridge id)obj mutableArrayValueForKey:(__bridge NSString *)key]; }

CFMutableArrayRef ObjectMutableArrayValueForKeyPath( CFTypeRef obj, CFStringRef keyPath )
{ return (__bridge CFMutableArrayRef)[(__bridge id)obj mutableArrayValueForKeyPath:(__bridge NSString *)keyPath]; }

CFMutableSetRef ObjectMutableSetValueForKey( CFTypeRef obj, CFStringRef key )
{ return (__bridge CFMutableSetRef)[(__bridge id)obj mutableSetValueForKey:(__bridge NSString *)key]; }

CFMutableSetRef ObjectMutableSetValueForKeyPath( CFTypeRef obj, CFStringRef keyPath )
{ return (__bridge CFMutableSetRef)[(__bridge id)obj mutableSetValueForKeyPath:(__bridge NSString *)keyPath]; }

OrderedSetRef ObjectMutableOrderedSetValueForKey( CFTypeRef obj, CFStringRef key )
{ return [(__bridge id)obj mutableOrderedSetValueForKey:(__bridge NSString *)key]; }

OrderedSetRef ObjectMutableOrderedSetValueForKeyPath( CFTypeRef obj, CFStringRef keyPath )
{ return [(__bridge id)obj mutableOrderedSetValueForKeyPath:(__bridge NSString *)keyPath]; }

// Setting values
void ObjectSetValueForKeyPath( CFTypeRef ref, CFTypeRef value, CFStringRef keyPath )
{ [(__bridge id)ref setValue:(__bridge id)value forKeyPath:(__bridge NSString *)keyPath]; }

void ObjectSetValuesForKeysWithDictionary( CFTypeRef obj, CFDictionaryRef keyedValues )
{ [(__bridge id)obj setValuesForKeysWithDictionary:(__bridge NSDictionary *)keyedValues]; }

void ObjectSetNilValueForKey( CFTypeRef obj, CFStringRef key )
{ [(__bridge id)obj setNilValueForKey:(__bridge NSString *)key]; }

void ObjectSetValueForKey( CFTypeRef obj, CFTypeRef value, CFStringRef key )
{ [(__bridge id)obj setValue:(__bridge id)value forKey:(__bridge NSString *)key]; }

void ObjectSetValueForUndefinedKey( CFTypeRef obj, CFTypeRef value, CFStringRef key )
{ [(__bridge id)obj setValue:(__bridge id)value forUndefinedKey:(__bridge NSString *)key]; }

// Default behavior
BOOL ObjectAccessInstanceVariablesDirectly( CFTypeRef obj )
{ return [(__bridge id)obj accessInstanceVariablesDirectly]; }

// Validation
BOOL ObjectValidateValueForKey( CFTypeRef obj, CFTypeRef *value, CFStringRef key, NSError **err )
{
    id tempValue = nil;
    BOOL flag = [(__bridge id)obj validateValue:&tempValue forKey:(__bridge NSString *)key error:err];
    if ( value ) *value = (__bridge CFTypeRef)tempValue;
    return flag;
}

BOOL ObjectValidateValueForKeyPath( CFTypeRef obj, CFTypeRef *value, CFStringRef keyPath, NSError **err )
{
    id tempValue = nil;
    BOOL flag = [(__bridge id)obj validateValue:&tempValue forKeyPath:(__bridge NSString *)keyPath error:err];
    if ( value ) *value = (__bridge CFTypeRef)tempValue;
    return flag;
}
