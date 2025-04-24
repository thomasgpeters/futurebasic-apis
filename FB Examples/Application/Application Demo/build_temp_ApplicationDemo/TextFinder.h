/*
 TextFinder.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class TextFinderClass( void );

// Init
NSTextFinder *TextFinderInit( void );

// Validating and performing
void TextFinderPerformAction( NSTextFinder *ref, NSTextFinderAction action );
BOOL TextFinderValidateAction( NSTextFinder *ref, NSTextFinderAction action );
void TextFinderCancelFindIndicator( NSTextFinder *ref );

// Container
id<NSTextFinderBarContainer> TextFinderFinderBarContainer( NSTextFinder *ref );
void TextFinderSetFinderBarContainer( NSTextFinder *ref, id<NSTextFinderBarContainer> container );

// Client
id<NSTextFinderClient> TextFinderClient( NSTextFinder *ref );
void TextFinderSetClient( NSTextFinder *ref, id<NSTextFinderClient> client );

// Changes in content
void TextFinderNoteClientStringWillChange( NSTextFinder *ref );

// Updating indicator
void TextFinderFindIndicatorNeedsUpdate( NSTextFinder *ref );

// Incremental search configuration
void TextFinderDrawIncrementalMatchHighlightingInRect( CGRect r );
CFArrayRef TextFinderIncrementalMatchRanges( NSTextFinder *ref );
BOOL TextFinderIsIncrementalSearchingEnabled( NSTextFinder *ref );
void TextFinderSetIncrementalSearchingEnabled( NSTextFinder *ref, BOOL flag );
BOOL TextFinderIncrementalSearchingShouldDimContentView( NSTextFinder *ref );
void TextFinderSetIncrementalSearchingShouldDimContentView( NSTextFinder *ref, BOOL flag );


/*
  TextFinderBarContainer
*/

// View
NSView *TextFinderBarContainerFindBarView( id<NSTextFinderBarContainer> ref );
void TextFinderBarContainerSetFindBarView( id<NSTextFinderBarContainer> ref, NSView *aView );
NSView *TextFinderBarContainerContentView( id<NSTextFinderBarContainer> ref );
//void TextFinderBarContainerSetContentView( id<NSTextFinderBarContainer> ref, NSView *aView );
BOOL TextFinderBarContainerIsFindBarVisible( id<NSTextFinderBarContainer> ref );
void TextFinderBarContainerSetFindBarVisible( id<NSTextFinderBarContainer> ref, BOOL flag );

// Height
void TextFinderBarContainerFindBarViewDidChangeHeight( id<NSTextFinderBarContainer> ref );


/*
  TextFinderClient
*/

// String searching
CFStringRef TextFinderClientString( id<NSTextFinderClient> ref );
CFStringRef TextFinderClientStringAtIndex( id<NSTextFinderClient> ref, NSUInteger characterIndex, CFRange *effectiveRange, BOOL *endsWithSearchBoundary );
NSUInteger TextFinderClientStringLength( id<NSTextFinderClient> ref );

// Replacing text
BOOL TextFinderClientShouldReplaceCharactersInRanges( id<NSTextFinderClient> ref, CFArrayRef ranges, CFArrayRef strings );
void TextFinderClientReplaceCharactersInRange( id<NSTextFinderClient> ref, CFRange range, CFStringRef string );
void TextFinderClientDidReplaceCharacters( id<NSTextFinderClient> ref );

// Selection
BOOL TextFinderClientIsSelectable( id<NSTextFinderClient> ref );
BOOL TextFinderClientAllowsMultipleSelection( id<NSTextFinderClient> ref );
CFRange TextFinderClientFirstSelectedRange( id<NSTextFinderClient> ref );
CFArrayRef TextFinderClientFirstSelectedRanges( id<NSTextFinderClient> ref );

// Editable
BOOL TextFinderClientIsEditable( id<NSTextFinderClient> ref );

// Text locations
NSView *TextFinderClientContentViewAtIndex( id<NSTextFinderClient> ref, NSUInteger index, CFRange *effectiveCharRange );
CFArrayRef TextFinderClientRectsForCharacterRange( id<NSTextFinderClient> ref, CFRange range );
void TextFinderClientScrollRangeToVisible( id<NSTextFinderClient> ref, CFRange range );
CFArrayRef TextFinderClientVisibleCharacterRanges( id<NSTextFinderClient> ref );

// Drawing glyphs
void TextFinderClientDrawCharactersInRange( id<NSTextFinderClient> ref, CFRange range, NSView *contentView );
