/*
 ObjCRuntime.h

 Bernie Wylde
 */



// private
//SEL CUI_FixSelector( CFTypeRef selector );

// public
Class ClassFromString( CFStringRef string );
CFStringRef StringFromClass( Class class );
SEL SelectorFromString( CFStringRef string );
CFStringRef StringFromSelector( SEL selector );

