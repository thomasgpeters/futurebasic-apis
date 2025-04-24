/*
 BackgroundActivityScheduler.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"


typedef NSBackgroundActivityResult (*CUI_BackgroundActivitySchedulerHandlerType)(NSBackgroundActivityScheduler*,void *);

// Class
Class BackgroundActivitySchedulerClass( void );

// Create
NSBackgroundActivityScheduler *BackgroundActivitySchedulerWithIdentifier( CFStringRef identifier );

// Attributes
CFStringRef BackgroundActivitySchedulerIdentifier( NSBackgroundActivityScheduler *ref );
BOOL BackgroundActivitySchedulerRepeats( NSBackgroundActivityScheduler *ref );
void BackgroundActivitySchedulerSetRepeats( NSBackgroundActivityScheduler *ref, BOOL flag );
CFTimeInterval BackgroundActivitySchedulerInterval( NSBackgroundActivityScheduler *ref );
void BackgroundActivitySchedulerSetInterval( NSBackgroundActivityScheduler *ref, CFTimeInterval interval );
NSQualityOfService BackgroundActivitySchedulerQualityOfService( NSBackgroundActivityScheduler *ref );
void BackgroundActivitySchedulerSetQualityOfService( NSBackgroundActivityScheduler *ref, NSQualityOfService qualityOfService );
BOOL BackgroundActivitySchedulerShouldDefer( NSBackgroundActivityScheduler *ref );
CFTimeInterval BackgroundActivitySchedulerTolerance( NSBackgroundActivityScheduler *ref );
void BackgroundActivitySchedulerSetTolerance( NSBackgroundActivityScheduler *ref, CFTimeInterval tolerance );

// Scheduling
void BackgroundActivitySchedulerSchedule( NSBackgroundActivityScheduler *ref, CUI_BackgroundActivitySchedulerHandlerType handler, void *userData );

// Stopping
void BackgroundActivitySchedulerInvalidate( NSBackgroundActivityScheduler *ref );

