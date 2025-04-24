/*
 JSONSerialization.h

 Bernie Wylde
 */

#import "CocoaUI.h"

// Class
Class JSONSerializationClass( void );

// Create object
CFTypeRef JSONSerializationJSONObjectWithData( CFDataRef dta, NSJSONReadingOptions options, NSError **err );
CFTypeRef JSONSerializationJSONObjectWithStream( CFReadStreamRef stream, NSJSONReadingOptions options, NSError **err );

// Create data
CFDataRef JSONSerializationDataWithJSONObject( CFTypeRef obj, NSJSONWritingOptions options, NSError **err );
NSInteger JSONSerializationWriteJSONObjectToStream( CFTypeRef obj, CFWriteStreamRef stream, NSJSONWritingOptions options, NSError **err );
BOOL JSONSerializationIsValidJSONObject( CFTypeRef obj );

#pragma mark - Convenience function
CFStringRef JSONStringWithObject( CFTypeRef obj, NSError **err );

