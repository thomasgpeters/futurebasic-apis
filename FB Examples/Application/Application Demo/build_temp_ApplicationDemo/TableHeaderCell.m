/*
 TableHeaderCell.m

 Bernie Wylde
 */

#import "TableHeaderCell.h"

@implementation TableHeaderCellSC

#if !__has_feature(objc_arc)
- (void)dealloc {
    [super dealloc];
}
#endif

- (NSFont *)font {
    CellEventSetFont( self.fontProp );
    CallUserDefinedOnDialogFunction( cellFont, 0, 0, (__bridge CFTypeRef)self );
    return CellEventFont();
}

- (NSColor *)textColor {
    TextFieldCellEventSetTextColor( self.textColorProp );
    CallUserDefinedOnDialogFunction( textFieldCellTextColor, 0, 0, (__bridge CFTypeRef)self );
    return TextFieldCellEventTextColor();
}

@end

// Class
Class TableHeaderCellClass( void )
{ return [NSTableHeaderCell class]; }

// Create
NSTableHeaderCell *TableHeaderCellInit( void )
{
#if __has_feature(objc_arc)
    return [[TableHeaderCellSC alloc] init];
#else
    return [[[TableHeaderCellSC alloc] init] autorelease];
#endif
}

// Custom
CFStringRef TableHeaderCellColumnIdentifier( NSTableHeaderCell *ref )
{ return (__bridge CFStringRef)[(TableHeaderCellSC *)ref columnIdentifier]; }
