/*
 WindowController.h

 Bernie Wylde
*/


#import "CocoaUI.h"

//#import "Window.h"

// dialog events
enum {
    windowControllerWindowWillLoad = 10100,
    windowControllerWindowDidLoad
};

// Class
Class WindowControllerClass( void );

// Init
NSWindowController *WindowControllerWithWindow( NSInteger wndTag );

// Load and display window
void WindowControllerShowWindow( NSWindowController *ref );
NSInteger WindowControllerWindow( NSWindowController *ref );
void WindowControllerSetWindow( NSWindowController *ref, NSInteger wndTag );

// Closing window
void WindowControllerClose( NSWindowController *ref );

// Nib and storyboard info
NSStoryboard *WindowControllerStoryboard( NSWindowController *ref );
