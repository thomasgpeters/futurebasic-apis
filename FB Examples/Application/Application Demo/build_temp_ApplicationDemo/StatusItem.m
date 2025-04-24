/*
 StatusItem.m

 Bernie Wylde
 */

#import "StatusItem.h"

// Class
Class StatusItemClass( void )
{ return [NSStatusItem class]; }

// - status bar -
NSStatusBar *StatusItemStatusBar( NSStatusItem *ref )
{ return [ref statusBar]; }

// - behavior -
NSStatusBarButton *StatusItemButton( NSStatusItem *ref )
{ return [ref button]; }

NSMenu *StatusItemMenu( NSStatusItem *ref )
{ return [ref menu]; }

void StatusItemSetMenu( NSStatusItem *ref, NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) [ref setMenu:menu];
}

// - appearance -
CGFloat StatusItemLength( NSStatusItem *ref )
{ return [ref length]; }

void StatusItemSetLength( NSStatusItem *ref, CGFloat length )
{ [ref setLength:length]; }

// - instance properties -
CFStringRef StatusItemAutosaveName( NSStatusItem *ref )
{ return (__bridge CFStringRef)[ref autosaveName]; }

void StatusItemSetAutosaveName( NSStatusItem *ref, CFStringRef name )
{ [ref setAutosaveName:(__bridge NSString *)name]; }

NSStatusItemBehavior StatusItemBehavior( NSStatusItem *ref )
{ return [ref behavior]; }

void StatusItemSetBehavior( NSStatusItem *ref, NSStatusItemBehavior behavior )
{ [ref setBehavior:behavior]; }

BOOL StatusItemIsVisible( NSStatusItem *ref )
{ return [ref isVisible]; }

void StatusItemSetVisible( NSStatusItem *ref, BOOL flag )
{ [ref setVisible:flag]; }

// - convenience -
void StatusItemButtonSetImage( NSStatusItem *ref, NSImage *image )
{ [[ref button] setImage:image]; }

BOOL StatusItemButtonAppearsDisabled( NSStatusItem *ref )
{ return [[ref button] appearsDisabled]; }

void StatusItemButtonSetAppearsDisabled( NSStatusItem *ref, BOOL flag )
{ [[ref button] setAppearsDisabled:flag]; }

void StatusItemButtonSetActionCallback( NSStatusItem *ref, CUI_StatusBarButtonCallbackType callback, void *userData )
{
#if __has_feature(objc_arc)
    CUI_StatusBarButtonTarget *target = [[CUI_StatusBarButtonTarget alloc] init];
#else
    CUI_StatusBarButtonTarget *target = [[[CUI_StatusBarButtonTarget alloc] init] autorelease];
#endif
    target.callback = callback;
    target.userData = userData;
    [[ref button] setTarget:target];
    [[ref button] setAction:@selector(action:)];
}

