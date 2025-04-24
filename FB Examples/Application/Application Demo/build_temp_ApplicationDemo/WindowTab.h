/*
 WindowTab.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "View.h"


// Class
Class WindowTabClass( void );

NSInteger WindowTabAccessoryView( NSWindowTab *ref );
void WindowTabSetAccessoryView( NSWindowTab *ref, NSInteger tag );
CFAttributedStringRef WindowTabAttributedTitle( NSWindowTab *ref );
void WindowTabSetAttributedTitle( NSWindowTab *ref, CFAttributedStringRef aString );
CFStringRef WindowTabTitle( NSWindowTab *ref );
void WindowTabSetTitle( NSWindowTab *ref, CFStringRef title );
CFStringRef WindowTabToolTip( NSWindowTab *ref );
void WindowTabSetToolTip( NSWindowTab *ref, CFStringRef toolTip );

