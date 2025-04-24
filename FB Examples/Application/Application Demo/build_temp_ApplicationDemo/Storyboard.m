/*
 Storyboard.m

 Bernie Wylde
 */

#import "Storyboard.h"


// Class
Class StoryboardClass( void )
{ return [NSStoryboard class]; }

// Create
NSStoryboard *StoryboardWithName( CFStringRef name, CFBundleRef bundle )
{ return [NSStoryboard storyboardWithName:(__bridge NSString *)name bundle:(__bridge NSBundle *)bundle]; }

NSStoryboard *StoryboardMain( void )
{ return [NSStoryboard mainStoryboard]; }

// Instantiate controller
CFTypeRef StoryboardInstantiateInitialController( NSStoryboard *ref )
{ return (__bridge CFTypeRef)[ref instantiateInitialController]; }

CFTypeRef StoryboardInstantiateControllerWithIdentifier( NSStoryboard *ref, CFStringRef identifier )
{
    NSViewController *controller = [ref instantiateControllerWithIdentifier:(__bridge NSString *)identifier];
    if ( controller ) {
        CUI_NibViewSetup( 0, controller.view );
    }
    return (__bridge CFTypeRef)controller;
}

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500

//if (@available(macOS 10.15, *)) {
//}

//CFTypeRef StoryboardInstantiateControllerWithIdentifierAndCreator( NSStoryboard *ref, CFStringRef identifier, void *creatorFn, void *userData )
//{
////    return (__bridge CFTypeRef)[ref instantiateControllerWithIdentifier:(__bridge NSString *)identifier creator:NSStoryboardControllerCreator(NSCoder *coder) {
////        
////    }];
//    return nil;
//}
//
//CFTypeRef StoryboardInstantiateInitialControllerWithCreator( NSStoryboard *ref, void *creatorFn, void *userData )
//{
////    return (__bridge CFTypeRef)[ref instantiateInitialControllerWithCreator:NSStoryboardControllerCreator(NSCoder *coder) {
////        
////    }];
//    return nil;
//}
#endif// 101500


