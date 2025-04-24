/*
 UserScriptTask.m

 Bernie Wylde
 */

#import "UserScriptTask.h"

// Specify
NSUserScriptTask *UserScriptTaskWithURL( CFURLRef url, ErrorRef *err )
{
#if __has_feature(objc_arc)
    return [[NSUserScriptTask alloc] initWithURL:(__bridge NSURL *)url error:err];
#else
    return [[[NSUserScriptTask alloc] initWithURL:(__bridge NSURL *)url error:err] autorelease];
#endif
}

CFURLRef UserScriptTaskURL( NSUserScriptTask *ref )
{ return (__bridge CFURLRef)[ref scriptURL]; }

// Execute
void UserScriptTaskExecute( NSUserScriptTask *ref, CUI_UserScriptTaskCompletionHandlerType completionHandler, void *userData )
{
    [ref executeWithCompletionHandler:^( NSError *error ) {
        if (completionHandler) (*completionHandler)(ref,error,userData);
    }];
}


#pragma mark - UserUnixTask

// Init
NSUserUnixTask *UserUnixTaskInit( void )
{
#if __has_feature(objc_arc)
    return [[NSUserUnixTask alloc] init];
#else
    return [[[NSUserUnixTask alloc] init] autorelease];
#endif
}

// Execute
void UserUnixTaskExecuteWithArguments( NSUserUnixTask *ref, CFArrayRef arguments, CUI_UserUnixTaskCompletionHandlerType completionHandler, void *userData )
{
    [ref executeWithArguments:(__bridge NSArray *)arguments completionHandler:^( NSError *error ) {
        if (completionHandler) (*completionHandler)(ref,error,userData);
    }];
}

// Standard unx streams
NSFileHandle *UserUnixTaskStandardError( NSUserUnixTask *ref )
{ return [ref standardError]; }

void UserUnixTaskSetStandardError( NSUserUnixTask *ref, NSFileHandle *standardError )
{ [ref setStandardError:standardError]; }

NSFileHandle *UserUnixTaskStandardInput( NSUserUnixTask *ref )
{ return [ref standardInput]; }

void UserUnixTaskSetStandardInput( NSUserUnixTask *ref, NSFileHandle *standardInput )
{ [ref setStandardError:standardInput]; }

NSFileHandle *UserUnixTaskStandardOutput( NSUserUnixTask *ref )
{ return [ref standardOutput]; }

void UserUnixTaskSetStandardOutput( NSUserUnixTask *ref, NSFileHandle *standardOutput )
{ [ref setStandardError:standardOutput]; }


#pragma mark - UserAppleScriptTask

// Init
NSUserAppleScriptTask *UserAppleScriptTaskInit( void )
{
#if __has_feature(objc_arc)
    return [[NSUserAppleScriptTask alloc] init];
#else
    return [[[NSUserAppleScriptTask alloc] init] autorelease];
#endif
}

// Execute
void UserAppleScriptTaskExecute( NSUserAppleScriptTask *ref, NSAppleEventDescriptor *event, CUI_UserAppleScriptTaskCompletionHandlerType completionHandler, void *userData )
{
    [ref executeWithAppleEvent:event completionHandler:^( NSAppleEventDescriptor *result, NSError *error ) {
        if (completionHandler) (*completionHandler)(ref,result,error,userData);
    }];
}


#pragma mark - UserAutomatorTask

// Init
NSUserAutomatorTask *UserAutomatorTaskInit( void )
{
#if __has_feature(objc_arc)
    return [[NSUserAutomatorTask alloc] init];
#else
    return [[[NSUserAutomatorTask alloc] init] autorelease];
#endif
}

// Execute
void UserAutomatorTaskExecute( NSUserAutomatorTask *ref, id<NSSecureCoding> input, CUI_UserAutomatorTaskCompletionHandlerType completionHandler, void *userData )
{
    [ref executeWithInput:input completionHandler:^( id result, NSError *error ) {
        if (completionHandler) (*completionHandler)(ref,(__bridge CFTypeRef)result,error,userData);
    }];
}

CFDictionaryRef UserAutomatorTaskVariables( NSUserAutomatorTask *ref )
{ return (__bridge CFDictionaryRef)[ref variables]; }

void UserAutomatorTaskSetVariables( NSUserAutomatorTask *ref, CFDictionaryRef variables )
{ [ref setVariables:(__bridge NSDictionary *)variables]; }

