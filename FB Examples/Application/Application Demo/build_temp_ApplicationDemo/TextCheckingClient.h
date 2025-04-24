/*
 TextCheckingClient.h

 Bernie Wylde
 */

#import "CocoaUI.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500

// Instance methods
void TextCheckingClientAddAnnotations( id<NSTextCheckingClient> ref, CFDictionaryRef annotations, CFRange range );
CFAttributedStringRef TextCheckingClientAnnotatedSubstring( id<NSTextCheckingClient> ref, CFRange proposedRange, CFRange *actualRange );
void TextCheckingClientRemoveAnnotation( id<NSTextCheckingClient> ref, CFStringRef annotationName, CFRange range );
void TextCheckingClientReplaceCharacters( id<NSTextCheckingClient> ref, CFRange range, CFAttributedStringRef annotatedString );
void TextCheckingClientSelectAndShowRange( id<NSTextCheckingClient> ref, CFRange range );
void TextCheckingClientSetAnnotations( id<NSTextCheckingClient> ref, CFDictionaryRef annotations, CFRange range );
NSView *TextCheckingClientViewForRange( id<NSTextCheckingClient> ref, CFRange range, CGRect *firstRect, CFRange *actualRange );

#pragma mark - TextInputTraits
NSTextInputTraitType TextInputTraitsAutocorrectionType( id<NSTextInputTraits> ref );
void TextInputTraitsSetAutocorrectionType( id<NSTextInputTraits> ref, NSTextInputTraitType type );

NSTextInputTraitType TextInputTraitsSpellCheckingType( id<NSTextInputTraits> ref );
void TextInputTraitsSetSpellCheckingType( id<NSTextInputTraits> ref, NSTextInputTraitType type );
NSTextInputTraitType TextInputTraitsGrammarCheckingType( id<NSTextInputTraits> ref );
void TextInputTraitsSetGrammarCheckingType( id<NSTextInputTraits> ref, NSTextInputTraitType type );
NSTextInputTraitType TextInputTraitsSmartQuotesType( id<NSTextInputTraits> ref );
void TextInputTraitsSetSmartQuotesType( id<NSTextInputTraits> ref, NSTextInputTraitType type );
NSTextInputTraitType TextInputTraitsSmartDashesType( id<NSTextInputTraits> ref );
void TextInputTraitsSetSmartDashesType( id<NSTextInputTraits> ref, NSTextInputTraitType type );
NSTextInputTraitType TextInputTraitsInsertDeleteType( id<NSTextInputTraits> ref );
void TextInputTraitsSetInsertDeleteType( id<NSTextInputTraits> ref, NSTextInputTraitType type );
NSTextInputTraitType TextInputTraitsTextReplacementType( id<NSTextInputTraits> ref );
void TextInputTraitsSetTextReplacementType( id<NSTextInputTraits> ref, NSTextInputTraitType type );
NSTextInputTraitType TextInputTraitsDataDetectionType( id<NSTextInputTraits> ref );
void TextInputTraitsSetDataDetectionType( id<NSTextInputTraits> ref, NSTextInputTraitType type );
NSTextInputTraitType TextInputTraitsLinkDetectionType( id<NSTextInputTraits> ref );
void TextInputTraitsSetLinkDetectionType( id<NSTextInputTraits> ref, NSTextInputTraitType type );
NSTextInputTraitType TextInputTraitsTextCompletionType( id<NSTextInputTraits> ref );
void TextInputTraitsSetTextCompletionType( id<NSTextInputTraits> ref, NSTextInputTraitType type );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
NSTextInputTraitType TextInputTraitsInlinePredictionType( id<NSTextInputTraits> ref );
void TextInputTraitsSetInlinePredictionType( id<NSTextInputTraits> ref, NSTextInputTraitType type );
#endif // 140000
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
API_AVAILABLE(macos(15.0))
NSTextInputTraitType TextInputTraitsMathExpressionCompletionType( id<NSTextInputTraits> ref );
API_AVAILABLE(macos(15.0))
void TextInputTraitsSetMathExpressionCompletionType( id<NSTextInputTraits> ref, NSTextInputTraitType type );
API_AVAILABLE(macos(15.0))
NSWritingToolsBehavior TextInputTraitsWritingToolsBehavior( id<NSTextInputTraits> ref );
API_AVAILABLE(macos(15.0))
void TextInputTraitsSetWritingToolsBehavior( id<NSTextInputTraits> ref, NSWritingToolsBehavior behavior );
//API_AVAILABLE(macos(15.0))
//NSWritingToolsAllowedInputOptions TextInputTraitsWritingToolsAllowedInputOptions( id<NSTextInputTraits> ref );
//API_AVAILABLE(macos(15.0))
//void TextInputTraitsSetWritingToolsAllowedInputOptions( id<NSTextInputTraits> ref, NSWritingToolsAllowedInputOptions options );
#endif // 150000

#endif// 101500

