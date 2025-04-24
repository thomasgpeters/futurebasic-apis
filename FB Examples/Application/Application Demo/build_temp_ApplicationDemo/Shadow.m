/*
 Shadow.m

 Bernie Wylde
 */

#import "Shadow.h"

// Class
Class ShadowClass( void )
{ return [NSShadow class]; }

NSShadow *ShadowInit( void )
{
#if __has_feature(objc_arc)
    return [[NSShadow alloc] init];
#else
    return [[[NSShadow alloc] init] autorelease];
#endif
}

CGSize ShadowOffset( NSShadow *ref )
{ return NSSizeToCGSize([ref shadowOffset]); }

void ShadowSetOffset( NSShadow *ref, CGSize offset )
{ [ref setShadowOffset:NSSizeFromCGSize(offset)]; }

CGFloat ShadowBlurRadius( NSShadow *ref )
{ return [ref shadowBlurRadius]; }

void ShadowSetBlurRadius( NSShadow *ref, CGFloat radius )
{ [ref setShadowBlurRadius:radius]; }

NSColor *ShadowColor( NSShadow *ref )
{ return [ref shadowColor]; }

void ShadowSetColor( NSShadow *ref, NSColor *col )
{ [ref setShadowColor:col]; }

void ShadowSet( NSShadow *ref )
{ [ref set]; }

// convenience
NSShadow *ShadowWithAttributes( CGSize offset, CGFloat blurRadius, NSColor *col )
{
#if __has_feature(objc_arc)
    NSShadow *ref = [[NSShadow alloc] init];
#else
    NSShadow *ref = [[[NSShadow alloc] init] autorelease];
#endif
    [ref setShadowOffset:NSSizeFromCGSize(offset)];
    [ref setShadowBlurRadius:blurRadius];
    if ( col ) [ref setShadowColor:col];
    return ref;
}

void ShadowSetWithAttributes( CGSize offset, CGFloat blurRadius, NSColor *col )
{
#if __has_feature(objc_arc)
    NSShadow *ref = [[NSShadow alloc] init];
#else
    NSShadow *ref = [[[NSShadow alloc] init] autorelease];
#endif
    [ref setShadowOffset:NSSizeFromCGSize(offset)];
    [ref setShadowBlurRadius:blurRadius];
    if ( col ) [ref setShadowColor:col];
    [ref set];
}
