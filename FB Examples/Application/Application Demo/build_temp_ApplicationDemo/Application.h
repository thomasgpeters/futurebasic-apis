/*
 Application.h
 
 Bernie Wylde
 */

#import "Menu.h"
#import "Object.h"
#import "Window.h"

typedef void (*CUI_AppEnumerateWindowsCallbackType)(NSInteger,BOOL*,void*);
typedef void (*CUI_AppRestoreWindowWithIdentifierCompletionHandler)(NSWindow*,NSError*,void*);

// Class
Class ApplicationClass( void );

// Shared app
NSApplication *AppSharedApplication( void );

// Event loop
NSEvent *AppNextEventMatchingMask( NSEventMask mask, CFDateRef untilDate, CFStringRef inMode, BOOL dequeue );
void AppDiscardEventsMatchingMask( NSEventMask mask, NSEvent *beforeEvent );

// Posting actions
BOOL AppTryToPerform( SEL action, CFTypeRef obj );
BOOL AppSendAction( SEL action, CFTypeRef toObj, CFTypeRef fromObj );
CFTypeRef AppTargetForAction( SEL action );
CFTypeRef AppTargetForActionTo( SEL action, CFTypeRef toObj, CFTypeRef fromObj );

// Providing services
CFTypeRef AppValidRequestorType( CFStringRef sendType, CFStringRef returnType );
CFTypeRef AppServicesProvider( void );
void AppSetServicesProvider( CFTypeRef provider );

// Keyboard access
BOOL AppIsFullKeyboardAccessEnabled( void );

// Threads
void AppDetachDrawingThread( SEL selector, CFTypeRef targetObj, CFTypeRef argument );

// Logging exceptions
void AppReportException( NSException *exception );

// Window restoration
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
BOOL AppIsProtectedDataAvailable( void );
#endif// 120000
void AppExtendStateRestoration( void );
void AppCompleteStateRestoration( void );
BOOL AppRestoreWindowWithIdentifier( CFStringRef identifier, NSCoder *state, CUI_AppRestoreWindowWithIdentifierCompletionHandler completionHandler, void *userData );

// aux functions
NSImage *AppIconImage( void );
void AppSetIconImage( CFTypeRef inImage );
void AppTerminate( void );

NSEvent *AppCurrentEvent( void );

BOOL AppIsRunning( void );
void AppRun( void );
void AppFinishLaunching( void );
void AppStop( void );
void AppSendEvent( NSEvent *evnt );
void AppPostEvent( NSEvent *evnt, BOOL atStart );

// Remote notifications
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
void AppRegisterForRemoteNotifications( void );
#endif
void AppUnregisterForRemoteNotifications( void );
NSRemoteNotificationType AppEnabledRemoteNotificationTypes( void );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
BOOL AppIsRegisteredForRemoteNotifications( void );
#endif// 101400

NSMenu *AppMainMenu( void );

NSMenu *AppWindowsMenu( void );
void AppAddWindowsItem( NSInteger tag, CFStringRef title, BOOL isFilename );
void AppRemoveWindowsItem( NSInteger tag );
void AppUpdateWindowsItem( NSInteger tag );

// Appearance
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
NSAppearance *AppAppearance( void );
API_AVAILABLE(macos(10.14))
void AppSetAppearance( NSAppearance *appearance );
API_AVAILABLE(macos(10.14))
void AppSetAppearanceNamed( CFStringRef name );
API_AVAILABLE(macos(10.14))
NSAppearance *AppEffectiveAppearance( void );
#endif

NSInteger AppKeyWindow( void );
NSInteger AppMainWindow( void );

NSWindow *AppWindowWithWindowNumber( NSInteger number );
CFArrayRef AppWindows( void );

void AppEnumerateWindows( NSWindowListOptions options, CUI_AppEnumerateWindowsCallbackType callback, void *userData );

void AppMiniaturizeAll( void );

BOOL AppIsHidden( void );
void AppHide( void );
void AppUnhide( void );
void AppUnhideWithoutActivation( void );

// Updating windows
void AppUpdateWindows( void );
void AppSetWindowsNeedUpdate( BOOL flag );

void AppPreventWindowOrdering( void );
void AppArrangeInFront( void );

NSDockTile *AppDockTile( void );

// Services menu
void AppRegisterServicesMenuTypes( CFArrayRef sendTypes, CFArrayRef returnTypes );
NSMenu *AppServicesMenu( void );
NSInteger AppServicesMenuIndex( void );
void AppSetServicesMenu( NSInteger index );

BOOL AppIsActive( void );
void AppDeactivate( void );
void AppActivateIgnoringOtherApps( BOOL flag );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
void AppActivate( void );
API_AVAILABLE(macos(14.0))
void AppYieldActivationToApplication( NSRunningApplication *application );
API_AVAILABLE(macos(14.0))
void AppYieldActivationToApplicationWithBundleIdentifier( CFStringRef identifier );
#endif// 140000

void AppHideOtherApplications( void );
void AppUnhideAllApplications( void );

BOOL AppSearchStringInUserInterfaceItemString( CFStringRef searchString, CFStringRef string, CFRange searchRange, CFRange *foundRange );
void AppShowHelp( void );
NSMenu *AppHelpMenu( void );
void AppActivateContextHelpMode( void );

NSInteger AppRequestUserAttention( NSRequestUserAttentionType type );
void AppCancelUserAttentionRequest( NSInteger request );
void AppReplyToOpenOrPrint( NSApplicationDelegateReply reply );

// Presentation options
NSApplicationPresentationOptions AppCurrentSystemPresentationOptions( void );
NSApplicationPresentationOptions AppPresentationOptions( void );
void AppSetPresentationOptions( NSApplicationPresentationOptions options );

// Activation policy
NSApplicationActivationPolicy AppActivationPolicy( void );
BOOL AppSetActivationPolicy( NSApplicationActivationPolicy policy );

// Relaunch on login
void AppDisableRelaunchOnLogin( void );
void AppEnableRelaunchOnLogin( void );

// Occlusion state
NSApplicationOcclusionState AppOcclusionState( void );

// Scripting
CFArrayRef AppOrderedDocuments( void );
CFArrayRef AppOrderedWindows( void );

NSInteger AppRunModal( NSInteger wndTag );
void AppStopModal( void );
void AppStopModalWithCode( NSInteger returnCode );
void AppAbortModal( void );
NSModalSession AppBeginModalSession( NSInteger wndTag );
NSModalResponse AppRunModalSession( NSModalSession session );
NSInteger AppModalWindow( void );
void AppEndModalSession( NSModalSession session );

void AppOrderFrontColorPanel( void );
void AppOrderFrontStandardAboutPanel( void );
void AppOrderFrontStandardAboutPanelWithOptions( CFDictionaryRef options );
void AppOrderFrontCharacterPalette( void );
void AppRunPageLayout( void );

NSUserInterfaceLayoutDirection AppUserInterfaceLayoutDirection( void );

void AppReplyToApplicationShouldTerminate( BOOL flag );

// custom
NSInteger AppOutputWindow( void );
void AppSetOutputWindow( NSInteger tag );
void AppBringAllWindowsToFront( void );

NSInteger AppFrontWindow( void );// 20240225

CFRunLoopTimerRef AppSetTimer( NSTimeInterval interval, CUI_AppTimerCallbackType callback, BOOL repeats );
void AppSetDelegateCallback( CUI_AppDelegateCallbackType callback, void *userData );

// -- convenience --
NSView *AppDockTileContentView( void );
CGSize AppDockTileSize( void );
//id AppDockTileOwner( void );
BOOL AppDockTileShowsApplicationBadge( void );
void AppDockTileSetShowsApplicationBadge( BOOL flag );
CFStringRef AppDockTileBadgeLabel( void );
void AppDockTileSetBadgeLabel( CFStringRef label );
void AppDockTileDisplay( void );

/*
  AppProperty

  Store an arbitrary value as a property of the app
*/
CFTypeRef AppProperty( CFStringRef key );
void AppSetProperty( CFStringRef key, CFTypeRef value );
void AppPropertySet( CFStringRef key, CFTypeRef value );

BOOL AppPropertyBool( CFStringRef key );
void AppPropertySetBool( CFStringRef key, BOOL value );
long AppPropertyLong( CFStringRef key );
void AppPropertySetLong( CFStringRef key, long value );
double AppPropertyDouble( CFStringRef key );
void AppPropertySetDouble( CFStringRef key, double value );
CGRect AppPropertyRect( CFStringRef key );
void AppPropertySetRect( CFStringRef key, CGRect r );
CGPoint AppPropertyPoint( CFStringRef key );
void AppPropertySetPoint( CFStringRef key, CGPoint pt );
CGSize AppPropertySize( CFStringRef key );
void AppPropertySetSize( CFStringRef key, CGSize sz );
CFRange AppPropertyRange( CFStringRef key );
void AppPropertySetRange( CFStringRef key, CFRange range );
CFURLRef AppPropertyBookmarkURL( CFStringRef key );
void AppPropertySetBookmarkURL( CFStringRef key, CFURLRef url );
BOOL AppPropertyGetBytes( CFStringRef key, void *bytes );
void AppPropertySetBytes( CFStringRef key, void *bytes, long length );

void AppRemoveProperty( CFStringRef key );
void AppPropertyRemove( CFStringRef key );
void AppRemoveAllProperties( void );
void AppPropertyRemoveAll( void );

// Hide/show tooltips
void AppSetToolTipsHidden( BOOL flag );// 20240622
