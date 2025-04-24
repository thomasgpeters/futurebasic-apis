/*
 ViewController.m

 Bernie Wylde
 */

#import "ViewController.h"

// Class
Class ViewControllerClass( void )
{ return [NSViewController class]; }

// - init -
NSViewController *ViewControllerInit( void )
{
#if __has_feature(objc_arc)
    return [[NSViewController alloc] init];
#else
    return [[[NSViewController alloc] init] autorelease];
#endif
}

// Represented object
CFTypeRef ViewControllerRepresentedObject( NSViewController *ref )
{ return (__bridge CFTypeRef)[ref representedObject]; }

void ViewControllerSetRepresentedObject( NSViewController *ref, CFTypeRef obj )
{ [ref setRepresentedObject:(__bridge id)obj]; }

// Nib properties
NSBundle *ViewControllerNibBundle( NSViewController *ref )
{ return [ref nibBundle]; }

CFStringRef ViewControllerNibName( NSViewController *ref )
{ return (__bridge CFStringRef)[ref nibName]; }

// - view properties -
NSView *ViewControllerView( NSViewController *ref )
{ return [ref view]; }

void ViewControllerSetView( NSViewController *ref, NSInteger vwTag )
{
    NSView *view = ViewWithTag( vwTag );
    if ( view ) [ref setView:view];
}

CFStringRef ViewControllerTitle( NSViewController *ref )
{ return (__bridge CFStringRef)[ref title]; }

void ViewControllerSetTitle( NSViewController *ref, CFStringRef title )
{ [ref setTitle:(__bridge NSString *)title]; }

// Storyboard
NSStoryboard *ViewControllerStoryboard( NSViewController *ref )
{ return [ref storyboard]; }

// View layout
CGSize ViewControllerPreferredContentSize( NSViewController *ref )
{ return NSSizeToCGSize([ref preferredContentSize]); }

void ViewControllerSetPreferredContentSize( NSViewController *ref, CGSize size )
{ [ref setPreferredContentSize:NSSizeFromCGSize(size)]; }

