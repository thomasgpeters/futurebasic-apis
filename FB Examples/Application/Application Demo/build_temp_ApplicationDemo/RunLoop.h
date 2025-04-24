/*
 RunLoop.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class RunLoopClass( void );

// Run loops and modes
NSRunLoop *RunLoopCurrent( void );
CFStringRef RunLoopCurrentMode( NSRunLoop *ref );
CFDateRef RunLoopLimitDateForMode( NSRunLoop *ref, CFStringRef mode );
NSRunLoop *RunLoopMain( void );
CFRunLoopRef RunLoopCFRunLoop( NSRunLoop *ref );

// Timers
void RunLoopAddTimer( NSRunLoop *ref, CFRunLoopTimerRef timer, CFStringRef mode );

// Ports
void RunLoopAddPort( NSRunLoop *ref, NSPort *port, CFStringRef mode );
void RunLoopRemovePort( NSRunLoop *ref, NSPort *port, CFStringRef mode );

// Running a loop
void RunLoopRun( NSRunLoop *ref );
BOOL RunLoopRunModeBeforeDate( NSRunLoop *ref, CFStringRef mode, CFDateRef dt );
void RunLoopRunUntilDate( NSRunLoop *ref, CFDateRef dt );
void RunLoopAcceptInputForModeBeforeDate( NSRunLoop *ref, CFStringRef mode, CFDateRef dt );
