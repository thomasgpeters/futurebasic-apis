/*
 TitlebarAccessoryViewController.h

 Bernie Wylde
 */


#import "CocoaUI.h"


// Class
Class TitlebarAccessoryViewControllerClass( void );

// Configure
CGFloat TitlebarAccessoryViewControllerFullScreenMinHeight( NSTitlebarAccessoryViewController *ref );
void TitlebarAccessoryViewControllerSetFullScreenMinHeight( NSTitlebarAccessoryViewController *ref, CGFloat minHeight );
NSLayoutAttribute TitlebarAccessoryViewControllerLayoutAttribute( NSTitlebarAccessoryViewController *ref );
void TitlebarAccessoryViewControllerSetLayoutAttribute( NSTitlebarAccessoryViewController *ref, NSLayoutAttribute attribute );

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
BOOL TitlebarAccessoryViewControllerAutomaticallyAdjustsSize( NSTitlebarAccessoryViewController *ref );
API_AVAILABLE(macos(11.0))
void TitlebarAccessoryViewControllerSetAutomaticallyAdjustsSize( NSTitlebarAccessoryViewController *ref, BOOL flag );
#endif// 110000

BOOL TitlebarAccessoryViewControllerIsHidden( NSTitlebarAccessoryViewController *ref );
void TitlebarAccessoryViewControllerSeHidden( NSTitlebarAccessoryViewController *ref, BOOL flag );

