/*
 Object.h

 Bernie Wylde
 */

typedef void (*CUI_ObjectPerformFunctionCallbackType)(id);

@interface CUI_ObjectTarget : NSObject
@property (nonatomic,assign) CUI_ObjectPerformFunctionCallbackType callback;

- (void)objectSelector:(id)object;
@end

@interface NSObject (Additions)
@property (nonatomic,retain) NSNumber *IDNumber;

//@property (nonatomic,retain) NSNumber *tagNumber;// 20200323

@property (nonatomic,retain) NSNumber *wndTagNumber;
@property (nonatomic,retain) NSMutableDictionary *objProperties;

- (NSInteger)ID;
- (void)setID:(NSInteger)objID;

//- (NSInteger)tag;// 20200323
//- (void)setTag:(NSInteger)tag;// 20200323

- (NSInteger)wndTag;
- (void)setWndTag:(NSInteger)tag;

- (NSMutableDictionary *)objectProperties;
- (void)setObjectProperties:(NSMutableDictionary *)properties;
@end

#pragma mark - private
NSMutableArray *CUI_Objects( void );

#pragma mark - public
//NSInteger ObjectTag( id obj );// 20200323
//void ObjectSetTag( id obj, NSInteger tag );// 20200323
//id ObjectWithTag( NSInteger tag );// 20200323

// Init
NSObject *ObjectInit( void );

// - create, copy, dealloc -
id ObjectCopy( id obj );
id ObjectMutableCopy( id obj );

Class ObjectClass( id obj );
Class ObjectSuperclass( id obj );
BOOL ObjectIsSubclassOfClass( id obj, Class class );

// Description
CFStringRef ObjectDescription( id obj );

// Method info
IMP ObjectMethodForSelector( id obj, SEL selector );
IMP ObjectInstanceMethodForSelector( Class cls, SEL selector );
//NSMethodSignature *ObjectInstanceMethodSignatureForSelector( id obj, SEL selector );
NSMethodSignature *ObjectInstanceMethodSignatureForSelector( Class cls, SEL selector );
NSMethodSignature *ObjectMethodSignatureForSelector( id obj, SEL selector );

// Sending messages
void ObjectPerformSelector( id obj, CFStringRef selector, id withObj, CFTimeInterval afterDelay );
void ObjectPerformSelectorOnMainThread( id obj, id selector, id withObj, BOOL waitUntilDone );
void ObjectPerformSelectorInBackground( id obj, CFStringRef selector, id withObj );

// Scripting
CFStringRef ObjectClassName( id obj );

// - instance methods -
BOOL ObjectIsEqual( id obj1, id obj2 );
//void ObjectSetValueForKey( id obj, id value, CFStringRef key );
//id ObjectValueForKey( id obj, CFStringRef key );

// -- NSObject protocol methods --
BOOL ObjectIsKindOfClass( id obj, Class class );

// Retain/release
id ObjectRetain( id obj );
void ObjectRelease( id obj );

#pragma mark - NSScriptWhoseTests
BOOL ObjectIsEqualTo( ObjectRef obj, ObjectRef otherObj );
BOOL ObjectIsGreaterThan( ObjectRef obj, ObjectRef otherObj );
BOOL ObjectIsGreaterThanOrEqualTo( ObjectRef obj, ObjectRef otherObj );
BOOL ObjectIsLessThan( ObjectRef obj, ObjectRef otherObj );
BOOL ObjectIsLessThanOrEqualTo( ObjectRef obj, ObjectRef otherObj );
BOOL ObjectIsNotEqualTo( ObjectRef obj, ObjectRef otherObj );

#pragma mark - Custom
// Call function
void ObjectCallFunction( CUI_ObjectPerformFunctionCallbackType fnAddress, id withObj, CFTimeInterval afterDelay );
void ObjectCallFunctionOnMainThread( CUI_ObjectPerformFunctionCallbackType fnAddress, id withObj, BOOL waitUntilDone );
void ObjectCallFunctionInBackground( CUI_ObjectPerformFunctionCallbackType fnAddress, id withObj );

// Object property
id ObjectProperty( id obj, CFStringRef key );
void ObjectSetProperty( id obj, CFStringRef key, id value );
void ObjectPropertySet( id obj, CFStringRef key, id value );

BOOL ObjectPropertyBool( id obj, CFStringRef key );
void ObjectPropertySetBool( id obj, CFStringRef key, BOOL value );
long ObjectPropertyLong( id obj, CFStringRef key );
void ObjectPropertySetLong( id obj, CFStringRef key, long value );
double ObjectPropertyDouble( id obj, CFStringRef key );
void ObjectPropertySetDouble( id obj, CFStringRef key, double value );
CGRect ObjectPropertyRect( id obj, CFStringRef key );
void ObjectPropertySetRect( id obj, CFStringRef key, CGRect r );
CGPoint ObjectPropertyPoint( id obj, CFStringRef key );
void ObjectPropertySetPoint( id obj, CFStringRef key, CGPoint pt );
CGSize ObjectPropertySize( id obj, CFStringRef key );
void ObjectPropertySetSize( id obj, CFStringRef key, CGSize sz );
CFRange ObjectPropertyRange( id obj, CFStringRef key );
void ObjectPropertySetRange( id obj, CFStringRef key, CFRange range );
CFURLRef ObjectPropertyBookmarkURL( id obj, CFStringRef key );
void ObjectPropertySetBookmarkURL( id obj, CFStringRef key, CFURLRef url );
BOOL ObjectPropertyGetBytes( id obj, CFStringRef key, void *bytes );
void ObjectPropertySetBytes( id obj, CFStringRef key, void *bytes, long length );

void ObjectRemoveProperty( id obj, CFStringRef key );
void ObjectPropertyRemove( id obj, CFStringRef key );
void ObjectRemoveAllProperties( id obj );
void ObjectPropertyRemoveAll( id obj );

// Object ID
NSInteger ObjectID( id obj );
id ObjectWithID( NSInteger objID );
void ObjectSetID( id obj, NSInteger objID );
void ObjectRemoveID( NSInteger objID );

#pragma mark - JSON convenience function
id ObjectWithJSONString( CFStringRef string, NSError **err );
