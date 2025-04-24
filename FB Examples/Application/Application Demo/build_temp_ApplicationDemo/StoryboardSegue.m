/*
 StoryboardSegue.m

 Bernie Wylde
 */

#import "StoryboardSegue.h"


// Class
Class StoryboardSegueClass( void )
{ return [NSStoryboardSegue class]; }

// Create
NSStoryboardSegue *StoryboardSegueWithIdentifier( CFStringRef identifier, CFTypeRef srcController, CFTypeRef destController, CUI_StoryboardSeguePerformHandlerType performHandler, void *userData )
{
    return [NSStoryboardSegue segueWithIdentifier:(__bridge NSString *)identifier source:(__bridge id)srcController destination:(__bridge id)destController performHandler:^(void) {
        (*performHandler)( userData );
    }];
}

// Inspect
CFTypeRef StoryboardSegueSourceController( NSStoryboardSegue *ref )
{ return (__bridge CFTypeRef)[ref sourceController]; }

CFTypeRef StoryboardSegueDestinationController( NSStoryboardSegue *ref )
{ return (__bridge CFTypeRef)[ref destinationController]; }

CFStringRef StoryboardSegueIdentifier( NSStoryboardSegue *ref )
{ return (__bridge CFStringRef)[ref identifier]; }

// Invocation
void StoryboardSeguePerform( NSStoryboardSegue *ref )
{ [ref perform]; }


