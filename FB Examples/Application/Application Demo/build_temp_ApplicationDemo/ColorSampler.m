/*
 ColorSampler.m
 
 Bernie Wylde
 */

#import "ColorSampler.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500

// Class
Class ColorSamplerClass( void )
{ return [NSColorSampler class]; }

void ColorSamplerShow( void )
{
#if __has_feature(objc_arc)
    NSColorSampler *sampler = [[NSColorSampler alloc] init];
#else
    NSColorSampler *sampler = [[[NSColorSampler alloc] init] autorelease];
#endif
    [sampler showSamplerWithSelectionHandler:^(NSColor *selectedColor) {
        DialogEventSetColor( selectedColor );
        CallUserDefinedOnDialogFunction( colorSamplerSelectedColor, 0, 0, (__bridge CFTypeRef)selectedColor );
    }];
}

#endif  // 101500
