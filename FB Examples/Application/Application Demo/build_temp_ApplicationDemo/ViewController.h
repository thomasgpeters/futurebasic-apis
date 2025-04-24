/*
 ViewController.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "View.h"

// Class
Class ViewControllerClass( void );

// - init -
NSViewController *ViewControllerInit( void );

// Represented object
CFTypeRef ViewControllerRepresentedObject( NSViewController *ref );
void ViewControllerSetRepresentedObject( NSViewController *ref, CFTypeRef obj );

// Nib properties
NSBundle *ViewControllerNibBundle( NSViewController *ref );
CFStringRef ViewControllerNibName( NSViewController *ref );

// - view properties -
NSView *ViewControllerView( NSViewController *ref );
void ViewControllerSetView( NSViewController *ref, NSInteger vwTag );
CFStringRef ViewControllerTitle( NSViewController *ref );
void ViewControllerSetTitle( NSViewController *ref, CFStringRef title );

// Storyboard
NSStoryboard *ViewControllerStoryboard( NSViewController *ref );

// View layout
CGSize ViewControllerPreferredContentSize( NSViewController *ref );
void ViewControllerSetPreferredContentSize( NSViewController *ref, CGSize size );

