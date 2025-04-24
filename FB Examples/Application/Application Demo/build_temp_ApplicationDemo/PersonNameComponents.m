/*
 PersonNameComponents.m

 Bernie Wylde
 */

#import "PersonNameComponents.h"


// Class
Class PersonNameComponentsClass( void )
{ return [NSPersonNameComponents class]; }

// Create
NSPersonNameComponents *PersonNameComponentsInit( void )
{
#if __has_feature(objc_arc)
    return [[NSPersonNameComponents alloc] init];
#else
    return [[[NSPersonNameComponents alloc] init] autorelease];
#endif
}

// Components
CFStringRef PersonNameComponentsNamePrefix( NSPersonNameComponents *ref )
{ return (__bridge CFStringRef)[ref namePrefix]; }

void PersonNameComponentsSetNamePrefix( NSPersonNameComponents *ref, CFStringRef prefix )
{ [ref setNamePrefix:(__bridge NSString *)prefix]; }

CFStringRef PersonNameComponentsGivenName( NSPersonNameComponents *ref )
{ return (__bridge CFStringRef)[ref givenName]; }

void PersonNameComponentsSetGivenName( NSPersonNameComponents *ref, CFStringRef name )
{ [ref setGivenName:(__bridge NSString *)name]; }

CFStringRef PersonNameComponentsMiddleName( NSPersonNameComponents *ref )
{ return (__bridge CFStringRef)[ref middleName]; }

void PersonNameComponentsSetMiddleName( NSPersonNameComponents *ref, CFStringRef name )
{ [ref setMiddleName:(__bridge NSString *)name]; }

CFStringRef PersonNameComponentsFamilyName( NSPersonNameComponents *ref )
{ return (__bridge CFStringRef)[ref familyName]; }

void PersonNameComponentsSetFamilyName( NSPersonNameComponents *ref, CFStringRef name )
{ [ref setFamilyName:(__bridge NSString *)name]; }

CFStringRef PersonNameComponentsNameSuffix( NSPersonNameComponents *ref )
{ return (__bridge CFStringRef)[ref nameSuffix]; }

void PersonNameComponentsSetNameSuffix( NSPersonNameComponents *ref, CFStringRef suffix )
{ [ref setNameSuffix:(__bridge NSString *)suffix]; }

CFStringRef PersonNameComponentsNickname( NSPersonNameComponents *ref )
{ return (__bridge CFStringRef)[ref nickname]; }

void PersonNameComponentsSetNickname( NSPersonNameComponents *ref, CFStringRef name )
{ [ref setNickname:(__bridge NSString *)name]; }

NSPersonNameComponents *PersonNameComponentsPhoneticRepresentation( NSPersonNameComponents *ref )
{ return [ref phoneticRepresentation]; }

void PersonNameComponentsSetPhoneticRepresentation( NSPersonNameComponents *ref, NSPersonNameComponents *comps )
{ [ref setPhoneticRepresentation:comps]; }


