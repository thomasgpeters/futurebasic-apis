/*
 UserDefaults.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "Window.h"

#pragma mark - private functions
//NSDictionary *UserDefaultsProcessDictionary( NSDictionary *inDict );

void CUI_UserDefaultsAddValueToDictionary( id view, NSMutableDictionary *dict );
void CUI_UserDefaultsAddSubviewValuesToDictionary( id superview, NSMutableDictionary *dict );
void CUI_UserDefaultsStoreWindowViewValues( NSWindow *w, NSString *key );
void CUI_UserDefaultsRestoreValueFromDictionary( id view, NSDictionary *dict );
void CUI_UserDefaultsRestoreSubviewValuesFromDictionary( id superview, NSDictionary *dict );
void CUI_UserDefaultsRestoreWindowViewValues( NSWindow *w, NSString *key );
void CUI_UserDefaultsRemoveWindowViewValues( NSWindow *w, NSString *key );


#pragma mark - public
// Class
Class UserDefaultsClass( void );

// Get values
CFTypeRef UserDefaultsObject( CFStringRef key );
BOOL UserDefaultsBool( CFStringRef key );
long UserDefaultsInteger( CFStringRef key );
double UserDefaultsDouble( CFStringRef key );
float UserDefaultsFloat( CFStringRef key );
CFURLRef UserDefaultsURL( CFStringRef key );
CFArrayRef UserDefaultsArray( CFStringRef key );
CFDictionaryRef UserDefaultsDictionary( CFStringRef key );
CFStringRef UserDefaultsString( CFStringRef key );
CFArrayRef UserDefaultsStringArray( CFStringRef key );
CFDataRef UserDefaultsData( CFStringRef key );
CFDictionaryRef UserDefaultsDictionaryRepresentation( void );

// Set values
void UserDefaultsSetObject( CFStringRef key, CFTypeRef obj );
void UserDefaultsSetBool( CFStringRef key, BOOL value );
void UserDefaultsSetInteger( CFStringRef key, long value );
void UserDefaultsSetDouble( CFStringRef key, double value );
void UserDefaultsSetFloat( CFStringRef key, float value );
void UserDefaultsSetURL( CFStringRef key, CFURLRef value );

// Remove
void UserDefaultsRemoveObject( CFStringRef key );
void UserDefaultsRemoveAll( void );

// Suites
void UserDefaultsAddSuiteNamed( CFStringRef name );
void UserDefaultsRemoveSuiteNamed( CFStringRef name );

// Register
void UserDefaultsRegisterDefaults( CFDictionaryRef defaults );

// Persistent domains
CFDictionaryRef UserDefaultsPersistentDomainForName( CFStringRef name );
void UserDefaultsSetPersistentDomainForName( CFDictionaryRef domain, CFStringRef name );
void UserDefaultsRemovePersistentDomainForName( CFStringRef name );

// Volatile domains
CFArrayRef UserDefaultsVolatileDomainNames( void );
CFDictionaryRef UserDefaultsVolatileDomainForName( CFStringRef name );
void UserDefaultsSetVolatileDomainForName( CFDictionaryRef domain, CFStringRef name );
void UserDefaultsRemoveVolatileDomainForName( CFStringRef name );

// Managed environment keys
BOOL UserDefaultsObjectIsForcedForKey( CFStringRef key );
BOOL UserDefaultsObjectIsForcedForKeyInDomain( CFStringRef key, CFStringRef domain );

// Legacy
BOOL UserDefaultsSynchronize( void );

#pragma mark - Convenience
void UserDefaultsSetValuesInDictionary( CFDictionaryRef inDict );

// Rect
CGRect UserDefaultsRect( CFStringRef key );
void UserDefaultsSetRect( CFStringRef key, CGRect r );

// Color
NSColor *UserDefaultsColor( CFStringRef key );
void UserDefaultsSetColor( CFStringRef key, NSColor *col );

// Font (stores as font descriptor)
CFTypeRef UserDefaultsFont( CFStringRef key );
void UserDefaultsSetFont( CFStringRef key, CFTypeRef font );

// URL (stores as bookmark data)
CFURLRef UserDefaultsBookmarkURL( CFStringRef key );
void UserDefaultsSetBookmarkURL( CFStringRef key, CFURLRef url );

// window view values
void UserDefaultsStoreWindowViewValues( NSInteger wndTag, CFStringRef key );
void UserDefaultsRestoreWindowViewValues( NSInteger wndTag, CFStringRef key );
void UserDefaultsRemoveWindowViewValues( NSInteger wndTag, CFStringRef key );

#pragma mark - Custom
// Dictation edit menu item
void UserDefaultsDictationMenuItemSetDisabled( BOOL flag );

// Character palette edit menu item
void UserDefaultsCharacterPaletteMenuItemSetDisabled( BOOL flag );

// MDA
void UserDefaultsSetMDA( long tag );
void UserDefaultsGetMDA( long tag );
void UserDefaultsRemoveMDA( long tag );
