/*
 MethodSignature.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class MethodSignatureClass( void );

// Create
//NSMethodSignature *MethodSignatureWithObjCTypes( CFArrayRef types );

// Argument types
CFStringRef MethodSignatureArgumentTypeAtIndex( NSMethodSignature *ref, NSUInteger index );
NSUInteger MethodSignatureNumberOfArguments( NSMethodSignature *ref );
NSUInteger MethodSignatureFrameLength( NSMethodSignature *ref );

// Return types
CFStringRef MethodSignatureMethodReturnType( NSMethodSignature *ref );
NSUInteger MethodSignatureMethodReturnLength( NSMethodSignature *ref );

// Synchronous status
BOOL MethodSignatureIsOneWay( NSMethodSignature *ref );
