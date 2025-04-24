/*
 Shadow.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class ShadowClass( void );

NSShadow *ShadowInit( void );
CGSize ShadowOffset( NSShadow *ref );
void ShadowSetOffset( NSShadow *ref, CGSize offset );
CGFloat ShadowBlurRadius( NSShadow *ref );
void ShadowSetBlurRadius( NSShadow *ref, CGFloat radius );
NSColor *ShadowColor( NSShadow *ref );
void ShadowSetColor( NSShadow *ref, NSColor *col );
void ShadowSet( NSShadow *ref );

// convenience
NSShadow *ShadowWithAttributes( CGSize offset, CGFloat blurRadius, NSColor *col );
void ShadowSetWithAttributes( CGSize offset, CGFloat blurRadius, NSColor *col );

