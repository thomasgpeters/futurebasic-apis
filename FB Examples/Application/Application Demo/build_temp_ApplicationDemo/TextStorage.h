/*
 TextStorage.h

 Bernie Wylde
 */

#import "CocoaUI.h"

typedef BOOL (*CUI_TextStorageCallbackType)(NSTextStorage *,NSUInteger,CFRange,NSInteger,void *);

@interface NSTextStorage (Additions)
@property (nonatomic,retain) NSValue *willProcessEditingCallbackValue;
@property (nonatomic,retain) NSValue *willProcessEditingUserDataValue;

@property (nonatomic,retain) NSValue *didProcessEditingCallbackValue;
@property (nonatomic,retain) NSValue *didProcessEditingUserDataValue;

- (CUI_TextStorageCallbackType)willProcessEditingCallback;
- (void *)willProcessEditingUserData;
- (void)setCuiTextStorageWillProcessEditingCallback:(CUI_TextStorageCallbackType)cb;
- (void)setCuiTextStorageWillProcessEditingUserData:(void *)ud;

- (CUI_TextStorageCallbackType)didProcessEditingCallback;
- (void *)didProcessEditingUserData;
- (void)setCuiTextStorageDidProcessEditingCallback:(CUI_TextStorageCallbackType)cb;
- (void)setCuiTextStorageDidProcessEditingUserData:(void *)ud;
@end

@interface CUI_TextStorageDelegate : NSObject <NSTextStorageDelegate>
@end

// private
CUI_TextStorageDelegate *CUI_TextStorageDelegateObj( void );

// Class
Class TextStorageClass( void );

// Layout managers
CFArrayRef TextStorageLayoutManagers( NSTextStorage *ref );
void TextStorageAddLayoutManager( NSTextStorage *ref, NSLayoutManager *lm );
void TextStorageRemoveLayoutManager( NSTextStorage *ref, NSLayoutManager *lm );

// Text editing messages
void TextStorageEdited( NSTextStorage *ref, NSUInteger editedMask, CFRange editedRange, NSInteger changeInLength );
void TextStorageProcessEditing( NSTextStorage *ref );

// Fixing string attributes
void TextStorageInvalidateAttributesInRange( NSTextStorage *ref, CFRange range );
void TextStorageEnsureAttributesAreFixedInRange( NSTextStorage *ref, CFRange range );
BOOL TextStorageFixesAttributesLazily( NSTextStorage *ref );

// Nature of changes
NSUInteger TextStorageEditedMask( NSTextStorage *ref );
CFRange TextStorageEditedRange( NSTextStorage *ref );
NSInteger TextStorageChangeInLength( NSTextStorage *ref );

// Scriptable properties
CFArrayRef TextStorageAttributeRuns( NSTextStorage *ref );
void TextStorageSetAttributeRuns( NSTextStorage *ref, CFArrayRef runs );
CFArrayRef TextStorageParagraphs( NSTextStorage *ref );
void TextStorageSetParagraphs( NSTextStorage *ref, CFArrayRef paragraphs );
CFArrayRef TextStorageWords( NSTextStorage *ref );
void TextStorageSetWords( NSTextStorage *ref, CFArrayRef words );
CFArrayRef TextStorageCharacters( NSTextStorage *ref );
void TextStorageSetCharacters( NSTextStorage *ref, CFArrayRef characters );
NSFont *TextStorageFont( NSTextStorage *ref );
void TextStorageSetFont( NSTextStorage *ref, NSFont *font );
NSColor *TextStorageForegroundColor( NSTextStorage *ref );
void TextStorageSetForegroundColor( NSTextStorage *ref, NSColor *col );

// Custom
void TextStorageSetWillProcessEditingCallback( NSTextStorage *ref, CUI_TextStorageCallbackType callback, void *userData );
void TextStorageSetDidProcessEditingCallback( NSTextStorage *ref, CUI_TextStorageCallbackType callback, void *userData );

// Convenience
NSTextStorage *TextStorageWithURL( CFURLRef url, CFDictionaryRef options, CFDictionaryRef *attributes, NSError **err );


