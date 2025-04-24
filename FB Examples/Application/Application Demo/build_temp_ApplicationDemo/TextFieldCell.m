/*
 TextFieldCell.m

 Bernie Wylde
 */

#import "TextFieldCell.h"

@implementation TextFieldCellSC
- (NSColor *)textColor {
    TextFieldCellEventSetTextColor( [self textColor] );
    CallUserDefinedOnDialogFunction( textFieldCellTextColor, 0, 0, (__bridge CFTypeRef)self );
    return TextFieldCellEventTextColor();
}
@end



@implementation CUI_TextFieldCellEvent

#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.textColorObj release];
    [super dealloc];
}
#endif
@end

CUI_TextFieldCellEvent *CUI_TextFieldCellEventObj( void )
{
    static CUI_TextFieldCellEvent *sCUI_TextFieldCellEvent = nil;
    if ( !sCUI_TextFieldCellEvent ) sCUI_TextFieldCellEvent = [[CUI_TextFieldCellEvent alloc] init];
    return sCUI_TextFieldCellEvent;
}

NSColor *TextFieldCellEventTextColor( void )
{
    CUI_TextFieldCellEvent *obj = CUI_TextFieldCellEventObj();
    return [obj textColorObj];
}

void TextFieldCellEventSetTextColor( NSColor *col )
{
    CUI_TextFieldCellEvent *obj = CUI_TextFieldCellEventObj();
    [obj setTextColorObj:col];
}

// Class
Class TextFieldCellClass( void )
{ return [NSTextFieldCell class]; }
