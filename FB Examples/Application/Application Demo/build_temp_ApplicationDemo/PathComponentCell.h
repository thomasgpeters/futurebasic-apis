/*
 PathComponentCell.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class PathComponentCellClass( void );

// Init
NSPathComponentCell *PathComponentCellInit( void );
NSPathComponentCell *PathComponentCellWithTitle( CFStringRef title, NSImage *image, CFURLRef url );

// Image
NSImage *PathComponentCellImage( NSPathComponentCell *ref );
void PathComponentCellSetImage( NSPathComponentCell *ref, NSImage *image );

// URL
CFURLRef PathComponentCellURL( NSPathComponentCell *ref );
void PathComponentCellSetURL( NSPathComponentCell *ref, CFURLRef url );
