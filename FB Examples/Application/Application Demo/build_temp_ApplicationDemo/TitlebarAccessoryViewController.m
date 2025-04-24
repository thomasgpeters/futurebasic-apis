/*
 Touch.m

 Bernie Wylde
 */

#import "TitlebarAccessoryViewController.h"


// Class
Class TitlebarAccessoryViewControllerClass( void )
{ return [NSTitlebarAccessoryViewController class]; }

// Configure
CGFloat TitlebarAccessoryViewControllerFullScreenMinHeight( NSTitlebarAccessoryViewController *ref )
{ return [ref fullScreenMinHeight]; }

void TitlebarAccessoryViewControllerSetFullScreenMinHeight( NSTitlebarAccessoryViewController *ref, CGFloat minHeight )
{ [ref setFullScreenMinHeight:minHeight]; }

NSLayoutAttribute TitlebarAccessoryViewControllerLayoutAttribute( NSTitlebarAccessoryViewController *ref )
{ return [ref layoutAttribute]; }

void TitlebarAccessoryViewControllerSetLayoutAttribute( NSTitlebarAccessoryViewController *ref, NSLayoutAttribute attribute )
{ [ref setLayoutAttribute:attribute]; }

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
BOOL TitlebarAccessoryViewControllerAutomaticallyAdjustsSize( NSTitlebarAccessoryViewController *ref )
{ return [ref automaticallyAdjustsSize]; }

void TitlebarAccessoryViewControllerSetAutomaticallyAdjustsSize( NSTitlebarAccessoryViewController *ref, BOOL flag )
{ [ref setAutomaticallyAdjustsSize:flag]; }
#endif// 110000

BOOL TitlebarAccessoryViewControllerIsHidden( NSTitlebarAccessoryViewController *ref )
{ return [ref isHidden]; }

void TitlebarAccessoryViewControllerSeHidden( NSTitlebarAccessoryViewController *ref, BOOL flag )
{ [ref setHidden:flag]; }

