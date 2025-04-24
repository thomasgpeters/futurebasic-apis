/*
 StoryboardSegue.h

 Bernie Wylde
 */


#import "CocoaUI.h"


typedef void (*CUI_StoryboardSeguePerformHandlerType)(void*);

// Class
Class StoryboardSegueClass( void );

// Create
NSStoryboardSegue *StoryboardSegueWithIdentifier( CFStringRef identifier, CFTypeRef srcController, CFTypeRef destController, CUI_StoryboardSeguePerformHandlerType performHandler, void *userData );

// Inspect
CFTypeRef StoryboardSegueSourceController( NSStoryboardSegue *ref );
CFTypeRef StoryboardSegueDestinationController( NSStoryboardSegue *ref );
CFStringRef StoryboardSegueIdentifier( NSStoryboardSegue *ref );

// Invocation
void StoryboardSeguePerform( NSStoryboardSegue *ref );

