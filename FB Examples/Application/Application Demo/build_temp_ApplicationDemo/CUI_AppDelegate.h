/*
 CUI_AppDelegate.h
 
 Bernie Wylde
 */

@class FBInkeyWindow;
@class FBInputWindow;

#import "BreakpointWindowController.h"

// application events
enum {
    appWillFinishLaunching = 1,
    appDidFinishLaunching,
    appShouldTerminate,
    appShouldTerminateAfterLastWindowClosed,
    appWillTerminate,
    appWillBecomeActive,
    appDidBecomeActive,
    appWillResignActive,
    appDidResignActive,
    appWillHide,
    appDidHide,
    appWillUnhide,
    appDidUnhide,
    appWillUpdate,
    appDidUpdate,
    appShouldHandleReopen,
    appDockMenu,
    appWillPresentError,
    appDidChangeScreenParameters,
    //    appOpenFile,
    appOpenFileWithoutUI,
    appOpenTempFile,
    //    appOpenFiles,
    appOpenUntitledFile,
    appShouldOpenUntitledFile,
    appPrintFile,
    appPrintFiles,
    appDidRegisterForRemoteNotificationsWithDeviceToken,
    appDidFailToRegisterForRemoteNotifications,
    appDidReceiveRemoteNotification,
    appDidDecodeRestorableState,
    appWillEncodeRestorableState,
    appWillContinueUserActivityWithType,
    appContinueUserActivity,
    appDidFailToContinueUserActivityWithType,
    appDidUpdateUserActivity,
    appDidChangeOcclusionState,
    appOpenURLs
};

typedef void (*CUI_AppDelegateCallbackType)(NSInteger,void*);// event,userData
typedef BOOL (*CUI_AppTimerCallbackType)(NSTimer*);

@interface CUI_AppDelegate : NSObject <NSApplicationDelegate>
@property (nonatomic,assign) CUI_AppDelegateCallbackType delegateCallback;
@property (nonatomic,assign) void *delegateUserData;

@property (nonatomic,retain) NSWindow *offscreenWindow;
@property (nonatomic,retain) NSMutableArray *windows;

@property (nonatomic,assign) BOOL boolVal;
@property (nonatomic,assign) long longVal;

@property (nonatomic,retain) NSString *stringVal;
@property (nonatomic,retain) NSArray *arrayVal;
@property (nonatomic,retain) NSDictionary *dictVal;
@property (nonatomic,retain) NSURL *urlVal;
@property (nonatomic,retain) NSMenu *menuObj;

@property (nonatomic,strong) FBInkeyWindow *inkeyWnd;
@property (nonatomic,strong) NSString *inkeyResponseString;

@property (nonatomic,strong) FBInputWindow *inputWnd;
@property (nonatomic,strong) NSString *inputResponseString;

@property (nonatomic,strong) BreakpointWindowController *breakpointController;

@end

extern CFRunLoopTimerRef cui_tempTimer;// temporary storage of fire date timer with timerbegin block   // 20220601
//extern CFRunLoopMode cui_tempRunLoopMode;

typedef void (*CUI_OnAppEventFunctionType)(NSInteger,CFTypeRef);
static CUI_OnAppEventFunctionType sCUI_OnAppEventFunction;

void CUI_BuildMinimalMenu( void );
void CUI_AppRun( void );

CUI_OnAppEventFunctionType CUI_OnAppEventFunction( void );
void CUI_SetOnAppEventFunction( CUI_OnAppEventFunctionType onAppEventFn );
void CallUserDefinedOnAppEventFunction( long event, CFTypeRef object );

// events
void AppEventSetBool( BOOL value );
void AppEventSetLong( long value );
CFStringRef AppEventString( void );
CFArrayRef AppEventArray( void );
CFDictionaryRef AppEventDictionary( void );
CFURLRef AppEventURL( void );
void AppEventSetMenu( NSMenu *obj );

CUI_AppDelegate *CUI_AppDelegateObj( void );

NSWindow *CUI_AppDelegateOffscreenWindow( void );
//NSArray *CUI_AppDelegateWindows( void );
void CUI_AppDelegateAddWindow( NSWindow *w );
void CUI_AppDelegateRemoveWindow( NSWindow *w );

// custom
void CocoaInit( void );
void AppSetDelegateCallback( CUI_AppDelegateCallbackType callback, void *userData );

