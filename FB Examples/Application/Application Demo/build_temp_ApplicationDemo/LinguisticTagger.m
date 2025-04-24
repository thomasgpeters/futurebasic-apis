/*
 LinguisticTagger.m

 Bernie Wylde
 */

#import "LinguisticTagger.h"

// Class
Class LinguisticTaggerClass( void )
{ return [NSLinguisticTagger class]; }

// - init -
NSLinguisticTagger *LinguisticTaggerInit( CFArrayRef tagSchemes, NSUInteger options )
{
#if __has_feature(objc_arc)
    return [[NSLinguisticTagger alloc] initWithTagSchemes:(__bridge NSArray *)tagSchemes options:options];
#else
    return [[[NSLinguisticTagger alloc] initWithTagSchemes:(__bridge NSArray *)tagSchemes options:options] autorelease];
#endif
}

NSLinguisticTagger *LinguisticTaggerWithTagSchemes( CFArrayRef tagSchemes, NSUInteger options )
{
#if __has_feature(objc_arc)
    return [[NSLinguisticTagger alloc] initWithTagSchemes:(__bridge NSArray *)tagSchemes options:options];
#else
    return [[[NSLinguisticTagger alloc] initWithTagSchemes:(__bridge NSArray *)tagSchemes options:options] autorelease];
#endif
}

// - string -
CFStringRef LinguisticTaggerString( NSLinguisticTagger *ref )
{ return (__bridge CFStringRef)[ref string]; }

void LinguisticTaggerSetString( NSLinguisticTagger *ref, CFStringRef string )
{ [ref setString:(__bridge NSString *)string]; }

// - tag schemes -
CFArrayRef LinguisticTaggerAvailableTagSchemesForUnit( NSLinguisticTaggerUnit unit, CFStringRef language )
{ return (__bridge CFArrayRef)[NSLinguisticTagger availableTagSchemesForUnit:unit language:(__bridge NSString *)language]; }

CFArrayRef LinguisticTaggerAvailableTagSchemesForLanguage( CFStringRef language )
{ return (__bridge CFArrayRef)[NSLinguisticTagger availableTagSchemesForLanguage:(__bridge NSString *)language]; }

CFArrayRef LinguisticTaggerTagSchemes( NSLinguisticTagger *ref )
{ return (__bridge CFArrayRef)[ref tagSchemes]; }

// - determine dominant language and orthography -
CFStringRef LinguisticTaggerDominantLanguageForString( CFStringRef string )
{ return (__bridge CFStringRef)[NSLinguisticTagger dominantLanguageForString:(__bridge NSString *)string]; }

CFStringRef LinguisticTaggerDominantLanguage( NSLinguisticTagger *ref )
{ return (__bridge CFStringRef)[ref dominantLanguage]; }

NSOrthography *LinguisticTaggerOrthographyAtIndex( NSLinguisticTagger *ref, NSUInteger index, CFRange *effectiveRange )
{ return [ref orthographyAtIndex:index effectiveRange:(NSRangePointer)effectiveRange]; }

void LinguisticTaggerSetOrthography( NSLinguisticTagger *ref, NSOrthography *orthRef, CFRange range )
{ [ref setOrthography:orthRef range:NSRangeFromCFRange(range)]; }

// - enumerate -
void LinguisticTaggerEnumerateTagsForUnit( NSLinguisticTagger *ref, CFRange range, NSLinguisticTaggerUnit unit, CFStringRef scheme, NSLinguisticTaggerOptions options, CUI_LinguisticTaggerCallbackType2 callback, void *userData )
{
    [ref enumerateTagsInRange:NSRangeFromCFRange(range)
                         unit:unit
                       scheme:(__bridge NSString *)scheme
                      options:options
                   usingBlock:^(NSString *tag, NSRange tokenRange, BOOL *stop) {
        (*callback)(ref,(__bridge CFStringRef)tag, NSRangeToCFRange(tokenRange), stop, userData );
    }];
}

void LinguisticTaggerEnumerateTagsForScheme( NSLinguisticTagger *ref, CFRange range, CFStringRef scheme, NSLinguisticTaggerOptions options, CUI_LinguisticTaggerCallbackType1 callback, void *userData )
{
    [ref enumerateTagsInRange:NSRangeFromCFRange(range)
                       scheme:(__bridge NSString *)scheme
                      options:options
                   usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
                       (*callback)(ref,(__bridge CFStringRef)tag, NSRangeToCFRange(tokenRange), NSRangeToCFRange(sentenceRange), stop, userData );
                   }];
}

void LinguisticTaggerEnumerateTagsForString( CFStringRef string, CFRange range, NSLinguisticTaggerUnit unit, CFStringRef scheme, NSLinguisticTaggerOptions options, NSOrthography *orthRef, CUI_LinguisticTaggerCallbackType2 callback, void *userData )
{
    [NSLinguisticTagger enumerateTagsForString:(__bridge NSString *)string
                                         range:NSRangeFromCFRange(range)
                                          unit:unit
                                        scheme:(__bridge NSString *)scheme
                                       options:options
                                   orthography:orthRef
                                    usingBlock:^(NSString *tag, NSRange tokenRange, BOOL *stop) {
                                        (*callback)(nil, (__bridge CFStringRef)tag, NSRangeToCFRange(tokenRange), stop, userData );
                                    }];
}

// - get -
CFStringRef LinguisticTaggerTagForUnit( NSLinguisticTagger *ref, NSUInteger index, NSLinguisticTaggerUnit unit, CFStringRef scheme, CFRange *tokenRange )
{ return (__bridge CFStringRef)[ref tagAtIndex:index unit:unit scheme:(__bridge NSString *)scheme tokenRange:(NSRangePointer)tokenRange]; }

CFStringRef LinguisticTaggerTagForScheme( NSLinguisticTagger *ref, NSUInteger index, CFStringRef scheme, CFRange *tokenRange, CFRange *sentenceRange )
{ return (__bridge CFStringRef)[ref tagAtIndex:index scheme:(__bridge NSString *)scheme tokenRange:(NSRangePointer)tokenRange sentenceRange:(NSRangePointer)sentenceRange]; }

CFStringRef LinguisticTaggerTagForString( CFStringRef string, NSUInteger index, NSLinguisticTaggerUnit unit, CFStringRef scheme, NSOrthography *orthRef, CFRange *tokenRange )
{ return (__bridge CFStringRef)[NSLinguisticTagger tagForString:(__bridge NSString *)string atIndex:index unit:unit scheme:(__bridge NSString *)scheme orthography:orthRef tokenRange:(NSRangePointer)tokenRange]; }

CFArrayRef LinguisticTaggerTagsForUnit( NSLinguisticTagger *ref, CFRange range, NSLinguisticTaggerUnit unit, CFStringRef scheme, NSLinguisticTaggerOptions options, CFArrayRef *tokenRanges )
{
    NSArray *tempTokenRanges = nil;
    NSArray *result = [ref tagsInRange:NSRangeFromCFRange(range) unit:unit scheme:(__bridge NSString *)scheme options:options tokenRanges:&tempTokenRanges];
    if ( tokenRanges ) *tokenRanges = (__bridge CFArrayRef)tempTokenRanges;
    return (__bridge CFArrayRef)result;
}

CFArrayRef LinguisticTaggerTagsForScheme( NSLinguisticTagger *ref, CFRange range, CFStringRef scheme, NSLinguisticTaggerOptions options, CFArrayRef *tokenRanges )
{
    NSArray *tempTokenRanges = nil;
    NSArray *result = [ref tagsInRange:NSRangeFromCFRange(range) scheme:(__bridge NSString *)scheme options:options tokenRanges:&tempTokenRanges];
    if ( tokenRanges ) *tokenRanges = (__bridge CFArrayRef)tempTokenRanges;
    return (__bridge CFArrayRef)result;
}

CFArrayRef LinguisticTaggerTagsForString( CFStringRef string, CFRange range, NSLinguisticTaggerUnit unit, CFStringRef scheme, NSLinguisticTaggerOptions options, NSOrthography *orthRef, CFArrayRef *tokenRanges )
{
    NSArray *tempTokenRanges = nil;
    NSArray *result = [NSLinguisticTagger tagsForString:(__bridge NSString *)string range:NSRangeFromCFRange(range) unit:unit scheme:(__bridge NSString *)scheme options:options orthography:orthRef tokenRanges:&tempTokenRanges];
    if ( tokenRanges ) *tokenRanges = (__bridge CFArrayRef)tempTokenRanges;
    return (__bridge CFArrayRef)result;
}

// - range of unit token -
CFRange LinguisticTaggerTokenRangeAtIndex( NSLinguisticTagger *ref, NSUInteger index, NSLinguisticTaggerUnit unit )
{
    NSRange range = [ref tokenRangeAtIndex:index unit:unit];
    return NSRangeToCFRange(range);
}

CFRange LinguisticTaggerSentenceRangeForRange( NSLinguisticTagger *ref, CFRange range )
{
    NSRange outRange = [ref sentenceRangeForRange:(NSRangeFromCFRange(range))];
    return NSRangeToCFRange(outRange);
}

// - possible tags -
CFArrayRef LinguisticTaggerPossibleTagsAtIndex( NSLinguisticTagger *ref, NSUInteger index, CFStringRef scheme, CFRange *tokenRange, CFRange *sentenceRange, CFArrayRef *scores )
{
    NSArray *tempScores = nil;
    NSArray *result = [ref possibleTagsAtIndex:index scheme:(__bridge NSString *)scheme tokenRange:(NSRangePointer)tokenRange sentenceRange:(NSRangePointer)sentenceRange scores:&tempScores];
    if ( scores ) *scores = (__bridge CFArrayRef)tempScores;
    return (__bridge CFArrayRef)result;
}

// Notify changes to analyzed string
void LinguisticTaggerStringEditedInRange( NSLinguisticTagger *ref, CFRange newRange, NSInteger delta )
{ [ref stringEditedInRange:NSRangeFromCFRange(newRange) changeInLength:delta]; }

