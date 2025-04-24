/*
 Workspace.m

 Bernie Wylde
 */

#import "Workspace.h"

static NSMutableArray *sCUI_WorkspaceNotificationCenters;

@implementation CUI_WorkspaceNotificationCenter : NSObject

- (id)initWithCallback:(CUI_WorkspaceNotificationCenterCallbackType)cb name:(NSString *)nm {
    if ( (self = [super init]) ) {
        self.callback = cb;
        self.name = nm;
    }
    return self;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.name release];
    [super dealloc];
}
#endif

- (void)didReceiveNotification:(NSNotification *)notification {
    if ( self.callback ) (*self.callback)(notification);
}
@end

// -- private --
NSMutableArray *CUI_WorkspaceNotificationCenters( void )
{
    if ( !sCUI_WorkspaceNotificationCenters ) sCUI_WorkspaceNotificationCenters = [[NSMutableArray alloc] initWithCapacity:0];
    return sCUI_WorkspaceNotificationCenters;
}

// -- public --
// Class
Class WorkspaceClass( void )
{ return [NSWorkspace class]; }

// Shared
NSWorkspace *WorkspaceShared( void )
{ return [NSWorkspace sharedWorkspace]; }

// Notification center
NSNotificationCenter *WorkspaceNotificationCenter( void )
{ return [[NSWorkspace sharedWorkspace] notificationCenter]; }

void WorkspaceNotificationCenterAddObserver( CUI_WorkspaceNotificationCenterCallbackType callback, CFStringRef name, CFTypeRef object )
{
    NSMutableArray *centers = CUI_WorkspaceNotificationCenters();
    CUI_WorkspaceNotificationCenter *center = [[CUI_WorkspaceNotificationCenter alloc] initWithCallback:callback name:(__bridge NSString *)name];
    [centers addObject:center];
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:center selector:@selector(didReceiveNotification:) name:(__bridge NSString *)name object:(__bridge id)object];
}

void WorkspaceNotificationCenterRemoveObserver( CUI_WorkspaceNotificationCenterCallbackType callback, CFStringRef name )
{
    NSMutableArray *centers = CUI_WorkspaceNotificationCenters();
    for ( CUI_WorkspaceNotificationCenter *center in centers ) {
        if ( (center.callback == callback) && ([[center name] isEqualToString:(__bridge NSString *)name]) ) {
            [[[NSWorkspace sharedWorkspace] notificationCenter] removeObserver:center name:(__bridge NSString *)name object:nil];
            [centers removeObject:center];
            break;
        }
    }
}

void WorkspaceNotificationCenterPostNotification( NSNotification *note )
{ [[[NSWorkspace sharedWorkspace] notificationCenter] postNotification:note]; }

void WorkspaceNotificationCenterPostNotificationName( CFStringRef name, CFTypeRef object, CFDictionaryRef userInfo )
{ [[[NSWorkspace sharedWorkspace] notificationCenter] postNotificationName:(__bridge NSString *)name object:(__bridge id)object userInfo:(__bridge NSDictionary *)userInfo]; }

// Opening files
NSRunningApplication *WorkspaceOpenURLWithOptions( CFURLRef url, NSWorkspaceLaunchOptions options, CFDictionaryRef configuration, NSError **err )
{ return [[NSWorkspace sharedWorkspace] openURL:(__bridge NSURL *)url options:options configuration:(__bridge NSDictionary *)configuration error:err]; }

BOOL WorkspaceOpenURL( CFURLRef url )
{ return [[NSWorkspace sharedWorkspace] openURL:(__bridge NSURL *)url]; }

BOOL WorkspaceOpenURLWithApplication( CFURLRef inURL, CFStringRef inAppName, BOOL deactivate )
{
    NSURL *url = (NSURL *)inURL;
    NSString *appName = (NSString *)inAppName;
    if ( appName != nil && url != nil ) {
        NSString *path = [url path];
        if ( path ) return [[NSWorkspace sharedWorkspace] openFile:path withApplication:appName andDeactivate:deactivate];
    }
    return NO;
}

BOOL WorkspaceOpenURLsWithApplicationAtURL( CFArrayRef urls, CFURLRef appURL, NSWorkspaceLaunchOptions options, CFDictionaryRef configuration )
{
    return ( [[NSWorkspace sharedWorkspace] openURLs:(__bridge NSArray *)urls withApplicationAtURL:(__bridge NSURL *)appURL options:options configuration:(__bridge NSDictionary *)configuration error:nil] != nil );
    return false;
}

BOOL WorkspaceOpenURLWithApplicationAtURL( CFURLRef url, CFURLRef appURL, NSWorkspaceLaunchOptions options, CFDictionaryRef configuration )
{
    return ( [[NSWorkspace sharedWorkspace] openURLs:[NSArray arrayWithObject:(__bridge NSURL *)url] withApplicationAtURL:(__bridge NSURL *)appURL options:options configuration:(__bridge NSDictionary *)configuration error:nil] != nil );
    return false;
}

BOOL WorkspaceLaunchApplication( CFStringRef appName )
{ return [[NSWorkspace sharedWorkspace] launchApplication:(__bridge NSString *)appName]; }

NSRunningApplication *WorkspaceLaunchApplicationAtURL( CFURLRef url, NSWorkspaceLaunchOptions options, CFDictionaryRef configuration, NSError **err )
{ return [[NSWorkspace sharedWorkspace] launchApplicationAtURL:(__bridge NSURL *)url options:options configuration:(__bridge NSDictionary *)configuration error:err]; }

void WorkspaceHideOtherApplications( void )
{ [[NSWorkspace sharedWorkspace] hideOtherApplications]; }

void WorkspaceDuplicateURLs( CFArrayRef urls )
{ [[NSWorkspace sharedWorkspace] duplicateURLs:(__bridge NSArray *)urls completionHandler:nil]; }

void WorkspaceRecycleURL( CFURLRef url)
{ [[NSWorkspace sharedWorkspace] recycleURLs:[NSArray arrayWithObject:(__bridge NSURL *)url] completionHandler:nil]; }

void WorkspaceRecycleURLs( CFArrayRef urls )
{ [[NSWorkspace sharedWorkspace] recycleURLs:(__bridge NSArray *)urls completionHandler:nil]; }

void WorkspaceActivateFileViewerSelectingURLs( CFArrayRef fileURLs )
{ [[NSWorkspace sharedWorkspace] activateFileViewerSelectingURLs:(__bridge NSArray *)fileURLs]; }

// UTI
CFStringRef WorkspaceTypeOfFileAtURL( CFURLRef inURL )
{
    NSURL *url = (__bridge NSURL *)inURL;
    if ( url ) {
        NSString *path = [url path];
        if ( path ) return (__bridge CFStringRef)[[NSWorkspace sharedWorkspace] typeOfFile:path error:nil];
    }
    return nil;
}

CFStringRef WorkspaceLocalizedDescriptionForType( CFStringRef type )
{ return (__bridge CFStringRef)[[NSWorkspace sharedWorkspace] localizedDescriptionForType:(__bridge NSString *)type]; }

CFStringRef WorkspacePreferredFilenameExtensionForType( CFStringRef typeName )
{ return (__bridge CFStringRef)[[NSWorkspace sharedWorkspace] preferredFilenameExtensionForType:(__bridge NSString *)typeName]; }

BOOL WorkspaceFilenameExtensionIsValidForType( CFStringRef filenameExtension, CFStringRef typeName )
{ return [[NSWorkspace sharedWorkspace] filenameExtension:(__bridge NSString *)filenameExtension isValidForType:(__bridge NSString *)typeName]; }

BOOL WorkspaceFileTypeConformsToType( CFStringRef firstTypeName, CFStringRef secondTypeName )
{ return [[NSWorkspace sharedWorkspace] type:(__bridge NSString *)firstTypeName conformsToType:(__bridge NSString *)secondTypeName]; }

BOOL WorkspaceGetInfoForFileAtURL( CFURLRef inURL, CFStringRef *appName, CFStringRef *type )
{
    NSURL *url = (__bridge NSURL *)inURL;
    if ( url ) {
        NSString *path = [url path];
        if ( path ) {
            NSString *tempType = nil;
            NSString *tempAppName = nil;
            BOOL flag = [[NSWorkspace sharedWorkspace] getInfoForFile:path application:&tempAppName type:&tempType];
            if ( flag ) {
                if ( appName ) *appName = (__bridge CFStringRef)tempAppName;
                if ( type ) *type = (__bridge CFStringRef)tempType;
            }
            return flag;
        }
    }
    return NO;
}

CFURLRef WorkspaceURLForApplicationToOpenURL( CFURLRef url )
{ return (__bridge CFURLRef)[[NSWorkspace sharedWorkspace] URLForApplicationToOpenURL:(__bridge NSURL *)url]; }

BOOL WorkspaceGetFileSystemInfoForURL( CFURLRef inURL, BOOL *isRemovable, BOOL *isWritable, BOOL *isUnmountable, CFStringRef *description, CFStringRef *type )
{
    NSURL *url = (__bridge NSURL *)inURL;
    if ( url ) {
        NSString *path = [url path];
        if ( path ) {
            NSString *tempDescription = nil;
            NSString *tempType = nil;
            BOOL flag = [[NSWorkspace sharedWorkspace] getFileSystemInfoForPath:path isRemovable:(BOOL *)isRemovable isWritable:(BOOL *)isWritable isUnmountable:(BOOL *)isUnmountable description:&tempDescription type:&tempType];
            if ( flag ) {
                if ( description ) *description = (__bridge CFStringRef)tempDescription;
                if ( type ) *type = (__bridge CFStringRef)tempType;
            }
            return flag;
        }
    }
    return NO;
}

BOOL WorkspaceIsFilePackageAtURL( CFURLRef inURL )
{
    NSURL *url = (__bridge NSURL *)inURL;
    if ( url ) {
        NSString *path = [url path];
        if ( path ) {
            return [[NSWorkspace sharedWorkspace] isFilePackageAtPath:path];
        }
    }
    return NO;
}

NSRunningApplication *WorkspaceFrontmostApplication( void )
{ return [[NSWorkspace sharedWorkspace] frontmostApplication]; }

CFArrayRef WorkspaceRunningApplications( void )
{ return (__bridge CFArrayRef)[[NSWorkspace sharedWorkspace] runningApplications]; }

NSRunningApplication *WorkspaceMenuBarOwningApplication( void )
{ return [[NSWorkspace sharedWorkspace] menuBarOwningApplication]; }

NSImage *WorkspaceIconForFileAtURL( CFURLRef inURL )
{
    NSURL *url = (__bridge NSURL *)inURL;
    if ( url ) {
        NSString *path = [url path];
        if ( path ) return [[NSWorkspace sharedWorkspace] iconForFile:path];
    }
    return nil;
}

NSImage *WorkspaceIconForFilesAtURLs( CFArrayRef inURLs )
{
    NSArray *urls = (__bridge NSArray *)inURLs;
    if ( urls ) {
        NSArray *paths = [urls valueForKey:@"path"];
        if ( paths ) return [[NSWorkspace sharedWorkspace] iconForFiles:paths];
    }
    return nil;
}

NSImage *WorkspaceIconForFileType( CFStringRef type )
{ return [[NSWorkspace sharedWorkspace] iconForFileType:(__bridge NSString *)type]; }

void WorkspaceSetIconForFileAtURL( NSImage *icon, CFURLRef inURL, NSWorkspaceIconCreationOptions options )
{
    NSURL *url = (__bridge NSURL *)inURL;
    if ( url ) {
        NSString *path = [url path];
        if ( path ) [[NSWorkspace sharedWorkspace] setIcon:icon forFile:path options:options];
    }
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
NSImage *WorkspaceIconForContentType( UTType *contentType )
{ return [[NSWorkspace sharedWorkspace] iconForContentType:contentType]; }
#endif// 110000

// Unmount
BOOL WorkspaceUnmountAndEjectDeviceAtURL( CFURLRef url, NSError **err )
{ return [[NSWorkspace sharedWorkspace] unmountAndEjectDeviceAtURL:(__bridge NSURL *)url error:err]; }

BOOL WorkspaceShowSearchResultsForQueryString( CFStringRef string )
{ return [[NSWorkspace sharedWorkspace] showSearchResultsForQueryString:(__bridge NSString *)string]; }

CFArrayRef WorkspaceFileLabelColors( void )
{ return (__bridge CFArrayRef)[[NSWorkspace sharedWorkspace] fileLabelColors]; }

CFArrayRef WorkspaceFileLabels( void )
{ return (__bridge CFArrayRef)[[NSWorkspace sharedWorkspace] fileLabels]; }


CFURLRef WorkspaceURLForApplicationWithBundleIdentifier( CFStringRef identifier )
{ return (__bridge CFURLRef)[[NSWorkspace sharedWorkspace] URLForApplicationWithBundleIdentifier:(__bridge NSString *)identifier]; }

CFURLRef WorkspaceURLForApplication( CFStringRef name )
{
    NSString *path = [[NSWorkspace sharedWorkspace] fullPathForApplication:(__bridge NSString *)name];
    if ( path ) {
        return (__bridge CFURLRef)[NSURL fileURLWithPath:path];
    }
    return nil;
}

void WorkspaceNoteFileSystemChangedAtURL( CFURLRef inURL )
{
    NSURL *url = (__bridge NSURL *)inURL;
    if ( url ) {
        NSString *path = [url path];
        if ( path ) [[NSWorkspace sharedWorkspace] noteFileSystemChanged:path];
    }
}

// Accessibility
BOOL WorkspaceAccessibilityDisplayShouldDifferentiateWithoutColor( void )
{ return [[NSWorkspace sharedWorkspace] accessibilityDisplayShouldDifferentiateWithoutColor]; }

BOOL WorkspaceAccessibilityDisplayShouldIncreaseContrast( void )
{ return [[NSWorkspace sharedWorkspace] accessibilityDisplayShouldIncreaseContrast]; }

BOOL WorkspaceAccessibilityDisplayShouldReduceTransparency( void )
{ return [[NSWorkspace sharedWorkspace] accessibilityDisplayShouldReduceTransparency]; }

BOOL WorkspaceAccessibilityDisplayShouldInvertColors( void )
{ return [[NSWorkspace sharedWorkspace] accessibilityDisplayShouldInvertColors]; }

BOOL WorkspaceAccessibilityDisplayShouldReduceMotion( void )
{ return [[NSWorkspace sharedWorkspace] accessibilityDisplayShouldReduceMotion]; }

BOOL WorkspaceIsSwitchControlEnabled( void )
{ return [[NSWorkspace sharedWorkspace] isSwitchControlEnabled]; }

BOOL WorkspaceIsVoiceOverEnabled( void )
{ return [[NSWorkspace sharedWorkspace] isVoiceOverEnabled]; }

// - desktop image -
CFURLRef WorkspaceDesktopImageURLForScreen( NSScreen *screen )
{ return (__bridge CFURLRef)[[NSWorkspace sharedWorkspace] desktopImageURLForScreen:screen]; }

void WorkspaceSetDesktopImageURLForScreen( CFURLRef url, NSScreen *screen, CFDictionaryRef options, NSError **err )
{ [[NSWorkspace sharedWorkspace] setDesktopImageURL:(__bridge NSURL *)url forScreen:screen options:(__bridge NSDictionary *)options error:err]; }

CFDictionaryRef WorkspaceDesktopImageOptionsForScreen( NSScreen *screen )
{ return (__bridge CFDictionaryRef)[[NSWorkspace sharedWorkspace] desktopImageOptionsForScreen:screen]; }

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
void WorkspaceRequestAuthorizationOfType( NSWorkspaceAuthorizationType type, WorkspaceRequestAuthorizationCompletionHandlerType completionHandler, void *userData )
{
    [[NSWorkspace sharedWorkspace] requestAuthorizationOfType:type completionHandler:^(NSWorkspaceAuthorization *authorization, NSError *error) {
        if ( completionHandler ) (*completionHandler)(authorization,error,userData);
    }];
}
#endif

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
void WorkspaceOpenURLWithConfiguration( CFURLRef url, NSWorkspaceOpenConfiguration *configuration, CUI_WorkspaceOpenCompletionHandlerType completionHandler, void *userData )
{
    if ( !configuration ) configuration = [NSWorkspaceOpenConfiguration configuration];
    [[NSWorkspace sharedWorkspace] openURL:(__bridge NSURL *)url configuration:configuration completionHandler:^(NSRunningApplication *app, NSError *err ) {
        if ( completionHandler ) (*completionHandler)(app,err,userData);
    }];
}

void WorkspaceOpenURLsWithApplicationAndConfiguration( CFArrayRef urls, CFURLRef appURL, NSWorkspaceOpenConfiguration *configuration, CUI_WorkspaceOpenCompletionHandlerType completionHandler, void *userData )
{
    if ( !configuration ) configuration = [NSWorkspaceOpenConfiguration configuration];
    [[NSWorkspace sharedWorkspace] openURLs:(__bridge NSArray *)urls withApplicationAtURL:(__bridge NSURL *)appURL configuration:configuration completionHandler:^(NSRunningApplication *app, NSError *err ) {
        if ( completionHandler ) (*completionHandler)(app,err,userData);
    }];
}

void WorkspaceOpenApplicationAtURLWithConfiguration( CFURLRef url, NSWorkspaceOpenConfiguration *configuration, CUI_WorkspaceOpenCompletionHandlerType completionHandler, void *userData )
{
    if ( !configuration ) configuration = [NSWorkspaceOpenConfiguration configuration];
    [[NSWorkspace sharedWorkspace] openApplicationAtURL:(__bridge NSURL *)url configuration:configuration completionHandler:^(NSRunningApplication *app, NSError *err ) {
        if ( completionHandler ) (*completionHandler)(app,err,userData);
    }];
}
#endif// 101500

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
void WorkspaceSetDefaultApplicationAtURLToOpenContentType( CFURLRef url, UTType *contentType, CUI_WorkspaceSetDefaultApplicationAtURLCompletionHandlerType completionHandler, void *userData )
{
    [[NSWorkspace sharedWorkspace] setDefaultApplicationAtURL:(__bridge NSURL *)url toOpenContentType:contentType completionHandler:^( NSError *error ) {
        (*completionHandler)( error, userData );
    }];
}

void WorkspaceSetDefaultApplicationAtURLToOpenContentTypeOfFileAtURL( CFURLRef url, CFURLRef fileURL, CUI_WorkspaceSetDefaultApplicationAtURLCompletionHandlerType completionHandler, void *userData )
{
    [[NSWorkspace sharedWorkspace] setDefaultApplicationAtURL:(__bridge NSURL *)url toOpenContentTypeOfFileAtURL:(__bridge NSURL *)fileURL completionHandler:^( NSError *error ) {
        (*completionHandler)( error, userData );
    }];
}

void WorkspaceSetDefaultApplicationAtURLToOpenFileAtURL( CFURLRef url, CFURLRef fileURL, CUI_WorkspaceSetDefaultApplicationAtURLCompletionHandlerType completionHandler, void *userData )
{
    [[NSWorkspace sharedWorkspace] setDefaultApplicationAtURL:(__bridge NSURL *)url toOpenFileAtURL:(__bridge NSURL *)fileURL completionHandler:^( NSError *error ) {
        (*completionHandler)( error, userData );
    }];
}

void WorkspaceSetDefaultApplicationAtURLToOpenURLsWithScheme( CFURLRef url, CFStringRef urlScheme, CUI_WorkspaceSetDefaultApplicationAtURLCompletionHandlerType completionHandler, void *userData )
{
    [[NSWorkspace sharedWorkspace] setDefaultApplicationAtURL:(__bridge NSURL *)url toOpenURLsWithScheme:(__bridge NSString *)urlScheme completionHandler:^( NSError *error ) {
        (*completionHandler)( error, userData );
    }];
}

CFURLRef WorkspaceURLForApplicationToOpenContentType( UTType *contentType )
{ return (__bridge CFURLRef)[[NSWorkspace sharedWorkspace] URLForApplicationToOpenContentType:contentType]; }

CFArrayRef WorkspaceURLsForApplicationsToOpenContentType( UTType *contentType )
{ return (__bridge CFArrayRef)[[NSWorkspace sharedWorkspace] URLsForApplicationsToOpenContentType:contentType]; }

CFArrayRef WorkspaceURLsForApplicationsToOpenURL( CFURLRef url )
{ return (__bridge CFArrayRef)[[NSWorkspace sharedWorkspace] URLsForApplicationsToOpenURL:(__bridge NSURL *)url]; }

CFArrayRef WorkspaceURLsForApplicationsWithBundleIdentifier( CFStringRef identifier )
{ return (__bridge CFArrayRef)[[NSWorkspace sharedWorkspace] URLsForApplicationsWithBundleIdentifier:(__bridge NSString *)identifier]; }
#endif// 120000


#pragma mark - WorkspaceOpenConfiguration

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
// Init
NSWorkspaceOpenConfiguration *WorkspaceOpenConfigurationInit( void )
{ return [NSWorkspaceOpenConfiguration configuration]; }

// Instance properties
BOOL WorkspaceOpenConfigurationActivates( NSWorkspaceOpenConfiguration *ref )
{ return [ref activates]; }

void WorkspaceOpenConfigurationSetActivates( NSWorkspaceOpenConfiguration *ref, BOOL flag )
{ [ref setActivates:flag]; }

BOOL WorkspaceOpenConfigurationAddsToRecentItems( NSWorkspaceOpenConfiguration *ref )
{ return [ref addsToRecentItems]; }

void WorkspaceOpenConfigurationSetAddsToRecentItems( NSWorkspaceOpenConfiguration *ref, BOOL flag )
{ [ref setAddsToRecentItems:flag]; }

BOOL WorkspaceOpenConfigurationAllowsRunningApplicationSubstition( NSWorkspaceOpenConfiguration *ref )
{ return [ref allowsRunningApplicationSubstitution]; }

void WorkspaceOpenConfigurationSetAllowsRunningApplicationSubstition( NSWorkspaceOpenConfiguration *ref, BOOL flag )
{ [ref setAllowsRunningApplicationSubstitution:flag]; }

NSAppleEventDescriptor *WorkspaceOpenConfigurationAppleEvent( NSWorkspaceOpenConfiguration *ref )
{ return [ref appleEvent]; }

void WorkspaceOpenConfigurationSetAppleEvent( NSWorkspaceOpenConfiguration *ref, NSAppleEventDescriptor *ae )
{ [ref setAppleEvent:ae]; }

SInt32 WorkspaceOpenConfigurationArchitecture( NSWorkspaceOpenConfiguration *ref )
{ return [ref architecture]; }

void WorkspaceOpenConfigurationSetArchitecture( NSWorkspaceOpenConfiguration *ref, SInt32 architecture )
{ [ref setArchitecture:architecture]; }

CFArrayRef WorkspaceOpenConfigurationArguments( NSWorkspaceOpenConfiguration *ref )
{ return (__bridge CFArrayRef)[ref arguments]; }

void WorkspaceOpenConfigurationSetArguments( NSWorkspaceOpenConfiguration *ref, CFArrayRef args )
{ [ref setArguments:(__bridge NSArray *)args]; }

BOOL WorkspaceOpenConfigurationCreatesNewApplicationInstance( NSWorkspaceOpenConfiguration *ref )
{ return [ref createsNewApplicationInstance]; }

void WorkspaceOpenConfigurationSetCreatesNewApplicationInstance( NSWorkspaceOpenConfiguration *ref, BOOL flag )
{ [ref setCreatesNewApplicationInstance:flag]; }

CFDictionaryRef WorkspaceOpenConfigurationEnvironment( NSWorkspaceOpenConfiguration *ref )
{ return (__bridge CFDictionaryRef)[ref environment]; }

void WorkspaceOpenConfigurationSetEnvironment( NSWorkspaceOpenConfiguration *ref, CFDictionaryRef environment )
{ [ref setEnvironment:(__bridge NSDictionary *)environment]; }

BOOL WorkspaceOpenConfigurationHides( NSWorkspaceOpenConfiguration *ref )
{ return [ref hides]; }

void WorkspaceOpenConfigurationSetHides( NSWorkspaceOpenConfiguration *ref, BOOL flag )
{ [ref setHides:flag]; }

BOOL WorkspaceOpenConfigurationHidesOthers( NSWorkspaceOpenConfiguration *ref )
{ return [ref hidesOthers]; }

void WorkspaceOpenConfigurationSetHidesOthers( NSWorkspaceOpenConfiguration *ref, BOOL flag )
{ [ref setHidesOthers:flag]; }

BOOL WorkspaceOpenConfigurationIsForPrinting( NSWorkspaceOpenConfiguration *ref )
{ return [ref isForPrinting]; }

void WorkspaceOpenConfigurationSetForPrinting( NSWorkspaceOpenConfiguration *ref, BOOL flag )
{ [ref setForPrinting:flag]; }

BOOL WorkspaceOpenConfigurationPromptsUserIfNeeded( NSWorkspaceOpenConfiguration *ref )
{ return [ref promptsUserIfNeeded]; }

void WorkspaceOpenConfigurationSetPromptsUserIfNeeded( NSWorkspaceOpenConfiguration *ref, BOOL flag )
{ [ref setPromptsUserIfNeeded:flag]; }

BOOL WorkspaceOpenConfigurationRequiresUniversalLinks( NSWorkspaceOpenConfiguration *ref )
{ return [ref requiresUniversalLinks]; }

void WorkspaceOpenConfigurationSetRequiresUniversalLinks( NSWorkspaceOpenConfiguration *ref, BOOL flag )
{ [ref setRequiresUniversalLinks:flag]; }

#endif// 101500
