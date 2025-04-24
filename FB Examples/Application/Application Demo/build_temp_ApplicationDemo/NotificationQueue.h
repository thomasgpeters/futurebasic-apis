/*
 NotificationQueue.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class NotificationQueueClass( void );

// - create -
NSNotificationQueue *NotificationQueueWithNotificationCenter( NSNotificationCenter *ref );

// - default queue -
NSNotificationQueue *NotificationQueueDefault( void );

// - managing notifications -
void NotificationQueueEnqueueNotificationWithCoalescing( NSNotificationQueue *ref, NSNotification *note, NSPostingStyle style, NSNotificationCoalescing coalesceMask, CFArrayRef modes );
void NotificationQueueEnqueueNotification( NSNotificationQueue *ref, NSNotification *note, NSPostingStyle style );
void NotificationQueueDequeueNotification( NSNotificationQueue *ref, NSNotification *note, NSNotificationCoalescing coalesceMask );

