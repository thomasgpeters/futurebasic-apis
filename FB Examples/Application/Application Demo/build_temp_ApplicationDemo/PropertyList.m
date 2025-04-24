/*
 PropertyList.m

 Bernie Wylde
 */

#import "PropertyList.h"

// Class
Class PropertyListSerializationClass( void )
{ return [NSPropertyListSerialization class]; }

// - serializing -
CFDataRef PropertyListSerializationDataWithPropertyList( CFTypeRef plistObj, NSPropertyListFormat format, NSError **err )
{ return (__bridge CFDataRef)[NSPropertyListSerialization dataWithPropertyList:(__bridge id)plistObj format:format options:0 error:err]; }

//NSInteger PropertyListSerializationWritePropertyList( CFTypeRef plistObj, NSOutputStream *stream, NSPropertyListFormat format, NSError **err )
//{ return [NSPropertyListSerialization writePropertyList:(__bridge id)plistObj toStream:stream format:format options:0 error:err]; }

// - deserializing -
CFTypeRef PropertyListSerializationPropertyListWithData( CFDataRef dta, NSPropertyListReadOptions options, NSPropertyListFormat *format, NSError **err )
{ return (__bridge CFTypeRef)[NSPropertyListSerialization propertyListWithData:(__bridge NSData *)dta options:options format:format error:err]; }

//CFTypeRef PropertyListSerializationPropertyListWithStream( NSInputStream *stream, NSPropertyListMutabilityOptions options, NSPropertyListFormat format, NSError **err )
//{ return (__bridge CFTypeRef)[NSPropertyListSerialization propertyListWithStream:stream options:options format:format error:err]; }

// - validating -
BOOL PropertyListSerializationPropertyListIsValidForFormat( CFTypeRef plistObj, NSPropertyListFormat format )
{ return [NSPropertyListSerialization propertyList:(__bridge id)plistObj isValidForFormat:format]; }

