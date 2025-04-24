/*
 Workspace.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef void (*CUI_WorkspaceNotificationCenterCallbackType)(NSNotification*);
typedef void (*CUI_WorkspaceSetDefaultApplicationAtURLCompletionHandlerType)(NSError*,void*);

@interface CUI_WorkspaceNotificationCenter : NSObject
@property (nonatomic,assign) CUI_WorkspaceNotificationCenterCallbackType callback;
@property (nonatomic,retain) NSString *name;

- (id)initWithCallback:(CUI_WorkspaceNotificationCenterCallbackType)cb name:(NSString *)nm;

@end

// -- private --
NSMutableArray *CUI_WorkspaceNotificationCenters( void );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
typedef void (*WorkspaceRequestAuthorizationCompletionHandlerType)(NSWorkspaceAuthorization*,NSError*,void*);
#endif

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
typedef void (*CUI_WorkspaceOpenCompletionHandlerType)(NSRunningApplication*,NSError*,void*);
#endif

// Class
Class WorkspaceClass( void );

// Shared
NSWorkspace *WorkspaceShared( void );

// Notification center
NSNotificationCenter *WorkspaceNotificationCenter( void );
void WorkspaceNotificationCenterAddObserver( CUI_WorkspaceNotificationCenterCallbackType callback, CFStringRef name, CFTypeRef object );
void WorkspaceNotificationCenterRemoveObserver( CUI_WorkspaceNotificationCenterCallbackType callback, CFStringRef name );
void WorkspaceNotificationCenterPostNotification( NSNotification *note );
void WorkspaceNotificationCenterPostNotificationName( CFStringRef name, CFTypeRef object, CFDictionaryRef userInfo );

// Opening files
NSRunningApplication *WorkspaceOpenURLWithOptions( CFURLRef url, NSWorkspaceLaunchOptions options, CFDictionaryRef configuration, NSError **err );
BOOL WorkspaceOpenURL( CFURLRef url );
BOOL WorkspaceOpenURLWithApplication( CFURLRef url, CFStringRef appName, BOOL deactivate );
BOOL WorkspaceOpenURLsWithApplicationAtURL( CFArrayRef urls, CFURLRef appURL, NSWorkspaceLaunchOptions options, CFDictionaryRef configuration );
BOOL WorkspaceOpenURLWithApplicationAtURL( CFURLRef url, CFURLRef appURL, NSWorkspaceLaunchOptions options, CFDictionaryRef configuration );
BOOL WorkspaceLaunchApplication( CFStringRef appName );

NSRunningApplication *WorkspaceLaunchApplicationAtURL( CFURLRef url, NSWorkspaceLaunchOptions options, CFDictionaryRef configuration, NSError **err );

void WorkspaceHideOtherApplications( void );
void WorkspaceDuplicateURLs( CFArrayRef urls );
void WorkspaceRecycleURL( CFURLRef url);
void WorkspaceRecycleURLs( CFArrayRef urls );

void WorkspaceActivateFileViewerSelectingURLs( CFArrayRef fileURLs );

// UTI
CFStringRef WorkspaceTypeOfFileAtURL( CFURLRef url );
CFStringRef WorkspaceLocalizedDescriptionForType( CFStringRef type );
CFStringRef WorkspacePreferredFilenameExtensionForType( CFStringRef typeName );
BOOL WorkspaceFilenameExtensionIsValidForType( CFStringRef filenameExtension, CFStringRef typeName );
BOOL WorkspaceFileTypeConformsToType( CFStringRef firstTypeName, CFStringRef secondTypeName );
BOOL WorkspaceGetInfoForFileAtURL( CFURLRef url, CFStringRef *appName, CFStringRef *type );
CFURLRef WorkspaceURLForApplicationToOpenURL( CFURLRef url );
CFURLRef WorkspaceURLForApplication( CFStringRef name );

BOOL WorkspaceGetFileSystemInfoForURL( CFURLRef url, BOOL *isRemovable, BOOL *isWritable, BOOL *isUnmountable, CFStringRef *description, CFStringRef *type );

BOOL WorkspaceIsFilePackageAtURL( CFURLRef url );
NSRunningApplication *WorkspaceFrontmostApplication( void );
CFArrayRef WorkspaceRunningApplications( void );
NSRunningApplication *WorkspaceMenuBarOwningApplication( void );
NSImage *WorkspaceIconForFileAtURL( CFURLRef url );
NSImage *WorkspaceIconForFilesAtURLs( CFArrayRef urls );
NSImage *WorkspaceIconForFileType( CFStringRef type );
void WorkspaceSetIconForFileAtURL( NSImage *icon, CFURLRef url, NSWorkspaceIconCreationOptions options );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
NSImage *WorkspaceIconForContentType( UTType *contentType );
#endif// 110000

// Unmount
BOOL WorkspaceUnmountAndEjectDeviceAtURL( CFURLRef url, NSError **err );

BOOL WorkspaceShowSearchResultsForQueryString( CFStringRef string );

CFArrayRef WorkspaceFileLabelColors( void );
CFArrayRef WorkspaceFileLabels( void );

CFURLRef WorkspaceURLForApplicationWithBundleIdentifier( CFStringRef identifier );
void WorkspaceNoteFileSystemChangedAtURL( CFURLRef url );

// Accessibility
BOOL WorkspaceAccessibilityDisplayShouldDifferentiateWithoutColor( void );
BOOL WorkspaceAccessibilityDisplayShouldIncreaseContrast( void );
BOOL WorkspaceAccessibilityDisplayShouldReduceTransparency( void );
BOOL WorkspaceAccessibilityDisplayShouldInvertColors( void );
BOOL WorkspaceAccessibilityDisplayShouldReduceMotion( void );
BOOL WorkspaceIsSwitchControlEnabled( void );
BOOL WorkspaceIsVoiceOverEnabled( void );

// - desktop image -
CFURLRef WorkspaceDesktopImageURLForScreen( NSScreen *screen );
void WorkspaceSetDesktopImageURLForScreen( CFURLRef url, NSScreen *screen, CFDictionaryRef options, NSError **err );
CFDictionaryRef WorkspaceDesktopImageOptionsForScreen( NSScreen *screen );

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
void WorkspaceRequestAuthorizationOfType( NSWorkspaceAuthorizationType type, WorkspaceRequestAuthorizationCompletionHandlerType completionHandler, void *userData );
#endif

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
void WorkspaceOpenURLWithConfiguration( CFURLRef url, NSWorkspaceOpenConfiguration *configuration, CUI_WorkspaceOpenCompletionHandlerType completionHandler, void *userData );
API_AVAILABLE(macos(10.15))
void WorkspaceOpenURLsWithApplicationAndConfiguration( CFArrayRef urls, CFURLRef appURL, NSWorkspaceOpenConfiguration *configuration, CUI_WorkspaceOpenCompletionHandlerType completionHandler, void *userData );
API_AVAILABLE(macos(10.15))
void WorkspaceOpenApplicationAtURLWithConfiguration( CFURLRef url, NSWorkspaceOpenConfiguration *configuration, CUI_WorkspaceOpenCompletionHandlerType completionHandler, void *userData );
#endif// 101500

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
void WorkspaceSetDefaultApplicationAtURLToOpenContentType( CFURLRef url, UTType *contentType, CUI_WorkspaceSetDefaultApplicationAtURLCompletionHandlerType completionHandler, void *userData );
API_AVAILABLE(macos(12.0))
void WorkspaceSetDefaultApplicationAtURLToOpenContentTypeOfFileAtURL( CFURLRef url, CFURLRef fileURL, CUI_WorkspaceSetDefaultApplicationAtURLCompletionHandlerType completionHandler, void *userData );
API_AVAILABLE(macos(12.0))
void WorkspaceSetDefaultApplicationAtURLToOpenFileAtURL( CFURLRef url, CFURLRef fileURL, CUI_WorkspaceSetDefaultApplicationAtURLCompletionHandlerType completionHandler, void *userData );
API_AVAILABLE(macos(12.0))
void WorkspaceSetDefaultApplicationAtURLToOpenURLsWithScheme( CFURLRef url, CFStringRef urlScheme, CUI_WorkspaceSetDefaultApplicationAtURLCompletionHandlerType completionHandler, void *userData );
API_AVAILABLE(macos(12.0))
CFURLRef WorkspaceURLForApplicationToOpenContentType( UTType *contentType );
API_AVAILABLE(macos(12.0))
CFArrayRef WorkspaceURLsForApplicationsToOpenContentType( UTType *contentType );
API_AVAILABLE(macos(12.0))
CFArrayRef WorkspaceURLsForApplicationsToOpenURL( CFURLRef url );
API_AVAILABLE(macos(12.0))
CFArrayRef WorkspaceURLsForApplicationsWithBundleIdentifier( CFStringRef identifier );
#endif// 120000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
/*
  WorkspaceOpenConfiguration
*/
// Init
API_AVAILABLE(macos(10.15))
NSWorkspaceOpenConfiguration *WorkspaceOpenConfigurationInit( void );

// Instance properties
API_AVAILABLE(macos(10.15))
BOOL WorkspaceOpenConfigurationActivates( NSWorkspaceOpenConfiguration *ref );
API_AVAILABLE(macos(10.15))
void WorkspaceOpenConfigurationSetActivates( NSWorkspaceOpenConfiguration *ref, BOOL flag );
API_AVAILABLE(macos(10.15))
BOOL WorkspaceOpenConfigurationAddsToRecentItems( NSWorkspaceOpenConfiguration *ref );
API_AVAILABLE(macos(10.15))
void WorkspaceOpenConfigurationSetAddsToRecentItems( NSWorkspaceOpenConfiguration *ref, BOOL flag );
API_AVAILABLE(macos(10.15))
BOOL WorkspaceOpenConfigurationAllowsRunningApplicationSubstition( NSWorkspaceOpenConfiguration *ref );
API_AVAILABLE(macos(10.15))
void WorkspaceOpenConfigurationSetAllowsRunningApplicationSubstition( NSWorkspaceOpenConfiguration *ref, BOOL flag );
API_AVAILABLE(macos(10.15))
NSAppleEventDescriptor *WorkspaceOpenConfigurationAppleEvent( NSWorkspaceOpenConfiguration *ref );
API_AVAILABLE(macos(10.15))
void WorkspaceOpenConfigurationSetAppleEvent( NSWorkspaceOpenConfiguration *ref, NSAppleEventDescriptor *ae );
API_AVAILABLE(macos(10.15))
SInt32 WorkspaceOpenConfigurationArchitecture( NSWorkspaceOpenConfiguration *ref );
API_AVAILABLE(macos(10.15))
void WorkspaceOpenConfigurationSetArchitecture( NSWorkspaceOpenConfiguration *ref, SInt32 architecture );
API_AVAILABLE(macos(10.15))
CFArrayRef WorkspaceOpenConfigurationArguments( NSWorkspaceOpenConfiguration *ref );
API_AVAILABLE(macos(10.15))
void WorkspaceOpenConfigurationSetArguments( NSWorkspaceOpenConfiguration *ref, CFArrayRef args );
API_AVAILABLE(macos(10.15))
BOOL WorkspaceOpenConfigurationCreatesNewApplicationInstance( NSWorkspaceOpenConfiguration *ref );
API_AVAILABLE(macos(10.15))
void WorkspaceOpenConfigurationSetCreatesNewApplicationInstance( NSWorkspaceOpenConfiguration *ref, BOOL flag );
API_AVAILABLE(macos(10.15))
CFDictionaryRef WorkspaceOpenConfigurationEnvironment( NSWorkspaceOpenConfiguration *ref );
API_AVAILABLE(macos(10.15))
void WorkspaceOpenConfigurationSetEnvironment( NSWorkspaceOpenConfiguration *ref, CFDictionaryRef environment );
API_AVAILABLE(macos(10.15))
BOOL WorkspaceOpenConfigurationHides( NSWorkspaceOpenConfiguration *ref );
API_AVAILABLE(macos(10.15))
void WorkspaceOpenConfigurationSetHides( NSWorkspaceOpenConfiguration *ref, BOOL flag );
API_AVAILABLE(macos(10.15))
BOOL WorkspaceOpenConfigurationHidesOthers( NSWorkspaceOpenConfiguration *ref );
API_AVAILABLE(macos(10.15))
void WorkspaceOpenConfigurationSetHidesOthers( NSWorkspaceOpenConfiguration *ref, BOOL flag );
API_AVAILABLE(macos(10.15))
BOOL WorkspaceOpenConfigurationIsForPrinting( NSWorkspaceOpenConfiguration *ref );
API_AVAILABLE(macos(10.15))
void WorkspaceOpenConfigurationSetForPrinting( NSWorkspaceOpenConfiguration *ref, BOOL flag );
API_AVAILABLE(macos(10.15))
BOOL WorkspaceOpenConfigurationPromptsUserIfNeeded( NSWorkspaceOpenConfiguration *ref );
API_AVAILABLE(macos(10.15))
void WorkspaceOpenConfigurationSetPromptsUserIfNeeded( NSWorkspaceOpenConfiguration *ref, BOOL flag );
API_AVAILABLE(macos(10.15))
BOOL WorkspaceOpenConfigurationRequiresUniversalLinks( NSWorkspaceOpenConfiguration *ref );
API_AVAILABLE(macos(10.15))
void WorkspaceOpenConfigurationSetRequiresUniversalLinks( NSWorkspaceOpenConfiguration *ref, BOOL flag );

#endif// 101500
