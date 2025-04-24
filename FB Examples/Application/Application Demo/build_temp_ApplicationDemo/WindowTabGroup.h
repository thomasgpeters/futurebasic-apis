/*
 WindowTabGroup.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "Window.h"


// Class
Class WindowTabGroupClass( void );

CFStringRef WindowTabGroupIdentifier( NSWindowTabGroup *ref );
BOOL WindowTabGroupIsOverviewVisible( NSWindowTabGroup *ref );
void WindowTabGroupSetOverviewVisible( NSWindowTabGroup *ref, BOOL flag );
BOOL WindowTabGroupIsTabBarVisible( NSWindowTabGroup *ref );
NSInteger WindowTabGroupSelectedWindow( NSWindowTabGroup *ref );
void WindowTabGroupSetSelectedWindow( NSWindowTabGroup *ref, NSInteger tag );
CFArrayRef WindowTabGroupWindows( NSWindowTabGroup *ref );
void WindowTabGroupAddWindow( NSWindowTabGroup *ref, NSInteger tag );
void WindowTabGroupInsertWindow( NSWindowTabGroup *ref, NSInteger tag, NSInteger index );
void WindowTabGroupRemoveWindow( NSWindowTabGroup *ref, NSInteger tag );

