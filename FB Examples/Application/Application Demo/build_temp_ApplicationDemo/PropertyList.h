/*
 PropertyList.h

 Bernie Wylde
 */


#import "CocoaUI.h"

/*
 PropertyListSerialization
 */

// Class
Class PropertyListSerializationClass( void );

// - serializing -
CFDataRef PropertyListSerializationDataWithPropertyList( CFTypeRef plistObj, NSPropertyListFormat format, NSError **err );
//NSInteger PropertyListSerializationWritePropertyList( CFTypeRef plistObj, NSOutputStream *stream, NSPropertyListFormat format, NSError **err );

// - deserializing -
CFTypeRef PropertyListSerializationPropertyListWithData( CFDataRef dta, NSPropertyListReadOptions options, NSPropertyListFormat *format, NSError **err );
//CFTypeRef PropertyListSerializationPropertyListWithStream( NSInputStream *stream, NSPropertyListReadOptions options, NSPropertyListFormat *format, NSError **err );

// - validating -
BOOL PropertyListSerializationPropertyListIsValidForFormat( CFTypeRef plistObj, NSPropertyListFormat format );
