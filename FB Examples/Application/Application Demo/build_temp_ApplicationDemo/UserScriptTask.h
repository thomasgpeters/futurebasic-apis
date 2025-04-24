/*
 UserScriptTask.h

 Bernie Wylde
 */

#import "CocoaUI.h"

typedef void (*CUI_UserScriptTaskCompletionHandlerType)(NSUserScriptTask*,NSError*,void*);

// Specify
NSUserScriptTask *UserScriptTaskWithURL( CFURLRef url, ErrorRef *err );
CFURLRef UserScriptTaskURL( NSUserScriptTask *ref );

// Execute
void UserScriptTaskExecute( NSUserScriptTask *ref, CUI_UserScriptTaskCompletionHandlerType completionHandler, void *userData );


#pragma mark - UserUnixTask

typedef void (*CUI_UserUnixTaskCompletionHandlerType)(NSUserUnixTask*,NSError*,void*);

// Init
NSUserUnixTask *UserUnixTaskInit( void );

// Execute
void UserUnixTaskExecuteWithArguments( NSUserUnixTask *ref, CFArrayRef arguments, CUI_UserUnixTaskCompletionHandlerType completionHandler, void *userData );

// Standard unx streams
NSFileHandle *UserUnixTaskStandardError( NSUserUnixTask *ref );
void UserUnixTaskSetStandardError( NSUserUnixTask *ref, NSFileHandle *standardError );
NSFileHandle *UserUnixTaskStandardInput( NSUserUnixTask *ref );
void UserUnixTaskSetStandardInput( NSUserUnixTask *ref, NSFileHandle *standardInput );
NSFileHandle *UserUnixTaskStandardOutput( NSUserUnixTask *ref );
void UserUnixTaskSetStandardOutput( NSUserUnixTask *ref, NSFileHandle *standardOutput );


#pragma mark - UserAppleScriptTask

typedef void (*CUI_UserAppleScriptTaskCompletionHandlerType)(NSUserAppleScriptTask*,NSAppleEventDescriptor*,NSError*,void*);

// Init
NSUserAppleScriptTask *UserAppleScriptTaskInit( void );

// Execute
void UserAppleScriptTaskExecute( NSUserAppleScriptTask *ref, NSAppleEventDescriptor *event, CUI_UserAppleScriptTaskCompletionHandlerType completionHandler, void *userData );


#pragma mark - UserAutomatorTask

typedef void (*CUI_UserAutomatorTaskCompletionHandlerType)(NSUserAutomatorTask*,CFTypeRef,NSError*,void*);

// Init
NSUserAutomatorTask *UserAutomatorTaskInit( void );

// Execute
void UserAutomatorTaskExecute( NSUserAutomatorTask *ref, id<NSSecureCoding> input, CUI_UserAutomatorTaskCompletionHandlerType completionHandler, void *userData );
CFDictionaryRef UserAutomatorTaskVariables( NSUserAutomatorTask *ref );
void UserAutomatorTaskSetVariables( NSUserAutomatorTask *ref, CFDictionaryRef variables );

