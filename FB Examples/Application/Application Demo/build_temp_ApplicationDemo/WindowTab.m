/*
 WindowTab.m

 Bernie Wylde
 */

#import "WindowTab.h"

// Class
Class WindowTabClass( void )
{ return [NSWindowTab class]; }

NSInteger WindowTabAccessoryView( NSWindowTab *ref )
{
    NSView *view = [ref accessoryView];
    if ( view ) return [view tag];
    return 0;
}

void WindowTabSetAccessoryView( NSWindowTab *ref, NSInteger tag )
{
    NSView *view = ViewWithTag( tag );
    if ( view ) [ref setAccessoryView:view];
}

CFAttributedStringRef WindowTabAttributedTitle( NSWindowTab *ref )
{ return (__bridge CFAttributedStringRef)[ref attributedTitle]; }

void WindowTabSetAttributedTitle( NSWindowTab *ref, CFAttributedStringRef aString )
{ [ref setAttributedTitle:(__bridge NSAttributedString *)aString]; }

CFStringRef WindowTabTitle( NSWindowTab *ref )
{ return (__bridge CFStringRef)[ref title]; }

void WindowTabSetTitle( NSWindowTab *ref, CFStringRef title )
{ [ref setTitle:(__bridge NSString *)title]; }

CFStringRef WindowTabToolTip( NSWindowTab *ref )
{ return (__bridge CFStringRef)[ref toolTip]; }

void WindowTabSetToolTip( NSWindowTab *ref, CFStringRef toolTip )
{ [ref setToolTip:(__bridge NSString *)toolTip]; }

