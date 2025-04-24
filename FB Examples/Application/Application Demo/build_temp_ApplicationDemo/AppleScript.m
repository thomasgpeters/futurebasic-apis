/*
 AppleScript.m
 
 Bernie Wylde
 */

#import "AppleScript.h"

// Class
Class AppleScriptClass( void )
{ return [NSAppleScript class]; }

// -- init --
NSAppleScript *AppleScriptWithContentsOfURL( CFURLRef url, CFDictionaryRef *errInfo )
{
    NSDictionary *tempErrInfo = nil;
#if __has_feature(objc_arc)
    NSAppleScript *script = [[NSAppleScript alloc] initWithContentsOfURL:(__bridge NSURL *)url error:&tempErrInfo];
#else
    NSAppleScript *script = [[[NSAppleScript alloc] initWithContentsOfURL:(__bridge NSURL *)url error:&tempErrInfo] autorelease];
#endif
    if ( errInfo ) *errInfo = (__bridge CFDictionaryRef)tempErrInfo;
    return script;
}

NSAppleScript *AppleScriptWithSource( CFStringRef source )
{
#if __has_feature(objc_arc)
    return [[NSAppleScript alloc] initWithSource:(__bridge NSString *)source];
#else
    return [[[NSAppleScript alloc] initWithSource:(__bridge NSString *)source] autorelease];
#endif
}

// -- info --
BOOL AppleScriptIsCompiled( NSAppleScript *script )
{ return [script isCompiled]; }

CFStringRef AppleScriptSource( NSAppleScript *script )
{ return (__bridge CFStringRef)[script source]; }

CFAttributedStringRef AppleScriptRichTextSource( NSAppleScript *script )
{ return (__bridge CFAttributedStringRef)[script richTextSource]; }

// -- compile and execute --
BOOL AppleScriptCompile( NSAppleScript *script, CFDictionaryRef *errInfo )
{
    NSDictionary *tempErrorInfo = nil;
    BOOL flag = [script compileAndReturnError:&tempErrorInfo];
    if ( errInfo ) *errInfo = (__bridge CFDictionaryRef)tempErrorInfo;
    return flag;
}

NSAppleEventDescriptor *AppleScriptExecute( NSAppleScript *script, CFDictionaryRef *errInfo )
{
    NSDictionary *tempErrorInfo = nil;
    NSAppleEventDescriptor *ed = [script executeAndReturnError:&tempErrorInfo];
    if ( errInfo ) *errInfo = (__bridge CFDictionaryRef)tempErrorInfo;
    return ed;
}

NSAppleEventDescriptor *AppleScriptExecuteAppleEvent( NSAppleScript *script, NSAppleEventDescriptor *aeDesc, CFDictionaryRef *errorInfo )
{
    NSDictionary *tempErrorInfo = nil;
    NSAppleEventDescriptor *ed = [script executeAppleEvent:aeDesc error:&tempErrorInfo];
    if ( errorInfo ) *errorInfo = (__bridge CFDictionaryRef)tempErrorInfo;
    return ed;
}


