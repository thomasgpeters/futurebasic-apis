/*
 Progress.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef void (*CUI_ProgressHandlerType)(NSProgress*,void *);

// Class
Class ProgressClass( void );

// Create
NSProgress *ProgressWithParent( NSProgress *parent, CFDictionaryRef userInfo );
NSProgress *ProgressDiscreteWithTotalUnitCount( SInt64 totalUnitCount );
NSProgress *ProgressWithTotalUnitCount( SInt64 totalUnitCount );
NSProgress *ProgressWithPendingUnitCount( SInt64 totalUnitCount, NSProgress *parent, SInt64 pendingUnitCount );

// Current
NSProgress *ProgressCurrent( void );
void ProgressBecomeCurrent( NSProgress *ref, SInt64 pendingUnitCount );
void ProgressAddChild( NSProgress *ref, NSProgress *child, SInt64 pendingUnitCount );
void ProgressResignCurrent( NSProgress *ref );

// Reporting
SInt64 ProgressTotalUnitCount( NSProgress *ref );
void ProgressSetTotalUnitCount( NSProgress *ref, SInt64 count );
SInt64 ProgressCompletedUnitCount( NSProgress *ref );
void ProgressSetCompletedUnitCount( NSProgress *ref, SInt64 count );
CFStringRef ProgressLocalizedDescription( NSProgress *ref );
CFStringRef ProgressLocalizedAdditionalDescription( NSProgress *ref );

// Observing
double ProgressFractionCompleted( NSProgress *ref );

// Controlling
BOOL ProgressIsCancellable( NSProgress *ref );
void ProgressIsSetCancellable( NSProgress *ref, BOOL flag );
BOOL ProgressIsCancelled( NSProgress *ref );
void ProgressCancel( NSProgress *ref );
void ProgressSetCancellationHandler( NSProgress *ref, CUI_ProgressHandlerType handler, void *userData );
BOOL ProgressIsPausable( NSProgress *ref );
void ProgressIsSetPausable( NSProgress *ref, BOOL flag );
BOOL ProgressIsPaused( NSProgress *ref );
void ProgressPause( NSProgress *ref );
void ProgressSetPausingHandler( NSProgress *ref, CUI_ProgressHandlerType handler, void *userData );
void ProgressResume( NSProgress *ref );
void ProgressSetResumingHandler( NSProgress *ref, CUI_ProgressHandlerType handler, void *userData );

// Info
BOOL ProgressIsIndeterminate( NSProgress *ref );
CFStringRef ProgressKind( NSProgress *ref );
void ProgressSetKind( NSProgress *ref, CFStringRef kind );
void ProgressSetUserInfoObject( NSProgress *ref, CFTypeRef obj, CFStringRef key );
CFDictionaryRef ProgressUserInfo( NSProgress *ref );

// Instance properties
CFStringRef ProgressFileOperationKind( NSProgress *ref );
void ProgressSetFileOperationKind( NSProgress *ref, CFStringRef kind );
CFURLRef ProgressFileURL( NSProgress *ref );
void ProgressSetFileURL( NSProgress *ref, CFURLRef url );
BOOL ProgressIsFinished( NSProgress *ref );
BOOL ProgressIsOld( NSProgress *ref );
CFNumberRef ProgressEstimatedTimeRemaining( NSProgress *ref );
void ProgressSetEstimatedTimeRemaining( NSProgress *ref, CFNumberRef number );
CFNumberRef ProgressFileCompletedCount( NSProgress *ref );
void ProgressSetFileCompletedCount( NSProgress *ref, CFNumberRef number );
CFNumberRef ProgressFileTotalCount( NSProgress *ref );
void ProgressSetFileTotalCount( NSProgress *ref, CFNumberRef number );
CFNumberRef ProgressThroughput( NSProgress *ref );
void ProgressSetThroughput( NSProgress *ref, CFNumberRef number );

// Instance methods
void ProgressPublish( NSProgress *ref );
void ProgressUnpublish( NSProgress *ref );
void ProgressPerformAsCurrent( NSProgress *ref, SInt64 pendingUnitCount, CUI_ProgressHandlerType callback, void *userData );

// Type methods
CFTypeRef ProgressAddSubscriberForFileURL( CFURLRef url, CUI_ProgressHandlerType publishingHandler, void *userData );
void ProgressRemoveSubscriber( CFTypeRef subscriber );

