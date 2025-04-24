/*
 UUID.m
 
 Bernie Wylde 20220316
 */

// Create
NSUUID *UUIDInit( void )
{ return [NSUUID UUID]; }

NSUUID *UUIDWithString( CFStringRef string )
{
#if __has_feature(objc_arc)
    return [[NSUUID alloc] initWithUUIDString:(__bridge NSString *)string];
#else
    return [[[NSUUID alloc] initWithUUIDString:(__bridge NSString *)string] autorelease];
#endif
}

// Values
CFStringRef UUIDString( NSUUID *ref )
{ return (__bridge CFStringRef)[ref UUIDString]; }

// Compare
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
NSComparisonResult UUIDCmpare( NSUUID *ref, NSUUID *otherUUID )
{ return [ref compare:otherUUID]; }
#endif// 120000
