/*
 ColorList.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class ColorListClass( void );

// Init
NSColorList *ColorListWithName( CFStringRef name );
NSColorList *ColorListFromFileAtURL( CFStringRef name, CFURLRef url );

// Lists
CFArrayRef ColorListAvailableColorLists( void );
NSColorList *ColorListNamed( CFStringRef name );

// Properties
CFStringRef ColorListName( NSColorList *ref );
BOOL ColorListIsEditable( NSColorList *ref );

// Managing colors
CFArrayRef ColorListAllKeys( NSColorList *ref );
NSColor *ColorListColorWithKey( NSColorList *ref, CFStringRef key );
void ColorListInsertColor( NSColorList *ref, NSColor *col, CFStringRef key, NSUInteger index );
void ColorListRemoveColorWithKey( NSColorList *ref, CFStringRef key );
void ColorListSetColor( NSColorList *ref, NSColor *col, CFStringRef key );

// Write and remove ColorList files
void ColorListRemoveFile( NSColorList *ref );
BOOL ColorListWriteToURL( NSColorList *ref, CFURLRef url, NSError **err );

// Custom
NSColorList *ColorListByAddingColor( NSColorList *ref, NSColor *col, CFStringRef key );
NSColorList *ColorListByAddingColorList( NSColorList *cl1, NSColorList *cl2 );
