/*
 PathControlItem.h

 Bernie Wylde
 */




// Class
Class PathControlItemClass( void );

// Init
NSPathControlItem *PathControlItemInit( void );

// Instance properties
CFURLRef PathControlItemURL( NSPathControlItem *ref );
CFAttributedStringRef PathControlItemAttributedTitle( NSPathControlItem *ref );
void PathControlItemSetAttributedTitle( NSPathControlItem *ref, CFAttributedStringRef aString );
NSImage *PathControlItemImage( NSPathControlItem *ref );
void PathControlItemSetImage( NSPathControlItem *ref, NSImage *image );
CFStringRef PathControlItemTitle( NSPathControlItem *ref );
void PathControlItemSetTitle( NSPathControlItem *ref, CFStringRef string );

