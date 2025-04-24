/*
 Port.m

 Bernie Wylde
 */

#import "Port.h"

// Class
Class PortClass( void )
{ return [NSPort class]; }

// Create
NSPort *PortInit( void )
{ return [NSPort port]; }

// Validate
void PortInvalidate( NSPort *ref )
{ [ref invalidate]; }

BOOL PortIsValid( NSPort *ref )
{ return [ref isValid]; }

// Info
BOOL PortSendBeforeDate( NSPort *ref, CFDateRef dt, CFMutableArrayRef components, NSPort *fromPort, NSUInteger reserved )
{ return [ref sendBeforeDate:(__bridge NSDate *)dt components:(__bridge NSMutableArray *)components from:fromPort reserved:reserved]; }

BOOL PortSendBeforeDateMsgID( NSPort *ref, CFDateRef dt, NSUInteger msgID, CFMutableArrayRef components, NSPort *fromPort, NSUInteger reserved )
{ return [ref sendBeforeDate:(__bridge NSDate *)dt msgid:msgID components:(__bridge NSMutableArray *)components from:fromPort reserved:reserved]; }

NSUInteger PortReservedSpaceLength( NSPort *ref )
{ return [ref reservedSpaceLength]; }

// Monitoring
void PortRemoveFromRunLoop( NSPort *ref, NSRunLoop *runLoop, CFStringRef mode )
{ [ref removeFromRunLoop:runLoop forMode:(__bridge NSString *)mode]; }

void PortScheduleInRunLoop( NSPort *ref, NSRunLoop *runLoop, CFStringRef mode )
{ [ref scheduleInRunLoop:runLoop forMode:(__bridge NSString *)mode]; }

