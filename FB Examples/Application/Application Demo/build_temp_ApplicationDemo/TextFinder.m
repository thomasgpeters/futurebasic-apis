/*
 TextFinder.m

 Bernie Wylde
 */

#import "TextFinder.h"

// Class
Class TextFinderClass( void )
{ return [NSTextFinder class]; }

// Init
NSTextFinder *TextFinderInit( void )
{
#if __has_feature(objc_arc)
    return [[NSTextFinder alloc] init];
#else
    return [[[NSTextFinder alloc] init] autorelease];
#endif
}

// Validating and performing
void TextFinderPerformAction( NSTextFinder *ref, NSTextFinderAction action )
{ [ref performAction:action]; }

BOOL TextFinderValidateAction( NSTextFinder *ref, NSTextFinderAction action )
{ return [ref validateAction:action]; }

void TextFinderCancelFindIndicator( NSTextFinder *ref )
{ [ref cancelFindIndicator]; }

// Container
id<NSTextFinderBarContainer> TextFinderFinderBarContainer( NSTextFinder *ref )
{ return [ref findBarContainer]; }

void TextFinderSetFinderBarContainer( NSTextFinder *ref, id<NSTextFinderBarContainer> container )
{ [ref setFindBarContainer:container]; }

// Client
id<NSTextFinderClient> TextFinderClient( NSTextFinder *ref )
{ return [ref client]; }

void TextFinderSetClient( NSTextFinder *ref, id<NSTextFinderClient> client )
{ [ref setClient:client]; }

// Changes in content
void TextFinderNoteClientStringWillChange( NSTextFinder *ref )
{ [ref noteClientStringWillChange]; }

// Updating indicator
void TextFinderFindIndicatorNeedsUpdate( NSTextFinder *ref )
{ [ref findIndicatorNeedsUpdate]; }

// Incremental search configuration
void TextFinderDrawIncrementalMatchHighlightingInRect( CGRect r )
{ [NSTextFinder drawIncrementalMatchHighlightInRect:NSRectFromCGRect(r)]; }

CFArrayRef TextFinderIncrementalMatchRanges( NSTextFinder *ref )
{ return (__bridge CFArrayRef)[ref incrementalMatchRanges]; }

BOOL TextFinderIsIncrementalSearchingEnabled( NSTextFinder *ref )
{ return [ref isIncrementalSearchingEnabled]; }

void TextFinderSetIncrementalSearchingEnabled( NSTextFinder *ref, BOOL flag )
{ [ref setIncrementalSearchingEnabled:flag]; }

BOOL TextFinderIncrementalSearchingShouldDimContentView( NSTextFinder *ref )
{ return [ref incrementalSearchingShouldDimContentView]; }

void TextFinderSetIncrementalSearchingShouldDimContentView( NSTextFinder *ref, BOOL flag )
{ [ref setIncrementalSearchingShouldDimContentView:flag]; }


/*
  TextFinderBarContainer
*/

// View
NSView *TextFinderBarContainerFindBarView( id<NSTextFinderBarContainer> ref )
{ return [ref findBarView]; }

void TextFinderBarContainerSetFindBarView( id<NSTextFinderBarContainer> ref, NSView *aView )
{ [ref setFindBarView:aView]; }

NSView *TextFinderBarContainerContentView( id<NSTextFinderBarContainer> ref )
{ return [ref contentView]; }

//void TextFinderBarContainerSetContentView( id<NSTextFinderBarContainer> ref, NSView *aView )
//{ [ref setContentView:aView]; }

BOOL TextFinderBarContainerIsFindBarVisible( id<NSTextFinderBarContainer> ref )
{ return [ref isFindBarVisible]; }

void TextFinderBarContainerSetFindBarVisible( id<NSTextFinderBarContainer> ref, BOOL flag )
{ [ref setFindBarVisible:flag]; }

// Height
void TextFinderBarContainerFindBarViewDidChangeHeight( id<NSTextFinderBarContainer> ref )
{ [ref findBarViewDidChangeHeight]; }


/*
  TextFinderClient
*/

// String searching
CFStringRef TextFinderClientString( id<NSTextFinderClient> ref )
{ return (__bridge CFStringRef)[ref string]; }

CFStringRef TextFinderClientStringAtIndex( id<NSTextFinderClient> ref, NSUInteger characterIndex, CFRange *effectiveRange, BOOL *endsWithSearchBoundary )
{ return (__bridge CFStringRef)[ref stringAtIndex:characterIndex effectiveRange:(NSRangePointer)effectiveRange endsWithSearchBoundary:endsWithSearchBoundary]; }

NSUInteger TextFinderClientStringLength( id<NSTextFinderClient> ref )
{ return [ref stringLength]; }

// Replacing text
BOOL TextFinderClientShouldReplaceCharactersInRanges( id<NSTextFinderClient> ref, CFArrayRef ranges, CFArrayRef strings )
{ return [ref shouldReplaceCharactersInRanges:(__bridge NSArray *)ranges withStrings:(__bridge NSArray *)strings]; }

void TextFinderClientReplaceCharactersInRange( id<NSTextFinderClient> ref, CFRange range, CFStringRef string )
{ [ref replaceCharactersInRange:NSRangeFromCFRange(range) withString:(__bridge NSString *)string]; }

void TextFinderClientDidReplaceCharacters( id<NSTextFinderClient> ref )
{ [ref didReplaceCharacters]; }

// Selection
BOOL TextFinderClientIsSelectable( id<NSTextFinderClient> ref )
{ return [ref isSelectable]; }

BOOL TextFinderClientAllowsMultipleSelection( id<NSTextFinderClient> ref )
{ return [ref allowsMultipleSelection]; }

CFRange TextFinderClientFirstSelectedRange( id<NSTextFinderClient> ref )
{ return NSRangeToCFRange([ref firstSelectedRange]); }

CFArrayRef TextFinderClientFirstSelectedRanges( id<NSTextFinderClient> ref )
{ return (__bridge CFArrayRef)[ref selectedRanges]; }
                                               
// Editable
BOOL TextFinderClientIsEditable( id<NSTextFinderClient> ref )
{ return [ref isEditable]; }

// Text locations
NSView *TextFinderClientContentViewAtIndex( id<NSTextFinderClient> ref, NSUInteger index, CFRange *effectiveCharRange )
{ return [ref contentViewAtIndex:index effectiveCharacterRange:(NSRangePointer)effectiveCharRange]; }

CFArrayRef TextFinderClientRectsForCharacterRange( id<NSTextFinderClient> ref, CFRange range )
{ return (__bridge CFArrayRef)[ref rectsForCharacterRange:NSRangeFromCFRange(range)]; }

void TextFinderClientScrollRangeToVisible( id<NSTextFinderClient> ref, CFRange range )
{ [ref scrollRangeToVisible:NSRangeFromCFRange(range)]; }

CFArrayRef TextFinderClientVisibleCharacterRanges( id<NSTextFinderClient> ref )
{ return (__bridge CFArrayRef)[ref visibleCharacterRanges]; }

// Drawing glyphs
void TextFinderClientDrawCharactersInRange( id<NSTextFinderClient> ref, CFRange range, NSView *contentView )
{ [ref drawCharactersInRange:NSRangeFromCFRange(range) forContentView:contentView]; }
