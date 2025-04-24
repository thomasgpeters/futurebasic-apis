/*
 FontDescriptor.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class FontDescriptorClass( void );

// Create
NSFontDescriptor *FontDescriptorWithAttributes( CFDictionaryRef attributes );
NSFontDescriptor *FontDescriptorWithNameAndMatrix( CFStringRef name, NSAffineTransform *matrix );
NSFontDescriptor *FontDescriptorWithNameAndSize( CFStringRef name, CGFloat size );
NSFontDescriptor *FontDescriptorByAddingAttributes( NSFontDescriptor *ref, CFDictionaryRef attrs );
NSFontDescriptor *FontDescriptorWithFace( NSFontDescriptor *ref, CFStringRef face );
NSFontDescriptor *FontDescriptorWithFamily( NSFontDescriptor *ref, CFStringRef family );
NSFontDescriptor *FontDescriptorWithMatrix( NSFontDescriptor *ref, NSAffineTransform *matrix );
NSFontDescriptor *FontDescriptorWithSize( NSFontDescriptor *ref, CGFloat size );
NSFontDescriptor *FontDescriptorWithSymbolicTraits( NSFontDescriptor *ref, UInt32 traits );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
NSFontDescriptor *FontDescriptorWithDesign( NSFontDescriptor *ref, NSFontDescriptorSystemDesign design );
#endif// 101500

// Finding fonts
CFArrayRef FontDescriptorMatchingDescriptorsWithMandatoryKeys( NSFontDescriptor *ref, CFSetRef keys );
NSFontDescriptor *FontDescriptorMatchingDescriptorWithMandatoryKeys( NSFontDescriptor *ref, CFSetRef keys );

// Attributes
CFDictionaryRef FontDescriptorAttributes( NSFontDescriptor *ref );
CFTypeRef FontDescriptorObjectForKey( NSFontDescriptor *ref, CFStringRef attribute );
NSAffineTransform *FontDescriptorMatrix( NSFontDescriptor *ref );
CGFloat FontDescriptorPointSize( NSFontDescriptor *ref );
CFStringRef FontDescriptorPostscriptName( NSFontDescriptor *ref );

// Traits
UInt32 FontDescriptorSymbolicTraits( NSFontDescriptor *ref );

// Assets
BOOL FontDescriptorRequiresFontAssetRequest( NSFontDescriptor *ref );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
// NSFontDescriptor_TextStyles
API_AVAILABLE(macos(11.0))
NSFontDescriptor *FontDescriptorPreferredFontDescriptorForTextStyle( NSFontTextStyle textStyle, CFDictionaryRef options );
#endif// 110000

