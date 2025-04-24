/*
 UUID.h
 
 Bernie Wylde 20220316
 */

#import "CocoaUI.h"

// Create
NSUUID *UUIDInit( void );
NSUUID *UUIDWithString( CFStringRef string );

// Values
CFStringRef UUIDString( NSUUID *ref );

// Compare
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
NSComparisonResult UUIDCmpare( NSUUID *ref, NSUUID *otherUUID );
#endif// 120000

