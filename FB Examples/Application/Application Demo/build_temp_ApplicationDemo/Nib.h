/*
 Nib.h

 Bernie Wylde
 */

#import "Control.h"
#import "Menu.h"
#import "Popover.h"
#import "Toolbar.h"
#import "View.h"
#import "Window.h"

#pragma mark - nibs
enum {// 20200219
    objectTypeNib = 0,
    objectTypeStoryboard
};

@interface CUI_NibObject : NSObject
@property (nonatomic,assign) NSInteger fileType;// 20200219
@property (nonatomic,retain) NSString *nibName;
@property (nonatomic,retain) NSArray *topLevelObjects;
@property (nonatomic,retain) id initialController;// 20200219

- (id)initWithType:(NSInteger)type name:(NSString *)name objects:(NSArray *)objects controller:(id)controller;// 20200219
@end

CUI_NibObject *CUI_NibObjectWithName( NSString *name );

void CUI_NibObjectAdd( NSInteger type, NSString *name, NSArray *objects, id controller );// 20200219

void CUI_NibObjectRemove( NSString *name );// 20240131
NSArray *CUI_NibObjects( NSString *name );

void CUI_ProcessViewMenu( NSMenu *menu );// 20200630
void CUI_ProcessMenuForView( NSView *view );// 20200619

void CUI_NibViewSetup( NSInteger wndTag, NSView *superview );
void CUI_NibWindowToolbarItemSetup( NSInteger wndTag, NSToolbar *toolbar );
void CUI_NibWindowToolbarSetup( NSInteger wndTag );

void CUI_WindowConfigureViews( NSInteger tag, NSWindow *w );

id CUI_WindowFromNibObjects( NSInteger tag, NSString *nibName, NSString *wndIdentifier );

void CUI_ViewFromNibObjects( NSInteger tag, NSString *nibName, NSString *viewIdentifier, NSPoint origin, NSView *superview );
NSView *CUI_ViewFromNibObjects2( NSInteger tag, NSString *nibName, NSString *viewIdentifier );

#pragma mark - nibpopover
void CUI_PopoverFromNibObjects( NSInteger tag, NSString *nibName );
void CUI_NibPopover( NSInteger inTag, CFStringRef inNibName );

#pragma mark - nibtoolbar
void CUI_ToolbarFromNibObjects( NSInteger tag, NSString *nibName );
void CUI_NibToolbar( NSInteger inTag, CFStringRef inNibName );

#pragma mark - nibview
void CUI_NibView( NSInteger inTag, CFStringRef inNibName, CFStringRef inViewIdentifier, CGPoint inOrigin, NSInteger inSuperviewTag );
id CUI_NibViewFunction( NSInteger inTag, CFStringRef inNibName, CFStringRef inViewIdentifier );

#pragma mark - nib <everything>
void CUI_Nib( CFStringRef inNibName );


// Class
Class NibClass( void );

