/*
 Event.m

 Bernie Wylde
 */

#import "Event.h"

@implementation CUI_Event

#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.nsEvent release];
    [super dealloc];
}
#endif

@end

// private
CUI_Event *CUI_EventObj( void )
{
    static CUI_Event *sCUI_Event = nil;
    if ( !sCUI_Event ) sCUI_Event = [[CUI_Event alloc] init];
    //if ( !sCUI_Event.nsEvent ) sCUI_Event.nsEvent = [NSApp currentEvent];
    return sCUI_Event;
}

void CUI_EventSetEvent( NSEvent *event )
{ [CUI_EventObj() setNsEvent:event]; }


// public
// Class
//Class EventClass( void )
//{ return [NSEvent class]; }

// Create
NSEvent *EventKeyEvent( NSEventType type, CGPoint location, NSUInteger modifierFlags, CFTimeInterval timestamp, NSInteger wndNum, NSGraphicsContext *ctx, CFStringRef chars, CFStringRef unmodChars, BOOL isRepeat, UInt16 code )
{ return [NSEvent keyEventWithType:type location:NSPointFromCGPoint(location) modifierFlags:modifierFlags timestamp:timestamp windowNumber:wndNum context:ctx characters:(__bridge NSString *)chars charactersIgnoringModifiers:(__bridge NSString *)unmodChars isARepeat:isRepeat keyCode:code]; }

NSEvent *EventMouseEvent( NSEventType type, CGPoint location, NSUInteger modifierFlags, CFTimeInterval timestamp, NSInteger wndNum, NSGraphicsContext *ctx, NSInteger evNum, NSInteger clickCount, float pressure )
{ return [NSEvent mouseEventWithType:type location:NSPointFromCGPoint(location) modifierFlags:modifierFlags timestamp:timestamp windowNumber:wndNum context:ctx eventNumber:evNum clickCount:clickCount pressure:pressure]; }

NSEvent *EventEnterExitEvent( NSEventType type, CGPoint location, NSUInteger modifierFlags, CFTimeInterval timestamp, NSInteger wndNum, NSGraphicsContext *ctx, NSInteger evNum, NSInteger trackingNum, void *userData )
{ return [NSEvent enterExitEventWithType:type location:NSPointFromCGPoint(location) modifierFlags:modifierFlags timestamp:timestamp windowNumber:wndNum context:ctx eventNumber:evNum trackingNumber:trackingNum userData:userData]; }

NSEvent *EventOtherEvent( NSEventType type, CGPoint location, NSUInteger modifierFlags, CFTimeInterval timestamp, NSInteger wndNum, NSGraphicsContext *ctx, SInt16 subtype, NSInteger data1, NSInteger data2 )
{ return [NSEvent otherEventWithType:type location:NSPointFromCGPoint(location) modifierFlags:modifierFlags timestamp:timestamp windowNumber:wndNum context:ctx subtype:subtype data1:data1 data2:data2]; }

NSEvent *EventWithCGEvent( CGEventRef cgEvent )
{ return [NSEvent eventWithCGEvent:cgEvent]; }

// Type
NSEventType EventType( void )
{ return [[CUI_EventObj() nsEvent] type]; }

short EventSubtype( NSEvent *ref )
{ return [ref subtype]; }

NSUInteger EventModifierFlags( void )
{ return [[CUI_EventObj() nsEvent] modifierFlags]; }

// General information
CGPoint EventLocationInWindow( void )
{ return NSPointToCGPoint([[CUI_EventObj() nsEvent] locationInWindow]); }

CFTimeInterval EventTimestamp( void )
{ return [[CUI_EventObj() nsEvent] timestamp]; }

void *EventWindow( void )
{ return (__bridge void *)[[CUI_EventObj() nsEvent] window]; }

NSInteger EventWindowTag( void )
{
    NSWindow *wnd = [[CUI_EventObj() nsEvent] window];
    if ( wnd ) return [wnd tag];
    return 0;
}

NSInteger EventWindowNumber( NSEvent *ref )
{ return [ref windowNumber]; }

CGEventRef EventCGEvent( NSEvent *ref )
{ return [ref CGEvent]; }

// Key info
NSUInteger EventClassModifierFlags( void )
{ return [NSEvent modifierFlags]; }

CFTimeInterval EventKeyRepeatDelay( void )
{ return [NSEvent keyRepeatDelay]; }

CFTimeInterval EventKeyRepeatInterval( void )
{ return [NSEvent keyRepeatInterval]; }

CFStringRef EventCharacters( void )
{
    NSEvent *event = [CUI_EventObj() nsEvent];
    if ( event ) {
        NSEventType type = [event type];
        switch ( type ) {
            case NSEventTypeKeyDown:
            case NSEventTypeKeyUp:
            case NSEventTypeFlagsChanged:
                return (__bridge CFStringRef)[event characters];
            default:
                return nil;
        }
    }
    return nil;
}

CFStringRef EventCharactersIgnoringModifiers( void )
{ return (__bridge CFStringRef)[[CUI_EventObj() nsEvent] charactersIgnoringModifiers]; }

BOOL EventIsARepeat( void )
{
    NSEvent *event = [CUI_EventObj() nsEvent];
    NSEventType type = [event type];
    switch ( type ) {
        case NSEventTypeKeyDown:
        case NSEventTypeKeyUp:
            return [event isARepeat];
        default:
            return NO;
    }
}

unsigned short EventKeyCode( void )
{
    NSEvent *event = [CUI_EventObj() nsEvent];
    NSEventType type = [event type];
    switch ( type ) {
        case NSEventTypeKeyDown:
        case NSEventTypeKeyUp:
        case NSEventTypeFlagsChanged:
            return [event keyCode];
        default:
            return 0;
    }
}

// Mouse info
NSUInteger EventPressedMouseButtons( void )
{ return [NSEvent pressedMouseButtons]; }

CFTimeInterval EventDoubleClickInterval( void )
{ return [NSEvent doubleClickInterval]; }

CGPoint EventMouseLocation( void )
{ return NSPointToCGPoint([NSEvent mouseLocation]); }

NSInteger EventButtonNumber( NSEvent *ref )
{ return [ref buttonNumber]; }

NSInteger EventClickCount( void )
{ return [[CUI_EventObj() nsEvent] clickCount]; }

NSEventMask EventAssociatedEventsMask( NSEvent *ref )
{ return [ref associatedEventsMask]; }

// Mouse tracking info
NSInteger EventNumber( NSEvent *ref )
{ return [ref eventNumber]; }

NSInteger EventTrackingNumber( NSEvent *ref )
{ return [ref trackingNumber]; }

NSTrackingArea *EventTrackingArea( NSEvent *ref )
{ return [ref trackingArea]; }

void *EventUserData( NSEvent *ref )
{ return [ref userData]; }

// Custom event info
NSInteger EventData1( NSEvent *ref )
{ return [ref data1]; }

NSInteger EventData2( NSEvent *ref )
{ return [ref data2]; }

// Scroll wheel info
CGFloat EventDeltaX( NSEvent *ref )
{ return [ref deltaX]; }

CGFloat EventDeltaY( NSEvent *ref )
{ return [ref deltaY]; }

CGFloat EventDeltaZ( NSEvent *ref )
{ return [ref deltaZ]; }

// Pressure info
float EventPressure( NSEvent *ref )
{ return [ref pressure]; }

NSInteger EventStage( NSEvent *ref )
{ return [ref stage]; }

CGFloat EventStageTransition( NSEvent *ref )
{ return [ref stageTransition]; }

NSPressureBehavior EventPressureBehavior( NSEvent *ref )
{ return [ref pressureBehavior]; }

// Tablet proximity info
NSUInteger EventCapabilityMask( NSEvent *ref )
{ return [ref capabilityMask]; }

NSUInteger EventDeviceID( NSEvent *ref )
{ return [ref deviceID]; }

BOOL EventIsEnteringProximity( NSEvent *ref )
{ return [ref isEnteringProximity]; }

NSUInteger EventPointingDeviceID( NSEvent *ref )
{ return [ref pointingDeviceID]; }

NSUInteger EventPointingDeviceSerialNumber( NSEvent *ref )
{ return [ref pointingDeviceSerialNumber]; }

NSPointingDeviceType EventPointingDeviceType( NSEvent *ref )
{ return [ref pointingDeviceType]; }

NSUInteger EventSystemTabletID( NSEvent *ref )
{ return [ref systemTabletID]; }

NSUInteger EventTabletID( NSEvent *ref )
{ return [ref tabletID]; }

UInt64 EventUniqueID( NSEvent *ref )
{ return [ref uniqueID]; }

NSUInteger EventVendorID( NSEvent *ref )
{ return [ref vendorID]; }

NSUInteger EventVendorPointingDeviceType( NSEvent *ref )
{ return [ref vendorPointingDeviceType]; }

// Tablet pointing info
NSInteger EventAbsoluteX( NSEvent *ref )
{ return [ref absoluteX]; }

NSInteger EventAbsoluteY( NSEvent *ref )
{ return [ref absoluteY]; }

NSInteger EventAbsoluteZ( NSEvent *ref )
{ return [ref absoluteZ]; }

NSEventButtonMask EventButtonMask( NSEvent *ref )
{ return [ref buttonMask]; }

float EventRotation( NSEvent *ref )
{ return [ref rotation]; }

float EventTangentialPressure( NSEvent *ref )
{ return [ref pressure]; }

CGPoint EventTilt( NSEvent *ref )
{ return NSPointToCGPoint([ref tilt]); }

CFTypeRef EventVendorDefined( NSEvent *ref )
{ return (__bridge CFTypeRef)[ref vendorDefined]; }

// Periodic events
void EventStartPeriodicEvents( CFTimeInterval delay, CFTimeInterval period )
{ [NSEvent startPeriodicEventsAfterDelay:delay withPeriod:period]; }

void EventStopPeriodicEvents( void )
{ [NSEvent stopPeriodicEvents]; }

// Touch and gesture info
CGFloat EventMagnification( NSEvent *ref )
{ return [ref magnification]; }

CFSetRef EventTouchesMatchingPhase( NSEvent *ref, NSTouchPhase phase, NSInteger vwTag )
{
    NSView *view = CUI_ViewWithTag(vwTag);
    if ( view ) {
        return (__bridge CFSetRef)[ref touchesMatchingPhase:phase inView:view];
    }
    return nil;
}

CFSetRef EventAllTouches( NSEvent *ref )
{ return (__bridge CFSetRef)[ref allTouches]; }

CFSetRef EventTouchesForView( NSEvent *ref, NSInteger vwTag )
{
    NSView *view = CUI_ViewWithTag(vwTag);
    if ( view ) {
        return (__bridge CFSetRef)[ref touchesForView:view];
    }
    return nil;
}

CFArrayRef EventCoalescedTouchesForTouch( NSEvent *ref, NSTouch *touch )
{ return (__bridge CFArrayRef)[ref coalescedTouchesForTouch:touch]; }

BOOL EventIsMouseCoalescingEnabled( void )
{ return [NSEvent isMouseCoalescingEnabled]; }

void EventSetMouseCoalescingEnabled( BOOL flag )
{ [NSEvent setMouseCoalescingEnabled:flag]; }

// Monitoring app events
CFTypeRef EventAddGlobalMonitor( NSEventMask mask, CUI_EventAddGlobalMonitorType monitorFunction, void *userData )
{
    return (__bridge CFTypeRef)[NSEvent addGlobalMonitorForEventsMatchingMask:mask handler:^(NSEvent *event) {
        CUI_EventSetEvent( event );
        (*monitorFunction)(event,userData);
    }];
}

CFTypeRef EventAddLocalMonitor( NSEventMask mask, CUI_EventAddLocalMonitorType monitorFunction, void *userData )
{
    return (__bridge CFTypeRef)[NSEvent addLocalMonitorForEventsMatchingMask:mask handler:^NSEvent *(NSEvent *event) {
        CUI_EventSetEvent( event );
        return (*monitorFunction)(event,userData);
    }];
}

void EventRemoveMonitor( CFTypeRef eventMonitor )
{ [NSEvent removeMonitor:(__bridge id)eventMonitor]; }

// Scroll wheel and flick events
BOOL EventHasPreciseScrollingDeltas( NSEvent *ref )
{ return [ref hasPreciseScrollingDeltas]; }

CGFloat EventScrollingDeltaX( NSEvent *ref )
{ return [ref scrollingDeltaX]; }

CGFloat EventScrollingDeltaY( NSEvent *ref )
{ return [ref scrollingDeltaX]; }

NSEventPhase EventMomentumPhase( NSEvent *ref )
{ return [ref momentumPhase]; }

NSEventPhase EventPhase( NSEvent *ref )
{ return [ref phase]; }

BOOL EventIsSwipeTrackingFromScrollEventsEnabled( void )
{ return [NSEvent isSwipeTrackingFromScrollEventsEnabled]; }

void EventTrackSwipeEvent( NSEvent *ref, NSEventSwipeTrackingOptions options, CGFloat dampenThresholdMin, CGFloat dampenThresholdMax, CUI_EventTrackSwipeEventHandlerType handler, void *userData )
{
    [ref trackSwipeEventWithOptions:options dampenAmountThresholdMin:dampenThresholdMin max:dampenThresholdMax usingHandler:^(CGFloat gestureAmount, NSEventPhase phase, BOOL isComplete, BOOL *stop) {
        (*handler)(ref,gestureAmount,phase,isComplete,stop,userData);
    }];
}

BOOL EventIsDirectionInvertedFromDevice( NSEvent *ref )
{ return [ref isDirectionInvertedFromDevice]; }

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
CFStringRef EventCharactersByApplyingModifiers( NSEvent *ref, NSEventModifierFlags modifiers )
{ return (__bridge CFStringRef)[ref charactersByApplyingModifiers:modifiers]; }
#endif// 101500


#pragma mark - NSEvent * functions
// Type
NSEventType EventRefType( NSEvent *ref )
{ return [ref type]; }

NSUInteger EventRefModifierFlags( NSEvent *ref )
{ return [ref modifierFlags]; }

// General information
CGPoint EventRefLocationInWindow( NSEvent *ref )
{ return NSPointToCGPoint([ref locationInWindow]); }

CFTimeInterval EventRefTimestamp( NSEvent *ref )
{ return [ref timestamp]; }

NSWindow *EventRefWindow( NSEvent *ref )
{ return [ref window]; }

NSInteger EventRefWindowTag( NSEvent *ref )
{
    NSWindow *obj = [ref window];
    if ( obj ) return [obj tag];
    return 0;
}

// Key info
CFStringRef EventRefCharacters( NSEvent *ref )
{ return (__bridge CFStringRef)[ref characters]; }

CFStringRef EventRefCharactersIgnoringModifiers( NSEvent *ref )
{ return (__bridge CFStringRef)[ref charactersIgnoringModifiers]; }

BOOL EventRefIsARepeat( NSEvent *ref )
{
    NSEventType type = [ref type];
    switch ( type ) {
        case NSKeyDown:
        case NSKeyUp:
            return [ref isARepeat];
        default:
            return NO;
    }
}

unsigned short EventRefKeyCode( NSEvent *ref )
{
    NSEventType type = [ref type];
    switch ( type ) {
        case NSKeyDown:
        case NSKeyUp:
        case NSFlagsChanged:
            return [ref keyCode];
        default:
            return 0;
    }
}

// Mouse info
NSInteger EventRefClickCount( NSEvent *ref )
{ return [ref clickCount]; }

// Custom
CGPoint EventRefLocationInView( NSEvent *ref, NSInteger tag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) {
        return NSPointToCGPoint([view convertPoint:[ref locationInWindow] fromView:nil]);
    }
    return CGPointZero;
}


#pragma mark - Custom
CGPoint EventLocationInView( NSInteger tag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) {
        return NSPointToCGPoint([view convertPoint:[[CUI_EventObj() nsEvent] locationInWindow] fromView:nil]);
    }
    return CGPointZero;
}

