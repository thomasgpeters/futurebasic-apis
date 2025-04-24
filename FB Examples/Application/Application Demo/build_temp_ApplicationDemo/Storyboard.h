/*
 Storyboard.h

 Bernie Wylde
 */


#import "CocoaUI.h"


// Class
Class StoryboardClass( void );

// Create
NSStoryboard *StoryboardWithName( CFStringRef name, CFBundleRef bundle );
NSStoryboard *StoryboardMain( void );

// Instantiate controller
CFTypeRef StoryboardInstantiateInitialController( NSStoryboard *ref );
CFTypeRef StoryboardInstantiateControllerWithIdentifier( NSStoryboard *ref, CFStringRef identifier );

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
CFTypeRef StoryboardInstantiateControllerWithIdentifierAndCreator( NSStoryboard *ref, CFStringRef identifier, void *creatorFn, void *userData );
CFTypeRef StoryboardInstantiateInitialControllerWithCreator( NSStoryboard *ref, void *creatorFn, void *userData );
#endif// 101500

