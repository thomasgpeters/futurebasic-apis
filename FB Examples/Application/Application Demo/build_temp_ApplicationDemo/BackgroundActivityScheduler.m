/*
 BackgroundActivityScheduler.m
 
 Bernie Wylde
 */

#import "BackgroundActivityScheduler.h"


// Class
Class BackgroundActivitySchedulerClass( void )
{ return [NSBackgroundActivityScheduler class]; }

// Create
NSBackgroundActivityScheduler *BackgroundActivitySchedulerWithIdentifier( CFStringRef identifier )
{
#if __has_feature(objc_arc)
    return [[NSBackgroundActivityScheduler alloc] initWithIdentifier:(__bridge NSString *)identifier];
#else
    return [[[NSBackgroundActivityScheduler alloc] initWithIdentifier:(__bridge NSString *)identifier] autorelease];
#endif
}

// Attributes
CFStringRef BackgroundActivitySchedulerIdentifier( NSBackgroundActivityScheduler *ref )
{ return (__bridge CFStringRef)[ref identifier]; }

BOOL BackgroundActivitySchedulerRepeats( NSBackgroundActivityScheduler *ref )
{ return [ref repeats]; }

void BackgroundActivitySchedulerSetRepeats( NSBackgroundActivityScheduler *ref, BOOL flag )
{ [ref setRepeats:flag]; }

CFTimeInterval BackgroundActivitySchedulerInterval( NSBackgroundActivityScheduler *ref )
{ return [ref interval]; }

void BackgroundActivitySchedulerSetInterval( NSBackgroundActivityScheduler *ref, CFTimeInterval interval )
{ [ref setInterval:interval]; }

NSQualityOfService BackgroundActivitySchedulerQualityOfService( NSBackgroundActivityScheduler *ref )
{ return [ref qualityOfService]; }

void BackgroundActivitySchedulerSetQualityOfService( NSBackgroundActivityScheduler *ref, NSQualityOfService qualityOfService )
{ [ref setQualityOfService:qualityOfService]; }

BOOL BackgroundActivitySchedulerShouldDefer( NSBackgroundActivityScheduler *ref )
{ return [ref shouldDefer]; }

CFTimeInterval BackgroundActivitySchedulerTolerance( NSBackgroundActivityScheduler *ref )
{ return [ref tolerance]; }

void BackgroundActivitySchedulerSetTolerance( NSBackgroundActivityScheduler *ref, CFTimeInterval tolerance )
{ [ref setTolerance:tolerance]; }

// Scheduling
void BackgroundActivitySchedulerSchedule( NSBackgroundActivityScheduler *ref, CUI_BackgroundActivitySchedulerHandlerType handler, void *userData )
{
    [ref scheduleWithBlock:^(NSBackgroundActivityCompletionHandler completion) {
        NSBackgroundActivityResult result = (*handler)(ref,userData);
        completion(result);
    }];
}

// Stopping
void BackgroundActivitySchedulerInvalidate( NSBackgroundActivityScheduler *ref )
{ [ref invalidate]; }

