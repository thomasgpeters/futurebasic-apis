/*
 NotificationQueue.m

 Bernie Wylde
 */

#import "NotificationQueue.h"

// Class
Class NotificationQueueClass( void )
{ return [NSNotificationQueue class]; }

// - create -
NSNotificationQueue *NotificationQueueWithNotificationCenter( NSNotificationCenter *ref )
{
#if __has_feature(objc_arc)
    return [[NSNotificationQueue alloc] initWithNotificationCenter:ref];
#else
    return [[[NSNotificationQueue alloc] initWithNotificationCenter:ref] autorelease];
#endif
}

// - default queue -
NSNotificationQueue *NotificationQueueDefault( void )
{ return [NSNotificationQueue defaultQueue]; }

// - managing notifications -
void NotificationQueueEnqueueNotificationWithCoalescing( NSNotificationQueue *ref, NSNotification *note, NSPostingStyle style, NSNotificationCoalescing coalesceMask, CFArrayRef modes )
{ [ref enqueueNotification:note postingStyle:style coalesceMask:coalesceMask forModes:(__bridge NSArray *)modes]; }

void NotificationQueueEnqueueNotification( NSNotificationQueue *ref, NSNotification *note, NSPostingStyle style )
{ [ref enqueueNotification:note postingStyle:style]; }

void NotificationQueueDequeueNotification( NSNotificationQueue *ref, NSNotification *note, NSNotificationCoalescing coalesceMask )
{ [ref dequeueNotificationsMatching:note coalesceMask:coalesceMask]; }

