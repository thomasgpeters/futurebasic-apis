/*
 FontDescriptor.m

 Bernie Wylde
 */

#import "FontDescriptor.h"

// Class
Class FontDescriptorClass( void )
{ return [NSFontDescriptor class]; }

// Create
NSFontDescriptor *FontDescriptorWithAttributes( CFDictionaryRef attributes )
{ return [NSFontDescriptor fontDescriptorWithFontAttributes:(__bridge NSDictionary *)attributes]; }

NSFontDescriptor *FontDescriptorWithNameAndMatrix( CFStringRef name, NSAffineTransform *matrix )
{ return [NSFontDescriptor fontDescriptorWithName:(__bridge NSString *)name matrix:matrix]; }

NSFontDescriptor *FontDescriptorWithNameAndSize( CFStringRef name, CGFloat size )
{ return [NSFontDescriptor fontDescriptorWithName:(__bridge NSString *)name size:size]; }

NSFontDescriptor *FontDescriptorByAddingAttributes( NSFontDescriptor *ref, CFDictionaryRef attrs )
{ return [ref fontDescriptorByAddingAttributes:(__bridge NSDictionary *)attrs]; }

NSFontDescriptor *FontDescriptorWithFace( NSFontDescriptor *ref, CFStringRef face )
{ return [ref fontDescriptorWithFace:(__bridge NSString *)face]; }

NSFontDescriptor *FontDescriptorWithFamily( NSFontDescriptor *ref, CFStringRef family )
{ return [ref fontDescriptorWithFamily:(__bridge NSString *)family]; }

NSFontDescriptor *FontDescriptorWithMatrix( NSFontDescriptor *ref, NSAffineTransform *matrix )
{ return [ref fontDescriptorWithMatrix:matrix]; }

NSFontDescriptor *FontDescriptorWithSize( NSFontDescriptor *ref, CGFloat size )
{ return [ref fontDescriptorWithSize:size]; }

NSFontDescriptor *FontDescriptorWithSymbolicTraits( NSFontDescriptor *ref, UInt32 traits )
{ return [ref fontDescriptorWithSymbolicTraits:traits]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
NSFontDescriptor *FontDescriptorWithDesign( NSFontDescriptor *ref, NSFontDescriptorSystemDesign design )
{ return [ref fontDescriptorWithDesign:design]; }
#endif// 101500

// Finding fonts
CFArrayRef FontDescriptorMatchingDescriptorsWithMandatoryKeys( NSFontDescriptor *ref, CFSetRef keys )
{ return (__bridge CFArrayRef)[ref matchingFontDescriptorsWithMandatoryKeys:(__bridge NSSet *)keys]; }

NSFontDescriptor *FontDescriptorMatchingDescriptorWithMandatoryKeys( NSFontDescriptor *ref, CFSetRef keys )
{ return [ref matchingFontDescriptorWithMandatoryKeys:(__bridge NSSet *)keys]; }

// Attributes
CFDictionaryRef FontDescriptorAttributes( NSFontDescriptor *ref )
{ return (__bridge CFDictionaryRef)[ref fontAttributes]; }

CFTypeRef FontDescriptorObjectForKey( NSFontDescriptor *ref, CFStringRef attribute )
{ return (__bridge CFTypeRef)[ref objectForKey:(__bridge NSString *)attribute]; }

NSAffineTransform *FontDescriptorMatrix( NSFontDescriptor *ref )
{ return [ref matrix]; }

CGFloat FontDescriptorPointSize( NSFontDescriptor *ref )
{ return [ref pointSize]; }

CFStringRef FontDescriptorPostscriptName( NSFontDescriptor *ref )
{ return (__bridge CFStringRef)[ref postscriptName]; }

// Traits
UInt32 FontDescriptorSymbolicTraits( NSFontDescriptor *ref )
{ return [ref symbolicTraits]; }

// Assets
BOOL FontDescriptorRequiresFontAssetRequest( NSFontDescriptor *ref )
{ return [ref requiresFontAssetRequest]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
// NSFontDescriptor_TextStyles
NSFontDescriptor *FontDescriptorPreferredFontDescriptorForTextStyle( NSFontTextStyle textStyle, CFDictionaryRef options )
{ return [NSFontDescriptor preferredFontDescriptorForTextStyle:textStyle options:(__bridge NSDictionary *)options]; }
#endif// 110000
