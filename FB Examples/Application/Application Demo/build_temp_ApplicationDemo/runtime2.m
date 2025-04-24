/*
 runtime2.m// should ideally be named "runtime.m" but renamed to avoid clash with other header of same name

 Bernie Wylde
 */

#import "runtime2.h"

CFStringRef ClassName( Class class )
{ return (__bridge CFStringRef)[NSString stringWithUTF8String:class_getName(class)]; }

Class ClassSuperclass( Class class )
{ return class_getSuperclass(class); }

Class ClassMetaClass( CFStringRef name )
{ return objc_getMetaClass( [(__bridge NSString *)name UTF8String] ); }

BOOL ClassIsMetaClass( Class class )
{ return class_isMetaClass(class); }

BOOL ClassRespondsToSelector( Class class, CFStringRef selectorName )
{ return class_respondsToSelector( class, NSSelectorFromString( (__bridge NSString *)selectorName) ); }

long ClassInstanceSize( Class class )
{ return class_getInstanceSize(class); }

Ivar ClassInstanceVariable( Class class, CFStringRef name )
{ return class_getInstanceVariable(class,[(__bridge NSString *)name UTF8String]); }

Ivar ClassClassVariable( Class class, CFStringRef name )
{ return class_getClassVariable(class,[(__bridge NSString *)name UTF8String]); }

BOOL ClassAddIvar( Class class, CFStringRef name, long size, UInt8 alignment, CFArrayRef types );

CFArrayRef ClassIvarList( Class class )
{
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:0];
    int unsigned count;
    Ivar *ivarList = class_copyIvarList(class,&count);
    for (unsigned int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        const char *name = ivar_getName(ivar);
        [list addObject:[NSString stringWithUTF8String:name]];
    }
    free(ivarList);
    return (__bridge CFArrayRef)list;
}

CFStringRef ClassIvarLayout( Class class );

void ClassSetIvarLayout( Class class, CFStringRef layout );

CFStringRef ClassWeakIvarLayout( Class class );

void ClassSetWeakIvarLayout( Class class, CFStringRef layout );

objc_property_t ClassProperty( Class class, CFStringRef name )
{ return class_getProperty( class, [(__bridge NSString *)name UTF8String] ); }

CFArrayRef ClassPropertyList( Class class )
{
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:0];
    int unsigned count;
    objc_property_t *propertyList = class_copyPropertyList(class,&count);
    for (unsigned int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *name = property_getName(property);
        [list addObject:[NSString stringWithUTF8String:name]];
    }
    free(propertyList);
    return (__bridge CFArrayRef)list;
}

BOOL ClassAddMethod( Class class, CFStringRef name, IMP imp, CFArrayRef types );

Method ClassInstanceMethod( Class class, CFStringRef selectorName )
{ return class_getInstanceMethod( class, NSSelectorFromString((__bridge NSString *)selectorName ) ); }

Method ClassClassMethod( Class class, CFStringRef selectorName )
{ return class_getClassMethod( class, NSSelectorFromString((__bridge NSString *)selectorName ) ); }

CFArrayRef ClassMethodList( Class class )
{
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:0];
    int unsigned count;
    Method *classMethods = class_copyMethodList(class, &count);
    for (unsigned int i = 0; i < count; i++) {
        [list addObject:NSStringFromSelector(method_getName(classMethods[i]))];
    }
    free(classMethods);
    return (__bridge CFArrayRef)list;
}

IMP ClassReplaceMethod( Class class, CFStringRef name, IMP imp, CFArrayRef types );

CFStringRef MethodArgumentType( Method m, UInt32 index )
{
    char *type = method_copyArgumentType( m, index );
    NSString *s = [NSString stringWithUTF8String:type];
    free(type);
    return (__bridge CFStringRef)s;
}

UInt32 MethodNumberOfArguments( Method m )
{ return method_getNumberOfArguments( m ); }

CFStringRef MethodReturnType( Method m )
{
    char ret[256];
    method_getReturnType( m, ret, 256 );
    return (__bridge CFStringRef)[NSString stringWithUTF8String:ret];
}

