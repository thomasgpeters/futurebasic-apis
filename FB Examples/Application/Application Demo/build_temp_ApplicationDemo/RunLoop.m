/*
 RunLoop.m

 Bernie Wylde
 */

#import "RunLoop.h"

// Class
Class RunLoopClass( void )
{ return [NSRunLoop class]; }

// Run loops and modes
NSRunLoop *RunLoopCurrent( void )
{ return [NSRunLoop currentRunLoop]; }

CFStringRef RunLoopCurrentMode( NSRunLoop *ref )
{ return (__bridge CFStringRef)[ref currentMode]; }

CFDateRef RunLoopLimitDateForMode( NSRunLoop *ref, CFStringRef mode )
{ return (__bridge CFDateRef)[ref limitDateForMode:(__bridge NSString *)mode]; }

NSRunLoop *RunLoopMain( void )
{ return [NSRunLoop mainRunLoop]; }

CFRunLoopRef RunLoopCFRunLoop( NSRunLoop *ref )
{ return [ref getCFRunLoop]; }

// Timers
void RunLoopAddTimer( NSRunLoop *ref, CFRunLoopTimerRef timer, CFStringRef mode )
{ [ref addTimer:(__bridge NSTimer *)timer forMode:(__bridge NSString *)mode]; }

// Ports
void RunLoopAddPort( NSRunLoop *ref, NSPort *port, CFStringRef mode )
{ [ref addPort:port forMode:(__bridge NSString *)mode]; }

void RunLoopRemovePort( NSRunLoop *ref, NSPort *port, CFStringRef mode )
{ [ref removePort:port forMode:(__bridge NSString *)mode]; }

// Running a loop
void RunLoopRun( NSRunLoop *ref )
{ [ref run]; }

BOOL RunLoopRunModeBeforeDate( NSRunLoop *ref, CFStringRef mode, CFDateRef dt )
{ return [ref runMode:(__bridge NSString *)mode beforeDate:(__bridge NSDate *)dt]; }

void RunLoopRunUntilDate( NSRunLoop *ref, CFDateRef dt )
{ [ref runUntilDate:(__bridge NSDate *)dt]; }

void RunLoopAcceptInputForModeBeforeDate( NSRunLoop *ref, CFStringRef mode, CFDateRef dt )
{ [ref acceptInputForMode:(__bridge NSString *)mode beforeDate:(__bridge NSDate *)dt]; }

