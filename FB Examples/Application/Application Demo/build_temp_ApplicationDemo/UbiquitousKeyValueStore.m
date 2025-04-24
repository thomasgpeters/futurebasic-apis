/*
 UbiquitousKeyValueStore.m

 Bernie Wylde
 */

#import "UbiquitousKeyValueStore.h"

// Class
Class UbiquitousKeyValueStoreClass( void )
{ return [NSUbiquitousKeyValueStore class]; }

// Shared instance
NSUbiquitousKeyValueStore *UbiquitousKeyValueStoreDefault( void )
{ return [NSUbiquitousKeyValueStore defaultStore]; }

// Getting values
CFArrayRef UbiquitousKeyValueStoreArray( CFStringRef key )
{ return (__bridge CFArrayRef)[[NSUbiquitousKeyValueStore defaultStore] arrayForKey:(__bridge NSString *)key]; }

BOOL UbiquitousKeyValueStoreBool( CFStringRef key )
{ return [[NSUbiquitousKeyValueStore defaultStore] boolForKey:(__bridge NSString *)key]; }

CFDataRef UbiquitousKeyValueStoreData( CFStringRef key )
{ return (__bridge CFDataRef)[[NSUbiquitousKeyValueStore defaultStore] dataForKey:(__bridge NSString *)key]; }

CFDictionaryRef UbiquitousKeyValueStoreDictionary( CFStringRef key )
{ return (__bridge CFDictionaryRef)[[NSUbiquitousKeyValueStore defaultStore] dictionaryForKey:(__bridge NSString *)key]; }

double UbiquitousKeyValueStoreDouble( CFStringRef key )
{ return [[NSUbiquitousKeyValueStore defaultStore] doubleForKey:(__bridge NSString *)key]; }

SInt64 UbiquitousKeyValueStoreLongLong( CFStringRef key )
{ return [[NSUbiquitousKeyValueStore defaultStore] longLongForKey:(__bridge NSString *)key]; }

CFTypeRef UbiquitousKeyValueStoreObject( CFStringRef key )
{ return (__bridge CFTypeRef)[[NSUbiquitousKeyValueStore defaultStore] objectForKey:(__bridge NSString *)key]; }

CFStringRef UbiquitousKeyValueStoreString( CFStringRef key )
{ return (__bridge CFStringRef)[[NSUbiquitousKeyValueStore defaultStore] stringForKey:(__bridge NSString *)key]; }

// Setting values
void UbiquitousKeyValueStoreSetArray( CFStringRef key, CFArrayRef value )
{ [[NSUbiquitousKeyValueStore defaultStore] setArray:(__bridge NSArray *)value forKey:(__bridge NSString *)key]; }

void UbiquitousKeyValueStoreSetBool( CFStringRef key, BOOL value )
{ [[NSUbiquitousKeyValueStore defaultStore] setBool:value forKey:(__bridge NSString *)key]; }

void UbiquitousKeyValueStoreSetData( CFStringRef key, CFDataRef value )
{ [[NSUbiquitousKeyValueStore defaultStore] setData:(__bridge NSData *)value forKey:(__bridge NSString *)key]; }

void UbiquitousKeyValueStoreSetDictionary( CFStringRef key, CFDictionaryRef value )
{ [[NSUbiquitousKeyValueStore defaultStore] setDictionary:(__bridge NSDictionary *)value forKey:(__bridge NSString *)key]; }

void UbiquitousKeyValueStoreSetDouble( CFStringRef key, double value )
{ [[NSUbiquitousKeyValueStore defaultStore] setDouble:value forKey:(__bridge NSString *)key]; }

void UbiquitousKeyValueStoreSetLongLong( CFStringRef key, SInt64 value )
{ [[NSUbiquitousKeyValueStore defaultStore] setLongLong:value forKey:(__bridge NSString *)key]; }

void UbiquitousKeyValueStoreSetObject( CFStringRef key, CFTypeRef value )
{ [[NSUbiquitousKeyValueStore defaultStore] setObject:(__bridge id)value forKey:(__bridge NSString *)key]; }

void UbiquitousKeyValueStoreSetString( CFStringRef key, CFStringRef value )
{ [[NSUbiquitousKeyValueStore defaultStore] setString:(__bridge NSString *)value forKey:(__bridge NSString *)key]; }

// Synchronize
BOOL UbiquitousKeyValueStoreSynchronize( void )
{ return [[NSUbiquitousKeyValueStore defaultStore] synchronize]; }

// Removing keys
void UbiquitousKeyValueRemoveObjectForKey( CFStringRef key )
{ [[NSUbiquitousKeyValueStore defaultStore] removeObjectForKey:(__bridge NSString *)key]; }

// Keys and values
CFDictionaryRef UbiquitousKeyValueStoreDictionaryRepresentation( void )
{ return (__bridge CFDictionaryRef)[[NSUbiquitousKeyValueStore defaultStore] dictionaryRepresentation]; }

