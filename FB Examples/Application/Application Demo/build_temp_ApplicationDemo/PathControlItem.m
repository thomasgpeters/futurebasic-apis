/*
 PathControlItem.m

 Bernie Wylde
 */

#import "PathControlItem.h"


// Class
Class PathControlItemClass( void )
{ return [NSPathControlItem class]; }

// Init
NSPathControlItem *PathControlItemInit( void )
{
#if __has_feature(objc_arc)
    return [[NSPathControlItem alloc] init];
#else
    return [[[NSPathControlItem alloc] init] autorelease];
#endif
}

// Instance properties
CFURLRef PathControlItemURL( NSPathControlItem *ref )
{ return (__bridge CFURLRef)[ref URL]; }

CFAttributedStringRef PathControlItemAttributedTitle( NSPathControlItem *ref )
{ return (__bridge CFAttributedStringRef)[ref attributedTitle]; }

void PathControlItemSetAttributedTitle( NSPathControlItem *ref, CFAttributedStringRef aString )
{ [ref setAttributedTitle:(__bridge NSAttributedString *)aString]; }

NSImage *PathControlItemImage( NSPathControlItem *ref )
{ return [ref image]; }

void PathControlItemSetImage( NSPathControlItem *ref, NSImage *image )
{ [ref setImage:image]; }

CFStringRef PathControlItemTitle( NSPathControlItem *ref )
{ return (__bridge CFStringRef)[ref title]; }

void PathControlItemSetTitle( NSPathControlItem *ref, CFStringRef string )
{ [ref setTitle:(__bridge NSString *)string]; }

