/*
 Operation.m

 Bernie Wylde
 */

#import "Operation.h"

// Class
Class OperationClass( void )
{ return [NSOperation class]; }

// Init
NSOperation *OperationInit( void )
{
#if __has_feature(objc_arc)
    return [[NSOperation alloc] init];
#else
    return [[[NSOperation alloc] init] autorelease];
#endif
}

// Executing
void OperationStart( NSOperation *ref )
{ [ref start]; }

void OperationMain( NSOperation *ref )
{ [ref main]; }

void OperationSetCompletionCallback( NSOperation *ref, CUI_OperationCompletionCallbackType callback, void *userData )
{
//    __unsafe_unretained typeof(ref) weakRef = ref;
//    [ref setCompletionBlock:^(void) {
//        (*callback)(weakRef,userData);
//    }];
    
    [ref setCompletionBlock:^(void) {
        (*callback)(ref,userData);
    }];
}

void OperationSetCompletionFunction( NSOperation *ref, CUI_OperationCompletionFunctionCallbackType fnAddress, void *userData )
{
//    __unsafe_unretained typeof(ref) weakRef = ref;
//    [ref setCompletionBlock:^(void) {
//        (*fnAddress)(weakRef,userData);
//    }];
    
    [ref setCompletionBlock:^(void) {
        (*fnAddress)(ref,userData);
    }];
}

// Cancelling
void OperationCancel( NSOperation *ref )
{ [ref cancel]; }

// Status
BOOL OperationIsCancelled( NSOperation *ref )
{ return [ref isCancelled]; }

BOOL OperationIsExecuting( NSOperation *ref )
{ return [ref isExecuting]; }

BOOL OperationIsFinished( NSOperation *ref )
{ return [ref isFinished]; }

BOOL OperationIsConcurrent( NSOperation *ref )
{ return [ref isConcurrent]; }

BOOL OperationIsAsynchronous( NSOperation *ref )
{ return [ref isAsynchronous]; }

BOOL OperationIsReady( NSOperation *ref )
{ return [ref isReady]; }

CFStringRef OperationName( NSOperation *ref )
{ return (__bridge CFStringRef)[ref name]; }

void OperationSetName( NSOperation *ref, CFStringRef name )
{ [ref setName:(__bridge NSString *)name]; }

// Dependencies
void OperationAddDependency( NSOperation *op1, NSOperation *op2 )
{ [op1 addDependency:op2]; }

void OperationRemoveDependency( NSOperation *op1, NSOperation *op2 )
{ [op1 removeDependency:op2]; }

CFArrayRef OperationDependencies( NSOperation *ref )
{ return (__bridge CFArrayRef)[ref dependencies]; }

// Execution priority
NSQualityOfService OperationQualityOfService( NSOperation *ref )
{ return [ref qualityOfService]; }

void OperationSetQualityOfService( NSOperation *ref, NSQualityOfService qos )
{ [ref setQualityOfService:qos]; }

NSOperationQueuePriority OperationQueuePriority( NSOperation *ref )
{ return [ref queuePriority]; }

void OperationSetQueuePriority( NSOperation *ref, NSOperationQueuePriority priority )
{ [ref setQueuePriority:priority]; }

// Waiting
void OperationWaitUntilFinished( NSOperation *ref )
{ [ref waitUntilFinished]; }


#pragma mark - OperationQueue

// Init
NSOperationQueue *OperationQueueInit( void )
{
#if __has_feature(objc_arc)
    return [[NSOperationQueue alloc] init];
#else
    return [[[NSOperationQueue alloc] init] autorelease];
#endif
}

// Get specific queues
NSOperationQueue *OperationQueueMain( void )
{ return [NSOperationQueue mainQueue]; }

NSOperationQueue *OperationQueueCurrent( void )
{ return [NSOperationQueue currentQueue]; }

// Managing operations
void OperationQueueAddOperation( NSOperationQueue *ref, NSOperation *op )
{ [ref addOperation:op]; }

void OperationQueueAddOperations( NSOperationQueue *ref, CFArrayRef ops, BOOL waitUntilFinished )
{ [ref addOperations:(__bridge NSArray *)ops waitUntilFinished:waitUntilFinished]; }

void OperationQueueAddOperationWithCallback( NSOperationQueue *ref, CUI_OperationQueueFunctionCallbackType callback, CFTypeRef obj )
{
    [ref addOperationWithBlock:^(void) {
        (*callback)( ref, obj );
    }];
}

void OperationQueueAddOperationWithFunction( NSOperationQueue *ref, CUI_OperationQueueFunctionCallbackType fnAddress, CFTypeRef obj )
{
    [ref addOperationWithBlock:^(void) {
        (*fnAddress)( ref, obj );
    }];
}

CFArrayRef OperationQueueOperations( NSOperationQueue *ref )
{ return (__bridge CFArrayRef)[ref operations]; }

NSUInteger OperationQueueOperationCount( NSOperationQueue *ref )
{ return [ref operationCount]; }

void OperationQueueCancelAllOperations( NSOperationQueue *ref )
{ [ref cancelAllOperations]; }

void OperationQueueWaitUntilAllOperationsAreFinished( NSOperationQueue *ref )
{ [ref waitUntilAllOperationsAreFinished]; }

// Managing execution
NSQualityOfService OperationQueueQualityOfService( NSOperationQueue *ref )
{ return [ref qualityOfService]; }

void OperationQueueSetQualityOfService( NSOperationQueue *ref, NSQualityOfService qos )
{ [ref setQualityOfService:qos]; }

NSInteger OperationQueueMaxConcurrentOperationCount( NSOperationQueue *ref )
{ return [ref maxConcurrentOperationCount]; }

void OperationQueueSetMaxConcurrentOperationCount( NSOperationQueue *ref, NSInteger count )
{ [ref setMaxConcurrentOperationCount:count]; }

// Suspending
BOOL OperationQueueIsSuspended( NSOperationQueue *ref )
{ return [ref isSuspended]; }

void OperationQueueSetSuspended( NSOperationQueue *ref, BOOL flag )
{ [ref setSuspended:flag]; }

// Configure
CFStringRef OperationQueueName( NSOperationQueue *ref )
{ return (__bridge CFStringRef)[ref name]; }

void OperationQueueSetName( NSOperationQueue *ref, CFStringRef name )
{ [ref setName:(__bridge NSString *)name]; }

dispatch_queue_t OperationQueueUnderlyingQueue( NSOperationQueue *ref )
{ return [ref underlyingQueue]; }

void OperationQueueSetUnderlyingQueue( NSOperationQueue *ref, dispatch_queue_t dq )
{ [ref setUnderlyingQueue:dq]; }

// Properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
NSProgress *OperationQueueProgress( NSOperationQueue *ref )
{ return [ref progress]; }
#endif


#pragma mark - InvocationOperation
@implementation CUI_InvocationOperation

- (id)initWithCallback:(CUI_InvocationOperationCallbackType)cb object:(id)object {
    if ( [super initWithTarget:self selector:@selector(action:) object:object] ) {
        self.callback = cb;
    }
    return self;
}

- (void)action:(id)object {
    (*self.callback)(object);
}
@end

// Init
NSInvocationOperation *InvocationOperationWithTarget( CFTypeRef target, SEL selector, CFTypeRef obj )
{
#if __has_feature(objc_arc)
    return [[NSInvocationOperation alloc] initWithTarget:(__bridge id)target selector:selector object:(__bridge id)obj];
#else
    return [[[NSInvocationOperation alloc] initWithTarget:(__bridge id)target selector:selector object:(__bridge id)obj] autorelease];
#endif
}

NSInvocationOperation *InvocationOperationWithTargetAndSelectorString( CFTypeRef target, CFStringRef string, CFTypeRef obj )
{
#if __has_feature(objc_arc)
    return [[NSInvocationOperation alloc] initWithTarget:(__bridge id)target selector:NSSelectorFromString((__bridge NSString *)string) object:(__bridge id)obj];
#else
    return [[[NSInvocationOperation alloc] initWithTarget:(__bridge id)target selector:NSSelectorFromString((__bridge NSString *)string) object:(__bridge id)obj] autorelease];
#endif
}

NSInvocationOperation *InvocationOperationWithInvocation( NSInvocation *invocation )
{
#if __has_feature(objc_arc)
    return [[NSInvocationOperation alloc] initWithInvocation:invocation];
#else
    return [[[NSInvocationOperation alloc] initWithInvocation:invocation] autorelease];
#endif
}

// Attributes
NSInvocation *InvocationOperationInvocation( NSInvocationOperation *ref )
{ return [ref invocation]; }

CFTypeRef InvocationOperationResult( NSInvocationOperation *ref )
{ return (__bridge CFTypeRef)[ref result]; }


#pragma mark - BlockOperation
// Manage
NSBlockOperation *BlockOperationWithCallback( CUI_BlockOperationCallbackType callback, void *userData )
{
    return [NSBlockOperation blockOperationWithBlock:^(void) {
        (*callback)( userData );
    }];
}

void BlockOperationAddCallback( NSBlockOperation *ref, CUI_BlockOperationCallbackType callback, void *userData )
{
    [ref addExecutionBlock:^(void) {
        (*callback)( userData );
    }];
}

CFArrayRef BlockOperationBlocks( NSBlockOperation *ref )
{ return (__bridge CFArrayRef)[ref executionBlocks]; }

NSBlockOperation *BlockOperationWithBlock( CUI_BlockOperationBlockType callback )
{
    return [NSBlockOperation blockOperationWithBlock:^(void) {
        (*callback)();
    }];
}

void BlockOperationAddBlock( NSBlockOperation *ref, CUI_BlockOperationBlockType callback )
{
    [ref addExecutionBlock:^(void) {
        (*callback)();
    }];
}
