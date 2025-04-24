/*
 Switch.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "View.h"
//#import "Window.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500

API_AVAILABLE(macos(10.15))
@interface SwitchSC : NSSwitch
@end

API_AVAILABLE(macos(10.15))
@interface CUI_SwitchTarget : NSObject
@end

// Class
API_AVAILABLE(macos(10.15))
Class SwitchClass( void );

API_AVAILABLE(macos(10.15))
NSSwitch *SwitchWithTag( NSInteger tag );
API_AVAILABLE(macos(10.15))
BOOL SwitchExists( NSInteger tag );

// State
API_AVAILABLE(macos(10.15))
NSControlStateValue SwitchState( NSInteger tag );
API_AVAILABLE(macos(10.15))
void SwitchSetState( NSInteger tag, NSControlStateValue state );

// Init
API_AVAILABLE(macos(10.15))
NSSwitch *SwitchInit( NSInteger inTag, CGRect inRect );

// Statement
API_AVAILABLE(macos(10.15))
void CUI_Switch( NSInteger inTag, NSInteger inEnabled, NSControlStateValue inState, CGRect inRect, NSInteger inWndTag );

#endif  // 101500
