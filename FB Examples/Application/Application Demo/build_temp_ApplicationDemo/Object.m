/*
 Object.m

 Bernie Wylde
 */

#import "Object.h"

@implementation CUI_ObjectTarget

- (void)objectSelector:(id)object {
    (*self.callback)(object);
}
@end

@implementation NSObject (Additions)

@dynamic IDNumber;

//@dynamic tagNumber;// 20200323

@dynamic wndTagNumber;
@dynamic objProperties;

- (NSInteger)ID {
    return [objc_getAssociatedObject(self, @selector(IDNumber)) integerValue];
}

- (void)setID:(NSInteger)ID {
    objc_setAssociatedObject(self, @selector(IDNumber), [NSNumber numberWithInteger:ID], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)wndTag {
    return [objc_getAssociatedObject(self, @selector(wndTagNumber)) integerValue];
}

- (void)setWndTag:(NSInteger)tag {
    objc_setAssociatedObject(self, @selector(wndTagNumber), [NSNumber numberWithInteger:tag], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)objectProperties {
    return objc_getAssociatedObject(self, @selector(objProperties));
}

- (void)setObjectProperties:(NSMutableDictionary *)properties {
    objc_setAssociatedObject(self, @selector(objProperties), properties, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

#pragma mark - private
NSMutableArray *CUI_Objects( void )
{
    static NSMutableArray *sCUI_Objects;
    if ( !sCUI_Objects ) sCUI_Objects = [[NSMutableArray alloc] initWithCapacity:0];
    return sCUI_Objects;
}


#pragma mark - public
//NSInteger ObjectTag( id obj )// 20200323
//{ return [(NSObject *)obj tag]; }
//
//void ObjectSetTag( id obj, NSInteger tag )// 20200323
//{ [(NSObject *)obj setTag:tag]; }
//
//id ObjectWithTag( NSInteger tag )// 20200323
//{
//    // ???
//    return nil;
//}


// Init
NSObject *ObjectInit( void )
{
#if __has_feature(objc_arc)
    return [[NSObject alloc] init];
#else
    return [[[NSObject alloc] init] autorelease];
#endif
}

// - create, copy, dealloc -
id ObjectCopy( id obj )
{
#if __has_feature(objc_arc)
    return (__bridge id)[(__bridge id)obj copy];
#else
    return (__bridge id)[[(__bridge id)obj copy] autorelease];
#endif
}

id ObjectMutableCopy( id obj )
{
#if __has_feature(objc_arc)
    return (__bridge id)[(__bridge id)obj mutableCopy];
#else
    return (__bridge id)[[(__bridge id)obj mutableCopy] autorelease];
#endif
}


//id ObjectNSClassFromCF( id obj )
//{
//    CFTypeID type = CFGetTypeID(obj);
//    switch ( type ) {
//        case CFArrayGetTypeID():
//            return [NSArray class];
//        case CFDictionaryGetTypeID():
//            return [NSDictionary class];
//        case CFStringGetTypeID():
//            return [NSString class];
//        default:
//            break;
//    }
//    return [(__bridge id)obj class]
//}


Class ObjectClass( id obj )
{
    // should check for CF type here and return NS equivalent
    return [(__bridge id)obj class];
}

Class ObjectSuperclass( id obj )
{ return [(__bridge id)obj superclass]; }


// - identify class -
BOOL ObjectIsSubclassOfClass( id obj, Class class )
{ return [(__bridge id)obj isSubclassOfClass:class]; }


// Description
CFStringRef ObjectDescription( id obj )
{ return (__bridge CFStringRef)[(__bridge id)obj description]; }

// Method info
IMP ObjectMethodForSelector( id obj, SEL selector )
{ return [(__bridge id)obj methodForSelector:selector]; }

IMP ObjectInstanceMethodForSelector( Class cls, SEL selector )
{ return [cls instanceMethodForSelector:selector]; }

//NSMethodSignature *ObjectInstanceMethodSignatureForSelector( id obj, SEL selector )
//{ return [(__bridge id)obj instanceMethodSignatureForSelector:selector]; }

NSMethodSignature *ObjectInstanceMethodSignatureForSelector( Class cls, SEL selector )
{ return [cls instanceMethodSignatureForSelector:selector]; }

NSMethodSignature *ObjectMethodSignatureForSelector( id obj, SEL selector )
{ return [(__bridge id)obj methodSignatureForSelector:selector]; }

// Sending messages
void ObjectPerformSelector( id obj, CFStringRef selector, id withObj, CFTimeInterval afterDelay )
{ [(__bridge id)obj performSelector:NSSelectorFromString((__bridge NSString *)selector) withObject:(__bridge id)withObj afterDelay:afterDelay]; }

void ObjectPerformSelectorOnMainThread( id obj, id selector, id withObj, BOOL waitUntilDone )
{
//    SEL sel = CUI_FixSelector( selector );
//    [(__bridge id)obj performSelectorOnMainThread:sel withObject:(__bridge id)withObj waitUntilDone:waitUntilDone];

    [(__bridge id)obj performSelectorOnMainThread:NSSelectorFromString((__bridge NSString *)selector) withObject:(__bridge id)withObj waitUntilDone:waitUntilDone];
    
}

void ObjectPerformSelectorInBackground( id obj, CFStringRef selector, id withObj )
{ [(__bridge id)obj performSelectorInBackground:NSSelectorFromString((__bridge NSString *)selector) withObject:(__bridge id)withObj]; }

// Scripting
CFStringRef ObjectClassName( id obj )
{ return (__bridge CFStringRef)[(__bridge id)obj className]; }

// - instance methods -
BOOL ObjectIsEqual( id obj1, id obj2 )
{ return [(__bridge id)obj1 isEqual:(__bridge id)obj2]; }

//void ObjectSetValueForKey( id obj, id value, CFStringRef key )
//{ [(NSObject *)obj setValue:(__bridge id)value forKey:(__bridge NSString *)key]; }
//
//id ObjectValueForKey( id obj, CFStringRef key )
//{ return (__bridge id)[(__bridge id)obj valueForKey:(__bridge NSString *)key]; }


// -- NSObject protocol methods --
BOOL ObjectIsKindOfClass( id obj, Class class )
{ return [(__bridge id)obj isKindOfClass:class]; }

// Retain/release
id ObjectRetain( id obj )
{ return [obj retain]; }

void ObjectRelease( id obj )
{ [obj release]; }


#pragma mark - NSScriptWhoseTests
BOOL ObjectIsEqualTo( ObjectRef obj, ObjectRef otherObj )
{ return [obj isEqualTo:otherObj]; }

BOOL ObjectIsGreaterThan( ObjectRef obj, ObjectRef otherObj )
{ return [obj isGreaterThan:otherObj]; }

BOOL ObjectIsGreaterThanOrEqualTo( ObjectRef obj, ObjectRef otherObj )
{ return [obj isGreaterThanOrEqualTo:otherObj]; }

BOOL ObjectIsLessThan( ObjectRef obj, ObjectRef otherObj )
{ return [obj isLessThan:otherObj]; }

BOOL ObjectIsLessThanOrEqualTo( ObjectRef obj, ObjectRef otherObj )
{ return [obj isLessThanOrEqualTo:otherObj]; }

BOOL ObjectIsNotEqualTo( ObjectRef obj, ObjectRef otherObj )
{ return [obj isNotEqualTo:otherObj]; }





/*
 Custom
 */
// Call function
void ObjectCallFunction( CUI_ObjectPerformFunctionCallbackType fnAddress, id withObj, CFTimeInterval afterDelay )
{
    CUI_ObjectTarget *target = [[CUI_ObjectTarget alloc] init];
    [target setCallback:fnAddress];
    [target performSelector:@selector(objectSelector:) withObject:(__bridge id)withObj afterDelay:afterDelay];
}

void ObjectCallFunctionOnMainThread( CUI_ObjectPerformFunctionCallbackType fnAddress, id withObj, BOOL waitUntilDone )
{
    CUI_ObjectTarget *target = [[CUI_ObjectTarget alloc] init];
    [target setCallback:fnAddress];
    [target performSelectorOnMainThread:@selector(objectSelector:) withObject:(__bridge id)withObj waitUntilDone:waitUntilDone];
}

void ObjectCallFunctionInBackground( CUI_ObjectPerformFunctionCallbackType fnAddress, id withObj )
{
    CUI_ObjectTarget *target = [[CUI_ObjectTarget alloc] init];
    [target setCallback:fnAddress];
    [target performSelectorInBackground:@selector(objectSelector:) withObject:(__bridge id)withObj];
}

// Object property
id ObjectProperty( id obj, CFStringRef key )
{
    id property = nil;
    NSMutableDictionary *properties = [(__bridge id)obj objectProperties];
    if ( properties ) {
        property = [properties objectForKey:(__bridge NSString *)key];
    }
    return (__bridge id)property;
}

void ObjectSetProperty( id obj, CFStringRef key, id value )
{
    NSMutableDictionary *properties = [(__bridge id)obj objectProperties];
    if ( !properties ) {
        properties = [[NSMutableDictionary alloc] initWithCapacity:0];
        [(__bridge id)obj setObjectProperties:properties];
    }
    if ( value == NULL ) {
        [properties removeObjectForKey:(__bridge NSString *)key];
        if ( [properties count] == 0 ) {
#if !__has_feature(objc_arc)
            [properties release];
#endif
            [(__bridge id)obj setObjectProperties:nil];
        }
    } else {
        [properties setObject:(__bridge id)value forKey:(__bridge NSString *)key];
    }
}

void ObjectPropertySet( id obj, CFStringRef key, id value )
{
    NSMutableDictionary *properties = [(__bridge id)obj objectProperties];
    if ( !properties ) {
        properties = [[NSMutableDictionary alloc] initWithCapacity:0];
        [(__bridge id)obj setObjectProperties:properties];
    }
    if ( value == NULL ) {
        [properties removeObjectForKey:(__bridge NSString *)key];
        if ( [properties count] == 0 ) {
#if !__has_feature(objc_arc)
            [properties release];
#endif
            [(__bridge id)obj setObjectProperties:nil];
        }
    } else {
        [properties setObject:(__bridge id)value forKey:(__bridge NSString *)key];
    }
}

BOOL ObjectPropertyBool( id obj, CFStringRef key )
{
    NSNumber *number = (__bridge NSNumber *)ObjectProperty( obj, key );
    if ( number ) return [number boolValue];
    return NO;
}

void ObjectPropertySetBool( id obj, CFStringRef key, BOOL value )
{ ObjectPropertySet( obj, key, (__bridge id)@(value) ); }

long ObjectPropertyLong( id obj, CFStringRef key )
{
    NSNumber *number = (__bridge NSNumber *)ObjectProperty( obj, key );
    if ( number ) return [number longValue];
    return 0;
}

void ObjectPropertySetLong( id obj, CFStringRef key, long value )
{ ObjectPropertySet( obj, key, (__bridge id)@(value) ); }

double ObjectPropertyDouble( id obj, CFStringRef key )
{
    NSNumber *number = (__bridge NSNumber *)ObjectProperty( obj, key );
    if ( number ) return [number doubleValue];
    return 0.0;
}

void ObjectPropertySetDouble( id obj, CFStringRef key, double value )
{ ObjectPropertySet( obj, key, (__bridge id)@(value) ); }

CGRect ObjectPropertyRect( id obj, CFStringRef key )
{
    NSValue *value = (__bridge NSValue *)ObjectProperty( obj, key );
    if ( value ) return NSRectToCGRect([value rectValue]);
    return CGRectZero;
}

void ObjectPropertySetRect( id obj, CFStringRef key, CGRect r )
{ ObjectPropertySet( obj, key, (__bridge id)[NSValue valueWithRect:NSRectFromCGRect(r)] ); }

CGPoint ObjectPropertyPoint( id obj, CFStringRef key )
{
    NSValue *value = (__bridge NSValue *)ObjectProperty( obj, key );
    if ( value ) return NSPointToCGPoint([value pointValue]);
    return CGPointZero;
}

void ObjectPropertySetPoint( id obj, CFStringRef key, CGPoint pt )
{ ObjectPropertySet( obj, key, (__bridge id)[NSValue valueWithPoint:NSPointFromCGPoint(pt)] ); }

CGSize ObjectPropertySize( id obj, CFStringRef key )
{
    NSValue *value = (__bridge NSValue *)ObjectProperty( obj, key );
    if ( value ) return NSSizeToCGSize([value sizeValue]);
    return CGSizeZero;
}

void ObjectPropertySetSize( id obj, CFStringRef key, CGSize sz )
{ ObjectPropertySet( obj, key, (__bridge id)[NSValue valueWithSize:NSSizeFromCGSize(sz)] ); }

CFRange ObjectPropertyRange( id obj, CFStringRef key )
{
    NSValue *value = (__bridge NSValue *)ObjectProperty( obj, key );
    if ( value ) return NSRangeToCFRange( [value rangeValue] );
    return CFRangeMake(NSNotFound,0);
}

void ObjectPropertySetRange( id obj, CFStringRef key, CFRange range )
{ ObjectPropertySet( obj, key, (__bridge id)[NSValue valueWithRange:NSRangeFromCFRange(range)] ); }

CFURLRef ObjectPropertyBookmarkURL( id obj, CFStringRef key )
{
    NSData *data = (__bridge NSData *)ObjectProperty( obj, key );
    if ( data ) return (__bridge CFURLRef)[NSURL URLByResolvingBookmarkData:data options:0 relativeToURL:nil bookmarkDataIsStale:nil error:nil];
    return nil;
}

void ObjectPropertySetBookmarkURL( id obj, CFStringRef key, CFURLRef url )
{
    if ( url ) {
        NSData *data = [(__bridge NSURL *)url bookmarkDataWithOptions:NSURLBookmarkCreationMinimalBookmark includingResourceValuesForKeys:nil relativeToURL:nil error:nil];
        if ( data ) ObjectPropertySet( obj, key, (__bridge id)data );
    }
}

BOOL ObjectPropertyGetBytes( id obj, CFStringRef key, void *bytes )
{
    NSData *data = (__bridge NSData *)ObjectProperty( obj, key );
    if ( data ) {
        [data getBytes:bytes length:[data length]];
        return YES;
    }
    return NO;
}

void ObjectPropertySetBytes( id obj, CFStringRef key, void *bytes, long length )
{
    NSData *data = [NSData dataWithBytes:bytes length:length];
    if ( data ) {
        ObjectPropertySet( obj, key, (__bridge id)data );
    }
}


void ObjectRemoveProperty( id obj, CFStringRef key )
{
    NSMutableDictionary *properties = [(__bridge id)obj objectProperties];
    if ( properties ) {
        [properties removeObjectForKey:(__bridge NSString *)key];
        if ( [properties count] == 0 ) {
#if !__has_feature(objc_arc)
            [properties release];
#endif
            [(__bridge id)obj setObjectProperties:nil];
        }
    }
}

void ObjectPropertyRemove( id obj, CFStringRef key )
{
    NSMutableDictionary *properties = [(__bridge id)obj objectProperties];
    if ( properties ) {
        [properties removeObjectForKey:(__bridge NSString *)key];
        if ( [properties count] == 0 ) {
#if !__has_feature(objc_arc)
            [properties release];
#endif
            [(__bridge id)obj setObjectProperties:nil];
        }
    }
}

void ObjectRemoveAllProperties( id obj )
{
    NSMutableDictionary *properties = [(__bridge id)obj objectProperties];
    if ( properties ) {
#if !__has_feature(objc_arc)
        [properties release];
#endif
        [(__bridge id)obj setObjectProperties:nil];
    }
}

void ObjectPropertyRemoveAll( id obj )
{
    NSMutableDictionary *properties = [(__bridge id)obj objectProperties];
    if ( properties ) {
#if !__has_feature(objc_arc)
        [properties release];
#endif
        [(__bridge id)obj setObjectProperties:nil];
    }
}


// Object ID
NSInteger ObjectID( id obj )
{
    NSMutableArray *objects = CUI_Objects();
    for ( NSObject *object in objects ) {
        if ( [object isEqual:(__bridge NSObject *)obj] ) return [object ID];
    }
    return NSNotFound;
}

id ObjectWithID( NSInteger objID )
{
    NSMutableArray *objects = CUI_Objects();
    for ( NSObject *obj in objects ) {
        if ( [obj ID] == objID ) return (__bridge id)obj;
    }
    return nil;
}

void ObjectSetID( id obj, NSInteger objID )
{
    NSMutableArray *objects = CUI_Objects();
    [(__bridge NSObject *)obj setID:objID];
    NSObject *object = (__bridge NSObject *)ObjectWithID( objID );
    if ( object ) {
        NSUInteger index = [objects indexOfObject:object];
        [objects replaceObjectAtIndex:index withObject:(__bridge NSObject *)obj];
    } else {
        [objects addObject:(__bridge NSObject *)obj];
    }
}

void ObjectRemoveID( NSInteger objID )
{
    NSObject *obj = (__bridge NSObject *)ObjectWithID( objID );
    if ( obj ) {
        [CUI_Objects() removeObject:obj];
    }
}


#pragma mark - JSON convenience functions
id ObjectWithJSONString( CFStringRef string, NSError **err )
{
    NSData *data = [(__bridge NSString *)string dataUsingEncoding:NSUTF8StringEncoding];
    if ( data ) {
        id obj = nil;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
        if ( @available( macOS 10.15, * ) ) {
            obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingFragmentsAllowed error:err];
        } else {
            obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:err];
        }
#else
        obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:err];
#endif
        if ( obj ) return (__bridge id)obj;
    }
    return nil;
}
