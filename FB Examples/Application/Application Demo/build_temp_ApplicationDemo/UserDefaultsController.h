/*
 UserDefaultsController.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class UserDefaultsControllerClass( void );

// Shared instance
NSUserDefaultsController *UserDefaultsControllerShared( void );

// Init

// Values
NSUserDefaults *UserDefaultsControllerDefaults( void );
CFDictionaryRef UserDefaultsControllerInitialValues( void );
void UserDefaultsControllerSetInitialValues( CFDictionaryRef values );
BOOL UserDefaultsControllerHasUnappliedChanges( void );
BOOL UserDefaultsControllerAppliesImmediately( void );
void UserDefaultsControllerSetAppliesImmediately( BOOL flag );
CFTypeRef UserDefaultsControllerValues( void );
void UserDefaultsControllerRevert( void );
void UserDefaultsControllerRevertToInitialValues( void );
void UserDefaultsControllerSave( void );

// Convenience
void UserDefaultsControllerValuesSetValueForKey( CFTypeRef value, CFStringRef key );
