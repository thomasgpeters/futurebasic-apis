/*
 Event.h

 Bernie Wylde
 */

#import "View.h"

@interface CUI_Event : NSObject
@property (nonatomic,retain) NSEvent *nsEvent;
@end

typedef void (*CUI_EventAddGlobalMonitorType)(NSEvent*,void*);
typedef id (*CUI_EventAddLocalMonitorType)(NSEvent*,void*);
typedef id (*CUI_EventTrackSwipeEventHandlerType)(NSEvent*,CGFloat,NSEventPhase,BOOL,BOOL*,void*);

CUI_Event *CUI_EventObj( void );
void CUI_EventSetEvent( NSEvent *event );

// Class
//Class EventClass( void );

// Create
NSEvent *EventKeyEvent( NSEventType type, CGPoint location, NSUInteger modifierFlags, CFTimeInterval timestamp, NSInteger wndNum, NSGraphicsContext *ctx, CFStringRef chars, CFStringRef unmodChars, BOOL isRepeat, UInt16 code );
NSEvent *EventMouseEvent( NSEventType type, CGPoint location, NSUInteger modifierFlags, CFTimeInterval timestamp, NSInteger wndNum, NSGraphicsContext *ctx, NSInteger evNum, NSInteger clickCount, float pressure );
NSEvent *EventEnterExitEvent( NSEventType type, CGPoint location, NSUInteger modifierFlags, CFTimeInterval timestamp, NSInteger wndNum, NSGraphicsContext *ctx, NSInteger evNum, NSInteger trackingNum, void *userData );
NSEvent *EventOtherEvent( NSEventType type, CGPoint location, NSUInteger modifierFlags, CFTimeInterval timestamp, NSInteger wndNum, NSGraphicsContext *ctx, SInt16 subtype, NSInteger data1, NSInteger data2 );
NSEvent *EventOtherEvent( NSEventType type, CGPoint location, NSUInteger modifierFlags, CFTimeInterval timestamp, NSInteger wndNum, NSGraphicsContext *ctx, SInt16 subtype, NSInteger data1, NSInteger data2 );
NSEvent *EventWithCGEvent( CGEventRef cgEvent );

// Type
NSEventType EventType( void );
short EventSubtype( NSEvent *ref );

NSUInteger EventModifierFlags( void );

// General information
CGPoint EventLocationInWindow( void );
CFTimeInterval EventTimestamp( void );
void *EventWindow( void );
NSInteger EventWindowTag( void );
NSInteger EventWindowNumber( NSEvent *ref );
CGEventRef EventCGEvent( NSEvent *ref );

// Key info
NSUInteger EventClassModifierFlags( void );
CFTimeInterval EventKeyRepeatDelay( void );
CFTimeInterval EventKeyRepeatInterval( void );
CFStringRef EventCharacters( void );
CFStringRef EventCharactersIgnoringModifiers( void );
BOOL EventIsARepeat( void );
unsigned short EventKeyCode( void );

// Mouse info
NSUInteger EventPressedMouseButtons( void );
CFTimeInterval EventDoubleClickInterval( void );
CGPoint EventMouseLocation( void );
NSInteger EventButtonNumber( NSEvent *ref );
NSInteger EventClickCount( void );

NSEventMask EventAssociatedEventsMask( NSEvent *ref );

// Mouse tracking info
NSInteger EventNumber( NSEvent *ref );
NSInteger EventTrackingNumber( NSEvent *ref );
NSTrackingArea *EventTrackingArea( NSEvent *ref );
void *EventUserData( NSEvent *ref );

// Custom event info
NSInteger EventData1( NSEvent *ref );
NSInteger EventData2( NSEvent *ref );

// Scroll wheel info
CGFloat EventDeltaX( NSEvent *ref );
CGFloat EventDeltaY( NSEvent *ref );
CGFloat EventDeltaZ( NSEvent *ref );

// Pressure info
float EventPressure( NSEvent *ref );
NSInteger EventStage( NSEvent *ref );
CGFloat EventStageTransition( NSEvent *ref );
NSPressureBehavior EventPressureBehavior( NSEvent *ref );

// Tablet proximity info
NSUInteger EventCapabilityMask( NSEvent *ref );
NSUInteger EventDeviceID( NSEvent *ref );
BOOL EventIsEnteringProximity( NSEvent *ref );
NSUInteger EventPointingDeviceID( NSEvent *ref );
NSUInteger EventPointingDeviceSerialNumber( NSEvent *ref );
NSPointingDeviceType EventPointingDeviceType( NSEvent *ref );
NSUInteger EventSystemTabletID( NSEvent *ref );
NSUInteger EventTabletID( NSEvent *ref );
UInt64 EventUniqueID( NSEvent *ref );
NSUInteger EventVendorID( NSEvent *ref );
NSUInteger EventVendorPointingDeviceType( NSEvent *ref );

// Tablet pointing info
NSInteger EventAbsoluteX( NSEvent *ref );
NSInteger EventAbsoluteY( NSEvent *ref );
NSInteger EventAbsoluteZ( NSEvent *ref );
NSEventButtonMask EventButtonMask( NSEvent *ref );
float EventRotation( NSEvent *ref );
float EventTangentialPressure( NSEvent *ref );
CGPoint EventTilt( NSEvent *ref );
CFTypeRef EventVendorDefined( NSEvent *ref );

// Periodic events
void EventStartPeriodicEvents( CFTimeInterval delay, CFTimeInterval period );
void EventStopPeriodicEvents( void );

// Touch and gesture info
CGFloat EventMagnification( NSEvent *ref );
CFSetRef EventTouchesMatchingPhase( NSEvent *ref, NSTouchPhase phase, NSInteger vwTag );
CFSetRef EventAllTouches( NSEvent *ref );
CFSetRef EventTouchesForView( NSEvent *ref, NSInteger vwTag );
CFArrayRef EventCoalescedTouchesForTouch( NSEvent *ref, NSTouch *touch );
BOOL EventIsMouseCoalescingEnabled( void );
void EventSetMouseCoalescingEnabled( BOOL flag );

// Monitoring app events
CFTypeRef EventAddGlobalMonitor( NSEventMask mask, CUI_EventAddGlobalMonitorType monitorFunction, void *userData );
CFTypeRef EventAddLocalMonitor( NSEventMask mask, CUI_EventAddLocalMonitorType monitorFunction, void *userData );
void EventRemoveMonitor( CFTypeRef eventMonitor );

// Scroll wheel and flick events
BOOL EventHasPreciseScrollingDeltas( NSEvent *ref );
CGFloat EventScrollingDeltaX( NSEvent *ref );
CGFloat EventScrollingDeltaY( NSEvent *ref );
NSEventPhase EventMomentumPhase( NSEvent *ref );
NSEventPhase EventPhase( NSEvent *ref );
BOOL EventIsSwipeTrackingFromScrollEventsEnabled( void );
void EventTrackSwipeEvent( NSEvent *ref, NSEventSwipeTrackingOptions options, CGFloat dampenThresholdMin, CGFloat dampenThresholdMax, CUI_EventTrackSwipeEventHandlerType handler, void *userData );
BOOL EventIsDirectionInvertedFromDevice( NSEvent *ref );

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
CFStringRef EventCharactersByApplyingModifiers( NSEvent *ref, NSEventModifierFlags modifiers );
#endif// 101500


#pragma mark - NSEvent * functions
// Type
NSEventType EventRefType( NSEvent *ref );
NSUInteger EventRefModifierFlags( NSEvent *ref );

// General information
CGPoint EventRefLocationInWindow( NSEvent *ref );
CFTimeInterval EventRefTimestamp( NSEvent *ref );
NSWindow *EventRefWindow( NSEvent *ref );
NSInteger EventRefWindowTag( NSEvent *ref );

// Key info
CFStringRef EventRefCharacters( NSEvent *ref );
CFStringRef EventRefCharactersIgnoringModifiers( NSEvent *ref );
BOOL EventRefIsARepeat( NSEvent *ref );
unsigned short EventRefKeyCode( NSEvent *ref );

// Mouse info
NSInteger EventRefClickCount( NSEvent *ref );

// Custom
CGPoint EventRefLocationInView( NSEvent *ref, NSInteger tag );


#pragma mark - Custom
CGPoint EventLocationInView( NSInteger tag );
