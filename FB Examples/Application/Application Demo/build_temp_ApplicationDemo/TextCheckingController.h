/*
 TextCheckingController.h

 Bernie Wylde
 */


#import "CocoaUI.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500

// Class
API_AVAILABLE(macos(10.15))
Class TextCheckingControllerClass( void );

// Initializers
API_AVAILABLE(macos(10.15))
NSTextCheckingController *TextCheckingControllerWithClient( CFTypeRef client );

// Instance properties
API_AVAILABLE(macos(10.15))
CFTypeRef TextCheckingControllerClient( NSTextCheckingController *ref );
API_AVAILABLE(macos(10.15))
NSInteger TextCheckingControllerSpellCheckerDocumentTag( NSTextCheckingController *ref );
API_AVAILABLE(macos(10.15))
void TextCheckingControllerSetSpellCheckerDocumentTag( NSTextCheckingController *ref, NSInteger tag );

// Instance methods
API_AVAILABLE(macos(10.15))
void TextCheckingControllerChangeSpelling( NSTextCheckingController *ref, CFTypeRef sender );
API_AVAILABLE(macos(10.15))
void TextCheckingControllerCheckSpelling( NSTextCheckingController *ref, CFTypeRef sender );
API_AVAILABLE(macos(10.15))
void TextCheckingControllerCheckTextInRange( NSTextCheckingController *ref, CFRange range, NSTextCheckingTypes types, CFDictionaryRef options );
API_AVAILABLE(macos(10.15))
void TextCheckingControllerCheckTextInDocument( NSTextCheckingController *ref, CFTypeRef sender );
API_AVAILABLE(macos(10.15))
void TextCheckingControllerCheckTextInSelection( NSTextCheckingController *ref, CFTypeRef sender );
API_AVAILABLE(macos(10.15))
void TextCheckingControllerConsiderTextCheckingForRange( NSTextCheckingController *ref, CFRange range );
API_AVAILABLE(macos(10.15))
void TextCheckingControllerDidChangeSelectedRange( NSTextCheckingController *ref );
API_AVAILABLE(macos(10.15))
void TextCheckingControllerDidChangeTextInRange( NSTextCheckingController *ref, CFRange range );
API_AVAILABLE(macos(10.15))
void TextCheckingControllerIgnoreSpelling( NSTextCheckingController *ref, CFTypeRef sender );
API_AVAILABLE(macos(10.15))
void TextCheckingControllerInsertedTextInRange( NSTextCheckingController *ref, CFRange range );
API_AVAILABLE(macos(10.15))
void TextCheckingControllerInvaliate( NSTextCheckingController *ref );
API_AVAILABLE(macos(10.15))
NSMenu *TextCheckingControllerMenuAtIndex( NSTextCheckingController *ref, NSUInteger location, BOOL clickedOnSelection, CFRange *effectiveRange );
API_AVAILABLE(macos(10.15))
void TextCheckingControllerOrderFrontSubstitionsPanel( NSTextCheckingController *ref, CFTypeRef sender );
API_AVAILABLE(macos(10.15))
void TextCheckingControllerShowGuessPanel( NSTextCheckingController *ref, CFTypeRef sender );
API_AVAILABLE(macos(10.15))
void TextCheckingControllerUpdateCandidates( NSTextCheckingController *ref );
API_AVAILABLE(macos(10.15))
CFArrayRef TextCheckingControllerValidAnnotations( NSTextCheckingController *ref );
API_AVAILABLE(macos(10.15))

#endif// 101500

