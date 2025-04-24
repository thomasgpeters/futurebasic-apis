/*
 MethodSignature.m
 
 Bernie Wylde
 */

#import "MethodSignature.h"

// Class
Class MethodSignatureClass( void )
{ return [NSMethodSignature class]; }

// Create
//NSMethodSignature *MethodSignatureWithObjCTypes( CFArrayRef types )
//{
//    // ...
//    return nil;
//}

// Argument types
CFStringRef MethodSignatureArgumentTypeAtIndex( NSMethodSignature *ref, NSUInteger index );
NSUInteger MethodSignatureNumberOfArguments( NSMethodSignature *ref );
NSUInteger MethodSignatureFrameLength( NSMethodSignature *ref );

// Return types
CFStringRef MethodSignatureMethodReturnType( NSMethodSignature *ref );
NSUInteger MethodSignatureMethodReturnLength( NSMethodSignature *ref );

// Synchronous status
BOOL MethodSignatureIsOneWay( NSMethodSignature *ref );
