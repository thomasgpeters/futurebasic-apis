/*
 HelpManager.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class HelpManagerClass( void );

// - get -
NSHelpManager *HelpManagerShared( void );

// - display -
void HelpManagerFindString( CFStringRef string, CFStringRef book );
void HelpManagerOpenHelpAnchor( CFStringRef anchor, CFStringRef book );

// - add help books -
BOOL HelpManagerRegisterBooksInBundle( NSBundle *bundle );

// - configure -
void HelpManagerSetContextHelp( CFAttributedStringRef attrString, NSObject *object );
void HelpManagerRemoveContextHelp( NSObject *object );

// - display -
CFAttributedStringRef HelpManagerContextHelp( NSObject *object );
BOOL HelpManagerShowContextHelp( NSObject *object, CGPoint locationHint );

// - properties -
BOOL HelpManagerIsContextHelpModeActive( void );


#pragma mark - custom
BOOL HelpManagerIndexBookInBundle( NSBundle *bundle );

