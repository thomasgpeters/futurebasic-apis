/*
 Progress.m

 Bernie Wylde
 */

#import "Progress.h"

// Class
Class ProgressClass( void )
{ return [NSProgress class]; }

// Create
NSProgress *ProgressWithParent( NSProgress *parent, CFDictionaryRef userInfo )
{
#if __has_feature(objc_arc)
    return [[NSProgress alloc] initWithParent:parent userInfo:(__bridge NSDictionary *)userInfo];
#else
    return [[[NSProgress alloc] initWithParent:parent userInfo:(__bridge NSDictionary *)userInfo] autorelease];
#endif
}

NSProgress *ProgressDiscreteWithTotalUnitCount( SInt64 totalUnitCount )
{ return [NSProgress discreteProgressWithTotalUnitCount:totalUnitCount]; }

NSProgress *ProgressWithTotalUnitCount( SInt64 totalUnitCount )
{ return [NSProgress progressWithTotalUnitCount:totalUnitCount]; }

NSProgress *ProgressWithPendingUnitCount( SInt64 totalUnitCount, NSProgress *parent, SInt64 pendingUnitCount )
{ return [NSProgress progressWithTotalUnitCount:totalUnitCount parent:parent pendingUnitCount:pendingUnitCount]; }

// Current
NSProgress *ProgressCurrent( void )
{ return [NSProgress currentProgress]; }

void ProgressBecomeCurrent( NSProgress *ref, SInt64 pendingUnitCount )
{ [ref becomeCurrentWithPendingUnitCount:pendingUnitCount]; }

void ProgressAddChild( NSProgress *ref, NSProgress *child, SInt64 pendingUnitCount )
{ [ref addChild:child withPendingUnitCount:pendingUnitCount]; }

void ProgressResignCurrent( NSProgress *ref )
{ [ref resignCurrent]; }

// Reporting
SInt64 ProgressTotalUnitCount( NSProgress *ref )
{ return [ref totalUnitCount]; }

void ProgressSetTotalUnitCount( NSProgress *ref, SInt64 count )
{ [ref setTotalUnitCount:count]; }

SInt64 ProgressCompletedUnitCount( NSProgress *ref )
{ return [ref completedUnitCount]; }

void ProgressSetCompletedUnitCount( NSProgress *ref, SInt64 count )
{ [ref setCompletedUnitCount:count]; }

CFStringRef ProgressLocalizedDescription( NSProgress *ref )
{ return (__bridge CFStringRef)[ref localizedDescription]; }

CFStringRef ProgressLocalizedAdditionalDescription( NSProgress *ref )
{ return (__bridge CFStringRef)[ref localizedAdditionalDescription]; }

// Observing
double ProgressFractionCompleted( NSProgress *ref )
{ return [ref fractionCompleted]; }

// Controlling
BOOL ProgressIsCancellable( NSProgress *ref )
{ return [ref isCancellable]; }

void ProgressIsSetCancellable( NSProgress *ref, BOOL flag )
{ [ref setCancellable:flag]; }

BOOL ProgressIsCancelled( NSProgress *ref )
{ return [ref isCancelled]; }

void ProgressCancel( NSProgress *ref )
{ [ref cancel]; }

void ProgressSetCancellationHandler( NSProgress *ref, CUI_ProgressHandlerType handler, void *userData )
{
//    __unsafe_unretained typeof(ref) weakRef = ref;
//    [ref setCancellationHandler:^(void) {
//        (*handler)(weakRef,userData);
//    }];
    
    [ref setCancellationHandler:^(void) {
        (*handler)(ref,userData);
    }];
}

BOOL ProgressIsPausable( NSProgress *ref )
{ return [ref isPausable]; }

void ProgressIsSetPausable( NSProgress *ref, BOOL flag )
{ [ref setPausable:flag]; }

BOOL ProgressIsPaused( NSProgress *ref )
{ return [ref isPaused]; }

void ProgressPause( NSProgress *ref )
{ [ref pause]; }

void ProgressSetPausingHandler( NSProgress *ref, CUI_ProgressHandlerType handler, void *userData )
{
//    __unsafe_unretained typeof(ref) weakRef = ref;
//    [ref setPausingHandler:^(void) {
//        (*handler)(weakRef,userData);
//    }];
    
    [ref setPausingHandler:^(void) {
        (*handler)(ref,userData);
    }];

}

void ProgressResume( NSProgress *ref )
{ [ref resume]; }

void ProgressSetResumingHandler( NSProgress *ref, CUI_ProgressHandlerType handler, void *userData )
{
//    __unsafe_unretained typeof(ref) weakRef = ref;
//    [ref setResumingHandler:^(void) {
//        (*handler)(weakRef,userData);
//    }];
    
    [ref setResumingHandler:^(void) {
        (*handler)(ref,userData);
    }];
}

// Info
BOOL ProgressIsIndeterminate( NSProgress *ref )
{ return [ref isIndeterminate]; }

CFStringRef ProgressKind( NSProgress *ref )
{ return (__bridge CFStringRef)[ref kind]; }

void ProgressSetKind( NSProgress *ref, CFStringRef kind )
{ [ref setKind:(__bridge NSString *)kind]; }

void ProgressSetUserInfoObject( NSProgress *ref, CFTypeRef obj, CFStringRef key )
{ [ref setUserInfoObject:(__bridge id)obj forKey:(__bridge NSString *)key]; }

CFDictionaryRef ProgressUserInfo( NSProgress *ref )
{ return (__bridge CFDictionaryRef)[ref userInfo]; }

// Instance properties

CFStringRef ProgressFileOperationKind( NSProgress *ref )
{ return (__bridge CFStringRef)[ref fileOperationKind]; }

void ProgressSetFileOperationKind( NSProgress *ref, CFStringRef kind )
{ [ref setFileOperationKind:(__bridge NSString *)kind]; }

CFURLRef ProgressFileURL( NSProgress *ref )
{ return (__bridge CFURLRef)[ref fileURL]; }

void ProgressSetFileURL( NSProgress *ref, CFURLRef url )
{ [ref setFileURL:(__bridge NSURL *)url]; }

BOOL ProgressIsFinished( NSProgress *ref )
{ return [ref isFinished]; }

BOOL ProgressIsOld( NSProgress *ref )
{ return [ref isOld]; }

CFNumberRef ProgressEstimatedTimeRemaining( NSProgress *ref )
{ return (__bridge CFNumberRef)[ref estimatedTimeRemaining]; }

void ProgressSetEstimatedTimeRemaining( NSProgress *ref, CFNumberRef number )
{ [ref setEstimatedTimeRemaining:(__bridge NSNumber *)number]; }

CFNumberRef ProgressFileCompletedCount( NSProgress *ref )
{ return (__bridge CFNumberRef)[ref fileCompletedCount]; }

void ProgressSetFileCompletedCount( NSProgress *ref, CFNumberRef number )
{ [ref setFileCompletedCount:(__bridge NSNumber *)number]; }

CFNumberRef ProgressFileTotalCount( NSProgress *ref )
{ return (__bridge CFNumberRef)[ref fileTotalCount]; }

void ProgressSetFileTotalCount( NSProgress *ref, CFNumberRef number )
{ [ref setFileTotalCount:(__bridge NSNumber *)number]; }

CFNumberRef ProgressThroughput( NSProgress *ref )
{ return (__bridge CFNumberRef)[ref throughput]; }

void ProgressSetThroughput( NSProgress *ref, CFNumberRef number )
{ [ref setThroughput:(__bridge NSNumber *)number]; }

// Instance methods
void ProgressPublish( NSProgress *ref )
{ [ref publish]; }

void ProgressUnpublish( NSProgress *ref )
{ [ref unpublish]; }

void ProgressPerformAsCurrent( NSProgress *ref, SInt64 pendingUnitCount, CUI_ProgressHandlerType callback, void *userData )
{
    [ref performAsCurrentWithPendingUnitCount:pendingUnitCount usingBlock:^(void) {
        (*callback)(ref,userData);
    }];
}

// Type methods
CFTypeRef ProgressAddSubscriberForFileURL( CFURLRef url, CUI_ProgressHandlerType publishingHandler, void *userData )
{
    return (__bridge CFTypeRef)[NSProgress addSubscriberForFileURL:(__bridge NSURL *)url withPublishingHandler:^NSProgressUnpublishingHandler(NSProgress *progress) {
        (*publishingHandler)(progress,userData);
        return nil;
    }];
}

void ProgressRemoveSubscriber( CFTypeRef subscriber )
{ [NSProgress removeSubscriber:(__bridge id)subscriber]; }

