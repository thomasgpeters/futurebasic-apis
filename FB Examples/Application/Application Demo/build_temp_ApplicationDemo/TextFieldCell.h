/*
 TextFieldCell.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "DialogEvent.h"

@interface TextFieldCellSC : NSTextFieldCell
@end

@interface CUI_TextFieldCellEvent : NSObject
@property (nonatomic,retain) NSColor *textColorObj;
@end

// dialog events
enum {
    textFieldCellTextColor = 4300
};

CUI_TextFieldCellEvent *CUI_TextFieldCellEventObj( void );


NSColor *TextFieldCellEventTextColor( void );
void TextFieldCellEventSetTextColor( NSColor *col );

// Class
Class TextFieldCellClass( void );
