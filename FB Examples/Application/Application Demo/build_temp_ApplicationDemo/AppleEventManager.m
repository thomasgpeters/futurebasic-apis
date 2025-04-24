/*
 AppleEventManager.M
 
 Bernie Wylde
 */

#import "AppleEventManager.h"

// Class
Class AppleEventManagerClass( void )
{ return [NSAppleEventManager class]; }

// Getting event manager
NSAppleEventManager *AppleEventManagerShared( void )
{ return [NSAppleEventManager sharedAppleEventManager]; }

// Working with event handlers
void AppleEventManagerRemoveEventHandler( NSAppleEventManager *ref, FourCharCode class, FourCharCode eventID )
{ [ref removeEventHandlerForEventClass:class andEventID:eventID]; }

void AppleEventManagerSetEventHandler( NSAppleEventManager *ref, CFTypeRef handler, SELRef selector, FourCharCode class, FourCharCode eventID )
{ [ref setEventHandler:(__bridge id)handler andSelector:selector forEventClass:class andEventID:eventID]; }

// Working with events
OSErr AppleEventManagerDispatchRawAppleEvent( NSAppleEventManager *ref, AppleEvent *appleEvent, AppleEvent *reply, SRefCon handlerRefCon )
{ return [ref dispatchRawAppleEvent:appleEvent withRawReply:reply handlerRefCon:handlerRefCon]; }

// Suspending and resuming events
NSAppleEventDescriptor *AppleEventManagerAppleEventForSuspensionID( NSAppleEventManager *ref, NSAppleEventManagerSuspensionID suspensionID )
{ return [ref appleEventForSuspensionID:suspensionID]; }

NSAppleEventDescriptor *AppleEventManagerCurrentAppleEvent( NSAppleEventManager *ref )
{ return [ref currentAppleEvent]; }

NSAppleEventDescriptor *AppleEventManagerCurrentReplyAppleEvent( NSAppleEventManager *ref )
{ return [ref currentReplyAppleEvent]; }

NSAppleEventDescriptor *AppleEventManagerReplyAppleEventForSuspensionID( NSAppleEventManager *ref, NSAppleEventManagerSuspensionID suspensionID )
{ return [ref replyAppleEventForSuspensionID:suspensionID]; }

void AppleEventManagerResumeWithSuspensionID( NSAppleEventManager *ref, NSAppleEventManagerSuspensionID suspensionID )
{ [ref resumeWithSuspensionID:suspensionID]; }

void AppleEventManagerSetCurrentAppleEventAndReplyEventWithSuspensionID( NSAppleEventManager *ref, NSAppleEventManagerSuspensionID suspensionID )
{ [ref setCurrentAppleEventAndReplyEventWithSuspensionID:suspensionID]; }

NSAppleEventManagerSuspensionID AppleEventManagerSuspendCurrentAppleEvent( NSAppleEventManager *ref )
{ return [ref suspendCurrentAppleEvent]; }

