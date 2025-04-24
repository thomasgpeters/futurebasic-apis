/*
 Bundle.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

// Class
Class BundleClass( void );

// -- standard objects --
NSBundle *BundleMain( void );
CFArrayRef BundleAllFrameworks( void );
CFArrayRef BundleAllBundles( void );

// -- init --
NSBundle *BundleWithURL( CFURLRef url );
NSBundle *BundleForClass( Class cls );
NSBundle *BundleWithIdentifier( CFStringRef identifier );

// -- loading nib files --
BOOL BundleLoadNibNamed( NSBundle *ref, CFStringRef nibName, CFTypeRef owner, CFArrayRef *topLevelObjects );

// -- resource files --
CFURLRef BundleURLForResource( NSBundle *ref, CFStringRef name, CFStringRef extension, CFStringRef subdirectory );
CFArrayRef BundleURLsForResources( NSBundle *ref, CFStringRef extension, CFStringRef subdirectory );
CFURLRef BundleURLForResourceWithLocalization( NSBundle *ref, CFStringRef name, CFStringRef extension, CFStringRef subdirectory, CFStringRef localizationName );
CFArrayRef BundleURLsForResourcesWithLocalization( NSBundle *ref, CFStringRef extension, CFStringRef subdirectory, CFStringRef localizationName );

// -- image --
CFURLRef BundleURLForImageResource( NSBundle *ref, CFStringRef name );
NSImage *BundleImageForResource( NSBundle *ref, CFStringRef name );

// -- sound --
CFURLRef BundleURLForSoundResource( NSBundle *ref, CFStringRef name );

// -- localized strings --
CFStringRef BundleLocalizedString( NSBundle *ref, CFStringRef key, CFStringRef value, CFStringRef table );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
CFAttributedStringRef BundleLocalizedAttributedString( NSBundle *ref, CFStringRef key, CFStringRef value, CFStringRef table );
#endif

// -- context help --
CFAttributedStringRef BundleContextHelp( NSBundle *ref, CFStringRef key );

// -- standard bundle directories --
CFURLRef BundleResourceURL( NSBundle *ref );
CFURLRef BundleExecutableURL( NSBundle *ref );
CFURLRef BundlePrivateFrameworksURL( NSBundle *ref );
CFURLRef BundleSharedFrameworksURL( NSBundle *ref );
CFURLRef BundleBuiltInPlugInsURL( NSBundle *ref );
CFURLRef BundleURLForAuxiliaryExecutable( NSBundle *ref, CFStringRef name );
CFURLRef BundleSharedSupportURL( NSBundle *ref );
CFURLRef BundleAppStoreReceiptURL( NSBundle *ref );

// -- bundle info --
CFURLRef BundleURL( NSBundle *ref );
CFStringRef BundleIdentifier( NSBundle *ref );
CFDictionaryRef BundleInfoDictionary( NSBundle *ref );
CFTypeRef BundleObjectForInfoDictionaryKey( NSBundle *ref, CFStringRef key );

// -- localization info --
CFArrayRef BundleLocalizations( NSBundle *ref );
CFArrayRef BundlePreferredLocalizations( NSBundle *ref );
CFStringRef BundleDevelopmentLocalization( NSBundle *ref );
CFDictionaryRef BundleLocalizedInfoDictionary( NSBundle *ref );
CFArrayRef BundlePreferredLocalizationsFromArray( CFArrayRef localizationsArray );
CFArrayRef BundlePreferredLocalizationsFromArrayForPreferences( CFArrayRef localizationsArray, CFArrayRef preferencesArray );

// Classes
Class BundleClassNamed( NSBundle *ref, CFStringRef className );
Class BundlePrincipalClass( NSBundle *ref );

// Loading code from bundle
CFArrayRef BundleExecutableArchitectures( NSBundle *ref );
BOOL BundlePreflightAndReturnError( NSBundle *ref, NSError **err );
BOOL BundleLoad( NSBundle *ref );
BOOL BundleLoadAndReturnError( NSBundle *ref, NSError **err );
BOOL BundleUnload( NSBundle *ref );
BOOL BundleIsLoaded( NSBundle *ref );

// -- convenience --
