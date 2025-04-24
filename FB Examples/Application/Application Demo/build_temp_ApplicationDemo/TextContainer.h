/*
 TextContainer.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class TextContainerClass( void );

// - create -
NSTextContainer *TextContainerWithSize( CGSize size );
// - initWithCoder:

// - components -
NSLayoutManager *TextContainerLayoutManager( NSTextContainer *ref );
void TextContainerSetLayoutManager( NSTextContainer *ref, NSLayoutManager *lm );
void TextContainerReplaceLayoutManager( NSTextContainer *ref, NSLayoutManager *lm );
NSInteger TextContainerTextView( NSTextContainer *ref );

// - shape -
CGSize TextContainerSize( NSTextContainer *ref );
void TextContainerSetSize( NSTextContainer *ref, CGSize size );
CFArrayRef TextContainerExclusionPaths( NSTextContainer *ref );
void TextContainerSetExclusionPaths( NSTextContainer *ref, CFArrayRef paths );
NSLineBreakMode TextContainerLineBreakMode( NSTextContainer *ref );
void TextContainerSetLineBreakMode( NSTextContainer *ref, NSLineBreakMode lineBreakMode );
BOOL TextContainerWidthTracksTextView( NSTextContainer *ref );
void TextContainerSetWidthTracksTextView( NSTextContainer *ref, BOOL flag );
BOOL TextContainerHeightTracksTextView( NSTextContainer *ref );
void TextContainerSetHeightTracksTextView( NSTextContainer *ref, BOOL flag );

// - constrain -
NSUInteger TextContainerMaximumNumberOfLines( NSTextContainer *ref );
void TextContainerSetMaximumNumberOfLines( NSTextContainer *ref, NSUInteger lines );
CGFloat TextContainerLineFragmentPadding( NSTextContainer *ref );
void TextContainerSetLineFragmentPadding( NSTextContainer *ref, CGFloat padding );
CGRect TextContainerLineFragmentRectForProposedRect( NSTextContainer *ref, CGRect proposedRect, NSUInteger index, NSWritingDirection direction, CGRect *remainingRect );
BOOL TextContainerIsSimpleRectangularTextContainer( NSTextContainer *ref );

