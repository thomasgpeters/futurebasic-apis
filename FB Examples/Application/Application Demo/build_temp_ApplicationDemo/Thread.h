/*
 Thread.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef void (*CUI_ThreadCallbackType)(id);

@interface CUI_ThreadTarget : NSObject
@property (nonatomic,assign) CUI_ThreadCallbackType callback;
- (void)doThread:(id)object;
@end

// Class
Class ThreadClass( void );

// -- start --
void ThreadStart( NSThread *ref );

// -- stop --
void ThreadSleepUntilDate( CFDateRef date );
void ThreadSleepForTimeInterval( CFTimeInterval ti );
void ThreadExit( void );
void ThreadCancel( NSThread *ref );

// -- execution state --
BOOL ThreadIsExecuting( NSThread *ref );
BOOL ThreadIsFinished( NSThread *ref );
BOOL ThreadIsCancelled( NSThread *ref );

// Main thread
BOOL ThreadIsMainThread( NSThread *ref );
NSThread *ThreadMainThread( void );

// Query
BOOL ThreadIsMultiThreaded( void );
NSThread *ThreadCurrentThread( void );
CFArrayRef ThreadCallStackReturnAddresses( void );
CFArrayRef ThreadCallStackSymbols( void );

// -- properties --
CFMutableDictionaryRef ThreadDictionary( NSThread *ref );
CFStringRef ThreadName( NSThread *ref );
void ThreadSetName( NSThread *ref, CFStringRef name );
NSUInteger ThreadStackSize( NSThread *ref );

// -- prioritizing --
NSQualityOfService ThreadQualityOfService( NSThread *ref );
void ThreadSetQualityOfService( NSThread *ref, NSQualityOfService value );
double ThreadPriority( NSThread *ref );
void ThreadSetPriority( NSThread *ref, double priority );

// -- custom --
void ThreadDetachNewThreadWithCallback( CUI_ThreadCallbackType callback, CFTypeRef object );
void ThreadDetachNewThreadFunction( CUI_ThreadCallbackType fnAddress, CFTypeRef object );
NSThread *ThreadWithCallback( CUI_ThreadCallbackType callback, CFTypeRef object );
NSThread *ThreadWithFunction( CUI_ThreadCallbackType fnAddress, CFTypeRef object );

