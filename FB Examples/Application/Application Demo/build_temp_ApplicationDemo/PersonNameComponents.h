/*
 PersonNameComponents.h

 Bernie Wylde
 */


#import "CocoaUI.h"


// Class
Class PersonNameComponentsClass( void );

// Create
NSPersonNameComponents *PersonNameComponentsInit( void );

// Components
CFStringRef PersonNameComponentsNamePrefix( NSPersonNameComponents *ref );
void PersonNameComponentsSetNamePrefix( NSPersonNameComponents *ref, CFStringRef prefix );
CFStringRef PersonNameComponentsGivenName( NSPersonNameComponents *ref );
void PersonNameComponentsSetGivenName( NSPersonNameComponents *ref, CFStringRef name );
CFStringRef PersonNameComponentsMiddleName( NSPersonNameComponents *ref );
void PersonNameComponentsSetMiddleName( NSPersonNameComponents *ref, CFStringRef name );
CFStringRef PersonNameComponentsFamilyName( NSPersonNameComponents *ref );
void PersonNameComponentsSetFamilyName( NSPersonNameComponents *ref, CFStringRef name );
CFStringRef PersonNameComponentsNameSuffix( NSPersonNameComponents *ref );
void PersonNameComponentsSetNameSuffix( NSPersonNameComponents *ref, CFStringRef suffix );
CFStringRef PersonNameComponentsNickname( NSPersonNameComponents *ref );
void PersonNameComponentsSetNickname( NSPersonNameComponents *ref, CFStringRef name );
NSPersonNameComponents *PersonNameComponentsPhoneticRepresentation( NSPersonNameComponents *ref );
void PersonNameComponentsSetPhoneticRepresentation( NSPersonNameComponents *ref, NSPersonNameComponents *comps );


