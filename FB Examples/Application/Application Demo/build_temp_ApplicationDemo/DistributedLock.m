/*
 DistributedLock.m

 Bernie Wylde
 */

#import "DistributedLock.h"

// Create
NSDistributedLock *DistributedLockWithPath( CFStringRef path )
{ return [NSDistributedLock lockWithPath:(__bridge NSString *)path]; }

// Acquire
BOOL DistributedLockTry( NSDistributedLock *ref )
{ return [ref tryLock]; }

// Relinquish
void DistributedLockBreak( NSDistributedLock *ref )
{ [ref breakLock]; }

void DistributedLockUnlock( NSDistributedLock *ref )
{ [ref unlock]; }

// Info
CFDateRef DistributedLockDate( NSDistributedLock *ref )
{ return (__bridge CFDateRef)[ref lockDate]; }

