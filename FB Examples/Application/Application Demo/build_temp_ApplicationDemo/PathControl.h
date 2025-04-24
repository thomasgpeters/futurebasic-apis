/*
 PathControl.h

 Bernie Wylde
 */



//#import "Control.h"
//#import "DialogEvent.h"
//#import "Menu.h"
//#import "View.h"
//#import "Window.h"

@interface PathControlSC : NSPathControl
@end

// dialog events
enum {
    //pathControlShouldDragPathComponentCell = 4400,
    pathControlValidateDrop = 4400,
    pathControlAcceptDrop,
    pathControlWillDisplayOpenPanel,
    pathControlWillPopUpMenu,
    pathControlShouldDragItem,
    pathControlDoubleAction
};

@interface CUI_PathControlDelegate : NSObject <NSPathControlDelegate>
@end

CUI_PathControlDelegate *CUI_PathControlDelegateObj( void );

// Class
Class PathControlClass( void );

NSPathControl *PathControlWithTag( NSInteger tag );
BOOL PathControlExists( NSInteger tag );

// Style
NSPathStyle PathControlStyle( NSInteger tag );
void PathControlSetStyle( NSInteger tag, NSPathStyle style );

// Background color
NSColor *PathControlBackgroundColor( NSInteger tag );
void PathControlSetBackgroundColor( NSInteger tag, NSColor *col );

// Components
NSPathComponentCell *PathControlClickedPathComponentCell( NSInteger tag );
CFArrayRef PathControlPathComponentCells( NSInteger tag );
void PathControlSetPathComponentCells( NSInteger tag, CFArrayRef comps );

// Path
CFURLRef PathControlURL( NSInteger tag );
void PathControlSetURL( NSInteger tag, CFURLRef url );

// Delegate
//void PathControlSetDelegate( NSInteger tag, BOOL flag );

// Menu
NSMenu *PathControlMenu( NSInteger tag );
void PathControlSetMenu( NSInteger tag, NSInteger menuIndex );
NSInteger PathControlMenuIndex( NSInteger tag );

// Instance properties
CFArrayRef PathControlAllowedTypes( NSInteger tag );
void PathControlSetAllowedTypes( NSInteger tag, CFArrayRef types );

NSPathControlItem *PathControlClickedPathItem( NSInteger tag );

BOOL PathControlIsEditable( NSInteger tag );
void PathControlSetEditable( NSInteger tag, BOOL flag );

CFArrayRef PathControlPathItems( NSInteger tag );
void PathControlSetPathItems( NSInteger tag, CFArrayRef items );

CFAttributedStringRef PathControlPlaceholderAttributedString( NSInteger tag );
void PathControlSetPlaceholderAttributedString( NSInteger tag, CFAttributedStringRef aString );
CFStringRef PathControlPlaceholderString( NSInteger tag );
void PathControlSetPlaceholderString( NSInteger tag, CFStringRef string );


// Init
NSPathControl *PathControlInit( NSInteger inTag, CGRect inRect );

#pragma mark - pathcontrol statement
void CUI_PathControl( NSInteger inTag, NSInteger inEnabled, CFURLRef inURL, CGRect inRect, NSInteger inStyle, NSInteger inWndTag );
