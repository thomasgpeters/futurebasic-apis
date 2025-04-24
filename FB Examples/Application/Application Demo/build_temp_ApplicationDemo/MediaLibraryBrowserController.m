/*
 MediaLibraryBrowserController.m

 Bernie Wylde
 */

#import "MediaLibraryBrowserController.h"

// Class
Class MediaLibraryBrowserControllerClass( void )
{ return [NSMediaLibraryBrowserController class]; }

// Create
NSMediaLibraryBrowserController *MediaLibraryBrowserControllerShared( void )
{ return [NSMediaLibraryBrowserController sharedMediaLibraryBrowserController]; }

// Display
CGRect MediaLibraryBrowserControllerFrame( void )
{ return NSRectToCGRect([[NSMediaLibraryBrowserController sharedMediaLibraryBrowserController] frame]); }

void MediaLibraryBrowserControllerSetFrame( CGRect r )
{ [[NSMediaLibraryBrowserController sharedMediaLibraryBrowserController] setFrame:NSRectFromCGRect(r)]; }

void MediaLibraryBrowserControllerTogglePanel( void )
{ [[NSMediaLibraryBrowserController sharedMediaLibraryBrowserController] togglePanel:nil]; }

BOOL MediaLibraryBrowserControllerIsVisible( void )
{ return [[NSMediaLibraryBrowserController sharedMediaLibraryBrowserController] isVisible]; }

void MediaLibraryBrowserControllerSetVisible( BOOL flag )
{ [[NSMediaLibraryBrowserController sharedMediaLibraryBrowserController] setVisible:flag]; }

// Library types
NSMediaLibrary MediaLibraryBrowserControllerMediaLibraries( void )
{ return [[NSMediaLibraryBrowserController sharedMediaLibraryBrowserController] mediaLibraries]; }

void MediaLibraryBrowserControllerSetMediaLibraries( NSMediaLibrary libs )
{ [[NSMediaLibraryBrowserController sharedMediaLibraryBrowserController] setMediaLibraries:libs]; }

