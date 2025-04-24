/*
 TableCellView.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class TableCellViewClass( void );

// Represented object
CFTypeRef TableCellViewObjectValue( NSTableCellView *ref );
void TableCellViewSetObjectValue( NSTableCellView *ref, CFTypeRef obj );

// Displayed items
NSImageView *TableCellViewImageView( NSTableCellView *ref );
void TableCellViewSetImageView( NSTableCellView *ref, NSImageView *imgViewRef );
NSTextField *TableCellViewTextField( NSTableCellView *ref );
void TableCellViewSetTextField( NSTableCellView *ref, NSTextField *txtFldRef );

// Background style
NSBackgroundStyle TableCellViewBackgroundStyle( NSTableCellView *ref );
void TableCellViewSetBackgroundStyle( NSTableCellView *ref, NSBackgroundStyle style );

// Row size style
NSTableViewRowSizeStyle TableCellViewRowSizeStyle( NSTableCellView *ref );
void TableCellViewSetRowSizeStyle( NSTableCellView *ref, NSTableViewRowSizeStyle style );

// Dragging images
CFArrayRef TableCellViewDraggingImageComponents( NSTableCellView *ref );

// Convenience
void TableCellViewTextFieldSetString( NSTableCellView *ref, CFStringRef string );
void TableCellViewImageViewSetImage( NSTableCellView *ref, NSImage *image );
