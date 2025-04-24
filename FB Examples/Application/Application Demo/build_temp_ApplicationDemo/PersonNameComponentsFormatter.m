/*
 PersonNameComponentsFormatter.m

 Bernie Wylde
 */

#import "PersonNameComponentsFormatter.h"


// Class
Class PersonNameComponentsFormatterClass( void )
{ return [NSPersonNameComponentsFormatter class]; }

// Create
NSPersonNameComponentsFormatter *PersonNameComponentsFormatterInit( void )
{
#if __has_feature(objc_arc)
    return [[NSPersonNameComponentsFormatter alloc] init];
#else
    return [[[NSPersonNameComponentsFormatter alloc] init] autorelease];
#endif
}

// Behavior
NSPersonNameComponentsFormatterStyle PersonNameComponentsFormatterStyle( NSPersonNameComponentsFormatter *ref )
{ return [ref style]; }

void PersonNameComponentsFormatterSetStyle( NSPersonNameComponentsFormatter *ref, NSPersonNameComponentsFormatterStyle style )
{ [ref setStyle:style]; }

BOOL PersonNameComponentsFormatterIsPhonetic( NSPersonNameComponentsFormatter *ref )
{ return [ref isPhonetic]; }

void PersonNameComponentsFormatterSetPhonetic( NSPersonNameComponentsFormatter *ref, BOOL flag )
{ [ref setPhonetic:flag]; }

// Convert
CFStringRef PersonNameComponentsFormatterLocalizedStringFromComponents( NSPersonNameComponents *comps, NSPersonNameComponentsFormatterStyle style, NSPersonNameComponentsFormatterOptions options )
{ return (__bridge CFStringRef)[NSPersonNameComponentsFormatter localizedStringFromPersonNameComponents:comps style:style options:options]; }

CFStringRef PersonNameComponentsFormatterStringFromComponents( NSPersonNameComponentsFormatter *ref, NSPersonNameComponents *comps )
{ return (__bridge CFStringRef)[ref stringFromPersonNameComponents:comps]; }

CFAttributedStringRef PersonNameComponentsFormatterAnnotatedStringFromComponents( NSPersonNameComponentsFormatter *ref, NSPersonNameComponents *comps )
{ return (__bridge CFAttributedStringRef)[ref annotatedStringFromPersonNameComponents:comps]; }

NSPersonNameComponents *PersonNameComponentsFormatterComponentsFromString( NSPersonNameComponentsFormatter *ref, CFStringRef string )
{ return [ref personNameComponentsFromString:(__bridge NSString *)string]; }

BOOL PersonNameComponentsFormatterGetObjectValue( NSPersonNameComponentsFormatter *ref, CFTypeRef *obj, CFStringRef string, CFStringRef *errDescription )
{
    id tempObj = nil;
    NSString *tempErrDescription = nil;
    BOOL flag = [ref getObjectValue:&tempObj forString:(__bridge NSString *)string errorDescription:&tempErrDescription];
    if ( obj ) *obj = (__bridge CFTypeRef)tempObj;
    if ( errDescription ) *errDescription = (__bridge CFStringRef)tempErrDescription;
    return flag;
}

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
CFLocaleRef PersonNameComponentsFormatterLocale( NSPersonNameComponentsFormatter *ref )
{ return (__bridge CFLocaleRef)[ref locale]; }

void PersonNameComponentsFormatterSetLocale( NSPersonNameComponentsFormatter *ref, CFLocaleRef locale )
{ [ref setLocale:(__bridge NSLocale *)locale]; }
#endif// 120000
