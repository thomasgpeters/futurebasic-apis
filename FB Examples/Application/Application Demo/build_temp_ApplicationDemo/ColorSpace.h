/*
 ColorSpace.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class ColorSpaceClass( void );

// Named spaces
NSColorSpace *ColorSpaceDeviceRGBSpace( void );
NSColorSpace *ColorSpaceGenericRGBSpace( void );
NSColorSpace *ColorSpaceDeviceCMYKSpace( void );
NSColorSpace *ColorSpaceGenericCMYKSpace( void );
NSColorSpace *ColorSpaceDeviceGraySpace( void );
NSColorSpace *ColorSpaceGenericGraySpace( void );
NSColorSpace *ColorSpaceSRGBSpace( void );

NSColorSpace *ColorSpaceExtendedSRGBSpace( void );
NSColorSpace *ColorSpaceP3Space( void );

NSColorSpace *ColorSpaceGenericGamma22GraySpace( void );

NSColorSpace *ColorSpaceExtendedGenericGamma22GraySpace( void );

NSColorSpace *ColorSpaceAdobeRGB1998Space( void );

// Available system spaces
CFArrayRef ColorSpaceAvailableSpacesWithModel( NSColorSpaceModel model );

// Custom spaces
NSColorSpace *ColorSpaceWithCGColorSpace( CGColorSpaceRef cgColorSpace );
NSColorSpace *ColorSpaceWithColorSyncProfile( void *prof );
NSColorSpace *ColorSpaceWithICCProfileData( CFDataRef dta );

// Data and attributes
CGColorSpaceRef ColorSpaceCGColorSpace( NSColorSpace *ref );
NSColorSpaceModel ColorSpaceModel( NSColorSpace *ref );
void *ColorSpaceColorSyncProfile( NSColorSpace *ref );
CFDataRef ColorSpaceICCProfileData( NSColorSpace *ref );
CFStringRef ColorSpaceLocalizedName( NSColorSpace *ref );
NSInteger ColorSpaceNumberOfColorComponents( NSColorSpace *ref );
