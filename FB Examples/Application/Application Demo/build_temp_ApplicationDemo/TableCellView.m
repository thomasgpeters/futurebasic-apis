/*
 TableCellView.m

 Bernie Wylde
 */

#import "TableCellView.h"

// Class
Class TableCellViewClass( void )
{ return [NSTableCellView class]; }

// Represented object
CFTypeRef TableCellViewObjectValue( NSTableCellView *ref )
{ return (__bridge CFTypeRef)[ref objectValue]; }

void TableCellViewSetObjectValue( NSTableCellView *ref, CFTypeRef obj )
{ [ref setObjectValue:(__bridge id)obj]; }

// Displayed items
NSImageView *TableCellViewImageView( NSTableCellView *ref )
{ return [ref imageView]; }

void TableCellViewSetImageView( NSTableCellView *ref, NSImageView *imgViewRef )
{ [ref setImageView:imgViewRef]; }

NSTextField *TableCellViewTextField( NSTableCellView *ref )
{ return [ref textField]; }

void TableCellViewSetTextField( NSTableCellView *ref, NSTextField *txtFldRef )
{ [ref setTextField:txtFldRef]; }

// Background style
NSBackgroundStyle TableCellViewBackgroundStyle( NSTableCellView *ref )
{ return [ref backgroundStyle]; }

void TableCellViewSetBackgroundStyle( NSTableCellView *ref, NSBackgroundStyle style )
{ [ref setBackgroundStyle:style]; }

// Row size style
NSTableViewRowSizeStyle TableCellViewRowSizeStyle( NSTableCellView *ref )
{ return [ref rowSizeStyle]; }

void TableCellViewSetRowSizeStyle( NSTableCellView *ref, NSTableViewRowSizeStyle style )
{ [ref setRowSizeStyle:style]; }

// Dragging images
CFArrayRef TableCellViewDraggingImageComponents( NSTableCellView *ref )
{ return (__bridge CFArrayRef)[ref draggingImageComponents]; }

// Convenience
void TableCellViewTextFieldSetString( NSTableCellView *ref, CFStringRef string )
{ [[ref textField] setStringValue:(__bridge NSString *)string]; }

void TableCellViewImageViewSetImage( NSTableCellView *ref, NSImage *image )
{ [[ref imageView] setImage:image]; }
