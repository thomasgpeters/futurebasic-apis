/*
 PointerFunctions.m

 Bernie Wylde
 */

#import "PointerFunctions.h"

// Class
Class PointerFunctionsClass( void )
{ return [NSPointerFunctions class]; }

// - create -
NSPointerFunctions *PointerFunctionsWithOptions( NSPointerFunctionsOptions options )
{ return [NSPointerFunctions pointerFunctionsWithOptions:options]; }

// - personality functions -
void *PointerFunctionsHashFunction( NSPointerFunctions *ref )
{ return (void *)[ref hashFunction]; }

void PointerFunctionsSetHashFunction( NSPointerFunctions *ref, CUI_PointerFunctionHashFunctionCallbackType fnAddress )
{ [ref setHashFunction:fnAddress]; }

void *PointerFunctionsIsEqualFunction( NSPointerFunctions *ref )
{ return (void *)[ref isEqualFunction]; }

void PointerFunctionsSetIsEqualFunction( NSPointerFunctions *ref, CUI_PointerFunctionIsEqualFunctionCallbackType fnAddress )
{ [ref setIsEqualFunction:fnAddress]; }

void *PointerFunctionsSizeFunction( NSPointerFunctions *ref )
{ return (void *)[ref sizeFunction]; }

void PointerFunctionsSetSizeFunction( NSPointerFunctions *ref, CUI_PointerFunctionSizeFunctionCallbackType fnAddress )
{ [ref setSizeFunction:fnAddress]; }

void *PointerFunctionsDescriptionFunction( NSPointerFunctions *ref )
{ return (void *)[ref descriptionFunction]; }

void PointerFunctionsSetDescriptionFunction( NSPointerFunctions *ref, CUI_PointerFunctionDescriptionFunctionCallbackType fnAddress )
{ [ref setDescriptionFunction:fnAddress]; }

// - memory configuration -
void *PointerFunctionsAcquireFunction( NSPointerFunctions *ref )
{ return (void *)[ref acquireFunction]; }

void PointerFunctionsSetAcquireFunction( NSPointerFunctions *ref, CUI_PointerFunctionAcquireFunctionCallbackType fnAddress )
{ [ref setAcquireFunction:fnAddress]; }

void *PointerFunctionsRelinquishFunction( NSPointerFunctions *ref )
{ return (void *)[ref relinquishFunction]; }

void PointerFunctionsSetRelinquishFunction( NSPointerFunctions *ref, CUI_PointerFunctionRelinquishFunctionCallbackType fnAddress )
{ [ref setRelinquishFunction:fnAddress]; }

