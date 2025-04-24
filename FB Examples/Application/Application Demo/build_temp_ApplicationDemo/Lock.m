/*
 Lock.m

 Bernie Wylde
 */

#import "Lock.h"

// Init
NSLock *LockInit( void )
{
#if __has_feature(objc_arc)
    return [[NSLock alloc] init];
#else
    return [[[NSLock alloc] init] autorelease];
#endif
}

// Acquire
BOOL LockBeforeDate( NSLock *ref, CFDateRef limit )
{ return [ref lockBeforeDate:(__bridge NSDate *)limit]; }

BOOL LockTry( NSLock *ref )
{ return [ref tryLock]; }

// Name
CFStringRef LockName( NSLock *ref )
{ return (__bridge CFStringRef)[ref name]; }

void LockSetName( NSLock *ref, CFStringRef name )
{ [ref setName:(__bridge NSString *)name]; }


#pragma mark - Locking
void LockingLock( id<NSLocking> ref )
{ [ref lock]; }

void LockingUnlock( id<NSLocking> ref )
{ [ref unlock]; }


#pragma mark - ConditionLock
// Init
NSConditionLock *ConditionLockWithCondition( NSInteger condition )
{
#if __has_feature(objc_arc)
    return [[NSConditionLock alloc] initWithCondition:condition];
#else
    return [[[NSConditionLock alloc] initWithCondition:condition] autorelease];
#endif
}

// Condition
NSInteger ConditionLockCondition( NSConditionLock *ref )
{ return [ref condition]; }

// Acquire and release
BOOL ConditionLockLockBeforeDate( NSConditionLock *ref, CFDateRef limit )
{ return [ref lockBeforeDate:(__bridge NSDate *)limit]; }

void ConditionLockLockWhenCondition( NSConditionLock *ref, NSInteger condition )
{ [ref lockWhenCondition:condition]; }

BOOL ConditionLockLockWhenConditionBeforeDate( NSConditionLock *ref, NSInteger condition, CFDateRef limit )
{ return [ref lockWhenCondition:condition beforeDate:(__bridge NSDate *)limit]; }

BOOL ConditionLockTryLock( NSConditionLock *ref )
{ return [ref tryLock]; }

BOOL ConditionLockTryLockWhenCondition( NSConditionLock *ref, NSInteger condition )
{ return [ref tryLockWhenCondition:condition]; }

void ConditionLockUnlockWithCondition( NSConditionLock *ref, NSInteger condition )
{ [ref unlockWithCondition:condition]; }

// Identify
CFStringRef ConditionLockName( NSConditionLock *ref )
{ return (__bridge CFStringRef)[ref name]; }

void ConditionLockSetName( NSConditionLock *ref, CFStringRef name )
{ [ref setName:(__bridge NSString *)name]; }


#pragma mark - RecursiveLock
// Init
NSRecursiveLock *RecursiveLockInit( void )
{
#if __has_feature(objc_arc)
    return [[NSRecursiveLock alloc] init];
#else
    return [[[NSRecursiveLock alloc] init] autorelease];
#endif
}

// Acquire
BOOL RecursiveLockLockBeforeDate( NSRecursiveLock *ref, CFDateRef limit )
{ return [ref lockBeforeDate:(__bridge NSDate *)limit]; }

BOOL RecursiveLockTryLock( NSRecursiveLock *ref )
{ return [ref tryLock]; }

// Naming
CFStringRef RecursiveLockName( NSRecursiveLock *ref )
{ return (__bridge CFStringRef)[ref name]; }

void RecursiveLockSetName( NSRecursiveLock *ref, CFStringRef name )
{ [ref setName:(__bridge NSString *)name]; }


#pragma mark - Condition
// Init
NSCondition *ConditionInit( void )
{
#if __has_feature(objc_arc)
    return [[NSCondition alloc] init];
#else
    return [[[NSCondition alloc] init] autorelease];
#endif
}

// Waiting
void ConditionWait( NSCondition *ref )
{ [ref wait]; }

BOOL ConditionWaitUntilDate( NSCondition *ref, CFDateRef limit )
{ return [ref waitUntilDate:(__bridge NSDate *)limit]; }

// Signal waiting threads
void ConditionSignal( NSCondition *ref )
{ [ref signal]; }

void ConditionBroadcast( NSCondition *ref )
{ [ref broadcast]; }

// Identify
CFStringRef ConditionName( NSCondition *ref )
{ return (__bridge CFStringRef)[ref name]; }

void ConditionSetName( NSCondition *ref, CFStringRef name )
{ [ref setName:(__bridge NSString *)name]; }

