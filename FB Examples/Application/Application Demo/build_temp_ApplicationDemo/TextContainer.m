/*
 TextContainer.m

 Bernie Wylde
 */

#import "TextContainer.h"

// Class
Class TextContainerClass( void )
{ return [NSTextContainer class]; }

// - create -
NSTextContainer *TextContainerWithSize( CGSize size )
{
#if __has_feature(objc_arc)
    return [[NSTextContainer alloc] initWithSize:NSSizeFromCGSize(size)];
#else
    return [[[NSTextContainer alloc] initWithSize:NSSizeFromCGSize(size)] autorelease];
#endif
}

// - components -
NSLayoutManager *TextContainerLayoutManager( NSTextContainer *ref )
{ return [ref layoutManager]; }

void TextContainerSetLayoutManager( NSTextContainer *ref, NSLayoutManager *lm )
{ [ref setLayoutManager:lm]; }

void TextContainerReplaceLayoutManager( NSTextContainer *ref, NSLayoutManager *lm )
{ [ref replaceLayoutManager:lm]; }

NSInteger TextContainerTextView( NSTextContainer *ref )
{
    NSTextView *view = [ref textView];
    if ( view ) return [view tag];
    return 0;
}

// - shape -
CGSize TextContainerSize( NSTextContainer *ref )
{ return NSSizeToCGSize([ref size]); }

void TextContainerSetSize( NSTextContainer *ref, CGSize size )
{ [ref setSize:NSSizeFromCGSize(size)]; }

CFArrayRef TextContainerExclusionPaths( NSTextContainer *ref )
{ return (__bridge CFArrayRef)[ref exclusionPaths]; }

void TextContainerSetExclusionPaths( NSTextContainer *ref, CFArrayRef paths )
{ [ref setExclusionPaths:(__bridge NSArray *)paths]; }

NSLineBreakMode TextContainerLineBreakMode( NSTextContainer *ref )
{ return [ref lineBreakMode]; }

void TextContainerSetLineBreakMode( NSTextContainer *ref, NSLineBreakMode lineBreakMode )
{ [ref setLineBreakMode:lineBreakMode]; }

BOOL TextContainerWidthTracksTextView( NSTextContainer *ref )
{ return [ref widthTracksTextView]; }

void TextContainerSetWidthTracksTextView( NSTextContainer *ref, BOOL flag )
{ [ref setWidthTracksTextView:flag]; }

BOOL TextContainerHeightTracksTextView( NSTextContainer *ref )
{ return [ref heightTracksTextView]; }

void TextContainerSetHeightTracksTextView( NSTextContainer *ref, BOOL flag )
{ [ref setHeightTracksTextView:flag]; }

// - constrain -
NSUInteger TextContainerMaximumNumberOfLines( NSTextContainer *ref )
{ return [ref maximumNumberOfLines]; }

void TextContainerSetMaximumNumberOfLines( NSTextContainer *ref, NSUInteger lines )
{ [ref setMaximumNumberOfLines:lines]; }

CGFloat TextContainerLineFragmentPadding( NSTextContainer *ref )
{ return [ref lineFragmentPadding]; }

void TextContainerSetLineFragmentPadding( NSTextContainer *ref, CGFloat padding )
{ [ref setLineFragmentPadding:padding]; }

CGRect TextContainerLineFragmentRectForProposedRect( NSTextContainer *ref, CGRect proposedRect, NSUInteger index, NSWritingDirection direction, CGRect *remainingRect )
{ return NSRectToCGRect([ref lineFragmentRectForProposedRect:NSRectFromCGRect(proposedRect) atIndex:index writingDirection:direction remainingRect:(NSRect *)remainingRect] );
}

BOOL TextContainerIsSimpleRectangularTextContainer( NSTextContainer *ref )
{ return [ref isSimpleRectangularTextContainer]; }
