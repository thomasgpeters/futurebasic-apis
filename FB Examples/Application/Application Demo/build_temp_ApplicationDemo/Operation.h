/*
 Operation.h

 Bernie Wylde
 */

#import "CocoaUI.h"

typedef void (*CUI_OperationCompletionCallbackType)(NSOperation*,void*);
typedef void (*CUI_OperationCompletionFunctionCallbackType)(NSOperation*,void*);

// Class
Class OperationClass( void );

// Init
NSOperation *OperationInit( void );

// Executing
void OperationStart( NSOperation *ref );
void OperationMain( NSOperation *ref );
void OperationSetCompletionCallback( NSOperation *ref, CUI_OperationCompletionCallbackType callback, void *userData );
void OperationSetCompletionFunction( NSOperation *ref, CUI_OperationCompletionFunctionCallbackType fnAddress, void *userData );

// Cancelling
void OperationCancel( NSOperation *ref );

// Status
BOOL OperationIsCancelled( NSOperation *ref );
BOOL OperationIsExecuting( NSOperation *ref );
BOOL OperationIsFinished( NSOperation *ref );
BOOL OperationIsConcurrent( NSOperation *ref );

BOOL OperationIsAsynchronous( NSOperation *ref );

BOOL OperationIsReady( NSOperation *ref );

CFStringRef OperationName( NSOperation *ref );
void OperationSetName( NSOperation *ref, CFStringRef name );

// Dependencies
void OperationAddDependency( NSOperation *op1, NSOperation *op2 );
void OperationRemoveDependency( NSOperation *op1, NSOperation *op2 );
CFArrayRef OperationDependencies( NSOperation *ref );

// Execution priority
NSQualityOfService OperationQualityOfService( NSOperation *ref );
void OperationSetQualityOfService( NSOperation *ref, NSQualityOfService qos );

NSOperationQueuePriority OperationQueuePriority( NSOperation *ref );
void OperationSetQueuePriority( NSOperation *ref, NSOperationQueuePriority priority );

// Waiting
void OperationWaitUntilFinished( NSOperation *ref );


#pragma mark - OperationQueue

typedef void (*CUI_OperationQueueFunctionCallbackType)(NSOperationQueue *,CFTypeRef);

// Init
NSOperationQueue *OperationQueueInit( void );

// Get specific queues
NSOperationQueue *OperationQueueMain( void );
NSOperationQueue *OperationQueueCurrent( void );

// Managing operations
void OperationQueueAddOperation( NSOperationQueue *ref, NSOperation *op );
void OperationQueueAddOperations( NSOperationQueue *ref, CFArrayRef ops, BOOL waitUntilFinished );
void OperationQueueAddOperationWithCallback( NSOperationQueue *ref, CUI_OperationQueueFunctionCallbackType callback, CFTypeRef obj );
void OperationQueueAddOperationWithFunction( NSOperationQueue *ref, CUI_OperationQueueFunctionCallbackType fnAddress, CFTypeRef obj );
CFArrayRef OperationQueueOperations( NSOperationQueue *ref );
NSUInteger OperationQueueOperationCount( NSOperationQueue *ref );
void OperationQueueCancelAllOperations( NSOperationQueue *ref );
void OperationQueueWaitUntilAllOperationsAreFinished( NSOperationQueue *ref );

// Managing execution
NSQualityOfService OperationQueueQualityOfService( NSOperationQueue *ref );
void OperationQueueSetQualityOfService( NSOperationQueue *ref, NSQualityOfService qos );

NSInteger OperationQueueMaxConcurrentOperationCount( NSOperationQueue *ref );
void OperationQueueSetMaxConcurrentOperationCount( NSOperationQueue *ref, NSInteger count );

// Suspending
BOOL OperationQueueIsSuspended( NSOperationQueue *ref );
void OperationQueueSetSuspended( NSOperationQueue *ref, BOOL flag );

// Configure
CFStringRef OperationQueueName( NSOperationQueue *ref );
void OperationQueueSetName( NSOperationQueue *ref, CFStringRef name );

dispatch_queue_t OperationQueueUnderlyingQueue( NSOperationQueue *ref );
void OperationQueueSetUnderlyingQueue( NSOperationQueue *ref, dispatch_queue_t dq );

// Properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
NSProgress *OperationQueueProgress( NSOperationQueue *ref );
#endif


#pragma mark - InvocationOperation

typedef void (*CUI_InvocationOperationCallbackType)(id);

@interface CUI_InvocationOperation : NSInvocationOperation {
//    CUI_InvocationOperationCallbackType callback;
}

@property (nonatomic,assign) CUI_InvocationOperationCallbackType callback;

- (id)initWithCallback:(CUI_InvocationOperationCallbackType)cb object:(id)object;
- (void)action:(id)object;
@end


// Init
NSInvocationOperation *InvocationOperationWithTarget( CFTypeRef target, SEL selector, CFTypeRef obj );
NSInvocationOperation *InvocationOperationWithTargetAndSelectorString( CFTypeRef target, CFStringRef string, CFTypeRef obj );
NSInvocationOperation *InvocationOperationWithInvocation( NSInvocation *invocation );

// Attributes
NSInvocation *InvocationOperationInvocation( NSInvocationOperation *ref );
CFTypeRef InvocationOperationResult( NSInvocationOperation *ref );


#pragma mark - BlockOperation
typedef void (*CUI_BlockOperationCallbackType)(void *);
typedef void (*CUI_BlockOperationBlockType)(void);

// Manage
NSBlockOperation *BlockOperationWithCallback( CUI_BlockOperationCallbackType callback, void *userData );
void BlockOperationAddCallback( NSBlockOperation *ref, CUI_BlockOperationCallbackType callback, void *userData );
CFArrayRef BlockOperationBlocks( NSBlockOperation *ref );

NSBlockOperation *BlockOperationWithBlock( CUI_BlockOperationBlockType callback );
void BlockOperationAddBlock( NSBlockOperation *ref, CUI_BlockOperationBlockType callback );

