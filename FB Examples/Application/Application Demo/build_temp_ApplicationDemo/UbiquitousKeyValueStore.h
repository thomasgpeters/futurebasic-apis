/*
 UbiquitousKeyValueStore.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class UbiquitousKeyValueStoreClass( void );

// Shared instance
NSUbiquitousKeyValueStore *UbiquitousKeyValueStoreDefault( void );

// Getting values
CFArrayRef UbiquitousKeyValueStoreArray( CFStringRef key );
BOOL UbiquitousKeyValueStoreBool( CFStringRef key );
CFDataRef UbiquitousKeyValueStoreData( CFStringRef key );
CFDictionaryRef UbiquitousKeyValueStoreDictionary( CFStringRef key );
double UbiquitousKeyValueStoreDouble( CFStringRef key );
SInt64 UbiquitousKeyValueStoreLongLong( CFStringRef key );
CFTypeRef UbiquitousKeyValueStoreObject( CFStringRef key );
CFStringRef UbiquitousKeyValueStoreString( CFStringRef key );

// Setting values
void UbiquitousKeyValueStoreSetArray( CFStringRef key, CFArrayRef value );
void UbiquitousKeyValueStoreSetBool( CFStringRef key, BOOL value );
void UbiquitousKeyValueStoreSetData( CFStringRef key, CFDataRef value );
void UbiquitousKeyValueStoreSetDictionary( CFStringRef key, CFDictionaryRef value );
void UbiquitousKeyValueStoreSetDouble( CFStringRef key, double value );
void UbiquitousKeyValueStoreSetLongLong( CFStringRef key, SInt64 value );
void UbiquitousKeyValueStoreSetObject( CFStringRef key, CFTypeRef value );
void UbiquitousKeyValueStoreSetString( CFStringRef key, CFStringRef value );

// Synchronize
BOOL UbiquitousKeyValueStoreSynchronize( void );

// Removing keys
void UbiquitousKeyValueRemoveObjectForKey( CFStringRef key );

// Keys and values
CFDictionaryRef UbiquitousKeyValueStoreDictionaryRepresentation( void );
