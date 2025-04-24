/*
 AppleEventManager.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

// Class
Class AppleEventManagerClass( void );

// Getting event manager
NSAppleEventManager *AppleEventManagerShared( void );

// Working with event handlers
void AppleEventManagerRemoveEventHandler( NSAppleEventManager *ref, FourCharCode class, FourCharCode eventID );
void AppleEventManagerSetEventHandler( NSAppleEventManager *ref, CFTypeRef handler, SELRef selector, FourCharCode class, FourCharCode eventID );

// Working with events
OSErr AppleEventManagerDispatchRawAppleEvent( NSAppleEventManager *ref, AppleEvent *appleEvent, AppleEvent *reply, SRefCon handlerRefCon );

// Suspending and resuming events
NSAppleEventDescriptor *AppleEventManagerAppleEventForSuspensionID( NSAppleEventManager *ref, NSAppleEventManagerSuspensionID suspensionID );
NSAppleEventDescriptor *AppleEventManagerCurrentAppleEvent( NSAppleEventManager *ref );
NSAppleEventDescriptor *AppleEventManagerCurrentReplyAppleEvent( NSAppleEventManager *ref );
NSAppleEventDescriptor *AppleEventManagerReplyAppleEventForSuspensionID( NSAppleEventManager *ref, NSAppleEventManagerSuspensionID suspensionID );
void AppleEventManagerResumeWithSuspensionID( NSAppleEventManager *ref, NSAppleEventManagerSuspensionID suspensionID );
void AppleEventManagerSetCurrentAppleEventAndReplyEventWithSuspensionID( NSAppleEventManager *ref, NSAppleEventManagerSuspensionID suspensionID );
NSAppleEventManagerSuspensionID AppleEventManagerSuspendCurrentAppleEvent( NSAppleEventManager *ref );

