/*
 MediaLibraryBrowserController.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class MediaLibraryBrowserControllerClass( void );

// Create
NSMediaLibraryBrowserController *MediaLibraryBrowserControllerShared( void );

// Display
CGRect MediaLibraryBrowserControllerFrame( void );
void MediaLibraryBrowserControllerSetFrame( CGRect r );
void MediaLibraryBrowserControllerTogglePanel( void );
BOOL MediaLibraryBrowserControllerIsVisible( void );
void MediaLibraryBrowserControllerSetVisible( BOOL flag );

// Library types
NSMediaLibrary MediaLibraryBrowserControllerMediaLibraries( void );
void MediaLibraryBrowserControllerSetMediaLibraries( NSMediaLibrary libs );

