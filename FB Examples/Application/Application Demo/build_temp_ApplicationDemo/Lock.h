/*
 Lock.h

 Bernie Wylde
 */

#import "CocoaUI.h"

// Init
NSLock *LockInit( void );

// Acquire
BOOL LockBeforeDate( NSLock *ref, CFDateRef limit );
BOOL LockTry( NSLock *ref );

// Name
CFStringRef LockName( NSLock *ref );
void LockSetName( NSLock *ref, CFStringRef name );


#pragma mark - Locking
void LockingLock( id<NSLocking> ref );
void LockingUnlock( id<NSLocking> ref );


#pragma mark - ConditionLock
// Init
NSConditionLock *ConditionLockWithCondition( NSInteger condition );

// Condition
NSInteger ConditionLockCondition( NSConditionLock *ref );

// Acquire and release
BOOL ConditionLockLockBeforeDate( NSConditionLock *ref, CFDateRef limit );
void ConditionLockLockWhenCondition( NSConditionLock *ref, NSInteger condition );
BOOL ConditionLockLockWhenConditionBeforeDate( NSConditionLock *ref, NSInteger condition, CFDateRef limit );
BOOL ConditionLockTryLock( NSConditionLock *ref );
BOOL ConditionLockTryLockWhenCondition( NSConditionLock *ref, NSInteger condition );
void ConditionLockUnlockWithCondition( NSConditionLock *ref, NSInteger condition );

// Identify
CFStringRef ConditionLockName( NSConditionLock *ref );
void ConditionLockSetName( NSConditionLock *ref, CFStringRef name );


#pragma mark - RecursiveLock
// Init
NSRecursiveLock *RecursiveLockInit( void );

// Acquire
BOOL RecursiveLockLockBeforeDate( NSRecursiveLock *ref, CFDateRef limit );
BOOL RecursiveLockTryLock( NSRecursiveLock *ref );

// Naming
CFStringRef RecursiveLockName( NSRecursiveLock *ref );
void RecursiveLockSetName( NSRecursiveLock *ref, CFStringRef name );


#pragma mark - Condition
// Init
NSCondition *ConditionInit( void );

// Waiting
void ConditionWait( NSCondition *ref );
BOOL ConditionWaitUntilDate( NSCondition *ref, CFDateRef limit );

// Signal waiting threads
void ConditionSignal( NSCondition *ref );
void ConditionBroadcast( NSCondition *ref );

// Identify
CFStringRef ConditionName( NSCondition *ref );
void ConditionSetName( NSCondition *ref, CFStringRef name );
