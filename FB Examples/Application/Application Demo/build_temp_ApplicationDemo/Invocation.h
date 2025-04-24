/*
 Invocation.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class InvocationClass( void );

// Create
NSInvocation *InvocationWithMethodSignature( NSMethodSignature *signature );

// Configure
SEL InvocationSelector( NSInvocation *ref );
void InvocationSetSelector( NSInvocation *ref, SEL selector );
CFStringRef InvocationSelectorString( NSInvocation *ref );
void InvocationSetSelectorString( NSInvocation *ref, CFStringRef string );
CFTypeRef InvocationTarget( NSInvocation *ref );
void InvocationSetTarget( NSInvocation *ref, CFTypeRef target );
void InvocationSetArgumentAtIndex( NSInvocation *ref, void *argLocation, NSInteger index );
void InvocationGetArgumentAtIndex( NSInvocation *ref, void *argLocation, NSInteger index );
BOOL InvocationArgumentsRetained( NSInvocation *ref );
void InvocationRetainArguments( NSInvocation *ref );
void InvocationSetReturnValue( NSInvocation *ref, void *retLocation );
void InvocationGetReturnValue( NSInvocation *ref, void *retLocation );

// Dispatch
void InvocationInvoke( NSInvocation *ref );
void InvocationInvokeWithTarget( NSInvocation *ref, CFTypeRef target );

// Method signature
NSMethodSignature *InvocationMethodSignature( NSInvocation *ref );

