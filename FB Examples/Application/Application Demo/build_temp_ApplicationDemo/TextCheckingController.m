/*
 TextCheckingController.m

 Bernie Wylde
 */

#import "TextCheckingController.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500

// Class
Class TextCheckingControllerClass( void )
{ return [NSTextCheckingController class]; }

// Initializers
NSTextCheckingController *TextCheckingControllerWithClient( CFTypeRef client )
{
#if __has_feature(objc_arc)
    return [[NSTextCheckingController alloc] initWithClient:(__bridge id)client];
#else
    return [[[NSTextCheckingController alloc] initWithClient:(__bridge id)client] autorelease];
#endif
}

// Instance properties
CFTypeRef TextCheckingControllerClient( NSTextCheckingController *ref )
{ return (__bridge CFTypeRef)[ref client]; }

NSInteger TextCheckingControllerSpellCheckerDocumentTag( NSTextCheckingController *ref )
{ return [ref spellCheckerDocumentTag]; }

void TextCheckingControllerSetSpellCheckerDocumentTag( NSTextCheckingController *ref, NSInteger tag )
{ [ref setSpellCheckerDocumentTag:tag]; }

// Instance methods
void TextCheckingControllerChangeSpelling( NSTextCheckingController *ref, CFTypeRef sender )
{ [ref changeSpelling:(__bridge id)sender]; }

void TextCheckingControllerCheckSpelling( NSTextCheckingController *ref, CFTypeRef sender )
{ [ref checkSpelling:(__bridge id)sender]; }

void TextCheckingControllerCheckTextInRange( NSTextCheckingController *ref, CFRange range, NSTextCheckingTypes types, CFDictionaryRef options )
{ [ref checkTextInRange:NSRangeFromCFRange(range) types:types options:(__bridge NSDictionary *)options]; }

void TextCheckingControllerCheckTextInDocument( NSTextCheckingController *ref, CFTypeRef sender )
{ [ref checkTextInDocument:(__bridge id)sender]; }

void TextCheckingControllerCheckTextInSelection( NSTextCheckingController *ref, CFTypeRef sender )
{ [ref checkTextInSelection:(__bridge id)sender]; }

void TextCheckingControllerConsiderTextCheckingForRange( NSTextCheckingController *ref, CFRange range )
{ [ref considerTextCheckingForRange:NSRangeFromCFRange(range)]; }

void TextCheckingControllerDidChangeSelectedRange( NSTextCheckingController *ref )
{ [ref didChangeSelectedRange]; }

void TextCheckingControllerDidChangeTextInRange( NSTextCheckingController *ref, CFRange range )
{ [ref didChangeTextInRange:NSRangeFromCFRange(range)]; }

void TextCheckingControllerIgnoreSpelling( NSTextCheckingController *ref, CFTypeRef sender )
{ [ref ignoreSpelling:(__bridge id)sender]; }

void TextCheckingControllerInsertedTextInRange( NSTextCheckingController *ref, CFRange range )
{ [ref insertedTextInRange:NSRangeFromCFRange(range)]; }

void TextCheckingControllerInvaliate( NSTextCheckingController *ref )
{ [ref invalidate]; }

NSMenu *TextCheckingControllerMenuAtIndex( NSTextCheckingController *ref, NSUInteger location, BOOL clickedOnSelection, CFRange *effectiveRange )
{ return [ref menuAtIndex:location clickedOnSelection:clickedOnSelection effectiveRange:(NSRangePointer)effectiveRange]; }

void TextCheckingControllerOrderFrontSubstitionsPanel( NSTextCheckingController *ref, CFTypeRef sender )
{ [ref orderFrontSubstitutionsPanel:(__bridge id)sender]; }

void TextCheckingControllerShowGuessPanel( NSTextCheckingController *ref, CFTypeRef sender )
{ [ref showGuessPanel:(__bridge id)sender]; }

void TextCheckingControllerUpdateCandidates( NSTextCheckingController *ref )
{ [ref updateCandidates]; }

CFArrayRef TextCheckingControllerValidAnnotations( NSTextCheckingController *ref )
{ return (__bridge CFArrayRef)[ref validAnnotations]; }

#endif

