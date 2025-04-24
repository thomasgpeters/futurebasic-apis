/*
 Bundle.h
 
 Bernie Wylde
 */

#import "Bundle.h"

// Class
Class BundleClass( void )
{ return [NSBundle class]; }

// -- standard objects --
NSBundle *BundleMain( void )
{ return [NSBundle mainBundle]; }

CFArrayRef BundleAllFrameworks( void )
{ return (__bridge CFArrayRef)[NSBundle allFrameworks]; }

CFArrayRef BundleAllBundles( void )
{ return (__bridge CFArrayRef)[NSBundle allBundles]; }

// -- init --
NSBundle *BundleWithURL( CFURLRef url )
{ return [NSBundle bundleWithURL:(__bridge NSURL *)url]; }

NSBundle *BundleForClass( Class cls )
{ return [NSBundle bundleForClass:cls]; }

NSBundle *BundleWithIdentifier( CFStringRef identifier )
{ return [NSBundle bundleWithIdentifier:(__bridge NSString *)identifier]; }

// -- loading nib files --
BOOL BundleLoadNibNamed( NSBundle *ref, CFStringRef nibName, CFTypeRef owner, CFArrayRef *topLevelObjects )
{
    NSArray *tempTopLevelObjects = nil;
    BOOL flag = [ref loadNibNamed:(__bridge NSString *)nibName owner:(__bridge id)owner topLevelObjects:&tempTopLevelObjects];
    if ( topLevelObjects ) *topLevelObjects = (__bridge CFArrayRef)tempTopLevelObjects;
    return flag;
}

// -- resource files --
CFURLRef BundleURLForResource( NSBundle *ref, CFStringRef name, CFStringRef extension, CFStringRef subdirectory )
{
    if ( subdirectory ) {
        return (__bridge CFURLRef)[ref URLForResource:(__bridge NSString *)name withExtension:(__bridge NSString *)extension subdirectory:(__bridge NSString *)subdirectory];
    } else {
        return (__bridge CFURLRef)[ref URLForResource:(__bridge NSString *)name withExtension:(__bridge NSString *)extension];
    }
}

CFArrayRef BundleURLsForResources( NSBundle *ref, CFStringRef extension, CFStringRef subdirectory )
{ return (__bridge CFArrayRef)[ref URLsForResourcesWithExtension:(__bridge NSString *)extension subdirectory:(__bridge NSString *)subdirectory]; }

CFURLRef BundleURLForResourceWithLocalization( NSBundle *ref, CFStringRef name, CFStringRef extension, CFStringRef subdirectory, CFStringRef localizationName )
{ return (__bridge CFURLRef)[ref URLForResource:(__bridge NSString *)name withExtension:(__bridge NSString *)extension subdirectory:(__bridge NSString *)subdirectory localization:(__bridge NSString *)localizationName]; }

CFArrayRef BundleURLsForResourcesWithLocalization( NSBundle *ref, CFStringRef extension, CFStringRef subdirectory, CFStringRef localizationName )
{ return (__bridge CFArrayRef)[ref URLsForResourcesWithExtension:(__bridge NSString *)extension subdirectory:(__bridge NSString *)subdirectory localization:(__bridge NSString *)localizationName]; }

// -- image --
CFURLRef BundleURLForImageResource( NSBundle *ref, CFStringRef name )
{ return (__bridge CFURLRef)[ref URLForImageResource:(__bridge NSString *)name]; }

NSImage *BundleImageForResource( NSBundle *ref, CFStringRef name )
{ return [ref imageForResource:(__bridge NSString *)name]; }

// -- sound --
CFURLRef BundleURLForSoundResource( NSBundle *ref, CFStringRef name )
{ return (__bridge CFURLRef)[NSURL fileURLWithPath:[ref pathForSoundResource:(__bridge NSString *)name]]; }

// -- localized strings --
CFStringRef BundleLocalizedString( NSBundle *ref, CFStringRef key, CFStringRef value, CFStringRef table )
{ return (__bridge CFStringRef)[ref localizedStringForKey:(__bridge NSString *)key value:(__bridge NSString *)value table:(__bridge NSString *)table]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
CFAttributedStringRef BundleLocalizedAttributedString( NSBundle *ref, CFStringRef key, CFStringRef value, CFStringRef table )
{ return (__bridge CFAttributedStringRef)[ref localizedAttributedStringForKey:(__bridge NSString *)key value:(__bridge NSString *)value table:(__bridge NSString *)table]; }
#endif

// -- context help --
CFAttributedStringRef BundleContextHelp( NSBundle *ref, CFStringRef key )
{ return (__bridge CFAttributedStringRef)[ref contextHelpForKey:(__bridge NSString *)key]; }

// -- standard bundle directories --
CFURLRef BundleResourceURL( NSBundle *ref )
{ return (__bridge CFURLRef)[ref resourceURL]; }

CFURLRef BundleExecutableURL( NSBundle *ref )
{ return (__bridge CFURLRef)[ref executableURL]; }

CFURLRef BundlePrivateFrameworksURL( NSBundle *ref )
{ return (__bridge CFURLRef)[ref privateFrameworksURL]; }

CFURLRef BundleSharedFrameworksURL( NSBundle *ref )
{ return (__bridge CFURLRef)[ref sharedFrameworksURL]; }

CFURLRef BundleBuiltInPlugInsURL( NSBundle *ref )
{ return (__bridge CFURLRef)[ref builtInPlugInsURL]; }

CFURLRef BundleURLForAuxiliaryExecutable( NSBundle *ref, CFStringRef name )
{ return (__bridge CFURLRef)[ref URLForAuxiliaryExecutable:(__bridge NSString *)name]; }

CFURLRef BundleSharedSupportURL( NSBundle *ref )
{ return (__bridge CFURLRef)[ref sharedSupportURL]; }

CFURLRef BundleAppStoreReceiptURL( NSBundle *ref )
{ return (__bridge CFURLRef)[ref appStoreReceiptURL]; }

// -- bundle info --
CFURLRef BundleURL( NSBundle *ref )
{ return (__bridge CFURLRef)[ref bundleURL]; }

CFStringRef BundleIdentifier( NSBundle *ref )
{ return (__bridge CFStringRef)[ref bundleIdentifier]; }

CFDictionaryRef BundleInfoDictionary( NSBundle *ref )
{ return (__bridge CFDictionaryRef)[ref infoDictionary]; }

CFTypeRef BundleObjectForInfoDictionaryKey( NSBundle *ref, CFStringRef key )
{ return (__bridge CFTypeRef)[ref objectForInfoDictionaryKey:(__bridge NSString *)key]; }

// -- localization info --
CFArrayRef BundleLocalizations( NSBundle *ref )
{ return (__bridge CFArrayRef)[ref localizations]; }

CFArrayRef BundlePreferredLocalizations( NSBundle *ref )
{ return (__bridge CFArrayRef)[ref preferredLocalizations]; }

CFStringRef BundleDevelopmentLocalization( NSBundle *ref )
{ return (__bridge CFStringRef)[ref developmentLocalization]; }

CFDictionaryRef BundleLocalizedInfoDictionary( NSBundle *ref )
{ return (__bridge CFDictionaryRef)[ref localizedInfoDictionary]; }

CFArrayRef BundlePreferredLocalizationsFromArray( CFArrayRef localizationsArray )
{ return (__bridge CFArrayRef)[NSBundle preferredLocalizationsFromArray:(__bridge NSArray *)localizationsArray]; }

CFArrayRef BundlePreferredLocalizationsFromArrayForPreferences( CFArrayRef localizationsArray, CFArrayRef preferencesArray )
{ return (__bridge CFArrayRef)[NSBundle preferredLocalizationsFromArray:(__bridge NSArray *)localizationsArray forPreferences:(__bridge NSArray *)preferencesArray]; }

// Classes
Class BundleClassNamed( NSBundle *ref, CFStringRef className )
{ return [ref classNamed:(__bridge NSString *)className]; }

Class BundlePrincipalClass( NSBundle *ref )
{ return [ref principalClass]; }

// Loading code from bundle
CFArrayRef BundleExecutableArchitectures( NSBundle *ref )
{ return (__bridge CFArrayRef)[ref executableArchitectures]; }

BOOL BundlePreflightAndReturnError( NSBundle *ref, NSError **err )
{ return [ref preflightAndReturnError:err]; }

BOOL BundleLoad( NSBundle *ref )
{ return [ref load]; }

BOOL BundleLoadAndReturnError( NSBundle *ref, NSError **err )
{ return [ref loadAndReturnError:err]; }

BOOL BundleUnload( NSBundle *ref )
{ return [ref unload]; }

BOOL BundleIsLoaded( NSBundle *ref )
{ return [ref isLoaded]; }


