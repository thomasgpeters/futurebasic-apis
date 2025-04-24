/*
 Task.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef void (*CUI_TaskTerminationHandlerType)(NSTask *);

// Class
Class TaskClass( void );

// - init -
NSTask *TaskInit( void );

NSTask *TaskLaunchedTaskWithExecutableURL( CFURLRef url, CFArrayRef arguments, NSError **err, CUI_TaskTerminationHandlerType handlerFn );

// - info + configure-
CFArrayRef TaskArguments( NSTask *ref );
void TaskSetArguments( NSTask *ref, CFArrayRef arguments );

CFURLRef TaskCurrentDirectoryURL( NSTask *ref );
void TaskSetCurrentDirectoryURL( NSTask *ref, CFURLRef url );
CFURLRef TaskExecutableURL( NSTask *ref );
void TaskSetExecutableURL( NSTask *ref, CFURLRef url );

CFDictionaryRef TaskEnvironment( NSTask *ref );
void TaskSetEnvironment( NSTask *ref, CFDictionaryRef environment );
int TaskProcessIdentifier( NSTask *ref );
void *TaskStandardError( NSTask *ref );
void TaskSetStandardError( NSTask *ref, void *obj );
void *TaskStandardInput( NSTask *ref );
void TaskSetStandardInput( NSTask *ref, void *obj );
void *TaskStandardOutput( NSTask *ref );
void TaskSetStandardOutput( NSTask *ref, void *obj );

// - running and stopping -
void TaskInterrupt( NSTask *ref );
BOOL TaskLaunch( NSTask *ref, NSError **err );
BOOL TaskResume( NSTask *ref );
BOOL TaskSuspend( NSTask *ref );
void TaskTerminate( NSTask *ref );
void TaskWaitUntilExit( NSTask *ref );

// - query state -
BOOL TaskIsRunning( NSTask *ref );
int TaskTerminationStatus( NSTask *ref );
NSTaskTerminationReason TaskTerminationReason( NSTask *ref );

// - termination handler -
void TaskSetTerminationHandler( NSTask *ref, CUI_TaskTerminationHandlerType handlerFn );

