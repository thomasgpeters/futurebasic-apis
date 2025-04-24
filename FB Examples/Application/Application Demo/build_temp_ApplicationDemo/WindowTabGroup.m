/*
 WindowTabGroup.m

 Bernie Wylde
 */

#import "WindowTabGroup.h"


// Class
Class WindowTabGroupClass( void )
{ return [NSWindowTabGroup class]; }

CFStringRef WindowTabGroupIdentifier( NSWindowTabGroup *ref )
{ return (__bridge CFStringRef)[ref identifier]; }

BOOL WindowTabGroupIsOverviewVisible( NSWindowTabGroup *ref )
{ return [ref isOverviewVisible]; }

void WindowTabGroupSetOverviewVisible( NSWindowTabGroup *ref, BOOL flag )
{ [ref setOverviewVisible:flag]; }

BOOL WindowTabGroupIsTabBarVisible( NSWindowTabGroup *ref )
{ return [ref isTabBarVisible]; }

NSInteger WindowTabGroupSelectedWindow( NSWindowTabGroup *ref )
{
    NSWindow *w = [ref selectedWindow];
    if ( w ) return [w tag];
    return 0;
}

void WindowTabGroupSetSelectedWindow( NSWindowTabGroup *ref, NSInteger tag )
{
    NSWindow *w = WindowWithTag( tag );
    if ( w ) [ref setSelectedWindow:w];
}

CFArrayRef WindowTabGroupWindows( NSWindowTabGroup *ref )
{
    NSArray *windows = [ref windows];
    if ( windows ) {
        NSMutableArray *tagsArray = [NSMutableArray arrayWithCapacity:0];
        for ( NSWindow *w in windows ) {
            NSInteger tag = [w tag];
            if ( tag ) [tagsArray addObject:[NSNumber numberWithInteger:tag]];
        }
        return (__bridge CFArrayRef)tagsArray;
    }
    return nil;
}

void WindowTabGroupAddWindow( NSWindowTabGroup *ref, NSInteger tag )
{
    NSWindow *w = WindowWithTag( tag );
    if ( w ) {
        [ref addWindow:w];
    }
}

void WindowTabGroupInsertWindow( NSWindowTabGroup *ref, NSInteger tag, NSInteger index )
{
    NSWindow *w = WindowWithTag( tag );
    if ( w ) {
        [ref insertWindow:w atIndex:index];
    }
}

void WindowTabGroupRemoveWindow( NSWindowTabGroup *ref, NSInteger tag )
{
    NSWindow *w = WindowWithTag( tag );
    if ( w ) {
        [ref removeWindow:w];
    }
}

