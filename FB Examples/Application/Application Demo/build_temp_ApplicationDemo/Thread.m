/*
 Thread.m

 Bernie Wylde
 */

#import "Thread.h"

@implementation CUI_ThreadTarget

- (void)doThread:(id)object {
    if ( self.callback ) (*self.callback)(object);
}
@end

// Class
Class ThreadClass( void )
{ return [NSThread class]; }

// -- start --
void ThreadStart( NSThread *ref )
{ [ref start]; }

// -- stop --
void ThreadSleepUntilDate( CFDateRef date )
{ [NSThread sleepUntilDate:(__bridge NSDate *)date]; }

void ThreadSleepForTimeInterval( CFTimeInterval ti )
{ [NSThread sleepForTimeInterval:ti]; }

void ThreadExit( void )
{ [NSThread exit]; }

void ThreadCancel( NSThread *ref )
{ [ref cancel]; }

// -- execution state --
BOOL ThreadIsExecuting( NSThread *ref )
{ return [ref isExecuting]; }

BOOL ThreadIsFinished( NSThread *ref )
{ return [ref isFinished]; }

BOOL ThreadIsCancelled( NSThread *ref )
{ return [ref isCancelled]; }

// Main thread
BOOL ThreadIsMainThread( NSThread *ref )
{
    if ( !ref ) return [NSThread isMainThread];
    return [ref isMainThread];
}

NSThread *ThreadMainThread( void )
{ return [NSThread mainThread]; }

// Query
BOOL ThreadIsMultiThreaded( void )
{ return [NSThread isMultiThreaded]; }

NSThread *ThreadCurrentThread( void )
{ return [NSThread currentThread]; }

CFArrayRef ThreadCallStackReturnAddresses( void )
{ return (__bridge CFArrayRef)[NSThread callStackReturnAddresses]; }

CFArrayRef ThreadCallStackSymbols( void )
{ return (__bridge CFArrayRef)[NSThread callStackSymbols]; }

// -- properties --
CFMutableDictionaryRef ThreadDictionary( NSThread *ref )
{ return (__bridge CFMutableDictionaryRef)[ref threadDictionary]; }

CFStringRef ThreadName( NSThread *ref )
{ return (__bridge CFStringRef)[ref name]; }

void ThreadSetName( NSThread *ref, CFStringRef name )
{ [ref setName:(__bridge NSString *)name]; }

NSUInteger ThreadStackSize( NSThread *ref )
{ return [ref stackSize]; }

// -- prioritizing --
NSQualityOfService ThreadQualityOfService( NSThread *ref )
{ return [ref qualityOfService]; }

void ThreadSetQualityOfService( NSThread *ref, NSQualityOfService value )
{ [ref setQualityOfService:value]; }

double ThreadPriority( NSThread *ref )
{
    if ( !ref ) return [NSThread threadPriority];
    return [ref threadPriority];
}

void ThreadSetPriority( NSThread *ref, double priority )
{
    if ( !ref ) {
        [NSThread setThreadPriority:priority];
    } else {
        [ref setThreadPriority:priority];
    }
}

// -- custom --
void ThreadDetachNewThreadWithCallback( CUI_ThreadCallbackType callback, CFTypeRef object )
{
#if __has_feature(objc_arc)
    CUI_ThreadTarget *target = [[CUI_ThreadTarget alloc] init];
#else
    CUI_ThreadTarget *target = [[[CUI_ThreadTarget alloc] init] autorelease];
#endif
    [target setCallback:callback];
    [NSThread detachNewThreadSelector:@selector(doThread:) toTarget:target withObject:(__bridge id)object];
}

void ThreadDetachNewThreadFunction( CUI_ThreadCallbackType fnAddress, CFTypeRef object )
{
#if __has_feature(objc_arc)
    CUI_ThreadTarget *target = [[CUI_ThreadTarget alloc] init];
#else
    CUI_ThreadTarget *target = [[[CUI_ThreadTarget alloc] init] autorelease];
#endif
    [target setCallback:fnAddress];
    [NSThread detachNewThreadSelector:@selector(doThread:) toTarget:target withObject:(__bridge id)object];
}

NSThread *ThreadWithCallback( CUI_ThreadCallbackType callback, CFTypeRef object )
{
#if __has_feature(objc_arc)
    CUI_ThreadTarget *target = [[CUI_ThreadTarget alloc] init];
    [target setCallback:callback];
    NSThread *ref = [[NSThread alloc] initWithTarget:target selector:@selector(doThread:) object:(__bridge id)object];
#else
    CUI_ThreadTarget *target = [[[CUI_ThreadTarget alloc] init] autorelease];
    [target setCallback:callback];
    NSThread *ref = [[[NSThread alloc] initWithTarget:target selector:@selector(doThread:) object:(__bridge id)object] autorelease];
#endif
    return ref;
}

NSThread *ThreadWithFunction( CUI_ThreadCallbackType fnAddress, CFTypeRef object )
{
#if __has_feature(objc_arc)
    CUI_ThreadTarget *target = [[CUI_ThreadTarget alloc] init];
    [target setCallback:fnAddress];
    NSThread *ref = [[NSThread alloc] initWithTarget:target selector:@selector(doThread:) object:(__bridge id)object];
#else
    CUI_ThreadTarget *target = [[[CUI_ThreadTarget alloc] init] autorelease];
    [target setCallback:fnAddress];
    NSThread *ref = [[[NSThread alloc] initWithTarget:target selector:@selector(doThread:) object:(__bridge id)object] autorelease];
#endif
    return ref;
}

