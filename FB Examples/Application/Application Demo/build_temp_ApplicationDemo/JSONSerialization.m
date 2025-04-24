/*
 JSONSerialization.m

 Bernie Wylde
 */

#import "JSONSerialization.h"

// Class
Class JSONSerializationClass( void )
{ return [NSJSONSerialization class]; }

// Create object
CFTypeRef JSONSerializationJSONObjectWithData( CFDataRef dta, NSJSONReadingOptions options, NSError **err )
{ return (__bridge CFTypeRef)[NSJSONSerialization JSONObjectWithData:(__bridge NSData *)dta options:options error:err]; }

CFTypeRef JSONSerializationJSONObjectWithStream( CFReadStreamRef stream, NSJSONReadingOptions options, NSError **err )
{ return (__bridge CFTypeRef)[NSJSONSerialization JSONObjectWithStream:(__bridge NSInputStream *)stream options:options error:err]; }

// Create data
CFDataRef JSONSerializationDataWithJSONObject( CFTypeRef obj, NSJSONWritingOptions options, NSError **err )
{ return (__bridge CFDataRef)[NSJSONSerialization dataWithJSONObject:(__bridge id)obj options:options error:err]; }

NSInteger JSONSerializationWriteJSONObjectToStream( CFTypeRef obj, CFWriteStreamRef stream, NSJSONWritingOptions options, NSError **err )
{ return [NSJSONSerialization writeJSONObject:(__bridge id)obj toStream:(__bridge NSOutputStream *)stream options:options error:err]; }

BOOL JSONSerializationIsValidJSONObject( CFTypeRef obj )
{ return [NSJSONSerialization isValidJSONObject:(__bridge id)obj]; }


#pragma mark - Convenience function
CFStringRef JSONStringWithObject( CFTypeRef obj, NSError **err )
{
    NSData *data = nil;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500    
    if ( @available( macOS 10.15, * ) ) {
        data = [NSJSONSerialization dataWithJSONObject:(__bridge id)obj options:NSJSONWritingFragmentsAllowed error:err];
    } else {
        //data = [NSJSONSerialization dataWithJSONObject:(__bridge id)obj options:NSJSONWritingFragmentsAllowed error:err];
    }
#else
    //data = [NSJSONSerialization dataWithJSONObject:(__bridge id)obj options:NSJSONWritingFragmentsAllowed error:err];
#endif
    if ( data ) {
#if __has_feature(objc_arc)
        return (__bridge CFStringRef)[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
#else
        return (__bridge CFStringRef)[[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
#endif
    }
    return nil;
}
