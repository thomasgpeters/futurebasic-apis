/*
 Port.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class PortClass( void );

// Create
NSPort *PortInit( void );

// Validate
void PortInvalidate( NSPort *ref );
BOOL PortIsValid( NSPort *ref );

// Info
BOOL PortSendBeforeDate( NSPort *ref, CFDateRef dt, CFMutableArrayRef components, NSPort *fromPort, NSUInteger reserved );
BOOL PortSendBeforeDateMsgID( NSPort *ref, CFDateRef dt, NSUInteger msgID, CFMutableArrayRef components, NSPort *fromPort, NSUInteger reserved );
NSUInteger PortReservedSpaceLength( NSPort *ref );

// Monitoring
void PortRemoveFromRunLoop( NSPort *ref, NSRunLoop *runLoop, CFStringRef mode );
void PortScheduleInRunLoop( NSPort *ref, NSRunLoop *runLoop, CFStringRef mode );
