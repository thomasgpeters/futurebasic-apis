/*
 PathComponentCell.m

 Bernie Wylde
 */

#import "PathComponentCell.h"

// Class
Class PathComponentCellClass( void )
{ return [NSPathComponentCell class]; }

// Init
NSPathComponentCell *PathComponentCellInit( void )
{
#if __has_feature(objc_arc)
    return [[NSPathComponentCell alloc] init];
#else
    return [[[NSPathComponentCell alloc] init] autorelease];
#endif
}

NSPathComponentCell *PathComponentCellWithTitle( CFStringRef title, NSImage *image, CFURLRef url )
{
#if __has_feature(objc_arc)
    NSPathComponentCell *cell = [[NSPathComponentCell alloc] init];
#else
    NSPathComponentCell *cell = [[[NSPathComponentCell alloc] init] autorelease];
#endif
    if ( title ) [cell setTitle:(__bridge NSString *)title];
    if ( image ) [cell setImage:image];
    if ( url ) [cell setURL:(__bridge NSURL *)url];
    return cell;
}

// Image
NSImage *PathComponentCellImage( NSPathComponentCell *ref )
{ return [ref image]; }

void PathComponentCellSetImage( NSPathComponentCell *ref, NSImage *image )
{ [ref setImage:image]; }

// URL
CFURLRef PathComponentCellURL( NSPathComponentCell *ref )
{ return (__bridge CFURLRef)[ref URL]; }

void PathComponentCellSetURL( NSPathComponentCell *ref, CFURLRef url )
{ [ref setURL:(__bridge NSURL *)url]; }

