/*
 runtime2.h// should ideally be named "runtime.h" but renamed to avoid clash with other header of same name

 Bernie Wylde
 */


#import "CocoaUI.h"

CFStringRef ClassName( Class class );
Class ClassSuperclass( Class class );
Class ClassMetaClass( CFStringRef name );
BOOL ClassIsMetaClass( Class class );

BOOL ClassRespondsToSelector( Class class, CFStringRef selectorName );

long ClassInstanceSize( Class class );
Ivar ClassInstanceVariable( Class class, CFStringRef name );
Ivar ClassClassVariable( Class class, CFStringRef name );
BOOL ClassAddIvar( Class class, CFStringRef name, long size, UInt8 alignment, CFArrayRef types );
CFArrayRef ClassIvarList( Class class );
CFStringRef ClassIvarLayout( Class class );
void ClassSetIvarLayout( Class class, CFStringRef layout );
CFStringRef ClassWeakIvarLayout( Class class );
void ClassSetWeakIvarLayout( Class class, CFStringRef layout );
objc_property_t ClassProperty( Class class, CFStringRef name );
CFArrayRef ClassPropertyList( Class class );
BOOL ClassAddMethod( Class class, CFStringRef name, IMP imp, CFArrayRef types );

Method ClassInstanceMethod( Class class, CFStringRef name );
Method ClassClassMethod( Class class, CFStringRef name );
CFArrayRef ClassMethodList( Class class );
IMP ClassReplaceMethod( Class class, CFStringRef name, IMP imp, CFArrayRef types );

CFStringRef MethodArgumentType( Method m, UInt32 index );
UInt32 MethodNumberOfArguments( Method m );
CFStringRef MethodReturnType( Method m );

