/*
 CUI_AppDelegate.m
 
 Bernie Wylde
 */

#import "CUI_AppDelegate.h"

static CUI_AppDelegate *sCUI_AppDelegate;

@implementation CUI_AppDelegate

- (id)init {
    if ( (self = [super init]) ) {
        self.windows = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.offscreenWindow release];
    [self.windows release];
    [self.stringVal release];
    [self.arrayVal release];
    [self.dictVal release];
    [self.urlVal release];
    [self.menuObj release];
    [super dealloc];
}
#endif

- (void)timerFired:(NSTimer *)timer {
    CUI_AppTimerCallbackType callback = (CUI_AppTimerCallbackType)[(NSValue *)[timer userInfo] pointerValue];
    if ( (*callback)(timer) ) {
        [timer invalidate];
    }
}

#pragma mark - application delegate methods
- (void)forwardApplicationEvent:(NSInteger)event object:(id)obj {
    if ( self.delegateCallback ) {
        (*self.delegateCallback)(event,self.delegateUserData);
    } else {
        CallUserDefinedOnAppEventFunction( event, (__bridge CFTypeRef)obj );
    }
}

- (void)applicationWillFinishLaunching:(NSNotification *)notification {
    if ( ![NSApp mainMenu] ) CUI_BuildMinimalMenu();
    [self forwardApplicationEvent:appWillFinishLaunching object:notification];
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    [self forwardApplicationEvent:appDidFinishLaunching object:notification];
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)app {
    self.longVal = NSTerminateNow;
    [self forwardApplicationEvent:appShouldTerminate object:app];
    return (NSApplicationTerminateReply)self.longVal;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)app {
    self.boolVal = NO;
    [self forwardApplicationEvent:appShouldTerminateAfterLastWindowClosed object:app];
    return self.boolVal;
}

- (void)applicationWillTerminate:(NSNotification *)notification {
    [self forwardApplicationEvent:appWillTerminate object:notification];
}

- (void)applicationWillBecomeActive:(NSNotification *)notification {
    [self forwardApplicationEvent:appWillBecomeActive object:notification];
}

- (void)applicationDidBecomeActive:(NSNotification *)notification {
    [self forwardApplicationEvent:appDidBecomeActive object:notification];
}

- (void)applicationWillResignActive:(NSNotification *)notification {
    [self forwardApplicationEvent:appWillResignActive object:notification];
}

- (void)applicationDidResignActive:(NSNotification *)notification {
    [self forwardApplicationEvent:appDidResignActive object:notification];
}

- (void)applicationWillHide:(NSNotification *)notification {
    [self forwardApplicationEvent:appWillHide object:notification];
}

- (void)applicationDidHide:(NSNotification *)notification {
    [self forwardApplicationEvent:appDidHide object:notification];
}

- (void)applicationWillUnhide:(NSNotification *)notification {
    [self forwardApplicationEvent:appWillUnhide object:notification];
}

- (void)applicationDidUnhide:(NSNotification *)notification {
    [self forwardApplicationEvent:appDidUnhide object:notification];
}

- (void)applicationWillUpdate:(NSNotification *)notification {
    [self forwardApplicationEvent:appWillUpdate object:notification];
}

- (void)applicationDidUpdate:(NSNotification *)notification {
    [self forwardApplicationEvent:appDidUpdate object:notification];
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)app hasVisibleWindows:(BOOL)flag {
    self.boolVal = YES;
    [self forwardApplicationEvent:appShouldHandleReopen object:app];
    return self.boolVal;
}

- (NSMenu *)applicationDockMenu:(NSApplication *)app {
    self.menuObj = nil;
    [self forwardApplicationEvent:appDockMenu object:app];
    return self.menuObj;
}

- (NSError *)application:(NSApplication *)app willPresentError:(NSError *)error {
    // .....
    //[self forwardApplicationEvent:appWillPresentError object:nil];
    return error;
}

- (void)applicationDidChangeScreenParameters:(NSNotification *)notification {
    [self forwardApplicationEvent:appDidChangeScreenParameters object:notification];
}

- (BOOL)application:(id)sender openFileWithoutUI:(NSString *)filename {
    self.stringVal = filename;
    self.boolVal = NO;
    [self forwardApplicationEvent:appOpenFileWithoutUI object:filename];
    return self.boolVal;
}

- (BOOL)application:(NSApplication *)app openTempFile:(NSString *)filename {
    self.stringVal = filename;
    self.boolVal = NO;
    [self forwardApplicationEvent:appOpenTempFile object:filename];
    return self.boolVal;
}

- (void)application:(NSApplication *)app openFiles:(NSArray *)filenames {
    self.stringVal = [(NSString *)[filenames objectAtIndex:0] lastPathComponent];
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:0];
    for ( NSString *path in filenames ) {
        [tempArray addObject:[NSURL fileURLWithPath:path]];
    }
    self.urlVal = [tempArray objectAtIndex:0];
    self.arrayVal = (NSArray *)tempArray;

    [self forwardApplicationEvent:appOpenURLs object:self.arrayVal];
}

- (BOOL)applicationOpenUntitledFile:(NSApplication *)app {
    self.boolVal = NO;
    [self forwardApplicationEvent:appOpenUntitledFile object:app];
    return self.boolVal;
}

- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)app {
    self.boolVal = NO;
    [self forwardApplicationEvent:appShouldOpenUntitledFile object:app];
    return self.boolVal;
}

- (BOOL)application:(NSApplication *)app printFile:(NSString *)filename {
    self.stringVal = filename;
    self.boolVal = YES;
    [self forwardApplicationEvent:appPrintFile object:filename];
    return self.boolVal;
}

- (NSApplicationPrintReply)application:(NSApplication *)app printFiles:(NSArray *)filenames withSettings:(NSDictionary *)printSettings showPrintPanels:(BOOL)showPrintPanels {
    self.longVal = NSPrintingSuccess;
    self.arrayVal = filenames;
    self.dictVal = printSettings;
    self.boolVal = showPrintPanels;
    [self forwardApplicationEvent:appPrintFiles object:self.arrayVal];
    return (NSApplicationPrintReply)self.longVal;
}

- (void)application:(NSApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // dataVal = deviceToken;
    [self forwardApplicationEvent:appDidRegisterForRemoteNotificationsWithDeviceToken object:deviceToken];
}

- (void)application:(NSApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [self forwardApplicationEvent:appDidFailToRegisterForRemoteNotifications object:error];
}

- (void)application:(NSApplication *)app didReceiveRemoteNotification:(NSDictionary *)userInfo {
    self.dictVal = userInfo;
    [self forwardApplicationEvent:appDidReceiveRemoteNotification object:userInfo];
}

- (void)application:(NSApplication *)app didDecodeRestorableState:(NSCoder *)coder {
    // coder
    [self forwardApplicationEvent:appDidDecodeRestorableState object:coder];
}

- (void)application:(NSApplication *)app willEncodeRestorableState:(NSCoder *)coder {
    // coder
    [self forwardApplicationEvent:appWillEncodeRestorableState object:coder];
}

- (BOOL)application:(NSApplication *)app willContinueUserActivityWithType:(NSString *)userActivityType {
    self.boolVal = NO;
    self.stringVal = userActivityType;
    [self forwardApplicationEvent:appWillContinueUserActivityWithType object:userActivityType];
    return self.boolVal;
}

//- (BOOL)application:(NSApplication *)app continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<NSUserActivityRestoring>> *restorableObjects))restorationHandler {
//    self.boolVal = NO;
//    //self.arrayVal = restorableObjects;
//    [self forwardApplicationEvent:appContinueUserActivity object:nil];
//    return self.boolVal;
//}

//- (BOOL)application:(NSApplication *)app continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *restorableObjects))restorationHandler {
//    self.boolVal = NO;
//    //self.arrayVal = restorableObjects;
//    [self forwardApplicationEvent:appContinueUserActivity object:nil];
//    return self.boolVal;
//}

- (void)application:(NSApplication *)app didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error {
    self.stringVal = userActivityType;
    // error
    [self forwardApplicationEvent:appDidFailToContinueUserActivityWithType object:userActivityType];
}

- (void)application:(NSApplication *)app didUpdateUserActivity:(NSUserActivity *)userActivity {
    [self forwardApplicationEvent:appDidUpdateUserActivity object:userActivity];
}

- (void)applicationDidChangeOcclusionState:(NSNotification *)notification {
    [self forwardApplicationEvent:appDidChangeOcclusionState object:notification];
}

/*
 if this method were to be implemented, it would prevent application:openFiles from being called
 */

//- (void)application:(NSApplication *)application openURLs:(NSArray<NSURL *> *)urls {
//    self.urlVal = [urls objectAtIndex:0];
//    self.arrayVal = urls;
//    CallUserDefinedOnAppEventFunction( appOpenURLs, 0 );
//    [self forwardApplicationEvent:appWillBecomeActive object:nil];
//}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
//- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
//    // ...
//    return YES;
//}
#endif// 120000
@end


// temporary storage of fire date timer and run loop mode for timerbegin block // 20220601
CFRunLoopTimerRef cui_tempTimer;
//CFRunLoopMode cui_tempRunLoopMode;


void CUI_BuildMinimalMenu( void )
{
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    
    NSMenu *mainMenu = [NSApp mainMenu];
#if __has_feature(objc_arc)
    if ( !mainMenu ) mainMenu = [[NSMenu alloc] initWithTitle:@"MainMenu"];
#else
    if ( !mainMenu ) mainMenu = [[[NSMenu alloc] initWithTitle:@"MainMenu"] autorelease];
#endif
    
    // Application
    NSMenuItem *item = [mainMenu addItemWithTitle:appName action:nil keyEquivalent:@""];
#if __has_feature(objc_arc)
    NSMenu *mApp = [[NSMenu alloc] initWithTitle:appName];
#else
    NSMenu *mApp = [[[NSMenu alloc] initWithTitle:appName] autorelease];
#endif
    [mainMenu setSubmenu:mApp forItem:item];
    
    [mApp addItemWithTitle:[NSString stringWithFormat:@"About %@", appName] action:@selector(orderFrontStandardAboutPanel:) keyEquivalent:@""];
    [mApp addItem:[NSMenuItem separatorItem]];
    [mApp addItemWithTitle:[NSString stringWithFormat:@"Quit %@", appName] action:@selector(terminate:) keyEquivalent:@"q"];

    [NSApp setMainMenu:mainMenu];
}


// on appevent fn
CUI_OnAppEventFunctionType CUI_OnAppEventFunction( void )
{ return sCUI_OnAppEventFunction; }

void CUI_SetOnAppEventFunction( CUI_OnAppEventFunctionType onAppEventFn )
{ sCUI_OnAppEventFunction = onAppEventFn; }

void CallUserDefinedOnAppEventFunction( long event, CFTypeRef object )
{
    CUI_OnAppEventFunctionType onAppEventFn = CUI_OnAppEventFunction();
    if ( onAppEventFn ) (*onAppEventFn)( event, object );
}


void CUI_AppRun( void )
{
    static BOOL sCUI_AppRun = NO;
    if ( !sCUI_AppRun ) {
#if !__has_feature(objc_arc)
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
#endif
        sCUI_AppRun = YES;
        [NSApp run];
#if !__has_feature(objc_arc)
        [pool drain];
#endif
    }
}

CUI_AppDelegate *CUI_AppDelegateObj( void )
{
    CUI_AppDelegate *appDelegate = (CUI_AppDelegate *)[NSApp delegate];
    if ( !appDelegate ) {
        appDelegate = [[CUI_AppDelegate alloc] init];
        sCUI_AppDelegate = appDelegate;
    }
    return appDelegate;
}

void CocoaInit( void )
{
    NSApplication *app = [NSApplication sharedApplication];
    if ( ![app delegate] ) {
#if __has_feature(objc_arc)
        CUI_AppDelegate *appDelegate = [[CUI_AppDelegate alloc] init];
#else
        CUI_AppDelegate *appDelegate = [[[CUI_AppDelegate alloc] init] autorelease];
#endif
        [app setDelegate:appDelegate];
    }
}

// event
void AppEventSetBool( BOOL value )
{ [CUI_AppDelegateObj() setBoolVal:value]; }

void AppEventSetLong( long value )
{ [CUI_AppDelegateObj() setLongVal:value]; }

CFStringRef AppEventString( void )
{ return (__bridge CFStringRef)[CUI_AppDelegateObj() stringVal]; }

CFArrayRef AppEventArray( void )
{ return (__bridge CFArrayRef)[CUI_AppDelegateObj() arrayVal]; }

CFDictionaryRef AppEventDictionary( void )
{ return (__bridge CFDictionaryRef)[CUI_AppDelegateObj() dictVal]; }

CFURLRef AppEventURL( void )
{ return (__bridge CFURLRef)[CUI_AppDelegateObj() urlVal]; }

void AppEventSetMenu( NSMenu *obj )
{ [CUI_AppDelegateObj() setMenuObj:obj]; }

NSWindow *CUI_AppDelegateOffscreenWindow( void )
{
    NSWindow *offscreenWindow = [CUI_AppDelegateObj() offscreenWindow];
    if ( !offscreenWindow ) {
        offscreenWindow = [[NSWindow alloc] init];
        [CUI_AppDelegateObj() setOffscreenWindow:offscreenWindow];
    }
    return offscreenWindow;
}

//NSArray *CUI_AppDelegateWindows( void )
//{ return [CUI_AppDelegateObj() windows]; }

void CUI_AppDelegateAddWindow( NSWindow *w )
{ [[CUI_AppDelegateObj() windows] addObject:w]; }

void CUI_AppDelegateRemoveWindow( NSWindow *w )
{ [[CUI_AppDelegateObj() windows] removeObject:w]; }

