/*
 DistributedLock.h

 Bernie Wylde
 */

#import "CocoaUI.h"

// Create
NSDistributedLock *DistributedLockWithPath( CFStringRef path );

// Acquire
BOOL DistributedLockTry( NSDistributedLock *ref );

// Relinquish
void DistributedLockBreak( NSDistributedLock *ref );
void DistributedLockUnlock( NSDistributedLock *ref );

// Info
CFDateRef DistributedLockDate( NSDistributedLock *ref );
