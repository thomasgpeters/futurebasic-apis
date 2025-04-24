/*
 TextStorage.m

 Bernie Wylde
 */

#import "TextStorage.h"

@implementation NSTextStorage (Additions)
@dynamic willProcessEditingCallbackValue;
@dynamic willProcessEditingUserDataValue;

@dynamic didProcessEditingCallbackValue;
@dynamic didProcessEditingUserDataValue;

- (CUI_TextStorageCallbackType)willProcessEditingCallback {
    return (CUI_TextStorageCallbackType)[objc_getAssociatedObject(self, @selector(willProcessEditingCallbackValue)) pointerValue];
}

- (void *)willProcessEditingUserData {
    return [objc_getAssociatedObject(self, @selector(willProcessEditingUserDataValue)) pointerValue];
}

- (void)setCuiTextStorageWillProcessEditingCallback:(CUI_TextStorageCallbackType)callback {
    objc_setAssociatedObject(self, @selector(willProcessEditingCallbackValue), [NSValue valueWithPointer:(void *)callback], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setCuiTextStorageWillProcessEditingUserData:(void *)userData {
    objc_setAssociatedObject(self, @selector(willProcessEditingUserDataValue), [NSValue valueWithPointer:userData], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CUI_TextStorageCallbackType)didProcessEditingCallback {
    return (CUI_TextStorageCallbackType)[objc_getAssociatedObject(self, @selector(didProcessEditingCallbackValue)) pointerValue];
}

- (void *)didProcessEditingUserData {
    return [objc_getAssociatedObject(self, @selector(didProcessEditingUserDataValue)) pointerValue];
}

- (void)setCuiTextStorageDidProcessEditingCallback:(CUI_TextStorageCallbackType)callback {
    objc_setAssociatedObject(self, @selector(didProcessEditingCallbackValue), [NSValue valueWithPointer:(void *)callback], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setCuiTextStorageDidProcessEditingUserData:(void *)userData {
    objc_setAssociatedObject(self, @selector(didProcessEditingUserDataValue), [NSValue valueWithPointer:userData], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end


@implementation CUI_TextStorageDelegate

- (void)textStorage:(NSTextStorage *)textStorage willProcessEditing:(NSTextStorageEditActions)editedMask range:(NSRange)editedRange changeInLength:(NSInteger)delta {
    CUI_TextStorageCallbackType callback = [textStorage willProcessEditingCallback];
    if ( callback ) {
        void *userData = [textStorage willProcessEditingUserData];
        (*callback)(textStorage,editedMask,NSRangeToCFRange(editedRange),delta,userData);
    }
}

- (void)textStorage:(NSTextStorage *)textStorage didProcessEditing:(NSTextStorageEditActions)editedMask range:(NSRange)editedRange changeInLength:(NSInteger)delta {
    CUI_TextStorageCallbackType callback = [textStorage didProcessEditingCallback];
    if ( callback ) {
        void *userData = [textStorage didProcessEditingUserData];
        (*callback)(textStorage,editedMask,NSRangeToCFRange(editedRange),delta,userData);
    }
}


@end



// - private -
CUI_TextStorageDelegate *CUI_TextStorageDelegateObj( void )
{
    static CUI_TextStorageDelegate *sCUI_TextStorageDelegate = nil;
    if ( !sCUI_TextStorageDelegate ) sCUI_TextStorageDelegate = [[CUI_TextStorageDelegate alloc] init];
    return sCUI_TextStorageDelegate;
}


// - public -
// Class
Class TextStorageClass( void )
{ return [NSTextStorage class]; }

// Layout managers
CFArrayRef TextStorageLayoutManagers( NSTextStorage *ref )
{ return (__bridge CFArrayRef)[ref layoutManagers]; }

void TextStorageAddLayoutManager( NSTextStorage *ref, NSLayoutManager *lm )
{ [ref addLayoutManager:lm]; }

void TextStorageRemoveLayoutManager( NSTextStorage *ref, NSLayoutManager *lm )
{ [ref removeLayoutManager:lm]; }

// Text editing messages
void TextStorageEdited( NSTextStorage *ref, NSUInteger editedMask, CFRange editedRange, NSInteger changeInLength )
{ [ref edited:editedMask range:NSRangeFromCFRange(editedRange) changeInLength:changeInLength]; }

void TextStorageProcessEditing( NSTextStorage *ref )
{ [ref processEditing]; }

// Fixing string attributes
void TextStorageInvalidateAttributesInRange( NSTextStorage *ref, CFRange range )
{ [ref invalidateAttributesInRange:NSRangeFromCFRange(range)]; }

void TextStorageEnsureAttributesAreFixedInRange( NSTextStorage *ref, CFRange range )
{ [ref ensureAttributesAreFixedInRange:NSRangeFromCFRange(range)]; }

BOOL TextStorageFixesAttributesLazily( NSTextStorage *ref )
{ return [ref fixesAttributesLazily]; }

// Nature of changes
NSUInteger TextStorageEditedMask( NSTextStorage *ref )
{ return [ref editedMask]; }

CFRange TextStorageEditedRange( NSTextStorage *ref )
{ return NSRangeToCFRange([ref editedRange]); }

NSInteger TextStorageChangeInLength( NSTextStorage *ref )
{ return [ref changeInLength]; }

// Scriptable properties
CFArrayRef TextStorageAttributeRuns( NSTextStorage *ref )
{ return (__bridge CFArrayRef)[ref attributeRuns]; }

void TextStorageSetAttributeRuns( NSTextStorage *ref, CFArrayRef runs )
{ [ref setAttributeRuns:(__bridge NSArray *)runs]; }

CFArrayRef TextStorageParagraphs( NSTextStorage *ref )
{ return (__bridge CFArrayRef)[ref paragraphs]; }

void TextStorageSetParagraphs( NSTextStorage *ref, CFArrayRef paragraphs )
{ [ref setParagraphs:(__bridge NSArray *)paragraphs]; }

CFArrayRef TextStorageWords( NSTextStorage *ref )
{ return (__bridge CFArrayRef)[ref words]; }

void TextStorageSetWords( NSTextStorage *ref, CFArrayRef words )
{ [ref setWords:(__bridge NSArray *)words]; }

CFArrayRef TextStorageCharacters( NSTextStorage *ref )
{ return (__bridge CFArrayRef)[ref characters]; }

void TextStorageSetCharacters( NSTextStorage *ref, CFArrayRef characters )
{ [ref setCharacters:(__bridge NSArray *)characters]; }

NSFont *TextStorageFont( NSTextStorage *ref )
{ return [ref font]; }

void TextStorageSetFont( NSTextStorage *ref, NSFont *font )
{ [ref setFont:font]; }

NSColor *TextStorageForegroundColor( NSTextStorage *ref )
{ return [ref foregroundColor]; }

void TextStorageSetForegroundColor( NSTextStorage *ref, NSColor *col )
{ [ref setForegroundColor:col]; }

// Custom
void TextStorageSetWillProcessEditingCallback( NSTextStorage *ref, CUI_TextStorageCallbackType callback, void *userData )
{
    CUI_TextStorageDelegate *delegate = CUI_TextStorageDelegateObj();
    [ref setDelegate:delegate];
    [ref setCuiTextStorageWillProcessEditingCallback:callback];
    [ref setCuiTextStorageWillProcessEditingUserData:userData];
}

void TextStorageSetDidProcessEditingCallback( NSTextStorage *ref, CUI_TextStorageCallbackType callback, void *userData )
{
    CUI_TextStorageDelegate *delegate = CUI_TextStorageDelegateObj();
    [ref setDelegate:delegate];
    [ref setCuiTextStorageDidProcessEditingCallback:callback];
    [ref setCuiTextStorageDidProcessEditingUserData:userData];
}


// Convenience
NSTextStorage *TextStorageWithURL( CFURLRef url, CFDictionaryRef options, CFDictionaryRef *attributes, NSError **err )
{
    NSDictionary *tempAttributes = nil;
    NSTextStorage *ts;
    ts = [[NSTextStorage alloc] initWithURL:(__bridge NSURL *)url options:(__bridge NSDictionary *)options documentAttributes:&tempAttributes error:err];
    if ( attributes ) *attributes = (__bridge CFDictionaryRef)tempAttributes;
#if !__has_feature(objc_arc)
    [ts autorelease];
#endif
    return ts;
}

