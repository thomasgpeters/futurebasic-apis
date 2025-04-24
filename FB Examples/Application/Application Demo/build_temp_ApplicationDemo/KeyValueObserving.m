/*
 KeyValueObserving.m

 Bernie Wylde
 */

#import "KeyValueObserving.h"

static NSMutableArray *sCUI_KeyValueObservingObjects;

@implementation CUI_KeyValueObservingObserver
#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.object release];
    [self.keyPath release];
    [super dealloc];
}
#endif

// observer callback
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ( self.observerCallback ) (*self.observerCallback)( (__bridge CFTypeRef)object, (__bridge CFStringRef)keyPath, (__bridge CFDictionaryRef)change, context );
}

@end

// Register
//void KeyValueObservingAddObserver( CFTypeRef obj, CFStringRef keyPath, NSKeyValueObservingOptions options, CUI_KeyValueObservingObserverType callback, void *context )
//{
//    if ( !sCUI_KeyValueObservingObjects ) sCUI_KeyValueObservingObjects = [[NSMutableArray alloc] initWithCapacity:0];
//    CUI_KeyValueObservingObserver *observer = [[CUI_KeyValueObservingObserver alloc] init];
//    [observer setObject:(__bridge id)obj];
//    [observer setKeyPath:(__bridge NSString *)keyPath];
//    [observer setObserverCallback:callback];
//    [observer setObserverContext:context];
//    [sCUI_KeyValueObservingObjects addObject:observer];
//    [(__bridge id)obj addObserver:observer forKeyPath:(__bridge NSString *)keyPath options:options context:context];
//}
//
//void KeyValueObservingRemoveObserver( CFTypeRef obj, CFStringRef keyPath )
//{
//    if ( sCUI_KeyValueObservingObjects ) {
//        for ( CUI_KeyValueObservingObserver *observer in sCUI_KeyValueObservingObjects ) {
//            if ( [[observer object] isEqualTo:(__bridge id)obj] && [[observer keyPath] isEqualToString:(__bridge NSString *)keyPath] ) {
//                [(__bridge id)obj removeObserver:observer forKeyPath:(__bridge NSString *)keyPath];
//                [sCUI_KeyValueObservingObjects removeObject:observer];
//                break;
//            }
//        }
//    }
//}
//
//void KeyValueObservingRemoveObserverForContext( CFTypeRef obj, CFStringRef keyPath, void *context )
//{
//    if ( sCUI_KeyValueObservingObjects ) {
//        for ( CUI_KeyValueObservingObserver *observer in sCUI_KeyValueObservingObjects ) {
//            if ( [[observer object] isEqualTo:(__bridge id)obj] && [[observer keyPath] isEqualToString:(__bridge NSString *)keyPath] && [observer observerContext] == context ) {
//                [(__bridge id)obj removeObserver:observer forKeyPath:(__bridge NSString *)keyPath context:context];
//                [sCUI_KeyValueObservingObjects removeObject:observer];
//                break;
//            }
//        }
//    }
//}
//
//// Notify of changes
//void KeyValueObservingWillChangeValue( CFTypeRef obj, CFStringRef key )
//{ [(__bridge id)obj willChangeValueForKey:(__bridge NSString *)key]; }
//
//void KeyValueObservingDidChangeValue( CFTypeRef obj, CFStringRef key )
//{ [(__bridge id)obj didChangeValueForKey:(__bridge NSString *)key]; }
//
//void KeyValueObservingWillChangeValues( CFTypeRef obj, NSKeyValueChange changeKind, NSIndexSet *indexes, CFStringRef key )
//{ [(__bridge id)obj willChange:changeKind valuesAtIndexes:indexes forKey:(__bridge NSString *)key]; }
//
//void KeyValueObservingDidChangeValues( CFTypeRef obj, NSKeyValueChange changeKind, NSIndexSet *indexes, CFStringRef key )
//{ [(__bridge id)obj didChange:changeKind valuesAtIndexes:indexes forKey:(__bridge NSString *)key]; }
//
//void KeyValueObservingWillChangeValueWithSetMutation( CFTypeRef obj, CFStringRef key, NSKeyValueSetMutationKind mutationKind, CFSetRef objects )
//{ [(__bridge id)obj willChangeValueForKey:(__bridge NSString *)key withSetMutation:mutationKind usingObjects:(__bridge NSSet *)objects]; }
//
//void KeyValueObservingDidChangeValueWithSetMutation( CFTypeRef obj, CFStringRef key, NSKeyValueSetMutationKind mutationKind, CFSetRef objects )
//{ [(__bridge id)obj didChangeValueForKey:(__bridge NSString *)key withSetMutation:mutationKind usingObjects:(__bridge NSSet *)objects]; }

// Customization



// Register
void ObjectAddObserver( CFTypeRef obj, CFStringRef keyPath, NSKeyValueObservingOptions options, CUI_KeyValueObservingObserverType callback, void *context )
{
    if ( !sCUI_KeyValueObservingObjects ) sCUI_KeyValueObservingObjects = [[NSMutableArray alloc] initWithCapacity:0];
    CUI_KeyValueObservingObserver *observer = [[CUI_KeyValueObservingObserver alloc] init];
    [observer setObject:(__bridge id)obj];
    [observer setKeyPath:(__bridge NSString *)keyPath];
    [observer setObserverCallback:callback];
    [observer setObserverContext:context];
    [sCUI_KeyValueObservingObjects addObject:observer];
    [(__bridge id)obj addObserver:observer forKeyPath:(__bridge NSString *)keyPath options:options context:context];
}

void ObjectRemoveObserver( CFTypeRef obj, CFStringRef keyPath )
{
    if ( sCUI_KeyValueObservingObjects ) {
        for ( CUI_KeyValueObservingObserver *observer in sCUI_KeyValueObservingObjects ) {
            if ( [[observer object] isEqualTo:(__bridge id)obj] && [[observer keyPath] isEqualToString:(__bridge NSString *)keyPath] ) {
                [(__bridge id)obj removeObserver:observer forKeyPath:(__bridge NSString *)keyPath];
                [sCUI_KeyValueObservingObjects removeObject:observer];
                break;
            }
        }
    }
}

void ObjectRemoveObserverForContext( CFTypeRef obj, CFStringRef keyPath, void *context )
{
    if ( sCUI_KeyValueObservingObjects ) {
        for ( CUI_KeyValueObservingObserver *observer in sCUI_KeyValueObservingObjects ) {
            if ( [[observer object] isEqualTo:(__bridge id)obj] && [[observer keyPath] isEqualToString:(__bridge NSString *)keyPath] && [observer observerContext] == context ) {
                [(__bridge id)obj removeObserver:observer forKeyPath:(__bridge NSString *)keyPath context:context];
                [sCUI_KeyValueObservingObjects removeObject:observer];
                break;
            }
        }
    }
}

// Notify of changes
void ObjectWillChangeValue( CFTypeRef obj, CFStringRef key )
{ [(__bridge id)obj willChangeValueForKey:(__bridge NSString *)key]; }

void ObjectDidChangeValue( CFTypeRef obj, CFStringRef key )
{ [(__bridge id)obj didChangeValueForKey:(__bridge NSString *)key]; }

void ObjectWillChangeValues( CFTypeRef obj, NSKeyValueChange changeKind, NSIndexSet *indexes, CFStringRef key )
{ [(__bridge id)obj willChange:changeKind valuesAtIndexes:indexes forKey:(__bridge NSString *)key]; }

void ObjectDidChangeValues( CFTypeRef obj, NSKeyValueChange changeKind, NSIndexSet *indexes, CFStringRef key )
{ [(__bridge id)obj didChange:changeKind valuesAtIndexes:indexes forKey:(__bridge NSString *)key]; }

void ObjectWillChangeValueWithSetMutation( CFTypeRef obj, CFStringRef key, NSKeyValueSetMutationKind mutationKind, CFSetRef objects )
{ [(__bridge id)obj willChangeValueForKey:(__bridge NSString *)key withSetMutation:mutationKind usingObjects:(__bridge NSSet *)objects]; }

void ObjectDidChangeValueWithSetMutation( CFTypeRef obj, CFStringRef key, NSKeyValueSetMutationKind mutationKind, CFSetRef objects )
{ [(__bridge id)obj didChangeValueForKey:(__bridge NSString *)key withSetMutation:mutationKind usingObjects:(__bridge NSSet *)objects]; }

// Customization
