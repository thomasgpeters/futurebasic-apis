/*
 TableHeaderCell.h

 Bernie Wylde
 */

#import "CocoaUI.h"

@interface TableHeaderCellSC : NSTableHeaderCell
@property (nonatomic,retain) NSString *columnIdentifier;
@property (nonatomic,strong) NSFont *fontProp;
@property (nonatomic,retain) NSColor *textColorProp;
@end

// Class
Class TableHeaderCellClass( void );

// Create
NSTableHeaderCell *TableHeaderCellInit( void );

// Custom
CFStringRef TableHeaderCellColumnIdentifier( NSTableHeaderCell *ref );

