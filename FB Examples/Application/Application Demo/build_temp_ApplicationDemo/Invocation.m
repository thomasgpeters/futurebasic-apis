/*
 Invocation.m

 Bernie Wylde
 */

#import "Invocation.h"

// Class
Class InvocationClass( void )
{ return [NSInvocation class]; }

// Create
NSInvocation *InvocationWithMethodSignature( NSMethodSignature *signature )
{ return [NSInvocation invocationWithMethodSignature:signature]; }

// Configure
SEL InvocationSelector( NSInvocation *ref )
{ return [ref selector]; }

void InvocationSetSelector( NSInvocation *ref, SEL selector )
{ [ref setSelector:selector]; }

CFStringRef InvocationSelectorString( NSInvocation *ref )
{ return (__bridge CFStringRef)NSStringFromSelector([ref selector]); }

void InvocationSetSelectorString( NSInvocation *ref, CFStringRef string )
{ [ref setSelector:NSSelectorFromString((__bridge NSString *)string)]; }

CFTypeRef InvocationTarget( NSInvocation *ref )
{ return (__bridge CFTypeRef)[ref target]; }

void InvocationSetTarget( NSInvocation *ref, CFTypeRef target )
{ [ref setTarget:(__bridge id)target]; }

void InvocationSetArgumentAtIndex( NSInvocation *ref, void *argLocation, NSInteger index )
{ [ref setArgument:argLocation atIndex:index]; }

void InvocationGetArgumentAtIndex( NSInvocation *ref, void *argLocation, NSInteger index )
{ [ref getArgument:argLocation atIndex:index]; }

BOOL InvocationArgumentsRetained( NSInvocation *ref )
{ return [ref argumentsRetained]; }

void InvocationRetainArguments( NSInvocation *ref )
{ [ref retainArguments]; }

void InvocationSetReturnValue( NSInvocation *ref, void *retLocation )
{ [ref setReturnValue:retLocation]; }

void InvocationGetReturnValue( NSInvocation *ref, void *retLocation )
{ [ref getReturnValue:retLocation]; }

// Dispatch
void InvocationInvoke( NSInvocation *ref )
{ [ref invoke]; }

void InvocationInvokeWithTarget( NSInvocation *ref, CFTypeRef target )
{ [ref invokeWithTarget:(__bridge id)target]; }

// Method signature
NSMethodSignature *InvocationMethodSignature( NSInvocation *ref )
{ return [ref methodSignature]; }

