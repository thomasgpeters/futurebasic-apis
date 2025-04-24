/*
 Task.m

 Bernie Wylde
 */

#import "Task.h"

// Class
Class TaskClass( void )
{ return [NSTask class]; }

// - init -
NSTask *TaskInit( void )
{
#if __has_feature(objc_arc)
    return [[NSTask alloc] init];
#else
    return [[[NSTask alloc] init] autorelease];
#endif
}

NSTask *TaskLaunchedTaskWithExecutableURL( CFURLRef url, CFArrayRef arguments, NSError **err, CUI_TaskTerminationHandlerType handlerFn )
{
    return [NSTask launchedTaskWithExecutableURL:(__bridge NSURL *)url arguments:(__bridge NSArray *)arguments error:err terminationHandler:^(NSTask *task) {
        if ( handlerFn ) (*handlerFn)(task);
    }];
    return nil;
}

// - info + configure-
CFArrayRef TaskArguments( NSTask *ref )
{ return (__bridge CFArrayRef)[ref arguments]; }

void TaskSetArguments( NSTask *ref, CFArrayRef arguments )
{ [ref setArguments:(__bridge NSArray *)arguments]; }

CFURLRef TaskCurrentDirectoryURL( NSTask *ref )
{ return (__bridge CFURLRef)[ref currentDirectoryURL]; }

void TaskSetCurrentDirectoryURL( NSTask *ref, CFURLRef url )
{ [ref setCurrentDirectoryURL:(__bridge NSURL *)url]; }

CFURLRef TaskExecutableURL( NSTask *ref )
{ return (__bridge CFURLRef)[ref executableURL]; }

void TaskSetExecutableURL( NSTask *ref, CFURLRef url )
{ [ref setExecutableURL:(__bridge NSURL *)url]; }

CFDictionaryRef TaskEnvironment( NSTask *ref )
{ return (__bridge CFDictionaryRef)[ref environment]; }

void TaskSetEnvironment( NSTask *ref, CFDictionaryRef environment )
{ [ref setEnvironment:(__bridge NSDictionary *)environment]; }

int TaskProcessIdentifier( NSTask *ref )
{ return [ref processIdentifier]; }

void *TaskStandardError( NSTask *ref )
{ return (__bridge void *)[ref standardError]; }

void TaskSetStandardError( NSTask *ref, void *obj )
{ [ref setStandardError:(__bridge id)obj]; }

void *TaskStandardInput( NSTask *ref )
{ return (__bridge void *)[ref standardInput]; }

void TaskSetStandardInput( NSTask *ref, void *obj )
{ [ref setStandardInput:(__bridge id)obj]; }

void *TaskStandardOutput( NSTask *ref )
{ return (__bridge void *)[ref standardOutput]; }

void TaskSetStandardOutput( NSTask *ref, void *obj )
{ [ref setStandardOutput:(__bridge id)obj]; }

// - running and stopping -
void TaskInterrupt( NSTask *ref )
{ [ref interrupt]; }

BOOL TaskLaunch( NSTask *ref, NSError **err )
{ return [ref launchAndReturnError:err]; }

BOOL TaskResume( NSTask *ref )
{ return [ref resume]; }

BOOL TaskSuspend( NSTask *ref )
{ return [ref suspend]; }

void TaskTerminate( NSTask *ref )
{ [ref terminate]; }

void TaskWaitUntilExit( NSTask *ref )
{ [ref waitUntilExit]; }

// - query state -
BOOL TaskIsRunning( NSTask *ref )
{ return [ref isRunning]; }

int TaskTerminationStatus( NSTask *ref )
{ return [ref terminationStatus]; }

NSTaskTerminationReason TaskTerminationReason( NSTask *ref )
{ return [ref terminationReason]; }

// - termination handler -
void TaskSetTerminationHandler( NSTask *ref, CUI_TaskTerminationHandlerType handlerFn )
{
    [ref setTerminationHandler:^(NSTask *task) {
        if ( handlerFn ) (*handlerFn)(task);
    }];
}

