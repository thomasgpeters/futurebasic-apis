/*
 WindowController.m

 Bernie Wylde
 */

#import "WindowController.h"

// Class
Class WindowControllerClass( void )
{ return [NSWindowController class]; }

// Init
NSWindowController *WindowControllerWithWindow( NSInteger wndTag )
{
    NSWindow *w = CUI_WindowWithTag(wndTag);
    if ( w ) {
#if __has_feature(objc_arc)
        return [[NSWindowController alloc] initWithWindow:w];
#else
        return [[[NSWindowController alloc] initWithWindow:w] autorelease];
#endif
    }
    return nil;
}

// Load and display window
void WindowControllerShowWindow( NSWindowController *ref )
{ [ref showWindow:nil]; }

NSInteger WindowControllerWindow( NSWindowController *ref )
{
    NSWindow *w = [ref window];
    if ( w ) return [w tag];
    return 0;
}

void WindowControllerSetWindow( NSWindowController *ref, NSInteger wndTag )
{
    NSWindow *w = CUI_WindowWithTag(wndTag);
    if ( w ) [ref setWindow:w];
}

// Closing window
void WindowControllerClose( NSWindowController *ref )
{ [ref close]; }

// Nib and storyboard info
NSStoryboard *WindowControllerStoryboard( NSWindowController *ref )
{ return [ref storyboard]; }
