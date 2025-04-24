/*
 ColorSpace.m

 Bernie Wylde
 */

#import "ColorSpace.h"

// Class
Class ColorSpaceClass( void )
{ return [NSColorSpace class]; }

// Named spaces
NSColorSpace *ColorSpaceDeviceRGBSpace( void )
{ return [NSColorSpace deviceRGBColorSpace]; }

NSColorSpace *ColorSpaceGenericRGBSpace( void )
{ return [NSColorSpace genericRGBColorSpace]; }

NSColorSpace *ColorSpaceDeviceCMYKSpace( void )
{ return [NSColorSpace deviceCMYKColorSpace]; }

NSColorSpace *ColorSpaceGenericCMYKSpace( void )
{ return [NSColorSpace genericCMYKColorSpace]; }

NSColorSpace *ColorSpaceDeviceGraySpace( void )
{ return [NSColorSpace deviceGrayColorSpace]; }

NSColorSpace *ColorSpaceGenericGraySpace( void )
{ return [NSColorSpace genericGrayColorSpace]; }

NSColorSpace *ColorSpaceSRGBSpace( void )
{ return [NSColorSpace sRGBColorSpace]; }

NSColorSpace *ColorSpaceExtendedSRGBSpace( void )
{ return [NSColorSpace extendedSRGBColorSpace]; }

NSColorSpace *ColorSpaceP3Space( void )
{ return [NSColorSpace displayP3ColorSpace]; }

NSColorSpace *ColorSpaceGenericGamma22GraySpace( void )
{ return [NSColorSpace genericGamma22GrayColorSpace]; }

NSColorSpace *ColorSpaceExtendedGenericGamma22GraySpace( void )
{ return [NSColorSpace extendedGenericGamma22GrayColorSpace]; }

NSColorSpace *ColorSpaceAdobeRGB1998Space( void )
{ return [NSColorSpace adobeRGB1998ColorSpace]; }

// Available system spaces
CFArrayRef ColorSpaceAvailableSpacesWithModel( NSColorSpaceModel model )
{ return (__bridge CFArrayRef)[NSColorSpace availableColorSpacesWithModel:model]; }

// Custom spaces
NSColorSpace *ColorSpaceWithCGColorSpace( CGColorSpaceRef cgColorSpace )
{
#if __has_feature(objc_arc)
    return [[NSColorSpace alloc] initWithCGColorSpace:cgColorSpace];
#else
    return [[[NSColorSpace alloc] initWithCGColorSpace:cgColorSpace] autorelease];
#endif
}

NSColorSpace *ColorSpaceWithColorSyncProfile( void *prof )
{
#if __has_feature(objc_arc)
    return [[NSColorSpace alloc] initWithColorSyncProfile:prof];
#else
    return [[[NSColorSpace alloc] initWithColorSyncProfile:prof] autorelease];
#endif
}

NSColorSpace *ColorSpaceWithICCProfileData( CFDataRef dta )
{
#if __has_feature(objc_arc)
    return [[NSColorSpace alloc] initWithICCProfileData:(__bridge NSData *)dta];
#else
    return [[[NSColorSpace alloc] initWithICCProfileData:(__bridge NSData *)dta] autorelease];
#endif
}

// Data and attributes
CGColorSpaceRef ColorSpaceCGColorSpace( NSColorSpace *ref )
{ return [ref CGColorSpace]; }

NSColorSpaceModel ColorSpaceModel( NSColorSpace *ref )
{ return [ref colorSpaceModel]; }

void *ColorSpaceColorSyncProfile( NSColorSpace *ref )
{ return [ref colorSyncProfile]; }

CFDataRef ColorSpaceICCProfileData( NSColorSpace *ref )
{ return (__bridge CFDataRef)[ref ICCProfileData]; }

CFStringRef ColorSpaceLocalizedName( NSColorSpace *ref )
{ return (__bridge CFStringRef)[ref localizedName]; }

NSInteger ColorSpaceNumberOfColorComponents( NSColorSpace *ref )
{ return [ref numberOfColorComponents]; }

