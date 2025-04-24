/*
 AppleScript.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

// Class
Class AppleScriptClass( void );

// -- init --
NSAppleScript *AppleScriptWithContentsOfURL( CFURLRef url, CFDictionaryRef *errInfo );
NSAppleScript *AppleScriptWithSource( CFStringRef source );

// -- info --
BOOL AppleScriptIsCompiled( NSAppleScript *script );
CFStringRef AppleScriptSource( NSAppleScript *script );
CFAttributedStringRef AppleScriptRichTextSource( NSAppleScript *script );

// -- compile and execute --
BOOL AppleScriptCompile( NSAppleScript *script, CFDictionaryRef *errInfo );
NSAppleEventDescriptor *AppleScriptExecute( NSAppleScript *script, CFDictionaryRef *errInfo );
NSAppleEventDescriptor *AppleScriptExecuteAppleEvent( NSAppleScript *script, NSAppleEventDescriptor *aeDesc, CFDictionaryRef *errorInfo );

