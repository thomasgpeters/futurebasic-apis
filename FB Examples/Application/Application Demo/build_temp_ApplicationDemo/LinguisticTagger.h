/*
 LinguisticTagger.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef void (*CUI_LinguisticTaggerCallbackType1)(NSLinguisticTagger*,CFStringRef,CFRange,CFRange,BOOL*,void*);
typedef void (*CUI_LinguisticTaggerCallbackType2)(NSLinguisticTagger*,CFStringRef,CFRange,BOOL*,void*);

//@interface CUI_LinguisticTaggerTarget : NSObject {
//    CUI_LinguisticTaggerCallbackType callback;
//    void *userData;
//}
//@property (nonatomic,assign) CUI_LinguisticTaggerCallbackType callback;
//@property (nonatomic,assign) void *userData;
//@end

// Class
Class LinguisticTaggerClass( void );

// - init -
NSLinguisticTagger *LinguisticTaggerInit( CFArrayRef tagSchemes, NSUInteger options );
NSLinguisticTagger *LinguisticTaggerWithTagSchemes( CFArrayRef tagSchemes, NSUInteger options );

// - string -
CFStringRef LinguisticTaggerString( NSLinguisticTagger *ref );
void LinguisticTaggerSetString( NSLinguisticTagger *ref, CFStringRef string );

// - tag schemes -
CFArrayRef LinguisticTaggerAvailableTagSchemesForUnit( NSLinguisticTaggerUnit unit, CFStringRef language );
CFArrayRef LinguisticTaggerAvailableTagSchemesForLanguage( CFStringRef language );
CFArrayRef LinguisticTaggerTagSchemes( NSLinguisticTagger *ref );

// - determine dominant language and orthography -
CFStringRef LinguisticTaggerDominantLanguageForString( CFStringRef string );
CFStringRef LinguisticTaggerDominantLanguage( NSLinguisticTagger *ref );
NSOrthography *LinguisticTaggerOrthographyAtIndex( NSLinguisticTagger *ref, NSUInteger index, CFRange *effectiveRange );
void LinguisticTaggerSetOrthography( NSLinguisticTagger *ref, NSOrthography *orthRef, CFRange range );

// - enumerate -
void LinguisticTaggerEnumerateTagsForUnit( NSLinguisticTagger *ref, CFRange range, NSLinguisticTaggerUnit unit, CFStringRef scheme, NSLinguisticTaggerOptions options, CUI_LinguisticTaggerCallbackType2 callback, void *userData );
void LinguisticTaggerEnumerateTagsForScheme( NSLinguisticTagger *ref, CFRange range, CFStringRef scheme, NSLinguisticTaggerOptions options, CUI_LinguisticTaggerCallbackType1 callback, void *userData );
void LinguisticTaggerEnumerateTagsForString( CFStringRef string, CFRange range, NSLinguisticTaggerUnit unit, CFStringRef scheme, NSLinguisticTaggerOptions options, NSOrthography *orthRef, CUI_LinguisticTaggerCallbackType2 callback, void *userData );

// - get -
CFStringRef LinguisticTaggerTagForUnit( NSLinguisticTagger *ref, NSUInteger index, NSLinguisticTaggerUnit unit, CFStringRef scheme, CFRange *tokenRange );
CFStringRef LinguisticTaggerTagForScheme( NSLinguisticTagger *ref, NSUInteger index, CFStringRef scheme, CFRange *tokenRange, CFRange *sentenceRange );
CFStringRef LinguisticTaggerTagForString( CFStringRef string, NSUInteger index, NSLinguisticTaggerUnit unit, CFStringRef scheme, NSOrthography *orthRef, CFRange *tokenRange );
CFArrayRef LinguisticTaggerTagsForUnit( NSLinguisticTagger *ref, CFRange range, NSLinguisticTaggerUnit unit, CFStringRef scheme, NSLinguisticTaggerOptions options, CFArrayRef *tokenRanges );
CFArrayRef LinguisticTaggerTagsForScheme( NSLinguisticTagger *ref, CFRange range, CFStringRef scheme, NSLinguisticTaggerOptions options, CFArrayRef *tokenRanges );
CFArrayRef LinguisticTaggerTagsForString( CFStringRef string, CFRange range, NSLinguisticTaggerUnit unit, CFStringRef scheme, NSLinguisticTaggerOptions options, NSOrthography *orthRef, CFArrayRef *tokenRanges );

// - range of unit token -
CFRange LinguisticTaggerTokenRangeAtIndex( NSLinguisticTagger *ref, NSUInteger index, NSLinguisticTaggerUnit unit );
CFRange LinguisticTaggerSentenceRangeForRange( NSLinguisticTagger *ref, CFRange range );

// - possible tags -
CFArrayRef LinguisticTaggerPossibleTagsAtIndex( NSLinguisticTagger *ref, NSUInteger index, CFStringRef scheme, CFRange *tokenRange, CFRange *sentenceRange, CFArrayRef *scores );

// Notify changes to analyzed string
void LinguisticTaggerStringEditedInRange( NSLinguisticTagger *ref, CFRange newRange, NSInteger delta );

