/*
 SegmentedControl.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "Menu.h"
//#import "View.h"
//#import "Window.h"

@interface SegmentedControlSC : NSSegmentedControl
@end

@interface CUI_SegmentedControlTarget : NSObject
@end

// Class
Class SegmentedControlClass( void );

NSSegmentedControl *SegmentedControlWithTag( NSInteger tag );
BOOL SegmentedControlExists( NSInteger tag );

// Behavior
NSSegmentSwitchTracking SegmentedControlTrackingMode( NSInteger tag );
void SegmentedControlSetTrackingMode( NSInteger tag, NSSegmentSwitchTracking mode );
NSSegmentStyle SegmentedControlStyle( NSInteger tag );
void SegmentedControlSetStyle( NSInteger tag, NSSegmentStyle style );

// Number of segments
NSInteger SegmentedControlSegmentCount( NSInteger tag );
void SegmentedControlSetSegmentCount( NSInteger tag, NSInteger count );

// Text
CFStringRef SegmentedControlLabelForSegment( NSInteger tag, NSInteger index );
void SegmentedControlSetSegmentLabel( NSInteger tag, NSInteger index, CFStringRef string );
NSTextAlignment SegmentedControlSegmentAlignment( NSInteger tag, NSInteger index );
void SegmentedControlSetSegmentAlignment( NSInteger tag, NSInteger index, NSTextAlignment value );

// Image
NSImage *SegmentedControlImageForSegment( NSInteger tag, NSInteger index );
void SegmentedControlSetSegmentImage( NSInteger tag, NSInteger index, NSImage *image );
NSImageScaling SegmentedControlImageScaling( NSInteger tag, NSInteger index );
void SegmentedControlSetImageScaling( NSInteger tag, NSInteger index, NSImageScaling scaling );

// Menu
NSMenu *SegmentedControlMenuForSegment( NSInteger tag, NSInteger index );
void SegmentedControlSetSegmentMenu( NSInteger tag, NSInteger index, NSMenu *menu );
void SegmentedControlSetSegmentMenuIndex( NSInteger tag, NSInteger index, NSInteger menuIndex );
BOOL SegmentedControlSegmentShowsMenuIndicator( NSInteger tag, NSInteger index );
void SegmentedControlSetSegmentShowsMenuIndicator( NSInteger tag, NSInteger index, BOOL flag );
BOOL SegmentedControlIsSpringLoaded( NSInteger tag );
void SegmentedControlSetSpringLoaded( NSInteger tag, BOOL flag );

// Selected segment
NSInteger SegmentedControlSelectedSegment( NSInteger tag );
NSInteger SegmentedControlIndexOfSelectedItem( NSInteger tag );
BOOL SegmentedControlSelectSegmentWithTag( NSInteger ctrlTag, NSInteger segTag );
void SegmentedControlSetSegmentSelected( NSInteger tag, NSInteger index, BOOL flag );
BOOL SegmentedControlIsSegmentSelected( NSInteger tag, NSInteger index );
NSColor *SegmentedControlSelectedSegmentBezelColor( NSInteger tag );
void SegmentedControlSetSelectedSegmentBezelColor( NSInteger tag, NSColor *col );
double SegmentedControlDoubleValueForSelectedSegment( NSInteger tag );

// Spacing
CGFloat SegmentedControlSegmentWidth( NSInteger tag, NSInteger index );
void SegmentedControlSetSegmentWidth( NSInteger tag, NSInteger index, CGFloat value );
void SegmentedControlSetSegmentDistribution( NSInteger tag, NSSegmentDistribution value );

// Enable
void SegmentedControlSetSegmentEnabled( NSInteger tag, NSInteger index, BOOL flag );
BOOL SegmentedControlIsSegmentEnabled( NSInteger tag, NSInteger index );

// Tags and tooltips
NSInteger SegmentedControlSegmentTag( NSInteger tag, NSInteger index );
void SegmentedControlSetSegmentTag( NSInteger tag, NSInteger index, NSInteger segTag );
CFStringRef SegmentedControlSegmentToolTip( NSInteger tag, NSInteger index );
void SegmentedControlSetSegmentToolTip( NSInteger tag, NSInteger index, CFStringRef string );

// Convenience
void SegmentedControlSetSegment( NSInteger tag, NSInteger index, NSInteger enabled, CFStringRef label, NSImage *image, NSUInteger imageScaling, NSInteger width );



// Init
NSSegmentedControl *SegmentedControlInit( NSInteger inTag, CGRect inRect );

// Statement
void CUI_SegmentedControl( NSInteger inTag, NSInteger inEnabled, NSInteger inIndex, CGRect inRect, NSInteger inSegments, NSInteger inWndTag );

