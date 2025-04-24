/*
 KeyValueObserving.h

 Bernie Wylde
 */

#import "CocoaUI.h"

typedef void (*CUI_KeyValueObservingObserverType)(CFTypeRef,CFStringRef,CFDictionaryRef,void*);

@interface CUI_KeyValueObservingObserver : NSObject
@property (nonatomic,strong) id object;
@property (nonatomic,strong) NSString *keyPath;
@property (nonatomic,assign) CUI_KeyValueObservingObserverType observerCallback;
@property (nonatomic,assign) void *observerContext;

@end


// Register
//void KeyValueObservingAddObserver( CFTypeRef obj, CFStringRef keyPath, NSKeyValueObservingOptions options, CUI_KeyValueObservingObserverType callback, void *context );
//void KeyValueObservingRemoveObserver( CFTypeRef obj, CFStringRef keyPath );
//void KeyValueObservingRemoveObserverForContext( CFTypeRef obj, CFStringRef keyPath, void *context );
//
//// Notify of changes
//void KeyValueObservingWillChangeValue( CFTypeRef obj, CFStringRef key );
//void KeyValueObservingDidChangeValue( CFTypeRef obj, CFStringRef key );
//void KeyValueObservingWillChangeValues( CFTypeRef obj, NSKeyValueChange changeKind, NSIndexSet *indexes, CFStringRef key );
//void KeyValueObservingDidChangeValues( CFTypeRef obj, NSKeyValueChange changeKind, NSIndexSet *indexes, CFStringRef key );
//void KeyValueObservingWillChangeValueWithSetMutation( CFTypeRef obj, CFStringRef key, NSKeyValueSetMutationKind mutationKind, CFSetRef objects );
//void KeyValueObservingDidChangeValueWithSetMutation( CFTypeRef obj, CFStringRef key, NSKeyValueSetMutationKind mutationKind, CFSetRef objects );

// Customization


// Register
void ObjectAddObserver( CFTypeRef obj, CFStringRef keyPath, NSKeyValueObservingOptions options, CUI_KeyValueObservingObserverType callback, void *context );
void ObjectRemoveObserver( CFTypeRef obj, CFStringRef keyPath );
void ObjectRemoveObserverForContext( CFTypeRef obj, CFStringRef keyPath, void *context );

// Notify of changes
void ObjectWillChangeValue( CFTypeRef obj, CFStringRef key );
void ObjectDidChangeValue( CFTypeRef obj, CFStringRef key );
void ObjectWillChangeValues( CFTypeRef obj, NSKeyValueChange changeKind, NSIndexSet *indexes, CFStringRef key );
void ObjectDidChangeValues( CFTypeRef obj, NSKeyValueChange changeKind, NSIndexSet *indexes, CFStringRef key );
void ObjectWillChangeValueWithSetMutation( CFTypeRef obj, CFStringRef key, NSKeyValueSetMutationKind mutationKind, CFSetRef objects );
void ObjectDidChangeValueWithSetMutation( CFTypeRef obj, CFStringRef key, NSKeyValueSetMutationKind mutationKind, CFSetRef objects );

// Customization
