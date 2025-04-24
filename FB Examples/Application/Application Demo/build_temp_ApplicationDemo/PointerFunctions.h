/*
 PointerFunctions.h

 Bernie Wylde
 */

#import "CocoaUI.h"

typedef NSUInteger (*CUI_PointerFunctionHashFunctionCallbackType)(const void *item, NSUInteger (*size)(const void *item));
typedef BOOL (*CUI_PointerFunctionIsEqualFunctionCallbackType)(const void *item1, const void *item2, NSUInteger (*size)(const void *item));
typedef NSUInteger (*CUI_PointerFunctionSizeFunctionCallbackType)(const void *item);
typedef NSString * (*CUI_PointerFunctionDescriptionFunctionCallbackType)(const void *item);
typedef void *(*CUI_PointerFunctionAcquireFunctionCallbackType)(const void *src, NSUInteger (*size)(const void *item), BOOL shouldCopy);
typedef void (*CUI_PointerFunctionRelinquishFunctionCallbackType)(const void *item, NSUInteger (*size)(const void *item));


// Class
Class PointerFunctionsClass( void );

// - create -
NSPointerFunctions *PointerFunctionsWithOptions( NSPointerFunctionsOptions options );

// - personality functions -
void *PointerFunctionsHashFunction( NSPointerFunctions *ref );
void PointerFunctionsSetHashFunction( NSPointerFunctions *ref, CUI_PointerFunctionHashFunctionCallbackType fnAddress );
void *PointerFunctionsIsEqualFunction( NSPointerFunctions *ref );
void PointerFunctionsSetIsEqualFunction( NSPointerFunctions *ref, CUI_PointerFunctionIsEqualFunctionCallbackType fnAddress );
void *PointerFunctionsSizeFunction( NSPointerFunctions *ref );
void PointerFunctionsSetSizeFunction( NSPointerFunctions *ref, CUI_PointerFunctionSizeFunctionCallbackType fnAddress );
void *PointerFunctionsDescriptionFunction( NSPointerFunctions *ref );
void PointerFunctionsSetDescriptionFunction( NSPointerFunctions *ref, CUI_PointerFunctionDescriptionFunctionCallbackType nAddress );

// - memory configuration -
void *PointerFunctionsAcquireFunction( NSPointerFunctions *ref );
void PointerFunctionsSetAcquireFunction( NSPointerFunctions *ref, CUI_PointerFunctionAcquireFunctionCallbackType fnAddress );
void *PointerFunctionsRelinquishFunction( NSPointerFunctions *ref );
void PointerFunctionsSetRelinquishFunction( NSPointerFunctions *ref, CUI_PointerFunctionRelinquishFunctionCallbackType fnAddress );

