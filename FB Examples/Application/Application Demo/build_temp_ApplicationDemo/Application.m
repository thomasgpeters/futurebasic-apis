/*
 Application.m
 
 Bernie Wylde
 */

#import "Application.h"

// Class
Class ApplicationClass( void )
{ return [NSApplication class]; }

// Shared app
NSApplication *AppSharedApplication( void )
{ return [NSApplication sharedApplication]; }

// Event loop
NSEvent *AppNextEventMatchingMask( NSEventMask mask, CFDateRef untilDate, CFStringRef inMode, BOOL dequeue )
{ return [NSApp nextEventMatchingMask:mask untilDate:(__bridge NSDate *)untilDate inMode:(__bridge NSString *)inMode dequeue:dequeue]; }

void AppDiscardEventsMatchingMask( NSEventMask mask, NSEvent *beforeEvent )
{ [NSApp discardEventsMatchingMask:mask beforeEvent:beforeEvent]; }

// Posting actions
BOOL AppTryToPerform( SEL action, CFTypeRef obj )
{ return [NSApp tryToPerform:action with:(__bridge id)obj]; }

BOOL AppSendAction( SEL action, CFTypeRef toObj, CFTypeRef fromObj )
{ return [NSApp sendAction:action to:(__bridge id)toObj from:(__bridge id)fromObj]; }

CFTypeRef AppTargetForAction( SEL action )
{ return (__bridge CFTypeRef)[NSApp targetForAction:action]; }

CFTypeRef AppTargetForActionTo( SEL action, CFTypeRef toObj, CFTypeRef fromObj )
{ return (__bridge CFTypeRef)[NSApp targetForAction:action to:(__bridge id)toObj from:(__bridge id)fromObj]; }

// Providing services
CFTypeRef AppValidRequestorType( CFStringRef sendType, CFStringRef returnType )
{ return (__bridge CFTypeRef)[NSApp validRequestorForSendType:(__bridge NSString *)sendType returnType:(__bridge NSString *)returnType]; }

CFTypeRef AppServicesProvider( void )
{ return (__bridge CFTypeRef)[NSApp servicesProvider]; }

void AppSetServicesProvider( CFTypeRef provider )
{ [NSApp setServicesProvider:(__bridge id)provider]; }

// Keyboard access
BOOL AppIsFullKeyboardAccessEnabled( void )
{ return [NSApp isFullKeyboardAccessEnabled]; }

// Threads
void AppDetachDrawingThread( SEL selector, CFTypeRef targetObj, CFTypeRef argument )
{ [NSApplication detachDrawingThread:selector toTarget:(__bridge id)targetObj withObject:(__bridge id)argument]; }

// Logging exceptions
void AppReportException( NSException *exception )
{ [NSApp reportException:exception]; }

// Window restoration
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
BOOL AppIsProtectedDataAvailable( void )
{ return [NSApp isProtectedDataAvailable]; }
#endif// 120000

void AppExtendStateRestoration( void )
{ [NSApp extendStateRestoration]; }

void AppCompleteStateRestoration( void )
{ [NSApp completeStateRestoration]; }

BOOL AppRestoreWindowWithIdentifier( CFStringRef identifier, NSCoder *state, CUI_AppRestoreWindowWithIdentifierCompletionHandler completionHandler, void *userData )
{
    return [NSApp restoreWindowWithIdentifier:(__bridge NSString *)identifier state:state completionHandler:^(NSWindow *window, NSError *error) {
        (*completionHandler)(window,error,userData);
    }];
}

NSImage *AppIconImage( void )
{ return [NSApp applicationIconImage]; }

void AppSetIconImage( CFTypeRef inImage )
{
    NSImage *image = CUI_FixImageValue( inImage );
    [NSApp setApplicationIconImage:image];
}

void AppTerminate( void )
{ [NSApp terminate:nil]; }

NSEvent *AppCurrentEvent( void )
{ return [NSApp currentEvent]; }

BOOL AppIsRunning( void )
{ return [NSApp isRunning]; }

void AppRun( void )
{ [NSApp run]; }

void AppFinishLaunching( void )
{ [NSApp finishLaunching]; }

void AppStop( void )
{ [NSApp stop:nil]; }

void AppSendEvent( NSEvent *evnt )
{ [NSApp sendEvent:evnt]; }

void AppPostEvent( NSEvent *evnt, BOOL atStart )
{ [NSApp postEvent:evnt atStart:atStart]; }


// Remote notifications
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
void AppRegisterForRemoteNotifications( void )
{
    if ( @available(macos 10.14, *)) {
        [NSApp registerForRemoteNotifications]; }
    }
#endif

void AppUnregisterForRemoteNotifications( void )
{
    if ( @available(macos 10.14, *)) {
        [NSApp unregisterForRemoteNotifications];
    }
}

NSRemoteNotificationType AppEnabledRemoteNotificationTypes( void )
{ return [NSApp enabledRemoteNotificationTypes]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
BOOL AppIsRegisteredForRemoteNotifications( void )
{ return [NSApp isRegisteredForRemoteNotifications]; }
#endif// 101400

NSInteger AppKeyWindow( void )
{
    NSWindow *w = [NSApp keyWindow];
    if ( w ) return [w tag];
    return 0;
}

NSInteger AppMainWindow( void )
{
    NSWindow *w = [NSApp mainWindow];
    if ( w ) return [w tag];
    return 0;
}

NSWindow *AppWindowWithWindowNumber( NSInteger number )
{ return [NSApp windowWithWindowNumber:number]; }

CFArrayRef AppWindows( void )
{ return (__bridge CFArrayRef)[NSApp windows]; }

void AppEnumerateWindows( NSWindowListOptions options, CUI_AppEnumerateWindowsCallbackType callback, void *userData )
{
    [NSApp enumerateWindowsWithOptions:options usingBlock:^(NSWindow *window, BOOL *stop) {
        (*callback)([window tag],stop,userData);
    }];
}

void AppMiniaturizeAll( void )
{ [NSApp miniaturizeAll:nil]; }

BOOL AppIsHidden( void )
{ return [NSApp isHidden]; }

void AppHide( void )
{ [NSApp hide:nil]; }

void AppUnhide( void )
{ [NSApp unhide:nil]; }

void AppUnhideWithoutActivation( void )
{ [NSApp unhideWithoutActivation]; }

// Updating windows
void AppUpdateWindows( void )
{ [NSApp updateWindows]; }

void AppSetWindowsNeedUpdate( BOOL flag )
{ [NSApp setWindowsNeedUpdate:flag]; }

void AppPreventWindowOrdering( void )
{ [NSApp preventWindowOrdering]; }

void AppArrangeInFront( void )
{ [NSApp arrangeInFront:nil]; }

NSMenu *AppMainMenu( void )
{ return [NSApp mainMenu]; }

NSMenu *AppWindowsMenu( void )
{ return [NSApp windowsMenu]; }

void AppAddWindowsItem( NSInteger tag, CFStringRef title, BOOL isFilename )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [NSApp addWindowsItem:w title:(__bridge NSString *)title filename:isFilename];
}

void AppRemoveWindowsItem( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [NSApp removeWindowsItem:w];
}

void AppUpdateWindowsItem( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [NSApp updateWindowsItem:w];
}

// Appearance
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
NSAppearance *AppAppearance( void )
{ return [NSApp appearance]; }

void AppSetAppearance( NSAppearance *appearance )
{ [NSApp setAppearance:appearance]; }

void AppSetAppearanceNamed( CFStringRef name )
{ [NSApp setAppearance:[NSAppearance appearanceNamed:(__bridge NSString *)name]]; }

NSAppearance *AppEffectiveAppearance( void )
{ return [NSApp effectiveAppearance]; }
#endif// 101400

NSMenu *AppHelpMenu( void )
{ return [NSApp helpMenu]; }

void AppActivateContextHelpMode( void )
{ [NSApp activateContextHelpMode:nil]; }

NSInteger AppRequestUserAttention( NSRequestUserAttentionType type )
{ return [NSApp requestUserAttention:type]; }

void AppCancelUserAttentionRequest( NSInteger request )
{ [NSApp cancelUserAttentionRequest:request]; }

void AppReplyToOpenOrPrint( NSApplicationDelegateReply reply )
{ [NSApp replyToOpenOrPrint:reply]; }

// Presentation options
NSApplicationPresentationOptions AppCurrentSystemPresentationOptions( void )
{ return [NSApp currentSystemPresentationOptions]; }

NSApplicationPresentationOptions AppPresentationOptions( void )
{ return [NSApp presentationOptions]; }

void AppSetPresentationOptions( NSApplicationPresentationOptions options )
{ [NSApp setPresentationOptions:options]; }

// Activation policy
NSApplicationActivationPolicy AppActivationPolicy( void )
{ return [NSApp activationPolicy]; }

BOOL AppSetActivationPolicy( NSApplicationActivationPolicy policy )
{ return [NSApp setActivationPolicy:policy]; }

// Relaunch on login
void AppDisableRelaunchOnLogin( void )
{ [NSApp disableRelaunchOnLogin]; }

void AppEnableRelaunchOnLogin( void )
{ [NSApp enableRelaunchOnLogin]; }

// Occlusion state
NSApplicationOcclusionState AppOcclusionState( void )
{ return [NSApp occlusionState]; }

// Scripting
CFArrayRef AppOrderedDocuments( void )
{ return (__bridge CFArrayRef)[NSApp orderedDocuments]; }

CFArrayRef AppOrderedWindows( void )
{ return (__bridge CFArrayRef)[NSApp orderedWindows]; }

NSDockTile *AppDockTile( void )
{ return [NSApp dockTile]; }

// Services menu
void AppRegisterServicesMenuTypes( CFArrayRef sendTypes, CFArrayRef returnTypes )
{ [NSApp registerServicesMenuSendTypes:(__bridge NSArray *)sendTypes returnTypes:(__bridge NSArray *)returnTypes]; }

NSMenu *AppServicesMenu( void )
{ return [NSApp servicesMenu]; }

NSInteger AppServicesMenuIndex( void )
{
    NSMenu *menu = [NSApp servicesMenu];
    if ( menu ) return CUI_MenuIndex( menu );
    return 0;
}

void AppSetServicesMenu( NSInteger index )
{
    NSMenu *menu = MenuAtIndex( index );
    if ( menu ) [NSApp setServicesMenu:menu];
}

BOOL AppIsActive( void )
{ return [NSApp isActive]; }

void AppDeactivate( void )
{ [NSApp deactivate]; }

void AppActivateIgnoringOtherApps( BOOL flag )
{ [NSApp activateIgnoringOtherApps:flag]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
void AppActivate( void )
{ [NSApp activate]; }

void AppYieldActivationToApplication( NSRunningApplication *application )
{ [NSApp yieldActivationToApplication:application]; }

void AppYieldActivationToApplicationWithBundleIdentifier( CFStringRef identifier )
{ [NSApp yieldActivationToApplicationWithBundleIdentifier:(__bridge NSString *)identifier]; }
#endif// 140000

void AppHideOtherApplications( void )
{ [NSApp hideOtherApplications:nil]; }

void AppUnhideAllApplications( void )
{ [NSApp unhideAllApplications:nil]; }

BOOL AppSearchStringInUserInterfaceItemString( CFStringRef searchString, CFStringRef string, CFRange searchRange, CFRange *foundRange )
{ return [NSApp searchString:(__bridge NSString *)searchString inUserInterfaceItemString:(__bridge NSString *)string searchRange:NSRangeFromCFRange(searchRange) foundRange:(NSRange *)foundRange]; }

void AppShowHelp( void )
{ [NSApp showHelp:nil]; }

NSInteger AppRunModal( NSInteger wndTag )
{
    NSWindow *w = CUI_WindowWithTag( wndTag );
    if ( w ) return [NSApp runModalForWindow:w];
    return 0;
}

void AppStopModal( void )
{ [NSApp stopModal]; }

void AppStopModalWithCode( NSInteger returnCode )
{ [NSApp stopModalWithCode:returnCode]; }

void AppAbortModal( void )
{ [NSApp abortModal]; }

NSModalSession AppBeginModalSession( NSInteger wndTag )
{
    NSWindow *w = CUI_WindowWithTag( wndTag );
    if ( w ) return [NSApp beginModalSessionForWindow:w];
    return nil;
}

NSModalResponse AppRunModalSession( NSModalSession session )
{ return [NSApp runModalSession:session]; }

NSInteger AppModalWindow( void )
{
    NSWindow *w = [NSApp modalWindow];
    if ( w ) return [w tag];
    return 0;
}

void AppEndModalSession( NSModalSession session )
{ [NSApp endModalSession:session]; }

void AppOrderFrontColorPanel( void )
{
    [NSApp orderFrontColorPanel:nil];
    CUI_ColorPanelSetTarget();
}

void AppOrderFrontStandardAboutPanel( void )
{ [NSApp orderFrontStandardAboutPanel:nil]; }

void AppOrderFrontStandardAboutPanelWithOptions( CFDictionaryRef options )
{
    NSMutableDictionary *dict = [(__bridge NSDictionary *)options mutableCopy];
    
    id icon = [dict objectForKey:@"ApplicationIcon"];
    if ( icon ) {
        if ( [icon isKindOfClass:[NSImage class]] ) {
            [dict setObject:icon forKey:@"ApplicationIcon"];
        } else {
            NSImage *image = CUI_ImageResource( icon );
            [dict setObject:image forKey:@"ApplicationIcon"];
        }
    }
    [NSApp orderFrontStandardAboutPanelWithOptions:dict];
#if !__has_feature(objc_arc)
    [dict release];
#endif
}

void AppOrderFrontCharacterPalette( void )
{ [NSApp orderFrontCharacterPalette:nil]; }

void AppRunPageLayout( void )
{ [NSApp runPageLayout:nil]; }

NSUserInterfaceLayoutDirection AppUserInterfaceLayoutDirection( void )
{ return [NSApp userInterfaceLayoutDirection]; }

void AppReplyToApplicationShouldTerminate( BOOL flag )
{ [NSApp replyToApplicationShouldTerminate:flag]; }

CFRunLoopTimerRef AppSetTimer( NSTimeInterval interval, CUI_AppTimerCallbackType callback, BOOL repeats )
{
    CUI_AppDelegate *appDelegate = (CUI_AppDelegate *)[NSApp delegate];
    if ( appDelegate ) {
        return (__bridge CFRunLoopTimerRef)[NSTimer scheduledTimerWithTimeInterval:interval target:appDelegate selector:@selector(timerFired:) userInfo:[NSValue valueWithPointer:(void *)callback] repeats:repeats];
    }
    return nil;
}

void AppSetDelegateCallback( CUI_AppDelegateCallbackType callback, void *userData )
{
    CUI_AppDelegate *appDelegate = (CUI_AppDelegate *)[NSApp delegate];
    if ( appDelegate ) {
        appDelegate.delegateCallback = callback;
        appDelegate.delegateUserData = userData;
    }
}

NSInteger AppOutputWindow( void )
{ return CUI_OutputWindowTag(); }

void AppSetOutputWindow( NSInteger tag )
{ CUI_OutputWindowSetTag( tag ); }

void AppBringAllWindowsToFront( void )
{
    NSArray *windows = [NSApp orderedWindows];
    NSInteger count = [windows count] - 1;
    while ( count >= 0 ) {
        //[(NSWindow *)[windows objectAtIndex:count] orderFrontRegardless];
        NSWindow *w = [windows objectAtIndex:count];
        if ( [w isVisible] ) {
            [w orderFrontRegardless];
        }
        count--;
    }
}

NSInteger AppFrontWindow( void )// 20240225
{
    NSArray *windows = [NSApp orderedWindows];
    if ( [windows count] > 0 ) return [windows[0] tag];
    return 0;
}

// -- convenience --
NSView *AppDockTileContentView( void )
{ return [[NSApp dockTile] contentView]; }

CGSize AppDockTileSize( void )
{ return NSSizeToCGSize([[NSApp dockTile] size]); }

//id AppDockTileOwner( void )
//{ return [[NSApp dockTile] owner]; }

BOOL AppDockTileShowsApplicationBadge( void )
{ return [[NSApp dockTile] showsApplicationBadge]; }

void AppDockTileSetShowsApplicationBadge( BOOL flag )
{ [[NSApp dockTile] setShowsApplicationBadge:flag]; }

CFStringRef AppDockTileBadgeLabel( void )
{ return (__bridge CFStringRef)[[NSApp dockTile] badgeLabel]; }

void AppDockTileSetBadgeLabel( CFStringRef label )
{ [[NSApp dockTile] setBadgeLabel:(__bridge NSString *)label]; }

void AppDockTileDisplay( void )
{ [[NSApp dockTile] display]; }

/*
  AppProperty
*/
CFTypeRef AppProperty( CFStringRef key )
{ return ObjectProperty( (__bridge CFTypeRef)NSApp, key ); }

void AppSetProperty( CFStringRef key, CFTypeRef value )
{ ObjectSetProperty( (__bridge CFTypeRef)NSApp, key, value ); }

void AppPropertySet( CFStringRef key, CFTypeRef value )
{ ObjectPropertySet( (__bridge CFTypeRef)NSApp, key, value ); }


BOOL AppPropertyBool( CFStringRef key )
{ return ObjectPropertyBool( (__bridge CFTypeRef)NSApp, key ); }

void AppPropertySetBool( CFStringRef key, BOOL value )
{ ObjectPropertySetBool( (__bridge CFTypeRef)NSApp, key, value ); }

long AppPropertyLong( CFStringRef key )
{ return ObjectPropertyLong( (__bridge CFTypeRef)NSApp, key ); }

void AppPropertySetLong( CFStringRef key, long value )
{ ObjectPropertySetLong( (__bridge CFTypeRef)NSApp, key, value ); }

double AppPropertyDouble( CFStringRef key )
{ return ObjectPropertyDouble( (__bridge CFTypeRef)NSApp, key ); }

void AppPropertySetDouble( CFStringRef key, double value )
{ ObjectPropertySetDouble( (__bridge CFTypeRef)NSApp, key, value ); }

CGRect AppPropertyRect( CFStringRef key )
{ return ObjectPropertyRect( (__bridge CFTypeRef)NSApp, key ); }

void AppPropertySetRect( CFStringRef key, CGRect r )
{ ObjectPropertySetRect( (__bridge CFTypeRef)NSApp, key, r ); }

CGPoint AppPropertyPoint( CFStringRef key )
{ return ObjectPropertyPoint( (__bridge CFTypeRef)NSApp, key ); }

void AppPropertySetPoint( CFStringRef key, CGPoint pt )
{ ObjectPropertySetPoint( (__bridge CFTypeRef)NSApp, key, pt ); }

CGSize AppPropertySize( CFStringRef key )
{ return ObjectPropertySize( (__bridge CFTypeRef)NSApp, key ); }

void AppPropertySetSize( CFStringRef key, CGSize sz )
{ ObjectPropertySetSize( (__bridge CFTypeRef)NSApp, key, sz ); }

CFRange AppPropertyRange( CFStringRef key )
{ return ObjectPropertyRange( (__bridge CFTypeRef)NSApp, key ); }

void AppPropertySetRange( CFStringRef key, CFRange range )
{ ObjectPropertySetRange( (__bridge CFTypeRef)NSApp, key, range ); }

CFURLRef AppPropertyBookmarkURL( CFStringRef key )
{ return ObjectPropertyBookmarkURL( (__bridge CFTypeRef)NSApp, key ); }

void AppPropertySetBookmarkURL( CFStringRef key, CFURLRef url )
{ ObjectPropertySetBookmarkURL( (__bridge CFTypeRef)NSApp, key, url ); }

BOOL AppPropertyGetBytes( CFStringRef key, void *bytes )
{ return ObjectPropertyGetBytes( (__bridge CFTypeRef)NSApp, key, bytes ); }

void AppPropertySetBytes( CFStringRef key, void *bytes, long length )
{ ObjectPropertySetBytes( (__bridge CFTypeRef)NSApp, key, bytes, length ); }


void AppRemoveProperty( CFStringRef key )
{ ObjectRemoveProperty( (__bridge CFTypeRef)NSApp, key ); }

void AppPropertyRemove( CFStringRef key )
{ ObjectPropertyRemove( (__bridge CFTypeRef)NSApp, key ); }

void AppRemoveAllProperties( void )
{ ObjectRemoveAllProperties( (__bridge CFTypeRef)NSApp ); }

void AppPropertyRemoveAll( void )
{ ObjectPropertyRemoveAll( (__bridge CFTypeRef)NSApp ); }

// Hide/show tooltips
void AppSetToolTipsHidden( BOOL flag )// 20240622
{
    // menus
    MenuSetToolTipsHidden( (NSInteger)[NSApp mainMenu], flag );
    
    // windows
    NSArray *windows = [NSApp orderedWindows];
    for ( NSWindow *w in windows ) {
        NSInteger tag = [w tag];
        if ( tag ) WindowSetToolTipsHidden( tag, flag );
    }
}
